Received: from eggs.gnu.org ([2001:4830:134:3::10]:55684)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eb2BW-0004MN-2r
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 05:40:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eb2BS-0006Gx-UB
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 05:40:10 -0500
Received: from mail-qt0-x241.google.com ([2607:f8b0:400d:c0d::241]:37422)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eb2BS-0006Gp-P1
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 05:40:06 -0500
Received: by mail-qt0-x241.google.com with SMTP id d54so1505504qtd.4
	for <qemu-devel@nongnu.org>; Mon, 15 Jan 2018 02:40:06 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180115102621.9183-1-berrange@redhat.com>
	<20180115102621.9183-5-berrange@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <3745d386-d84c-2b3f-e189-7263ccf2f1ff@amsat.org>
Date: Mon, 15 Jan 2018 07:40:02 -0300
MIME-Version: 1.0
In-Reply-To: <20180115102621.9183-5-berrange@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v3 04/13] qapi: adapt to moved location of
 StringIO module in py3
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, Fam Zheng <famz@redhat.com>, Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

On 01/15/2018 07:26 AM, Daniel P. Berrange wrote:
> Signed-off-by: Daniel P. Berrange <berrange@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  scripts/qapi.py | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/scripts/qapi.py b/scripts/qapi.py
> index 7ec2e00b2c..eaa63a58be 100644
> --- a/scripts/qapi.py
> +++ b/scripts/qapi.py
> @@ -22,6 +22,10 @@ try:
>      from collections import OrderedDict
>  except:
>      from ordereddict import OrderedDict
> +try:
> +    from StringIO import StringIO
> +except ImportError:
> +    from io import StringIO
>  
>  builtin_types = {
>      'null':     'QTYPE_QNULL',
> @@ -1995,8 +1999,7 @@ def open_output(output_dir, do_c, do_h, prefix, c_file, h_file,
>          if really:
>              return open(name, opt)
>          else:
> -            import StringIO
> -            return StringIO.StringIO()
> +            return StringIO()
>  
>      fdef = maybe_open(do_c, c_file, 'w')
>      fdecl = maybe_open(do_h, h_file, 'w')
> 

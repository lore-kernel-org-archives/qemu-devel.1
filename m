Received: from eggs.gnu.org ([2001:4830:134:3::10]:33811)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dk9g2-0003Jj-Fl
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 09:57:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dk9fz-0004Rv-Ea
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 09:57:06 -0400
Received: from mail-qk0-x22b.google.com ([2607:f8b0:400d:c09::22b]:33020)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dk9fz-0004Rp-AM
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 09:57:03 -0400
Received: by mail-qk0-x22b.google.com with SMTP id a77so97571071qkb.0
	for <qemu-devel@nongnu.org>; Tue, 22 Aug 2017 06:57:03 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170822132255.23945-1-marcandre.lureau@redhat.com>
	<20170822132255.23945-15-marcandre.lureau@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <cfd835b4-a205-7b59-05d4-00416278a162@amsat.org>
Date: Tue, 22 Aug 2017 10:56:59 -0300
MIME-Version: 1.0
In-Reply-To: <20170822132255.23945-15-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 14/54] qapi2texi: minor python code
 simplification
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>

On 08/22/2017 10:22 AM, Marc-André Lureau wrote:
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>   scripts/qapi2texi.py | 7 +++----
>   1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/scripts/qapi2texi.py b/scripts/qapi2texi.py
> index a317526e51..8b542f9fff 100755
> --- a/scripts/qapi2texi.py
> +++ b/scripts/qapi2texi.py
> @@ -136,10 +136,9 @@ def texi_enum_value(value):
>   def texi_member(member, suffix=''):
>       """Format a table of members item for an object type member"""
>       typ = member.type.doc_type()
> -    return '@item @code{%s%s%s}%s%s\n' % (
> -        member.name,
> -        ': ' if typ else '',
> -        typ if typ else '',
> +    membertype = ': %s' % typ if typ else ''
> +    return '@item @code{%s%s}%s%s\n' % (
> +        member.name, membertype,
>           ' (optional)' if member.optional else '',
>           suffix)
>   
> 

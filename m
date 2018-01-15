Received: from eggs.gnu.org ([2001:4830:134:3::10]:56061)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eb2Cj-0005Up-7n
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 05:41:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eb2Cf-0007EE-Bb
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 05:41:25 -0500
Received: from mail-qt0-x243.google.com ([2607:f8b0:400d:c0d::243]:37435)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eb2Cf-0007Dy-6g
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 05:41:21 -0500
Received: by mail-qt0-x243.google.com with SMTP id d54so1508847qtd.4
	for <qemu-devel@nongnu.org>; Mon, 15 Jan 2018 02:41:21 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180115102621.9183-1-berrange@redhat.com>
	<20180115102621.9183-9-berrange@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <02604af8-5aad-9942-ee5d-45efd91aff14@amsat.org>
Date: Mon, 15 Jan 2018 07:41:17 -0300
MIME-Version: 1.0
In-Reply-To: <20180115102621.9183-9-berrange@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v3 08/13] scripts: ensure signrom treats
 data as bytes
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
>  scripts/signrom.py | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/scripts/signrom.py b/scripts/signrom.py
> index d1dabe0240..0497a1c32e 100644
> --- a/scripts/signrom.py
> +++ b/scripts/signrom.py
> @@ -18,7 +18,7 @@ fin = open(sys.argv[1], 'rb')
>  fout = open(sys.argv[2], 'wb')
>  
>  magic = fin.read(2)
> -if magic != '\x55\xaa':
> +if magic != b'\x55\xaa':
>      sys.exit("%s: option ROM does not begin with magic 55 aa" % sys.argv[1])
>  
>  size_byte = ord(fin.read(1))
> @@ -33,7 +33,7 @@ elif len(data) < size:
>      # Add padding if necessary, rounding the whole input to a multiple of
>      # 512 bytes according to the third byte of the input.
>      # size-1 because a final byte is added below to store the checksum.
> -    data = data.ljust(size-1, '\0')
> +    data = data.ljust(size-1, b'\0')
>  else:
>      if ord(data[-1:]) != 0:
>          sys.stderr.write('WARNING: ROM includes nonzero checksum\n')
> 

Received: from eggs.gnu.org ([2001:4830:134:3::10]:40976)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gJQz2-0002lc-R1
	for qemu-devel@nongnu.org; Sun, 04 Nov 2018 17:35:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gJQyz-0002da-LX
	for qemu-devel@nongnu.org; Sun, 04 Nov 2018 17:35:04 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:38434)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gJQyz-0002aU-DH
	for qemu-devel@nongnu.org; Sun, 04 Nov 2018 17:35:01 -0500
Received: by mail-wr1-f67.google.com with SMTP id d10-v6so7439006wrs.5
	for <qemu-devel@nongnu.org>; Sun, 04 Nov 2018 14:35:01 -0800 (PST)
References: <20181104112424.18663-1-stefanha@redhat.com>
	<20181104112424.18663-8-stefanha@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <0d0df4c5-9952-4f3a-503d-f4169643b19b@redhat.com>
Date: Sun, 4 Nov 2018 23:34:58 +0100
MIME-Version: 1.0
In-Reply-To: <20181104112424.18663-8-stefanha@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v3 7/8] target-alpha: use HTTPS git URL for
 palcode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Fam Zheng <famz@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Jeff Cody <jcody@redhat.com>, cohuck@redhat.com, Markus Armbruster <armbru@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, Richard Henderson <rth@twiddle.net>

On 4/11/18 12:24, Stefan Hajnoczi wrote:
> When you clone the repository without previous commit history, 'git://'
> doesn't protect from man-in-the-middle attacks.  HTTPS is more secure
> since the client verifies the server certificate.
> 
> Cc: Richard Henderson <rth@twiddle.net>
> Suggested-by: Eric Blake <eblake@redhat.com>
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> ---
>   pc-bios/README | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/pc-bios/README b/pc-bios/README
> index 8f98c07a74..20f7c33c24 100644
> --- a/pc-bios/README
> +++ b/pc-bios/README
> @@ -36,7 +36,7 @@
>   	1af4:1000 -> pxe-virtio.rom
>   
>   - The sources for the Alpha palcode image is available from:
> -  git://github.com/rth7680/qemu-palcode.git
> +  https://github.com/rth7680/qemu-palcode.git
>   
>   - The u-boot binary for e500 comes from the upstream denx u-boot project where
>     it was compiled using the qemu-ppce500 target.
> 

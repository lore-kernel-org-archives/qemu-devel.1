Received: from eggs.gnu.org ([209.51.188.92]:44457)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gphu7-0005Fp-FI
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 18:07:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gphu6-0000Xe-PH
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 18:07:23 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:36149)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gphu6-0000VQ-I4
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 18:07:22 -0500
Received: by mail-wr1-f66.google.com with SMTP id u4so8791476wrp.3
	for <qemu-devel@nongnu.org>; Fri, 01 Feb 2019 15:07:18 -0800 (PST)
References: <20190201230042.31003-1-mst@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <5753ea87-9bc2-7b36-e1d9-6aa517be8677@redhat.com>
Date: Sat, 2 Feb 2019 00:07:16 +0100
MIME-Version: 1.0
In-Reply-To: <20190201230042.31003-1-mst@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] r2d: fix build on mingw
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org
Cc: Magnus Damm <magnus.damm@gmail.com>, Aurelien Jarno <aurelien@aurel32.net>

On 2/2/19 12:00 AM, Michael S. Tsirkin wrote:
> Comment near strncpy explains kernel_cmdline does
> not need to be 0-terminated.
> 
> Accordingly mark it as QEMU_NONSTRING.
> 
> Without this, gcc warns:
>     'strncpy' specified bound 256 equals destination size
> 
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> ---
>  hw/sh4/r2d.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/sh4/r2d.c b/hw/sh4/r2d.c
> index 5b399e7161..dcdb3728cb 100644
> --- a/hw/sh4/r2d.c
> +++ b/hw/sh4/r2d.c
> @@ -220,7 +220,7 @@ static struct QEMU_PACKED
>  
>      char pad[232];
>  
> -    char kernel_cmdline[256];
> +    char kernel_cmdline[256] QEMU_NONSTRING;
>  } boot_params;
>  
>  static void r2d_init(MachineState *machine)
> 

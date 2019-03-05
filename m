Received: from eggs.gnu.org ([209.51.188.92]:50994)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1h1D1K-0002Pj-OD
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 11:34:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1h1D1J-0000ZR-U8
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 11:34:22 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:34120)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1h1D1J-0000YV-Jy
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 11:34:21 -0500
Received: by mail-wr1-f65.google.com with SMTP id f14so10194548wrg.1
	for <qemu-devel@nongnu.org>; Tue, 05 Mar 2019 08:34:21 -0800 (PST)
References: <20190305162829.20079-1-philmd@redhat.com>
	<20190305162829.20079-6-philmd@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <fb85944c-888a-7151-8f93-22ac747ba237@redhat.com>
Date: Tue, 5 Mar 2019 17:34:19 +0100
MIME-Version: 1.0
In-Reply-To: <20190305162829.20079-6-philmd@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 5/5] mips_malta: Clean up definition of
 flash memory size somewhat
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>
Cc: Aurelien Jarno <aurelien@aurel32.net>, Aleksandar Markovic <amarkovic@wavecomp.com>, Aleksandar Rikalo <arikalo@wavecomp.com>

On 3/5/19 5:28 PM, Philippe Mathieu-Daudé wrote:
> From: Markus Armbruster <armbru@redhat.com>
> 
> pflash_cfi01_register() takes a size in bytes, a block size in bytes
> and a number of blocks.  mips_malta_init() passes BIOS_SIZE, 65536,
> FLASH_SIZE >> 16.  Actually consistent only because BIOS_SIZE (defined
> in include/hw/mips/bios.h as (4 * MiB)) matches FLASH_SIZE (defined
> locally as 0x400000).  Confusing all the same.
> 
> Pass FLASH_SIZE instead of BIOS_SIZE.
> 
> Cc: Aurelien Jarno <aurelien@aurel32.net>
> Cc: Aleksandar Rikalo <arikalo@wavecomp.com>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>

I forgot here:

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>

> [PMD: rebased]
> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> ---
>  hw/mips/mips_malta.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/mips/mips_malta.c b/hw/mips/mips_malta.c
> index 04788ff50a..a5726edaa7 100644
> --- a/hw/mips/mips_malta.c
> +++ b/hw/mips/mips_malta.c
> @@ -1280,7 +1280,7 @@ void mips_malta_init(MachineState *machine)
>  #endif
>      }
>      fl = pflash_cfi01_register(FLASH_ADDRESS, NULL, "mips_malta.bios",
> -                               BIOS_SIZE,
> +                               FLASH_SIZE,
>                                 pflash_blk,
>                                 65536, FLASH_SIZE >> 16,
>                                 4, 0x0000, 0x0000, 0x0000, 0x0000, be);
> 

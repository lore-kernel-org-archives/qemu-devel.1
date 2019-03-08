Received: from eggs.gnu.org ([209.51.188.92]:50907)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1h2EgD-0008Fr-RQ
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 07:32:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1h2EgB-0007C2-0k
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 07:32:49 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:34701)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1h2EgA-0006vV-Qw
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 07:32:46 -0500
Received: by mail-wr1-f67.google.com with SMTP id f14so21182548wrg.1
	for <qemu-devel@nongnu.org>; Fri, 08 Mar 2019 04:32:45 -0800 (PST)
References: <20190308094610.21210-1-armbru@redhat.com>
	<20190308094610.21210-14-armbru@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <6086ea28-11a1-e72f-d4fb-6069543732c3@redhat.com>
Date: Fri, 8 Mar 2019 13:32:42 +0100
MIME-Version: 1.0
In-Reply-To: <20190308094610.21210-14-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v4 13/15] mips_malta: Clean up definition
 of flash memory size somewhat
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org, lersek@redhat.com, kwolf@redhat.com, mreitz@redhat.com, qemu-block@nongnu.org, qemu-ppc@nongnu.org, balaton@eik.bme.hu, Aurelien Jarno <aurelien@aurel32.net>, Aleksandar Rikalo <arikalo@wavecomp.com>

On 3/8/19 10:46 AM, Markus Armbruster wrote:
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
> Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> ---
>  hw/mips/mips_malta.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/mips/mips_malta.c b/hw/mips/mips_malta.c
> index 4dfe06a1a0..2f20f56458 100644
> --- a/hw/mips/mips_malta.c
> +++ b/hw/mips/mips_malta.c
> @@ -1262,7 +1262,7 @@ void mips_malta_init(MachineState *machine)
>      /* Load firmware in flash / BIOS. */
>      dinfo = drive_get(IF_PFLASH, 0, fl_idx);
>      fl = pflash_cfi01_register(FLASH_ADDRESS, NULL, "mips_malta.bios",
> -                               BIOS_SIZE,
> +                               FLASH_SIZE,
>                                 dinfo ? blk_by_legacy_dinfo(dinfo) : NULL,
>                                 65536, FLASH_SIZE >> 16,
>                                 4, 0x0000, 0x0000, 0x0000, 0x0000, be);
> 

Received: from eggs.gnu.org ([2001:4830:134:3::10]:58263)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1fcxM9-0001ym-1f
	for qemu-devel@nongnu.org; Tue, 10 Jul 2018 14:27:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1fcxM5-000287-R8
	for qemu-devel@nongnu.org; Tue, 10 Jul 2018 14:27:21 -0400
Received: from mail-eopbgr690112.outbound.protection.outlook.com
	([40.107.69.112]:63936
	helo=NAM04-CO1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <amarkovic@wavecomp.com>)
	id 1fcxM5-00026k-FE
	for qemu-devel@nongnu.org; Tue, 10 Jul 2018 14:27:17 -0400
From: Aleksandar Markovic <amarkovic@wavecomp.com>
Date: Tue, 10 Jul 2018 18:27:12 +0000
Message-ID: <BN7PR08MB4868B34DA0B4033C20B4A736C65B0@BN7PR08MB4868.namprd08.prod.outlook.com>
References: <1531169431-10772-1-git-send-email-aleksandar.markovic@rt-rk.com>,
	<1531169431-10772-28-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1531169431-10772-28-git-send-email-aleksandar.markovic@rt-rk.com>
Content-Language: en-US
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 27/33] target/mips: Add ELF flags for
 MIPS machine variants
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "f4bug@amsat.org" <f4bug@amsat.org>, "aurelien@aurel32.net" <aurelien@aurel32.net>, Stefan Markovic <smarkovic@wavecomp.com>, Petar Jovanovic <pjovanovic@wavecomp.com>, Paul Burton <pburton@wavecomp.com>

> Subject: [PATCH v2 27/33] target/mips: Add ELF flags for MIPS machine var=
iants
>
> From: Aleksandar Markovic <amarkovic@wavecomp.com>
>
> Add MIPS machine variants ELF flags so that the emulation behavior
> can be adjusted if needed.
>
> Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
> Signed-off-by: Stefan Markovic <smarkovic@wavecomp.com>
> ---
>  include/elf.h | 23 +++++++++++++++++++++++
>  1 file changed, 23 insertions(+)
>

This update is good for general MIPS support in QEMU, but where are nanoMIP=
S-specifics regarding ELF header? These must be included in this (or anothe=
r, separate) patch, within this series. I know this was actually the initia=
l intention of the author. (I know that since I was the author.)

> diff --git a/include/elf.h b/include/elf.h
> index 934dbbd..b39e303 100644
> --- a/include/elf.h
> +++ b/include/elf.h
> @@ -63,6 +63,29 @@ typedef int64_t  Elf64_Sxword;
>  #define EF_MIPS_NAN2008   0x00000400
>  #define EF_MIPS_ARCH      0xf0000000
>
> +/* MIPS machine variant */
> +#define EF_MIPS_MACH_NONE     0x00000000  /* A standard MIPS implementat=
ion  */
> +#define EF_MIPS_MACH_3900     0x00810000  /* Toshiba R3900              =
     */
> +#define EF_MIPS_MACH_4010     0x00820000  /* LSI R4010                  =
     */
> +#define EF_MIPS_MACH_4100     0x00830000  /* NEC VR4100                 =
     */
> +#define EF_MIPS_MACH_4650     0x00850000  /* MIPS R4650                 =
     */
> +#define EF_MIPS_MACH_4120     0x00870000  /* NEC VR4120                 =
     */
> +#define EF_MIPS_MACH_4111     0x00880000  /* NEC VR4111/VR4181          =
     */
> +#define EF_MIPS_MACH_SB1      0x008a0000  /* Broadcom SB-1              =
     */
> +#define EF_MIPS_MACH_OCTEON   0x008b0000  /* Cavium Networks Octeon     =
     */
> +#define EF_MIPS_MACH_XLR      0x008c0000  /* RMI Xlr                    =
     */
> +#define EF_MIPS_MACH_OCTEON2  0x008d0000  /* Cavium Networks Octeon2    =
     */
> +#define EF_MIPS_MACH_OCTEON3  0x008e0000  /* Cavium Networks Octeon3    =
     */
> +#define EF_MIPS_MACH_5400     0x00910000  /* NEC VR5400                 =
     */
> +#define EF_MIPS_MACH_5900     0x00920000  /* MIPS R5900                 =
     */
> +#define EF_MIPS_MACH_5500     0x00980000  /* NEC VR5500                 =
     */
> +#define EF_MIPS_MACH_9000     0x00990000  /* Unknown                    =
     */
> +#define EF_MIPS_MACH_LS2E     0x00a00000  /* ST Microelectronics Loongso=
n 2E */
> +#define EF_MIPS_MACH_LS2F     0x00a10000  /* ST Microelectronics Loongso=
n 2F */
> +#define EF_MIPS_MACH_LS3A     0x00a20000  /* Loongson 3A                =
     */
> +#define EF_MIPS_MACH          0x00ff0000  /* EF_MIPS_MACH_xxx selection =
mask */
> +
> +
>  /* These constants define the different elf file types */
>  #define ET_NONE   0
>  #define ET_REL    1
> --
> 2.7.4
>
>

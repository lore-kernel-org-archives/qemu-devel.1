Received: from eggs.gnu.org ([2001:4830:134:3::10]:54463)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1gC0cw-0002xa-13
	for qemu-devel@nongnu.org; Mon, 15 Oct 2018 07:01:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1gC0co-0007Qq-Kt
	for qemu-devel@nongnu.org; Mon, 15 Oct 2018 07:01:33 -0400
Received: from mail-cys01nam02on0112.outbound.protection.outlook.com
	([104.47.37.112]:21328
	helo=NAM02-CY1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <amarkovic@wavecomp.com>)
	id 1gC0ci-0007Jz-Kq
	for qemu-devel@nongnu.org; Mon, 15 Oct 2018 07:01:24 -0400
From: Aleksandar Markovic <amarkovic@wavecomp.com>
Date: Mon, 15 Oct 2018 11:01:05 +0000
Message-ID: <BN6PR2201MB1251DDA3C4C4AC5A65D7331CC6FD0@BN6PR2201MB1251.namprd22.prod.outlook.com>
References: <cover.1539428198.git.noring@nocrew.org>,
	<540683755a2357b670b107a29658531466be18f4.1539428198.git.noring@nocrew.org>
In-Reply-To: <540683755a2357b670b107a29658531466be18f4.1539428198.git.noring@nocrew.org>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v7 7/7] elf: Toshiba/Sony rather than MIPS
 are the implementors of the R5900
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fredrik Noring <noring@nocrew.org>, "Maciej W. Rozycki" <macro@linux-mips.org>, =?iso-8859-1?Q?Philippe_Mathieu-Daud=E9?= <f4bug@amsat.org>
Cc: Richard Henderson <richard.henderson@linaro.org>, Aurelien Jarno <aurelien@aurel32.net>, Petar Jovanovic <pjovanovic@wavecomp.com>, Peter Maydell <peter.maydell@linaro.org>, =?iso-8859-1?Q?J=FCrgen_Urban?= <JuergenUrban@gmx.de>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>

> From: Fredrik Noring <noring@nocrew.org>
> Sent: Saturday, October 13, 2018 1:11 PM
> To: Aleksandar Markovic; Maciej W. Rozycki; Philippe Mathieu-Daud=E9
> Cc: Richard Henderson; Aurelien Jarno; Petar Jovanovic; Peter Maydell; J=
=FCrgen Urban; > qemu-devel@nongnu.org
> Subject: [PATCH v7 7/7] elf: Toshiba/Sony rather than MIPS are the implem=
entors of the > R5900
>=20

Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com>

This patch will be applied to the next MIPS queue, perhaps in a slightly
modified form. The queue is planned to be created very soon.

> Sources [1][2] indicate that the Emotion Engine was designed by Toshiba
> and licensed to Sony. Others [3][4][5] claim it was a joint effort. It
> therefore makes sense to refer to the CPU as "Toshiba/Sony R5900".
>=20
> [1] http://cs.nyu.edu/courses/spring02/V22.0480-002/projects/aldrich/emot=
ionengine.ppt
> [2] http://archive.arstechnica.com/reviews/1q00/playstation2/m-ee-3.html
> [3] http://docencia.ac.upc.edu/ETSETB/SEGPAR/microprocessors/emotionengin=
e%20(mpr).pdf
> [4] http://www.eetimes.com/document.asp?doc_id=3D1144055
> [5] https://www.toshiba.co.jp/about/press/2001_09/pr2701.htm
>=20
> Reported-by: Maciej W. Rozycki <macro@linux-mips.org>
> Signed-off-by: Fredrik Noring <noring@nocrew.org>
> Reviewed-by: Philippe Mathieu-Daud=E9 <f4bug@amsat.org>
> ---
>  include/elf.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/include/elf.h b/include/elf.h
> index 312f68af81..2510fc7be4 100644
> --- a/include/elf.h
> +++ b/include/elf.h
> @@ -76,7 +76,7 @@ typedef int64_t  Elf64_Sxword;
>  #define EF_MIPS_MACH_OCTEON2  0x008d0000  /* Cavium Networks Octeon2    =
     */
>  #define EF_MIPS_MACH_OCTEON3  0x008e0000  /* Cavium Networks Octeon3    =
     */
>  #define EF_MIPS_MACH_5400     0x00910000  /* NEC VR5400                 =
     */
> -#define EF_MIPS_MACH_5900     0x00920000  /* MIPS R5900                 =
     */
> +#define EF_MIPS_MACH_5900     0x00920000  /* Toshiba/Sony R5900         =
     */
>  #define EF_MIPS_MACH_5500     0x00980000  /* NEC VR5500                 =
     */
>  #define EF_MIPS_MACH_9000     0x00990000  /* PMC-Sierra's RM9000        =
     */
>  #define EF_MIPS_MACH_LS2E     0x00a00000  /* ST Microelectronics Loongso=
n 2E */
> --
> 2.16.4
>=20
> =

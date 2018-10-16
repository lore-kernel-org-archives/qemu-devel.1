Received: from eggs.gnu.org ([2001:4830:134:3::10]:60509)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <smarkovic@wavecomp.com>) id 1gCPNw-0004WU-R0
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 09:27:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <smarkovic@wavecomp.com>) id 1gCPNt-0003iU-Jy
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 09:27:44 -0400
Received: from mail-eopbgr710122.outbound.protection.outlook.com
	([40.107.71.122]:8853
	helo=NAM05-BY2-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <smarkovic@wavecomp.com>)
	id 1gCPNt-0003fM-B1
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 09:27:41 -0400
References: <1539692044-15732-1-git-send-email-aleksandar.markovic@rt-rk.com>
	<1539692044-15732-2-git-send-email-aleksandar.markovic@rt-rk.com>
From: Stefan Markovic <smarkovic@wavecomp.com>
Message-ID: <637e0ef6-9e4a-5633-e082-38952c2bd8aa@wavecomp.com>
Date: Tue, 16 Oct 2018 15:27:28 +0200
MIME-Version: 1.0
In-Reply-To: <1539692044-15732-2-git-send-email-aleksandar.markovic@rt-rk.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH 1/4] target/mips: Add basic description of
 MXU ASE
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>, qemu-devel@nongnu.org
Cc: aurelien@aurel32.net, jancraig@amazon.com, amarkovic@wavecomp.com, pjovanovic@wavecomp.com


On 16.10.18. 14:14, Aleksandar Markovic wrote:
> From: Aleksandar Markovic <amarkovic@wavecomp.com>
>
> Add a comment that contains a basic description of MXU ASE.
>
> Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
> ---
>   target/mips/translate.c | 20 ++++++++++++++++++++
>   1 file changed, 20 insertions(+)
>
> diff --git a/target/mips/translate.c b/target/mips/translate.c
> index ab16cdb..23e21c5 100644
> --- a/target/mips/translate.c
> +++ b/target/mips/translate.c
> @@ -1389,6 +1389,26 @@ enum {
>       OPC_BINSRI_df   =3D (0x7 << 23) | OPC_MSA_BIT_09,
>   };
>  =20
> +
> +/*
> + *    AN OVERVIEW OF MXU EXTENSTION INSTRUCTION SET
> + *    =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

Misspelled EXTENSION. Otherwise:

Reviewed-by: Stefan Markovic <smarkovic@wavecomp.com>


> + *
> + * MXU (full name: MIPS eXtension/enhanced Unit) is an SIMD extension of=
 MIPS32
> + * instructions set. It is designed to fit the needs of signal, graphica=
l and
> + * video processing applications. MXU instruction set is used in Xburst =
family
> + * of microprocessors by Ingenic.
> + *
> + * MXU unit contains 17 registers called X0-X16. X0 is always zero, and =
X16 is
> + * the control register.
> + *
> + *   Compiled after:
> + *
> + *   "XBurst=C2=AE Instruction Set Architecture MIPS eXtension/enhanced =
Unit
> + *   Programming Manual", Ingenic Semiconductor Co, Ltd., 2017
> + */
> +
> +
>   /* global register indices */
>   static TCGv cpu_gpr[32], cpu_PC;
>   static TCGv cpu_HI[MIPS_DSP_ACC], cpu_LO[MIPS_DSP_ACC];

Received: from eggs.gnu.org ([2001:4830:134:3::10]:36187)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <smarkovic@wavecomp.com>) id 1gCPaf-0003WG-Od
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 09:40:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <smarkovic@wavecomp.com>) id 1gCPac-0001mU-Fs
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 09:40:53 -0400
Received: from mail-co1nam05on0726.outbound.protection.outlook.com
	([2a01:111:f400:fe50::726]:52672
	helo=NAM05-CO1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <smarkovic@wavecomp.com>)
	id 1gCPaA-0001Mu-IA
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 09:40:50 -0400
References: <1539692044-15732-1-git-send-email-aleksandar.markovic@rt-rk.com>
	<1539692044-15732-5-git-send-email-aleksandar.markovic@rt-rk.com>
From: Stefan Markovic <smarkovic@wavecomp.com>
Message-ID: <75803856-711b-ce50-4790-5e11718d7047@wavecomp.com>
Date: Tue, 16 Oct 2018 15:40:10 +0200
MIME-Version: 1.0
In-Reply-To: <1539692044-15732-5-git-send-email-aleksandar.markovic@rt-rk.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH 4/4] target/mips: Add opcode values of MXU
 ASE
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
> Add opcode values for all instructions in MXU ASE.
>
> Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
> ---
>   target/mips/translate.c | 276 ++++++++++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 276 insertions(+)


Reviewed-by: Stefan Markovic <smarkovic@wavecomp.com>


> diff --git a/target/mips/translate.c b/target/mips/translate.c
> index 4dfc360..941b546 100644
> --- a/target/mips/translate.c
> +++ b/target/mips/translate.c
> @@ -1652,6 +1652,282 @@ enum {
>    *   Programming Manual", Ingenic Semiconductor Co, Ltd., 2017
>    */
>   
> +enum {
> +    OPC_MXU_S32MADD  = 0x00,
> +    OPC_MXU_S32MADDU = 0x01,
> +    /* not assigned 0x02 */
> +    OPC_MXU__POOL00  = 0x03,
> +    OPC_MXU_S32MSUB  = 0x04,
> +    OPC_MXU_S32MSUBU = 0x05,
> +    OPC_MXU__POOL01  = 0x06,
> +    OPC_MXU__POOL02  = 0x07,
> +    OPC_MXU_D16MUL   = 0x08,
> +    OPC_MXU__POOL03  = 0x09,
> +    OPC_MXU_D16MAC   = 0x0A,
> +    OPC_MXU_D16MACF  = 0x0B,
> +    OPC_MXU_D16MADL  = 0x0C,
> +    OPC_MXU__POOL04  = 0x0D,
> +    OPC_MXU_Q16ADD   = 0x0E,
> +    OPC_MXU_D16MACE  = 0x0F,
> +    OPC_MXU__POOL05  = 0x10,
> +    OPC_MXU__POOL06  = 0x11,
> +    OPC_MXU__POOL07  = 0x12,
> +    OPC_MXU__POOL08  = 0x13,
> +    OPC_MXU__POOL09  = 0x14,
> +    OPC_MXU__POOL10  = 0x15,
> +    OPC_MXU__POOL11  = 0x16,
> +    OPC_MXU__POOL12  = 0x17,
> +    OPC_MXU_D32ADD   = 0x18,
> +    OPC_MXU__POOL13  = 0x19,
> +    /* not assigned 0x1A */
> +    OPC_MXU__POOL14  = 0x1B,
> +    OPC_MXU__POOL15  = 0x1C,
> +    OPC_MXU_Q8ACCE   = 0x1D,
> +    /* not assigned 0x1E */
> +    /* not assigned 0x1F */
> +    /* not assigned 0x20 */
> +    /* not assigned 0x21 */
> +    OPC_MXU_S8LDD    = 0x22,
> +    OPC_MXU_S8STD    = 0x23,
> +    OPC_MXU_S8LDI    = 0x24,
> +    OPC_MXU_S8SDI    = 0x25,
> +    OPC_MXU__POOL16  = 0x26,
> +    OPC_MXU__POOL17  = 0x27,
> +    OPC_MXU_LXB      = 0x28,
> +    /* not assigned 0x29 */
> +    OPC_MXU_S16LDD   = 0x2A,
> +    OPC_MXU_S16STD   = 0x2B,
> +    OPC_MXU_S16LDI   = 0x2C,
> +    OPC_MXU_S16SDI   = 0x2D,
> +    OPC_MXU_S32M2I   = 0x2E,
> +    OPC_MXU_S32I2M   = 0x2F,
> +    OPC_MXU_D32SLL   = 0x30,
> +    OPC_MXU_D32SLR   = 0x31,
> +    OPC_MXU_D32SARL  = 0x32,
> +    OPC_MXU_D32SAR   = 0x33,
> +    OPC_MXU_Q16SLL   = 0x34,
> +    OPC_MXU_Q16SLR   = 0x35,
> +    OPC_MXU__POOL18  = 0x36,
> +    OPC_MXU_Q16SAR   = 0x37,
> +    OPC_MXU__POOL19  = 0x38,
> +    OPC_MXU__POOL20  = 0x39,
> +    OPC_MXU__POOL21  = 0x3A,
> +    OPC_MXU_Q16SCOP  = 0x3B,
> +    OPC_MXU_Q8MADL   = 0x3C,
> +    OPC_MXU_S32SFL   = 0x3D,
> +    OPC_MXU_Q8SAD    = 0x3E,
> +    /* not assigned 0x3F */
> +};
> +
> +
> +/*
> + * MXU pool 00
> + */
> +enum {
> +    OPC_MXU_S32MAX   = 0x00,
> +    OPC_MXU_S32MIN   = 0x01,
> +    OPC_MXU_D16MAX   = 0x02,
> +    OPC_MXU_D16MIN   = 0x03,
> +    OPC_MXU_Q8MAX    = 0x04,
> +    OPC_MXU_Q8MIN    = 0x05,
> +    OPC_MXU_Q8SLT    = 0x06,
> +    OPC_MXU_Q8SLTU   = 0x07,
> +};
> +
> +/*
> + * MXU pool 01
> + */
> +enum {
> +    OPC_MXU_S32SLT   = 0x00,
> +    OPC_MXU_D16SLT   = 0x01,
> +    OPC_MXU_D16AVG   = 0x02,
> +    OPC_MXU_D16AVGR  = 0x03,
> +    OPC_MXU_Q8AVG    = 0x04,
> +    OPC_MXU_Q8AVGR   = 0x05,
> +    OPC_MXU_Q8ADD    = 0x07,
> +};
> +
> +/*
> + * MXU pool 02
> + */
> +enum {
> +    OPC_MXU_S32CPS   = 0x00,
> +    OPC_MXU_D16CPS   = 0x02,
> +    OPC_MXU_Q8ABD    = 0x04,
> +    OPC_MXU_Q16SAT   = 0x06,
> +};
> +
> +/*
> + * MXU pool 03
> + */
> +enum {
> +    OPC_MXU_D16MULF  = 0x00,
> +    OPC_MXU_D16MULE  = 0x01,
> +};
> +
> +/*
> + * MXU pool 04
> + */
> +enum {
> +    OPC_MXU_S16MAD   = 0x00,
> +    OPC_MXU_S16MAD_1 = 0x01,
> +};
> +
> +/*
> + * MXU pool 05
> + */
> +enum {
> +    OPC_MXU_S32LDD   = 0x00,
> +    OPC_MXU_S32LDDR  = 0x01,
> +};
> +
> +/*
> + * MXU pool 06
> + */
> +enum {
> +    OPC_MXU_S32STD   = 0x00,
> +    OPC_MXU_S32STDR  = 0x01,
> +};
> +
> +/*
> + * MXU pool 07
> + */
> +enum {
> +    OPC_MXU_S32LDDV  = 0x00,
> +    OPC_MXU_S32LDDVR = 0x01,
> +};
> +
> +/*
> + * MXU pool 08
> + */
> +enum {
> +    OPC_MXU_S32TDV   = 0x00,
> +    OPC_MXU_S32TDVR  = 0x01,
> +};
> +
> +/*
> + * MXU pool 09
> + */
> +enum {
> +    OPC_MXU_S32LDI   = 0x00,
> +    OPC_MXU_S32LDIR  = 0x01,
> +};
> +
> +/*
> + * MXU pool 10
> + */
> +enum {
> +    OPC_MXU_S32SDI   = 0x00,
> +    OPC_MXU_S32SDIR  = 0x01,
> +};
> +
> +/*
> + * MXU pool 11
> + */
> +enum {
> +    OPC_MXU_S32LDIV  = 0x00,
> +    OPC_MXU_S32LDIVR = 0x01,
> +};
> +
> +/*
> + * MXU pool 12
> + */
> +enum {
> +    OPC_MXU_S32SDIV  = 0x00,
> +    OPC_MXU_S32SDIVR = 0x01,
> +};
> +
> +/*
> + * MXU pool 13
> + */
> +enum {
> +    OPC_MXU_D32ACC   = 0x00,
> +    OPC_MXU_D32ACCM  = 0x01,
> +    OPC_MXU_D32ASUM  = 0x02,
> +};
> +
> +/*
> + * MXU pool 14
> + */
> +enum {
> +    OPC_MXU_Q16ACC   = 0x00,
> +    OPC_MXU_Q16ACCM  = 0x01,
> +    OPC_MXU_Q16ASUM  = 0x02,
> +};
> +
> +/*
> + * MXU pool 15
> + */
> +enum {
> +    OPC_MXU_Q8ADDE   = 0x00,
> +    OPC_MXU_D8SUM    = 0x01,
> +    OPC_MXU_D8SUMC   = 0x02,
> +};
> +
> +/*
> + * MXU pool 16
> + */
> +enum {
> +    OPC_MXU_S32MUL   = 0x00,
> +    OPC_MXU_S32MULU  = 0x01,
> +    OPC_MXU_S32EXTR  = 0x02,
> +    OPC_MXU_S32EXTRV = 0x03,
> +};
> +
> +/*
> + * MXU pool 17
> + */
> +enum {
> +    OPC_MXU_D32SARW  = 0x00,
> +    OPC_MXU_S32ALN   = 0x01,
> +    OPC_MXU_S32ALNI  = 0x02,
> +    OPC_MXU_S32NOR   = 0x03,
> +    OPC_MXU_S32AND   = 0x04,
> +    OPC_MXU_S32OR    = 0x05,
> +    OPC_MXU_S32XOR   = 0x06,
> +    OPC_MXU_S32LUI   = 0x07,
> +};
> +
> +/*
> + * MXU pool 18
> + */
> +enum {
> +    OPC_MXU_D32SLLV  = 0x00,
> +    OPC_MXU_D32SLRV  = 0x01,
> +    OPC_MXU_D32SARV  = 0x03,
> +    OPC_MXU_Q16SLLV  = 0x04,
> +    OPC_MXU_Q16SLRV  = 0x05,
> +    OPC_MXU_Q16SARV  = 0x07,
> +};
> +
> +/*
> + * MXU pool 19
> + */
> +enum {
> +    OPC_MXU_Q8MUL    = 0x00,
> +    OPC_MXU_Q8MULSU  = 0x01,
> +};
> +
> +/*
> + * MXU pool 20
> + */
> +enum {
> +    OPC_MXU_Q8MOVZ   = 0x00,
> +    OPC_MXU_Q8MOVN   = 0x01,
> +    OPC_MXU_D16MOVZ  = 0x02,
> +    OPC_MXU_D16MOVN  = 0x03,
> +    OPC_MXU_S32MOVZ  = 0x04,
> +    OPC_MXU_S32MOVN  = 0x05,
> +};
> +
> +/*
> + * MXU pool 21
> + */
> +enum {
> +    OPC_MXU_Q8MAC    = 0x00,
> +    OPC_MXU_Q8MACSU  = 0x01,
> +};
> +
>   
>   /* global register indices */
>   static TCGv cpu_gpr[32], cpu_PC;

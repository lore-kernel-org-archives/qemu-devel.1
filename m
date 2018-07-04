Received: from eggs.gnu.org ([2001:4830:134:3::10]:33880)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1faoCk-0001s0-4s
	for qemu-devel@nongnu.org; Wed, 04 Jul 2018 16:16:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1faoCg-0001Pj-5f
	for qemu-devel@nongnu.org; Wed, 04 Jul 2018 16:16:46 -0400
Received: from mail-qk0-x244.google.com ([2607:f8b0:400d:c09::244]:41602)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1faoCf-0001PN-WA
	for qemu-devel@nongnu.org; Wed, 04 Jul 2018 16:16:42 -0400
Received: by mail-qk0-x244.google.com with SMTP id d22-v6so3408036qkc.8
	for <qemu-devel@nongnu.org>; Wed, 04 Jul 2018 13:16:41 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <1530732637-28606-1-git-send-email-aleksandar.markovic@rt-rk.com>
	<1530732637-28606-4-git-send-email-aleksandar.markovic@rt-rk.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <d87018ab-f66f-565c-813e-e1cdd204e635@amsat.org>
Date: Wed, 4 Jul 2018 17:16:37 -0300
MIME-Version: 1.0
In-Reply-To: <1530732637-28606-4-git-send-email-aleksandar.markovic@rt-rk.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v3 3/8] target/mips: Update some CP0
 registers bit definitions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>, qemu-devel@nongnu.org
Cc: philippe.mathieu.daude@gmail.com, aurelien@aurel32.net, amarkovic@wavecomp.com, smarkovic@wavecomp.com, pjovanovic@wavecomp.com, pburton@wavecomp.com

Hi Aleksandar,

On 07/04/2018 04:30 PM, Aleksandar Markovic wrote:
> From: Aleksandar Markovic <amarkovic@wavecomp.com>
> 
> Update CP0 registers Config0, Config1, and Config5 bit definitions.
> 
> Some of these bits will be utilized by upcoming nanoMIPS changes.
> 
> Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
> ---
>  target/mips/cpu.h | 41 ++++++++++++++++++++++++++++-------------
>  1 file changed, 28 insertions(+), 13 deletions(-)
> 
> diff --git a/target/mips/cpu.h b/target/mips/cpu.h
> index cfe1735..edbb66d 100644
> --- a/target/mips/cpu.h
> +++ b/target/mips/cpu.h
> @@ -388,26 +388,27 @@ struct CPUMIPSState {
>      target_ulong CP0_CMGCRBase;
>      int32_t CP0_Config0;
>  #define CP0C0_M    31
> -#define CP0C0_K23  28
> -#define CP0C0_KU   25
> +#define CP0C0_K23  28    /* 30..28 */
> +#define CP0C0_KU   25    /* 27..25 */
>  #define CP0C0_MDU  20
>  #define CP0C0_MM   18
>  #define CP0C0_BM   16
> +#define CP0C0_Impl 16    /* 24..16 */
>  #define CP0C0_BE   15
> -#define CP0C0_AT   13
> -#define CP0C0_AR   10
> -#define CP0C0_MT   7
> +#define CP0C0_AT   13    /* 14..13 */
> +#define CP0C0_AR   10    /* 12..10 */
> +#define CP0C0_MT   7     /*  9..7  */
>  #define CP0C0_VI   3
> -#define CP0C0_K0   0
> +#define CP0C0_K0   0     /*  2..0  */
>      int32_t CP0_Config1;
>  #define CP0C1_M    31
> -#define CP0C1_MMU  25
> -#define CP0C1_IS   22
> -#define CP0C1_IL   19
> -#define CP0C1_IA   16
> -#define CP0C1_DS   13
> -#define CP0C1_DL   10
> -#define CP0C1_DA   7
> +#define CP0C1_MMU  25    /* 30..25 */
> +#define CP0C1_IS   22    /* 24..22 */
> +#define CP0C1_IL   19    /* 21..19 */
> +#define CP0C1_IA   16    /* 18..16 */
> +#define CP0C1_DS   13    /* 15..13 */
> +#define CP0C1_DL   10    /* 12..10 */
> +#define CP0C1_DA   7     /*  9..7  */
>  #define CP0C1_C2   6
>  #define CP0C1_MD   5
>  #define CP0C1_PC   4
> @@ -468,7 +469,21 @@ struct CPUMIPSState {
>  #define CP0C5_CV         29
>  #define CP0C5_EVA        28
>  #define CP0C5_MSAEn      27
> +#define CP0C5_PMJ2       25
> +#define CP0C5_PMJ1       24
> +#define CP0C5_PMJ0       23

Why not use:

  #define CP0C5_PMJ         23   /* 25..23 */

> +#define CP0C5_WR2        22
> +#define CP0C5_NMS        21
> +#define CP0C5_ULS        20
> +#define CP0C5_XPA        19
> +#define CP0C5_CRCP       18
> +#define CP0C5_MI         17
> +#define CP0C5_GI1        16
> +#define CP0C5_GI0        15

Ditto:

  #define CP0C5_GI          15   /* 16..15 */

> +#define CP0C5_CA2        14
>  #define CP0C5_XNP        13
> +#define CP0C5_DEC        11
> +#define CP0C5_L2C        10
>  #define CP0C5_UFE        9
>  #define CP0C5_FRE        8
>  #define CP0C5_VP         7

Regardless:
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

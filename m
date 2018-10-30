Received: from eggs.gnu.org ([2001:4830:134:3::10]:37380)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gHTR4-0008CA-6n
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 08:47:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gHTQx-0007We-Ih
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 08:47:52 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:40813)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gHTQx-0007UA-7P
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 08:47:47 -0400
Received: by mail-wr1-f65.google.com with SMTP id i17-v6so12396533wre.7
	for <qemu-devel@nongnu.org>; Tue, 30 Oct 2018 05:47:45 -0700 (PDT)
References: <1540899411-16761-1-git-send-email-aleksandar.markovic@rt-rk.com>
	<1540899411-16761-5-git-send-email-aleksandar.markovic@rt-rk.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <f9b3eb95-7696-93b1-6b63-14b80e4d9217@redhat.com>
Date: Tue, 30 Oct 2018 13:47:42 +0100
MIME-Version: 1.0
In-Reply-To: <1540899411-16761-5-git-send-email-aleksandar.markovic@rt-rk.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 4/5] target/mips: Misc R5900-related
 cosmetic changes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>, qemu-devel@nongnu.org
Cc: smarkovic@wavecomp.com, pjovanovic@wavecomp.com, amarkovic@wavecomp.com, aurelien@aurel32.net

On 30/10/18 12:36, Aleksandar Markovic wrote:
> From: Aleksandar Markovic <amarkovic@wavecomp.com>
> 
> Misc changes in comments and strings for R5900.
> 
> Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
> ---
>   target/mips/translate.c          | 14 +++++++-------
>   target/mips/translate_init.inc.c | 12 ------------
>   2 files changed, 7 insertions(+), 19 deletions(-)
> 
> diff --git a/target/mips/translate.c b/target/mips/translate.c
> index 155331f..259ad2b 100644
> --- a/target/mips/translate.c
> +++ b/target/mips/translate.c
> @@ -2096,8 +2096,8 @@ enum {
>    * MTSAH   rs, immediate     Move Halfword Count to Shift Amount Register
>    * PROT3W  rd, rt            Parallel Rotate 3 Words
>    *
> - *     The TX79-specific Multimedia Instruction encodings
> - *     ==================================================
> + *     Multimedia Instructions (MMI) encodings

Oh now I see this. I this single change should be squashed into patch #2 
of this series.

Also, maybe use "MultiMedia ..."

> + *     =======================================
>    *
>    * MMI Instruction encoding table keys:
>    *
> @@ -24714,7 +24714,7 @@ static void decode_mmi0(CPUMIPSState *env, DisasContext *ctx)
>           generate_exception_end(ctx, EXCP_RI); /* TODO: MMI_OPC_CLASS_MMI0 */
>           break;
>       default:
> -        MIPS_INVAL("TX79 MMI class MMI0");
> +        MIPS_INVAL("MMI class MMI0");
>           generate_exception_end(ctx, EXCP_RI);
>           break;
>       }
> @@ -24746,7 +24746,7 @@ static void decode_mmi1(CPUMIPSState *env, DisasContext *ctx)
>           generate_exception_end(ctx, EXCP_RI); /* TODO: MMI_OPC_CLASS_MMI1 */
>           break;
>       default:
> -        MIPS_INVAL("TX79 MMI class MMI1");
> +        MIPS_INVAL("MMI class MMI1");
>           generate_exception_end(ctx, EXCP_RI);
>           break;
>       }
> @@ -24782,7 +24782,7 @@ static void decode_mmi2(CPUMIPSState *env, DisasContext *ctx)
>           generate_exception_end(ctx, EXCP_RI); /* TODO: MMI_OPC_CLASS_MMI2 */
>           break;
>       default:
> -        MIPS_INVAL("TX79 MMI class MMI2");
> +        MIPS_INVAL("MMI class MMI2");
>           generate_exception_end(ctx, EXCP_RI);
>           break;
>       }
> @@ -24809,7 +24809,7 @@ static void decode_mmi3(CPUMIPSState *env, DisasContext *ctx)
>           generate_exception_end(ctx, EXCP_RI); /* TODO: MMI_OPC_CLASS_MMI3 */
>           break;
>       default:
> -        MIPS_INVAL("TX79 MMI class MMI3");
> +        MIPS_INVAL("MMI class MMI3");
>           generate_exception_end(ctx, EXCP_RI);
>           break;
>       }
> @@ -24867,7 +24867,7 @@ static void decode_mmi(CPUMIPSState *env, DisasContext *ctx)
>           generate_exception_end(ctx, EXCP_RI);    /* TODO: MMI_CLASS_MMI */
>           break;
>       default:
> -        MIPS_INVAL("TX79 MMI class");
> +        MIPS_INVAL("MMI class");
>           generate_exception_end(ctx, EXCP_RI);
>           break;
>       }
> diff --git a/target/mips/translate_init.inc.c b/target/mips/translate_init.inc.c
> index 85da4a2..cab2003 100644
> --- a/target/mips/translate_init.inc.c
> +++ b/target/mips/translate_init.inc.c
> @@ -411,18 +411,6 @@ const mips_def_t mips_defs[] =
>           .mmu_type = MMU_TYPE_R4000,
>       },
>       {
> -        /*
> -         * The Toshiba TX System RISC TX79 Core Architecture manual
> -         *
> -         * https://wiki.qemu.org/File:C790.pdf
> -         *
> -         * describes the C790 processor that is a follow-up to the R5900.
> -         * There are a few notable differences in that the R5900 FPU
> -         *
> -         * - is not IEEE 754-1985 compliant,
> -         * - does not implement double format, and
> -         * - its machine code is nonstandard.
> -         */

Why remove this documentation? This entry is specific to the R5900.

>           .name = "R5900",
>           .CP0_PRid = 0x00002E00,
>           /* No L2 cache, icache size 32k, dcache size 32k, uncached coherency. */
> 

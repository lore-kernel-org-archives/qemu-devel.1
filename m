Received: from eggs.gnu.org ([2001:4830:134:3::10]:57111)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1ftblx-0007Ux-RC
	for qemu-devel@nongnu.org; Sat, 25 Aug 2018 12:50:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1ftblu-0001lh-LE
	for qemu-devel@nongnu.org; Sat, 25 Aug 2018 12:50:49 -0400
Received: from mail-io0-x244.google.com ([2607:f8b0:4001:c06::244]:37430)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1ftblu-0001jO-1j
	for qemu-devel@nongnu.org; Sat, 25 Aug 2018 12:50:46 -0400
Received: by mail-io0-x244.google.com with SMTP id v14-v6so9570185iob.4
	for <qemu-devel@nongnu.org>; Sat, 25 Aug 2018 09:50:45 -0700 (PDT)
References: <cover.1535133088.git.jancraig@amazon.com>
	<261dd8062c85c2a5eefb4d6effa2a44d5fc953f7.1535133089.git.jancraig@amazon.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <32f4fc9c-1893-521f-60d2-23e9a35b1c46@linaro.org>
Date: Sat, 25 Aug 2018 09:50:40 -0700
MIME-Version: 1.0
In-Reply-To: <261dd8062c85c2a5eefb4d6effa2a44d5fc953f7.1535133089.git.jancraig@amazon.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 1/7] target/mips: Add MXU register support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Craig Janeczek <jancraig@amazon.com>, qemu-devel@nongnu.org
Cc: aurelien@aurel32.net, amarkovic@wavecomp.com

On 08/24/2018 12:44 PM, Craig Janeczek via Qemu-devel wrote:
> +/* MXU General purpose registers moves. */
> +static inline void gen_load_mxu_gpr (TCGv t, int reg)
> +{
> +    if (reg == 0)
> +        tcg_gen_movi_tl(t, 0);
> +    else
> +        tcg_gen_mov_tl(t, mxu_gpr[reg-1]);
> +}
> +
> +static inline void gen_store_mxu_gpr (TCGv t, int reg)
> +{
> +    if (reg != 0)
> +        tcg_gen_mov_tl(mxu_gpr[reg-1], t);
> +}
> +
>  /* Moves to/from shadow registers. */
>  static inline void gen_load_srsgpr (int from, int to)
>  {
> @@ -20742,6 +20767,11 @@ void mips_tcg_init(void)
>      fpu_fcr31 = tcg_global_mem_new_i32(cpu_env,
>                                         offsetof(CPUMIPSState, active_fpu.fcr31),
>                                         "fcr31");
> +
> +    for (i = 0; i < 16; i++)
> +        mxu_gpr[i] = tcg_global_mem_new(cpu_env,
> +                                        offsetof(CPUMIPSState, active_tc.mxu_gpr[i]),
> +                                        mxuregnames[i]);
>  }

You need to fix the ./scripts/checkpatch.pl errors.
But otherwise the logic is ok.


r~

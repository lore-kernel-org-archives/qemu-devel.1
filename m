Received: from eggs.gnu.org ([209.51.188.92]:54765)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1grnjK-0004Xp-70
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 12:44:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1grnjG-0004Dx-K9
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 12:44:52 -0500
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:43821)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1grnjG-0004Dg-Eh
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 12:44:50 -0500
Received: by mail-ot1-x342.google.com with SMTP id a11so1175436otr.10
	for <qemu-devel@nongnu.org>; Thu, 07 Feb 2019 09:44:50 -0800 (PST)
MIME-Version: 1.0
References: <20190114011122.5995-1-richard.henderson@linaro.org>
	<20190114011122.5995-14-richard.henderson@linaro.org>
In-Reply-To: <20190114011122.5995-14-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 7 Feb 2019 17:44:38 +0000
Message-ID: <CAFEAcA9c_Fw1YNjV9Gnat6ymHSBVvcfH8xZDgoC2ENAuzCqrTg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 13/17] target/arm: Set PSTATE.TCO on
 exception entry
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>

On Mon, 14 Jan 2019 at 01:12, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> R0085 specifies that exception handlers begin with tag checks overridden.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/helper.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/target/arm/helper.c b/target/arm/helper.c
> index df43deb0f8..1e9ccf0b2e 100644
> --- a/target/arm/helper.c
> +++ b/target/arm/helper.c
> @@ -8830,7 +8830,7 @@ static void arm_cpu_do_interrupt_aarch64(CPUState *cs)
>      qemu_log_mask(CPU_LOG_INT, "...with ELR 0x%" PRIx64 "\n",
>                    env->elr_el[new_el]);
>
> -    pstate_write(env, PSTATE_DAIF | new_mode);
> +    pstate_write(env, PSTATE_DAIF | PSTATE_TCO | new_mode);
>      env->aarch64 = 1;
>      aarch64_restore_sp(env, new_el);

PSTATE_TCO being set doesn't affect codegen for non-MTE CPUs,
right?

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

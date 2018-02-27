Received: from eggs.gnu.org ([2001:4830:134:3::10]:49790)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eqeBi-0005l0-G5
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 07:16:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eqeBh-0000LM-Jb
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 07:16:54 -0500
Received: from mail-ot0-x242.google.com ([2607:f8b0:4003:c0f::242]:41497)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eqeBh-0000Kp-Cc
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 07:16:53 -0500
Received: by mail-ot0-x242.google.com with SMTP id w38so3547695ota.8
	for <qemu-devel@nongnu.org>; Tue, 27 Feb 2018 04:16:53 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180217182323.25885-45-richard.henderson@linaro.org>
References: <20180217182323.25885-1-richard.henderson@linaro.org>
	<20180217182323.25885-45-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 27 Feb 2018 12:16:32 +0000
Message-ID: <CAFEAcA-9n_fF0Z7Z+W+2Tf_5n8unS6jXa67yNKBM-DqrzCpRwA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH v2 44/67] target/arm: Implement
 SVE Memory Contiguous Load Group
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

On 17 February 2018 at 18:23, Richard Henderson
<richard.henderson@linaro.org> wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Commit message should mention significant missing things
like first-fault/non-fault handling. (In general I would prefer
not to see so many patches which all have one-liner commit
messages.)

> +static void trans_LDFF1_zprr(DisasContext *s, arg_rprr_load *a, uint32_t insn)
> +{
> +    /* FIXME */
> +    trans_LD_zprr(s, a, insn);
> +}
> +
> +static void trans_LDNF1_zpri(DisasContext *s, arg_rpri_load *a, uint32_t insn)
> +{
> +    /* FIXME */
> +    trans_LD_zpri(s, a, insn);
> +}

What are these FIXMEs for? Either they should be fixed, or expanded
into longer comments describing what needs fixing. I assume it is
the missing non-fault/first-fault behaviour...

> diff --git a/target/arm/sve.decode b/target/arm/sve.decode
> index 42d14994a1..d2b3869c58 100644
> --- a/target/arm/sve.decode
> +++ b/target/arm/sve.decode
> @@ -42,9 +42,12 @@
>  %tszimm16_shl  22:2 16:5 !function=tszimm_shl
>
>  # Signed 8-bit immediate, optionally shifted left by 8.
> -%sh8_i8s               5:9 !function=expand_imm_sh8s
> +%sh8_i8s       5:9 !function=expand_imm_sh8s
>  # Unsigned 8-bit immediate, optionally shifted left by 8.
> -%sh8_i8u               5:9 !function=expand_imm_sh8u
> +%sh8_i8u       5:9 !function=expand_imm_sh8u


More changes that should be squashed into earlier patch.


otherwise
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

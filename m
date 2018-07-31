Received: from eggs.gnu.org ([2001:4830:134:3::10]:54821)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fkZjw-00038C-TW
	for qemu-devel@nongnu.org; Tue, 31 Jul 2018 14:51:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fkZjt-0001Tl-M8
	for qemu-devel@nongnu.org; Tue, 31 Jul 2018 14:51:24 -0400
Received: from mail-vk0-x243.google.com ([2607:f8b0:400c:c05::243]:34446)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fkZjt-0001TH-G1
	for qemu-devel@nongnu.org; Tue, 31 Jul 2018 14:51:21 -0400
Received: by mail-vk0-x243.google.com with SMTP id l143-v6so8039406vke.1
	for <qemu-devel@nongnu.org>; Tue, 31 Jul 2018 11:51:21 -0700 (PDT)
References: <1532967169-22265-1-git-send-email-aleksandar.markovic@rt-rk.com>
	<1532967169-22265-43-git-send-email-aleksandar.markovic@rt-rk.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <a54ad820-f536-077c-c5c3-1fa1b141680a@linaro.org>
Date: Tue, 31 Jul 2018 14:51:16 -0400
MIME-Version: 1.0
In-Reply-To: <1532967169-22265-43-git-send-email-aleksandar.markovic@rt-rk.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v5 42/76] target/mips: Add emulation of DSP
 ASE for nanoMIPS - part 5
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>, qemu-devel@nongnu.org
Cc: laurent@vivier.eu, riku.voipio@iki.fi, philippe.mathieu.daude@gmail.com, aurelien@aurel32.net, amarkovic@wavecomp.com, smarkovic@wavecomp.com, pjovanovic@wavecomp.com, pburton@wavecomp.com

On 07/30/2018 12:12 PM, Aleksandar Markovic wrote:
> +static void gen_pool32axf_4_nanomips_insn(DisasContext *ctx, uint32_t opc,
> +                                          int ret, int v1, int v2)
> +{
> +    TCGv t0;
> +    TCGv v0_t;
> +    TCGv v1_t;
> +
> +    t0 = tcg_temp_new();
> +
> +    v0_t = tcg_temp_new();
> +    v1_t = tcg_temp_new();
> +
> +    gen_load_gpr(v0_t, ret);

Again with loading a result,

> +    gen_load_gpr(v1_t, v1);
> +
> +    switch (opc) {
> +    case NM_ABSQ_S_QB:
> +        check_dspr2(ctx);
> +        gen_helper_absq_s_qb(cpu_gpr[ret], v0_t, cpu_env);
> +        break;

and unprotected use of cpu_gpr[0].


r~

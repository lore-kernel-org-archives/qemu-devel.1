Received: from eggs.gnu.org ([2001:4830:134:3::10]:38687)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fkUq2-00028V-Cs
	for qemu-devel@nongnu.org; Tue, 31 Jul 2018 09:37:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fkUpz-0004cR-9D
	for qemu-devel@nongnu.org; Tue, 31 Jul 2018 09:37:22 -0400
Received: from mail-vk0-x244.google.com ([2607:f8b0:400c:c05::244]:41622)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fkUpz-0004cE-3b
	for qemu-devel@nongnu.org; Tue, 31 Jul 2018 09:37:19 -0400
Received: by mail-vk0-x244.google.com with SMTP id o82-v6so7500991vko.8
	for <qemu-devel@nongnu.org>; Tue, 31 Jul 2018 06:37:18 -0700 (PDT)
References: <1532967169-22265-1-git-send-email-aleksandar.markovic@rt-rk.com>
	<1532967169-22265-26-git-send-email-aleksandar.markovic@rt-rk.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <5e7d8dfb-11b9-1ff7-1980-4b6c0a4ee6b4@linaro.org>
Date: Tue, 31 Jul 2018 09:35:49 -0400
MIME-Version: 1.0
In-Reply-To: <1532967169-22265-26-git-send-email-aleksandar.markovic@rt-rk.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v5 25/76] target/mips: Add emulation of
 nanoMIPS 16-bit save and restore instructions
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

On 07/30/2018 12:11 PM, Aleksandar Markovic wrote:
> +static void gen_adjust_sp(DisasContext *ctx, int u)
> +{
> +    TCGv tsp = tcg_temp_new();
> +    gen_base_offset_addr(ctx, tsp, 29, u);
> +    gen_store_gpr(tsp, 29);
> +    tcg_temp_free(tsp);
> +}

This could now be just

  gen_op_addr_addi(cpu_gpr[29], cpu_gpr[29], u);


r~

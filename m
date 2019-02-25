Received: from eggs.gnu.org ([209.51.188.92]:48650)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gyOdX-0006hD-Al
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 17:22:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gyOdW-00072H-Ig
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 17:22:11 -0500
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643]:34080)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gyOdW-00070o-8M
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 17:22:10 -0500
Received: by mail-pl1-x643.google.com with SMTP id d15so5165949plr.1
	for <qemu-devel@nongnu.org>; Mon, 25 Feb 2019 14:22:10 -0800 (PST)
References: <1551111037-23411-1-git-send-email-mateja.marjanovic@rt-rk.com>
	<1551111037-23411-4-git-send-email-mateja.marjanovic@rt-rk.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <a90adf65-905d-c1e4-ca11-51b4f19a8c91@linaro.org>
Date: Mon, 25 Feb 2019 14:22:06 -0800
MIME-Version: 1.0
In-Reply-To: <1551111037-23411-4-git-send-email-mateja.marjanovic@rt-rk.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 3/3] target/mips: Add emulation of MMI
 instruction PCPYUD
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mateja Marjanovic <mateja.marjanovic@rt-rk.com>, qemu-devel@nongnu.org
Cc: arikalo@wavecomp.com, amarkovic@wavecomp.com, aurelien@aurel32.net

On 2/25/19 8:10 AM, Mateja Marjanovic wrote:
> +    if (rd == 0) {
> +        /* nop */
> +    } else if ((rt == 0) && (rs == 0)) {
> +        tcg_gen_movi_i64(cpu_gpr[rt], 0);
> +        tcg_gen_movi_i64(cpu_mmr[rt], 0);
> +    } else if (rt == 0) {
> +        tcg_gen_movi_i64(cpu_mmr[rd], 0);
> +        tcg_gen_mov_i64(cpu_gpr[rd], cpu_mmr[rs]);
> +    } else if (rs == 0) {
> +        tcg_gen_mov_i64(cpu_mmr[rd], cpu_mmr[rt]);
> +        tcg_gen_movi_i64(cpu_gpr[rd], 0);
> +    } else {
> +        tcg_gen_mov_i64(cpu_mmr[rd], cpu_mmr[rt]);
> +        tcg_gen_mov_i64(cpu_gpr[rd], cpu_mmr[rs]);
> +    }

Same as patch 2.  You may have to invent gen_load_mmr.


r~

Received: from eggs.gnu.org ([209.51.188.92]:36616)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gyg7L-0000IJ-CB
	for qemu-devel@nongnu.org; Tue, 26 Feb 2019 12:02:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gyg7F-00040T-Fe
	for qemu-devel@nongnu.org; Tue, 26 Feb 2019 12:02:07 -0500
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641]:35381)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gyg7F-0003xQ-6n
	for qemu-devel@nongnu.org; Tue, 26 Feb 2019 12:02:01 -0500
Received: by mail-pl1-x641.google.com with SMTP id p19so6531680plo.2
	for <qemu-devel@nongnu.org>; Tue, 26 Feb 2019 09:02:00 -0800 (PST)
References: <1551183797-13570-1-git-send-email-mateja.marjanovic@rt-rk.com>
	<1551183797-13570-4-git-send-email-mateja.marjanovic@rt-rk.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <269b43a4-5bed-2628-bc5e-061fa5fd1f8a@linaro.org>
Date: Tue, 26 Feb 2019 09:01:56 -0800
MIME-Version: 1.0
In-Reply-To: <1551183797-13570-4-git-send-email-mateja.marjanovic@rt-rk.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 3/6] target/mips: Add emulation of MMI
 instruction PCPYLD
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

On 2/26/19 4:23 AM, Mateja Marjanovic wrote:
> +        if (rs == 0) {
> +            tcg_gen_movi_i64(cpu_mmr[rd], 0);
> +        } else {
> +            tcg_gen_mov_i64(cpu_mmr[rd], cpu_gpr[rs]);
> +        }

Why are you not using gen_load_gpr?

> +        if (rt == 0) {
> +            tcg_gen_movi_i64(cpu_gpr[rd], 0);
> +        } else {
> +            if (rd != rt) {
> +                tcg_gen_mov_i64(cpu_gpr[rd], cpu_gpr[rt]);

Why are you duplicating a check that tcg_gen_mov_i64 will do?


r~

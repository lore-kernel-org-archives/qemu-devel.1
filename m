Received: from eggs.gnu.org ([209.51.188.92]:60035)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hBabG-0001l1-EN
	for qemu-devel@nongnu.org; Wed, 03 Apr 2019 03:46:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hBabE-0006LB-Gv
	for qemu-devel@nongnu.org; Wed, 03 Apr 2019 03:46:22 -0400
Received: from mail-pg1-x530.google.com ([2607:f8b0:4864:20::530]:45755)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hBabB-0006GW-FG
	for qemu-devel@nongnu.org; Wed, 03 Apr 2019 03:46:18 -0400
Received: by mail-pg1-x530.google.com with SMTP id y3so7869645pgk.12
	for <qemu-devel@nongnu.org>; Wed, 03 Apr 2019 00:46:16 -0700 (PDT)
References: <1554218121-26766-1-git-send-email-mateja.marjanovic@rt-rk.com>
	<1554218121-26766-2-git-send-email-mateja.marjanovic@rt-rk.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <8258dcf8-d84a-c642-e18b-d16be001f587@linaro.org>
Date: Wed, 3 Apr 2019 14:46:09 +0700
MIME-Version: 1.0
In-Reply-To: <1554218121-26766-2-git-send-email-mateja.marjanovic@rt-rk.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v5 1/2] target/mips: Optimize
 ILVOD.<B|H|W|D> MSA instructions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mateja Marjanovic <mateja.marjanovic@rt-rk.com>, qemu-devel@nongnu.org
Cc: aurelien@aurel32.net, amarkovic@wavecomp.com, arikalo@wavecomp.com

On 4/2/19 10:15 PM, Mateja Marjanovic wrote:
> +static inline void gen_ilvod_w(CPUMIPSState *env, uint32_t wd,
> +                               uint32_t ws, uint32_t wt)
> +{
> +    TCGv_i64 t1 = tcg_temp_new_i64();
> +    const uint64_t mask = 0xffffffff00000000ULL;
> +
> +    tcg_gen_andi_i64(t1, msa_wr_d[wt * 2], mask);
> +    tcg_gen_shri_i64(t1, t1, 32);

The andi is useless.  The bits that it discards are also discarded by the shift.


r~

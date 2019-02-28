Received: from eggs.gnu.org ([209.51.188.92]:51376)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gz9wg-0007JQ-84
	for qemu-devel@nongnu.org; Wed, 27 Feb 2019 19:53:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gz9wV-0004e1-0i
	for qemu-devel@nongnu.org; Wed, 27 Feb 2019 19:52:59 -0500
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:45744)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gz9wL-0001Cl-1K
	for qemu-devel@nongnu.org; Wed, 27 Feb 2019 19:52:49 -0500
Received: by mail-pf1-x444.google.com with SMTP id v21so8819775pfm.12
	for <qemu-devel@nongnu.org>; Wed, 27 Feb 2019 16:51:29 -0800 (PST)
References: <1551289217-10072-1-git-send-email-mateja.marjanovic@rt-rk.com>
	<1551289217-10072-2-git-send-email-mateja.marjanovic@rt-rk.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <0a3137ac-6de0-5980-313e-f36f87641420@linaro.org>
Date: Wed, 27 Feb 2019 16:51:25 -0800
MIME-Version: 1.0
In-Reply-To: <1551289217-10072-2-git-send-email-mateja.marjanovic@rt-rk.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 1/4] target/mips: Optimize support for MSA
 instructions ILVEV.<B|H|W|D>
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

On 2/27/19 9:40 AM, Mateja Marjanovic wrote:
> +void helper_msa_ilvev_df(CPUMIPSState *env, uint32_t df, uint32_t wd,
> +                         uint32_t ws, uint32_t wt)
> +{
> +    wr_t *pwd = &(env->active_fpu.fpr[wd].wr);
> +    wr_t *pws = &(env->active_fpu.fpr[ws].wr);
> +    wr_t *pwt = &(env->active_fpu.fpr[wt].wr);
> +
> +    switch (df) {

I'll bet you can do even better by splitting this into 4 functions such that
you do not need to pass the "df" parameter at all -- just choose the correct
helper function during translate.


r~

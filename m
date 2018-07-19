Received: from eggs.gnu.org ([2001:4830:134:3::10]:56597)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fgESC-0006yS-7r
	for qemu-devel@nongnu.org; Thu, 19 Jul 2018 15:19:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fgES8-0006fW-QK
	for qemu-devel@nongnu.org; Thu, 19 Jul 2018 15:19:08 -0400
Received: from mail-pl0-x242.google.com ([2607:f8b0:400e:c01::242]:33764)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fgES8-0006fF-Id
	for qemu-devel@nongnu.org; Thu, 19 Jul 2018 15:19:04 -0400
Received: by mail-pl0-x242.google.com with SMTP id 6-v6so4078232plb.0
	for <qemu-devel@nongnu.org>; Thu, 19 Jul 2018 12:19:04 -0700 (PDT)
References: <1532004912-13899-1-git-send-email-stefan.markovic@rt-rk.com>
	<1532004912-13899-16-git-send-email-stefan.markovic@rt-rk.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <35825c4b-2c54-4a6d-f7a0-f21fbffa6050@linaro.org>
Date: Thu, 19 Jul 2018 12:19:00 -0700
MIME-Version: 1.0
In-Reply-To: <1532004912-13899-16-git-send-email-stefan.markovic@rt-rk.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 15/40] target/mips: Add emulation of
 misc nanoMIPS instructions (pool p_lsx)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Markovic <stefan.markovic@rt-rk.com>, qemu-devel@nongnu.org
Cc: laurent@vivier.eu, riku.voipio@iki.fi, philippe.mathieu.daude@gmail.com, aurelien@aurel32.net, amarkovic@wavecomp.com, smarkovic@wavecomp.com, pjovanovic@wavecomp.com, pburton@wavecomp.com

On 07/19/2018 05:54 AM, Stefan Markovic wrote:
> +static void gen_p_lsx(DisasContext *ctx, int rd, int rs, int rt)
> +{
> +    TCGv t0, t1;
> +    t0 = tcg_temp_new();
> +    t1 = tcg_temp_new();
> +    tcg_gen_movi_tl(t1, 0);
> +    if (rs == 0) {
> +        tcg_gen_movi_tl(t0, 0);
> +    } else {
> +        gen_load_gpr(t0, rs);
> +    }
> +    if (rt == 0) {
> +        tcg_gen_movi_tl(t1, 0);
> +    } else {
> +        gen_load_gpr(t1, rt);
> +    }

gen_load_gpr already takes care of register 0.
And what is that initial redundant assignment to t1?


r~

Received: from eggs.gnu.org ([209.51.188.92]:40426)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gygK0-0007XI-7R
	for qemu-devel@nongnu.org; Tue, 26 Feb 2019 12:15:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gygJu-0000bk-Mc
	for qemu-devel@nongnu.org; Tue, 26 Feb 2019 12:15:08 -0500
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e]:42447)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gygJr-0000Vx-6t
	for qemu-devel@nongnu.org; Tue, 26 Feb 2019 12:15:03 -0500
Received: by mail-pf1-x42e.google.com with SMTP id n74so6538771pfi.9
	for <qemu-devel@nongnu.org>; Tue, 26 Feb 2019 09:14:57 -0800 (PST)
References: <1551183797-13570-1-git-send-email-mateja.marjanovic@rt-rk.com>
	<1551183797-13570-3-git-send-email-mateja.marjanovic@rt-rk.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <9c6deafd-0f61-7693-dfb7-69ab26edf004@linaro.org>
Date: Tue, 26 Feb 2019 09:14:54 -0800
MIME-Version: 1.0
In-Reply-To: <1551183797-13570-3-git-send-email-mateja.marjanovic@rt-rk.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 2/6] target/mips: Add emulation of MMI
 instruction PCPYH
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
> +        tcg_gen_andi_i64(t0, cpu_gpr[rt], mask);
> +        tcg_gen_movi_i64(t1, 0);
> +        tcg_gen_or_i64(t1, t0, t1);
> +        tcg_gen_shli_i64(t0, t0, 16);
> +        tcg_gen_or_i64(t1, t0, t1);
> +        tcg_gen_shli_i64(t0, t0, 16);
> +        tcg_gen_or_i64(t1, t0, t1);
> +        tcg_gen_shli_i64(t0, t0, 16);
> +        tcg_gen_or_i64(t1, t0, t1);

See previous review about this using 4x too many operations.


r~

Received: from eggs.gnu.org ([209.51.188.92]:56597)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1h0uL6-00007z-Sq
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 15:37:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1h0uL5-0006fo-He
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 15:37:32 -0500
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436]:34005)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1h0uL5-0006ZN-7N
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 15:37:31 -0500
Received: by mail-pf1-x436.google.com with SMTP id u9so3850058pfn.1
	for <qemu-devel@nongnu.org>; Mon, 04 Mar 2019 12:37:27 -0800 (PST)
References: <1551712405-2530-1-git-send-email-mateja.marjanovic@rt-rk.com>
	<1551712405-2530-3-git-send-email-mateja.marjanovic@rt-rk.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <ed9a9992-cd34-224a-4f62-5b119b1c1120@linaro.org>
Date: Mon, 4 Mar 2019 12:37:23 -0800
MIME-Version: 1.0
In-Reply-To: <1551712405-2530-3-git-send-email-mateja.marjanovic@rt-rk.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 02/13] target/mips: Add emulation of MMI
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

On 3/4/19 7:13 AM, Mateja Marjanovic wrote:
> +            if (rd != rt) {
> +                tcg_gen_mov_i64(cpu_gpr[rd], cpu_gpr[rt]);
> +            }

This condition replicates the one inside tcg_gen_mov_i64.


r~

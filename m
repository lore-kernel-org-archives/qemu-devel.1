Received: from eggs.gnu.org ([209.51.188.92]:57028)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1h0uMa-0001HO-Qm
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 15:39:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1h0uMa-0000Dz-1n
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 15:39:04 -0500
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:45343)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1h0uMZ-0000Bx-EF
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 15:39:03 -0500
Received: by mail-pf1-x441.google.com with SMTP id v21so3841180pfm.12
	for <qemu-devel@nongnu.org>; Mon, 04 Mar 2019 12:39:03 -0800 (PST)
References: <1551712405-2530-1-git-send-email-mateja.marjanovic@rt-rk.com>
	<1551712405-2530-4-git-send-email-mateja.marjanovic@rt-rk.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <b617edef-2935-c0d6-4f3e-f0993e2cf3cd@linaro.org>
Date: Mon, 4 Mar 2019 12:38:58 -0800
MIME-Version: 1.0
In-Reply-To: <1551712405-2530-4-git-send-email-mateja.marjanovic@rt-rk.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 03/13] target/mips: Add emulation of MMI
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

On 3/4/19 7:13 AM, Mateja Marjanovic wrote:
> +            if (rd != rt) {
> +                tcg_gen_mov_i64(cpu_mmr[rd], cpu_mmr[rt]);
> +            }

This condition replicates the one inside tcg_gen_mov_i64.


r~

Received: from eggs.gnu.org ([2001:4830:134:3::10]:60636)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fqLLl-0003WH-5O
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 12:42:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fqLLf-0008Mp-9N
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 12:42:17 -0400
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:38894)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fqLLe-0008MT-Fn
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 12:42:10 -0400
Received: by mail-pf1-x441.google.com with SMTP id x17-v6so2267564pfh.5
	for <qemu-devel@nongnu.org>; Thu, 16 Aug 2018 09:42:09 -0700 (PDT)
References: <1534431497-1385-1-git-send-email-aleksandar.markovic@rt-rk.com>
	<1534431497-1385-44-git-send-email-aleksandar.markovic@rt-rk.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <892dabee-193d-ce2c-2557-51775bd3eb54@linaro.org>
Date: Thu, 16 Aug 2018 09:42:06 -0700
MIME-Version: 1.0
In-Reply-To: <1534431497-1385-44-git-send-email-aleksandar.markovic@rt-rk.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v9 43/84] target/mips: Add emulation of DSP
 ASE for nanoMIPS - part 2
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, laurent@vivier.eu, riku.voipio@iki.fi, philippe.mathieu.daude@gmail.com, aurelien@aurel32.net, amarkovic@wavecomp.com, smarkovic@wavecomp.com, pjovanovic@wavecomp.com, pburton@wavecomp.com

On 08/16/2018 07:57 AM, Aleksandar Markovic wrote:
> +                        gen_compute_branch(ctx, OPC_BPOSGE32, 4, -1, -2,
> +                                           imm, 4);

gen_compute_compact_branch_nm, or something.


r~

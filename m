Received: from eggs.gnu.org ([2001:4830:134:3::10]:55939)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eihKc-0005Vo-Ea
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 09:01:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eihKT-0007PI-8x
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 09:01:14 -0500
Received: from mail-pl0-x230.google.com ([2607:f8b0:400e:c01::230]:36098)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1eihKT-0007Mo-26
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 09:01:05 -0500
Received: by mail-pl0-x230.google.com with SMTP id v3so11823269plg.3
	for <qemu-devel@nongnu.org>; Mon, 05 Feb 2018 06:01:04 -0800 (PST)
References: <1517811767-75958-1-git-send-email-mjc@sifive.com>
	<1517811767-75958-6-git-send-email-mjc@sifive.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <ce17e6a5-7e22-a73e-36f5-89c81bcb60a6@linaro.org>
Date: Mon, 5 Feb 2018 06:01:00 -0800
MIME-Version: 1.0
In-Reply-To: <1517811767-75958-6-git-send-email-mjc@sifive.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v4 06/22] RISC-V FPU Support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Clark <mjc@sifive.com>, qemu-devel@nongnu.org
Cc: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, Palmer Dabbelt <palmer@sifive.com>, Sagar Karandikar <sagark@eecs.berkeley.edu>, RISC-V Patches <patches@groups.riscv.org>

On 02/04/2018 10:22 PM, Michael Clark wrote:
> +uint64_t helper_fmsub_s(CPURISCVState *env, uint64_t frs1, uint64_t frs2,
> +                        uint64_t frs3)
> +{
> +    return float32_muladd(frs1, frs2, frs3 ^ (uint32_t)INT32_MIN, 0,
> +                          &env->fp_status);

Missing the requested change to use float32_chs or float_muladd_negate_product
et al throughout the fma family of helpers.

Probably float_muladd_* since you've re-enabled default_nan_mode.


r~

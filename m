Received: from eggs.gnu.org ([2001:4830:134:3::10]:42003)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fXFPC-0000wb-75
	for qemu-devel@nongnu.org; Sun, 24 Jun 2018 20:30:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fXFP9-0002Fw-2b
	for qemu-devel@nongnu.org; Sun, 24 Jun 2018 20:30:54 -0400
Received: from mail-pl0-x243.google.com ([2607:f8b0:400e:c01::243]:39866)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fXFP8-0002Fi-Sf
	for qemu-devel@nongnu.org; Sun, 24 Jun 2018 20:30:51 -0400
Received: by mail-pl0-x243.google.com with SMTP id s24-v6so5958943plq.6
	for <qemu-devel@nongnu.org>; Sun, 24 Jun 2018 17:30:50 -0700 (PDT)
References: <20180620120620.12806-1-yongbok.kim@mips.com>
	<20180620120620.12806-22-yongbok.kim@mips.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <4504e8b3-dc2c-6cb8-707b-451962001660@linaro.org>
Date: Sun, 24 Jun 2018 17:30:47 -0700
MIME-Version: 1.0
In-Reply-To: <20180620120620.12806-22-yongbok.kim@mips.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 21/35] target/mips: Add nanoMIPS rotx
 instruction
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Yongbok Kim <yongbok.kim@mips.com>, qemu-devel@nongnu.org
Cc: Aleksandar.Markovic@mips.com, Paul.Burton@mips.com, Stefan.Markovic@mips.com, Matthew.Fortune@mips.com, James.Hogan@mips.com, aurelien@aurel32.net

On 06/20/2018 05:06 AM, Yongbok Kim wrote:
>          case NM_P_ROTX:
> +            if (rt != 0) {
> +                TCGv t0 = tcg_temp_new();
> +                TCGv_i32 shift = tcg_const_i32(extract32(ctx->opcode, 0, 5));
> +                TCGv_i32 shiftx = tcg_const_i32(extract32(ctx->opcode, 7, 4)
> +                                                << 1);
> +                TCGv_i32 stripe = tcg_const_i32((ctx->opcode >> 6) & 1);
> +
> +                gen_load_gpr(t0, rs);
> +                gen_helper_rotx(cpu_gpr[rt], t0, shift, shiftx, stripe);
> +                tcg_temp_free(t0);
> +
> +                tcg_temp_free_i32(shift);
> +                tcg_temp_free_i32(shiftx);
> +                tcg_temp_free_i32(stripe);
> +            }

It would be worth your while to recognize the special case of BYTEREVW.

But otherwise
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

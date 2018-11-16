Received: from eggs.gnu.org ([2001:4830:134:3::10]:56679)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gNhtH-0004xc-IY
	for qemu-devel@nongnu.org; Fri, 16 Nov 2018 12:26:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gNhtE-0004Ml-Mq
	for qemu-devel@nongnu.org; Fri, 16 Nov 2018 12:26:46 -0500
Received: from mail-it1-x12c.google.com ([2607:f8b0:4864:20::12c]:34034)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gNhtC-0004LO-SK
	for qemu-devel@nongnu.org; Fri, 16 Nov 2018 12:26:42 -0500
Received: by mail-it1-x12c.google.com with SMTP id x124so1620308itd.1
	for <qemu-devel@nongnu.org>; Fri, 16 Nov 2018 09:26:40 -0800 (PST)
References: <cover.1542321076.git.alistair.francis@wdc.com>
	<cd89e90aeb79ed438aaee6cfa02ca42a36d633b6.1542321076.git.alistair.francis@wdc.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <2aa0f464-c9c4-3d59-81da-952279f56843@linaro.org>
Date: Fri, 16 Nov 2018 18:26:33 +0100
MIME-Version: 1.0
In-Reply-To: <cd89e90aeb79ed438aaee6cfa02ca42a36d633b6.1542321076.git.alistair.francis@wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC v1 20/23] riscv: tcg-target: Add the target
 init code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <Alistair.Francis@wdc.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>
Cc: "alistair23@gmail.com" <alistair23@gmail.com>

On 11/15/18 11:36 PM, Alistair Francis wrote:
> +    tcg_regset_set_reg(s->reserved_regs, TCG_REG_L0);
> +    tcg_regset_set_reg(s->reserved_regs, TCG_REG_L1);
> +    tcg_regset_set_reg(s->reserved_regs, TCG_REG_RA);

Why are these three reserved?


r~

Received: from eggs.gnu.org ([2001:4830:134:3::10]:55080)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gS5aS-0004dc-Ar
	for qemu-devel@nongnu.org; Wed, 28 Nov 2018 14:33:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gS5aP-0004WQ-4f
	for qemu-devel@nongnu.org; Wed, 28 Nov 2018 14:33:28 -0500
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c]:34100)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gS5aM-0004P0-IS
	for qemu-devel@nongnu.org; Wed, 28 Nov 2018 14:33:22 -0500
Received: by mail-pf1-x42c.google.com with SMTP id h3so10672852pfg.1
	for <qemu-devel@nongnu.org>; Wed, 28 Nov 2018 11:33:18 -0800 (PST)
References: <cover.1543352682.git.alistair.francis@wdc.com>
	<67303db03721ef2e4d9737379312681543a0ba0c.1543352682.git.alistair.francis@wdc.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <e48d8e2c-3399-06cf-e4bb-fb73f5b1dba1@linaro.org>
Date: Wed, 28 Nov 2018 11:33:14 -0800
MIME-Version: 1.0
In-Reply-To: <67303db03721ef2e4d9737379312681543a0ba0c.1543352682.git.alistair.francis@wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC v2 07/24] riscv: tcg-target: Add support for
 the constraints
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

On 11/27/18 1:07 PM, Alistair Francis wrote:
> +    OPC_FENCE_RW_RW = 0x0330000f,
> +    OPC_FENCE_R_R = 0x0220000f,
> +    OPC_FENCE_W_R = 0x0120000f,
> +    OPC_FENCE_R_W = 0x0210000f,
> +    OPC_FENCE_W_W = 0x0110000f,
> +    OPC_FENCE_R_RW = 0x0230000f,
> +    OPC_FENCE_RW_W = 0x0310000f,

A full compliment would have 9 alternatives, surely?
Perhaps better to just fill in the fields when emitting?

Otherwise,
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

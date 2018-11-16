Received: from eggs.gnu.org ([2001:4830:134:3::10]:54828)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gNhnk-0001XB-0S
	for qemu-devel@nongnu.org; Fri, 16 Nov 2018 12:21:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gNhng-0001Yz-TH
	for qemu-devel@nongnu.org; Fri, 16 Nov 2018 12:21:03 -0500
Received: from mail-it1-x131.google.com ([2607:f8b0:4864:20::131]:35227)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gNhng-0001Yi-Nw
	for qemu-devel@nongnu.org; Fri, 16 Nov 2018 12:21:00 -0500
Received: by mail-it1-x131.google.com with SMTP id v11so35341014itj.0
	for <qemu-devel@nongnu.org>; Fri, 16 Nov 2018 09:21:00 -0800 (PST)
References: <cover.1542321076.git.alistair.francis@wdc.com>
	<1c17c37965dcd1b579a58af168892818b33453fe.1542321076.git.alistair.francis@wdc.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <ccfbcd15-2295-59ff-4cad-3d5e2947beda@linaro.org>
Date: Fri, 16 Nov 2018 18:20:50 +0100
MIME-Version: 1.0
In-Reply-To: <1c17c37965dcd1b579a58af168892818b33453fe.1542321076.git.alistair.francis@wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC v1 05/23] riscv: Add the tcg-target header
 file
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

On 11/15/18 11:34 PM, Alistair Francis wrote:
> +#define TCG_TARGET_HAS_extrl_i64_i32    0
> +#define TCG_TARGET_HAS_extrh_i64_i32    0

You need these two for rv64 to preserve the invariant that 32-bit values are
sign-extended in a 64-bit register.  Otherwise _i32 comparisons won't work
reliably.

The first is yet another alias for exts32_i64; the second is an arithmetic
right shift of 32.  Their existence changes how code is emitted in tcg-op.c.


r~

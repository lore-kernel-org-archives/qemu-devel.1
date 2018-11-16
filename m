Received: from eggs.gnu.org ([2001:4830:134:3::10]:56749)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gNZ0C-0006O7-D8
	for qemu-devel@nongnu.org; Fri, 16 Nov 2018 02:57:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gNZ04-0000c2-Uj
	for qemu-devel@nongnu.org; Fri, 16 Nov 2018 02:57:17 -0500
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:41528)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gNZ03-0000b6-6A
	for qemu-devel@nongnu.org; Fri, 16 Nov 2018 02:57:11 -0500
Received: by mail-wr1-x441.google.com with SMTP id v18-v6so23827655wrt.8
	for <qemu-devel@nongnu.org>; Thu, 15 Nov 2018 23:57:11 -0800 (PST)
References: <cover.1542321076.git.alistair.francis@wdc.com>
	<1c17c37965dcd1b579a58af168892818b33453fe.1542321076.git.alistair.francis@wdc.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <1c642108-907b-38ce-0a4c-b0e64400d02d@linaro.org>
Date: Fri, 16 Nov 2018 08:57:06 +0100
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
> +#define TCG_TARGET_HAS_add2_i32         0
> +#define TCG_TARGET_HAS_sub2_i32         0

You're not allowed to not implement this for riscv-32,
along with brcond2 and setcond2.

> +#define TCG_TARGET_HAS_movcond_i32      0

The architecture manual suggests that implementations recognize short
branch-over and convert internally to predication.  Do any do that?

Even if they don't, you might implement it that way anyway, as the code size
savings are large vs the inline fallback (6 insns).  But you can definitely put
that off for a later patch.

> +#define TCG_TARGET_HAS_ext16u_i32       1

Really?  I thought this required two insns...  Or do you expand to shifts while
the default is x & 0xffff, which would take 3 insns?  I guess I'll find out as
I keep reading.  ;-)


r~

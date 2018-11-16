Received: from eggs.gnu.org ([2001:4830:134:3::10]:57836)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gNZ2i-0008U0-CD
	for qemu-devel@nongnu.org; Fri, 16 Nov 2018 02:59:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gNZ2h-00023K-Kb
	for qemu-devel@nongnu.org; Fri, 16 Nov 2018 02:59:56 -0500
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a]:44577)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gNZ2h-00022g-E5
	for qemu-devel@nongnu.org; Fri, 16 Nov 2018 02:59:55 -0500
Received: by mail-wr1-x42a.google.com with SMTP id j17-v6so23824869wrq.11
	for <qemu-devel@nongnu.org>; Thu, 15 Nov 2018 23:59:55 -0800 (PST)
References: <cover.1542321076.git.alistair.francis@wdc.com>
	<bc29bf08db9e3801a3e833f579d93ee2c86cc49d.1542321076.git.alistair.francis@wdc.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <8b66282e-7a68-4f43-4f17-b00eacd1266d@linaro.org>
Date: Fri, 16 Nov 2018 08:59:51 +0100
MIME-Version: 1.0
In-Reply-To: <bc29bf08db9e3801a3e833f579d93ee2c86cc49d.1542321076.git.alistair.francis@wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC v1 07/23] riscv: tcg-target: Regiser the JIT
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
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> Signed-off-by: Michael Clark <mjc@sifive.com>
> ---
>  tcg/riscv/tcg-target.inc.c | 45 ++++++++++++++++++++++++++++++++++++++
>  1 file changed, 45 insertions(+)

I think this whole patch should be merged with the prologue.  They are
interrelated and it's hard to verify this without the other.

Also, FRAME_SIZE isn't defined yet, so this patch isn't even self-contained.


r~

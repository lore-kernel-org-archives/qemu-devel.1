Received: from eggs.gnu.org ([2001:4830:134:3::10]:57284)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gNhwK-0007XP-Fr
	for qemu-devel@nongnu.org; Fri, 16 Nov 2018 12:29:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gNhwJ-0005ME-C8
	for qemu-devel@nongnu.org; Fri, 16 Nov 2018 12:29:56 -0500
Received: from mail-it1-x141.google.com ([2607:f8b0:4864:20::141]:36462)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gNhwH-0005DR-ER
	for qemu-devel@nongnu.org; Fri, 16 Nov 2018 12:29:53 -0500
Received: by mail-it1-x141.google.com with SMTP id c9so2595450itj.1
	for <qemu-devel@nongnu.org>; Fri, 16 Nov 2018 09:29:21 -0800 (PST)
References: <cover.1542321076.git.alistair.francis@wdc.com>
	<9e9303670bf6210b643b05f9bddf9c52f684173b.1542321076.git.alistair.francis@wdc.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <3ea3567c-1ca0-1853-eebb-7914a750b5a4@linaro.org>
Date: Fri, 16 Nov 2018 18:29:13 +0100
MIME-Version: 1.0
In-Reply-To: <9e9303670bf6210b643b05f9bddf9c52f684173b.1542321076.git.alistair.francis@wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC v1 21/23] tcg: Add RISC-V cpu signal handler
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

On 11/15/18 11:37 PM, Alistair Francis wrote:
> +    /* Detect store by reading the instruction at the program
> +       counter. Note: we currently only generate 32-bit
> +       instructions so we thus only detect 32-bit stores */

Actually, you need to handle what the compiler generates too.  So, if
__riscv_compressed is defined, you need to handle it.


r~

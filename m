Received: from eggs.gnu.org ([209.51.188.92]:37870)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1h0tIE-0002Sk-Ob
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 14:30:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1h0tID-0008Cl-Sy
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 14:30:30 -0500
Received: from mail-pg1-x532.google.com ([2607:f8b0:4864:20::532]:37301)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1h0tID-0008AS-Aj
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 14:30:29 -0500
Received: by mail-pg1-x532.google.com with SMTP id q206so3775451pgq.4
	for <qemu-devel@nongnu.org>; Mon, 04 Mar 2019 11:30:27 -0800 (PST)
References: <20190301214945.4353-1-palmer@sifive.com>
	<CAFEAcA-ZbFf+_Bt4QGu6ZchOZtvizWPR_5pFz4vOVVYAf23mgA@mail.gmail.com>
	<36b17c57-7caf-1e49-d500-bf2eddcd1f25@mail.uni-paderborn.de>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <a652de39-fae2-9885-1197-fbb70b28b7cf@linaro.org>
Date: Mon, 4 Mar 2019 11:30:21 -0800
MIME-Version: 1.0
In-Reply-To: <36b17c57-7caf-1e49-d500-bf2eddcd1f25@mail.uni-paderborn.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PULL] target/riscv: Convert to decodetree
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, Peter Maydell <peter.maydell@linaro.org>, Palmer Dabbelt <palmer@sifive.com>
Cc: "open list:RISC-V" <qemu-riscv@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>

On 3/4/19 4:52 AM, Bastian Koppelmann wrote:
> This looks like an unforeseen decodetree problem (CC' Richard). As these 16/32
> instructions share the same trans_* function, we emit the same typedef once for
> 16 bit and once for 32 bit. I don't see an easy fix in decodetree

Use an argument set, and add !extern to the argument set definition for the
"second" decoder.

(Leastwise I don't think that feature is sitting on the branch...)


r~

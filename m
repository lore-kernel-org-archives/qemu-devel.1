Received: from eggs.gnu.org ([2001:4830:134:3::10]:41791)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bobby.prani@gmail.com>) id 1fwjYV-00079z-TF
	for qemu-devel@nongnu.org; Mon, 03 Sep 2018 03:45:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bobby.prani@gmail.com>) id 1fwjYV-0005P5-2D
	for qemu-devel@nongnu.org; Mon, 03 Sep 2018 03:45:51 -0400
Received: from mail-it0-x230.google.com ([2607:f8b0:4001:c0b::230]:54300)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bobby.prani@gmail.com>)
	id 1fwjYU-0005OP-TR
	for qemu-devel@nongnu.org; Mon, 03 Sep 2018 03:45:50 -0400
Received: by mail-it0-x230.google.com with SMTP id f14-v6so78430ita.4
	for <qemu-devel@nongnu.org>; Mon, 03 Sep 2018 00:45:50 -0700 (PDT)
MIME-Version: 1.0
From: Pranith Kumar <bobby.prani@gmail.com>
Date: Mon, 3 Sep 2018 00:45:23 -0700
Message-ID: <CAJhHMCDR3FVHxO7hfUNbYTM2zsx6Q1CeKfeMjkW0b-En-1Z0Xw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: [Qemu-devel] qemu-riscv64 seg fault
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: mjc@sifive.com
Cc: qemu-devel <qemu-devel@nongnu.org>, Richard Henderson <rth@twiddle.net>

Hi Michael,

qemu-riscv64 seg faults for me on a static binary. You can build the
binary from here: https://github.com/pranith/quickht

$ STATIC=1 RISCV=1 make

$ qemu-riscv64 ./bench -t 1 -u 1
<seg fault>

Thanks,
-- 
Pranith

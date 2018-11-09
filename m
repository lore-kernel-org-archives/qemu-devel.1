Received: from eggs.gnu.org ([2001:4830:134:3::10]:42551)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <palmer@sifive.com>) id 1gLCKX-0002XV-3f
	for qemu-devel@nongnu.org; Fri, 09 Nov 2018 14:20:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <palmer@sifive.com>) id 1gLCKK-0001c2-SX
	for qemu-devel@nongnu.org; Fri, 09 Nov 2018 14:20:27 -0500
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a]:36627)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <palmer@sifive.com>) id 1gLCKI-0001Yi-Na
	for qemu-devel@nongnu.org; Fri, 09 Nov 2018 14:20:20 -0500
Received: by mail-pf1-x42a.google.com with SMTP id d13-v6so1359931pfo.3
	for <qemu-devel@nongnu.org>; Fri, 09 Nov 2018 11:20:16 -0800 (PST)
Date: Fri,  9 Nov 2018 11:19:33 -0800
Message-Id: <20181109191933.6641-1-palmer@sifive.com>
From: Palmer Dabbelt <palmer@sifive.com>
Subject: [Qemu-devel] [PATCH for 3.1] RISC-V: Respect fences for user-only
 emulators
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-riscv@nongnu.org, richard.henderson@linaro.org
Cc: qemu-devel@nongnu.org

I'd like to target this for 3.1: while it's a pretty esoteric bug the
risk of breaking anything is low and tracking down a manifestation of
the bug would be a nightmare.

I don't think the performance improvement alluded to will be a 3.1
candidiate, and as a result I probably won't get around to it until
later.

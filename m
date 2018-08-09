Received: from eggs.gnu.org ([2001:4830:134:3::10]:45714)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1fnsjB-00030a-Ov
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 17:44:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1fnsj8-0000xF-3Y
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 17:44:17 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:51375)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1fnsj7-0000uA-Vp
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 17:44:14 -0400
From: "Emilio G. Cota" <cota@braap.org>
Date: Thu,  9 Aug 2018 17:43:53 -0400
Message-Id: <20180809214356.27690-1-cota@braap.org>
Subject: [Qemu-devel] [PATCH 0/3] target/riscv: use tcg_lookup_and_goto_ptr
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, Michael Clark <mjc@sifive.com>, Palmer Dabbelt <palmer@sifive.com>, Sagar Karandikar <sagark@eecs.berkeley.edu>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>

There are a few more places where the lookup could be inserted,
but I think these are the ones that will matter performance-wise.

Perf results in patch 3's log.

Regarding the benchmarks: I'd have used SPEC06 but I don't have
much time to get it to compile. Is there a guide on how to do so?
Ideally I'd like to use the fedora image, which works very well.

Thanks,

		Emilio

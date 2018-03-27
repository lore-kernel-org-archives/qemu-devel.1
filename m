Received: from eggs.gnu.org ([2001:4830:134:3::10]:45494)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1f0uht-0004y5-He
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 15:56:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1f0uho-0006Id-NX
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 15:56:33 -0400
Received: from mail-pl0-x244.google.com ([2607:f8b0:400e:c01::244]:38950)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mjc@sifive.com>) id 1f0uho-0006IF-H5
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 15:56:28 -0400
Received: by mail-pl0-x244.google.com with SMTP id s24-v6so66430plq.6
	for <qemu-devel@nongnu.org>; Tue, 27 Mar 2018 12:56:28 -0700 (PDT)
From: Michael Clark <mjc@sifive.com>
Date: Tue, 27 Mar 2018 12:55:45 -0700
Message-Id: <1522180547-22956-1-git-send-email-mjc@sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v1 0/2] RISC-V: Important fixes for QEMU 2.12
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>
Cc: patches@groups.riscv.org, Michael Clark <mjc@sifive.com>, Palmer Dabbelt <palmer@sifive.com>, Sagar Karandikar <sagark@eecs.berkeley.edu>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>

This series includes changes that are considered important.
i.e. correct user-visible bugs that are exercised by common
operations such as -cpu list or -d in_asm

Michael Clark (2):
  RISC-V: Convert cpu definition to future model
  RISC-V: Fix incorrect disassembly for addiw

 disas/riscv.c      |   2 +-
 target/riscv/cpu.c | 123 ++++++++++++++++++++++++++++++-----------------------
 2 files changed, 70 insertions(+), 55 deletions(-)

-- 
2.7.0

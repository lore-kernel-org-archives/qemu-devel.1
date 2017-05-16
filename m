Received: from eggs.gnu.org ([2001:4830:134:3::10]:46833)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1dAlFa-0002Hq-6A
	for qemu-devel@nongnu.org; Tue, 16 May 2017 18:47:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1dAlFZ-0005JV-9M
	for qemu-devel@nongnu.org; Tue, 16 May 2017 18:47:30 -0400
Received: from hall.aurel32.net ([2001:bc8:30d7:100::1]:45084)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aurelien@aurel32.net>)
	id 1dAlFZ-0005IX-2r
	for qemu-devel@nongnu.org; Tue, 16 May 2017 18:47:29 -0400
From: Aurelien Jarno <aurelien@aurel32.net>
Date: Wed, 17 May 2017 00:47:16 +0200
Message-Id: <20170516224721.13832-1-aurelien@aurel32.net>
Subject: [Qemu-devel] [PATCH 0/5] target/sh4: system emulation improvement
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Aurelien Jarno <aurelien@aurel32.net>

This patch series fix two issues with the SH4 system emulation:
- reboot does not work when using -kernel and -initrd
- the RTE instruction is not correctly emulated in some very rare
  cases, causing userland processes to receive a segmentation fault.

Aurelien Jarno (5):
  target/sh4: log unauthorized accesses using qemu_log_mask
  target/sh4: fix reset when using a kernel and an initrd
  target/sh4: introduce DELAY_SLOT_MASK
  target/sh4: ignore interrupts in a delay slot
  target/sh4: fix RTE instruction delay slot

 target/sh4/cpu.h       | 12 ++++++++++--
 target/sh4/helper.c    | 28 ++++++++++++++++++++++------
 target/sh4/translate.c | 25 ++++++++++++++-----------
 3 files changed, 46 insertions(+), 19 deletions(-)

-- 
2.11.0

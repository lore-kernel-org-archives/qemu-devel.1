Received: from eggs.gnu.org ([2001:4830:134:3::10]:45741)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1d5JX2-0007Y5-Hq
	for qemu-devel@nongnu.org; Mon, 01 May 2017 18:11:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1d5JX1-0004Dp-KK
	for qemu-devel@nongnu.org; Mon, 01 May 2017 18:11:00 -0400
Received: from hall.aurel32.net ([2001:bc8:30d7:100::1]:57304)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aurelien@aurel32.net>)
	id 1d5JX1-00047Y-E2
	for qemu-devel@nongnu.org; Mon, 01 May 2017 18:10:59 -0400
From: Aurelien Jarno <aurelien@aurel32.net>
Date: Tue,  2 May 2017 00:10:32 +0200
Message-Id: <20170501221046.9369-1-aurelien@aurel32.net>
Subject: [Qemu-devel] [PATCH 00/14] target/sh4: misc fixes,
 cleanup and optimizations
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

This patch series try to improve the SH4 target by using the (more or
less) recently introduced TCG features. It also fixes some issues spot
when writting the patches (linking of TB with different flags, SH4-A
specific instructions allowed on SH4) and correctly trap unaligned
accesses.

Aurelien Jarno (14):
  target/sh4: split ctx->flags into ctx->tbflags and ctx->envflags
  target/sh4: get rid of DELAY_SLOT_CLEARME
  target/sh4: do not include DELAY_SLOT_TRUE in the TB state
  target/sh4: move DELAY_SLOT_TRUE flag into a separate global
  target/sh4: fix BS_STOP exit
  target/sh4: fix BS_EXCP exit
  target/sh4: only save flags state at the end of the TB
  target/sh4: fold ctx->bstate = BS_BRANCH into gen_conditional_jump
  target/sh4: optimize gen_store_fpr64
  target/sh4: optimize gen_write_sr using extract op
  target/sh4: generate fences for SH4
  target/sh4: implement tas.b using atomic helper
  target/sh4: movua.l is an SH4-A only instruction
  target/sh4: trap unaligned accesses

 target/sh4/cpu.c       |   1 +
 target/sh4/cpu.h       |  18 ++-
 target/sh4/helper.c    |   4 +-
 target/sh4/op_helper.c |  19 +++
 target/sh4/translate.c | 323 ++++++++++++++++++++++++-------------------------
 5 files changed, 183 insertions(+), 182 deletions(-)

-- 
2.11.0

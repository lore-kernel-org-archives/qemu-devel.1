Received: from eggs.gnu.org ([2001:4830:134:3::10]:41346)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=7672175d0=jancraig@amazon.com>)
	id 1ftI0o-0006Lg-VJ
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 15:44:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=7672175d0=jancraig@amazon.com>)
	id 1ftI0j-0003v0-1N
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 15:44:50 -0400
Received: from smtp-fw-4101.amazon.com ([72.21.198.25]:1250)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <prvs=7672175d0=jancraig@amazon.com>)
	id 1ftI0i-0003td-OQ
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 15:44:44 -0400
From: Craig Janeczek <jancraig@amazon.com>
Date: Fri, 24 Aug 2018 15:44:01 -0400
Message-Id: <cover.1535133088.git.jancraig@amazon.com>
Subject: [Qemu-devel] [PATCH 0/7] Add limited MXU instruction support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: amarkovic@wavecomp.com, aurelien@aurel32.net, Craig Janeczek <jancraig@amazon.com>

This patch set begins to add MXU instruction support for mips
emulation. The patches are split such that the register overhead
is added first followed by a series of instructions.

Craig Janeczek (7):
  target/mips: Add MXU register support
  target/mips: Add MXU instructions S32I2M and S32M2I
  target/mips: Add MXU instruction S8LDD
  target/mips: Add MXU instruction D16MUL
  target/mips: Add MXU instruction D16MAC
  target/mips: Add MXU instructions Q8MUL and Q8MULSU
  target/mips: Add MXU instructions S32LDD and S32LDDR

 target/mips/cpu.h       |   1 +
 target/mips/translate.c | 401 +++++++++++++++++++++++++++++++++++++++-
 2 files changed, 398 insertions(+), 4 deletions(-)

-- 
2.18.0

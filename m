Received: from eggs.gnu.org ([208.118.235.92]:59958)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=7732fbd28=jancraig@amazon.com>)
	id 1fvSsv-00010D-Fg
	for qemu-devel@nongnu.org; Thu, 30 Aug 2018 15:45:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=7732fbd28=jancraig@amazon.com>)
	id 1fvSha-0008CT-UY
	for qemu-devel@nongnu.org; Thu, 30 Aug 2018 15:34:02 -0400
Received: from smtp-fw-33001.amazon.com ([207.171.190.10]:48467)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <prvs=7732fbd28=jancraig@amazon.com>)
	id 1fvSha-0008CG-LM
	for qemu-devel@nongnu.org; Thu, 30 Aug 2018 15:33:58 -0400
From: Craig Janeczek <jancraig@amazon.com>
Date: Thu, 30 Aug 2018 15:30:10 -0400
Message-Id: <20180830193019.20104-1-jancraig@amazon.com>
Subject: [Qemu-devel] [PATCH v4 0/9] Add limited MXU instruction support
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
emulation.

Craig Janeczek (9):
  target/mips: Introduce MXU registers
  target/mips: Add all MXU opcodes
  target/mips: Split mips instruction handling
  target/mips: Add MXU instructions S32I2M and S32M2I
  target/mips: Add MXU instruction S8LDD
  target/mips: Add MXU instruction D16MUL
  target/mips: Add MXU instruction D16MAC
  target/mips: Add MXU instructions Q8MUL and Q8MULSU
  target/mips: Add MXU instructions S32LDD and S32LDDR

 target/mips/cpu.h       |   2 +
 target/mips/mips-defs.h |   1 +
 target/mips/translate.c | 598 +++++++++++++++++++++++++++++++++++++++-
 3 files changed, 600 insertions(+), 1 deletion(-)

-- 
2.18.0

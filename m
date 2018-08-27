Received: from eggs.gnu.org ([2001:4830:134:3::10]:45307)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=770980de4=jancraig@amazon.com>)
	id 1fuIez-0001zD-CX
	for qemu-devel@nongnu.org; Mon, 27 Aug 2018 10:38:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=770980de4=jancraig@amazon.com>)
	id 1fuIeu-00005a-Pc
	for qemu-devel@nongnu.org; Mon, 27 Aug 2018 10:38:29 -0400
Received: from smtp-fw-6002.amazon.com ([52.95.49.90]:26560)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <prvs=770980de4=jancraig@amazon.com>)
	id 1fuIeu-0008Vj-Ek
	for qemu-devel@nongnu.org; Mon, 27 Aug 2018 10:38:24 -0400
From: Craig Janeczek <jancraig@amazon.com>
Date: Mon, 27 Aug 2018 10:38:00 -0400
Message-Id: <20180827143806.25048-1-jancraig@amazon.com>
Subject: [Qemu-devel] [PATCH v2 0/6] Add limited MXU instruction support
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

Craig Janeczek (6):
  target/mips: Add MXU instructions S32I2M and S32M2I
  target/mips: Add MXU instruction S8LDD
  target/mips: Add MXU instruction D16MUL
  target/mips: Add MXU instruction D16MAC
  target/mips: Add MXU instructions Q8MUL and Q8MULSU
  target/mips: Add MXU instructions S32LDD and S32LDDR

 target/mips/cpu.h       |   1 +
 target/mips/translate.c | 345 +++++++++++++++++++++++++++++++++++++++-
 2 files changed, 342 insertions(+), 4 deletions(-)

-- 
2.18.0

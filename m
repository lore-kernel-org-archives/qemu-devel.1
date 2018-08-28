Received: from eggs.gnu.org ([2001:4830:134:3::10]:52380)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=771b48d5d=jancraig@amazon.com>)
	id 1fudfD-0006Ht-Mb
	for qemu-devel@nongnu.org; Tue, 28 Aug 2018 09:04:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=771b48d5d=jancraig@amazon.com>)
	id 1fudf8-0006F8-KV
	for qemu-devel@nongnu.org; Tue, 28 Aug 2018 09:04:07 -0400
Received: from smtp-fw-33001.amazon.com ([207.171.190.10]:17584)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <prvs=771b48d5d=jancraig@amazon.com>)
	id 1fudf8-0006Eu-Bu
	for qemu-devel@nongnu.org; Tue, 28 Aug 2018 09:04:02 -0400
From: Craig Janeczek <jancraig@amazon.com>
Date: Tue, 28 Aug 2018 09:00:33 -0400
Message-Id: <20180828130041.26445-1-jancraig@amazon.com>
Subject: [Qemu-devel] [PATCH v3 0/8] Add limited MXU instruction support
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

Craig Janeczek (8):
  target/mips: Introduce MXU registers
  target/mips: Add all MXU opcodes
  target/mips: Add MXU instructions S32I2M and S32M2I
  target/mips: Add MXU instruction S8LDD
  target/mips: Add MXU instruction D16MUL
  target/mips: Add MXU instruction D16MAC
  target/mips: Add MXU instructions Q8MUL and Q8MULSU
  target/mips: Add MXU instructions S32LDD and S32LDDR

 target/mips/cpu.h       |   1 +
 target/mips/translate.c | 601 +++++++++++++++++++++++++++++++++++-----
 2 files changed, 540 insertions(+), 62 deletions(-)

-- 
2.18.0

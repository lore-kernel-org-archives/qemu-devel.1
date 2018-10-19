Received: from eggs.gnu.org ([2001:4830:134:3::10]:38600)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gDXiz-00051z-QV
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 12:34:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gDXiw-0006Xb-LO
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 12:34:09 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:54849 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
	id 1gDXiw-0006TX-CY
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 12:34:06 -0400
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Date: Fri, 19 Oct 2018 18:33:34 +0200
Message-Id: <1539966828-20947-1-git-send-email-aleksandar.markovic@rt-rk.com>
Subject: [Qemu-devel] [PATCH v5 00/14] Add limited MXU instruction support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: aurelien@aurel32.net, richard.henderson@linaro.org, jancraig@amazon.com, amarkovic@wavecomp.com, smarkovic@wavecomp.com, pjovanovic@wavecomp.com

From: Aleksandar Markovic <amarkovic@wavecomp.com>

This patch set begins to add MXU instruction support for
MIPS emulation.

v4->v5:

  - added full decoding engine for MXU ASE
  - changes on aptn2, optn2, optn3 are now stand-alone patches
  - all patches on individual instructions are reworked to fit
    new decoding engine, and also cosmetically improved
  - rebased to the latest code

Aleksandar Markovic (2):
  target/mips: Add and integrate MXU decoding engine placeholder
  target/mips: Add MXU decoding engine

Craig Janeczek (12):
  target/mips: Introduce MXU registers
  target/mips: Define a bit for MXU in insn_flags
  target/mips: Add bit encoding for MXU add/subtract patterns 'aptn2'
  target/mips: Add bit encoding for MXU operand getting patterns 'optn2'
  target/mips: Add bit encoding for MXU operand getting patterns 'optn3'
  target/mips: Add emulation of non-MXU MULL within MXU decoding engine
  target/mips: Add emulation of MXU instructions S32I2M and S32M2I
  target/mips: Add emulation of MXU instruction S8LDD
  target/mips: Add emulation of MXU instruction D16MUL
  target/mips: Add emulation of MXU instruction D16MAC
  target/mips: Add emulation of MXU instructions Q8MUL and Q8MULSU
  target/mips: Add emulation of MXU instructions S32LDD and S32LDDR

 target/mips/cpu.h       |   10 +
 target/mips/mips-defs.h |    1 +
 target/mips/translate.c | 1979 +++++++++++++++++++++++++++++++++++++++++++----
 3 files changed, 1834 insertions(+), 156 deletions(-)

-- 
2.7.4

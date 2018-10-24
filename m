Received: from eggs.gnu.org ([2001:4830:134:3::10]:58414)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gFI7s-0008On-2V
	for qemu-devel@nongnu.org; Wed, 24 Oct 2018 08:19:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gFI7n-0002BG-4x
	for qemu-devel@nongnu.org; Wed, 24 Oct 2018 08:19:04 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:38252 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
	id 1gFI7m-00028h-RN
	for qemu-devel@nongnu.org; Wed, 24 Oct 2018 08:18:59 -0400
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Date: Wed, 24 Oct 2018 14:18:27 +0200
Message-Id: <1540383527-7923-1-git-send-email-aleksandar.markovic@rt-rk.com>
Subject: [Qemu-devel] [PATCH v7 00/20] target/mips: Add limited support for
 Ingenic's MXU ASE
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

This patch set begins to add MXU ASE instruction support.

v6->v7:

  - move MXU_EN check to the main MXU decoding function
  - amend MXU ASE overview note

v5->v6:

  - added bit definitions for 'aptn1' and 'eptn2'. 
  - pool04 eliminated, since it is covered by a single instruction.
  - moved MUL, S32M2I, S32I2M handling out of main MXU switch.
  - rebased to the latest code (this series applies on top of
    the current MIPS pull request)

v4->v5:

  - added full decoding engine for MXU ASE
  - changes on aptn2, optn2, optn3 are now stand-alone patches
  - all patches on individual instructions are reworked to fit
    new decoding engine, and also cosmetically improved
  - rebased to the latest code

Aleksandar Markovic (8):
  target/mips: Amend MXU instruction opcodes
  target/mips: Add and integrate MXU decoding engine placeholder
  target/mips: Add MXU decoding engine
  target/mips: Add bit encoding for MXU accumulate add/sub 1-bit pattern
    'aptn1'
  target/mips: Add bit encoding for MXU execute add/sub pattern 'eptn2'
  target/mips: Move MUL, S32M2I, S32I2M handling out of main MXU switch
  target/mips: Move MXU_EN check one level higher
  target/mips: Amend MXU ASE overview note

Craig Janeczek (12):
  target/mips: Introduce MXU registers
  target/mips: Define a bit for MXU in insn_flags
  target/mips: Add bit encoding for MXU accumulate add/sub 2-bit pattern
    'aptn2'
  target/mips: Add bit encoding for MXU operand getting pattern 'optn2'
  target/mips: Add bit encoding for MXU operand getting pattern 'optn3'
  target/mips: Add emulation of non-MXU MULL within MXU decoding engine
  target/mips: Add emulation of MXU instructions S32I2M and S32M2I
  target/mips: Add emulation of MXU instruction S8LDD
  target/mips: Add emulation of MXU instruction D16MUL
  target/mips: Add emulation of MXU instruction D16MAC
  target/mips: Add emulation of MXU instructions Q8MUL and Q8MULSU
  target/mips: Add emulation of MXU instructions S32LDD and S32LDDR

 target/mips/cpu.h       |   10 +
 target/mips/mips-defs.h |    1 +
 target/mips/translate.c | 2084 ++++++++++++++++++++++++++++++++++++++++++-----
 3 files changed, 1886 insertions(+), 209 deletions(-)

-- 
2.7.4

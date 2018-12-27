Received: from eggs.gnu.org ([208.118.235.92]:47553)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gcWZP-0001Fi-C1
	for qemu-devel@nongnu.org; Thu, 27 Dec 2018 09:23:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gcWZK-0000z6-Es
	for qemu-devel@nongnu.org; Thu, 27 Dec 2018 09:23:31 -0500
Received: from mx2.rt-rk.com ([89.216.37.149]:51021 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
	id 1gcWZK-0000ws-2M
	for qemu-devel@nongnu.org; Thu, 27 Dec 2018 09:23:26 -0500
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Date: Thu, 27 Dec 2018 15:22:40 +0100
Message-Id: <1545920586-17815-1-git-send-email-aleksandar.markovic@rt-rk.com>
Subject: [Qemu-devel] [PATCH v6 00/26] disas: nanoMIPS: Clean up several
 issues
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: aurelien@aurel32.net, amarkovic@wavecomp.com, smarkovic@wavecomp.com, arikalo@wavecomp.com

From: Aleksandar Markovic <amarkovic@wavecomp.com>

Clean up several misc issues in nanoMIPS disassembler. There are
more issues to be cleaned, and this is meant to be just the first
phase. Complete cleanup should happen over the course of next
few months.

All these changes should not and do not affect any functionality.

v5->v6:

  - patches that deal with adding format specifiers [16] and [49]
    removed, until we determine what is the most appropriate form,
    and how to be more in sync with objdump output and inline
    assembler allowed formats
  - added 14 patches on reformating grp decoders
  - added a patch that adds documentation as reference

v4->v5:

  - renamed patch "Fix comments for 48-bit instructions" to
      "Clean up handling of 48-bit instructions"
  - added patch "Clean up handling of 16-bit logic instructions"
  - added eight patches on improving gpr decoders
  - minor addition to patch "Fix order of more invocations"
  - minor cleanups of previous commit messages

v3->v4:

  - added patch "Name more functions in a more descriptive way"
  - added patch "Fix order of more invocations"
  - added patch "Fix comments for 48-bit instructions"
  - minor cleanups of previous commit messages

v2->v3:

  - added three patches that fix function misnomers.
  - minor changes in commit messages.

v1->v2:

  - patch 5 was somehow lost in v1, now should be fine.

Aleksandar Markovic (26):
  disas: nanoMIPS: Fix preamble text in nanomips.* files
  disas: nanoMIPS: Remove functions that are not used
  disas: nanoMIPS: Fix a function misnomer
  disas: nanoMIPS: Fix order of some invocations
  disas: nanoMIPS: Name some functions in a more descriptive way
  disas: nanoMIPS: Fix an FP-related misnomer 1
  disas: nanoMIPS: Fix an FP-related misnomer 2
  disas: nanoMIPS: Fix an FP-related misnomer 3
  disas: nanoMIPS: Name more functions in a more descriptive way
  disas: nanoMIPS: Fix order of more invocations
  disas: nanoMIPS: Rename the decoder of 'gpr3' gpr encoding type
  disas: nanoMIPS: Comment the decoder of 'gpr3' gpr encoding type
  disas: nanoMIPS: Rename the decoder of 'gpr3.src.store' gpr encoding
    type
  disas: nanoMIPS: Comment the decoder of 'gpr3.src.store' gpr encoding
    type
  disas: nanoMIPS: Rename the decoder of 'gpr4' gpr encoding type
  disas: nanoMIPS: Comment the decoder of 'gpr4' gpr encoding type
  disas: nanoMIPS: Rename the decoder of 'gpr4.zero' gpr encoding type
  disas: nanoMIPS: Comment the decoder of 'gpr4.zero' gpr encoding type
  disas: nanoMIPS: Rename the decoder of 'gpr2.reg1' gpr encoding type
  disas: nanoMIPS: Comment the decoder of 'gpr2.reg1' gpr encoding type
  disas: nanoMIPS: Rename the decoder of 'gpr2.reg2' gpr encoding type
  disas: nanoMIPS: Comment the decoder of 'gpr2.reg2' gpr encoding type
  disas: nanoMIPS: Rename the decoder of 'gpr1' gpr encoding type
  disas: nanoMIPS: Comment the decoder of 'gpr1' gpr encoding type
  disas: nanoMIPS: Reorder declarations and definitions of gpr decoders
  disas: nanoMIPS: Add a note on documentation

 disas/nanomips.cpp | 2135 ++++++++++++++++++++++++++--------------------------
 disas/nanomips.h   |  115 ++-
 2 files changed, 1111 insertions(+), 1139 deletions(-)

-- 
2.7.4

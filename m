Received: from eggs.gnu.org ([208.118.235.92]:56954)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gc72S-0007uz-5b
	for qemu-devel@nongnu.org; Wed, 26 Dec 2018 06:07:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gc72N-0001lR-7l
	for qemu-devel@nongnu.org; Wed, 26 Dec 2018 06:07:48 -0500
Received: from mx2.rt-rk.com ([89.216.37.149]:53880 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
	id 1gc72N-00014s-0s
	for qemu-devel@nongnu.org; Wed, 26 Dec 2018 06:07:43 -0500
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Date: Wed, 26 Dec 2018 12:06:08 +0100
Message-Id: <1545822388-10911-1-git-send-email-aleksandar.markovic@rt-rk.com>
Subject: [Qemu-devel] [PATCH v5 00/20] disas: nanoMIPS: Clean up several
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
Cc: aurelien@aurel32.net, amarkovic@wavecomp.com, smarkovic@wavecomp.com

From: Aleksandar Markovic <amarkovic@wavecomp.com>

Clean up several misc issues in nanoMIPS disassembler. There are
more issues to be cleaned, and this is meant to be just the first
phase. Complete cleanup should happen over the course of next
few months.

All these changes should not and do not affect any functionality.

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

Aleksandar Markovic (20):
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
  disas: nanoMIPS: Clean up handling of 48-bit instructions
  disas: nanoMIPS: Clean up handling of 16-bit logic instructions
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

 disas/nanomips.cpp | 2156 +++++++++++++++++++++++++---------------------------
 disas/nanomips.h   |  108 +--
 2 files changed, 1079 insertions(+), 1185 deletions(-)

-- 
2.7.4

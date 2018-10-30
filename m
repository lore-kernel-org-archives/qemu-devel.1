Received: from eggs.gnu.org ([2001:4830:134:3::10]:34213)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gHSLX-0006Vo-Ix
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 07:38:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gHSLS-0007eS-EX
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 07:38:07 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:43064 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
	id 1gHSLS-0006cz-4H
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 07:38:02 -0400
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Date: Tue, 30 Oct 2018 12:36:46 +0100
Message-Id: <1540899411-16761-1-git-send-email-aleksandar.markovic@rt-rk.com>
Subject: [Qemu-devel] [PATCH v2 0/5] target/mips: Renaming and limiting
 modes for R5900
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: aurelien@aurel32.net, amarkovic@wavecomp.com, smarkovic@wavecomp.com, pjovanovic@wavecomp.com

From: Aleksandar Markovic <amarkovic@wavecomp.com>

Rename some code elements related to R5900, and limit supported modes
to O32.

v1->v2:

  - added limiting of supported modes
  - added more cosmetic changes

Aleksandar Markovic (5):
  target/mips: Rename MMI-related masks
  target/mips: Rename MMI-related opcodes
  target/mips: Rename MMI-related functions
  target/mips: Misc R5900-related cosmetic changes
  target/mips: Enable only tested modes for R5900

 target/mips/translate.c          | 532 +++++++++++++++++++--------------------
 target/mips/translate_init.inc.c |  16 +-
 2 files changed, 270 insertions(+), 278 deletions(-)

-- 
2.7.4

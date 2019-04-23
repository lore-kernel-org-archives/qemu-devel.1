Received: from eggs.gnu.org ([209.51.188.92]:36425)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1hItda-0001cr-35
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 07:30:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1hItdZ-0005W2-5G
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 07:30:58 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:41149 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
	id 1hItdY-0004AY-TO
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 07:30:57 -0400
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Date: Tue, 23 Apr 2019 13:29:34 +0200
Message-Id: <1556018982-3715-1-git-send-email-aleksandar.markovic@rt-rk.com>
Subject: [Qemu-devel] [PATCH 0/8] target/mips: Clean up misc code segments
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: aurelien@aurel32.net, amarkovic@wavecomp.com, arikalo@wavecomp.com

From: Aleksandar Markovic <amarkovic@wavecomp.com>

This series removes a number of checkpatch errors and warnings
to improve code readibility and maintainability.

Aleksandar Markovic (4):
  target/mips: Clean up dsp_helper.c
  target/mips: Clean up lmi_helper.c
  target/mips: Fix some space checkpatch errors in translate.c
  target/mips: Fix if-else arms checkpatch errors in translate.c

Jules Irenge (4):
  target/mips: Add or remove space to fix checkpatch errors
  target/mips: Realign comments to fix checkpatch warnings
  target/mips: Remove a space before open parenthesis to fix checkpatch
    errors
  target/mips: Add * to comments and realign them to fix checkpatch
    warnings

 target/mips/cp0_timer.c  |  26 +++---
 target/mips/cpu.h        | 211 ++++++++++++++++++++++-------------------
 target/mips/dsp_helper.c |  40 +++++---
 target/mips/lmi_helper.c |   8 +-
 target/mips/translate.c  | 238 +++++++++++++++++++++++++++--------------------
 5 files changed, 301 insertions(+), 222 deletions(-)

-- 
2.7.4

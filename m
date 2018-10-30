Received: from eggs.gnu.org ([2001:4830:134:3::10]:50004)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gHXp1-0001Cn-2y
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 13:28:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gHXot-0002nz-Gp
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 13:28:54 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:44221 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
	id 1gHXot-0002iG-3E
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 13:28:47 -0400
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Date: Tue, 30 Oct 2018 18:28:13 +0100
Message-Id: <1540920498-5133-1-git-send-email-aleksandar.markovic@rt-rk.com>
Subject: [Qemu-devel] [PULL 0/5] MIPS queue for October 2018, part 5
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, amarkovic@wavecomp.com

From: Aleksandar Markovic <amarkovic@wavecomp.com>

The following changes since commit 3f3285491dd52014852a56135c90e428c8b507ea:

  Merge remote-tracking branch 'remotes/jnsnow/tags/bitmaps-pull-request' into staging (2018-10-30 14:09:25 +0000)

are available in the git repository at:

  https://github.com/AMarkovic/qemu tags/mips-queue-october-2018-part-5

for you to fetch changes up to 12ccc41b192a0a65e9379bafa947d1ed7de79750:

  target/mips: Enable only tested modes for R5900 (2018-10-30 18:17:17 +0100)

----------------------------------------------------------------
MIPS queue for October 2018, part 5

  - some cleanup of R5900 support
----------------------------------------------------------------
Aleksandar Markovic (5):
  target/mips: Rename MMI-related masks
  target/mips: Rename MMI-related opcodes
  target/mips: Rename MMI-related functions
  target/mips: Remove some spurious R5900-related comments
  target/mips: Enable only tested modes for R5900

 target/mips/translate.c          | 533 ++++++++++++++++++++-------------------
 target/mips/translate_init.inc.c |  16 +-
 2 files changed, 271 insertions(+), 278 deletions(-)

-- 
2.7.4

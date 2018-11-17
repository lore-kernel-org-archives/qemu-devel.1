Received: from eggs.gnu.org ([2001:4830:134:3::10]:44448)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gO2x0-0003xD-KL
	for qemu-devel@nongnu.org; Sat, 17 Nov 2018 10:56:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gO2wx-0000fg-5O
	for qemu-devel@nongnu.org; Sat, 17 Nov 2018 10:56:02 -0500
Received: from mx2.rt-rk.com ([89.216.37.149]:60326 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
	id 1gO2ww-00077N-UU
	for qemu-devel@nongnu.org; Sat, 17 Nov 2018 10:55:59 -0500
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Date: Sat, 17 Nov 2018 16:54:29 +0100
Message-Id: <1542470080-5797-1-git-send-email-aleksandar.markovic@rt-rk.com>
Subject: [Qemu-devel] [PULL 00/11] MIPS queue for November 2018 (for QEMU
 3.1-rc2)
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

The following changes since commit 83c496599cc04926ecbc3e47a37debaa3e38b686:

  Merge remote-tracking branch 'remotes/kraxel/tags/fixes-31-20181116-pull-request' into staging (2018-11-16 13:53:01 +0000)

are available in the git repository at:

  https://github.com/AMarkovic/qemu tags/mips-queue-november-2018

for you to fetch changes up to b6ac8eed1ca277a6ed59a61bb7bd4785190990f6:

  MAINTAINERS: Add Stefan Markovic as a MIPS reviewer (2018-11-17 16:17:08 +0100)

----------------------------------------------------------------
MIPS queue for November 2018

  - fix MIPS-specific prctl() handling in linux-user
  - fix some issues of R5900 support
  - update MAINTAINERS wrt. MIPS reviewer

----------------------------------------------------------------

Aleksandar Markovic (5):
  target/mips: Rename MMI-related masks
  target/mips: Rename MMI-related opcodes
  target/mips: Rename MMI-related functions
  target/mips: Disable R5900 support
  MAINTAINERS: Add Stefan Markovic as a MIPS reviewer

Fredrik Noring (5):
  target/mips: Fix decoding mechanism of R5900 MFLO1, MFHI1, MTLO1 and
    MTHI1
  target/mips: Fix decoding mechanism of R5900 DIV1 and DIVU1
  target/mips: Fix decoding mechanism of special R5900 opcodes
  target/mips: Guard check_insn_opc_user_only with INSN_R5900 check
  target/mips: Guard check_insn with INSN_R5900 check

Stefan Markovic (1):
  linux-user: Update MIPS specific prctl() implementation

 MAINTAINERS                      |   9 +
 linux-user/syscall.c             |  18 +
 target/mips/translate.c          | 707 +++++++++++++++++++++++----------------
 target/mips/translate_init.inc.c |  59 ----
 4 files changed, 450 insertions(+), 343 deletions(-)

-- 
2.7.4

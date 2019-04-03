Received: from eggs.gnu.org ([209.51.188.92]:46157)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Sandra_Loosemore@mentor.com>) id 1hBlwy-0003HU-Qn
	for qemu-devel@nongnu.org; Wed, 03 Apr 2019 15:53:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Sandra_Loosemore@mentor.com>) id 1hBlww-0001ku-PJ
	for qemu-devel@nongnu.org; Wed, 03 Apr 2019 15:53:32 -0400
Received: from relay1.mentorg.com ([192.94.38.131]:43845)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <Sandra_Loosemore@mentor.com>)
	id 1hBlwr-0001Vk-1i
	for qemu-devel@nongnu.org; Wed, 03 Apr 2019 15:53:27 -0400
From: Sandra Loosemore <sandra@codesourcery.com>
Date: Wed, 3 Apr 2019 13:53:03 -0600
Message-ID: <1554321185-2825-1-git-send-email-sandra@codesourcery.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v7 0/2] Nios II generic board config and
 semihosting
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: crwulff@gmail.com, marex@denx.de, peter.maydell@linaro.org

This is the seventh version of the patch series last posted here:
http://lists.nongnu.org/archive/html/qemu-devel/2019-03/msg06255.html

Changes since v6:
- Fixed block comment formatting for QEMU style.
- Fixed fixme for interrupt handler (now added to libgloss BSP).
- Added link to libgloss semihosting documentation.

Sandra Loosemore (2):
  Add generic Nios II board.
  Add Nios II semihosting support.

 default-configs/nios2-softmmu.mak |   1 +
 hw/nios2/Kconfig                  |   4 +
 hw/nios2/Makefile.objs            |   1 +
 hw/nios2/boot.c                   |  18 +-
 hw/nios2/generic_nommu.c          | 105 +++++++++
 qemu-options.hx                   |   8 +-
 target/nios2/Makefile.objs        |   2 +-
 target/nios2/cpu.h                |   4 +-
 target/nios2/helper.c             |  13 ++
 target/nios2/nios2-semi.c         | 455 ++++++++++++++++++++++++++++++++++++++
 10 files changed, 599 insertions(+), 12 deletions(-)
 create mode 100644 hw/nios2/generic_nommu.c
 create mode 100644 target/nios2/nios2-semi.c

-- 
2.8.1

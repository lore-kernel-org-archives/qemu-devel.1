Received: from eggs.gnu.org ([209.51.188.92]:56629)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Sandra_Loosemore@mentor.com>) id 1gtljZ-0007Zn-QB
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 23:01:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Sandra_Loosemore@mentor.com>) id 1gtlZQ-00030l-I6
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 22:50:49 -0500
Received: from relay1.mentorg.com ([192.94.38.131]:38750)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <Sandra_Loosemore@mentor.com>)
	id 1gtlZO-0002is-66
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 22:50:46 -0500
From: Sandra Loosemore <sandra@codesourcery.com>
Date: Tue, 12 Feb 2019 20:45:58 -0700
Message-ID: <1550029560-30530-1-git-send-email-sandra@codesourcery.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v5 0/2] Nios II generic board config and
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
Cc: marex@denx.de

This is the fifth version of the patch series last posted here:

http://lists.nongnu.org/archive/html/qemu-devel/2018-08/msg01987.html

Since the previous version, I've updated the copyrights on the new
files, refreshed the patches against current trunk, and fixed bugs in
the implementations of lseek() and gettimeofday().

The original version of these patches was rejected because there was
no corresponding open-source BSP or I/O library support, making it
difficult to test the code.  I contributed those pieces to libgloss
last summer (commit fddc74d12bf7f765c04c3182a7237ecf23893d27), so that
should no longer be a blocking issue.

Sandra Loosemore (2):
  Add generic Nios II board.
  Add Nios II semihosting support.

 default-configs/nios2-softmmu.mak |   1 +
 hw/nios2/Makefile.objs            |   1 +
 hw/nios2/boot.c                   |   5 +-
 hw/nios2/generic_nommu.c          | 130 +++++++++++
 qemu-options.hx                   |   8 +-
 target/nios2/Makefile.objs        |   2 +-
 target/nios2/cpu.h                |   4 +-
 target/nios2/helper.c             |  11 +
 target/nios2/nios2-semi.c         | 446 ++++++++++++++++++++++++++++++++++++++
 9 files changed, 601 insertions(+), 7 deletions(-)
 create mode 100644 hw/nios2/generic_nommu.c
 create mode 100644 target/nios2/nios2-semi.c

-- 
2.8.1

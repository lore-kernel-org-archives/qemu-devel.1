Received: from eggs.gnu.org ([209.51.188.92]:59742)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1gn9cm-0005EA-2c
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 17:06:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1gn9ck-0006ZY-84
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 17:06:55 -0500
Received: from mx1.redhat.com ([209.132.183.28]:23772)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jsnow@redhat.com>) id 1gn9ci-0006Xt-85
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 17:06:53 -0500
From: John Snow <jsnow@redhat.com>
Date: Fri, 25 Jan 2019 17:06:40 -0500
Message-Id: <20190125220648.28164-1-jsnow@redhat.com>
Subject: [Qemu-devel] [PULL 0/8] Ide patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, jsnow@redhat.com

The following changes since commit ad7a21e81231ae64540310384fb0f87ac8758b02:

  Merge remote-tracking branch 'remotes/ehabkost/tags/python-next-pull-request' into staging (2019-01-25 17:22:20 +0000)

are available in the Git repository at:

  https://github.com/jnsnow/qemu.git tags/ide-pull-request

for you to fetch changes up to 4ea98d317eb442c738f898f16cfdd47a18b7ca49:

  ide/via: Implement and use native PCI IDE mode (2019-01-25 14:52:12 -0500)

----------------------------------------------------------------
Pull request

----------------------------------------------------------------

BALATON Zoltan (8):
  cmd646: Remove unused variable
  cmd646: Remove IDEBus from CMD646BAR
  cmd646: Move PCI IDE specific functions to ide/pci.c
  ide: Get rid of CMD646BAR struct
  sii3112: Remove duplicated code and use PCI IDE ops instead
  ide/via: Remove vt82c686b_init_ports() function
  ide/via: Rename functions to match device name
  ide/via: Implement and use native PCI IDE mode

 hw/ide/cmd646.c         | 102 +++++++---------------------------------
 hw/ide/pci.c            |  65 +++++++++++++++++++++++++
 hw/ide/sii3112.c        |  52 ++++----------------
 hw/ide/via.c            |  87 ++++++++++++++++++++--------------
 hw/mips/mips_fulong2e.c |   2 +-
 include/hw/ide.h        |   2 +-
 include/hw/ide/pci.h    |  14 ++----
 7 files changed, 148 insertions(+), 176 deletions(-)

-- 
2.17.2

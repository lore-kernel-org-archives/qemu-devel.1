Received: from eggs.gnu.org ([2001:4830:134:3::10]:57631)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1ecfCf-0007jv-RU
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 17:32:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1ecfCd-0005FZ-9k
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 17:32:05 -0500
Received: from mx1.redhat.com ([209.132.183.28]:37024)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jsnow@redhat.com>) id 1ecfCd-0005DY-3l
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 17:32:03 -0500
From: John Snow <jsnow@redhat.com>
Date: Fri, 19 Jan 2018 17:31:55 -0500
Message-Id: <20180119223159.29890-1-jsnow@redhat.com>
Subject: [Qemu-devel] [PULL 0/4] Ide patches
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

The following changes since commit b384cd95eb9c6f73ad84ed1bb0717a26e29cc78f:

  Merge remote-tracking branch 'remotes/ehabkost/tags/machine-next-pull-request' into staging (2018-01-19 16:35:25 +0000)

are available in the Git repository at:

  https://github.com/jnsnow/qemu.git tags/ide-pull-request

for you to fetch changes up to 3161906df88a471b09c38fff9a618ff83beea0c3:

  hw/ide: Remove duplicated definitions from ahci_internal.h (2018-01-19 16:04:57 -0500)

----------------------------------------------------------------

----------------------------------------------------------------

Anton Nefedov (3):
  ide: pass IDEState to trim AIO callback
  ide: move ide_sect_range_ok() up
  ide: abort TRIM operation for invalid range

John Snow (1):
  hw/ide: Remove duplicated definitions from ahci_internal.h

 hw/ide/ahci_internal.h |  4 ----
 hw/ide/core.c          | 53 +++++++++++++++++++++++++++++++-------------------
 include/hw/ide/ahci.h  |  6 ------
 3 files changed, 33 insertions(+), 30 deletions(-)

-- 
2.14.3

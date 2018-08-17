Received: from eggs.gnu.org ([2001:4830:134:3::10]:57532)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fqjW4-0000wW-OI
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 14:30:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fqjW1-000698-FZ
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 14:30:32 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59034)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1fqjW1-000690-A4
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 14:30:29 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Fri, 17 Aug 2018 15:30:23 -0300
Message-Id: <20180817183026.32662-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PULL 0/3] Machine queue, 2018-08-17
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Eduardo Habkost <ehabkost@redhat.com>

The following changes since commit bb16c0412a572c2c9cd44496deb3ad430bc49c1a:

  Merge remote-tracking branch 'remotes/pmaydell/tags/pull-target-arm-20180816' into staging (2018-08-16 14:35:50 +0100)

are available in the Git repository at:

  git://github.com/ehabkost/qemu.git tags/machine-next-pull-request

for you to fetch changes up to 907aac2f6af6ef775367c368b87cc1720e39d407:

  fw_cfg: ignore suffixes in the bootdevice list dependent on machine class (2018-08-16 22:27:43 -0300)

----------------------------------------------------------------
Machine queue, 2018-08-17

* Allow machine classes to specify if boot device suffixes should
  be ignored by get_boot_devices_list()
* Tiny coding style fixup

----------------------------------------------------------------

Queue for Machine Core patches


Dou Liyang (1):
  machine: Fix coding style at machine_run_board_init()

Mark Cave-Ayland (2):
  sysbus: always allow explicit_ofw_unit_address() to override address
    generation
  fw_cfg: ignore suffixes in the bootdevice list dependent on machine
    class

 include/hw/boards.h     |  1 +
 include/sysemu/sysemu.h |  2 +-
 bootdevice.c            |  5 ++++-
 hw/core/machine.c       |  3 ++-
 hw/core/sysbus.c        | 15 +++++++--------
 hw/nvram/fw_cfg.c       |  2 +-
 hw/ppc/spapr.c          |  3 ++-
 7 files changed, 18 insertions(+), 13 deletions(-)

-- 
2.18.0.rc1.1.g3f1ff2140

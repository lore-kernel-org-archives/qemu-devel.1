Received: from eggs.gnu.org ([2001:4830:134:3::10]:38978)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1cdKlq-0003Pa-T5
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 12:50:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1cdKlp-0005so-Ft
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 12:50:38 -0500
Received: from mx1.redhat.com ([209.132.183.28]:42476)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1cdKlp-0005sS-0B
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 12:50:37 -0500
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Mon, 13 Feb 2017 17:50:19 +0000
Message-Id: <20170213175033.7314-1-dgilbert@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 00/14] migration queue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: quintela@redhat.com, ashijeetacharya@gmail.com, amit@kernel.org, pbutsykin@virtuozzo.com, zhang.zhanghailiang@huawei.com

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

The following changes since commit df96bfab49dab2d0373e49b51bbb51ce72e160=
1e:

  Merge remote-tracking branch 'remotes/kraxel/tags/pull-vga-20170213-1' =
into staging (2017-02-13 10:54:49 +0000)

are available in the git repository at:

  git://github.com/dagrh/qemu.git tags/pull-migration-20170213a

for you to fetch changes up to 982b78c5e37864c06fd7b5f156d80bf02628a855:

  virtio/migration: Migrate virtio-net to VMState (2017-02-13 17:27:14 +0=
000)

----------------------------------------------------------------
Migration

  Amit: migration: remove myself as maintainer
        MAINTAINERS: update my email address
  Ashijeet: migrate: Introduce zero RAM checks to skip RAM migration
  Pavel: Postcopy release RAM
  Halil: consolidate VMStateField.start
  Hailiang: COLO: fix setting checkpoint-delay not working properly
         COLO: Shutdown related socket fd while do failover
         COLO: Don't process failover request while loading VM's state
  Me:
     migration: Add VMSTATE_UNUSED_VARRAY_UINT32
     migration: Add VMSTATE_WITH_TMP
     tests/migration: Add test for VMSTATE_WITH_TMP
     virtio-net VMState conversion and new VMSTATE macros

----------------------------------------------------------------
Amit Shah (2):
      migration: remove myself as maintainer
      MAINTAINERS: update my email address

Ashijeet Acharya (1):
      migrate: Introduce zero RAM checks to skip RAM migration

Dr. David Alan Gilbert (4):
      migration: Add VMSTATE_UNUSED_VARRAY_UINT32
      migration: Add VMSTATE_WITH_TMP
      tests/migration: Add test for VMSTATE_WITH_TMP
      virtio/migration: Migrate virtio-net to VMState

Halil Pasic (1):
      migration: consolidate VMStateField.start

Pavel Butsykin (3):
      migration: add MigrationState arg for ram_save_/compressed_/page()
      add 'release-ram' migrate capability
      migration: discard non-dirty ram pages after the start of postcopy

zhanghailiang (3):
      COLO: fix setting checkpoint-delay not working properly
      COLO: Shutdown related socket fd while do failover
      COLO: Don't process failover request while loading VM's state

 MAINTAINERS                    |   5 +-
 hw/char/exynos4210_uart.c      |   2 +-
 hw/display/g364fb.c            |   2 +-
 hw/dma/pl330.c                 |   8 +-
 hw/intc/exynos4210_gic.c       |   2 +-
 hw/ipmi/isa_ipmi_bt.c          |   6 +-
 hw/net/virtio-net.c            | 316 +++++++++++++++++++++++++++--------=
------
 hw/net/vmxnet3.c               |   2 +-
 hw/nvram/mac_nvram.c           |   2 +-
 hw/nvram/spapr_nvram.c         |   2 +-
 hw/sd/sdhci.c                  |   2 +-
 hw/timer/m48t59.c              |   2 +-
 include/hw/virtio/virtio-net.h |   4 +-
 include/migration/colo.h       |   2 +
 include/migration/migration.h  |  10 ++
 include/migration/qemu-file.h  |   3 +-
 include/migration/vmstate.h    |  51 +++++--
 migration/colo.c               | 102 +++++++++++--
 migration/migration.c          |  16 +++
 migration/qemu-file.c          |  59 +++++++-
 migration/ram.c                |  78 ++++++++--
 migration/savevm.c             |   2 +-
 migration/vmstate.c            |  44 +++++-
 qapi-schema.json               |   9 +-
 target/s390x/machine.c         |   2 +-
 tests/test-vmstate.c           |  98 ++++++++++++-
 util/fifo8.c                   |   2 +-
 27 files changed, 648 insertions(+), 185 deletions(-)

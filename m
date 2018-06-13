Received: from eggs.gnu.org ([2001:4830:134:3::10]:49240)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fSxyN-0005HQ-5t
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 01:05:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fSxyI-00027R-7s
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 01:05:31 -0400
From: Thomas Huth <thuth@redhat.com>
Date: Wed, 13 Jun 2018 07:05:17 +0200
Message-Id: <1528866321-23886-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [PATCH 0/4] Clean up accelerator options
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Ben Warren <ben@skyportsystems.com>, zhang.zhanghailiang@huawei.com, Markus Armbruster <armbru@redhat.com>, qemu-trivial@nongnu.org

The current state of the accelerator options is quite messy: There are
three ways of enabling an accelerator (-machine accel=xyz, -accel xyz
and -enable-xyz) and this can be very confusing for the users. This
patch series now tries to standardize our documentation and examples
on the preferred -accel option.

Thomas Huth (4):
  Replace '-machine accel=xyz' with '-accel xyz'
  Replace '-enable-kvm' with '-accel kvm' in docs and help texts
  qemu-options: Improve the documentation of '-accel' and '-machine
    accel=...'
  qemu-options: Do not show -enable-kvm and -enable-hax in the docs
    anymore

 docs/COLO-FT.txt                    |  8 +++----
 docs/can.txt                        |  4 ++--
 docs/multi-thread-compression.txt   |  2 +-
 docs/multiseat.txt                  |  2 +-
 docs/specs/tpm.txt                  |  8 +++----
 hw/block/dataplane/virtio-blk.c     |  4 ++--
 hw/scsi/virtio-scsi-dataplane.c     |  4 ++--
 qemu-doc.texi                       |  3 +--
 qemu-options.hx                     | 44 ++++++++++++-------------------------
 scripts/qtest.py                    |  2 +-
 tests/bios-tables-test.c            |  2 +-
 tests/boot-serial-test.c            |  2 +-
 tests/libqtest.c                    |  2 +-
 tests/migration-test.c              |  8 +++----
 tests/migration/guestperf/engine.py |  2 +-
 tests/pnv-xscom-test.c              |  2 +-
 tests/prom-env-test.c               |  2 +-
 tests/pxe-test.c                    |  2 +-
 tests/qemu-iotests/172              |  2 +-
 tests/qemu-iotests/check            |  2 +-
 tests/vmgenid-test.c                |  2 +-
 21 files changed, 46 insertions(+), 63 deletions(-)

-- 
1.8.3.1

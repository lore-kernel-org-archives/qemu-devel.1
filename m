Received: from eggs.gnu.org ([2001:4830:134:3::10]:58173)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fMFsO-0003Yl-Ur
	for qemu-devel@nongnu.org; Fri, 25 May 2018 12:47:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fMFsN-0002bH-PC
	for qemu-devel@nongnu.org; Fri, 25 May 2018 12:47:36 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:45618 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1fMFsN-0002b7-JP
	for qemu-devel@nongnu.org; Fri, 25 May 2018 12:47:35 -0400
Date: Fri, 25 May 2018 19:47:33 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <1527266793-301361-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [Qemu-devel] [PATCH v2 00/20] include cleanups
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: eblake@redhat.com, peter.maydell@linaro.org

Right now, a local header can be included with either

#include "foo.h"
    or
#include "dir/foo.h"

since the later doesn't tell you where the header is
(in source or include directory), the former is preferable.

I intend to look for ways to prevent the second way from working, but
that will take time. For now, fix all instances for the later way I
could find.

In a couple of places I just dropped the include instead.

Finally, arch_init huge list of includes is sorted, which will be
helpful in future cleanups.

This was part of the include path cleanup patchset
(https://lists.gnu.org/archive/html/qemu-devel/2018-05/msg00739.html).

Changes from v1
    drop patches not dealing with local headers
    stop saying include through root works by accident -
        it's not by accident, just not how we'd like code to look like
    address comments by eric, philip, others

Michael S. Tsirkin (20):
  block: use local path for local headers
  crypto: use local path for local headers
  hppa: use local path for local headers
  migration: drop an unused include
  trace: use local path for local headers
  display: use local path for local headers
  ide: use local path for local headers
  ioapic: fix up includes
  e1000e: use local path for local headers
  rocker: drop an unused include
  ppc: use local path for local headers
  vhost-scsi: drop an unused include
  sd: fix up include
  usb: use local path for local headers
  migration: use local path for local headers
  colo: use local path for local headers
  qga: use local path for local headers
  trace: use local path for local headers
  ui: use local path for local headers
  arch_init: sort architectures

 crypto/block-luks.h             |  2 +-
 crypto/block-qcow.h             |  2 +-
 crypto/ivgen-essiv.h            |  2 +-
 crypto/ivgen-plain.h            |  2 +-
 crypto/ivgen-plain64.h          |  2 +-
 hw/hppa/hppa_sys.h              |  2 +-
 include/migration/vmstate.h     |  2 +-
 trace/control.h                 |  2 +-
 arch_init.c                     | 16 ++++++++--------
 block/crypto.c                  |  2 +-
 block/nbd.c                     |  2 +-
 block/qcow.c                    |  2 +-
 block/qcow2-bitmap.c            |  2 +-
 block/qcow2-cluster.c           |  2 +-
 block/qcow2-refcount.c          |  2 +-
 block/qcow2-snapshot.c          |  2 +-
 block/qcow2.c                   |  4 ++--
 block/vhdx-endian.c             |  2 +-
 block/vhdx-log.c                |  2 +-
 block/vhdx.c                    |  2 +-
 crypto/block-luks.c             |  2 +-
 crypto/block-qcow.c             |  2 +-
 crypto/block.c                  |  6 +++---
 crypto/cipher.c                 |  6 +++---
 crypto/ivgen-essiv.c            |  2 +-
 crypto/ivgen-plain.c            |  2 +-
 crypto/ivgen-plain64.c          |  2 +-
 crypto/ivgen.c                  |  8 ++++----
 crypto/tlscreds.c               |  2 +-
 crypto/tlscredsanon.c           |  2 +-
 crypto/tlscredsx509.c           |  2 +-
 hw/display/bcm2835_fb.c         |  2 +-
 hw/hppa/machine.c               |  2 +-
 hw/ide/ahci-allwinner.c         |  2 +-
 hw/ide/ahci.c                   |  2 +-
 hw/ide/ich.c                    |  2 +-
 hw/intc/ioapic.c                |  3 +--
 hw/net/e1000e.c                 |  2 +-
 hw/net/rocker/rocker_fp.c       |  1 -
 hw/ppc/ppc440_uc.c              |  2 +-
 hw/ppc/sam460ex.c               |  4 ++--
 hw/scsi/vhost-scsi-common.c     |  1 -
 hw/sd/milkymist-memcard.c       |  2 +-
 hw/usb/desc-msos.c              |  2 +-
 hw/usb/desc.c                   |  2 +-
 hw/usb/dev-audio.c              |  2 +-
 hw/usb/dev-bluetooth.c          |  2 +-
 hw/usb/dev-hid.c                |  2 +-
 hw/usb/dev-hub.c                |  2 +-
 hw/usb/dev-mtp.c                |  2 +-
 hw/usb/dev-network.c            |  2 +-
 hw/usb/dev-serial.c             |  2 +-
 hw/usb/dev-smartcard-reader.c   |  2 +-
 hw/usb/dev-storage.c            |  2 +-
 hw/usb/dev-uas.c                |  2 +-
 hw/usb/dev-wacom.c              |  2 +-
 migration/block-dirty-bitmap.c  |  2 +-
 migration/page_cache.c          |  2 +-
 migration/ram.c                 |  4 ++--
 migration/savevm.c              |  1 +
 migration/vmstate.c             |  2 +-
 net/colo-compare.c              |  2 +-
 net/colo.c                      |  2 +-
 net/filter-rewriter.c           |  2 +-
 qga/channel-posix.c             |  2 +-
 qga/channel-win32.c             |  4 ++--
 qga/commands-posix.c            |  2 +-
 qga/commands-win32.c            |  4 ++--
 qga/commands.c                  |  2 +-
 qga/guest-agent-command-state.c |  2 +-
 qga/main.c                      |  4 ++--
 qga/vss-win32.c                 |  6 +++---
 trace/qmp.c                     |  2 +-
 ui/gtk.c                        |  2 +-
 ui/input-keymap.c               |  2 +-
 ui/input-legacy.c               |  2 +-
 ui/spice-input.c                |  2 +-
 77 files changed, 97 insertions(+), 99 deletions(-)

-- 
MST

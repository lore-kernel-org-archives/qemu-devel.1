Received: from eggs.gnu.org ([2001:4830:134:3::10]:59736)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ejP1U-0001X4-HM
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 07:40:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ejP1K-0004kx-RG
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 07:40:24 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:50756 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1ejP1K-0004kN-L9
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 07:40:14 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 47E138A9E8
	for <qemu-devel@nongnu.org>; Wed,  7 Feb 2018 12:40:14 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-148.ams2.redhat.com
	[10.36.116.148])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 8825D2024CA5
	for <qemu-devel@nongnu.org>; Wed,  7 Feb 2018 12:40:13 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Wed,  7 Feb 2018 13:40:09 +0100
Message-Id: <20180207124009.12376-21-armbru@redhat.com>
In-Reply-To: <20180207124009.12376-1-armbru@redhat.com>
References: <20180207124009.12376-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 20/20] Move include qemu/option.h from
 qemu-common.h to actual users
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

qemu-common.h includes qemu/option.h, but most places that include the
former don't actually need the latter.  Drop the include, and add it
to the places that actually need it.

While there, drop superfluous includes of both headers, and
separate #include from file comment with a blank line.

This cleanup makes the number of objects depending on qemu/option.h
drop from 4545 (out of 4743) to 284 in my "build everything" tree.

Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
Message-Id: <20180201111846.21846-20-armbru@redhat.com>
---
 accel/accel.c                 | 2 +-
 block.c                       | 1 +
 block/blkdebug.c              | 1 +
 block/blkverify.c             | 1 +
 block/block-backend.c         | 1 +
 block/crypto.c                | 1 +
 block/curl.c                  | 2 +-
 block/file-posix.c            | 2 ++
 block/file-win32.c            | 2 ++
 block/gluster.c               | 2 ++
 block/iscsi-opts.c            | 1 +
 block/iscsi.c                 | 2 +-
 block/nbd.c                   | 1 +
 block/nfs.c                   | 2 +-
 block/null.c                  | 1 +
 block/parallels.c             | 3 ++-
 block/qcow.c                  | 2 +-
 block/qed.c                   | 1 +
 block/quorum.c                | 1 +
 block/rbd.c                   | 1 +
 block/replication.c           | 2 +-
 block/sheepdog.c              | 1 +
 block/snapshot.c              | 1 +
 block/ssh.c                   | 1 +
 block/throttle.c              | 1 +
 block/vdi.c                   | 1 +
 block/vhdx.c                  | 2 +-
 block/vmdk.c                  | 1 +
 block/vpc.c                   | 3 ++-
 block/vvfat.c                 | 1 +
 chardev/char-file.c           | 3 ++-
 chardev/char-mux.c            | 3 ++-
 chardev/char-parallel.c       | 2 ++
 chardev/char-pipe.c           | 2 ++
 chardev/char-ringbuf.c        | 1 +
 chardev/char-serial.c         | 2 ++
 chardev/char-socket.c         | 2 ++
 chardev/char-stdio.c          | 3 ++-
 chardev/char-udp.c            | 2 ++
 chardev/char.c                | 1 +
 chardev/spice.c               | 1 +
 contrib/ivshmem-server/main.c | 2 +-
 cpus.c                        | 2 +-
 device-hotplug.c              | 1 +
 device_tree.c                 | 2 +-
 fsdev/qemu-fsdev-throttle.c   | 1 +
 fsdev/qemu-fsdev.c            | 2 +-
 fsdev/qemu-fsdev.h            | 1 -
 hw/9pfs/9p-handle.c           | 1 +
 hw/9pfs/9p-local.c            | 1 +
 hw/9pfs/9p-proxy.c            | 1 +
 hw/9pfs/xen-9p-backend.c      | 1 +
 hw/acpi/core.c                | 1 +
 hw/arm/boot.c                 | 1 +
 hw/core/qdev.c                | 1 +
 hw/i386/multiboot.c           | 2 +-
 hw/i386/pc.c                  | 1 +
 hw/i386/pc_sysfw.c            | 1 +
 hw/nvram/fw_cfg.c             | 2 ++
 hw/ppc/e500.c                 | 2 +-
 hw/ppc/virtex_ml507.c         | 1 +
 hw/s390x/s390-virtio-ccw.c    | 2 +-
 hw/scsi/scsi-bus.c            | 1 +
 hw/smbios/smbios.c            | 1 +
 hw/usb/xen-usb.c              | 2 +-
 hw/vfio/pci.c                 | 1 +
 hw/xen/xen_devconfig.c        | 1 +
 hw/xtensa/xtfpga.c            | 2 +-
 include/block/block.h         | 1 -
 include/block/block_int.h     | 1 -
 include/block/nbd.h           | 2 --
 include/block/snapshot.h      | 2 --
 include/chardev/char.h        | 2 --
 include/hw/acpi/acpi.h        | 1 -
 include/hw/qdev-core.h        | 1 -
 include/hw/smbios/smbios.h    | 1 -
 include/net/net.h             | 2 --
 include/net/slirp.h           | 2 --
 include/qapi/opts-visitor.h   | 1 -
 include/qemu-common.h         | 2 --
 include/qemu/config-file.h    | 1 -
 include/sysemu/arch_init.h    | 1 -
 include/sysemu/hostmem.h      | 1 -
 include/sysemu/numa.h         | 1 -
 include/sysemu/sysemu.h       | 1 -
 include/ui/qemu-spice.h       | 1 -
 monitor.c                     | 2 +-
 net/net.c                     | 2 +-
 net/vhost-user.c              | 1 +
 qdev-monitor.c                | 1 +
 qemu-io-cmds.c                | 1 +
 qemu-nbd.c                    | 2 +-
 qmp.c                         | 1 +
 qom/object_interfaces.c       | 1 +
 replay/replay.c               | 2 +-
 tests/test-char.c             | 2 +-
 tests/test-qemu-opts.c        | 1 +
 tests/test-replication.c      | 1 +
 trace/control.c               | 1 +
 ui/console.c                  | 2 +-
 ui/spice-core.c               | 2 +-
 ui/spice-display.c            | 2 +-
 ui/vnc.c                      | 1 +
 103 files changed, 98 insertions(+), 54 deletions(-)

diff --git a/accel/accel.c b/accel/accel.c
index 8ae40e1e13..93e2434c87 100644
--- a/accel/accel.c
+++ b/accel/accel.c
@@ -26,7 +26,6 @@
 #include "qemu/osdep.h"
 #include "sysemu/accel.h"
 #include "hw/boards.h"
-#include "qemu-common.h"
 #include "sysemu/arch_init.h"
 #include "sysemu/sysemu.h"
 #include "sysemu/kvm.h"
@@ -34,6 +33,7 @@
 #include "hw/xen/xen.h"
 #include "qom/object.h"
 #include "qemu/error-report.h"
+#include "qemu/option.h"
=20
 static const TypeInfo accel_type =3D {
     .name =3D TYPE_ACCEL,
diff --git a/block.c b/block.c
index 924b084436..7269481050 100644
--- a/block.c
+++ b/block.c
@@ -37,6 +37,7 @@
 #include "sysemu/block-backend.h"
 #include "sysemu/sysemu.h"
 #include "qemu/notify.h"
+#include "qemu/option.h"
 #include "qemu/coroutine.h"
 #include "block/qapi.h"
 #include "qemu/timer.h"
diff --git a/block/blkdebug.c b/block/blkdebug.c
index 356538482d..d83f23febd 100644
--- a/block/blkdebug.c
+++ b/block/blkdebug.c
@@ -29,6 +29,7 @@
 #include "qemu/config-file.h"
 #include "block/block_int.h"
 #include "qemu/module.h"
+#include "qemu/option.h"
 #include "qapi/qmp/qdict.h"
 #include "qapi/qmp/qstring.h"
 #include "sysemu/qtest.h"
diff --git a/block/blkverify.c b/block/blkverify.c
index 06369f9eac..331365be33 100644
--- a/block/blkverify.c
+++ b/block/blkverify.c
@@ -14,6 +14,7 @@
 #include "qapi/qmp/qdict.h"
 #include "qapi/qmp/qstring.h"
 #include "qemu/cutils.h"
+#include "qemu/option.h"
=20
 typedef struct {
     BdrvChild *test_file;
diff --git a/block/block-backend.c b/block/block-backend.c
index 6a5fdb7f42..3d7d3b4229 100644
--- a/block/block-backend.c
+++ b/block/block-backend.c
@@ -20,6 +20,7 @@
 #include "qapi-event.h"
 #include "qapi/error.h"
 #include "qemu/id.h"
+#include "qemu/option.h"
 #include "trace.h"
 #include "migration/misc.h"
=20
diff --git a/block/crypto.c b/block/crypto.c
index 2626f8ae3a..70e3691cd8 100644
--- a/block/crypto.c
+++ b/block/crypto.c
@@ -28,6 +28,7 @@
 #include "qapi/qobject-input-visitor.h"
 #include "qapi-visit.h"
 #include "qapi/error.h"
+#include "qemu/option.h"
 #include "block/crypto.h"
=20
 typedef struct BlockCrypto BlockCrypto;
diff --git a/block/curl.c b/block/curl.c
index fbd62b3864..059edfbeff 100644
--- a/block/curl.c
+++ b/block/curl.c
@@ -24,8 +24,8 @@
=20
 #include "qemu/osdep.h"
 #include "qapi/error.h"
-#include "qemu-common.h"
 #include "qemu/error-report.h"
+#include "qemu/option.h"
 #include "block/block_int.h"
 #include "qapi/qmp/qdict.h"
 #include "qapi/qmp/qstring.h"
diff --git a/block/file-posix.c b/block/file-posix.c
index 36ee89e940..2a94a84417 100644
--- a/block/file-posix.c
+++ b/block/file-posix.c
@@ -21,12 +21,14 @@
  * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALING=
S IN
  * THE SOFTWARE.
  */
+
 #include "qemu/osdep.h"
 #include "qapi/error.h"
 #include "qemu/cutils.h"
 #include "qemu/error-report.h"
 #include "block/block_int.h"
 #include "qemu/module.h"
+#include "qemu/option.h"
 #include "trace.h"
 #include "block/thread-pool.h"
 #include "qemu/iov.h"
diff --git a/block/file-win32.c b/block/file-win32.c
index 2f1da48e71..f24c7bb92c 100644
--- a/block/file-win32.c
+++ b/block/file-win32.c
@@ -21,11 +21,13 @@
  * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALING=
S IN
  * THE SOFTWARE.
  */
+
 #include "qemu/osdep.h"
 #include "qapi/error.h"
 #include "qemu/cutils.h"
 #include "block/block_int.h"
 #include "qemu/module.h"
+#include "qemu/option.h"
 #include "block/raw-aio.h"
 #include "trace.h"
 #include "block/thread-pool.h"
diff --git a/block/gluster.c b/block/gluster.c
index 097b6930a5..d8decc41ad 100644
--- a/block/gluster.c
+++ b/block/gluster.c
@@ -7,6 +7,7 @@
  * See the COPYING file in the top-level directory.
  *
  */
+
 #include "qemu/osdep.h"
 #include <glusterfs/api/glfs.h>
 #include "block/block_int.h"
@@ -15,6 +16,7 @@
 #include "qapi/qmp/qerror.h"
 #include "qemu/uri.h"
 #include "qemu/error-report.h"
+#include "qemu/option.h"
 #include "qemu/cutils.h"
=20
 #define GLUSTER_OPT_FILENAME        "filename"
diff --git a/block/iscsi-opts.c b/block/iscsi-opts.c
index 5335539130..9b19bd2f52 100644
--- a/block/iscsi-opts.c
+++ b/block/iscsi-opts.c
@@ -25,6 +25,7 @@
 #include "qemu/osdep.h"
 #include "qemu-common.h"
 #include "qemu/config-file.h"
+#include "qemu/option.h"
=20
 static QemuOptsList qemu_iscsi_opts =3D {
     .name =3D "iscsi",
diff --git a/block/iscsi.c b/block/iscsi.c
index 9a1bf43cbc..b1585ca218 100644
--- a/block/iscsi.c
+++ b/block/iscsi.c
@@ -28,7 +28,6 @@
 #include <poll.h>
 #include <math.h>
 #include <arpa/inet.h>
-#include "qemu-common.h"
 #include "qemu/config-file.h"
 #include "qemu/error-report.h"
 #include "qemu/bitops.h"
@@ -36,6 +35,7 @@
 #include "block/block_int.h"
 #include "scsi/constants.h"
 #include "qemu/iov.h"
+#include "qemu/option.h"
 #include "qemu/uuid.h"
 #include "qmp-commands.h"
 #include "qapi/error.h"
diff --git a/block/nbd.c b/block/nbd.c
index 8cc4c6f312..411eeb42a7 100644
--- a/block/nbd.c
+++ b/block/nbd.c
@@ -32,6 +32,7 @@
 #include "qemu/uri.h"
 #include "block/block_int.h"
 #include "qemu/module.h"
+#include "qemu/option.h"
 #include "qapi-visit.h"
 #include "qapi/qobject-input-visitor.h"
 #include "qapi/qobject-output-visitor.h"
diff --git a/block/nfs.c b/block/nfs.c
index effc8719b5..6576a73d6e 100644
--- a/block/nfs.c
+++ b/block/nfs.c
@@ -25,13 +25,13 @@
 #include "qemu/osdep.h"
=20
 #include <poll.h>
-#include "qemu-common.h"
 #include "qemu/config-file.h"
 #include "qemu/error-report.h"
 #include "qapi/error.h"
 #include "block/block_int.h"
 #include "trace.h"
 #include "qemu/iov.h"
+#include "qemu/option.h"
 #include "qemu/uri.h"
 #include "qemu/cutils.h"
 #include "sysemu/sysemu.h"
diff --git a/block/null.c b/block/null.c
index 0cdabaa440..214d394fff 100644
--- a/block/null.c
+++ b/block/null.c
@@ -14,6 +14,7 @@
 #include "qapi/error.h"
 #include "qapi/qmp/qdict.h"
 #include "qapi/qmp/qstring.h"
+#include "qemu/option.h"
 #include "block/block_int.h"
=20
 #define NULL_OPT_LATENCY "latency-ns"
diff --git a/block/parallels.c b/block/parallels.c
index d3802085e3..e1e3d80c88 100644
--- a/block/parallels.c
+++ b/block/parallels.c
@@ -27,12 +27,13 @@
  * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALING=
S IN
  * THE SOFTWARE.
  */
+
 #include "qemu/osdep.h"
 #include "qapi/error.h"
-#include "qemu-common.h"
 #include "block/block_int.h"
 #include "sysemu/block-backend.h"
 #include "qemu/module.h"
+#include "qemu/option.h"
 #include "qemu/bswap.h"
 #include "qemu/bitmap.h"
 #include "migration/blocker.h"
diff --git a/block/qcow.c b/block/qcow.c
index 0b32c04cd0..8631155ac8 100644
--- a/block/qcow.c
+++ b/block/qcow.c
@@ -24,11 +24,11 @@
=20
 #include "qemu/osdep.h"
 #include "qapi/error.h"
-#include "qemu-common.h"
 #include "qemu/error-report.h"
 #include "block/block_int.h"
 #include "sysemu/block-backend.h"
 #include "qemu/module.h"
+#include "qemu/option.h"
 #include "qemu/bswap.h"
 #include <zlib.h>
 #include "qapi/qmp/qdict.h"
diff --git a/block/qed.c b/block/qed.c
index 7e2b34c3a7..205dbf16e3 100644
--- a/block/qed.c
+++ b/block/qed.c
@@ -16,6 +16,7 @@
 #include "qapi/error.h"
 #include "qemu/timer.h"
 #include "qemu/bswap.h"
+#include "qemu/option.h"
 #include "trace.h"
 #include "qed.h"
 #include "sysemu/block-backend.h"
diff --git a/block/quorum.c b/block/quorum.c
index 2dc79bf7e2..19f1c34425 100644
--- a/block/quorum.c
+++ b/block/quorum.c
@@ -15,6 +15,7 @@
=20
 #include "qemu/osdep.h"
 #include "qemu/cutils.h"
+#include "qemu/option.h"
 #include "block/block_int.h"
 #include "qapi/error.h"
 #include "qapi/qmp/qdict.h"
diff --git a/block/rbd.c b/block/rbd.c
index 42be5ed49d..8474b0ba11 100644
--- a/block/rbd.c
+++ b/block/rbd.c
@@ -16,6 +16,7 @@
 #include <rbd/librbd.h>
 #include "qapi/error.h"
 #include "qemu/error-report.h"
+#include "qemu/option.h"
 #include "block/block_int.h"
 #include "crypto/secret.h"
 #include "qemu/cutils.h"
diff --git a/block/replication.c b/block/replication.c
index b1ea3caa4b..f98ef094b9 100644
--- a/block/replication.c
+++ b/block/replication.c
@@ -13,7 +13,7 @@
  */
=20
 #include "qemu/osdep.h"
-#include "qemu-common.h"
+#include "qemu/option.h"
 #include "block/nbd.h"
 #include "block/blockjob.h"
 #include "block/block_int.h"
diff --git a/block/sheepdog.c b/block/sheepdog.c
index f684477328..af125a2c8d 100644
--- a/block/sheepdog.c
+++ b/block/sheepdog.c
@@ -19,6 +19,7 @@
 #include "qapi/qobject-input-visitor.h"
 #include "qemu/uri.h"
 #include "qemu/error-report.h"
+#include "qemu/option.h"
 #include "qemu/sockets.h"
 #include "block/block_int.h"
 #include "sysemu/block-backend.h"
diff --git a/block/snapshot.c b/block/snapshot.c
index 9294a9fcc4..eacc1f19a2 100644
--- a/block/snapshot.c
+++ b/block/snapshot.c
@@ -29,6 +29,7 @@
 #include "qapi/qmp/qdict.h"
 #include "qapi/qmp/qerror.h"
 #include "qapi/qmp/qstring.h"
+#include "qemu/option.h"
=20
 QemuOptsList internal_snapshot_opts =3D {
     .name =3D "snapshot",
diff --git a/block/ssh.c b/block/ssh.c
index 91f5f4c3c9..b63addcf94 100644
--- a/block/ssh.c
+++ b/block/ssh.c
@@ -30,6 +30,7 @@
 #include "block/block_int.h"
 #include "qapi/error.h"
 #include "qemu/error-report.h"
+#include "qemu/option.h"
 #include "qemu/cutils.h"
 #include "qemu/sockets.h"
 #include "qemu/uri.h"
diff --git a/block/throttle.c b/block/throttle.c
index 833175ac77..495f88c752 100644
--- a/block/throttle.c
+++ b/block/throttle.c
@@ -19,6 +19,7 @@
=20
 #include "qemu/osdep.h"
 #include "block/throttle-groups.h"
+#include "qemu/option.h"
 #include "qemu/throttle-options.h"
 #include "qapi/error.h"
=20
diff --git a/block/vdi.c b/block/vdi.c
index 8da5dfc897..fc1c614cb1 100644
--- a/block/vdi.c
+++ b/block/vdi.c
@@ -54,6 +54,7 @@
 #include "block/block_int.h"
 #include "sysemu/block-backend.h"
 #include "qemu/module.h"
+#include "qemu/option.h"
 #include "qemu/bswap.h"
 #include "migration/blocker.h"
 #include "qemu/coroutine.h"
diff --git a/block/vhdx.c b/block/vhdx.c
index 9956933da6..c449c5dcfd 100644
--- a/block/vhdx.c
+++ b/block/vhdx.c
@@ -17,10 +17,10 @@
=20
 #include "qemu/osdep.h"
 #include "qapi/error.h"
-#include "qemu-common.h"
 #include "block/block_int.h"
 #include "sysemu/block-backend.h"
 #include "qemu/module.h"
+#include "qemu/option.h"
 #include "qemu/crc32c.h"
 #include "qemu/bswap.h"
 #include "block/vhdx.h"
diff --git a/block/vmdk.c b/block/vmdk.c
index d71cec4f31..ef15ddbfd3 100644
--- a/block/vmdk.c
+++ b/block/vmdk.c
@@ -30,6 +30,7 @@
 #include "qapi/qmp/qerror.h"
 #include "qemu/error-report.h"
 #include "qemu/module.h"
+#include "qemu/option.h"
 #include "qemu/bswap.h"
 #include "migration/blocker.h"
 #include "qemu/cutils.h"
diff --git a/block/vpc.c b/block/vpc.c
index 1576d7b595..cfa5144e86 100644
--- a/block/vpc.c
+++ b/block/vpc.c
@@ -22,12 +22,13 @@
  * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALING=
S IN
  * THE SOFTWARE.
  */
+
 #include "qemu/osdep.h"
 #include "qapi/error.h"
-#include "qemu-common.h"
 #include "block/block_int.h"
 #include "sysemu/block-backend.h"
 #include "qemu/module.h"
+#include "qemu/option.h"
 #include "migration/blocker.h"
 #include "qemu/bswap.h"
 #include "qemu/uuid.h"
diff --git a/block/vvfat.c b/block/vvfat.c
index 5dca227311..7e06ebacf6 100644
--- a/block/vvfat.c
+++ b/block/vvfat.c
@@ -28,6 +28,7 @@
 #include "qapi/error.h"
 #include "block/block_int.h"
 #include "qemu/module.h"
+#include "qemu/option.h"
 #include "qemu/bswap.h"
 #include "migration/blocker.h"
 #include "qapi/qmp/qdict.h"
diff --git a/chardev/char-file.c b/chardev/char-file.c
index a57b88aaf2..87fb61088c 100644
--- a/chardev/char-file.c
+++ b/chardev/char-file.c
@@ -21,9 +21,10 @@
  * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALING=
S IN
  * THE SOFTWARE.
  */
+
 #include "qemu/osdep.h"
 #include "qapi/error.h"
-#include "qemu-common.h"
+#include "qemu/option.h"
 #include "chardev/char.h"
=20
 #ifdef _WIN32
diff --git a/chardev/char-mux.c b/chardev/char-mux.c
index 567bf965cd..d48e78103a 100644
--- a/chardev/char-mux.c
+++ b/chardev/char-mux.c
@@ -21,9 +21,10 @@
  * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALING=
S IN
  * THE SOFTWARE.
  */
+
 #include "qemu/osdep.h"
 #include "qapi/error.h"
-#include "qemu-common.h"
+#include "qemu/option.h"
 #include "chardev/char.h"
 #include "sysemu/block-backend.h"
 #include "chardev/char-mux.h"
diff --git a/chardev/char-parallel.c b/chardev/char-parallel.c
index bce89f8c36..ab82c72ac7 100644
--- a/chardev/char-parallel.c
+++ b/chardev/char-parallel.c
@@ -21,9 +21,11 @@
  * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALING=
S IN
  * THE SOFTWARE.
  */
+
 #include "qemu/osdep.h"
 #include "chardev/char.h"
 #include "qapi/error.h"
+#include "qemu/option.h"
 #include <sys/ioctl.h>
=20
 #ifdef CONFIG_BSD
diff --git a/chardev/char-pipe.c b/chardev/char-pipe.c
index 3a95e4c1b2..8a51872e5e 100644
--- a/chardev/char-pipe.c
+++ b/chardev/char-pipe.c
@@ -21,8 +21,10 @@
  * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALING=
S IN
  * THE SOFTWARE.
  */
+
 #include "qemu/osdep.h"
 #include "qapi/error.h"
+#include "qemu/option.h"
 #include "chardev/char.h"
=20
 #ifdef _WIN32
diff --git a/chardev/char-ringbuf.c b/chardev/char-ringbuf.c
index c1fa4c3f87..679afaa4fd 100644
--- a/chardev/char-ringbuf.c
+++ b/chardev/char-ringbuf.c
@@ -27,6 +27,7 @@
 #include "qmp-commands.h"
 #include "qapi/error.h"
 #include "qemu/base64.h"
+#include "qemu/option.h"
=20
 /* Ring buffer chardev */
=20
diff --git a/chardev/char-serial.c b/chardev/char-serial.c
index 93392c528c..feb52e559d 100644
--- a/chardev/char-serial.c
+++ b/chardev/char-serial.c
@@ -21,7 +21,9 @@
  * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALING=
S IN
  * THE SOFTWARE.
  */
+
 #include "qemu/osdep.h"
+#include "qemu/option.h"
 #include "qemu/sockets.h"
 #include "io/channel-file.h"
 #include "qapi/error.h"
diff --git a/chardev/char-socket.c b/chardev/char-socket.c
index 77cdf487eb..3c6727dda8 100644
--- a/chardev/char-socket.c
+++ b/chardev/char-socket.c
@@ -21,12 +21,14 @@
  * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALING=
S IN
  * THE SOFTWARE.
  */
+
 #include "qemu/osdep.h"
 #include "chardev/char.h"
 #include "io/channel-socket.h"
 #include "io/channel-tls.h"
 #include "io/net-listener.h"
 #include "qemu/error-report.h"
+#include "qemu/option.h"
 #include "qapi/error.h"
 #include "qapi/clone-visitor.h"
=20
diff --git a/chardev/char-stdio.c b/chardev/char-stdio.c
index 6f5d798d7b..96375f2ab8 100644
--- a/chardev/char-stdio.c
+++ b/chardev/char-stdio.c
@@ -21,10 +21,11 @@
  * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALING=
S IN
  * THE SOFTWARE.
  */
+
 #include "qemu/osdep.h"
+#include "qemu/option.h"
 #include "qemu/sockets.h"
 #include "qapi/error.h"
-#include "qemu-common.h"
 #include "chardev/char.h"
=20
 #ifdef _WIN32
diff --git a/chardev/char-udp.c b/chardev/char-udp.c
index d46ff7ab53..097a2f0f42 100644
--- a/chardev/char-udp.c
+++ b/chardev/char-udp.c
@@ -21,10 +21,12 @@
  * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALING=
S IN
  * THE SOFTWARE.
  */
+
 #include "qemu/osdep.h"
 #include "chardev/char.h"
 #include "io/channel-socket.h"
 #include "qapi/error.h"
+#include "qemu/option.h"
=20
 #include "chardev/char-io.h"
=20
diff --git a/chardev/char.c b/chardev/char.c
index 51f269796a..01d979a1da 100644
--- a/chardev/char.c
+++ b/chardev/char.c
@@ -34,6 +34,7 @@
 #include "qapi/error.h"
 #include "sysemu/replay.h"
 #include "qemu/help_option.h"
+#include "qemu/option.h"
=20
 #include "chardev/char-mux.h"
=20
diff --git a/chardev/spice.c b/chardev/spice.c
index bbdf649904..e66e3ad568 100644
--- a/chardev/spice.c
+++ b/chardev/spice.c
@@ -4,6 +4,7 @@
 #include "chardev/char.h"
 #include "qapi/error.h"
 #include "qemu/error-report.h"
+#include "qemu/option.h"
 #include <spice.h>
 #include <spice/protocol.h>
=20
diff --git a/contrib/ivshmem-server/main.c b/contrib/ivshmem-server/main.=
c
index 45776d8af4..197c79c57e 100644
--- a/contrib/ivshmem-server/main.c
+++ b/contrib/ivshmem-server/main.c
@@ -9,7 +9,7 @@
 #include "qemu/osdep.h"
 #include "qapi/error.h"
 #include "qemu/cutils.h"
-
+#include "qemu/option.h"
 #include "ivshmem-server.h"
=20
 #define IVSHMEM_SERVER_DEFAULT_VERBOSE        0
diff --git a/cpus.c b/cpus.c
index c5bd49d60a..18166c93ef 100644
--- a/cpus.c
+++ b/cpus.c
@@ -23,7 +23,6 @@
  */
=20
 #include "qemu/osdep.h"
-#include "qemu-common.h"
 #include "qemu/config-file.h"
 #include "cpu.h"
 #include "monitor/monitor.h"
@@ -45,6 +44,7 @@
 #include "sysemu/cpus.h"
 #include "sysemu/qtest.h"
 #include "qemu/main-loop.h"
+#include "qemu/option.h"
 #include "qemu/bitmap.h"
 #include "qemu/seqlock.h"
 #include "tcg.h"
diff --git a/device-hotplug.c b/device-hotplug.c
index b10e8cc6d4..23fd6656f1 100644
--- a/device-hotplug.c
+++ b/device-hotplug.c
@@ -29,6 +29,7 @@
 #include "sysemu/blockdev.h"
 #include "qapi/qmp/qdict.h"
 #include "qemu/config-file.h"
+#include "qemu/option.h"
 #include "sysemu/sysemu.h"
 #include "monitor/monitor.h"
 #include "block/block_int.h"
diff --git a/device_tree.c b/device_tree.c
index a24ddff02b..19458b32bf 100644
--- a/device_tree.c
+++ b/device_tree.c
@@ -18,8 +18,8 @@
 #endif
=20
 #include "qapi/error.h"
-#include "qemu-common.h"
 #include "qemu/error-report.h"
+#include "qemu/option.h"
 #include "qemu/bswap.h"
 #include "sysemu/device_tree.h"
 #include "sysemu/sysemu.h"
diff --git a/fsdev/qemu-fsdev-throttle.c b/fsdev/qemu-fsdev-throttle.c
index 49eebb5412..ea9508da0a 100644
--- a/fsdev/qemu-fsdev-throttle.c
+++ b/fsdev/qemu-fsdev-throttle.c
@@ -16,6 +16,7 @@
 #include "qemu/error-report.h"
 #include "qemu-fsdev-throttle.h"
 #include "qemu/iov.h"
+#include "qemu/option.h"
=20
 static void fsdev_throttle_read_timer_cb(void *opaque)
 {
diff --git a/fsdev/qemu-fsdev.c b/fsdev/qemu-fsdev.c
index de819cf7a1..8a4afbffbd 100644
--- a/fsdev/qemu-fsdev.c
+++ b/fsdev/qemu-fsdev.c
@@ -14,9 +14,9 @@
 #include "qapi/error.h"
 #include "qemu-fsdev.h"
 #include "qemu/queue.h"
-#include "qemu-common.h"
 #include "qemu/config-file.h"
 #include "qemu/error-report.h"
+#include "qemu/option.h"
=20
 static QTAILQ_HEAD(FsDriverEntry_head, FsDriverListEntry) fsdriver_entri=
es =3D
     QTAILQ_HEAD_INITIALIZER(fsdriver_entries);
diff --git a/fsdev/qemu-fsdev.h b/fsdev/qemu-fsdev.h
index 29c962296d..65e4b1cfab 100644
--- a/fsdev/qemu-fsdev.h
+++ b/fsdev/qemu-fsdev.h
@@ -12,7 +12,6 @@
  */
 #ifndef QEMU_FSDEV_H
 #define QEMU_FSDEV_H
-#include "qemu/option.h"
 #include "file-op-9p.h"
=20
=20
diff --git a/hw/9pfs/9p-handle.c b/hw/9pfs/9p-handle.c
index c1681d3c8a..4dc0d2bed1 100644
--- a/hw/9pfs/9p-handle.c
+++ b/hw/9pfs/9p-handle.c
@@ -22,6 +22,7 @@
 #include "qemu/xattr.h"
 #include "qemu/cutils.h"
 #include "qemu/error-report.h"
+#include "qemu/option.h"
 #include <linux/fs.h>
 #ifdef CONFIG_LINUX_MAGIC_H
 #include <linux/magic.h>
diff --git a/hw/9pfs/9p-local.c b/hw/9pfs/9p-local.c
index fe85726c97..b37b1db453 100644
--- a/hw/9pfs/9p-local.c
+++ b/hw/9pfs/9p-local.c
@@ -25,6 +25,7 @@
 #include "qapi/error.h"
 #include "qemu/cutils.h"
 #include "qemu/error-report.h"
+#include "qemu/option.h"
 #include <libgen.h>
 #include <linux/fs.h>
 #ifdef CONFIG_LINUX_MAGIC_H
diff --git a/hw/9pfs/9p-proxy.c b/hw/9pfs/9p-proxy.c
index 0f288b1300..e2e03292de 100644
--- a/hw/9pfs/9p-proxy.c
+++ b/hw/9pfs/9p-proxy.c
@@ -17,6 +17,7 @@
 #include "qapi/error.h"
 #include "qemu/cutils.h"
 #include "qemu/error-report.h"
+#include "qemu/option.h"
 #include "fsdev/qemu-fsdev.h"
 #include "9p-proxy.h"
=20
diff --git a/hw/9pfs/xen-9p-backend.c b/hw/9pfs/xen-9p-backend.c
index 14f0d6a50e..95e50c4dfc 100644
--- a/hw/9pfs/xen-9p-backend.c
+++ b/hw/9pfs/xen-9p-backend.c
@@ -15,6 +15,7 @@
 #include "hw/xen/xen_backend.h"
 #include "hw/9pfs/xen-9pfs.h"
 #include "qemu/config-file.h"
+#include "qemu/option.h"
 #include "fsdev/qemu-fsdev.h"
=20
 #define VERSIONS "1"
diff --git a/hw/acpi/core.c b/hw/acpi/core.c
index 5ee55414c1..b50b3ca772 100644
--- a/hw/acpi/core.c
+++ b/hw/acpi/core.c
@@ -30,6 +30,7 @@
 #include "qapi-visit.h"
 #include "qapi-event.h"
 #include "qemu/error-report.h"
+#include "qemu/option.h"
=20
 struct acpi_table_header {
     uint16_t _length;         /* our length, not actual part of the hdr =
*/
diff --git a/hw/arm/boot.c b/hw/arm/boot.c
index c2720c8046..32628202c5 100644
--- a/hw/arm/boot.c
+++ b/hw/arm/boot.c
@@ -21,6 +21,7 @@
 #include "elf.h"
 #include "sysemu/device_tree.h"
 #include "qemu/config-file.h"
+#include "qemu/option.h"
 #include "exec/address-spaces.h"
=20
 /* Kernel boot protocol is specified in the kernel docs
diff --git a/hw/core/qdev.c b/hw/core/qdev.c
index e1143ad542..e2eea34f79 100644
--- a/hw/core/qdev.c
+++ b/hw/core/qdev.c
@@ -32,6 +32,7 @@
 #include "qapi/qmp/qerror.h"
 #include "qapi/visitor.h"
 #include "qemu/error-report.h"
+#include "qemu/option.h"
 #include "hw/hotplug.h"
 #include "hw/boards.h"
 #include "hw/sysbus.h"
diff --git a/hw/i386/multiboot.c b/hw/i386/multiboot.c
index c7b70c91d5..46d9c68bf5 100644
--- a/hw/i386/multiboot.c
+++ b/hw/i386/multiboot.c
@@ -23,7 +23,7 @@
  */
=20
 #include "qemu/osdep.h"
-#include "qemu-common.h"
+#include "qemu/option.h"
 #include "cpu.h"
 #include "hw/hw.h"
 #include "hw/nvram/fw_cfg.h"
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index f610253953..55e69d66fe 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -59,6 +59,7 @@
 #include "qemu/bitmap.h"
 #include "qemu/config-file.h"
 #include "qemu/error-report.h"
+#include "qemu/option.h"
 #include "hw/acpi/acpi.h"
 #include "hw/acpi/cpu_hotplug.h"
 #include "hw/boards.h"
diff --git a/hw/i386/pc_sysfw.c b/hw/i386/pc_sysfw.c
index 6b183747fc..4325575e7d 100644
--- a/hw/i386/pc_sysfw.c
+++ b/hw/i386/pc_sysfw.c
@@ -27,6 +27,7 @@
 #include "qapi/error.h"
 #include "sysemu/block-backend.h"
 #include "qemu/error-report.h"
+#include "qemu/option.h"
 #include "hw/sysbus.h"
 #include "hw/hw.h"
 #include "hw/i386/pc.h"
diff --git a/hw/nvram/fw_cfg.c b/hw/nvram/fw_cfg.c
index 4313484b21..2a0739d0e9 100644
--- a/hw/nvram/fw_cfg.c
+++ b/hw/nvram/fw_cfg.c
@@ -21,6 +21,7 @@
  * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALING=
S IN
  * THE SOFTWARE.
  */
+
 #include "qemu/osdep.h"
 #include "hw/hw.h"
 #include "sysemu/sysemu.h"
@@ -31,6 +32,7 @@
 #include "hw/sysbus.h"
 #include "trace.h"
 #include "qemu/error-report.h"
+#include "qemu/option.h"
 #include "qemu/config-file.h"
 #include "qemu/cutils.h"
 #include "qapi/error.h"
diff --git a/hw/ppc/e500.c b/hw/ppc/e500.c
index c4fe06ea2a..937bc9e4eb 100644
--- a/hw/ppc/e500.c
+++ b/hw/ppc/e500.c
@@ -16,7 +16,6 @@
=20
 #include "qemu/osdep.h"
 #include "qapi/error.h"
-#include "qemu-common.h"
 #include "e500.h"
 #include "e500-ccsr.h"
 #include "net/net.h"
@@ -36,6 +35,7 @@
 #include "hw/sysbus.h"
 #include "exec/address-spaces.h"
 #include "qemu/host-utils.h"
+#include "qemu/option.h"
 #include "hw/pci-host/ppce500.h"
 #include "qemu/error-report.h"
 #include "hw/platform-bus.h"
diff --git a/hw/ppc/virtex_ml507.c b/hw/ppc/virtex_ml507.c
index 9fe7655074..46fb9d4e03 100644
--- a/hw/ppc/virtex_ml507.c
+++ b/hw/ppc/virtex_ml507.c
@@ -37,6 +37,7 @@
 #include "elf.h"
 #include "qemu/error-report.h"
 #include "qemu/log.h"
+#include "qemu/option.h"
 #include "exec/address-spaces.h"
=20
 #include "hw/ppc/ppc.h"
diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
index 7d922ad732..f2db448233 100644
--- a/hw/s390x/s390-virtio-ccw.c
+++ b/hw/s390x/s390-virtio-ccw.c
@@ -12,7 +12,6 @@
=20
 #include "qemu/osdep.h"
 #include "qapi/error.h"
-#include "qemu-common.h"
 #include "cpu.h"
 #include "hw/boards.h"
 #include "exec/address-spaces.h"
@@ -24,6 +23,7 @@
 #include "virtio-ccw.h"
 #include "qemu/config-file.h"
 #include "qemu/error-report.h"
+#include "qemu/option.h"
 #include "s390-pci-bus.h"
 #include "hw/s390x/storage-keys.h"
 #include "hw/s390x/storage-attributes.h"
diff --git a/hw/scsi/scsi-bus.c b/hw/scsi/scsi-bus.c
index 05e501efd3..b7bafbed6e 100644
--- a/hw/scsi/scsi-bus.c
+++ b/hw/scsi/scsi-bus.c
@@ -2,6 +2,7 @@
 #include "hw/hw.h"
 #include "qapi/error.h"
 #include "qemu/error-report.h"
+#include "qemu/option.h"
 #include "hw/scsi/scsi.h"
 #include "scsi/constants.h"
 #include "hw/qdev.h"
diff --git a/hw/smbios/smbios.c b/hw/smbios/smbios.c
index 5d11f01874..27a07e96f4 100644
--- a/hw/smbios/smbios.c
+++ b/hw/smbios/smbios.c
@@ -19,6 +19,7 @@
 #include "qapi/error.h"
 #include "qemu/config-file.h"
 #include "qemu/error-report.h"
+#include "qemu/option.h"
 #include "sysemu/sysemu.h"
 #include "qemu/uuid.h"
 #include "sysemu/cpus.h"
diff --git a/hw/usb/xen-usb.c b/hw/usb/xen-usb.c
index e9eb1e902f..3beeb0d170 100644
--- a/hw/usb/xen-usb.c
+++ b/hw/usb/xen-usb.c
@@ -23,8 +23,8 @@
 #include <libusb.h>
 #include <sys/user.h>
=20
-#include "qemu-common.h"
 #include "qemu/config-file.h"
+#include "qemu/option.h"
 #include "hw/sysbus.h"
 #include "hw/usb.h"
 #include "hw/xen/xen_backend.h"
diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index 2c71295125..d6b386b1b9 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -26,6 +26,7 @@
 #include "hw/pci/msix.h"
 #include "hw/pci/pci_bridge.h"
 #include "qemu/error-report.h"
+#include "qemu/option.h"
 #include "qemu/range.h"
 #include "sysemu/kvm.h"
 #include "sysemu/sysemu.h"
diff --git a/hw/xen/xen_devconfig.c b/hw/xen/xen_devconfig.c
index a80e78c0dc..fac9d3fcdc 100644
--- a/hw/xen/xen_devconfig.c
+++ b/hw/xen/xen_devconfig.c
@@ -1,5 +1,6 @@
 #include "qemu/osdep.h"
 #include "hw/xen/xen_backend.h"
+#include "qemu/option.h"
 #include "sysemu/block-backend.h"
 #include "sysemu/blockdev.h"
=20
diff --git a/hw/xtensa/xtfpga.c b/hw/xtensa/xtfpga.c
index 76ea970215..70686a2eb1 100644
--- a/hw/xtensa/xtfpga.c
+++ b/hw/xtensa/xtfpga.c
@@ -27,7 +27,6 @@
=20
 #include "qemu/osdep.h"
 #include "qapi/error.h"
-#include "qemu-common.h"
 #include "cpu.h"
 #include "sysemu/sysemu.h"
 #include "hw/boards.h"
@@ -43,6 +42,7 @@
 #include "chardev/char.h"
 #include "sysemu/device_tree.h"
 #include "qemu/error-report.h"
+#include "qemu/option.h"
 #include "bootparam.h"
 #include "xtensa_memory.h"
=20
diff --git a/include/block/block.h b/include/block/block.h
index d2fc44dd30..ae1517f32d 100644
--- a/include/block/block.h
+++ b/include/block/block.h
@@ -4,7 +4,6 @@
 #include "block/aio.h"
 #include "qapi-types.h"
 #include "qemu/iov.h"
-#include "qemu/option.h"
 #include "qemu/coroutine.h"
 #include "block/accounting.h"
 #include "block/dirty-bitmap.h"
diff --git a/include/block/block_int.h b/include/block/block_int.h
index 6499f7c16a..5a54c4d0de 100644
--- a/include/block/block_int.h
+++ b/include/block/block_int.h
@@ -26,7 +26,6 @@
=20
 #include "block/accounting.h"
 #include "block/block.h"
-#include "qemu/option.h"
 #include "qemu/queue.h"
 #include "qemu/coroutine.h"
 #include "qemu/stats64.h"
diff --git a/include/block/nbd.h b/include/block/nbd.h
index ee74ec391a..fc50003003 100644
--- a/include/block/nbd.h
+++ b/include/block/nbd.h
@@ -21,8 +21,6 @@
 #define NBD_H
=20
=20
-#include "qemu-common.h"
-#include "qemu/option.h"
 #include "io/channel-socket.h"
 #include "crypto/tlscreds.h"
=20
diff --git a/include/block/snapshot.h b/include/block/snapshot.h
index 9407799941..f73d1094af 100644
--- a/include/block/snapshot.h
+++ b/include/block/snapshot.h
@@ -25,8 +25,6 @@
 #ifndef SNAPSHOT_H
 #define SNAPSHOT_H
=20
-#include "qemu-common.h"
-#include "qemu/option.h"
=20
=20
 #define SNAPSHOT_OPT_BASE       "snapshot."
diff --git a/include/chardev/char.h b/include/chardev/char.h
index d8941fcbb1..a381dc3df8 100644
--- a/include/chardev/char.h
+++ b/include/chardev/char.h
@@ -1,8 +1,6 @@
 #ifndef QEMU_CHAR_H
 #define QEMU_CHAR_H
=20
-#include "qemu-common.h"
-#include "qemu/option.h"
 #include "qemu/main-loop.h"
 #include "qemu/bitmap.h"
 #include "qom/object.h"
diff --git a/include/hw/acpi/acpi.h b/include/hw/acpi/acpi.h
index 39ff512129..c20ace0d0b 100644
--- a/include/hw/acpi/acpi.h
+++ b/include/hw/acpi/acpi.h
@@ -21,7 +21,6 @@
  */
=20
 #include "qemu/notify.h"
-#include "qemu/option.h"
 #include "exec/memory.h"
 #include "hw/irq.h"
 #include "hw/acpi/acpi_dev_interface.h"
diff --git a/include/hw/qdev-core.h b/include/hw/qdev-core.h
index 51473eee7b..bf022dc75b 100644
--- a/include/hw/qdev-core.h
+++ b/include/hw/qdev-core.h
@@ -2,7 +2,6 @@
 #define QDEV_CORE_H
=20
 #include "qemu/queue.h"
-#include "qemu/option.h"
 #include "qemu/bitmap.h"
 #include "qom/object.h"
 #include "hw/irq.h"
diff --git a/include/hw/smbios/smbios.h b/include/hw/smbios/smbios.h
index a83adb93d7..eeb5a4d7b6 100644
--- a/include/hw/smbios/smbios.h
+++ b/include/hw/smbios/smbios.h
@@ -14,7 +14,6 @@
  *
  */
=20
-#include "qemu/option.h"
=20
 #define SMBIOS_MAX_TYPE 127
=20
diff --git a/include/net/net.h b/include/net/net.h
index 71f1119bc9..3fc48e4f51 100644
--- a/include/net/net.h
+++ b/include/net/net.h
@@ -2,9 +2,7 @@
 #define QEMU_NET_H
=20
 #include "qemu/queue.h"
-#include "qemu-common.h"
 #include "qapi-types.h"
-#include "qemu/option.h"
 #include "net/queue.h"
 #include "migration/vmstate.h"
=20
diff --git a/include/net/slirp.h b/include/net/slirp.h
index 9a492b84a4..4d63d74da4 100644
--- a/include/net/slirp.h
+++ b/include/net/slirp.h
@@ -24,8 +24,6 @@
 #ifndef QEMU_NET_SLIRP_H
 #define QEMU_NET_SLIRP_H
=20
-#include "qemu-common.h"
-#include "qemu/option.h"
=20
 #ifdef CONFIG_SLIRP
=20
diff --git a/include/qapi/opts-visitor.h b/include/qapi/opts-visitor.h
index 6462c96c29..9b989e7e08 100644
--- a/include/qapi/opts-visitor.h
+++ b/include/qapi/opts-visitor.h
@@ -14,7 +14,6 @@
 #define OPTS_VISITOR_H
=20
 #include "qapi/visitor.h"
-#include "qemu/option.h"
=20
 /* Inclusive upper bound on the size of any flattened range. This is a s=
afety
  * (=3D anti-annoyance) measure; wrong ranges should not cause long star=
tup
diff --git a/include/qemu-common.h b/include/qemu-common.h
index 05319b9ddc..8a4f63c9de 100644
--- a/include/qemu-common.h
+++ b/include/qemu-common.h
@@ -16,8 +16,6 @@
=20
 #define TFR(expr) do { if ((expr) !=3D -1) break; } while (errno =3D=3D =
EINTR)
=20
-#include "qemu/option.h"
-
 /* Copyright string for -version arguments, About dialogs, etc */
 #define QEMU_COPYRIGHT "Copyright (c) 2003-2017 " \
     "Fabrice Bellard and the QEMU Project developers"
diff --git a/include/qemu/config-file.h b/include/qemu/config-file.h
index 449e631c86..d74f920152 100644
--- a/include/qemu/config-file.h
+++ b/include/qemu/config-file.h
@@ -1,7 +1,6 @@
 #ifndef QEMU_CONFIG_FILE_H
 #define QEMU_CONFIG_FILE_H
=20
-#include "qemu/option.h"
=20
 QemuOptsList *qemu_find_opts(const char *group);
 QemuOptsList *qemu_find_opts_err(const char *group, Error **errp);
diff --git a/include/sysemu/arch_init.h b/include/sysemu/arch_init.h
index 28f713eae2..d40d882e38 100644
--- a/include/sysemu/arch_init.h
+++ b/include/sysemu/arch_init.h
@@ -2,7 +2,6 @@
 #define QEMU_ARCH_INIT_H
=20
 #include "qapi-types.h"
-#include "qemu/option.h"
=20
 enum {
     QEMU_ARCH_ALL =3D -1,
diff --git a/include/sysemu/hostmem.h b/include/sysemu/hostmem.h
index ed6a437f4d..621a3f9d42 100644
--- a/include/sysemu/hostmem.h
+++ b/include/sysemu/hostmem.h
@@ -16,7 +16,6 @@
 #include "sysemu/sysemu.h" /* for MAX_NODES */
 #include "qom/object.h"
 #include "exec/memory.h"
-#include "qemu/option.h"
 #include "qemu/bitmap.h"
=20
 #define TYPE_MEMORY_BACKEND "memory-backend"
diff --git a/include/sysemu/numa.h b/include/sysemu/numa.h
index b3545215f6..d99e5474b4 100644
--- a/include/sysemu/numa.h
+++ b/include/sysemu/numa.h
@@ -2,7 +2,6 @@
 #define SYSEMU_NUMA_H
=20
 #include "qemu/bitmap.h"
-#include "qemu/option.h"
 #include "sysemu/sysemu.h"
 #include "sysemu/hostmem.h"
 #include "hw/boards.h"
diff --git a/include/sysemu/sysemu.h b/include/sysemu/sysemu.h
index 36fd371c93..77bb3da582 100644
--- a/include/sysemu/sysemu.h
+++ b/include/sysemu/sysemu.h
@@ -2,7 +2,6 @@
 #define SYSEMU_H
 /* Misc. things related to the system emulator.  */
=20
-#include "qemu/option.h"
 #include "qemu/queue.h"
 #include "qemu/timer.h"
 #include "qemu/notify.h"
diff --git a/include/ui/qemu-spice.h b/include/ui/qemu-spice.h
index 52a9f8808b..c6d50eb87a 100644
--- a/include/ui/qemu-spice.h
+++ b/include/ui/qemu-spice.h
@@ -23,7 +23,6 @@
 #ifdef CONFIG_SPICE
=20
 #include <spice.h>
-#include "qemu/option.h"
 #include "qemu/config-file.h"
=20
 extern int using_spice;
diff --git a/monitor.c b/monitor.c
index 6f70c8db9a..31f7aa2488 100644
--- a/monitor.c
+++ b/monitor.c
@@ -24,7 +24,6 @@
=20
 #include "qemu/osdep.h"
 #include <dirent.h>
-#include "qemu-common.h"
 #include "cpu.h"
 #include "hw/hw.h"
 #include "monitor/qdev.h"
@@ -68,6 +67,7 @@
 #include "exec/memory.h"
 #include "exec/exec-all.h"
 #include "qemu/log.h"
+#include "qemu/option.h"
 #include "qmp-commands.h"
 #include "hmp.h"
 #include "qemu/thread.h"
diff --git a/net/net.c b/net/net.c
index b36449dd65..3044d60dcc 100644
--- a/net/net.c
+++ b/net/net.c
@@ -32,7 +32,6 @@
 #include "util.h"
=20
 #include "monitor/monitor.h"
-#include "qemu-common.h"
 #include "qemu/help_option.h"
 #include "qapi/qmp/qerror.h"
 #include "qemu/error-report.h"
@@ -43,6 +42,7 @@
 #include "hw/qdev.h"
 #include "qemu/iov.h"
 #include "qemu/main-loop.h"
+#include "qemu/option.h"
 #include "qapi-visit.h"
 #include "qapi/error.h"
 #include "qapi/opts-visitor.h"
diff --git a/net/vhost-user.c b/net/vhost-user.c
index fd766504ab..cb45512506 100644
--- a/net/vhost-user.c
+++ b/net/vhost-user.c
@@ -16,6 +16,7 @@
 #include "qapi/error.h"
 #include "qemu/config-file.h"
 #include "qemu/error-report.h"
+#include "qemu/option.h"
 #include "qmp-commands.h"
 #include "trace.h"
=20
diff --git a/qdev-monitor.c b/qdev-monitor.c
index 0aa8a6c60b..77bb1993ed 100644
--- a/qdev-monitor.c
+++ b/qdev-monitor.c
@@ -29,6 +29,7 @@
 #include "qemu/config-file.h"
 #include "qemu/error-report.h"
 #include "qemu/help_option.h"
+#include "qemu/option.h"
 #include "sysemu/block-backend.h"
 #include "migration/misc.h"
=20
diff --git a/qemu-io-cmds.c b/qemu-io-cmds.c
index a6a70fc3dc..9b3cd00af6 100644
--- a/qemu-io-cmds.c
+++ b/qemu-io-cmds.c
@@ -17,6 +17,7 @@
 #include "block/qapi.h"
 #include "qemu/error-report.h"
 #include "qemu/main-loop.h"
+#include "qemu/option.h"
 #include "qemu/timer.h"
 #include "qemu/cutils.h"
=20
diff --git a/qemu-nbd.c b/qemu-nbd.c
index 6ff8ef41e9..ed5d9b5062 100644
--- a/qemu-nbd.c
+++ b/qemu-nbd.c
@@ -22,12 +22,12 @@
 #include <pthread.h>
=20
 #include "qapi/error.h"
-#include "qemu-common.h"
 #include "qemu/cutils.h"
 #include "sysemu/block-backend.h"
 #include "block/block_int.h"
 #include "block/nbd.h"
 #include "qemu/main-loop.h"
+#include "qemu/option.h"
 #include "qemu/error-report.h"
 #include "qemu/config-file.h"
 #include "qemu/bswap.h"
diff --git a/qmp.c b/qmp.c
index f87de2bc26..d53021f7d4 100644
--- a/qmp.c
+++ b/qmp.c
@@ -16,6 +16,7 @@
 #include "qemu/osdep.h"
 #include "qemu-version.h"
 #include "qemu/cutils.h"
+#include "qemu/option.h"
 #include "monitor/monitor.h"
 #include "sysemu/sysemu.h"
 #include "qemu/config-file.h"
diff --git a/qom/object_interfaces.c b/qom/object_interfaces.c
index 2719df3bae..80d09139be 100644
--- a/qom/object_interfaces.c
+++ b/qom/object_interfaces.c
@@ -3,6 +3,7 @@
 #include "qapi/qmp/qdict.h"
 #include "qom/object_interfaces.h"
 #include "qemu/module.h"
+#include "qemu/option.h"
 #include "qapi-visit.h"
 #include "qapi/opts-visitor.h"
 #include "qemu/config-file.h"
diff --git a/replay/replay.c b/replay/replay.c
index ff58a5adf9..7a23c62d61 100644
--- a/replay/replay.c
+++ b/replay/replay.c
@@ -11,11 +11,11 @@
=20
 #include "qemu/osdep.h"
 #include "qapi/error.h"
-#include "qemu-common.h"
 #include "sysemu/replay.h"
 #include "replay-internal.h"
 #include "qemu/timer.h"
 #include "qemu/main-loop.h"
+#include "qemu/option.h"
 #include "sysemu/cpus.h"
 #include "sysemu/sysemu.h"
 #include "qemu/error-report.h"
diff --git a/tests/test-char.c b/tests/test-char.c
index 911e3f6e8d..b17d094b85 100644
--- a/tests/test-char.c
+++ b/tests/test-char.c
@@ -1,8 +1,8 @@
 #include "qemu/osdep.h"
 #include <glib/gstdio.h>
=20
-#include "qemu-common.h"
 #include "qemu/config-file.h"
+#include "qemu/option.h"
 #include "qemu/sockets.h"
 #include "chardev/char-fe.h"
 #include "chardev/char-mux.h"
diff --git a/tests/test-qemu-opts.c b/tests/test-qemu-opts.c
index b37d695c28..5d5a3daa7b 100644
--- a/tests/test-qemu-opts.c
+++ b/tests/test-qemu-opts.c
@@ -9,6 +9,7 @@
=20
 #include "qemu/osdep.h"
 #include "qemu/cutils.h"
+#include "qemu/option.h"
 #include "qapi/error.h"
 #include "qapi/qmp/qdict.h"
 #include "qapi/qmp/qstring.h"
diff --git a/tests/test-replication.c b/tests/test-replication.c
index 31372777ae..68c0d04f2a 100644
--- a/tests/test-replication.c
+++ b/tests/test-replication.c
@@ -12,6 +12,7 @@
=20
 #include "qapi/error.h"
 #include "qapi/qmp/qdict.h"
+#include "qemu/option.h"
 #include "replication.h"
 #include "block/block_int.h"
 #include "sysemu/block-backend.h"
diff --git a/trace/control.c b/trace/control.c
index 2769934bec..e40cfca775 100644
--- a/trace/control.c
+++ b/trace/control.c
@@ -10,6 +10,7 @@
 #include "qemu/osdep.h"
 #include "trace/control.h"
 #include "qemu/help_option.h"
+#include "qemu/option.h"
 #ifdef CONFIG_TRACE_SIMPLE
 #include "trace/simple.h"
 #endif
diff --git a/ui/console.c b/ui/console.c
index f678979f86..36584d039e 100644
--- a/ui/console.c
+++ b/ui/console.c
@@ -23,10 +23,10 @@
  */
=20
 #include "qemu/osdep.h"
-#include "qemu-common.h"
 #include "ui/console.h"
 #include "hw/qdev-core.h"
 #include "qapi/error.h"
+#include "qemu/option.h"
 #include "qemu/timer.h"
 #include "qmp-commands.h"
 #include "chardev/char-fe.h"
diff --git a/ui/spice-core.c b/ui/spice-core.c
index 64ed759be5..e449172fe9 100644
--- a/ui/spice-core.c
+++ b/ui/spice-core.c
@@ -21,7 +21,6 @@
 #include <netdb.h>
 #include "sysemu/sysemu.h"
=20
-#include "qemu-common.h"
 #include "ui/qemu-spice.h"
 #include "qemu/error-report.h"
 #include "qemu/thread.h"
@@ -32,6 +31,7 @@
 #include "qmp-commands.h"
 #include "qapi/error.h"
 #include "qemu/notify.h"
+#include "qemu/option.h"
 #include "migration/misc.h"
 #include "hw/hw.h"
 #include "ui/spice-display.h"
diff --git a/ui/spice-display.c b/ui/spice-display.c
index efe9c57eb5..98ccdfb687 100644
--- a/ui/spice-display.c
+++ b/ui/spice-display.c
@@ -16,9 +16,9 @@
  */
=20
 #include "qemu/osdep.h"
-#include "qemu-common.h"
 #include "ui/qemu-spice.h"
 #include "qemu/timer.h"
+#include "qemu/option.h"
 #include "qemu/queue.h"
 #include "ui/console.h"
 #include "sysemu/sysemu.h"
diff --git a/ui/vnc.c b/ui/vnc.c
index a34b128193..c715bae1cf 100644
--- a/ui/vnc.c
+++ b/ui/vnc.c
@@ -30,6 +30,7 @@
 #include "trace.h"
 #include "sysemu/sysemu.h"
 #include "qemu/error-report.h"
+#include "qemu/option.h"
 #include "qemu/sockets.h"
 #include "qemu/timer.h"
 #include "qemu/acl.h"
--=20
2.13.6

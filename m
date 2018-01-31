Received: from eggs.gnu.org ([2001:4830:134:3::10]:50955)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1egth5-00005s-Ej
	for qemu-devel@nongnu.org; Wed, 31 Jan 2018 09:49:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1egth0-0003eX-1S
	for qemu-devel@nongnu.org; Wed, 31 Jan 2018 09:48:59 -0500
Received: from mx1.redhat.com ([209.132.183.28]:37500)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1egtgz-0003df-Me
	for qemu-devel@nongnu.org; Wed, 31 Jan 2018 09:48:53 -0500
From: Markus Armbruster <armbru@redhat.com>
Date: Wed, 31 Jan 2018 15:48:39 +0100
Message-Id: <20180131144846.31697-13-armbru@redhat.com>
In-Reply-To: <20180131144846.31697-1-armbru@redhat.com>
References: <20180131144846.31697-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 12/19] Include qapi/qmp/qdict.h exactly
 where needed
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: balaton@eik.bme.hu, eblake@redhat.com, f4bug@amsat.org

This cleanup makes the number of objects depending on qapi/qmp/qdict.h
drop from 4550 (out of 4743) to 368 in my "build everything" tree.
For qapi/qmp/qobject.h, the number drops from 4552 to 390.

While there, separate #include from file comment with a blank line.

Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 block/crypto.c                      | 1 +
 block/curl.c                        | 2 ++
 block/file-win32.c                  | 1 +
 block/gluster.c                     | 1 +
 block/qcow.c                        | 2 ++
 block/rbd.c                         | 1 +
 block/snapshot.c                    | 1 +
 block/ssh.c                         | 1 +
 block/vvfat.c                       | 2 ++
 device-hotplug.c                    | 1 +
 hmp.h                               | 1 -
 hw/pci/pcie_aer.c                   | 1 +
 hw/s390x/s390-stattrib.c            | 1 +
 hw/usb/xen-usb.c                    | 1 +
 include/block/block.h               | 1 +
 include/block/dirty-bitmap.h        | 1 +
 include/hw/block/block.h            | 1 +
 include/hw/block/fdc.h              | 1 +
 include/hw/loader.h                 | 1 -
 include/migration/colo.h            | 1 +
 include/migration/failover.h        | 1 +
 include/monitor/monitor.h           | 1 -
 include/net/net.h                   | 2 +-
 include/net/slirp.h                 | 1 -
 include/qapi/qmp-event.h            | 1 -
 include/qapi/qmp/dispatch.h         | 2 +-
 include/qemu/config-file.h          | 1 -
 include/qemu/option.h               | 1 -
 include/qemu/throttle.h             | 1 +
 include/qom/object_interfaces.h     | 1 -
 include/scsi/pr-manager.h           | 1 -
 include/sysemu/arch_init.h          | 1 +
 include/ui/console.h                | 1 -
 migration/ram.h                     | 1 +
 net/slirp.c                         | 2 ++
 net/tap_int.h                       | 1 +
 qapi/qmp-dispatch.c                 | 1 +
 qapi/qmp-event.c                    | 1 +
 qapi/qobject-input-visitor.c        | 1 +
 qapi/qobject-output-visitor.c       | 1 +
 qemu-img.c                          | 2 ++
 qemu-io.c                           | 2 ++
 qemu-nbd.c                          | 1 +
 qobject/json-parser.c               | 1 +
 qobject/qjson.c                     | 1 +
 qom/object_interfaces.c             | 1 +
 target/i386/cpu.c                   | 1 +
 target/i386/monitor.c               | 2 ++
 target/s390x/cpu_models.c           | 1 +
 tests/ahci-test.c                   | 1 +
 tests/check-qobject.c               | 1 +
 tests/cpu-plug-test.c               | 1 +
 tests/drive_del-test.c              | 1 +
 tests/libqos/libqos.c               | 1 +
 tests/libqos/pci-pc.c               | 2 +-
 tests/libqtest.c                    | 1 +
 tests/libqtest.h                    | 2 --
 tests/migration-test.c              | 1 +
 tests/numa-test.c                   | 1 +
 tests/pvpanic-test.c                | 1 +
 tests/q35-test.c                    | 1 +
 tests/qmp-test.c                    | 1 +
 tests/qom-test.c                    | 1 +
 tests/tco-test.c                    | 2 ++
 tests/test-keyval.c                 | 1 +
 tests/test-netfilter.c              | 1 +
 tests/test-qemu-opts.c              | 1 +
 tests/test-qga.c                    | 1 +
 tests/test-qmp-event.c              | 1 +
 tests/test-qobject-input-visitor.c  | 1 +
 tests/test-qobject-output-visitor.c | 1 +
 tests/test-replication.c            | 1 +
 tests/tmp105-test.c                 | 1 +
 tests/vhost-user-test.c             | 1 +
 tests/virtio-net-test.c             | 1 +
 tests/vmgenid-test.c                | 1 +
 tests/wdt_ib700-test.c              | 1 +
 util/keyval.c                       | 1 +
 78 files changed, 75 insertions(+), 15 deletions(-)

diff --git a/block/crypto.c b/block/crypto.c
index 60ddf8623e..2626f8ae3a 100644
--- a/block/crypto.c
+++ b/block/crypto.c
@@ -24,6 +24,7 @@
 #include "sysemu/block-backend.h"
 #include "crypto/block.h"
 #include "qapi/opts-visitor.h"
+#include "qapi/qmp/qdict.h"
 #include "qapi/qobject-input-visitor.h"
 #include "qapi-visit.h"
 #include "qapi/error.h"
diff --git a/block/curl.c b/block/curl.c
index 35cf417f59..e0eb8ebb78 100644
--- a/block/curl.c
+++ b/block/curl.c
@@ -21,12 +21,14 @@
  * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALING=
S IN
  * THE SOFTWARE.
  */
+
 #include "qemu/osdep.h"
 #include "qapi/error.h"
 #include "qemu-common.h"
 #include "qemu/error-report.h"
 #include "block/block_int.h"
 #include "qapi/qmp/qbool.h"
+#include "qapi/qmp/qdict.h"
 #include "qapi/qmp/qstring.h"
 #include "crypto/secret.h"
 #include <curl/curl.h>
diff --git a/block/file-win32.c b/block/file-win32.c
index 9e02214a69..2f1da48e71 100644
--- a/block/file-win32.c
+++ b/block/file-win32.c
@@ -30,6 +30,7 @@
 #include "trace.h"
 #include "block/thread-pool.h"
 #include "qemu/iov.h"
+#include "qapi/qmp/qdict.h"
 #include "qapi/qmp/qstring.h"
 #include <windows.h>
 #include <winioctl.h>
diff --git a/block/gluster.c b/block/gluster.c
index 0f4265a3a4..097b6930a5 100644
--- a/block/gluster.c
+++ b/block/gluster.c
@@ -11,6 +11,7 @@
 #include <glusterfs/api/glfs.h>
 #include "block/block_int.h"
 #include "qapi/error.h"
+#include "qapi/qmp/qdict.h"
 #include "qapi/qmp/qerror.h"
 #include "qemu/uri.h"
 #include "qemu/error-report.h"
diff --git a/block/qcow.c b/block/qcow.c
index 369241aae8..0b32c04cd0 100644
--- a/block/qcow.c
+++ b/block/qcow.c
@@ -21,6 +21,7 @@
  * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALING=
S IN
  * THE SOFTWARE.
  */
+
 #include "qemu/osdep.h"
 #include "qapi/error.h"
 #include "qemu-common.h"
@@ -30,6 +31,7 @@
 #include "qemu/module.h"
 #include "qemu/bswap.h"
 #include <zlib.h>
+#include "qapi/qmp/qdict.h"
 #include "qapi/qmp/qstring.h"
 #include "crypto/block.h"
 #include "migration/blocker.h"
diff --git a/block/rbd.c b/block/rbd.c
index 76b9e83cea..42be5ed49d 100644
--- a/block/rbd.c
+++ b/block/rbd.c
@@ -20,6 +20,7 @@
 #include "crypto/secret.h"
 #include "qemu/cutils.h"
 #include "qapi/qmp/qstring.h"
+#include "qapi/qmp/qdict.h"
 #include "qapi/qmp/qjson.h"
 #include "qapi/qmp/qlist.h"
=20
diff --git a/block/snapshot.c b/block/snapshot.c
index 8cb70dbad5..9294a9fcc4 100644
--- a/block/snapshot.c
+++ b/block/snapshot.c
@@ -26,6 +26,7 @@
 #include "block/snapshot.h"
 #include "block/block_int.h"
 #include "qapi/error.h"
+#include "qapi/qmp/qdict.h"
 #include "qapi/qmp/qerror.h"
 #include "qapi/qmp/qstring.h"
=20
diff --git a/block/ssh.c b/block/ssh.c
index b049a16eb9..c693a4a4c7 100644
--- a/block/ssh.c
+++ b/block/ssh.c
@@ -34,6 +34,7 @@
 #include "qemu/sockets.h"
 #include "qemu/uri.h"
 #include "qapi-visit.h"
+#include "qapi/qmp/qdict.h"
 #include "qapi/qmp/qstring.h"
 #include "qapi/qobject-input-visitor.h"
 #include "qapi/qobject-output-visitor.h"
diff --git a/block/vvfat.c b/block/vvfat.c
index a690595f2c..93e76580b0 100644
--- a/block/vvfat.c
+++ b/block/vvfat.c
@@ -22,6 +22,7 @@
  * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALING=
S IN
  * THE SOFTWARE.
  */
+
 #include "qemu/osdep.h"
 #include <dirent.h>
 #include "qapi/error.h"
@@ -30,6 +31,7 @@
 #include "qemu/bswap.h"
 #include "migration/blocker.h"
 #include "qapi/qmp/qbool.h"
+#include "qapi/qmp/qdict.h"
 #include "qapi/qmp/qstring.h"
 #include "qemu/cutils.h"
 #include "qemu/error-report.h"
diff --git a/device-hotplug.c b/device-hotplug.c
index 126f73c676..b10e8cc6d4 100644
--- a/device-hotplug.c
+++ b/device-hotplug.c
@@ -27,6 +27,7 @@
 #include "hw/boards.h"
 #include "sysemu/block-backend.h"
 #include "sysemu/blockdev.h"
+#include "qapi/qmp/qdict.h"
 #include "qemu/config-file.h"
 #include "sysemu/sysemu.h"
 #include "monitor/monitor.h"
diff --git a/hmp.h b/hmp.h
index dbb40ebbfa..4d633af86c 100644
--- a/hmp.h
+++ b/hmp.h
@@ -16,7 +16,6 @@
=20
 #include "qemu-common.h"
 #include "qemu/readline.h"
-#include "qapi/qmp/qdict.h"
=20
 void hmp_info_name(Monitor *mon, const QDict *qdict);
 void hmp_info_version(Monitor *mon, const QDict *qdict);
diff --git a/hw/pci/pcie_aer.c b/hw/pci/pcie_aer.c
index 071e5e9bbb..0b55392fe7 100644
--- a/hw/pci/pcie_aer.c
+++ b/hw/pci/pcie_aer.c
@@ -20,6 +20,7 @@
=20
 #include "qemu/osdep.h"
 #include "sysemu/sysemu.h"
+#include "qapi/qmp/qdict.h"
 #include "qapi/qmp/qjson.h"
 #include "monitor/monitor.h"
 #include "hw/pci/pci_bridge.h"
diff --git a/hw/s390x/s390-stattrib.c b/hw/s390x/s390-stattrib.c
index c6c06b2780..a1d2135a60 100644
--- a/hw/s390x/s390-stattrib.c
+++ b/hw/s390x/s390-stattrib.c
@@ -18,6 +18,7 @@
 #include "qemu/error-report.h"
 #include "exec/ram_addr.h"
 #include "qapi/error.h"
+#include "qapi/qmp/qdict.h"
=20
 #define CMMA_BLOCK_SIZE  (1 << 10)
=20
diff --git a/hw/usb/xen-usb.c b/hw/usb/xen-usb.c
index 584a6f2442..3b678685e1 100644
--- a/hw/usb/xen-usb.c
+++ b/hw/usb/xen-usb.c
@@ -30,6 +30,7 @@
 #include "hw/xen/xen_backend.h"
 #include "monitor/qdev.h"
 #include "qapi/qmp/qbool.h"
+#include "qapi/qmp/qdict.h"
 #include "qapi/qmp/qstring.h"
=20
 #include "hw/xen/io/ring.h"
diff --git a/include/block/block.h b/include/block/block.h
index 62ba19d78d..d2fc44dd30 100644
--- a/include/block/block.h
+++ b/include/block/block.h
@@ -2,6 +2,7 @@
 #define BLOCK_H
=20
 #include "block/aio.h"
+#include "qapi-types.h"
 #include "qemu/iov.h"
 #include "qemu/option.h"
 #include "qemu/coroutine.h"
diff --git a/include/block/dirty-bitmap.h b/include/block/dirty-bitmap.h
index a591c27213..3da8486ab1 100644
--- a/include/block/dirty-bitmap.h
+++ b/include/block/dirty-bitmap.h
@@ -2,6 +2,7 @@
 #define BLOCK_DIRTY_BITMAP_H
=20
 #include "qemu-common.h"
+#include "qapi-types.h"
 #include "qemu/hbitmap.h"
=20
 BdrvDirtyBitmap *bdrv_create_dirty_bitmap(BlockDriverState *bs,
diff --git a/include/hw/block/block.h b/include/hw/block/block.h
index 64b9298829..f532d10e35 100644
--- a/include/hw/block/block.h
+++ b/include/hw/block/block.h
@@ -12,6 +12,7 @@
 #define HW_BLOCK_H
=20
 #include "qemu-common.h"
+#include "qapi-types.h"
=20
 /* Configuration */
=20
diff --git a/include/hw/block/fdc.h b/include/hw/block/fdc.h
index 1749dabf25..68a0c904ea 100644
--- a/include/hw/block/fdc.h
+++ b/include/hw/block/fdc.h
@@ -2,6 +2,7 @@
 #define HW_FDC_H
=20
 #include "qemu-common.h"
+#include "qapi-types.h"
=20
 /* fdc.c */
 #define MAX_FD 2
diff --git a/include/hw/loader.h b/include/hw/loader.h
index 355fe0f5a2..5edbe02b1c 100644
--- a/include/hw/loader.h
+++ b/include/hw/loader.h
@@ -1,6 +1,5 @@
 #ifndef LOADER_H
 #define LOADER_H
-#include "qapi/qmp/qdict.h"
 #include "hw/nvram/fw_cfg.h"
=20
 /* loader.c */
diff --git a/include/migration/colo.h b/include/migration/colo.h
index ff9874ea16..50ace16205 100644
--- a/include/migration/colo.h
+++ b/include/migration/colo.h
@@ -14,6 +14,7 @@
 #define QEMU_COLO_H
=20
 #include "qemu-common.h"
+#include "qapi-types.h"
=20
 void colo_info_init(void);
=20
diff --git a/include/migration/failover.h b/include/migration/failover.h
index 9283d602e6..ad91ef2381 100644
--- a/include/migration/failover.h
+++ b/include/migration/failover.h
@@ -14,6 +14,7 @@
 #define QEMU_FAILOVER_H
=20
 #include "qemu-common.h"
+#include "qapi-types.h"
=20
 void failover_init_state(void);
 FailoverStatus failover_set_state(FailoverStatus old_state,
diff --git a/include/monitor/monitor.h b/include/monitor/monitor.h
index 83ea4a1aaf..ad64ad8e68 100644
--- a/include/monitor/monitor.h
+++ b/include/monitor/monitor.h
@@ -2,7 +2,6 @@
 #define MONITOR_H
=20
 #include "qemu-common.h"
-#include "qapi/qmp/qdict.h"
 #include "block/block.h"
 #include "qemu/readline.h"
=20
diff --git a/include/net/net.h b/include/net/net.h
index eefb259e0a..71f1119bc9 100644
--- a/include/net/net.h
+++ b/include/net/net.h
@@ -3,7 +3,7 @@
=20
 #include "qemu/queue.h"
 #include "qemu-common.h"
-#include "qapi/qmp/qdict.h"
+#include "qapi-types.h"
 #include "qemu/option.h"
 #include "net/queue.h"
 #include "migration/vmstate.h"
diff --git a/include/net/slirp.h b/include/net/slirp.h
index 865d2fca36..9a492b84a4 100644
--- a/include/net/slirp.h
+++ b/include/net/slirp.h
@@ -25,7 +25,6 @@
 #define QEMU_NET_SLIRP_H
=20
 #include "qemu-common.h"
-#include "qapi/qmp/qdict.h"
 #include "qemu/option.h"
=20
 #ifdef CONFIG_SLIRP
diff --git a/include/qapi/qmp-event.h b/include/qapi/qmp-event.h
index 40fe3cbc12..0c87ad833e 100644
--- a/include/qapi/qmp-event.h
+++ b/include/qapi/qmp-event.h
@@ -14,7 +14,6 @@
 #ifndef QMP_EVENT_H
 #define QMP_EVENT_H
=20
-#include "qapi/qmp/qdict.h"
=20
 typedef void (*QMPEventFuncEmit)(unsigned event, QDict *dict, Error **er=
rp);
=20
diff --git a/include/qapi/qmp/dispatch.h b/include/qapi/qmp/dispatch.h
index 47a0ff348b..1e694b5ecf 100644
--- a/include/qapi/qmp/dispatch.h
+++ b/include/qapi/qmp/dispatch.h
@@ -14,7 +14,7 @@
 #ifndef QAPI_QMP_DISPATCH_H
 #define QAPI_QMP_DISPATCH_H
=20
-#include "qapi/qmp/qdict.h"
+#include "qemu/queue.h"
=20
 typedef void (QmpCommandFunc)(QDict *, QObject **, Error **);
=20
diff --git a/include/qemu/config-file.h b/include/qemu/config-file.h
index c80d5c8a33..449e631c86 100644
--- a/include/qemu/config-file.h
+++ b/include/qemu/config-file.h
@@ -2,7 +2,6 @@
 #define QEMU_CONFIG_FILE_H
=20
 #include "qemu/option.h"
-#include "qapi/qmp/qdict.h"
=20
 QemuOptsList *qemu_find_opts(const char *group);
 QemuOptsList *qemu_find_opts_err(const char *group, Error **errp);
diff --git a/include/qemu/option.h b/include/qemu/option.h
index a88c5f02b1..b127fb6db6 100644
--- a/include/qemu/option.h
+++ b/include/qemu/option.h
@@ -27,7 +27,6 @@
 #define QEMU_OPTION_H
=20
 #include "qemu/queue.h"
-#include "qapi/qmp/qdict.h"
=20
 const char *get_opt_name(char *buf, int buf_size, const char *p, char de=
lim);
 const char *get_opt_value(char *buf, int buf_size, const char *p);
diff --git a/include/qemu/throttle.h b/include/qemu/throttle.h
index 8c93237866..03d45f44f8 100644
--- a/include/qemu/throttle.h
+++ b/include/qemu/throttle.h
@@ -26,6 +26,7 @@
 #define THROTTLE_H
=20
 #include "qemu-common.h"
+#include "qapi-types.h"
 #include "qemu/timer.h"
=20
 #define THROTTLE_VALUE_MAX 1000000000000000LL
diff --git a/include/qom/object_interfaces.h b/include/qom/object_interfa=
ces.h
index d23e11bc53..4d513fb329 100644
--- a/include/qom/object_interfaces.h
+++ b/include/qom/object_interfaces.h
@@ -2,7 +2,6 @@
 #define OBJECT_INTERFACES_H
=20
 #include "qom/object.h"
-#include "qapi/qmp/qdict.h"
 #include "qapi/visitor.h"
=20
 #define TYPE_USER_CREATABLE "user-creatable"
diff --git a/include/scsi/pr-manager.h b/include/scsi/pr-manager.h
index b2b37d63bc..5d2f13a5e4 100644
--- a/include/scsi/pr-manager.h
+++ b/include/scsi/pr-manager.h
@@ -2,7 +2,6 @@
 #define PR_MANAGER_H
=20
 #include "qom/object.h"
-#include "qapi/qmp/qdict.h"
 #include "qapi/visitor.h"
 #include "qom/object_interfaces.h"
 #include "block/aio.h"
diff --git a/include/sysemu/arch_init.h b/include/sysemu/arch_init.h
index 90b38aecdd..c9e786b6ac 100644
--- a/include/sysemu/arch_init.h
+++ b/include/sysemu/arch_init.h
@@ -1,6 +1,7 @@
 #ifndef QEMU_ARCH_INIT_H
 #define QEMU_ARCH_INIT_H
=20
+#include "qapi-types.h"
 #include "qemu/option.h"
=20
 enum {
diff --git a/include/ui/console.h b/include/ui/console.h
index d48bfcc4d9..c2cf993b8c 100644
--- a/include/ui/console.h
+++ b/include/ui/console.h
@@ -3,7 +3,6 @@
=20
 #include "ui/qemu-pixman.h"
 #include "qom/object.h"
-#include "qapi/qmp/qdict.h"
 #include "qemu/notify.h"
 #include "qemu/error-report.h"
 #ifndef CONFIG_VNC
diff --git a/migration/ram.h b/migration/ram.h
index 64d81e9f1d..f3a227b4fc 100644
--- a/migration/ram.h
+++ b/migration/ram.h
@@ -30,6 +30,7 @@
 #define QEMU_MIGRATION_RAM_H
=20
 #include "qemu-common.h"
+#include "qapi-types.h"
 #include "exec/cpu-common.h"
=20
 extern MigrationStats ram_counters;
diff --git a/net/slirp.c b/net/slirp.c
index cb8ca2312f..8481c2d65f 100644
--- a/net/slirp.c
+++ b/net/slirp.c
@@ -21,6 +21,7 @@
  * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALING=
S IN
  * THE SOFTWARE.
  */
+
 #include "qemu/osdep.h"
 #include "net/slirp.h"
=20
@@ -41,6 +42,7 @@
 #include "sysemu/sysemu.h"
 #include "qemu/cutils.h"
 #include "qapi/error.h"
+#include "qapi/qmp/qdict.h"
=20
 static int get_str_sep(char *buf, int buf_size, const char **pp, int sep=
)
 {
diff --git a/net/tap_int.h b/net/tap_int.h
index e3a14d5dda..ae6888f74a 100644
--- a/net/tap_int.h
+++ b/net/tap_int.h
@@ -27,6 +27,7 @@
 #define NET_TAP_INT_H
=20
 #include "qemu-common.h"
+#include "qapi-types.h"
=20
 int tap_open(char *ifname, int ifname_size, int *vnet_hdr,
              int vnet_hdr_required, int mq_required, Error **errp);
diff --git a/qapi/qmp-dispatch.c b/qapi/qmp-dispatch.c
index 92f957f40e..e31ac4be1f 100644
--- a/qapi/qmp-dispatch.c
+++ b/qapi/qmp-dispatch.c
@@ -15,6 +15,7 @@
 #include "qapi/error.h"
 #include "qapi/qmp/dispatch.h"
 #include "qapi/qmp/json-parser.h"
+#include "qapi/qmp/qdict.h"
 #include "qapi/qmp/qjson.h"
=20
 static QDict *qmp_dispatch_check_obj(const QObject *request, Error **err=
p)
diff --git a/qapi/qmp-event.c b/qapi/qmp-event.c
index ba3029cc89..9d7e88e84a 100644
--- a/qapi/qmp-event.c
+++ b/qapi/qmp-event.c
@@ -16,6 +16,7 @@
 #include "qemu-common.h"
 #include "qapi/qmp-event.h"
 #include "qapi/qmp/qstring.h"
+#include "qapi/qmp/qdict.h"
 #include "qapi/qmp/qjson.h"
=20
 static QMPEventFuncEmit qmp_emit;
diff --git a/qapi/qobject-input-visitor.c b/qapi/qobject-input-visitor.c
index 3e235a1eee..3566eed365 100644
--- a/qapi/qobject-input-visitor.c
+++ b/qapi/qobject-input-visitor.c
@@ -21,6 +21,7 @@
 #include "qemu-common.h"
 #include "qapi/qmp/qjson.h"
 #include "qapi/qmp/qbool.h"
+#include "qapi/qmp/qdict.h"
 #include "qapi/qmp/qerror.h"
 #include "qapi/qmp/qlist.h"
 #include "qapi/qmp/qnull.h"
diff --git a/qapi/qobject-output-visitor.c b/qapi/qobject-output-visitor.=
c
index 52634b9725..7c3b42cfe2 100644
--- a/qapi/qobject-output-visitor.c
+++ b/qapi/qobject-output-visitor.c
@@ -18,6 +18,7 @@
 #include "qemu/queue.h"
 #include "qemu-common.h"
 #include "qapi/qmp/qbool.h"
+#include "qapi/qmp/qdict.h"
 #include "qapi/qmp/qlist.h"
 #include "qapi/qmp/qnull.h"
 #include "qapi/qmp/qnum.h"
diff --git a/qemu-img.c b/qemu-img.c
index cf8db3d7b7..fc6b4ffc00 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -21,6 +21,7 @@
  * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALING=
S IN
  * THE SOFTWARE.
  */
+
 #include "qemu/osdep.h"
 #include <getopt.h>
=20
@@ -30,6 +31,7 @@
 #include "qapi/qobject-output-visitor.h"
 #include "qapi/qmp/qjson.h"
 #include "qapi/qmp/qbool.h"
+#include "qapi/qmp/qdict.h"
 #include "qemu/cutils.h"
 #include "qemu/config-file.h"
 #include "qemu/option.h"
diff --git a/qemu-io.c b/qemu-io.c
index c70bde3eb1..2e5737ce9c 100644
--- a/qemu-io.c
+++ b/qemu-io.c
@@ -7,6 +7,7 @@
  * This work is licensed under the terms of the GNU GPL, version 2 or la=
ter.
  * See the COPYING file in the top-level directory.
  */
+
 #include "qemu/osdep.h"
 #include <getopt.h>
 #include <libgen.h>
@@ -21,6 +22,7 @@
 #include "qemu/log.h"
 #include "qapi/qmp/qstring.h"
 #include "qapi/qmp/qbool.h"
+#include "qapi/qmp/qdict.h"
 #include "qom/object_interfaces.h"
 #include "sysemu/block-backend.h"
 #include "block/block_int.h"
diff --git a/qemu-nbd.c b/qemu-nbd.c
index 3723493be1..6ff8ef41e9 100644
--- a/qemu-nbd.c
+++ b/qemu-nbd.c
@@ -34,6 +34,7 @@
 #include "qemu/log.h"
 #include "qemu/systemd.h"
 #include "block/snapshot.h"
+#include "qapi/qmp/qdict.h"
 #include "qapi/qmp/qstring.h"
 #include "qom/object_interfaces.h"
 #include "io/channel-socket.h"
diff --git a/qobject/json-parser.c b/qobject/json-parser.c
index ee0cbba6a5..b724562415 100644
--- a/qobject/json-parser.c
+++ b/qobject/json-parser.c
@@ -16,6 +16,7 @@
 #include "qapi/error.h"
 #include "qemu-common.h"
 #include "qapi/qmp/qbool.h"
+#include "qapi/qmp/qdict.h"
 #include "qapi/qmp/qlist.h"
 #include "qapi/qmp/qnull.h"
 #include "qapi/qmp/qnum.h"
diff --git a/qobject/qjson.c b/qobject/qjson.c
index 527b5bb571..77f796bbee 100644
--- a/qobject/qjson.c
+++ b/qobject/qjson.c
@@ -18,6 +18,7 @@
 #include "qapi/qmp/json-streamer.h"
 #include "qapi/qmp/qjson.h"
 #include "qapi/qmp/qbool.h"
+#include "qapi/qmp/qdict.h"
 #include "qapi/qmp/qlist.h"
 #include "qapi/qmp/qnum.h"
 #include "qemu/unicode.h"
diff --git a/qom/object_interfaces.c b/qom/object_interfaces.c
index 6824a88caa..2719df3bae 100644
--- a/qom/object_interfaces.c
+++ b/qom/object_interfaces.c
@@ -1,5 +1,6 @@
 #include "qemu/osdep.h"
 #include "qapi/error.h"
+#include "qapi/qmp/qdict.h"
 #include "qom/object_interfaces.h"
 #include "qemu/module.h"
 #include "qapi-visit.h"
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 6627e98bdf..36c555e372 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -31,6 +31,7 @@
 #include "qemu/option.h"
 #include "qemu/config-file.h"
 #include "qapi/error.h"
+#include "qapi/qmp/qdict.h"
 #include "qapi/qmp/qerror.h"
=20
 #include "qapi-visit.h"
diff --git a/target/i386/monitor.c b/target/i386/monitor.c
index 75e155ffb1..75429129fd 100644
--- a/target/i386/monitor.c
+++ b/target/i386/monitor.c
@@ -21,10 +21,12 @@
  * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALING=
S IN
  * THE SOFTWARE.
  */
+
 #include "qemu/osdep.h"
 #include "cpu.h"
 #include "monitor/monitor.h"
 #include "monitor/hmp-target.h"
+#include "qapi/qmp/qdict.h"
 #include "hw/i386/pc.h"
 #include "sysemu/kvm.h"
 #include "hmp.h"
diff --git a/target/s390x/cpu_models.c b/target/s390x/cpu_models.c
index 212a5f0697..27201c4f91 100644
--- a/target/s390x/cpu_models.c
+++ b/target/s390x/cpu_models.c
@@ -21,6 +21,7 @@
 #include "qapi/qmp/qerror.h"
 #include "qapi/qobject-input-visitor.h"
 #include "qapi/qmp/qbool.h"
+#include "qapi/qmp/qdict.h"
 #ifndef CONFIG_USER_ONLY
 #include "sysemu/arch_init.h"
 #endif
diff --git a/tests/ahci-test.c b/tests/ahci-test.c
index 3934e62ef7..7aa5af428c 100644
--- a/tests/ahci-test.c
+++ b/tests/ahci-test.c
@@ -31,6 +31,7 @@
 #include "libqos/pci-pc.h"
=20
 #include "qemu-common.h"
+#include "qapi/qmp/qdict.h"
 #include "qemu/host-utils.h"
=20
 #include "hw/pci/pci_ids.h"
diff --git a/tests/check-qobject.c b/tests/check-qobject.c
index 885d0e3de6..7a3670643c 100644
--- a/tests/check-qobject.c
+++ b/tests/check-qobject.c
@@ -9,6 +9,7 @@
=20
 #include "qemu/osdep.h"
 #include "qapi/qmp/qbool.h"
+#include "qapi/qmp/qdict.h"
 #include "qapi/qmp/qlist.h"
 #include "qapi/qmp/qnull.h"
 #include "qapi/qmp/qnum.h"
diff --git a/tests/cpu-plug-test.c b/tests/cpu-plug-test.c
index 65456c9e37..8b5ab1fd02 100644
--- a/tests/cpu-plug-test.c
+++ b/tests/cpu-plug-test.c
@@ -11,6 +11,7 @@
=20
 #include "qemu-common.h"
 #include "libqtest.h"
+#include "qapi/qmp/qdict.h"
=20
 struct PlugTestData {
     char *machine;
diff --git a/tests/drive_del-test.c b/tests/drive_del-test.c
index c9ac997555..313030a14c 100644
--- a/tests/drive_del-test.c
+++ b/tests/drive_del-test.c
@@ -13,6 +13,7 @@
 #include "qemu/osdep.h"
 #include "libqtest.h"
 #include "libqos/virtio.h"
+#include "qapi/qmp/qdict.h"
=20
 static void drive_add(void)
 {
diff --git a/tests/libqos/libqos.c b/tests/libqos/libqos.c
index 991bc1aec2..306d4c06de 100644
--- a/tests/libqos/libqos.c
+++ b/tests/libqos/libqos.c
@@ -4,6 +4,7 @@
 #include "libqtest.h"
 #include "libqos/libqos.h"
 #include "libqos/pci.h"
+#include "qapi/qmp/qdict.h"
=20
 /*** Test Setup & Teardown ***/
=20
diff --git a/tests/libqos/pci-pc.c b/tests/libqos/pci-pc.c
index ded1c54c06..cd4e20e1ea 100644
--- a/tests/libqos/pci-pc.c
+++ b/tests/libqos/pci-pc.c
@@ -13,7 +13,7 @@
 #include "qemu/osdep.h"
 #include "libqtest.h"
 #include "libqos/pci-pc.h"
-
+#include "qapi/qmp/qdict.h"
 #include "hw/pci/pci_regs.h"
=20
 #include "qemu-common.h"
diff --git a/tests/libqtest.c b/tests/libqtest.c
index 16d60818a7..b65374c634 100644
--- a/tests/libqtest.c
+++ b/tests/libqtest.c
@@ -24,6 +24,7 @@
 #include "qapi/error.h"
 #include "qapi/qmp/json-parser.h"
 #include "qapi/qmp/json-streamer.h"
+#include "qapi/qmp/qdict.h"
 #include "qapi/qmp/qjson.h"
 #include "qapi/qmp/qlist.h"
=20
diff --git a/tests/libqtest.h b/tests/libqtest.h
index fe7847cbd5..811169453a 100644
--- a/tests/libqtest.h
+++ b/tests/libqtest.h
@@ -17,8 +17,6 @@
 #ifndef LIBQTEST_H
 #define LIBQTEST_H
=20
-#include "qapi/qmp/qdict.h"
-
 typedef struct QTestState QTestState;
=20
 extern QTestState *global_qtest;
diff --git a/tests/migration-test.c b/tests/migration-test.c
index 799e24ebc6..baafabaa5d 100644
--- a/tests/migration-test.c
+++ b/tests/migration-test.c
@@ -13,6 +13,7 @@
 #include "qemu/osdep.h"
=20
 #include "libqtest.h"
+#include "qapi/qmp/qdict.h"
 #include "qemu/option.h"
 #include "qemu/range.h"
 #include "qemu/sockets.h"
diff --git a/tests/numa-test.c b/tests/numa-test.c
index 8158854e17..68aca9cb38 100644
--- a/tests/numa-test.c
+++ b/tests/numa-test.c
@@ -11,6 +11,7 @@
=20
 #include "qemu/osdep.h"
 #include "libqtest.h"
+#include "qapi/qmp/qdict.h"
 #include "qapi/qmp/qlist.h"
=20
 static char *make_cli(const char *generic_cli, const char *test_cli)
diff --git a/tests/pvpanic-test.c b/tests/pvpanic-test.c
index 71ebb5c02c..ebdf32c2e2 100644
--- a/tests/pvpanic-test.c
+++ b/tests/pvpanic-test.c
@@ -9,6 +9,7 @@
=20
 #include "qemu/osdep.h"
 #include "libqtest.h"
+#include "qapi/qmp/qdict.h"
=20
 static void test_panic(void)
 {
diff --git a/tests/q35-test.c b/tests/q35-test.c
index f98bed7a2d..187d68fb7e 100644
--- a/tests/q35-test.c
+++ b/tests/q35-test.c
@@ -14,6 +14,7 @@
 #include "libqos/pci.h"
 #include "libqos/pci-pc.h"
 #include "hw/pci-host/q35.h"
+#include "qapi/qmp/qdict.h"
=20
 #define TSEG_SIZE_TEST_GUEST_RAM_MBYTES 128
=20
diff --git a/tests/qmp-test.c b/tests/qmp-test.c
index cc9661af47..908f9b981f 100644
--- a/tests/qmp-test.c
+++ b/tests/qmp-test.c
@@ -14,6 +14,7 @@
 #include "libqtest.h"
 #include "qapi-visit.h"
 #include "qapi/error.h"
+#include "qapi/qmp/qdict.h"
 #include "qapi/qmp/qlist.h"
 #include "qapi/qobject-input-visitor.h"
 #include "qapi/util.h"
diff --git a/tests/qom-test.c b/tests/qom-test.c
index 847703cb14..9dab7ac61e 100644
--- a/tests/qom-test.c
+++ b/tests/qom-test.c
@@ -10,6 +10,7 @@
 #include "qemu/osdep.h"
=20
 #include "qemu-common.h"
+#include "qapi/qmp/qdict.h"
 #include "qapi/qmp/qlist.h"
 #include "qemu/cutils.h"
 #include "libqtest.h"
diff --git a/tests/tco-test.c b/tests/tco-test.c
index 2616d33c29..8ab43d742a 100644
--- a/tests/tco-test.c
+++ b/tests/tco-test.c
@@ -6,11 +6,13 @@
  * This work is licensed under the terms of the GNU GPL, version 2 or la=
ter.
  * See the COPYING file in the top-level directory.
  */
+
 #include "qemu/osdep.h"
=20
 #include "libqtest.h"
 #include "libqos/pci.h"
 #include "libqos/pci-pc.h"
+#include "qapi/qmp/qdict.h"
 #include "hw/pci/pci_regs.h"
 #include "hw/i386/ich9.h"
 #include "hw/acpi/ich9.h"
diff --git a/tests/test-keyval.c b/tests/test-keyval.c
index d0c4bf2b9d..94eb4df28d 100644
--- a/tests/test-keyval.c
+++ b/tests/test-keyval.c
@@ -12,6 +12,7 @@
=20
 #include "qemu/osdep.h"
 #include "qapi/error.h"
+#include "qapi/qmp/qdict.h"
 #include "qapi/qmp/qlist.h"
 #include "qapi/qmp/qstring.h"
 #include "qapi/qobject-input-visitor.h"
diff --git a/tests/test-netfilter.c b/tests/test-netfilter.c
index 2506473365..95f7839aef 100644
--- a/tests/test-netfilter.c
+++ b/tests/test-netfilter.c
@@ -10,6 +10,7 @@
=20
 #include "qemu/osdep.h"
 #include "libqtest.h"
+#include "qapi/qmp/qdict.h"
=20
 /* add a netfilter to a netdev and then remove it */
 static void add_one_netfilter(void)
diff --git a/tests/test-qemu-opts.c b/tests/test-qemu-opts.c
index cc1bb1afdf..b37d695c28 100644
--- a/tests/test-qemu-opts.c
+++ b/tests/test-qemu-opts.c
@@ -10,6 +10,7 @@
 #include "qemu/osdep.h"
 #include "qemu/cutils.h"
 #include "qapi/error.h"
+#include "qapi/qmp/qdict.h"
 #include "qapi/qmp/qstring.h"
 #include "qemu/config-file.h"
=20
diff --git a/tests/test-qga.c b/tests/test-qga.c
index e67c7289eb..5c5b661f8a 100644
--- a/tests/test-qga.c
+++ b/tests/test-qga.c
@@ -5,6 +5,7 @@
 #include <sys/un.h>
=20
 #include "libqtest.h"
+#include "qapi/qmp/qdict.h"
 #include "qapi/qmp/qlist.h"
=20
 typedef struct {
diff --git a/tests/test-qmp-event.c b/tests/test-qmp-event.c
index e5ee69e9af..8012341343 100644
--- a/tests/test-qmp-event.c
+++ b/tests/test-qmp-event.c
@@ -18,6 +18,7 @@
 #include "test-qapi-event.h"
 #include "qapi/error.h"
 #include "qapi/qmp/qbool.h"
+#include "qapi/qmp/qdict.h"
 #include "qapi/qmp/qnum.h"
 #include "qapi/qmp/qstring.h"
 #include "qapi/qmp-event.h"
diff --git a/tests/test-qobject-input-visitor.c b/tests/test-qobject-inpu=
t-visitor.c
index 20bf9a5414..2e6f7f422f 100644
--- a/tests/test-qobject-input-visitor.c
+++ b/tests/test-qobject-input-visitor.c
@@ -18,6 +18,7 @@
 #include "qapi/qobject-input-visitor.h"
 #include "test-qapi-visit.h"
 #include "qapi/qmp/qbool.h"
+#include "qapi/qmp/qdict.h"
 #include "qapi/qmp/qnull.h"
 #include "qapi/qmp/qnum.h"
 #include "qapi/qmp/qjson.h"
diff --git a/tests/test-qobject-output-visitor.c b/tests/test-qobject-out=
put-visitor.c
index 7cf86707ec..09a56d2d06 100644
--- a/tests/test-qobject-output-visitor.c
+++ b/tests/test-qobject-output-visitor.c
@@ -17,6 +17,7 @@
 #include "qapi/qobject-output-visitor.h"
 #include "test-qapi-visit.h"
 #include "qapi/qmp/qbool.h"
+#include "qapi/qmp/qdict.h"
 #include "qapi/qmp/qlist.h"
 #include "qapi/qmp/qnull.h"
 #include "qapi/qmp/qnum.h"
diff --git a/tests/test-replication.c b/tests/test-replication.c
index cebeb793b0..31372777ae 100644
--- a/tests/test-replication.c
+++ b/tests/test-replication.c
@@ -11,6 +11,7 @@
 #include "qemu/osdep.h"
=20
 #include "qapi/error.h"
+#include "qapi/qmp/qdict.h"
 #include "replication.h"
 #include "block/block_int.h"
 #include "sysemu/block-backend.h"
diff --git a/tests/tmp105-test.c b/tests/tmp105-test.c
index a7940a4639..e9a3cb7ac3 100644
--- a/tests/tmp105-test.c
+++ b/tests/tmp105-test.c
@@ -11,6 +11,7 @@
=20
 #include "libqtest.h"
 #include "libqos/i2c.h"
+#include "qapi/qmp/qdict.h"
 #include "hw/misc/tmp105_regs.h"
=20
 #define OMAP2_I2C_1_BASE 0x48070000
diff --git a/tests/vhost-user-test.c b/tests/vhost-user-test.c
index ec6ac9dc9e..906451daa1 100644
--- a/tests/vhost-user-test.c
+++ b/tests/vhost-user-test.c
@@ -12,6 +12,7 @@
=20
 #include "libqtest.h"
 #include "qapi/error.h"
+#include "qapi/qmp/qdict.h"
 #include "qemu/config-file.h"
 #include "qemu/option.h"
 #include "qemu/range.h"
diff --git a/tests/virtio-net-test.c b/tests/virtio-net-test.c
index 635b942c36..0e366e302e 100644
--- a/tests/virtio-net-test.c
+++ b/tests/virtio-net-test.c
@@ -16,6 +16,7 @@
 #include "libqos/libqos-spapr.h"
 #include "libqos/virtio.h"
 #include "libqos/virtio-pci.h"
+#include "qapi/qmp/qdict.h"
 #include "qemu/bswap.h"
 #include "hw/virtio/virtio-net.h"
 #include "standard-headers/linux/virtio_ids.h"
diff --git a/tests/vmgenid-test.c b/tests/vmgenid-test.c
index 68ff954578..7190e680dc 100644
--- a/tests/vmgenid-test.c
+++ b/tests/vmgenid-test.c
@@ -15,6 +15,7 @@
 #include "boot-sector.h"
 #include "acpi-utils.h"
 #include "libqtest.h"
+#include "qapi/qmp/qdict.h"
=20
 #define VGID_GUID "324e6eaf-d1d1-4bf6-bf41-b9bb6c91fb87"
 #define VMGENID_GUID_OFFSET 40   /* allow space for
diff --git a/tests/wdt_ib700-test.c b/tests/wdt_ib700-test.c
index 49f4f0c221..6062d4e942 100644
--- a/tests/wdt_ib700-test.c
+++ b/tests/wdt_ib700-test.c
@@ -9,6 +9,7 @@
=20
 #include "qemu/osdep.h"
 #include "libqtest.h"
+#include "qapi/qmp/qdict.h"
 #include "qemu/timer.h"
=20
 static void qmp_check_no_event(void)
diff --git a/util/keyval.c b/util/keyval.c
index 4085282a7a..212ae90d00 100644
--- a/util/keyval.c
+++ b/util/keyval.c
@@ -81,6 +81,7 @@
=20
 #include "qemu/osdep.h"
 #include "qapi/error.h"
+#include "qapi/qmp/qdict.h"
 #include "qapi/qmp/qlist.h"
 #include "qapi/qmp/qstring.h"
 #include "qemu/cutils.h"
--=20
2.13.6

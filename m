Received: from eggs.gnu.org ([2001:4830:134:3::10]:37903)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ehCtI-0006Iy-OF
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 06:18:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ehCtF-0004wj-Ic
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 06:18:52 -0500
Received: from mx1.redhat.com ([209.132.183.28]:56962)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1ehCtF-0004vf-AZ
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 06:18:49 -0500
From: Markus Armbruster <armbru@redhat.com>
Date: Thu,  1 Feb 2018 12:18:30 +0100
Message-Id: <20180201111846.21846-4-armbru@redhat.com>
In-Reply-To: <20180201111846.21846-1-armbru@redhat.com>
References: <20180201111846.21846-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3 03/19] Drop superfluous includes of
 qapi-types.h and test-qapi-types.h
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

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 backends/cryptodev.c                 | 1 -
 backends/hostmem.c                   | 1 -
 hmp.h                                | 1 -
 include/block/block.h                | 1 -
 include/block/block_int.h            | 1 -
 include/block/qapi.h                 | 1 -
 include/hw/acpi/acpi_dev_interface.h | 1 -
 include/migration/failover.h         | 1 -
 include/net/net.h                    | 1 -
 include/net/slirp.h                  | 1 -
 include/net/tap.h                    | 1 -
 include/qapi/qmp/qlit.h              | 1 -
 include/sysemu/dump.h                | 1 -
 include/sysemu/replay.h              | 1 -
 include/sysemu/sysemu.h              | 1 -
 include/sysemu/tpm.h                 | 1 -
 include/sysemu/tpm_backend.h         | 1 -
 include/ui/console.h                 | 1 -
 migration/migration.h                | 1 -
 net/clients.h                        | 1 -
 net/tap_int.h                        | 1 -
 qapi/qmp-dispatch.c                  | 1 -
 qemu-keymap.c                        | 1 -
 target/i386/cpu.c                    | 1 -
 tests/test-clone-visitor.c           | 1 -
 tests/test-qapi-util.c               | 1 -
 tests/test-qmp-event.c               | 1 -
 tests/test-qobject-input-visitor.c   | 1 -
 tests/test-qobject-output-visitor.c  | 1 -
 tests/test-string-input-visitor.c    | 1 -
 tests/test-string-output-visitor.c   | 1 -
 tests/test-visitor-serialization.c   | 2 --
 ui/input-legacy.c                    | 1 -
 ui/input.c                           | 1 -
 ui/vnc.h                             | 1 -
 35 files changed, 36 deletions(-)

diff --git a/backends/cryptodev.c b/backends/cryptodev.c
index 67edfa5328..d0dff1a463 100644
--- a/backends/cryptodev.c
+++ b/backends/cryptodev.c
@@ -26,7 +26,6 @@
 #include "hw/boards.h"
 #include "qapi/error.h"
 #include "qapi/visitor.h"
-#include "qapi-types.h"
 #include "qapi-visit.h"
 #include "qemu/config-file.h"
 #include "qom/object_interfaces.h"
diff --git a/backends/hostmem.c b/backends/hostmem.c
index ee2c2d5bfd..81d14554a7 100644
--- a/backends/hostmem.c
+++ b/backends/hostmem.c
@@ -14,7 +14,6 @@
 #include "hw/boards.h"
 #include "qapi/error.h"
 #include "qapi/visitor.h"
-#include "qapi-types.h"
 #include "qapi-visit.h"
 #include "qemu/config-file.h"
 #include "qom/object_interfaces.h"
diff --git a/hmp.h b/hmp.h
index a6f56b1f29..dbb40ebbfa 100644
--- a/hmp.h
+++ b/hmp.h
@@ -16,7 +16,6 @@
=20
 #include "qemu-common.h"
 #include "qemu/readline.h"
-#include "qapi-types.h"
 #include "qapi/qmp/qdict.h"
=20
 void hmp_info_name(Monitor *mon, const QDict *qdict);
diff --git a/include/block/block.h b/include/block/block.h
index 9b12774ddf..0608834396 100644
--- a/include/block/block.h
+++ b/include/block/block.h
@@ -9,7 +9,6 @@
 #include "block/dirty-bitmap.h"
 #include "block/blockjob.h"
 #include "qapi/qmp/qobject.h"
-#include "qapi-types.h"
 #include "qemu/hbitmap.h"
=20
 /* block.c */
diff --git a/include/block/block_int.h b/include/block/block_int.h
index 29cafa4236..6499f7c16a 100644
--- a/include/block/block_int.h
+++ b/include/block/block_int.h
@@ -31,7 +31,6 @@
 #include "qemu/coroutine.h"
 #include "qemu/stats64.h"
 #include "qemu/timer.h"
-#include "qapi-types.h"
 #include "qemu/hbitmap.h"
 #include "block/snapshot.h"
 #include "qemu/main-loop.h"
diff --git a/include/block/qapi.h b/include/block/qapi.h
index 82ba4b63a0..83bdb098bd 100644
--- a/include/block/qapi.h
+++ b/include/block/qapi.h
@@ -25,7 +25,6 @@
 #ifndef BLOCK_QAPI_H
 #define BLOCK_QAPI_H
=20
-#include "qapi-types.h"
 #include "block/block.h"
 #include "block/snapshot.h"
=20
diff --git a/include/hw/acpi/acpi_dev_interface.h b/include/hw/acpi/acpi_=
dev_interface.h
index 3c2e4e95a5..dabf4c4fc9 100644
--- a/include/hw/acpi/acpi_dev_interface.h
+++ b/include/hw/acpi/acpi_dev_interface.h
@@ -2,7 +2,6 @@
 #define ACPI_DEV_INTERFACE_H
=20
 #include "qom/object.h"
-#include "qapi-types.h"
 #include "hw/boards.h"
=20
 /* These values are part of guest ABI, and can not be changed */
diff --git a/include/migration/failover.h b/include/migration/failover.h
index ad91ef2381..9283d602e6 100644
--- a/include/migration/failover.h
+++ b/include/migration/failover.h
@@ -14,7 +14,6 @@
 #define QEMU_FAILOVER_H
=20
 #include "qemu-common.h"
-#include "qapi-types.h"
=20
 void failover_init_state(void);
 FailoverStatus failover_set_state(FailoverStatus old_state,
diff --git a/include/net/net.h b/include/net/net.h
index 4afac1a9dd..eefb259e0a 100644
--- a/include/net/net.h
+++ b/include/net/net.h
@@ -7,7 +7,6 @@
 #include "qemu/option.h"
 #include "net/queue.h"
 #include "migration/vmstate.h"
-#include "qapi-types.h"
=20
 #define MAC_FMT "%02X:%02X:%02X:%02X:%02X:%02X"
 #define MAC_ARG(x) ((uint8_t *)(x))[0], ((uint8_t *)(x))[1], \
diff --git a/include/net/slirp.h b/include/net/slirp.h
index 0c98e463db..865d2fca36 100644
--- a/include/net/slirp.h
+++ b/include/net/slirp.h
@@ -27,7 +27,6 @@
 #include "qemu-common.h"
 #include "qapi/qmp/qdict.h"
 #include "qemu/option.h"
-#include "qapi-types.h"
=20
 #ifdef CONFIG_SLIRP
=20
diff --git a/include/net/tap.h b/include/net/tap.h
index 5da4edc692..ce6f8418ac 100644
--- a/include/net/tap.h
+++ b/include/net/tap.h
@@ -27,7 +27,6 @@
 #define QEMU_NET_TAP_H
=20
 #include "qemu-common.h"
-#include "qapi-types.h"
 #include "standard-headers/linux/virtio_net.h"
=20
 int tap_enable(NetClientState *nc);
diff --git a/include/qapi/qmp/qlit.h b/include/qapi/qmp/qlit.h
index b18406bce9..56f9d97bd9 100644
--- a/include/qapi/qmp/qlit.h
+++ b/include/qapi/qmp/qlit.h
@@ -14,7 +14,6 @@
 #ifndef QLIT_H
 #define QLIT_H
=20
-#include "qapi-types.h"
 #include "qobject.h"
=20
 typedef struct QLitDictEntry QLitDictEntry;
diff --git a/include/sysemu/dump.h b/include/sysemu/dump.h
index df43bd0e07..c14bcfe8c6 100644
--- a/include/sysemu/dump.h
+++ b/include/sysemu/dump.h
@@ -38,7 +38,6 @@
=20
 #include "sysemu/dump-arch.h"
 #include "sysemu/memory_mapping.h"
-#include "qapi-types.h"
=20
 typedef struct QEMU_PACKED MakedumpfileHeader {
     char signature[16];     /* =3D "makedumpfile" */
diff --git a/include/sysemu/replay.h b/include/sysemu/replay.h
index fa14d0ec0b..dc8ae7b6b1 100644
--- a/include/sysemu/replay.h
+++ b/include/sysemu/replay.h
@@ -12,7 +12,6 @@
  *
  */
=20
-#include "qapi-types.h"
 #include "sysemu.h"
=20
 /* replay clock kinds */
diff --git a/include/sysemu/sysemu.h b/include/sysemu/sysemu.h
index 1c925309e3..36fd371c93 100644
--- a/include/sysemu/sysemu.h
+++ b/include/sysemu/sysemu.h
@@ -5,7 +5,6 @@
 #include "qemu/option.h"
 #include "qemu/queue.h"
 #include "qemu/timer.h"
-#include "qapi-types.h"
 #include "qemu/notify.h"
 #include "qemu/main-loop.h"
 #include "qemu/bitmap.h"
diff --git a/include/sysemu/tpm.h b/include/sysemu/tpm.h
index 852e02687c..00be220248 100644
--- a/include/sysemu/tpm.h
+++ b/include/sysemu/tpm.h
@@ -13,7 +13,6 @@
 #define QEMU_TPM_H
=20
 #include "qom/object.h"
-#include "qapi-types.h"
=20
 int tpm_config_parse(QemuOptsList *opts_list, const char *optarg);
 int tpm_init(void);
diff --git a/include/sysemu/tpm_backend.h b/include/sysemu/tpm_backend.h
index 0d6c994a62..3c3960fa90 100644
--- a/include/sysemu/tpm_backend.h
+++ b/include/sysemu/tpm_backend.h
@@ -15,7 +15,6 @@
=20
 #include "qom/object.h"
 #include "qemu-common.h"
-#include "qapi-types.h"
 #include "qemu/option.h"
 #include "sysemu/tpm.h"
=20
diff --git a/include/ui/console.h b/include/ui/console.h
index 4c5d2102b6..2a5efa79ed 100644
--- a/include/ui/console.h
+++ b/include/ui/console.h
@@ -5,7 +5,6 @@
 #include "qom/object.h"
 #include "qapi/qmp/qdict.h"
 #include "qemu/notify.h"
-#include "qapi-types.h"
 #include "qemu/error-report.h"
 #include "qapi/error.h"
=20
diff --git a/migration/migration.h b/migration/migration.h
index 786d971ce2..7e3dbed057 100644
--- a/migration/migration.h
+++ b/migration/migration.h
@@ -16,7 +16,6 @@
=20
 #include "qemu-common.h"
 #include "qemu/thread.h"
-#include "qapi-types.h"
 #include "exec/cpu-common.h"
 #include "qemu/coroutine_int.h"
 #include "hw/qdev.h"
diff --git a/net/clients.h b/net/clients.h
index 5cae479730..a6ef267e19 100644
--- a/net/clients.h
+++ b/net/clients.h
@@ -25,7 +25,6 @@
 #define QEMU_NET_CLIENTS_H
=20
 #include "net/net.h"
-#include "qapi-types.h"
=20
 int net_init_dump(const Netdev *netdev, const char *name,
                   NetClientState *peer, Error **errp);
diff --git a/net/tap_int.h b/net/tap_int.h
index ae6888f74a..e3a14d5dda 100644
--- a/net/tap_int.h
+++ b/net/tap_int.h
@@ -27,7 +27,6 @@
 #define NET_TAP_INT_H
=20
 #include "qemu-common.h"
-#include "qapi-types.h"
=20
 int tap_open(char *ifname, int ifname_size, int *vnet_hdr,
              int vnet_hdr_required, int mq_required, Error **errp);
diff --git a/qapi/qmp-dispatch.c b/qapi/qmp-dispatch.c
index b41fa174fe..7d18524f3c 100644
--- a/qapi/qmp-dispatch.c
+++ b/qapi/qmp-dispatch.c
@@ -17,7 +17,6 @@
 #include "qapi/qmp/dispatch.h"
 #include "qapi/qmp/json-parser.h"
 #include "qapi/qmp/qjson.h"
-#include "qapi-types.h"
 #include "qapi/qmp/qerror.h"
=20
 static QDict *qmp_dispatch_check_obj(const QObject *request, Error **err=
p)
diff --git a/qemu-keymap.c b/qemu-keymap.c
index 49e9167b86..6216371aa1 100644
--- a/qemu-keymap.c
+++ b/qemu-keymap.c
@@ -11,7 +11,6 @@
  */
 #include "qemu/osdep.h"
 #include "qemu-common.h"
-#include "qapi-types.h"
 #include "qemu/notify.h"
 #include "ui/input.h"
=20
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index a49d2221ad..050644f820 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -32,7 +32,6 @@
 #include "qapi/qmp/qerror.h"
 #include "qapi/qmp/types.h"
=20
-#include "qapi-types.h"
 #include "qapi-visit.h"
 #include "qapi/visitor.h"
 #include "qom/qom-qobject.h"
diff --git a/tests/test-clone-visitor.c b/tests/test-clone-visitor.c
index ac6afc562e..6b6d4aaeba 100644
--- a/tests/test-clone-visitor.c
+++ b/tests/test-clone-visitor.c
@@ -11,7 +11,6 @@
=20
 #include "qemu-common.h"
 #include "qapi/clone-visitor.h"
-#include "test-qapi-types.h"
 #include "test-qapi-visit.h"
 #include "qapi/qmp/types.h"
=20
diff --git a/tests/test-qapi-util.c b/tests/test-qapi-util.c
index 4b5e4f8bd3..847f305cff 100644
--- a/tests/test-qapi-util.c
+++ b/tests/test-qapi-util.c
@@ -12,7 +12,6 @@
=20
 #include "qemu/osdep.h"
 #include "qapi/error.h"
-#include "test-qapi-types.h"
=20
 static void test_qapi_enum_parse(void)
 {
diff --git a/tests/test-qmp-event.c b/tests/test-qmp-event.c
index 9fb3c5e81e..46825b4f3f 100644
--- a/tests/test-qmp-event.c
+++ b/tests/test-qmp-event.c
@@ -14,7 +14,6 @@
 #include "qemu/osdep.h"
=20
 #include "qemu-common.h"
-#include "test-qapi-types.h"
 #include "test-qapi-visit.h"
 #include "test-qapi-event.h"
 #include "qapi/qmp/types.h"
diff --git a/tests/test-qobject-input-visitor.c b/tests/test-qobject-inpu=
t-visitor.c
index fe591814e4..ade6062e2c 100644
--- a/tests/test-qobject-input-visitor.c
+++ b/tests/test-qobject-input-visitor.c
@@ -16,7 +16,6 @@
 #include "qemu-common.h"
 #include "qapi/error.h"
 #include "qapi/qobject-input-visitor.h"
-#include "test-qapi-types.h"
 #include "test-qapi-visit.h"
 #include "qapi/qmp/types.h"
 #include "qapi/qmp/qjson.h"
diff --git a/tests/test-qobject-output-visitor.c b/tests/test-qobject-out=
put-visitor.c
index d375100a52..1cff769b15 100644
--- a/tests/test-qobject-output-visitor.c
+++ b/tests/test-qobject-output-visitor.c
@@ -15,7 +15,6 @@
 #include "qemu-common.h"
 #include "qapi/error.h"
 #include "qapi/qobject-output-visitor.h"
-#include "test-qapi-types.h"
 #include "test-qapi-visit.h"
 #include "qapi/qmp/types.h"
 #include "qapi/qmp/qjson.h"
diff --git a/tests/test-string-input-visitor.c b/tests/test-string-input-=
visitor.c
index 4f9c36bef1..4473944f3f 100644
--- a/tests/test-string-input-visitor.c
+++ b/tests/test-string-input-visitor.c
@@ -15,7 +15,6 @@
 #include "qemu-common.h"
 #include "qapi/error.h"
 #include "qapi/string-input-visitor.h"
-#include "test-qapi-types.h"
 #include "test-qapi-visit.h"
 #include "qapi/qmp/types.h"
=20
diff --git a/tests/test-string-output-visitor.c b/tests/test-string-outpu=
t-visitor.c
index 385cddb5d9..facb76ffc3 100644
--- a/tests/test-string-output-visitor.c
+++ b/tests/test-string-output-visitor.c
@@ -15,7 +15,6 @@
 #include "qemu-common.h"
 #include "qapi/error.h"
 #include "qapi/string-output-visitor.h"
-#include "test-qapi-types.h"
 #include "test-qapi-visit.h"
 #include "qapi/qmp/types.h"
=20
diff --git a/tests/test-visitor-serialization.c b/tests/test-visitor-seri=
alization.c
index 4d47ceec7a..a3407d205d 100644
--- a/tests/test-visitor-serialization.c
+++ b/tests/test-visitor-serialization.c
@@ -15,7 +15,6 @@
 #include <float.h>
=20
 #include "qemu-common.h"
-#include "test-qapi-types.h"
 #include "test-qapi-visit.h"
 #include "qapi/error.h"
 #include "qapi/qmp/types.h"
@@ -24,7 +23,6 @@
 #include "qapi/qobject-output-visitor.h"
 #include "qapi/string-input-visitor.h"
 #include "qapi/string-output-visitor.h"
-#include "qapi-types.h"
 #include "qapi-visit.h"
 #include "qapi/dealloc-visitor.h"
=20
diff --git a/ui/input-legacy.c b/ui/input-legacy.c
index c75aba1549..92b37ccb90 100644
--- a/ui/input-legacy.c
+++ b/ui/input-legacy.c
@@ -26,7 +26,6 @@
 #include "sysemu/sysemu.h"
 #include "ui/console.h"
 #include "qmp-commands.h"
-#include "qapi-types.h"
 #include "ui/keymaps.h"
 #include "ui/input.h"
=20
diff --git a/ui/input.c b/ui/input.c
index e5b78aae9e..ab22c8423f 100644
--- a/ui/input.c
+++ b/ui/input.c
@@ -1,6 +1,5 @@
 #include "qemu/osdep.h"
 #include "sysemu/sysemu.h"
-#include "qapi-types.h"
 #include "qemu/error-report.h"
 #include "qmp-commands.h"
 #include "trace.h"
diff --git a/ui/vnc.h b/ui/vnc.h
index bbda0540a7..cfc3d0a570 100644
--- a/ui/vnc.h
+++ b/ui/vnc.h
@@ -42,7 +42,6 @@
 #include "keymaps.h"
 #include "vnc-palette.h"
 #include "vnc-enc-zrle.h"
-#include "qapi-types.h"
=20
 // #define _VNC_DEBUG 1
=20
--=20
2.13.6

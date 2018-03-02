Received: from eggs.gnu.org ([2001:4830:134:3::10]:57604)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1erZXg-0008Cs-LK
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 20:31:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1erZXa-0003VD-QS
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 20:31:24 -0500
From: Eric Blake <eblake@redhat.com>
Date: Thu,  1 Mar 2018 19:30:01 -0600
Message-Id: <20180302013007.11827-25-eblake@redhat.com>
In-Reply-To: <20180302013007.11827-1-eblake@redhat.com>
References: <20180302013007.11827-1-eblake@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL v2 24/30] Include less of the generated modular
 QAPI headers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, Gonglei <arei.gonglei@huawei.com>, Eduardo Habkost <ehabkost@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Jeff Cody <jcody@redhat.com>, Peter Lieven <pl@kamp.de>, Alberto Garcia <berto@igalia.com>, Hitoshi Mitake <mitake.hitoshi@lab.ntt.co.jp>, Liu Yuan <namei.unix@gmail.com>, "Richard W.M. Jones" <rjones@redhat.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Richard Henderson <rth@twiddle.net>, =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, John Snow <jsnow@redhat.com>, Amit Shah <amit@kernel.org>, Marcel Apfelbaum <marcel@redhat.com>, Xiao Guangrong <xiaoguangrong.eric@gmail.com>, Jiri Pirko <jiri@resnulli.us>, Jason Wang <jasowang@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Alexander Graf <agraf@suse.de>, Stefan Berger <stefanb@linux.vnet.ibm.com>, Fam Zheng <famz@redhat.com>, zhanghailiang <zhang.zhanghailiang@huawei.com>, Juan Quintela <quintela@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, Gerd Hoffmann <kraxel@redhat.com>, =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>, Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>, Zhang Chen <zhangckid@gmail.com>, Li Zhijian <lizhijian@cn.fujitsu.com>, Wen Congyang <wencongyang2@huawei.com>, Xie Changlong <xiechanglong.d@gmail.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cohuck@redhat.com>, David Hildenbrand <david@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, "open list:Block layer core" <qemu-block@nongnu.org>, "open list:Sheepdog" <sheepdog@lists.wpkg.org>, "open list:sPAPR" <qemu-ppc@nongnu.org>, "open list:S390" <qemu-s390x@nongnu.org>

From: Markus Armbruster <armbru@redhat.com>

In my "build everything" tree, a change to the types in
qapi-schema.json triggers a recompile of about 4800 out of 5100
objects.

The previous commit split up qmp-commands.h, qmp-event.h, qmp-visit.h,
qapi-types.h.  Each of these headers still includes all its shards.
Reduce compile time by including just the shards we actually need.

To illustrate the benefits: adding a type to qapi/migration.json now
recompiles some 2300 instead of 4800 objects.  The next commit will
improve it further.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Message-Id: <20180211093607.27351-24-armbru@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
[eblake: rebase to master]
Signed-off-by: Eric Blake <eblake@redhat.com>
---
 include/qapi/visitor.h           |  2 +-
 scripts/qapi/commands.py         | 14 ++++++++------
 scripts/qapi/events.py           | 10 ++++++----
 scripts/qapi/types.py            |  8 +++++---
 scripts/qapi/visit.py            | 10 ++++++----
 crypto/cipherpriv.h              |  2 +-
 include/block/block.h            |  2 +-
 include/block/dirty-bitmap.h     |  2 +-
 include/block/nbd.h              |  2 +-
 include/chardev/char.h           |  1 +
 include/crypto/cipher.h          |  2 +-
 include/crypto/hash.h            |  2 +-
 include/crypto/hmac.h            |  2 +-
 include/crypto/secret.h          |  1 +
 include/crypto/tlscreds.h        |  1 +
 include/hw/block/block.h         |  2 +-
 include/hw/block/fdc.h           |  2 +-
 include/hw/ppc/spapr_drc.h       |  1 +
 include/hw/qdev-properties.h     |  1 +
 include/io/dns-resolver.h        |  1 +
 include/migration/colo.h         |  2 +-
 include/migration/failover.h     |  2 +-
 include/migration/global_state.h |  1 +
 include/monitor/monitor.h        |  1 +
 include/net/filter.h             |  1 +
 include/net/net.h                |  2 +-
 include/qapi/clone-visitor.h     |  1 -
 include/qapi/error.h             |  2 +-
 include/qapi/qmp/qobject.h       |  2 +-
 include/qemu/sockets.h           |  2 +-
 include/qemu/throttle.h          |  2 +-
 include/qom/cpu.h                |  1 +
 include/qom/object.h             |  2 +-
 include/sysemu/dump.h            |  2 ++
 include/sysemu/hostmem.h         |  1 +
 include/sysemu/replay.h          |  1 +
 include/sysemu/sysemu.h          |  1 +
 include/sysemu/tpm.h             |  1 +
 include/sysemu/watchdog.h        |  2 +-
 include/ui/console.h             |  1 +
 include/ui/input.h               |  2 +-
 migration/migration.h            |  1 +
 migration/ram.h                  |  2 +-
 net/tap_int.h                    |  2 +-
 replication.h                    |  1 +
 ui/vnc.h                         |  1 +
 vl.c                             |  4 ++--
 backends/cryptodev.c             |  1 -
 backends/hostmem.c               |  3 ++-
 block.c                          |  1 -
 block/block-backend.c            |  2 +-
 block/crypto.c                   |  2 +-
 block/nbd.c                      |  2 +-
 block/nfs.c                      |  2 +-
 block/qapi.c                     |  4 ++--
 block/qcow2.c                    |  3 +--
 block/quorum.c                   |  2 +-
 block/sheepdog.c                 |  2 +-
 block/ssh.c                      |  2 +-
 block/throttle-groups.c          |  2 +-
 block/write-threshold.c          |  4 ++--
 blockdev-nbd.c                   |  2 +-
 blockdev.c                       |  5 +++--
 blockjob.c                       |  2 +-
 chardev/char-fe.c                |  1 -
 chardev/char-ringbuf.c           |  2 +-
 chardev/char-socket.c            |  1 +
 chardev/char.c                   |  3 +--
 cpus.c                           |  2 +-
 hmp.c                            |  2 +-
 hw/acpi/core.c                   |  2 +-
 hw/block/block.c                 |  1 +
 hw/block/hd-geometry.c           |  1 +
 hw/char/virtio-console.c         |  2 +-
 hw/core/machine.c                |  2 +-
 hw/i386/pc.c                     |  2 +-
 hw/mem/nvdimm.c                  |  1 -
 hw/net/rocker/qmp-norocker.c     |  2 +-
 hw/net/rocker/rocker.c           |  2 +-
 hw/net/rocker/rocker_fp.c        |  2 +-
 hw/net/rocker/rocker_of_dpa.c    |  2 +-
 hw/net/virtio-net.c              |  2 +-
 hw/ppc/spapr_rtas.c              |  1 -
 hw/tpm/tpm_emulator.c            |  1 +
 hw/tpm/tpm_passthrough.c         |  1 +
 hw/watchdog/watchdog.c           |  2 +-
 io/channel-socket.c              |  1 +
 io/dns-resolver.c                |  1 +
 migration/colo-failover.c        |  2 +-
 migration/colo.c                 |  2 +-
 migration/migration.c            |  4 ++--
 migration/ram.c                  |  2 +-
 net/colo-compare.c               |  1 -
 net/filter-buffer.c              |  2 +-
 net/filter-mirror.c              |  1 -
 net/filter-rewriter.c            |  1 -
 net/net.c                        |  4 ++--
 net/vhost-user.c                 |  2 +-
 qemu-img.c                       |  2 +-
 qom/object.c                     |  2 +-
 qom/object_interfaces.c          |  1 -
 replay/replay-input.c            |  1 +
 stubs/tpm.c                      |  3 ++-
 target/s390x/kvm.c               |  1 -
 target/s390x/sigp.c              |  1 +
 tests/test-char.c                |  2 +-
 tests/test-qmp-event.c           |  1 -
 tpm.c                            |  2 +-
 trace/qmp.c                      |  2 +-
 ui/console.c                     |  2 +-
 ui/input-legacy.c                |  2 +-
 ui/input.c                       |  2 +-
 ui/spice-core.c                  |  4 ++--
 ui/vnc.c                         |  2 +-
 util/qemu-sockets.c              |  2 +-
 115 files changed, 135 insertions(+), 109 deletions(-)

diff --git a/include/qapi/visitor.h b/include/qapi/visitor.h
index ecff296c11a..9e57508446e 100644
--- a/include/qapi/visitor.h
+++ b/include/qapi/visitor.h
@@ -15,7 +15,7 @@
 #ifndef QAPI_VISITOR_H
 #define QAPI_VISITOR_H

-#include "qapi-types.h"
+#include "qapi-builtin-types.h"

 /*
  * The QAPI schema defines both a set of C data types, and a QMP wire
diff --git a/scripts/qapi/commands.py b/scripts/qapi/commands.py
index a43bccb1902..953449171b3 100644
--- a/scripts/qapi/commands.py
+++ b/scripts/qapi/commands.py
@@ -241,6 +241,9 @@ class QAPISchemaGenCommandVisitor(QAPISchemaModularCV=
isitor):

     def _begin_module(self, name):
         self._visited_ret_types[self._genc] =3D set()
+        commands =3D self._module_basename('qapi-commands', name)
+        types =3D self._module_basename('qapi-types', name)
+        visit =3D self._module_basename('qapi-visit', name)
         self._genc.add(mcgen('''
 #include "qemu/osdep.h"
 #include "qemu-common.h"
@@ -251,18 +254,17 @@ class QAPISchemaGenCommandVisitor(QAPISchemaModular=
CVisitor):
 #include "qapi/qobject-input-visitor.h"
 #include "qapi/dealloc-visitor.h"
 #include "qapi/error.h"
-#include "%(prefix)sqapi-types.h"
-#include "%(prefix)sqapi-visit.h"
-#include "%(prefix)sqmp-commands.h"
+#include "%(visit)s.h"
+#include "%(commands)s.h"

 ''',
-                             prefix=3Dself._prefix))
+                             commands=3Dcommands, visit=3Dvisit))
         self._genh.add(mcgen('''
-#include "%(prefix)sqapi-types.h"
+#include "%(types)s.h"
 #include "qapi/qmp/dispatch.h"

 ''',
-                             prefix=3Dself._prefix))
+                             types=3Dtypes))

     def visit_end(self):
         (genc, genh) =3D self._module[self._main_module]
diff --git a/scripts/qapi/events.py b/scripts/qapi/events.py
index 1e0b990f356..5ad67084911 100644
--- a/scripts/qapi/events.py
+++ b/scripts/qapi/events.py
@@ -165,24 +165,26 @@ class QAPISchemaGenEventVisitor(QAPISchemaModularCV=
isitor):
         return basename

     def _begin_module(self, name):
+        types =3D self._module_basename('qapi-types', name)
+        visit =3D self._module_basename('qapi-visit', name)
         self._genc.add(mcgen('''
 #include "qemu/osdep.h"
 #include "qemu-common.h"
 #include "%(prefix)sqapi-event.h"
-#include "%(prefix)sqapi-visit.h"
+#include "%(visit)s.h"
 #include "qapi/error.h"
 #include "qapi/qmp/qdict.h"
 #include "qapi/qobject-output-visitor.h"
 #include "qapi/qmp-event.h"

 ''',
-                             prefix=3Dself._prefix))
+                             visit=3Dvisit, prefix=3Dself._prefix))
         self._genh.add(mcgen('''
 #include "qapi/util.h"
-#include "%(prefix)sqapi-types.h"
+#include "%(types)s.h"

 ''',
-                             prefix=3Dself._prefix))
+                             types=3Dtypes))

     def visit_end(self):
         self._genh.add(gen_enum(self._enum_name, self._event_names))
diff --git a/scripts/qapi/types.py b/scripts/qapi/types.py
index 59826b11625..2a3c502cf6d 100644
--- a/scripts/qapi/types.py
+++ b/scripts/qapi/types.py
@@ -185,13 +185,15 @@ class QAPISchemaGenTypeVisitor(QAPISchemaModularCVi=
sitor):
 '''))

     def _begin_module(self, name):
+        types =3D self._module_basename('qapi-types', name)
+        visit =3D self._module_basename('qapi-visit', name)
         self._genc.preamble_add(mcgen('''
 #include "qemu/osdep.h"
 #include "qapi/dealloc-visitor.h"
-#include "%(prefix)sqapi-types.h"
-#include "%(prefix)sqapi-visit.h"
+#include "%(types)s.h"
+#include "%(visit)s.h"
 ''',
-                                      prefix=3Dself._prefix))
+                                      types=3Dtypes, visit=3Dvisit))
         self._genh.preamble_add(mcgen('''
 #include "qapi-builtin-types.h"
 '''))
diff --git a/scripts/qapi/visit.py b/scripts/qapi/visit.py
index 9b678e72634..de09966643d 100644
--- a/scripts/qapi/visit.py
+++ b/scripts/qapi/visit.py
@@ -284,20 +284,22 @@ class QAPISchemaGenVisitVisitor(QAPISchemaModularCV=
isitor):
                                       prefix=3Dprefix))

     def _begin_module(self, name):
+        types =3D self._module_basename('qapi-types', name)
+        visit =3D self._module_basename('qapi-visit', name)
         self._genc.preamble_add(mcgen('''
 #include "qemu/osdep.h"
 #include "qemu-common.h"
 #include "qapi/error.h"
 #include "qapi/qmp/qerror.h"
-#include "%(prefix)sqapi-visit.h"
+#include "%(visit)s.h"
 ''',
-                                      prefix=3Dself._prefix))
+                                      visit=3Dvisit, prefix=3Dself._pref=
ix))
         self._genh.preamble_add(mcgen('''
 #include "qapi-builtin-visit.h"
-#include "%(prefix)sqapi-types.h"
+#include "%(types)s.h"

 ''',
-                                      prefix=3Dself._prefix))
+                                      types=3Dtypes))

     def visit_enum_type(self, name, info, values, prefix):
         self._genh.add(gen_visit_decl(name, scalar=3DTrue))
diff --git a/crypto/cipherpriv.h b/crypto/cipherpriv.h
index 77da4c2f321..0823239f413 100644
--- a/crypto/cipherpriv.h
+++ b/crypto/cipherpriv.h
@@ -15,7 +15,7 @@
 #ifndef QCRYPTO_CIPHERPRIV_H
 #define QCRYPTO_CIPHERPRIV_H

-#include "qapi-types.h"
+#include "qapi/qapi-types-crypto.h"

 typedef struct QCryptoCipherDriver QCryptoCipherDriver;

diff --git a/include/block/block.h b/include/block/block.h
index 19b3ab9cb5e..fac401ba3e6 100644
--- a/include/block/block.h
+++ b/include/block/block.h
@@ -2,7 +2,7 @@
 #define BLOCK_H

 #include "block/aio.h"
-#include "qapi-types.h"
+#include "qapi/qapi-types-block-core.h"
 #include "qemu/iov.h"
 #include "qemu/coroutine.h"
 #include "block/accounting.h"
diff --git a/include/block/dirty-bitmap.h b/include/block/dirty-bitmap.h
index e3f4bbf51dc..09efec609f6 100644
--- a/include/block/dirty-bitmap.h
+++ b/include/block/dirty-bitmap.h
@@ -2,7 +2,7 @@
 #define BLOCK_DIRTY_BITMAP_H

 #include "qemu-common.h"
-#include "qapi-types.h"
+#include "qapi/qapi-types-block-core.h"
 #include "qemu/hbitmap.h"

 BdrvDirtyBitmap *bdrv_create_dirty_bitmap(BlockDriverState *bs,
diff --git a/include/block/nbd.h b/include/block/nbd.h
index fc500030038..631290dac94 100644
--- a/include/block/nbd.h
+++ b/include/block/nbd.h
@@ -20,7 +20,7 @@
 #ifndef NBD_H
 #define NBD_H

-
+#include "qapi/qapi-types-block.h"
 #include "io/channel-socket.h"
 #include "crypto/tlscreds.h"

diff --git a/include/chardev/char.h b/include/chardev/char.h
index a381dc3df86..ebf1e0ba048 100644
--- a/include/chardev/char.h
+++ b/include/chardev/char.h
@@ -1,6 +1,7 @@
 #ifndef QEMU_CHAR_H
 #define QEMU_CHAR_H

+#include "qapi/qapi-types-char.h"
 #include "qemu/main-loop.h"
 #include "qemu/bitmap.h"
 #include "qom/object.h"
diff --git a/include/crypto/cipher.h b/include/crypto/cipher.h
index 984fb8243f0..bce2d4c8e46 100644
--- a/include/crypto/cipher.h
+++ b/include/crypto/cipher.h
@@ -21,7 +21,7 @@
 #ifndef QCRYPTO_CIPHER_H
 #define QCRYPTO_CIPHER_H

-#include "qapi-types.h"
+#include "qapi/qapi-types-crypto.h"

 typedef struct QCryptoCipher QCryptoCipher;

diff --git a/include/crypto/hash.h b/include/crypto/hash.h
index ca3267f3dfd..077ac7bea0e 100644
--- a/include/crypto/hash.h
+++ b/include/crypto/hash.h
@@ -21,7 +21,7 @@
 #ifndef QCRYPTO_HASH_H
 #define QCRYPTO_HASH_H

-#include "qapi-types.h"
+#include "qapi/qapi-types-crypto.h"

 /* See also "QCryptoHashAlgorithm" defined in qapi/crypto.json */

diff --git a/include/crypto/hmac.h b/include/crypto/hmac.h
index 5e889059896..aa3c97a2ffa 100644
--- a/include/crypto/hmac.h
+++ b/include/crypto/hmac.h
@@ -12,7 +12,7 @@
 #ifndef QCRYPTO_HMAC_H
 #define QCRYPTO_HMAC_H

-#include "qapi-types.h"
+#include "qapi/qapi-types-crypto.h"

 typedef struct QCryptoHmac QCryptoHmac;
 struct QCryptoHmac {
diff --git a/include/crypto/secret.h b/include/crypto/secret.h
index 07a963e7940..edd0e132366 100644
--- a/include/crypto/secret.h
+++ b/include/crypto/secret.h
@@ -21,6 +21,7 @@
 #ifndef QCRYPTO_SECRET_H
 #define QCRYPTO_SECRET_H

+#include "qapi/qapi-types-crypto.h"
 #include "qom/object.h"

 #define TYPE_QCRYPTO_SECRET "secret"
diff --git a/include/crypto/tlscreds.h b/include/crypto/tlscreds.h
index ad47d88be77..6b011e1dbc6 100644
--- a/include/crypto/tlscreds.h
+++ b/include/crypto/tlscreds.h
@@ -21,6 +21,7 @@
 #ifndef QCRYPTO_TLSCREDS_H
 #define QCRYPTO_TLSCREDS_H

+#include "qapi/qapi-types-crypto.h"
 #include "qom/object.h"

 #ifdef CONFIG_GNUTLS
diff --git a/include/hw/block/block.h b/include/hw/block/block.h
index f532d10e355..d4f4dfffab9 100644
--- a/include/hw/block/block.h
+++ b/include/hw/block/block.h
@@ -12,7 +12,7 @@
 #define HW_BLOCK_H

 #include "qemu-common.h"
-#include "qapi-types.h"
+#include "qapi/qapi-types-block-core.h"

 /* Configuration */

diff --git a/include/hw/block/fdc.h b/include/hw/block/fdc.h
index 68a0c904eaf..3b813c7f7d6 100644
--- a/include/hw/block/fdc.h
+++ b/include/hw/block/fdc.h
@@ -2,7 +2,7 @@
 #define HW_FDC_H

 #include "qemu-common.h"
-#include "qapi-types.h"
+#include "qapi/qapi-types-block.h"

 /* fdc.c */
 #define MAX_FD 2
diff --git a/include/hw/ppc/spapr_drc.h b/include/hw/ppc/spapr_drc.h
index f8d9f5b231c..f6ff32e7e2f 100644
--- a/include/hw/ppc/spapr_drc.h
+++ b/include/hw/ppc/spapr_drc.h
@@ -14,6 +14,7 @@
 #define HW_SPAPR_DRC_H

 #include <libfdt.h>
+#include "qapi/qapi-types-run-state.h"
 #include "qom/object.h"
 #include "sysemu/sysemu.h"
 #include "hw/qdev.h"
diff --git a/include/hw/qdev-properties.h b/include/hw/qdev-properties.h
index 1d61a351086..40c2c8acb1a 100644
--- a/include/hw/qdev-properties.h
+++ b/include/hw/qdev-properties.h
@@ -1,6 +1,7 @@
 #ifndef QEMU_QDEV_PROPERTIES_H
 #define QEMU_QDEV_PROPERTIES_H

+#include "qapi-types.h"
 #include "hw/qdev-core.h"

 /*** qdev-properties.c ***/
diff --git a/include/io/dns-resolver.h b/include/io/dns-resolver.h
index 2f69c08c13f..1a162185cc6 100644
--- a/include/io/dns-resolver.h
+++ b/include/io/dns-resolver.h
@@ -22,6 +22,7 @@
 #define QIO_DNS_RESOLVER_H

 #include "qemu-common.h"
+#include "qapi/qapi-types-sockets.h"
 #include "qom/object.h"
 #include "io/task.h"

diff --git a/include/migration/colo.h b/include/migration/colo.h
index 50ace162059..2fe48ad3535 100644
--- a/include/migration/colo.h
+++ b/include/migration/colo.h
@@ -14,7 +14,7 @@
 #define QEMU_COLO_H

 #include "qemu-common.h"
-#include "qapi-types.h"
+#include "qapi/qapi-types-migration.h"

 void colo_info_init(void);

diff --git a/include/migration/failover.h b/include/migration/failover.h
index ad91ef23819..4c37218dcc1 100644
--- a/include/migration/failover.h
+++ b/include/migration/failover.h
@@ -14,7 +14,7 @@
 #define QEMU_FAILOVER_H

 #include "qemu-common.h"
-#include "qapi-types.h"
+#include "qapi/qapi-types-migration.h"

 void failover_init_state(void);
 FailoverStatus failover_set_state(FailoverStatus old_state,
diff --git a/include/migration/global_state.h b/include/migration/global_=
state.h
index d307de8350e..fd22dd30345 100644
--- a/include/migration/global_state.h
+++ b/include/migration/global_state.h
@@ -13,6 +13,7 @@
 #ifndef QEMU_MIGRATION_GLOBAL_STATE_H
 #define QEMU_MIGRATION_GLOBAL_STATE_H

+#include "qapi/qapi-types-run-state.h"
 #include "sysemu/sysemu.h"

 void register_global_state(void);
diff --git a/include/monitor/monitor.h b/include/monitor/monitor.h
index ad64ad8e682..50f7cea057d 100644
--- a/include/monitor/monitor.h
+++ b/include/monitor/monitor.h
@@ -3,6 +3,7 @@

 #include "qemu-common.h"
 #include "block/block.h"
+#include "qapi-types.h"
 #include "qemu/readline.h"

 extern Monitor *cur_mon;
diff --git a/include/net/filter.h b/include/net/filter.h
index 0c4a2ea6c90..435acd6f82c 100644
--- a/include/net/filter.h
+++ b/include/net/filter.h
@@ -9,6 +9,7 @@
 #ifndef QEMU_NET_FILTER_H
 #define QEMU_NET_FILTER_H

+#include "qapi/qapi-types-net.h"
 #include "qom/object.h"
 #include "qemu-common.h"
 #include "net/queue.h"
diff --git a/include/net/net.h b/include/net/net.h
index 3fc48e4f51a..727643032cf 100644
--- a/include/net/net.h
+++ b/include/net/net.h
@@ -2,7 +2,7 @@
 #define QEMU_NET_H

 #include "qemu/queue.h"
-#include "qapi-types.h"
+#include "qapi/qapi-types-net.h"
 #include "net/queue.h"
 #include "migration/vmstate.h"

diff --git a/include/qapi/clone-visitor.h b/include/qapi/clone-visitor.h
index b119d3daa99..5b665ee38c6 100644
--- a/include/qapi/clone-visitor.h
+++ b/include/qapi/clone-visitor.h
@@ -12,7 +12,6 @@
 #define QAPI_CLONE_VISITOR_H

 #include "qapi/visitor.h"
-#include "qapi-visit.h"

 /*
  * The clone visitor is for direct use only by the QAPI_CLONE() macro;
diff --git a/include/qapi/error.h b/include/qapi/error.h
index c2115a6a4aa..bcb86a79f5e 100644
--- a/include/qapi/error.h
+++ b/include/qapi/error.h
@@ -115,7 +115,7 @@
 #ifndef ERROR_H
 #define ERROR_H

-#include "qapi-types.h"
+#include "qapi/qapi-types-common.h"

 /*
  * Overall category of an error.
diff --git a/include/qapi/qmp/qobject.h b/include/qapi/qmp/qobject.h
index 38ac68845cc..a2964fbf254 100644
--- a/include/qapi/qmp/qobject.h
+++ b/include/qapi/qmp/qobject.h
@@ -32,7 +32,7 @@
 #ifndef QOBJECT_H
 #define QOBJECT_H

-#include "qapi-types.h"
+#include "qapi-builtin-types.h"

 struct QObject {
     QType type;
diff --git a/include/qemu/sockets.h b/include/qemu/sockets.h
index 8889bcb1ecf..e88d4c37abe 100644
--- a/include/qemu/sockets.h
+++ b/include/qemu/sockets.h
@@ -9,7 +9,7 @@ int inet_aton(const char *cp, struct in_addr *ia);

 #endif /* !_WIN32 */

-#include "qapi-types.h"
+#include "qapi/qapi-types-sockets.h"

 /* misc helpers */
 int qemu_socket(int domain, int type, int protocol);
diff --git a/include/qemu/throttle.h b/include/qemu/throttle.h
index 03d45f44f87..abeb886d93c 100644
--- a/include/qemu/throttle.h
+++ b/include/qemu/throttle.h
@@ -26,7 +26,7 @@
 #define THROTTLE_H

 #include "qemu-common.h"
-#include "qapi-types.h"
+#include "qapi/qapi-types-block-core.h"
 #include "qemu/timer.h"

 #define THROTTLE_VALUE_MAX 1000000000000000LL
diff --git a/include/qom/cpu.h b/include/qom/cpu.h
index aff88fa16f6..dc6d4956a81 100644
--- a/include/qom/cpu.h
+++ b/include/qom/cpu.h
@@ -24,6 +24,7 @@
 #include "disas/bfd.h"
 #include "exec/hwaddr.h"
 #include "exec/memattrs.h"
+#include "qapi/qapi-types-run-state.h"
 #include "qemu/bitmap.h"
 #include "qemu/queue.h"
 #include "qemu/thread.h"
diff --git a/include/qom/object.h b/include/qom/object.h
index dc73d59660c..5b5c016d8fa 100644
--- a/include/qom/object.h
+++ b/include/qom/object.h
@@ -14,7 +14,7 @@
 #ifndef QEMU_OBJECT_H
 #define QEMU_OBJECT_H

-#include "qapi-types.h"
+#include "qapi-builtin-types.h"
 #include "qemu/queue.h"

 struct TypeImpl;
diff --git a/include/sysemu/dump.h b/include/sysemu/dump.h
index c14bcfe8c60..2424e314255 100644
--- a/include/sysemu/dump.h
+++ b/include/sysemu/dump.h
@@ -14,6 +14,8 @@
 #ifndef DUMP_H
 #define DUMP_H

+#include "qapi-types.h"
+
 #define MAKEDUMPFILE_SIGNATURE      "makedumpfile"
 #define MAX_SIZE_MDF_HEADER         (4096) /* max size of makedumpfile_h=
eader */
 #define TYPE_FLAT_HEADER            (1)    /* type of flattened format *=
/
diff --git a/include/sysemu/hostmem.h b/include/sysemu/hostmem.h
index d5ab0b99c61..e1efaf04ac7 100644
--- a/include/sysemu/hostmem.h
+++ b/include/sysemu/hostmem.h
@@ -14,6 +14,7 @@
 #define SYSEMU_HOSTMEM_H

 #include "sysemu/sysemu.h" /* for MAX_NODES */
+#include "qapi-types.h"
 #include "qom/object.h"
 #include "exec/memory.h"
 #include "qemu/bitmap.h"
diff --git a/include/sysemu/replay.h b/include/sysemu/replay.h
index dc8ae7b6b11..fb533ed9b6a 100644
--- a/include/sysemu/replay.h
+++ b/include/sysemu/replay.h
@@ -13,6 +13,7 @@
  */

 #include "sysemu.h"
+#include "qapi-types.h"

 /* replay clock kinds */
 enum ReplayClockKind {
diff --git a/include/sysemu/sysemu.h b/include/sysemu/sysemu.h
index 77bb3da5828..bfbef9e69ca 100644
--- a/include/sysemu/sysemu.h
+++ b/include/sysemu/sysemu.h
@@ -2,6 +2,7 @@
 #define SYSEMU_H
 /* Misc. things related to the system emulator.  */

+#include "qapi/qapi-types-run-state.h"
 #include "qemu/queue.h"
 #include "qemu/timer.h"
 #include "qemu/notify.h"
diff --git a/include/sysemu/tpm.h b/include/sysemu/tpm.h
index 32b753d4f3e..9ae1ab6da3b 100644
--- a/include/sysemu/tpm.h
+++ b/include/sysemu/tpm.h
@@ -12,6 +12,7 @@
 #ifndef QEMU_TPM_H
 #define QEMU_TPM_H

+#include "qapi/qapi-types-tpm.h"
 #include "qom/object.h"

 int tpm_config_parse(QemuOptsList *opts_list, const char *optarg);
diff --git a/include/sysemu/watchdog.h b/include/sysemu/watchdog.h
index 677ace39457..a08d16380d7 100644
--- a/include/sysemu/watchdog.h
+++ b/include/sysemu/watchdog.h
@@ -23,7 +23,7 @@
 #define QEMU_WATCHDOG_H

 #include "qemu/queue.h"
-#include "qapi-types.h"
+#include "qapi/qapi-types-run-state.h"

 struct WatchdogTimerModel {
     QLIST_ENTRY(WatchdogTimerModel) entry;
diff --git a/include/ui/console.h b/include/ui/console.h
index f29bacd6255..e0d81f1144b 100644
--- a/include/ui/console.h
+++ b/include/ui/console.h
@@ -5,6 +5,7 @@
 #include "qom/object.h"
 #include "qemu/notify.h"
 #include "qemu/error-report.h"
+#include "qapi/qapi-types-ui.h"

 #ifdef CONFIG_OPENGL
 # include <epoxy/gl.h>
diff --git a/include/ui/input.h b/include/ui/input.h
index ceb22b8eef7..16395ab8f28 100644
--- a/include/ui/input.h
+++ b/include/ui/input.h
@@ -1,7 +1,7 @@
 #ifndef INPUT_H
 #define INPUT_H

-#include "qapi-types.h"
+#include "qapi/qapi-types-ui.h"

 #define INPUT_EVENT_MASK_KEY   (1<<INPUT_EVENT_KIND_KEY)
 #define INPUT_EVENT_MASK_BTN   (1<<INPUT_EVENT_KIND_BTN)
diff --git a/migration/migration.h b/migration/migration.h
index 82cf926b170..08c5d2ded14 100644
--- a/migration/migration.h
+++ b/migration/migration.h
@@ -15,6 +15,7 @@
 #define QEMU_MIGRATION_H

 #include "qemu-common.h"
+#include "qapi/qapi-types-migration.h"
 #include "qemu/thread.h"
 #include "exec/cpu-common.h"
 #include "qemu/coroutine_int.h"
diff --git a/migration/ram.h b/migration/ram.h
index f3a227b4fcc..53f0021c518 100644
--- a/migration/ram.h
+++ b/migration/ram.h
@@ -30,7 +30,7 @@
 #define QEMU_MIGRATION_RAM_H

 #include "qemu-common.h"
-#include "qapi-types.h"
+#include "qapi/qapi-types-migration.h"
 #include "exec/cpu-common.h"

 extern MigrationStats ram_counters;
diff --git a/net/tap_int.h b/net/tap_int.h
index ae6888f74ae..9f931d52d61 100644
--- a/net/tap_int.h
+++ b/net/tap_int.h
@@ -27,7 +27,7 @@
 #define NET_TAP_INT_H

 #include "qemu-common.h"
-#include "qapi-types.h"
+#include "qapi/qapi-types-net.h"

 int tap_open(char *ifname, int ifname_size, int *vnet_hdr,
              int vnet_hdr_required, int mq_required, Error **errp);
diff --git a/replication.h b/replication.h
index ece6ca6133e..8faefe005f8 100644
--- a/replication.h
+++ b/replication.h
@@ -15,6 +15,7 @@
 #ifndef REPLICATION_H
 #define REPLICATION_H

+#include "qapi/qapi-types-block-core.h"
 #include "qemu/queue.h"

 typedef struct ReplicationOps ReplicationOps;
diff --git a/ui/vnc.h b/ui/vnc.h
index 1ca062f3321..7b29def77de 100644
--- a/ui/vnc.h
+++ b/ui/vnc.h
@@ -28,6 +28,7 @@
 #define QEMU_VNC_H

 #include "qemu-common.h"
+#include "qapi/qapi-types-ui.h"
 #include "qemu/queue.h"
 #include "qemu/thread.h"
 #include "ui/console.h"
diff --git a/vl.c b/vl.c
index 3018433706e..24d855a373c 100644
--- a/vl.c
+++ b/vl.c
@@ -97,7 +97,6 @@ int main(int argc, char **argv)
 #include "sysemu/kvm.h"
 #include "sysemu/hax.h"
 #include "qapi/qobject-input-visitor.h"
-#include "qapi-visit.h"
 #include "qemu/option.h"
 #include "qemu/config-file.h"
 #include "qemu-options.h"
@@ -122,10 +121,11 @@ int main(int argc, char **argv)
 #include "qapi/string-input-visitor.h"
 #include "qapi/opts-visitor.h"
 #include "qom/object_interfaces.h"
-#include "qapi-event.h"
 #include "exec/semihost.h"
 #include "crypto/init.h"
 #include "sysemu/replay.h"
+#include "qapi/qapi-events-run-state.h"
+#include "qapi/qapi-visit-block-core.h"
 #include "qapi/qmp/qerror.h"
 #include "sysemu/iothread.h"

diff --git a/backends/cryptodev.c b/backends/cryptodev.c
index d0dff1a463b..f35be377efa 100644
--- a/backends/cryptodev.c
+++ b/backends/cryptodev.c
@@ -26,7 +26,6 @@
 #include "hw/boards.h"
 #include "qapi/error.h"
 #include "qapi/visitor.h"
-#include "qapi-visit.h"
 #include "qemu/config-file.h"
 #include "qom/object_interfaces.h"
 #include "hw/virtio/virtio-crypto.h"
diff --git a/backends/hostmem.c b/backends/hostmem.c
index 8aa04120323..74fc04a3621 100644
--- a/backends/hostmem.c
+++ b/backends/hostmem.c
@@ -9,12 +9,13 @@
  * This work is licensed under the terms of the GNU GPL, version 2 or la=
ter.
  * See the COPYING file in the top-level directory.
  */
+
 #include "qemu/osdep.h"
 #include "sysemu/hostmem.h"
 #include "hw/boards.h"
 #include "qapi/error.h"
+#include "qapi-builtin-visit.h"
 #include "qapi/visitor.h"
-#include "qapi-visit.h"
 #include "qemu/config-file.h"
 #include "qom/object_interfaces.h"

diff --git a/block.c b/block.c
index 628910f6382..c205320a50b 100644
--- a/block.c
+++ b/block.c
@@ -41,7 +41,6 @@
 #include "qemu/coroutine.h"
 #include "block/qapi.h"
 #include "qemu/timer.h"
-#include "qapi-event.h"
 #include "qemu/cutils.h"
 #include "qemu/id.h"

diff --git a/block/block-backend.c b/block/block-backend.c
index 0266ac990b3..94ffbb6a60b 100644
--- a/block/block-backend.c
+++ b/block/block-backend.c
@@ -17,8 +17,8 @@
 #include "block/throttle-groups.h"
 #include "sysemu/blockdev.h"
 #include "sysemu/sysemu.h"
-#include "qapi-event.h"
 #include "qapi/error.h"
+#include "qapi/qapi-events-block.h"
 #include "qemu/id.h"
 #include "qemu/option.h"
 #include "trace.h"
diff --git a/block/crypto.c b/block/crypto.c
index 3df66947c5a..aeac482e7bb 100644
--- a/block/crypto.c
+++ b/block/crypto.c
@@ -24,9 +24,9 @@
 #include "sysemu/block-backend.h"
 #include "crypto/block.h"
 #include "qapi/opts-visitor.h"
+#include "qapi/qapi-visit-crypto.h"
 #include "qapi/qmp/qdict.h"
 #include "qapi/qobject-input-visitor.h"
-#include "qapi-visit.h"
 #include "qapi/error.h"
 #include "qemu/option.h"
 #include "block/crypto.h"
diff --git a/block/nbd.c b/block/nbd.c
index ef81a9f53ba..683f486060c 100644
--- a/block/nbd.c
+++ b/block/nbd.c
@@ -33,7 +33,7 @@
 #include "block/block_int.h"
 #include "qemu/module.h"
 #include "qemu/option.h"
-#include "qapi-visit.h"
+#include "qapi/qapi-visit-sockets.h"
 #include "qapi/qobject-input-visitor.h"
 #include "qapi/qobject-output-visitor.h"
 #include "qapi/qmp/qdict.h"
diff --git a/block/nfs.c b/block/nfs.c
index 6576a73d6eb..bbdb4fadad0 100644
--- a/block/nfs.c
+++ b/block/nfs.c
@@ -35,9 +35,9 @@
 #include "qemu/uri.h"
 #include "qemu/cutils.h"
 #include "sysemu/sysemu.h"
+#include "qapi/qapi-visit-block-core.h"
 #include "qapi/qmp/qdict.h"
 #include "qapi/qmp/qstring.h"
-#include "qapi-visit.h"
 #include "qapi/qobject-input-visitor.h"
 #include "qapi/qobject-output-visitor.h"
 #include <nfsc/libnfs.h>
diff --git a/block/qapi.c b/block/qapi.c
index 1fdeb1ef2fd..4c9923d262b 100644
--- a/block/qapi.c
+++ b/block/qapi.c
@@ -27,10 +27,10 @@
 #include "block/block_int.h"
 #include "block/throttle-groups.h"
 #include "block/write-threshold.h"
-#include "qmp-commands.h"
-#include "qapi-visit.h"
 #include "qapi/error.h"
+#include "qapi/qapi-commands-block-core.h"
 #include "qapi/qobject-output-visitor.h"
+#include "qapi/qapi-visit-block-core.h"
 #include "qapi/qmp/qbool.h"
 #include "qapi/qmp/qdict.h"
 #include "qapi/qmp/qlist.h"
diff --git a/block/qcow2.c b/block/qcow2.c
index fd79c0ebaaf..3dd098b74f8 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -30,15 +30,14 @@
 #include "block/qcow2.h"
 #include "qemu/error-report.h"
 #include "qapi/error.h"
+#include "qapi/qapi-events-block-core.h"
 #include "qapi/qmp/qdict.h"
 #include "qapi/qmp/qstring.h"
-#include "qapi-event.h"
 #include "trace.h"
 #include "qemu/option_int.h"
 #include "qemu/cutils.h"
 #include "qemu/bswap.h"
 #include "qapi/opts-visitor.h"
-#include "qapi-visit.h"
 #include "block/crypto.h"

 /*
diff --git a/block/quorum.c b/block/quorum.c
index 19f1c344252..14333c18aac 100644
--- a/block/quorum.c
+++ b/block/quorum.c
@@ -18,11 +18,11 @@
 #include "qemu/option.h"
 #include "block/block_int.h"
 #include "qapi/error.h"
+#include "qapi/qapi-events-block.h"
 #include "qapi/qmp/qdict.h"
 #include "qapi/qmp/qerror.h"
 #include "qapi/qmp/qlist.h"
 #include "qapi/qmp/qstring.h"
-#include "qapi-event.h"
 #include "crypto/hash.h"

 #define HASH_LENGTH 32
diff --git a/block/sheepdog.c b/block/sheepdog.c
index ac02b10fe03..215223053bb 100644
--- a/block/sheepdog.c
+++ b/block/sheepdog.c
@@ -13,8 +13,8 @@
  */

 #include "qemu/osdep.h"
-#include "qapi-visit.h"
 #include "qapi/error.h"
+#include "qapi/qapi-visit-sockets.h"
 #include "qapi/qmp/qdict.h"
 #include "qapi/qobject-input-visitor.h"
 #include "qemu/uri.h"
diff --git a/block/ssh.c b/block/ssh.c
index b63addcf948..b11d4c5e862 100644
--- a/block/ssh.c
+++ b/block/ssh.c
@@ -34,7 +34,7 @@
 #include "qemu/cutils.h"
 #include "qemu/sockets.h"
 #include "qemu/uri.h"
-#include "qapi-visit.h"
+#include "qapi/qapi-visit-sockets.h"
 #include "qapi/qmp/qdict.h"
 #include "qapi/qmp/qstring.h"
 #include "qapi/qobject-input-visitor.h"
diff --git a/block/throttle-groups.c b/block/throttle-groups.c
index f26bcb5eee4..36cc0430c32 100644
--- a/block/throttle-groups.c
+++ b/block/throttle-groups.c
@@ -30,7 +30,7 @@
 #include "qemu/thread.h"
 #include "sysemu/qtest.h"
 #include "qapi/error.h"
-#include "qapi-visit.h"
+#include "qapi/qapi-visit-block-core.h"
 #include "qom/object.h"
 #include "qom/object_interfaces.h"

diff --git a/block/write-threshold.c b/block/write-threshold.c
index db3de0fa6d3..1d48fc20774 100644
--- a/block/write-threshold.c
+++ b/block/write-threshold.c
@@ -15,9 +15,9 @@
 #include "qemu/coroutine.h"
 #include "block/write-threshold.h"
 #include "qemu/notify.h"
-#include "qapi-event.h"
 #include "qapi/error.h"
-#include "qmp-commands.h"
+#include "qapi/qapi-commands-block-core.h"
+#include "qapi/qapi-events-block-core.h"

 uint64_t bdrv_write_threshold_get(const BlockDriverState *bs)
 {
diff --git a/blockdev-nbd.c b/blockdev-nbd.c
index 3a5479bdad9..65a84739edc 100644
--- a/blockdev-nbd.c
+++ b/blockdev-nbd.c
@@ -14,8 +14,8 @@
 #include "sysemu/block-backend.h"
 #include "hw/block/block.h"
 #include "qapi/error.h"
+#include "qapi/qapi-commands-block.h"
 #include "sysemu/sysemu.h"
-#include "qmp-commands.h"
 #include "block/nbd.h"
 #include "io/channel-socket.h"
 #include "io/net-listener.h"
diff --git a/blockdev.c b/blockdev.c
index 3fb1ca803c5..1fbfd3a2c40 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -40,10 +40,12 @@
 #include "qemu/error-report.h"
 #include "qemu/option.h"
 #include "qemu/config-file.h"
+#include "qapi/qapi-commands-block.h"
+#include "qapi/qapi-commands-transaction.h"
+#include "qapi/qapi-visit-block-core.h"
 #include "qapi/qmp/qdict.h"
 #include "qapi/qmp/qnum.h"
 #include "qapi/qmp/qstring.h"
-#include "qapi-visit.h"
 #include "qapi/error.h"
 #include "qapi/qmp/qerror.h"
 #include "qapi/qmp/qlist.h"
@@ -51,7 +53,6 @@
 #include "sysemu/sysemu.h"
 #include "sysemu/iothread.h"
 #include "block/block_int.h"
-#include "qmp-commands.h"
 #include "block/trace.h"
 #include "sysemu/arch_init.h"
 #include "sysemu/qtest.h"
diff --git a/blockjob.c b/blockjob.c
index 3f52f29f751..801d29d8496 100644
--- a/blockjob.c
+++ b/blockjob.c
@@ -30,11 +30,11 @@
 #include "block/block_int.h"
 #include "sysemu/block-backend.h"
 #include "qapi/error.h"
+#include "qapi/qapi-events-block-core.h"
 #include "qapi/qmp/qerror.h"
 #include "qemu/coroutine.h"
 #include "qemu/id.h"
 #include "qemu/timer.h"
-#include "qapi-event.h"

 /* Right now, this mutex is only needed to synchronize accesses to job->=
busy
  * and job->sleep_timer, such as concurrent calls to block_job_do_yield =
and
diff --git a/chardev/char-fe.c b/chardev/char-fe.c
index e5f870e4d21..392db78b13d 100644
--- a/chardev/char-fe.c
+++ b/chardev/char-fe.c
@@ -25,7 +25,6 @@
 #include "qemu/error-report.h"
 #include "qapi/error.h"
 #include "qapi/qmp/qerror.h"
-#include "qapi-visit.h"
 #include "sysemu/replay.h"

 #include "chardev/char-fe.h"
diff --git a/chardev/char-ringbuf.c b/chardev/char-ringbuf.c
index 679afaa4fd5..87832e27920 100644
--- a/chardev/char-ringbuf.c
+++ b/chardev/char-ringbuf.c
@@ -24,8 +24,8 @@

 #include "qemu/osdep.h"
 #include "chardev/char.h"
-#include "qmp-commands.h"
 #include "qapi/error.h"
+#include "qapi/qapi-commands-char.h"
 #include "qemu/base64.h"
 #include "qemu/option.h"

diff --git a/chardev/char-socket.c b/chardev/char-socket.c
index bdd6cff5f64..22f65971a1d 100644
--- a/chardev/char-socket.c
+++ b/chardev/char-socket.c
@@ -31,6 +31,7 @@
 #include "qemu/option.h"
 #include "qapi/error.h"
 #include "qapi/clone-visitor.h"
+#include "qapi/qapi-visit-sockets.h"

 #include "chardev/char-io.h"

diff --git a/chardev/char.c b/chardev/char.c
index c9a4da55163..5d7b079ef03 100644
--- a/chardev/char.c
+++ b/chardev/char.c
@@ -29,9 +29,8 @@
 #include "qemu/config-file.h"
 #include "qemu/error-report.h"
 #include "chardev/char.h"
-#include "qmp-commands.h"
-#include "qapi-visit.h"
 #include "qapi/error.h"
+#include "qapi/qapi-commands-char.h"
 #include "qapi/qmp/qerror.h"
 #include "sysemu/replay.h"
 #include "qemu/help_option.h"
diff --git a/cpus.c b/cpus.c
index af678264f6e..ac5b21ef076 100644
--- a/cpus.c
+++ b/cpus.c
@@ -27,6 +27,7 @@
 #include "cpu.h"
 #include "monitor/monitor.h"
 #include "qapi/error.h"
+#include "qapi/qapi-events-run-state.h"
 #include "qapi/qmp/qerror.h"
 #include "qemu/error-report.h"
 #include "sysemu/sysemu.h"
@@ -49,7 +50,6 @@
 #include "qemu/bitmap.h"
 #include "qemu/seqlock.h"
 #include "tcg.h"
-#include "qapi-event.h"
 #include "hw/nmi.h"
 #include "sysemu/replay.h"
 #include "hw/boards.h"
diff --git a/hmp.c b/hmp.c
index ae86bfbadeb..cc35a787f94 100644
--- a/hmp.c
+++ b/hmp.c
@@ -29,11 +29,11 @@
 #include "monitor/qdev.h"
 #include "qapi/error.h"
 #include "qapi/opts-visitor.h"
+#include "qapi-builtin-visit.h"
 #include "qapi/qmp/qdict.h"
 #include "qapi/qmp/qerror.h"
 #include "qapi/string-input-visitor.h"
 #include "qapi/string-output-visitor.h"
-#include "qapi-visit.h"
 #include "qom/object_interfaces.h"
 #include "ui/console.h"
 #include "block/nbd.h"
diff --git a/hw/acpi/core.c b/hw/acpi/core.c
index b50b3ca772c..5d4ce925dcd 100644
--- a/hw/acpi/core.c
+++ b/hw/acpi/core.c
@@ -27,8 +27,8 @@
 #include "qemu/config-file.h"
 #include "qapi/error.h"
 #include "qapi/opts-visitor.h"
+#include "qapi/qapi-events-run-state.h"
 #include "qapi-visit.h"
-#include "qapi-event.h"
 #include "qemu/error-report.h"
 #include "qemu/option.h"

diff --git a/hw/block/block.c b/hw/block/block.c
index b0269c857fd..b91e2b6d7ef 100644
--- a/hw/block/block.c
+++ b/hw/block/block.c
@@ -12,6 +12,7 @@
 #include "sysemu/block-backend.h"
 #include "hw/block/block.h"
 #include "qapi/error.h"
+#include "qapi/qapi-types-block.h"
 #include "qemu/error-report.h"

 void blkconf_serial(BlockConf *conf, char **serial)
diff --git a/hw/block/hd-geometry.c b/hw/block/hd-geometry.c
index 57ad5012a70..79384a2b0a2 100644
--- a/hw/block/hd-geometry.c
+++ b/hw/block/hd-geometry.c
@@ -32,6 +32,7 @@

 #include "qemu/osdep.h"
 #include "sysemu/block-backend.h"
+#include "qapi/qapi-types-block.h"
 #include "qemu/bswap.h"
 #include "hw/block/block.h"
 #include "trace.h"
diff --git a/hw/char/virtio-console.c b/hw/char/virtio-console.c
index 4be5d4ee524..679a8248884 100644
--- a/hw/char/virtio-console.c
+++ b/hw/char/virtio-console.c
@@ -15,8 +15,8 @@
 #include "qemu/error-report.h"
 #include "trace.h"
 #include "hw/virtio/virtio-serial.h"
-#include "qapi-event.h"
 #include "qapi/error.h"
+#include "qapi/qapi-events-char.h"

 #define TYPE_VIRTIO_CONSOLE_SERIAL_PORT "virtserialport"
 #define VIRTIO_CONSOLE(obj) \
diff --git a/hw/core/machine.c b/hw/core/machine.c
index 5d445839e89..5e2bbcdaced 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -13,7 +13,7 @@
 #include "qemu/osdep.h"
 #include "hw/boards.h"
 #include "qapi/error.h"
-#include "qapi-visit.h"
+#include "qapi/qapi-visit-common.h"
 #include "qapi/visitor.h"
 #include "hw/sysbus.h"
 #include "sysemu/sysemu.h"
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 55e69d66fe6..94cfd40ef2c 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -67,8 +67,8 @@
 #include "acpi-build.h"
 #include "hw/mem/pc-dimm.h"
 #include "qapi/error.h"
+#include "qapi/qapi-visit-common.h"
 #include "qapi/visitor.h"
-#include "qapi-visit.h"
 #include "qom/cpu.h"
 #include "hw/nmi.h"
 #include "hw/i386/intel_iommu.h"
diff --git a/hw/mem/nvdimm.c b/hw/mem/nvdimm.c
index 61e677f92ff..acb656b6725 100644
--- a/hw/mem/nvdimm.c
+++ b/hw/mem/nvdimm.c
@@ -25,7 +25,6 @@
 #include "qemu/osdep.h"
 #include "qapi/error.h"
 #include "qapi/visitor.h"
-#include "qapi-visit.h"
 #include "hw/mem/nvdimm.h"

 static void nvdimm_get_label_size(Object *obj, Visitor *v, const char *n=
ame,
diff --git a/hw/net/rocker/qmp-norocker.c b/hw/net/rocker/qmp-norocker.c
index 94c1e480aed..0d60513c01b 100644
--- a/hw/net/rocker/qmp-norocker.c
+++ b/hw/net/rocker/qmp-norocker.c
@@ -17,8 +17,8 @@

 #include "qemu/osdep.h"
 #include "qemu-common.h"
-#include "qmp-commands.h"
 #include "qapi/error.h"
+#include "qapi/qapi-commands-rocker.h"
 #include "qapi/qmp/qerror.h"

 RockerSwitch *qmp_query_rocker(const char *name, Error **errp)
diff --git a/hw/net/rocker/rocker.c b/hw/net/rocker/rocker.c
index a2a76c2a746..c02cbefece8 100644
--- a/hw/net/rocker/rocker.c
+++ b/hw/net/rocker/rocker.c
@@ -22,9 +22,9 @@
 #include "net/net.h"
 #include "net/eth.h"
 #include "qapi/error.h"
+#include "qapi/qapi-commands-rocker.h"
 #include "qemu/iov.h"
 #include "qemu/bitops.h"
-#include "qmp-commands.h"

 #include "rocker.h"
 #include "rocker_hw.h"
diff --git a/hw/net/rocker/rocker_fp.c b/hw/net/rocker/rocker_fp.c
index 4b3c9847db7..27b17c890f8 100644
--- a/hw/net/rocker/rocker_fp.c
+++ b/hw/net/rocker/rocker_fp.c
@@ -16,7 +16,7 @@

 #include "qemu/osdep.h"
 #include "net/clients.h"
-
+#include "qapi/qapi-types-rocker.h"
 #include "rocker.h"
 #include "rocker_hw.h"
 #include "rocker_fp.h"
diff --git a/hw/net/rocker/rocker_of_dpa.c b/hw/net/rocker/rocker_of_dpa.=
c
index 9339df2d093..60046720a56 100644
--- a/hw/net/rocker/rocker_of_dpa.c
+++ b/hw/net/rocker/rocker_of_dpa.c
@@ -17,9 +17,9 @@
 #include "qemu/osdep.h"
 #include "net/eth.h"
 #include "qapi/error.h"
+#include "qapi/qapi-commands-rocker.h"
 #include "qemu/iov.h"
 #include "qemu/timer.h"
-#include "qmp-commands.h"

 #include "rocker.h"
 #include "rocker_hw.h"
diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index 369d40b3782..188744e17d5 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -23,7 +23,7 @@
 #include "net/vhost_net.h"
 #include "hw/virtio/virtio-bus.h"
 #include "qapi/error.h"
-#include "qapi-event.h"
+#include "qapi/qapi-events-net.h"
 #include "hw/virtio/virtio-access.h"
 #include "migration/misc.h"

diff --git a/hw/ppc/spapr_rtas.c b/hw/ppc/spapr_rtas.c
index 4bb939d3d11..0ec5fa4cfe4 100644
--- a/hw/ppc/spapr_rtas.c
+++ b/hw/ppc/spapr_rtas.c
@@ -38,7 +38,6 @@
 #include "hw/ppc/spapr_vio.h"
 #include "hw/ppc/spapr_rtas.h"
 #include "hw/ppc/ppc.h"
-#include "qapi-event.h"
 #include "hw/boards.h"

 #include <libfdt.h>
diff --git a/hw/tpm/tpm_emulator.c b/hw/tpm/tpm_emulator.c
index b787aee13bc..f187a72c101 100644
--- a/hw/tpm/tpm_emulator.c
+++ b/hw/tpm/tpm_emulator.c
@@ -38,6 +38,7 @@
 #include "migration/blocker.h"
 #include "qapi/error.h"
 #include "qapi/clone-visitor.h"
+#include "qapi/qapi-visit-tpm.h"
 #include "chardev/char-fe.h"

 #define DEBUG_TPM 0
diff --git a/hw/tpm/tpm_passthrough.c b/hw/tpm/tpm_passthrough.c
index a495fe07f4a..211df3191c9 100644
--- a/hw/tpm/tpm_passthrough.c
+++ b/hw/tpm/tpm_passthrough.c
@@ -30,6 +30,7 @@
 #include "tpm_int.h"
 #include "hw/hw.h"
 #include "qapi/clone-visitor.h"
+#include "qapi/qapi-visit-tpm.h"
 #include "tpm_util.h"

 #define DEBUG_TPM 0
diff --git a/hw/watchdog/watchdog.c b/hw/watchdog/watchdog.c
index 98a5dd6689e..c7843d5748a 100644
--- a/hw/watchdog/watchdog.c
+++ b/hw/watchdog/watchdog.c
@@ -24,9 +24,9 @@
 #include "qemu/config-file.h"
 #include "qemu/queue.h"
 #include "qapi/error.h"
+#include "qapi/qapi-events-run-state.h"
 #include "sysemu/sysemu.h"
 #include "sysemu/watchdog.h"
-#include "qapi-event.h"
 #include "hw/nmi.h"
 #include "qemu/help_option.h"
 #include "qmp-commands.h"
diff --git a/io/channel-socket.c b/io/channel-socket.c
index 563e297357c..8359b6683ac 100644
--- a/io/channel-socket.c
+++ b/io/channel-socket.c
@@ -20,6 +20,7 @@

 #include "qemu/osdep.h"
 #include "qapi/error.h"
+#include "qapi/qapi-visit-sockets.h"
 #include "io/channel-socket.h"
 #include "io/channel-watch.h"
 #include "trace.h"
diff --git a/io/dns-resolver.c b/io/dns-resolver.c
index c072d121c3a..8c924071c41 100644
--- a/io/dns-resolver.c
+++ b/io/dns-resolver.c
@@ -21,6 +21,7 @@
 #include "qemu/osdep.h"
 #include "io/dns-resolver.h"
 #include "qapi/clone-visitor.h"
+#include "qapi/qapi-visit-sockets.h"
 #include "qemu/sockets.h"
 #include "qapi/error.h"
 #include "qemu/cutils.h"
diff --git a/migration/colo-failover.c b/migration/colo-failover.c
index 891785cb631..0ae0c412212 100644
--- a/migration/colo-failover.c
+++ b/migration/colo-failover.c
@@ -15,8 +15,8 @@
 #include "migration/failover.h"
 #include "qemu/main-loop.h"
 #include "migration.h"
-#include "qmp-commands.h"
 #include "qapi/error.h"
+#include "qapi/qapi-commands-migration.h"
 #include "qapi/qmp/qerror.h"
 #include "qemu/error-report.h"
 #include "trace.h"
diff --git a/migration/colo.c b/migration/colo.c
index 245a46d59de..4381067ed4c 100644
--- a/migration/colo.c
+++ b/migration/colo.c
@@ -13,6 +13,7 @@
 #include "qemu/osdep.h"
 #include "sysemu/sysemu.h"
 #include "qapi/error.h"
+#include "qapi/qapi-commands-migration.h"
 #include "qemu-file-channel.h"
 #include "migration.h"
 #include "qemu-file.h"
@@ -24,7 +25,6 @@
 #include "qemu/error-report.h"
 #include "migration/failover.h"
 #include "replication.h"
-#include "qmp-commands.h"

 static bool vmstate_loading;

diff --git a/migration/migration.c b/migration/migration.c
index 0aa596f8678..e345d0cc7e8 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -31,15 +31,15 @@
 #include "migration/vmstate.h"
 #include "block/block.h"
 #include "qapi/error.h"
+#include "qapi/qapi-commands-migration.h"
+#include "qapi/qapi-events-migration.h"
 #include "qapi/qmp/qerror.h"
 #include "qapi/qmp/qnull.h"
 #include "qemu/rcu.h"
 #include "block.h"
 #include "postcopy-ram.h"
 #include "qemu/thread.h"
-#include "qmp-commands.h"
 #include "trace.h"
-#include "qapi-event.h"
 #include "exec/target_page.h"
 #include "io/channel-buffer.h"
 #include "migration/colo.h"
diff --git a/migration/ram.c b/migration/ram.c
index 5e33e5cc790..3b6c077964b 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -29,7 +29,6 @@
 #include "qemu/osdep.h"
 #include "cpu.h"
 #include <zlib.h>
-#include "qapi-event.h"
 #include "qemu/cutils.h"
 #include "qemu/bitops.h"
 #include "qemu/bitmap.h"
@@ -44,6 +43,7 @@
 #include "migration/page_cache.h"
 #include "qemu/error-report.h"
 #include "qapi/error.h"
+#include "qapi/qapi-events-migration.h"
 #include "qapi/qmp/qerror.h"
 #include "trace.h"
 #include "exec/ram_addr.h"
diff --git a/net/colo-compare.c b/net/colo-compare.c
index 76e03fdb140..23b2d2c4cc6 100644
--- a/net/colo-compare.c
+++ b/net/colo-compare.c
@@ -25,7 +25,6 @@
 #include "net/queue.h"
 #include "chardev/char-fe.h"
 #include "qemu/sockets.h"
-#include "qapi-visit.h"
 #include "net/colo.h"
 #include "sysemu/iothread.h"

diff --git a/net/filter-buffer.c b/net/filter-buffer.c
index 9ce96aaa354..7c487629f92 100644
--- a/net/filter-buffer.c
+++ b/net/filter-buffer.c
@@ -13,8 +13,8 @@
 #include "qemu-common.h"
 #include "qemu/timer.h"
 #include "qemu/iov.h"
+#include "qapi-builtin-visit.h"
 #include "qapi/qmp/qerror.h"
-#include "qapi-visit.h"
 #include "qom/object.h"

 #define TYPE_FILTER_BUFFER "filter-buffer"
diff --git a/net/filter-mirror.c b/net/filter-mirror.c
index bd78e25d127..3a61cf21e8c 100644
--- a/net/filter-mirror.c
+++ b/net/filter-mirror.c
@@ -14,7 +14,6 @@
 #include "net/net.h"
 #include "qemu-common.h"
 #include "qapi/error.h"
-#include "qapi-visit.h"
 #include "qom/object.h"
 #include "qemu/main-loop.h"
 #include "qemu/error-report.h"
diff --git a/net/filter-rewriter.c b/net/filter-rewriter.c
index 6201494ceb8..62dad2d773c 100644
--- a/net/filter-rewriter.c
+++ b/net/filter-rewriter.c
@@ -16,7 +16,6 @@
 #include "net/net.h"
 #include "qemu-common.h"
 #include "qemu/error-report.h"
-#include "qapi-visit.h"
 #include "qom/object.h"
 #include "qemu/main-loop.h"
 #include "qemu/iov.h"
diff --git a/net/net.c b/net/net.c
index 7d429252586..547c4991105 100644
--- a/net/net.c
+++ b/net/net.c
@@ -33,18 +33,18 @@

 #include "monitor/monitor.h"
 #include "qemu/help_option.h"
+#include "qapi/qapi-commands-net.h"
+#include "qapi/qapi-visit-net.h"
 #include "qapi/qmp/qdict.h"
 #include "qapi/qmp/qerror.h"
 #include "qemu/error-report.h"
 #include "qemu/sockets.h"
 #include "qemu/cutils.h"
 #include "qemu/config-file.h"
-#include "qmp-commands.h"
 #include "hw/qdev.h"
 #include "qemu/iov.h"
 #include "qemu/main-loop.h"
 #include "qemu/option.h"
-#include "qapi-visit.h"
 #include "qapi/error.h"
 #include "qapi/opts-visitor.h"
 #include "sysemu/sysemu.h"
diff --git a/net/vhost-user.c b/net/vhost-user.c
index cb455125069..98f36010495 100644
--- a/net/vhost-user.c
+++ b/net/vhost-user.c
@@ -14,10 +14,10 @@
 #include "net/vhost-user.h"
 #include "chardev/char-fe.h"
 #include "qapi/error.h"
+#include "qapi/qapi-commands-net.h"
 #include "qemu/config-file.h"
 #include "qemu/error-report.h"
 #include "qemu/option.h"
-#include "qmp-commands.h"
 #include "trace.h"

 typedef struct VhostUserState {
diff --git a/qemu-img.c b/qemu-img.c
index 56edc152181..40bf7aa7d15 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -27,7 +27,7 @@

 #include "qemu-version.h"
 #include "qapi/error.h"
-#include "qapi-visit.h"
+#include "qapi/qapi-visit-block-core.h"
 #include "qapi/qobject-output-visitor.h"
 #include "qapi/qmp/qjson.h"
 #include "qapi/qmp/qdict.h"
diff --git a/qom/object.c b/qom/object.c
index 5dcee4683ce..81b4f7ac482 100644
--- a/qom/object.c
+++ b/qom/object.c
@@ -16,9 +16,9 @@
 #include "qom/object_interfaces.h"
 #include "qemu/cutils.h"
 #include "qapi/visitor.h"
-#include "qapi-visit.h"
 #include "qapi/string-input-visitor.h"
 #include "qapi/string-output-visitor.h"
+#include "qapi-builtin-visit.h"
 #include "qapi/qmp/qerror.h"
 #include "trace.h"

diff --git a/qom/object_interfaces.c b/qom/object_interfaces.c
index 43d9aa0946d..2f76e1f36d5 100644
--- a/qom/object_interfaces.c
+++ b/qom/object_interfaces.c
@@ -5,7 +5,6 @@
 #include "qom/object_interfaces.h"
 #include "qemu/module.h"
 #include "qemu/option.h"
-#include "qapi-visit.h"
 #include "qapi/opts-visitor.h"
 #include "qemu/config-file.h"

diff --git a/replay/replay-input.c b/replay/replay-input.c
index 3ab1536bf75..6ee8b5f8dbf 100644
--- a/replay/replay-input.c
+++ b/replay/replay-input.c
@@ -16,6 +16,7 @@
 #include "qemu/notify.h"
 #include "ui/input.h"
 #include "qapi/clone-visitor.h"
+#include "qapi/qapi-visit-ui.h"

 void replay_save_input_event(InputEvent *evt)
 {
diff --git a/stubs/tpm.c b/stubs/tpm.c
index c18aac1c739..6729bc85172 100644
--- a/stubs/tpm.c
+++ b/stubs/tpm.c
@@ -4,9 +4,10 @@
  * This work is licensed under the terms of the GNU GPL, version 2 or la=
ter.
  * See the COPYING file in the top-level directory.
  */
+
 #include "qemu/osdep.h"
+#include "qapi/qapi-commands-tpm.h"
 #include "sysemu/tpm.h"
-#include "qmp-commands.h"

 int tpm_init(void)
 {
diff --git a/target/s390x/kvm.c b/target/s390x/kvm.c
index 656aaea2cd0..f570896dc16 100644
--- a/target/s390x/kvm.c
+++ b/target/s390x/kvm.c
@@ -41,7 +41,6 @@
 #include "exec/gdbstub.h"
 #include "exec/address-spaces.h"
 #include "trace.h"
-#include "qapi-event.h"
 #include "hw/s390x/s390-pci-inst.h"
 #include "hw/s390x/s390-pci-bus.h"
 #include "hw/s390x/ipl.h"
diff --git a/target/s390x/sigp.c b/target/s390x/sigp.c
index 5a7a9c4cfbd..92b2830940c 100644
--- a/target/s390x/sigp.c
+++ b/target/s390x/sigp.c
@@ -17,6 +17,7 @@
 #include "exec/exec-all.h"
 #include "sysemu/sysemu.h"
 #include "trace.h"
+#include "qapi-types.h"

 QemuMutex qemu_sigp_mutex;

diff --git a/tests/test-char.c b/tests/test-char.c
index b3586209113..b3a77af0855 100644
--- a/tests/test-char.c
+++ b/tests/test-char.c
@@ -8,9 +8,9 @@
 #include "chardev/char-mux.h"
 #include "sysemu/sysemu.h"
 #include "qapi/error.h"
+#include "qapi/qapi-commands-char.h"
 #include "qapi/qmp/qdict.h"
 #include "qom/qom-qobject.h"
-#include "qmp-commands.h"

 static bool quit;

diff --git a/tests/test-qmp-event.c b/tests/test-qmp-event.c
index 80123413438..5fbe7e551f7 100644
--- a/tests/test-qmp-event.c
+++ b/tests/test-qmp-event.c
@@ -14,7 +14,6 @@
 #include "qemu/osdep.h"

 #include "qemu-common.h"
-#include "test-qapi-visit.h"
 #include "test-qapi-event.h"
 #include "qapi/error.h"
 #include "qapi/qmp/qbool.h"
diff --git a/tpm.c b/tpm.c
index d11b10bed86..2db03a09b21 100644
--- a/tpm.c
+++ b/tpm.c
@@ -15,12 +15,12 @@
 #include "qemu/osdep.h"

 #include "qapi/error.h"
+#include "qapi/qapi-commands-tpm.h"
 #include "qapi/qmp/qerror.h"
 #include "sysemu/tpm_backend.h"
 #include "sysemu/tpm.h"
 #include "qemu/config-file.h"
 #include "qemu/error-report.h"
-#include "qmp-commands.h"

 static QLIST_HEAD(, TPMBackend) tpm_backends =3D
     QLIST_HEAD_INITIALIZER(tpm_backends);
diff --git a/trace/qmp.c b/trace/qmp.c
index ccd35cd840a..756086c79fb 100644
--- a/trace/qmp.c
+++ b/trace/qmp.c
@@ -9,7 +9,7 @@

 #include "qemu/osdep.h"
 #include "qapi/error.h"
-#include "qmp-commands.h"
+#include "qapi/qapi-commands-trace.h"
 #include "trace/control.h"


diff --git a/ui/console.c b/ui/console.c
index e22931a3961..6a1f49916ee 100644
--- a/ui/console.c
+++ b/ui/console.c
@@ -26,9 +26,9 @@
 #include "ui/console.h"
 #include "hw/qdev-core.h"
 #include "qapi/error.h"
+#include "qapi/qapi-commands-ui.h"
 #include "qemu/option.h"
 #include "qemu/timer.h"
-#include "qmp-commands.h"
 #include "chardev/char-fe.h"
 #include "trace.h"
 #include "exec/memory.h"
diff --git a/ui/input-legacy.c b/ui/input-legacy.c
index 92b37ccb902..e5d4db1d973 100644
--- a/ui/input-legacy.c
+++ b/ui/input-legacy.c
@@ -23,9 +23,9 @@
  */

 #include "qemu/osdep.h"
+#include "qapi/qapi-commands-ui.h"
 #include "sysemu/sysemu.h"
 #include "ui/console.h"
-#include "qmp-commands.h"
 #include "ui/keymaps.h"
 #include "ui/input.h"

diff --git a/ui/input.c b/ui/input.c
index 8bef0fb0383..51b1019252c 100644
--- a/ui/input.c
+++ b/ui/input.c
@@ -1,9 +1,9 @@
 #include "qemu/osdep.h"
 #include "sysemu/sysemu.h"
 #include "qapi/error.h"
+#include "qapi/qapi-commands-ui.h"
 #include "qapi/qmp/qdict.h"
 #include "qemu/error-report.h"
-#include "qmp-commands.h"
 #include "trace.h"
 #include "ui/input.h"
 #include "ui/console.h"
diff --git a/ui/spice-core.c b/ui/spice-core.c
index e449172fe90..ae8921a201c 100644
--- a/ui/spice-core.c
+++ b/ui/spice-core.c
@@ -28,14 +28,14 @@
 #include "qemu/queue.h"
 #include "qemu-x509.h"
 #include "qemu/sockets.h"
-#include "qmp-commands.h"
 #include "qapi/error.h"
+#include "qapi/qapi-commands-ui.h"
+#include "qapi/qapi-events-ui.h"
 #include "qemu/notify.h"
 #include "qemu/option.h"
 #include "migration/misc.h"
 #include "hw/hw.h"
 #include "ui/spice-display.h"
-#include "qapi-event.h"

 /* core bits */

diff --git a/ui/vnc.c b/ui/vnc.c
index d19f86c7f41..a25e408cf03 100644
--- a/ui/vnc.c
+++ b/ui/vnc.c
@@ -36,7 +36,7 @@
 #include "qemu/acl.h"
 #include "qemu/config-file.h"
 #include "qapi/error.h"
-#include "qmp-commands.h"
+#include "qapi/qapi-commands-ui.h"
 #include "ui/input.h"
 #include "qapi-event.h"
 #include "crypto/hash.h"
diff --git a/util/qemu-sockets.c b/util/qemu-sockets.c
index fbbef69f627..7f13e8a338c 100644
--- a/util/qemu-sockets.c
+++ b/util/qemu-sockets.c
@@ -24,11 +24,11 @@
 #include "monitor/monitor.h"
 #include "qapi/clone-visitor.h"
 #include "qapi/error.h"
+#include "qapi/qapi-visit-sockets.h"
 #include "qemu/sockets.h"
 #include "qemu/main-loop.h"
 #include "qapi/qobject-input-visitor.h"
 #include "qapi/qobject-output-visitor.h"
-#include "qapi-visit.h"
 #include "qemu/cutils.h"

 #ifndef AI_ADDRCONFIG
--=20
2.14.3

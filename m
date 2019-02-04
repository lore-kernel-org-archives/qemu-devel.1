Received: from eggs.gnu.org ([209.51.188.92]:45897)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gqlXr-0004pz-Cq
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 16:12:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gqlXp-0002Fe-FK
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 16:12:47 -0500
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Date: Mon,  4 Feb 2019 22:12:03 +0100
Message-Id: <20190204211204.27321-3-philmd@redhat.com>
In-Reply-To: <20190204211204.27321-1-philmd@redhat.com>
References: <20190204211204.27321-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3 2/3] util/cutils: Move ctype macros to
 "cutils.h"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-trivial@nongnu.org, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Cornelia Huck <cohuck@redhat.com>, Halil Pasic <pasic@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Richard Henderson <rth@twiddle.net>, David Hildenbrand <david@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>, Markus Armbruster <armbru@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, Michael Clark <mjc@sifive.com>, Palmer Dabbelt <palmer@sifive.com>, Alistair Francis <Alistair.Francis@wdc.com>, Sagar Karandikar <sagark@eecs.berkeley.edu>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, Gerd Hoffmann <kraxel@redhat.com>, "open list:S390 Virtio-ccw" <qemu-s390x@nongnu.org>, "open list:PowerPC" <qemu-ppc@nongnu.org>

Introduced in cd390083ad1, these macros don't need to be in
a generic header.
Add documentation to justify their use.

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
---
v2: Fixed checkpatch warnings (tabs)
---
 hw/core/bus.c              |  2 +-
 hw/core/qdev-properties.c  |  1 +
 hw/s390x/s390-virtio-ccw.c |  1 +
 hw/scsi/scsi-generic.c     |  2 +-
 include/qemu-common.h      | 16 ----------------
 include/qemu/cutils.h      | 25 +++++++++++++++++++++++++
 qapi/qapi-util.c           |  2 +-
 qobject/json-parser.c      |  1 -
 target/ppc/monitor.c       |  1 +
 target/riscv/cpu.c         |  1 +
 ui/keymaps.c               |  1 +
 util/id.c                  |  2 +-
 util/readline.c            |  1 -
 13 files changed, 34 insertions(+), 22 deletions(-)

diff --git a/hw/core/bus.c b/hw/core/bus.c
index 4651f24486..dceb144075 100644
--- a/hw/core/bus.c
+++ b/hw/core/bus.c
@@ -18,7 +18,7 @@
  */
=20
 #include "qemu/osdep.h"
-#include "qemu-common.h"
+#include "qemu/cutils.h"
 #include "hw/qdev.h"
 #include "qapi/error.h"
=20
diff --git a/hw/core/qdev-properties.c b/hw/core/qdev-properties.c
index 5da1439a8b..f36006bfce 100644
--- a/hw/core/qdev-properties.c
+++ b/hw/core/qdev-properties.c
@@ -1,4 +1,5 @@
 #include "qemu/osdep.h"
+#include "qemu/cutils.h"
 #include "net/net.h"
 #include "hw/qdev.h"
 #include "qapi/error.h"
diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
index 811fdf913d..3ef42dfaf9 100644
--- a/hw/s390x/s390-virtio-ccw.c
+++ b/hw/s390x/s390-virtio-ccw.c
@@ -11,6 +11,7 @@
  */
=20
 #include "qemu/osdep.h"
+#include "qemu/cutils.h"
 #include "qapi/error.h"
 #include "cpu.h"
 #include "hw/boards.h"
diff --git a/hw/scsi/scsi-generic.c b/hw/scsi/scsi-generic.c
index 7237b4162e..86f65fd474 100644
--- a/hw/scsi/scsi-generic.c
+++ b/hw/scsi/scsi-generic.c
@@ -12,8 +12,8 @@
  */
=20
 #include "qemu/osdep.h"
+#include "qemu/cutils.h"
 #include "qapi/error.h"
-#include "qemu-common.h"
 #include "qemu/error-report.h"
 #include "hw/scsi/scsi.h"
 #include "hw/scsi/emulation.h"
diff --git a/include/qemu-common.h b/include/qemu-common.h
index 760527294f..ed43ae286d 100644
--- a/include/qemu-common.h
+++ b/include/qemu-common.h
@@ -33,22 +33,6 @@ int qemu_main(int argc, char **argv, char **envp);
 void qemu_get_timedate(struct tm *tm, int offset);
 int qemu_timedate_diff(struct tm *tm);
=20
-#define qemu_isalnum(c)		isalnum((unsigned char)(c))
-#define qemu_isalpha(c)		isalpha((unsigned char)(c))
-#define qemu_iscntrl(c)		iscntrl((unsigned char)(c))
-#define qemu_isdigit(c)		isdigit((unsigned char)(c))
-#define qemu_isgraph(c)		isgraph((unsigned char)(c))
-#define qemu_islower(c)		islower((unsigned char)(c))
-#define qemu_isprint(c)		isprint((unsigned char)(c))
-#define qemu_ispunct(c)		ispunct((unsigned char)(c))
-#define qemu_isspace(c)		isspace((unsigned char)(c))
-#define qemu_isupper(c)		isupper((unsigned char)(c))
-#define qemu_isxdigit(c)	isxdigit((unsigned char)(c))
-#define qemu_tolower(c)		tolower((unsigned char)(c))
-#define qemu_toupper(c)		toupper((unsigned char)(c))
-#define qemu_isascii(c)		isascii((unsigned char)(c))
-#define qemu_toascii(c)		toascii((unsigned char)(c))
-
 void *qemu_oom_check(void *ptr);
=20
 ssize_t qemu_write_full(int fd, const void *buf, size_t count)
diff --git a/include/qemu/cutils.h b/include/qemu/cutils.h
index 9ee40470e3..644f2d75bd 100644
--- a/include/qemu/cutils.h
+++ b/include/qemu/cutils.h
@@ -3,6 +3,31 @@
=20
 #include "qemu/fprintf-fn.h"
=20
+/**
+ * unsigned ctype macros:
+ *
+ * The standards require that the argument for these functions
+ * is either EOF or a value that is representable in the type
+ * unsigned char. If the argument is of type char, it must be
+ * cast to unsigned char. This is what these macros do,
+ * avoiding 'signed to unsigned' conversion warnings.
+ */
+#define qemu_isalnum(c)     isalnum((unsigned char)(c))
+#define qemu_isalpha(c)     isalpha((unsigned char)(c))
+#define qemu_iscntrl(c)     iscntrl((unsigned char)(c))
+#define qemu_isdigit(c)     isdigit((unsigned char)(c))
+#define qemu_isgraph(c)     isgraph((unsigned char)(c))
+#define qemu_islower(c)     islower((unsigned char)(c))
+#define qemu_isprint(c)     isprint((unsigned char)(c))
+#define qemu_ispunct(c)     ispunct((unsigned char)(c))
+#define qemu_isspace(c)     isspace((unsigned char)(c))
+#define qemu_isupper(c)     isupper((unsigned char)(c))
+#define qemu_isxdigit(c)    isxdigit((unsigned char)(c))
+#define qemu_tolower(c)     tolower((unsigned char)(c))
+#define qemu_toupper(c)     toupper((unsigned char)(c))
+#define qemu_isascii(c)     isascii((unsigned char)(c))
+#define qemu_toascii(c)     toascii((unsigned char)(c))
+
 /**
  * pstrcpy:
  * @buf: buffer to copy string into
diff --git a/qapi/qapi-util.c b/qapi/qapi-util.c
index e9b266bb70..ea93ae05d9 100644
--- a/qapi/qapi-util.c
+++ b/qapi/qapi-util.c
@@ -11,8 +11,8 @@
  */
=20
 #include "qemu/osdep.h"
+#include "qemu/cutils.h"
 #include "qapi/error.h"
-#include "qemu-common.h"
=20
 const char *qapi_enum_lookup(const QEnumLookup *lookup, int val)
 {
diff --git a/qobject/json-parser.c b/qobject/json-parser.c
index d8eb210c0c..cad019d4cc 100644
--- a/qobject/json-parser.c
+++ b/qobject/json-parser.c
@@ -15,7 +15,6 @@
 #include "qemu/cutils.h"
 #include "qemu/unicode.h"
 #include "qapi/error.h"
-#include "qemu-common.h"
 #include "qapi/qmp/qbool.h"
 #include "qapi/qmp/qdict.h"
 #include "qapi/qmp/qlist.h"
diff --git a/target/ppc/monitor.c b/target/ppc/monitor.c
index 04deec8030..173177081b 100644
--- a/target/ppc/monitor.c
+++ b/target/ppc/monitor.c
@@ -22,6 +22,7 @@
  * THE SOFTWARE.
  */
 #include "qemu/osdep.h"
+#include "qemu/cutils.h"
 #include "cpu.h"
 #include "monitor/monitor.h"
 #include "monitor/hmp-target.h"
diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 28d7e5302f..77fb2372b9 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -19,6 +19,7 @@
=20
 #include "qemu/osdep.h"
 #include "qemu/log.h"
+#include "qemu/cutils.h"
 #include "cpu.h"
 #include "exec/exec-all.h"
 #include "qapi/error.h"
diff --git a/ui/keymaps.c b/ui/keymaps.c
index 6e44f738ed..a672fe3dd3 100644
--- a/ui/keymaps.c
+++ b/ui/keymaps.c
@@ -23,6 +23,7 @@
  */
=20
 #include "qemu/osdep.h"
+#include "qemu/cutils.h"
 #include "keymaps.h"
 #include "sysemu/sysemu.h"
 #include "trace.h"
diff --git a/util/id.c b/util/id.c
index 6141352955..ca21a77522 100644
--- a/util/id.c
+++ b/util/id.c
@@ -11,7 +11,7 @@
  */
=20
 #include "qemu/osdep.h"
-#include "qemu-common.h"
+#include "qemu/cutils.h"
 #include "qemu/id.h"
=20
 bool id_wellformed(const char *id)
diff --git a/util/readline.c b/util/readline.c
index ec91ee0fea..f3d8b0698a 100644
--- a/util/readline.c
+++ b/util/readline.c
@@ -23,7 +23,6 @@
  */
=20
 #include "qemu/osdep.h"
-#include "qemu-common.h"
 #include "qemu/readline.h"
 #include "qemu/cutils.h"
=20
--=20
2.20.1

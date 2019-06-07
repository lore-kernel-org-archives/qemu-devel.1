Return-Path: <SRS0=3yEa=UG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9871C2BCA1
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 17:53:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7E664208C0
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 17:53:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E664208C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49916 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hZJ3p-0000gp-Nj
	for qemu-devel@archiver.kernel.org; Fri, 07 Jun 2019 13:53:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54159)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <armbru@redhat.com>) id 1hZH0Q-00045E-92
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 11:42:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1hZGls-0000aG-IQ
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 11:27:19 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58557)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1hZGlr-000837-KN
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 11:27:11 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id C0EBDC010924;
 Fri,  7 Jun 2019 15:26:48 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-148.ams2.redhat.com
 [10.36.116.148])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 681AD10AFF08;
 Fri,  7 Jun 2019 15:26:48 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id EB59111386B0; Fri,  7 Jun 2019 17:26:46 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Date: Fri,  7 Jun 2019 17:26:36 +0200
Message-Id: <20190607152646.4822-3-armbru@redhat.com>
In-Reply-To: <20190607152646.4822-1-armbru@redhat.com>
References: <20190607152646.4822-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.31]); Fri, 07 Jun 2019 15:26:50 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 02/12] qemu-common: Move qemu_isalnum() etc. to
 qemu/ctype.h
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Richard Henderson <richard.henderson@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Message-Id: <20190523143508.25387-3-armbru@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 block/ssh.c                |  1 +
 block/vvfat.c              |  1 +
 gdbstub.c                  |  2 ++
 hw/core/bus.c              |  2 +-
 hw/core/qdev-properties.c  |  1 +
 hw/s390x/s390-virtio-ccw.c |  1 +
 hw/scsi/scsi-generic.c     |  2 +-
 include/qemu-common.h      | 16 ----------------
 include/qemu/ctype.h       | 27 +++++++++++++++++++++++++++
 monitor.c                  |  1 +
 net/net.c                  |  1 +
 net/tap-solaris.c          |  1 +
 qapi/qapi-util.c           |  2 +-
 qobject/json-parser.c      |  2 +-
 target/ppc/monitor.c       |  2 ++
 target/riscv/cpu.c         |  1 +
 tests/libqtest.c           |  1 +
 tests/vhost-user-bridge.c  |  2 +-
 ui/keymaps.c               |  1 +
 util/cutils.c              |  3 ++-
 util/id.c                  |  2 +-
 util/readline.c            |  2 +-
 22 files changed, 50 insertions(+), 24 deletions(-)
 create mode 100644 include/qemu/ctype.h

diff --git a/block/ssh.c b/block/ssh.c
index 12fd4f39e8..584c302fe6 100644
--- a/block/ssh.c
+++ b/block/ssh.c
@@ -32,6 +32,7 @@
 #include "qapi/error.h"
 #include "qemu/error-report.h"
 #include "qemu/option.h"
+#include "qemu/ctype.h"
 #include "qemu/cutils.h"
 #include "qemu/sockets.h"
 #include "qemu/uri.h"
diff --git a/block/vvfat.c b/block/vvfat.c
index 253cc716dd..f6c28805dd 100644
--- a/block/vvfat.c
+++ b/block/vvfat.c
@@ -34,6 +34,7 @@
 #include "migration/blocker.h"
 #include "qapi/qmp/qdict.h"
 #include "qapi/qmp/qstring.h"
+#include "qemu/ctype.h"
 #include "qemu/cutils.h"
 #include "qemu/error-report.h"
=20
diff --git a/gdbstub.c b/gdbstub.c
index 462f89edfe..9159d7d153 100644
--- a/gdbstub.c
+++ b/gdbstub.c
@@ -16,9 +16,11 @@
  * You should have received a copy of the GNU Lesser General Public
  * License along with this library; if not, see <http://www.gnu.org/lice=
nses/>.
  */
+
 #include "qemu/osdep.h"
 #include "qapi/error.h"
 #include "qemu/error-report.h"
+#include "qemu/ctype.h"
 #include "qemu/cutils.h"
 #include "trace-root.h"
 #ifdef CONFIG_USER_ONLY
diff --git a/hw/core/bus.c b/hw/core/bus.c
index e09843f6ab..60c4720379 100644
--- a/hw/core/bus.c
+++ b/hw/core/bus.c
@@ -18,7 +18,7 @@
  */
=20
 #include "qemu/osdep.h"
-#include "qemu-common.h"
+#include "qemu/ctype.h"
 #include "hw/qdev.h"
 #include "qapi/error.h"
=20
diff --git a/hw/core/qdev-properties.c b/hw/core/qdev-properties.c
index 5da1439a8b..81c97f48a7 100644
--- a/hw/core/qdev-properties.c
+++ b/hw/core/qdev-properties.c
@@ -4,6 +4,7 @@
 #include "qapi/error.h"
 #include "hw/pci/pci.h"
 #include "qapi/qmp/qerror.h"
+#include "qemu/ctype.h"
 #include "qemu/error-report.h"
 #include "hw/block/block.h"
 #include "net/hub.h"
diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
index bbc6e8fa0b..3af9308789 100644
--- a/hw/s390x/s390-virtio-ccw.c
+++ b/hw/s390x/s390-virtio-ccw.c
@@ -23,6 +23,7 @@
 #include "hw/s390x/css.h"
 #include "virtio-ccw.h"
 #include "qemu/config-file.h"
+#include "qemu/ctype.h"
 #include "qemu/error-report.h"
 #include "qemu/option.h"
 #include "s390-pci-bus.h"
diff --git a/hw/scsi/scsi-generic.c b/hw/scsi/scsi-generic.c
index d82b462be4..e8a8706a4f 100644
--- a/hw/scsi/scsi-generic.c
+++ b/hw/scsi/scsi-generic.c
@@ -13,7 +13,7 @@
=20
 #include "qemu/osdep.h"
 #include "qapi/error.h"
-#include "qemu-common.h"
+#include "qemu/ctype.h"
 #include "qemu/error-report.h"
 #include "hw/scsi/scsi.h"
 #include "hw/scsi/emulation.h"
diff --git a/include/qemu-common.h b/include/qemu-common.h
index d7f4a4e7eb..9b01f6e7cb 100644
--- a/include/qemu-common.h
+++ b/include/qemu-common.h
@@ -31,22 +31,6 @@ int qemu_main(int argc, char **argv, char **envp);
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
diff --git a/include/qemu/ctype.h b/include/qemu/ctype.h
new file mode 100644
index 0000000000..3691f0984d
--- /dev/null
+++ b/include/qemu/ctype.h
@@ -0,0 +1,27 @@
+/*
+ * QEMU TCG support
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or la=
ter.
+ * See the COPYING file in the top-level directory.
+ */
+
+#ifndef QEMU_CTYPE_H
+#define QEMU_CTYPE_H
+
+#define qemu_isalnum(c)         isalnum((unsigned char)(c))
+#define qemu_isalpha(c)         isalpha((unsigned char)(c))
+#define qemu_iscntrl(c)         iscntrl((unsigned char)(c))
+#define qemu_isdigit(c)         isdigit((unsigned char)(c))
+#define qemu_isgraph(c)         isgraph((unsigned char)(c))
+#define qemu_islower(c)         islower((unsigned char)(c))
+#define qemu_isprint(c)         isprint((unsigned char)(c))
+#define qemu_ispunct(c)         ispunct((unsigned char)(c))
+#define qemu_isspace(c)         isspace((unsigned char)(c))
+#define qemu_isupper(c)         isupper((unsigned char)(c))
+#define qemu_isxdigit(c)        isxdigit((unsigned char)(c))
+#define qemu_tolower(c)         tolower((unsigned char)(c))
+#define qemu_toupper(c)         toupper((unsigned char)(c))
+#define qemu_isascii(c)         isascii((unsigned char)(c))
+#define qemu_toascii(c)         toascii((unsigned char)(c))
+
+#endif
diff --git a/monitor.c b/monitor.c
index 3650ceb574..5c5cbe254a 100644
--- a/monitor.c
+++ b/monitor.c
@@ -42,6 +42,7 @@
 #include "sysemu/numa.h"
 #include "monitor/monitor.h"
 #include "qemu/config-file.h"
+#include "qemu/ctype.h"
 #include "qemu/readline.h"
 #include "ui/console.h"
 #include "ui/input.h"
diff --git a/net/net.c b/net/net.c
index 2cf5e76469..3e65c93920 100644
--- a/net/net.c
+++ b/net/net.c
@@ -41,6 +41,7 @@
 #include "qemu/sockets.h"
 #include "qemu/cutils.h"
 #include "qemu/config-file.h"
+#include "qemu/ctype.h"
 #include "hw/qdev.h"
 #include "qemu/iov.h"
 #include "qemu/main-loop.h"
diff --git a/net/tap-solaris.c b/net/tap-solaris.c
index a2a92356c1..0e3f3e0a9b 100644
--- a/net/tap-solaris.c
+++ b/net/tap-solaris.c
@@ -26,6 +26,7 @@
 #include "qapi/error.h"
 #include "tap_int.h"
 #include "sysemu/sysemu.h"
+#include "qemu/ctype.h"
 #include "qemu/cutils.h"
=20
 #include <sys/ethernet.h>
diff --git a/qapi/qapi-util.c b/qapi/qapi-util.c
index e9b266bb70..29a6c98b53 100644
--- a/qapi/qapi-util.c
+++ b/qapi/qapi-util.c
@@ -12,7 +12,7 @@
=20
 #include "qemu/osdep.h"
 #include "qapi/error.h"
-#include "qemu-common.h"
+#include "qemu/ctype.h"
=20
 const char *qapi_enum_lookup(const QEnumLookup *lookup, int val)
 {
diff --git a/qobject/json-parser.c b/qobject/json-parser.c
index d8eb210c0c..7d23e12e33 100644
--- a/qobject/json-parser.c
+++ b/qobject/json-parser.c
@@ -12,10 +12,10 @@
  */
=20
 #include "qemu/osdep.h"
+#include "qemu/ctype.h"
 #include "qemu/cutils.h"
 #include "qemu/unicode.h"
 #include "qapi/error.h"
-#include "qemu-common.h"
 #include "qapi/qmp/qbool.h"
 #include "qapi/qmp/qdict.h"
 #include "qapi/qmp/qlist.h"
diff --git a/target/ppc/monitor.c b/target/ppc/monitor.c
index ee9d6e81d2..7f8360d903 100644
--- a/target/ppc/monitor.c
+++ b/target/ppc/monitor.c
@@ -21,9 +21,11 @@
  * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALING=
S IN
  * THE SOFTWARE.
  */
+
 #include "qemu/osdep.h"
 #include "cpu.h"
 #include "monitor/monitor.h"
+#include "qemu/ctype.h"
 #include "monitor/hmp-target.h"
 #include "hmp.h"
=20
diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index e29879915f..04edda727b 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -19,6 +19,7 @@
=20
 #include "qemu/osdep.h"
 #include "qemu/qemu-print.h"
+#include "qemu/ctype.h"
 #include "qemu/log.h"
 #include "cpu.h"
 #include "exec/exec-all.h"
diff --git a/tests/libqtest.c b/tests/libqtest.c
index 9b9b5f37fc..3c5c3f49d8 100644
--- a/tests/libqtest.c
+++ b/tests/libqtest.c
@@ -22,6 +22,7 @@
=20
 #include "libqtest.h"
 #include "qemu-common.h"
+#include "qemu/ctype.h"
 #include "qemu/cutils.h"
 #include "qapi/error.h"
 #include "qapi/qmp/json-parser.h"
diff --git a/tests/vhost-user-bridge.c b/tests/vhost-user-bridge.c
index 5b771de7a3..0bb03af0e5 100644
--- a/tests/vhost-user-bridge.c
+++ b/tests/vhost-user-bridge.c
@@ -30,8 +30,8 @@
 #define _FILE_OFFSET_BITS 64
=20
 #include "qemu/osdep.h"
-#include "qemu-common.h"
 #include "qemu/atomic.h"
+#include "qemu/ctype.h"
 #include "qemu/iov.h"
 #include "standard-headers/linux/virtio_net.h"
 #include "contrib/libvhost-user/libvhost-user.h"
diff --git a/ui/keymaps.c b/ui/keymaps.c
index 544b55c27b..38fd22ed2b 100644
--- a/ui/keymaps.c
+++ b/ui/keymaps.c
@@ -26,6 +26,7 @@
 #include "keymaps.h"
 #include "sysemu/sysemu.h"
 #include "trace.h"
+#include "qemu/ctype.h"
 #include "qemu/error-report.h"
 #include "qapi/error.h"
 #include "ui/input.h"
diff --git a/util/cutils.c b/util/cutils.c
index 9aacc422ca..53e4af59f8 100644
--- a/util/cutils.c
+++ b/util/cutils.c
@@ -21,14 +21,15 @@
  * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALING=
S IN
  * THE SOFTWARE.
  */
+
 #include "qemu/osdep.h"
-#include "qemu-common.h"
 #include "qemu/host-utils.h"
 #include <math.h>
=20
 #include "qemu/sockets.h"
 #include "qemu/iov.h"
 #include "net/net.h"
+#include "qemu/ctype.h"
 #include "qemu/cutils.h"
 #include "qemu/error-report.h"
=20
diff --git a/util/id.c b/util/id.c
index 6141352955..af1c5f1b81 100644
--- a/util/id.c
+++ b/util/id.c
@@ -11,7 +11,7 @@
  */
=20
 #include "qemu/osdep.h"
-#include "qemu-common.h"
+#include "qemu/ctype.h"
 #include "qemu/id.h"
=20
 bool id_wellformed(const char *id)
diff --git a/util/readline.c b/util/readline.c
index a7672b51c1..e534460da6 100644
--- a/util/readline.c
+++ b/util/readline.c
@@ -23,8 +23,8 @@
  */
=20
 #include "qemu/osdep.h"
-#include "qemu-common.h"
 #include "qemu/readline.h"
+#include "qemu/ctype.h"
 #include "qemu/cutils.h"
=20
 #define IS_NORM 0
--=20
2.21.0



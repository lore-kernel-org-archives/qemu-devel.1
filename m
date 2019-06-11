Return-Path: <SRS0=mXWu=UK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 104D5C4321A
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Jun 2019 15:43:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CA8ED2080A
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Jun 2019 15:43:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA8ED2080A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60408 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1haiw3-00005L-2z
	for qemu-devel@archiver.kernel.org; Tue, 11 Jun 2019 11:43:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57312)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <armbru@redhat.com>) id 1haidq-0004bg-Re
 for qemu-devel@nongnu.org; Tue, 11 Jun 2019 11:24:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1haido-0006KI-1l
 for qemu-devel@nongnu.org; Tue, 11 Jun 2019 11:24:54 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41400)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1haidn-0006If-PG
 for qemu-devel@nongnu.org; Tue, 11 Jun 2019 11:24:51 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id B1B6533025F;
 Tue, 11 Jun 2019 15:24:50 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-148.ams2.redhat.com
 [10.36.116.148])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 328765D705;
 Tue, 11 Jun 2019 15:24:50 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id B614C1138660; Tue, 11 Jun 2019 17:24:48 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Date: Tue, 11 Jun 2019 17:24:37 +0200
Message-Id: <20190611152448.29436-2-armbru@redhat.com>
In-Reply-To: <20190611152448.29436-1-armbru@redhat.com>
References: <20190611152448.29436-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.29]); Tue, 11 Jun 2019 15:24:50 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 01/12] qemu-common: Move tcg_enabled() etc. to
 sysemu/tcg.h
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Other accelerators have their own headers: sysemu/hax.h, sysemu/hvf.h,
sysemu/kvm.h, sysemu/whpx.h.  Only tcg_enabled() & friends sit in
qemu-common.h.  This necessitates inclusion of qemu-common.h into
headers, which is against the rules spelled out in qemu-common.h's
file comment.

Move tcg_enabled() & friends into their own header sysemu/tcg.h, and
adjust #include directives.

Cc: Richard Henderson <rth@twiddle.net>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
Message-Id: <20190523143508.25387-2-armbru@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
[Rebased with conflicts resolved automatically, except for
accel/tcg/tcg-all.c]
---
 MAINTAINERS                     |  1 +
 accel/tcg/cpu-exec-common.c     |  1 +
 accel/tcg/tcg-all.c             |  2 +-
 accel/tcg/translate-all.c       |  3 ++-
 bsd-user/main.c                 |  2 ++
 cpus.c                          |  1 +
 exec.c                          |  2 ++
 hw/i386/pc.c                    |  1 +
 hw/ppc/spapr_caps.c             |  2 ++
 hw/s390x/ipl.c                  |  1 +
 include/exec/ram_addr.h         |  1 +
 include/qemu-common.h           |  8 --------
 include/sysemu/tcg.h            | 19 +++++++++++++++++++
 linux-user/main.c               |  2 ++
 memory.c                        |  2 +-
 monitor.c                       |  1 +
 qemu-nbd.c                      |  1 +
 qom/cpu.c                       |  2 +-
 target/arm/cpu.c                |  2 +-
 target/i386/cpu.c               |  1 +
 target/i386/cpu.h               |  2 +-
 target/i386/helper.c            |  1 +
 target/i386/machine.c           |  2 +-
 target/ppc/translate_init.inc.c |  1 +
 target/s390x/cpu.c              |  2 +-
 target/s390x/cpu_models.c       |  1 +
 target/s390x/gdbstub.c          |  3 ++-
 target/s390x/helper.c           |  1 +
 target/s390x/interrupt.c        |  1 +
 target/s390x/machine.c          |  1 +
 target/s390x/mmu_helper.c       |  1 +
 target/s390x/sigp.c             |  2 +-
 vl.c                            |  1 +
 33 files changed, 56 insertions(+), 18 deletions(-)
 create mode 100644 include/sysemu/tcg.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 7be1225415..ef00e8a70d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -125,6 +125,7 @@ F: include/exec/exec-all.h
 F: include/exec/helper*.h
 F: include/exec/tb-hash.h
 F: include/sysemu/cpus.h
+F: include/sysemu/tcg.h
=20
 FPU emulation
 M: Aurelien Jarno <aurelien@aurel32.net>
diff --git a/accel/tcg/cpu-exec-common.c b/accel/tcg/cpu-exec-common.c
index 462a1f1865..12c1e3e974 100644
--- a/accel/tcg/cpu-exec-common.c
+++ b/accel/tcg/cpu-exec-common.c
@@ -20,6 +20,7 @@
 #include "qemu/osdep.h"
 #include "cpu.h"
 #include "sysemu/cpus.h"
+#include "sysemu/tcg.h"
 #include "exec/exec-all.h"
=20
 bool tcg_allowed;
diff --git a/accel/tcg/tcg-all.c b/accel/tcg/tcg-all.c
index 9b215dcc5a..c92d4c82ed 100644
--- a/accel/tcg/tcg-all.c
+++ b/accel/tcg/tcg-all.c
@@ -26,8 +26,8 @@
 #include "qemu/osdep.h"
 #include "sysemu/accel.h"
 #include "sysemu/sysemu.h"
+#include "sysemu/tcg.h"
 #include "qom/object.h"
-#include "qemu-common.h"
 #include "cpu.h"
 #include "sysemu/cpus.h"
 #include "qemu/main-loop.h"
diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
index e24ee3a172..5d97a2a651 100644
--- a/accel/tcg/translate-all.c
+++ b/accel/tcg/translate-all.c
@@ -16,9 +16,9 @@
  * You should have received a copy of the GNU Lesser General Public
  * License along with this library; if not, see <http://www.gnu.org/lice=
nses/>.
  */
+
 #include "qemu/osdep.h"
=20
-#include "qemu-common.h"
 #define NO_CPU_IO_DEFS
 #include "cpu.h"
 #include "trace.h"
@@ -55,6 +55,7 @@
 #include "qemu/main-loop.h"
 #include "exec/log.h"
 #include "sysemu/cpus.h"
+#include "sysemu/tcg.h"
=20
 /* #define DEBUG_TB_INVALIDATE */
 /* #define DEBUG_TB_FLUSH */
diff --git a/bsd-user/main.c b/bsd-user/main.c
index c473a99153..7d4abd20ed 100644
--- a/bsd-user/main.c
+++ b/bsd-user/main.c
@@ -16,8 +16,10 @@
  *  You should have received a copy of the GNU General Public License
  *  along with this program; if not, see <http://www.gnu.org/licenses/>.
  */
+
 #include "qemu/osdep.h"
 #include "qemu/units.h"
+#include "sysemu/tcg.h"
 #include "qemu-version.h"
 #include <machine/trap.h>
=20
diff --git a/cpus.c b/cpus.c
index 111ca4ed1c..5d7be0c5a2 100644
--- a/cpus.c
+++ b/cpus.c
@@ -33,6 +33,7 @@
 #include "qemu/error-report.h"
 #include "qemu/qemu-print.h"
 #include "sysemu/sysemu.h"
+#include "sysemu/tcg.h"
 #include "sysemu/block-backend.h"
 #include "exec/gdbstub.h"
 #include "sysemu/dma.h"
diff --git a/exec.c b/exec.c
index 4e734770c2..0bc59e9a30 100644
--- a/exec.c
+++ b/exec.c
@@ -16,6 +16,7 @@
  * You should have received a copy of the GNU Lesser General Public
  * License along with this library; if not, see <http://www.gnu.org/lice=
nses/>.
  */
+
 #include "qemu/osdep.h"
 #include "qapi/error.h"
=20
@@ -32,6 +33,7 @@
 #endif
 #include "sysemu/kvm.h"
 #include "sysemu/sysemu.h"
+#include "sysemu/tcg.h"
 #include "qemu/timer.h"
 #include "qemu/config-file.h"
 #include "qemu/error-report.h"
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 1b08b56362..2c5446b095 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -50,6 +50,7 @@
 #include "hw/pci/msi.h"
 #include "hw/sysbus.h"
 #include "sysemu/sysemu.h"
+#include "sysemu/tcg.h"
 #include "sysemu/numa.h"
 #include "sysemu/kvm.h"
 #include "sysemu/qtest.h"
diff --git a/hw/ppc/spapr_caps.c b/hw/ppc/spapr_caps.c
index 31b4661399..bbb001f84a 100644
--- a/hw/ppc/spapr_caps.c
+++ b/hw/ppc/spapr_caps.c
@@ -21,6 +21,7 @@
  * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALING=
S IN
  * THE SOFTWARE.
  */
+
 #include "qemu/osdep.h"
 #include "qemu/error-report.h"
 #include "qapi/error.h"
@@ -32,6 +33,7 @@
 #include "cpu-models.h"
 #include "kvm_ppc.h"
 #include "sysemu/qtest.h"
+#include "sysemu/tcg.h"
=20
 #include "hw/ppc/spapr.h"
=20
diff --git a/hw/s390x/ipl.c b/hw/s390x/ipl.c
index b93750c14e..1f3aef051b 100644
--- a/hw/s390x/ipl.c
+++ b/hw/s390x/ipl.c
@@ -14,6 +14,7 @@
 #include "qemu/osdep.h"
 #include "qapi/error.h"
 #include "sysemu/sysemu.h"
+#include "sysemu/tcg.h"
 #include "cpu.h"
 #include "elf.h"
 #include "hw/loader.h"
diff --git a/include/exec/ram_addr.h b/include/exec/ram_addr.h
index 139ad79390..f96777bb99 100644
--- a/include/exec/ram_addr.h
+++ b/include/exec/ram_addr.h
@@ -21,6 +21,7 @@
=20
 #ifndef CONFIG_USER_ONLY
 #include "hw/xen/xen.h"
+#include "sysemu/tcg.h"
 #include "exec/ramlist.h"
=20
 struct RAMBlock {
diff --git a/include/qemu-common.h b/include/qemu-common.h
index f891e05e7e..d7f4a4e7eb 100644
--- a/include/qemu-common.h
+++ b/include/qemu-common.h
@@ -77,14 +77,6 @@ int qemu_openpty_raw(int *aslave, char *pty_name);
     sendto(sockfd, buf, len, flags, destaddr, addrlen)
 #endif
=20
-extern bool tcg_allowed;
-void tcg_exec_init(unsigned long tb_size);
-#ifdef CONFIG_TCG
-#define tcg_enabled() (tcg_allowed)
-#else
-#define tcg_enabled() 0
-#endif
-
 void cpu_exec_init_all(void);
 void cpu_exec_step_atomic(CPUState *cpu);
=20
diff --git a/include/sysemu/tcg.h b/include/sysemu/tcg.h
new file mode 100644
index 0000000000..7d116d2e80
--- /dev/null
+++ b/include/sysemu/tcg.h
@@ -0,0 +1,19 @@
+/*
+ * QEMU TCG support
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or la=
ter.
+ * See the COPYING file in the top-level directory.
+ */
+
+#ifndef SYSEMU_TCG_H
+#define SYSEMU_TCG_H
+
+extern bool tcg_allowed;
+void tcg_exec_init(unsigned long tb_size);
+#ifdef CONFIG_TCG
+#define tcg_enabled() (tcg_allowed)
+#else
+#define tcg_enabled() 0
+#endif
+
+#endif
diff --git a/linux-user/main.c b/linux-user/main.c
index 97ca22bb04..a2b4a9f3e2 100644
--- a/linux-user/main.c
+++ b/linux-user/main.c
@@ -16,8 +16,10 @@
  *  You should have received a copy of the GNU General Public License
  *  along with this program; if not, see <http://www.gnu.org/licenses/>.
  */
+
 #include "qemu/osdep.h"
 #include "qemu/units.h"
+#include "sysemu/tcg.h"
 #include "qemu-version.h"
 #include <sys/syscall.h>
 #include <sys/resource.h>
diff --git a/memory.c b/memory.c
index 0920c105aa..0a089a73ae 100644
--- a/memory.c
+++ b/memory.c
@@ -15,7 +15,6 @@
=20
 #include "qemu/osdep.h"
 #include "qapi/error.h"
-#include "qemu-common.h"
 #include "cpu.h"
 #include "exec/memory.h"
 #include "exec/address-spaces.h"
@@ -30,6 +29,7 @@
 #include "exec/ram_addr.h"
 #include "sysemu/kvm.h"
 #include "sysemu/sysemu.h"
+#include "sysemu/tcg.h"
 #include "hw/qdev-properties.h"
 #include "migration/vmstate.h"
=20
diff --git a/monitor.c b/monitor.c
index 6428eb3b7e..3650ceb574 100644
--- a/monitor.c
+++ b/monitor.c
@@ -53,6 +53,7 @@
 #include "sysemu/hw_accel.h"
 #include "authz/list.h"
 #include "qapi/util.h"
+#include "sysemu/tcg.h"
 #include "sysemu/tpm.h"
 #include "qapi/qmp/qdict.h"
 #include "qapi/qmp/qerror.h"
diff --git a/qemu-nbd.c b/qemu-nbd.c
index 081fcf74d5..25ce71e160 100644
--- a/qemu-nbd.c
+++ b/qemu-nbd.c
@@ -21,6 +21,7 @@
 #include <libgen.h>
 #include <pthread.h>
=20
+#include "qemu-common.h"
 #include "qapi/error.h"
 #include "qemu/cutils.h"
 #include "sysemu/block-backend.h"
diff --git a/qom/cpu.c b/qom/cpu.c
index 6b4632abda..f376f782d8 100644
--- a/qom/cpu.c
+++ b/qom/cpu.c
@@ -20,7 +20,6 @@
=20
 #include "qemu/osdep.h"
 #include "qapi/error.h"
-#include "qemu-common.h"
 #include "qom/cpu.h"
 #include "sysemu/hw_accel.h"
 #include "qemu/notify.h"
@@ -30,6 +29,7 @@
 #include "qemu/error-report.h"
 #include "qemu/qemu-print.h"
 #include "sysemu/sysemu.h"
+#include "sysemu/tcg.h"
 #include "hw/boards.h"
 #include "hw/qdev-properties.h"
 #include "trace-root.h"
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index f70e07fd11..c2dff10f82 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -24,13 +24,13 @@
 #include "qapi/visitor.h"
 #include "cpu.h"
 #include "internals.h"
-#include "qemu-common.h"
 #include "exec/exec-all.h"
 #include "hw/qdev-properties.h"
 #if !defined(CONFIG_USER_ONLY)
 #include "hw/loader.h"
 #endif
 #include "sysemu/sysemu.h"
+#include "sysemu/tcg.h"
 #include "sysemu/hw_accel.h"
 #include "kvm_arm.h"
 #include "disas/capstone.h"
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index b21ecaac17..a4bc04ed1d 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -47,6 +47,7 @@
 #include "standard-headers/asm-x86/kvm_para.h"
=20
 #include "sysemu/sysemu.h"
+#include "sysemu/tcg.h"
 #include "hw/qdev-properties.h"
 #include "hw/i386/topology.h"
 #ifndef CONFIG_USER_ONLY
diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index edad6e1efb..0732e059ec 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -20,7 +20,7 @@
 #ifndef I386_CPU_H
 #define I386_CPU_H
=20
-#include "qemu-common.h"
+#include "sysemu/tcg.h"
 #include "cpu-qom.h"
 #include "hyperv-proto.h"
 #include "exec/cpu-defs.h"
diff --git a/target/i386/helper.c b/target/i386/helper.c
index ff3a60c7cf..23024926ac 100644
--- a/target/i386/helper.c
+++ b/target/i386/helper.c
@@ -25,6 +25,7 @@
 #include "kvm_i386.h"
 #ifndef CONFIG_USER_ONLY
 #include "sysemu/sysemu.h"
+#include "sysemu/tcg.h"
 #include "sysemu/hw_accel.h"
 #include "monitor/monitor.h"
 #include "hw/i386/apic_internal.h"
diff --git a/target/i386/machine.c b/target/i386/machine.c
index 225b5d433b..1150967b97 100644
--- a/target/i386/machine.c
+++ b/target/i386/machine.c
@@ -1,5 +1,4 @@
 #include "qemu/osdep.h"
-#include "qemu-common.h"
 #include "cpu.h"
 #include "exec/exec-all.h"
 #include "hw/hw.h"
@@ -10,6 +9,7 @@
 #include "hyperv.h"
=20
 #include "sysemu/kvm.h"
+#include "sysemu/tcg.h"
=20
 #include "qemu/error-report.h"
=20
diff --git a/target/ppc/translate_init.inc.c b/target/ppc/translate_init.=
inc.c
index b71b7bac20..970171b116 100644
--- a/target/ppc/translate_init.inc.c
+++ b/target/ppc/translate_init.inc.c
@@ -24,6 +24,7 @@
 #include "sysemu/arch_init.h"
 #include "sysemu/cpus.h"
 #include "sysemu/hw_accel.h"
+#include "sysemu/tcg.h"
 #include "cpu-models.h"
 #include "mmu-hash32.h"
 #include "mmu-hash64.h"
diff --git a/target/s390x/cpu.c b/target/s390x/cpu.c
index 4ca66fed1a..c80743a923 100644
--- a/target/s390x/cpu.c
+++ b/target/s390x/cpu.c
@@ -26,7 +26,6 @@
 #include "internal.h"
 #include "kvm_s390x.h"
 #include "sysemu/kvm.h"
-#include "qemu-common.h"
 #include "qemu/timer.h"
 #include "qemu/error-report.h"
 #include "trace.h"
@@ -39,6 +38,7 @@
 #include "hw/hw.h"
 #include "sysemu/arch_init.h"
 #include "sysemu/sysemu.h"
+#include "sysemu/tcg.h"
 #endif
 #include "fpu/softfloat.h"
=20
diff --git a/target/s390x/cpu_models.c b/target/s390x/cpu_models.c
index b5d16e4c89..3fce8114de 100644
--- a/target/s390x/cpu_models.c
+++ b/target/s390x/cpu_models.c
@@ -15,6 +15,7 @@
 #include "internal.h"
 #include "kvm_s390x.h"
 #include "sysemu/kvm.h"
+#include "sysemu/tcg.h"
 #include "qapi/error.h"
 #include "qapi/visitor.h"
 #include "qemu/error-report.h"
diff --git a/target/s390x/gdbstub.c b/target/s390x/gdbstub.c
index a45d805a21..e24a49f4a9 100644
--- a/target/s390x/gdbstub.c
+++ b/target/s390x/gdbstub.c
@@ -17,14 +17,15 @@
  * You should have received a copy of the GNU Lesser General Public
  * License along with this library; if not, see <http://www.gnu.org/lice=
nses/>.
  */
+
 #include "qemu/osdep.h"
-#include "qemu-common.h"
 #include "cpu.h"
 #include "internal.h"
 #include "exec/exec-all.h"
 #include "exec/gdbstub.h"
 #include "qemu/bitops.h"
 #include "sysemu/hw_accel.h"
+#include "sysemu/tcg.h"
=20
 int s390_cpu_gdb_read_register(CPUState *cs, uint8_t *mem_buf, int n)
 {
diff --git a/target/s390x/helper.c b/target/s390x/helper.c
index 52a11daeae..13ae9909ad 100644
--- a/target/s390x/helper.c
+++ b/target/s390x/helper.c
@@ -28,6 +28,7 @@
 #include "sysemu/hw_accel.h"
 #ifndef CONFIG_USER_ONLY
 #include "sysemu/sysemu.h"
+#include "sysemu/tcg.h"
 #endif
=20
 #ifndef CONFIG_USER_ONLY
diff --git a/target/s390x/interrupt.c b/target/s390x/interrupt.c
index a8f9b38795..a841f7187d 100644
--- a/target/s390x/interrupt.c
+++ b/target/s390x/interrupt.c
@@ -14,6 +14,7 @@
 #include "internal.h"
 #include "exec/exec-all.h"
 #include "sysemu/kvm.h"
+#include "sysemu/tcg.h"
 #include "hw/s390x/ioinst.h"
 #include "tcg_s390x.h"
 #if !defined(CONFIG_USER_ONLY)
diff --git a/target/s390x/machine.c b/target/s390x/machine.c
index e6851a57bc..1e9526e937 100644
--- a/target/s390x/machine.c
+++ b/target/s390x/machine.c
@@ -21,6 +21,7 @@
 #include "kvm_s390x.h"
 #include "tcg_s390x.h"
 #include "sysemu/kvm.h"
+#include "sysemu/tcg.h"
=20
 static int cpu_post_load(void *opaque, int version_id)
 {
diff --git a/target/s390x/mmu_helper.c b/target/s390x/mmu_helper.c
index 9669bae393..6e9c4d6151 100644
--- a/target/s390x/mmu_helper.c
+++ b/target/s390x/mmu_helper.c
@@ -22,6 +22,7 @@
 #include "internal.h"
 #include "kvm_s390x.h"
 #include "sysemu/kvm.h"
+#include "sysemu/tcg.h"
 #include "exec/exec-all.h"
 #include "trace.h"
 #include "hw/s390x/storage-keys.h"
diff --git a/target/s390x/sigp.c b/target/s390x/sigp.c
index ea5f69d5d8..ce49a792fc 100644
--- a/target/s390x/sigp.c
+++ b/target/s390x/sigp.c
@@ -9,13 +9,13 @@
  */
=20
 #include "qemu/osdep.h"
-#include "qemu-common.h"
 #include "cpu.h"
 #include "internal.h"
 #include "sysemu/hw_accel.h"
 #include "exec/address-spaces.h"
 #include "exec/exec-all.h"
 #include "sysemu/sysemu.h"
+#include "sysemu/tcg.h"
 #include "trace.h"
 #include "qapi/qapi-types-misc.h"
=20
diff --git a/vl.c b/vl.c
index cd1fbc4cdc..efdfea26ee 100644
--- a/vl.c
+++ b/vl.c
@@ -30,6 +30,7 @@
 #include "qemu/help_option.h"
 #include "qemu/uuid.h"
 #include "sysemu/seccomp.h"
+#include "sysemu/tcg.h"
=20
 #ifdef CONFIG_SDL
 #if defined(__APPLE__) || defined(main)
--=20
2.21.0



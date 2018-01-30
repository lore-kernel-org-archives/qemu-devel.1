Received: from eggs.gnu.org ([2001:4830:134:3::10]:59520)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1egT3R-00049q-MT
	for qemu-devel@nongnu.org; Tue, 30 Jan 2018 05:22:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1egT3L-0000c1-7q
	for qemu-devel@nongnu.org; Tue, 30 Jan 2018 05:22:17 -0500
Received: from mx1.redhat.com ([209.132.183.28]:50736)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1egT3K-0000YQ-Uw
	for qemu-devel@nongnu.org; Tue, 30 Jan 2018 05:22:11 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id BDF6D3AD83
	for <qemu-devel@nongnu.org>; Tue, 30 Jan 2018 10:22:04 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-148.ams2.redhat.com
	[10.36.116.148])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 2E1527D533
	for <qemu-devel@nongnu.org>; Tue, 30 Jan 2018 10:22:04 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Tue, 30 Jan 2018 11:21:45 +0100
Message-Id: <20180130102202.28519-2-armbru@redhat.com>
In-Reply-To: <20180130102202.28519-1-armbru@redhat.com>
References: <20180130102202.28519-1-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH 01/18] Clean up includes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Clean up includes so that osdep.h is included first and headers
which it implies are not included manually.

This commit was created with scripts/clean-includes, with the change
to target/s390x/gen-features.c manually reverted, and blank lines
around deletions collapsed.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 block/parallels.h                                     |  1 -
 hw/block/vhost-user-blk.c                             |  1 -
 hw/ide/sii3112.c                                      |  1 +
 hw/nvram/eeprom_at24c.c                               |  3 +--
 hw/tpm/tpm_emulator.c                                 |  4 ----
 hw/tpm/tpm_int.h                                      |  2 --
 hw/tpm/tpm_ioctl.h                                    |  2 --
 hw/xtensa/xtensa_memory.h                             |  1 -
 include/exec/tb-lookup.h                              |  2 --
 include/hw/intc/xlnx-pmu-iomod-intc.h                 |  1 -
 include/hw/intc/xlnx-zynqmp-ipi.h                     |  1 -
 include/hw/nvram/fw_cfg.h                             |  1 -
 include/hw/pci-bridge/simba.h                         |  1 -
 include/hw/xtensa/xtensa-isa.h                        |  2 --
 include/qapi/clone-visitor.h                          |  1 -
 include/sysemu/hvf.h                                  |  2 --
 include/ui/console.h                                  |  1 -
 io/channel-websock.c                                  |  3 ---
 linux-user/syscall.c                                  |  1 -
 scsi/pr-helper.h                                      |  2 --
 target/i386/hvf/vmx.h                                 |  1 -
 target/i386/hvf/x86hvf.c                              |  3 ---
 target/xtensa/core-dc232b/xtensa-modules.c            |  1 +
 target/xtensa/core-dc233c/xtensa-modules.c            |  1 +
 target/xtensa/core-de212/xtensa-modules.c             |  1 +
 target/xtensa/core-fsf/xtensa-modules.c               |  1 +
 target/xtensa/core-sample_controller/xtensa-modules.c |  1 +
 target/xtensa/xtensa-isa.c                            |  4 +---
 tests/migration/stress.c                              | 10 +---------
 tests/ptimer-test.c                                   |  4 ++--
 trace/control-internal.h                              |  2 --
 31 files changed, 11 insertions(+), 51 deletions(-)

diff --git a/block/parallels.h b/block/parallels.h
index 4b044079ef..5aa101cfc8 100644
--- a/block/parallels.h
+++ b/block/parallels.h
@@ -32,7 +32,6 @@
 #ifndef BLOCK_PARALLELS_H
 #define BLOCK_PARALLELS_H
 #include "qemu/coroutine.h"
-#include "qemu/typedefs.h"
 
 #define HEADS_NUMBER 16
 #define SEC_IN_CYL 32
diff --git a/hw/block/vhost-user-blk.c b/hw/block/vhost-user-blk.c
index b53b4c9c57..f840f07dfe 100644
--- a/hw/block/vhost-user-blk.c
+++ b/hw/block/vhost-user-blk.c
@@ -19,7 +19,6 @@
 #include "qemu/osdep.h"
 #include "qapi/error.h"
 #include "qemu/error-report.h"
-#include "qemu/typedefs.h"
 #include "qemu/cutils.h"
 #include "qom/object.h"
 #include "hw/qdev-core.h"
diff --git a/hw/ide/sii3112.c b/hw/ide/sii3112.c
index 17aa930e39..a5d1776756 100644
--- a/hw/ide/sii3112.c
+++ b/hw/ide/sii3112.c
@@ -12,6 +12,7 @@
  * http://wiki.osdev.org/User:Quok/Silicon_Image_Datasheets
  */
 
+#include "qemu/osdep.h"
 #include <qemu/osdep.h>
 #include <hw/ide/pci.h>
 #include "trace.h"
diff --git a/hw/nvram/eeprom_at24c.c b/hw/nvram/eeprom_at24c.c
index efa3621ac6..22183f5360 100644
--- a/hw/nvram/eeprom_at24c.c
+++ b/hw/nvram/eeprom_at24c.c
@@ -7,9 +7,8 @@
  * the LICENSE file in the top-level directory.
  */
 
-#include <string.h>
-
 #include "qemu/osdep.h"
+
 #include "qapi/error.h"
 #include "hw/hw.h"
 #include "hw/i2c/i2c.h"
diff --git a/hw/tpm/tpm_emulator.c b/hw/tpm/tpm_emulator.c
index 35c78de5a9..7be79e7296 100644
--- a/hw/tpm/tpm_emulator.c
+++ b/hw/tpm/tpm_emulator.c
@@ -40,10 +40,6 @@
 #include "qapi/clone-visitor.h"
 #include "chardev/char-fe.h"
 
-#include <fcntl.h>
-#include <sys/types.h>
-#include <sys/stat.h>
-#include <stdio.h>
 
 #define DEBUG_TPM 0
 
diff --git a/hw/tpm/tpm_int.h b/hw/tpm/tpm_int.h
index abbca5191a..a4c77fbd7e 100644
--- a/hw/tpm/tpm_int.h
+++ b/hw/tpm/tpm_int.h
@@ -12,8 +12,6 @@
 #ifndef TPM_TPM_INT_H
 #define TPM_TPM_INT_H
 
-#include "qemu/osdep.h"
-
 #define TPM_STANDARD_CMDLINE_OPTS \
     { \
         .name = "type", \
diff --git a/hw/tpm/tpm_ioctl.h b/hw/tpm/tpm_ioctl.h
index 54c8d345ad..59a0b0595d 100644
--- a/hw/tpm/tpm_ioctl.h
+++ b/hw/tpm/tpm_ioctl.h
@@ -8,9 +8,7 @@
 #ifndef _TPM_IOCTL_H_
 #define _TPM_IOCTL_H_
 
-#include <stdint.h>
 #include <sys/uio.h>
-#include <sys/types.h>
 #include <sys/ioctl.h>
 
 /*
diff --git a/hw/xtensa/xtensa_memory.h b/hw/xtensa/xtensa_memory.h
index cab4d172d4..e9aa08749d 100644
--- a/hw/xtensa/xtensa_memory.h
+++ b/hw/xtensa/xtensa_memory.h
@@ -28,7 +28,6 @@
 #ifndef _XTENSA_MEMORY_H
 #define _XTENSA_MEMORY_H
 
-#include "qemu/osdep.h"
 #include "qemu-common.h"
 #include "cpu.h"
 #include "exec/memory.h"
diff --git a/include/exec/tb-lookup.h b/include/exec/tb-lookup.h
index 296138591a..492cb68289 100644
--- a/include/exec/tb-lookup.h
+++ b/include/exec/tb-lookup.h
@@ -7,8 +7,6 @@
 #ifndef EXEC_TB_LOOKUP_H
 #define EXEC_TB_LOOKUP_H
 
-#include "qemu/osdep.h"
-
 #ifdef NEED_CPU_H
 #include "cpu.h"
 #else
diff --git a/include/hw/intc/xlnx-pmu-iomod-intc.h b/include/hw/intc/xlnx-pmu-iomod-intc.h
index 1fdba73b9f..01c9d040b8 100644
--- a/include/hw/intc/xlnx-pmu-iomod-intc.h
+++ b/include/hw/intc/xlnx-pmu-iomod-intc.h
@@ -25,7 +25,6 @@
 #ifndef XLNX_PMU_IO_INTC_H
 #define XLNX_PMU_IO_INTC_H
 
-#include "qemu/osdep.h"
 #include "hw/sysbus.h"
 #include "hw/register.h"
 
diff --git a/include/hw/intc/xlnx-zynqmp-ipi.h b/include/hw/intc/xlnx-zynqmp-ipi.h
index 4afa4ff313..866c719c6f 100644
--- a/include/hw/intc/xlnx-zynqmp-ipi.h
+++ b/include/hw/intc/xlnx-zynqmp-ipi.h
@@ -25,7 +25,6 @@
 #ifndef XLNX_ZYNQMP_IPI_H
 #define XLNX_ZYNQMP_IPI_H
 
-#include "qemu/osdep.h"
 #include "hw/sysbus.h"
 #include "hw/register.h"
 
diff --git a/include/hw/nvram/fw_cfg.h b/include/hw/nvram/fw_cfg.h
index 7ccbae5fba..b2259cc4a3 100644
--- a/include/hw/nvram/fw_cfg.h
+++ b/include/hw/nvram/fw_cfg.h
@@ -1,7 +1,6 @@
 #ifndef FW_CFG_H
 #define FW_CFG_H
 
-#include "qemu/typedefs.h"
 #include "exec/hwaddr.h"
 #include "hw/nvram/fw_cfg_keys.h"
 #include "hw/sysbus.h"
diff --git a/include/hw/pci-bridge/simba.h b/include/hw/pci-bridge/simba.h
index fac56ab1cf..e13ba27d0b 100644
--- a/include/hw/pci-bridge/simba.h
+++ b/include/hw/pci-bridge/simba.h
@@ -24,7 +24,6 @@
  * THE SOFTWARE.
  */
 
-#include "qemu/osdep.h"
 #include "hw/pci/pci_bridge.h"
 
 
diff --git a/include/hw/xtensa/xtensa-isa.h b/include/hw/xtensa/xtensa-isa.h
index 353f82ba25..bd68ada640 100644
--- a/include/hw/xtensa/xtensa-isa.h
+++ b/include/hw/xtensa/xtensa-isa.h
@@ -25,8 +25,6 @@
 #ifndef XTENSA_LIBISA_H
 #define XTENSA_LIBISA_H
 
-#include <stdint.h>
-
 #ifdef __cplusplus
 extern "C" {
 #endif
diff --git a/include/qapi/clone-visitor.h b/include/qapi/clone-visitor.h
index a4915c7d57..b119d3daa9 100644
--- a/include/qapi/clone-visitor.h
+++ b/include/qapi/clone-visitor.h
@@ -11,7 +11,6 @@
 #ifndef QAPI_CLONE_VISITOR_H
 #define QAPI_CLONE_VISITOR_H
 
-#include "qemu/typedefs.h"
 #include "qapi/visitor.h"
 #include "qapi-visit.h"
 
diff --git a/include/sysemu/hvf.h b/include/sysemu/hvf.h
index e4e43f6468..241118845c 100644
--- a/include/sysemu/hvf.h
+++ b/include/sysemu/hvf.h
@@ -12,8 +12,6 @@
 #ifndef _HVF_H
 #define _HVF_H
 
-#include "config-host.h"
-#include "qemu/osdep.h"
 #include "qemu-common.h"
 #include "qemu/bitops.h"
 #include "exec/memory.h"
diff --git a/include/ui/console.h b/include/ui/console.h
index 7b35778444..b153a584da 100644
--- a/include/ui/console.h
+++ b/include/ui/console.h
@@ -5,7 +5,6 @@
 #include "qom/object.h"
 #include "qapi/qmp/qdict.h"
 #include "qemu/notify.h"
-#include "qemu/typedefs.h"
 #include "qapi-types.h"
 #include "qemu/error-report.h"
 #include "qapi/error.h"
diff --git a/io/channel-websock.c b/io/channel-websock.c
index 87ebdebfc0..7fd6bb68ba 100644
--- a/io/channel-websock.c
+++ b/io/channel-websock.c
@@ -26,9 +26,6 @@
 #include "trace.h"
 #include "qemu/iov.h"
 
-#include <time.h>
-
-
 /* Max amount to allow in rawinput/encoutput buffers */
 #define QIO_CHANNEL_WEBSOCK_MAX_BUFFER 8192
 
diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 74378947f0..779e590726 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -48,7 +48,6 @@ int __clone2(int (*fn)(void *), void *child_stack_base,
 #include <sys/shm.h>
 #include <sys/sem.h>
 #include <sys/statfs.h>
-#include <time.h>
 #include <utime.h>
 #include <sys/sysinfo.h>
 #include <sys/signalfd.h>
diff --git a/scsi/pr-helper.h b/scsi/pr-helper.h
index 96c50a9e5f..096d1f1df6 100644
--- a/scsi/pr-helper.h
+++ b/scsi/pr-helper.h
@@ -26,8 +26,6 @@
 #ifndef QEMU_PR_HELPER_H
 #define QEMU_PR_HELPER_H 1
 
-#include <stdint.h>
-
 #define PR_HELPER_CDB_SIZE     16
 #define PR_HELPER_SENSE_SIZE   96
 #define PR_HELPER_DATA_SIZE    8192
diff --git a/target/i386/hvf/vmx.h b/target/i386/hvf/vmx.h
index 9dfcd2f2eb..f3e6e86999 100644
--- a/target/i386/hvf/vmx.h
+++ b/target/i386/hvf/vmx.h
@@ -22,7 +22,6 @@
 #ifndef VMX_H
 #define VMX_H
 
-#include <stdint.h>
 #include <Hypervisor/hv.h>
 #include <Hypervisor/hv_vmx.h>
 #include "vmcs.h"
diff --git a/target/i386/hvf/x86hvf.c b/target/i386/hvf/x86hvf.c
index 7803e09a28..6c88939b96 100644
--- a/target/i386/hvf/x86hvf.c
+++ b/target/i386/hvf/x86hvf.c
@@ -29,11 +29,8 @@
 
 #include "hw/i386/apic_internal.h"
 
-#include <stdio.h>
-#include <stdlib.h>
 #include <Hypervisor/hv.h>
 #include <Hypervisor/hv_vmx.h>
-#include <stdint.h>
 
 void hvf_set_segment(struct CPUState *cpu, struct vmx_segment *vmx_seg,
                      SegmentCache *qseg, bool is_tr)
diff --git a/target/xtensa/core-dc232b/xtensa-modules.c b/target/xtensa/core-dc232b/xtensa-modules.c
index 2e103cd2f5..f6f4afb535 100644
--- a/target/xtensa/core-dc232b/xtensa-modules.c
+++ b/target/xtensa/core-dc232b/xtensa-modules.c
@@ -18,6 +18,7 @@
    Foundation, Inc., 51 Franklin Street - Fifth Floor, Boston, MA
    02110-1301, USA.  */
 
+#include "qemu/osdep.h"
 #include <xtensa-isa.h>
 #include "xtensa-isa-internal.h"
 
diff --git a/target/xtensa/core-dc233c/xtensa-modules.c b/target/xtensa/core-dc233c/xtensa-modules.c
index 2728311c9a..5e1f124f9c 100644
--- a/target/xtensa/core-dc233c/xtensa-modules.c
+++ b/target/xtensa/core-dc233c/xtensa-modules.c
@@ -21,6 +21,7 @@
    TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
    SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.  */
 
+#include "qemu/osdep.h"
 #include <xtensa-isa.h>
 #include "xtensa-isa-internal.h"
 
diff --git a/target/xtensa/core-de212/xtensa-modules.c b/target/xtensa/core-de212/xtensa-modules.c
index 4a8735889e..4493b9ff1e 100644
--- a/target/xtensa/core-de212/xtensa-modules.c
+++ b/target/xtensa/core-de212/xtensa-modules.c
@@ -21,6 +21,7 @@
    TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
    SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.  */
 
+#include "qemu/osdep.h"
 #include <xtensa-isa.h>
 #include "xtensa-isa-internal.h"
 
diff --git a/target/xtensa/core-fsf/xtensa-modules.c b/target/xtensa/core-fsf/xtensa-modules.c
index 238800d823..ee6dfe2ef3 100644
--- a/target/xtensa/core-fsf/xtensa-modules.c
+++ b/target/xtensa/core-fsf/xtensa-modules.c
@@ -18,6 +18,7 @@
    Foundation, Inc., 51 Franklin Street - Fifth Floor, Boston, MA
    02110-1301, USA.  */
 
+#include "qemu/osdep.h"
 #include <xtensa-isa.h>
 #include "xtensa-isa-internal.h"
 
diff --git a/target/xtensa/core-sample_controller/xtensa-modules.c b/target/xtensa/core-sample_controller/xtensa-modules.c
index 2f000199b8..d3377118b2 100644
--- a/target/xtensa/core-sample_controller/xtensa-modules.c
+++ b/target/xtensa/core-sample_controller/xtensa-modules.c
@@ -21,6 +21,7 @@
    TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
    SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.  */
 
+#include "qemu/osdep.h"
 #include <xtensa-isa.h>
 #include "xtensa-isa-internal.h"
 
diff --git a/target/xtensa/xtensa-isa.c b/target/xtensa/xtensa-isa.c
index e0076a694f..630b4f9da1 100644
--- a/target/xtensa/xtensa-isa.c
+++ b/target/xtensa/xtensa-isa.c
@@ -22,9 +22,7 @@
  * SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
  */
 
-#include <stdio.h>
-#include <stdlib.h>
-#include <string.h>
+#include "qemu/osdep.h"
 #include "xtensa-isa.h"
 #include "xtensa-isa-internal.h"
 
diff --git a/tests/migration/stress.c b/tests/migration/stress.c
index cf8ce8b16d..49a03aab7b 100644
--- a/tests/migration/stress.c
+++ b/tests/migration/stress.c
@@ -17,21 +17,13 @@
  * License along with this library; if not, see <http://www.gnu.org/licenses/>.
  */
 
-#include <stdio.h>
+#include "qemu/osdep.h"
 #include <getopt.h>
-#include <string.h>
-#include <stdlib.h>
-#include <errno.h>
-#include <unistd.h>
 #include <sys/reboot.h>
 #include <sys/syscall.h>
 #include <linux/random.h>
-#include <sys/time.h>
 #include <pthread.h>
-#include <fcntl.h>
 #include <sys/mount.h>
-#include <sys/stat.h>
-#include <sys/mman.h>
 
 const char *argv0;
 
diff --git a/tests/ptimer-test.c b/tests/ptimer-test.c
index 5d1a2a8188..41488896f7 100644
--- a/tests/ptimer-test.c
+++ b/tests/ptimer-test.c
@@ -8,9 +8,9 @@
  *
  */
 
-#include <glib/gprintf.h>
-
 #include "qemu/osdep.h"
+#include <glib/gprintf.h>
+
 #include "qemu/main-loop.h"
 #include "hw/ptimer.h"
 
diff --git a/trace/control-internal.h b/trace/control-internal.h
index a9d395a587..c7fbe2d3bf 100644
--- a/trace/control-internal.h
+++ b/trace/control-internal.h
@@ -10,8 +10,6 @@
 #ifndef TRACE__CONTROL_INTERNAL_H
 #define TRACE__CONTROL_INTERNAL_H
 
-#include <stddef.h>                     /* size_t */
-
 #include "qom/cpu.h"
 
 
-- 
2.13.6

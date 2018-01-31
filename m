Received: from eggs.gnu.org ([2001:4830:134:3::10]:50933)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1egth4-00005L-T2
	for qemu-devel@nongnu.org; Wed, 31 Jan 2018 09:49:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1egtgx-0003cF-BS
	for qemu-devel@nongnu.org; Wed, 31 Jan 2018 09:48:58 -0500
Received: from mx1.redhat.com ([209.132.183.28]:58970)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1egtgw-0003bK-Vd
	for qemu-devel@nongnu.org; Wed, 31 Jan 2018 09:48:51 -0500
From: Markus Armbruster <armbru@redhat.com>
Date: Wed, 31 Jan 2018 15:48:31 +0100
Message-Id: <20180131144846.31697-5-armbru@redhat.com>
In-Reply-To: <20180131144846.31697-1-armbru@redhat.com>
References: <20180131144846.31697-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 04/19] Include qapi/error.h exactly where
 needed
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

This cleanup makes the number of objects depending on qapi/error.h
drop from 1910 (out of 4743) to 1612 in my "build everything" tree.

While there, separate #include from file comment with a blank line,
and drop a useless comment on why qemu/osdep.h is included first.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
---
 audio/wavcapture.c                      | 1 +
 balloon.c                               | 1 +
 block.c                                 | 2 ++
 block/block-backend.c                   | 1 +
 block/iscsi.c                           | 1 +
 block/qapi.c                            | 1 +
 block/qcow2-cluster.c                   | 1 -
 block/qcow2.c                           | 2 ++
 block/quorum.c                          | 1 +
 block/write-threshold.c                 | 1 +
 blockdev-nbd.c                          | 1 +
 blockdev.c                              | 1 +
 blockjob.c                              | 1 +
 chardev/char-ringbuf.c                  | 2 ++
 chardev/char.c                          | 2 ++
 chardev/spice.c                         | 1 +
 cpus.c                                  | 2 +-
 crypto/hash.c                           | 1 -
 crypto/hmac.c                           | 1 -
 crypto/ivgen-essiv.c                    | 1 -
 crypto/ivgen-plain.c                    | 1 -
 crypto/ivgen-plain64.c                  | 1 -
 crypto/random-gnutls.c                  | 1 +
 crypto/random-platform.c                | 1 +
 docs/devel/qapi-code-gen.txt            | 2 --
 dump.c                                  | 1 +
 fsdev/qemu-fsdev-throttle.h             | 1 -
 fsdev/qemu-fsdev.c                      | 3 ++-
 hmp.c                                   | 1 +
 hw/9pfs/9p-local.c                      | 2 +-
 hw/9pfs/9p-proxy.c                      | 2 ++
 hw/acpi/acpi-stub.c                     | 1 +
 hw/acpi/core.c                          | 2 ++
 hw/acpi/memory_hotplug.c                | 1 +
 hw/acpi/vmgenid.c                       | 1 +
 hw/adc/stm32f2xx_adc.c                  | 1 -
 hw/char/mcf_uart.c                      | 1 -
 hw/char/virtio-console.c                | 1 +
 hw/core/qdev.c                          | 1 +
 hw/display/milkymist-tmu2.c             | 1 +
 hw/display/qxl.c                        | 1 +
 hw/display/virtio-gpu-3d.c              | 1 -
 hw/display/xlnx_dp.c                    | 1 +
 hw/i2c/ppc4xx_i2c.c                     | 1 -
 hw/i386/pc.c                            | 2 ++
 hw/i386/pc_piix.c                       | 1 +
 hw/i386/pc_q35.c                        | 2 ++
 hw/i386/xen/xen-hvm.c                   | 2 +-
 hw/ide/core.c                           | 2 ++
 hw/intc/xics_pnv.c                      | 1 -
 hw/intc/xics_spapr.c                    | 1 -
 hw/ipmi/ipmi.c                          | 1 +
 hw/mips/mips_jazz.c                     | 1 +
 hw/mips/mips_malta.c                    | 1 +
 hw/misc/exynos4210_rng.c                | 1 +
 hw/misc/mips_cmgcr.c                    | 1 -
 hw/misc/mps2-scc.c                      | 1 -
 hw/net/rocker/qmp-norocker.c            | 1 +
 hw/net/rocker/rocker.c                  | 1 +
 hw/net/rocker/rocker_of_dpa.c           | 1 +
 hw/net/virtio-net.c                     | 1 +
 hw/nios2/cpu_pic.c                      | 1 -
 hw/pci-bridge/i82801b11.c               | 1 -
 hw/pci-bridge/ioh3420.c                 | 1 -
 hw/pci-bridge/xio3130_upstream.c        | 1 -
 hw/pci-host/sabre.c                     | 1 -
 hw/pci/pci-stub.c                       | 1 +
 hw/pci/pci.c                            | 2 ++
 hw/ppc/fdt.c                            | 1 -
 hw/ppc/pnv_bmc.c                        | 1 -
 hw/ppc/pnv_xscom.c                      | 1 -
 hw/ppc/ppc.c                            | 1 -
 hw/ppc/spapr_pci_vfio.c                 | 1 -
 hw/ppc/spapr_rtc.c                      | 3 ++-
 hw/s390x/s390-skeys.c                   | 1 +
 hw/scsi/esp.c                           | 1 -
 hw/scsi/vhost-scsi-common.c             | 1 -
 hw/sd/sdhci.c                           | 1 -
 hw/smbios/smbios-stub.c                 | 1 +
 hw/sparc64/niagara.c                    | 1 -
 hw/sparc64/sun4u_iommu.c                | 1 -
 hw/ssi/stm32f2xx_spi.c                  | 1 -
 hw/timer/m48t59.c                       | 1 -
 hw/timer/mc146818rtc.c                  | 2 ++
 hw/usb/ccid-card-passthru.c             | 1 -
 hw/virtio/virtio-balloon.c              | 1 +
 hw/watchdog/watchdog.c                  | 1 +
 include/crypto/random.h                 | 1 -
 include/crypto/xts.h                    | 1 -
 include/hw/ide/internal.h               | 1 -
 include/ui/console.h                    | 2 ++
 iothread.c                              | 1 +
 migration/colo-failover.c               | 1 +
 migration/colo.c                        | 1 +
 migration/exec.c                        | 1 -
 migration/fd.c                          | 1 -
 migration/migration.c                   | 1 +
 migration/ram.c                         | 2 ++
 migration/savevm.c                      | 1 +
 monitor.c                               | 2 ++
 nbd/common.c                            | 1 -
 net/filter-replay.c                     | 1 -
 net/filter-rewriter.c                   | 1 -
 net/net.c                               | 2 ++
 net/vhost-user.c                        | 1 +
 numa.c                                  | 1 +
 qdev-monitor.c                          | 1 +
 qga/commands-posix.c                    | 1 +
 qga/commands-win32.c                    | 2 ++
 qga/commands.c                          | 1 +
 qga/main.c                              | 2 ++
 qga/vss-win32.c                         | 1 +
 qmp.c                                   | 1 +
 qobject/qnum.c                          | 1 -
 replay/replay-input.c                   | 1 -
 scripts/qapi-commands.py                | 3 ++-
 scripts/qapi-event.py                   | 2 +-
 stubs/arch-query-cpu-def.c              | 1 +
 stubs/arch-query-cpu-model-baseline.c   | 1 +
 stubs/arch-query-cpu-model-comparison.c | 1 +
 stubs/arch-query-cpu-model-expansion.c  | 1 +
 stubs/vmgenid.c                         | 1 +
 target/i386/cpu.c                       | 2 ++
 target/i386/xsave_helper.c              | 1 -
 target/nios2/helper.c                   | 1 -
 target/ppc/mmu-book3s-v3.c              | 1 -
 target/ppc/mmu-hash64.c                 | 1 -
 target/ppc/mmu-radix64.c                | 1 -
 target/ppc/mmu_helper.c                 | 1 -
 target/ppc/translate_init.c             | 1 +
 target/s390x/excp_helper.c              | 1 -
 target/s390x/helper.c                   | 1 -
 target/s390x/kvm.c                      | 1 +
 tests/check-qlist.c                     | 1 -
 tests/check-qnum.c                      | 1 -
 tests/io-channel-helpers.c              | 1 -
 tests/test-aio-multithread.c            | 1 -
 tests/test-qmp-commands.c               | 1 +
 tests/test-qmp-event.c                  | 1 +
 tests/test-x86-cpuid-compat.c           | 1 -
 tpm.c                                   | 2 ++
 trace/qmp.c                             | 1 +
 ui/console.c                            | 2 ++
 ui/gtk.c                                | 1 +
 ui/input.c                              | 1 +
 ui/spice-core.c                         | 1 +
 ui/vnc.c                                | 1 +
 util/qemu-config.c                      | 1 +
 vl.c                                    | 2 ++
 149 files changed, 116 insertions(+), 65 deletions(-)

diff --git a/audio/wavcapture.c b/audio/wavcapture.c
index 5863803584..cf31ed652c 100644
--- a/audio/wavcapture.c
+++ b/audio/wavcapture.c
@@ -1,6 +1,7 @@
 #include "qemu/osdep.h"
 #include "hw/hw.h"
 #include "monitor/monitor.h"
+#include "qapi/error.h"
 #include "qemu/error-report.h"
 #include "audio.h"
=20
diff --git a/balloon.c b/balloon.c
index 1d720fff81..f8b5ca9870 100644
--- a/balloon.c
+++ b/balloon.c
@@ -31,6 +31,7 @@
 #include "sysemu/balloon.h"
 #include "trace-root.h"
 #include "qmp-commands.h"
+#include "qapi/error.h"
 #include "qapi/qmp/qerror.h"
 #include "qapi/qmp/qjson.h"
=20
diff --git a/block.c b/block.c
index a8da4f2b25..2a8bc276c7 100644
--- a/block.c
+++ b/block.c
@@ -21,6 +21,7 @@
  * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALING=
S IN
  * THE SOFTWARE.
  */
+
 #include "qemu/osdep.h"
 #include "block/trace.h"
 #include "block/block_int.h"
@@ -29,6 +30,7 @@
 #include "qemu/error-report.h"
 #include "module_block.h"
 #include "qemu/module.h"
+#include "qapi/error.h"
 #include "qapi/qmp/qerror.h"
 #include "qapi/qmp/qbool.h"
 #include "qapi/qmp/qjson.h"
diff --git a/block/block-backend.c b/block/block-backend.c
index baef8e7abc..6a5fdb7f42 100644
--- a/block/block-backend.c
+++ b/block/block-backend.c
@@ -18,6 +18,7 @@
 #include "sysemu/blockdev.h"
 #include "sysemu/sysemu.h"
 #include "qapi-event.h"
+#include "qapi/error.h"
 #include "qemu/id.h"
 #include "trace.h"
 #include "migration/misc.h"
diff --git a/block/iscsi.c b/block/iscsi.c
index 6a1c53711a..9a1bf43cbc 100644
--- a/block/iscsi.c
+++ b/block/iscsi.c
@@ -38,6 +38,7 @@
 #include "qemu/iov.h"
 #include "qemu/uuid.h"
 #include "qmp-commands.h"
+#include "qapi/error.h"
 #include "qapi/qmp/qstring.h"
 #include "crypto/secret.h"
 #include "scsi/utils.h"
diff --git a/block/qapi.c b/block/qapi.c
index fc10f0a565..4fc9fd8082 100644
--- a/block/qapi.c
+++ b/block/qapi.c
@@ -29,6 +29,7 @@
 #include "block/write-threshold.h"
 #include "qmp-commands.h"
 #include "qapi-visit.h"
+#include "qapi/error.h"
 #include "qapi/qobject-output-visitor.h"
 #include "qapi/qmp/types.h"
 #include "sysemu/block-backend.h"
diff --git a/block/qcow2-cluster.c b/block/qcow2-cluster.c
index a3fec27bf9..3a979bcd82 100644
--- a/block/qcow2-cluster.c
+++ b/block/qcow2-cluster.c
@@ -25,7 +25,6 @@
 #include "qemu/osdep.h"
 #include <zlib.h>
=20
-#include "qapi/error.h"
 #include "qemu-common.h"
 #include "block/block_int.h"
 #include "block/qcow2.h"
diff --git a/block/qcow2.c b/block/qcow2.c
index 1f80961e1b..7645b3c6ae 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -21,6 +21,7 @@
  * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALING=
S IN
  * THE SOFTWARE.
  */
+
 #include "qemu/osdep.h"
 #include "block/block_int.h"
 #include "sysemu/block-backend.h"
@@ -28,6 +29,7 @@
 #include <zlib.h>
 #include "block/qcow2.h"
 #include "qemu/error-report.h"
+#include "qapi/error.h"
 #include "qapi/qmp/qerror.h"
 #include "qapi/qmp/qbool.h"
 #include "qapi/qmp/types.h"
diff --git a/block/quorum.c b/block/quorum.c
index 272f9a5b77..ec427c39e7 100644
--- a/block/quorum.c
+++ b/block/quorum.c
@@ -16,6 +16,7 @@
 #include "qemu/osdep.h"
 #include "qemu/cutils.h"
 #include "block/block_int.h"
+#include "qapi/error.h"
 #include "qapi/qmp/qbool.h"
 #include "qapi/qmp/qdict.h"
 #include "qapi/qmp/qerror.h"
diff --git a/block/write-threshold.c b/block/write-threshold.c
index 0bd1a01c86..a7146c8452 100644
--- a/block/write-threshold.c
+++ b/block/write-threshold.c
@@ -16,6 +16,7 @@
 #include "block/write-threshold.h"
 #include "qemu/notify.h"
 #include "qapi-event.h"
+#include "qapi/error.h"
 #include "qmp-commands.h"
=20
=20
diff --git a/blockdev-nbd.c b/blockdev-nbd.c
index 9e3c22109c..f3c3400e52 100644
--- a/blockdev-nbd.c
+++ b/blockdev-nbd.c
@@ -13,6 +13,7 @@
 #include "sysemu/blockdev.h"
 #include "sysemu/block-backend.h"
 #include "hw/block/block.h"
+#include "qapi/error.h"
 #include "qapi/qmp/qerror.h"
 #include "sysemu/sysemu.h"
 #include "qmp-commands.h"
diff --git a/blockdev.c b/blockdev.c
index 8e977eef11..ad82dbbeee 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -42,6 +42,7 @@
 #include "qemu/config-file.h"
 #include "qapi/qmp/types.h"
 #include "qapi-visit.h"
+#include "qapi/error.h"
 #include "qapi/qmp/qerror.h"
 #include "qapi/qobject-output-visitor.h"
 #include "sysemu/sysemu.h"
diff --git a/blockjob.c b/blockjob.c
index f5cea84e73..d766fdc4ce 100644
--- a/blockjob.c
+++ b/blockjob.c
@@ -29,6 +29,7 @@
 #include "block/blockjob_int.h"
 #include "block/block_int.h"
 #include "sysemu/block-backend.h"
+#include "qapi/error.h"
 #include "qapi/qmp/qerror.h"
 #include "qapi/qmp/qjson.h"
 #include "qemu/coroutine.h"
diff --git a/chardev/char-ringbuf.c b/chardev/char-ringbuf.c
index df52b04d22..c1fa4c3f87 100644
--- a/chardev/char-ringbuf.c
+++ b/chardev/char-ringbuf.c
@@ -21,9 +21,11 @@
  * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALING=
S IN
  * THE SOFTWARE.
  */
+
 #include "qemu/osdep.h"
 #include "chardev/char.h"
 #include "qmp-commands.h"
+#include "qapi/error.h"
 #include "qemu/base64.h"
=20
 /* Ring buffer chardev */
diff --git a/chardev/char.c b/chardev/char.c
index 3e14de1920..51f269796a 100644
--- a/chardev/char.c
+++ b/chardev/char.c
@@ -21,6 +21,7 @@
  * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALING=
S IN
  * THE SOFTWARE.
  */
+
 #include "qemu/osdep.h"
 #include "qemu/cutils.h"
 #include "monitor/monitor.h"
@@ -30,6 +31,7 @@
 #include "chardev/char.h"
 #include "qmp-commands.h"
 #include "qapi-visit.h"
+#include "qapi/error.h"
 #include "sysemu/replay.h"
 #include "qemu/help_option.h"
=20
diff --git a/chardev/spice.c b/chardev/spice.c
index a312078812..bbdf649904 100644
--- a/chardev/spice.c
+++ b/chardev/spice.c
@@ -2,6 +2,7 @@
 #include "trace.h"
 #include "ui/qemu-spice.h"
 #include "chardev/char.h"
+#include "qapi/error.h"
 #include "qemu/error-report.h"
 #include <spice.h>
 #include <spice/protocol.h>
diff --git a/cpus.c b/cpus.c
index 2cb0af9b22..c5bd49d60a 100644
--- a/cpus.c
+++ b/cpus.c
@@ -22,12 +22,12 @@
  * THE SOFTWARE.
  */
=20
-/* Needed early for CONFIG_BSD etc. */
 #include "qemu/osdep.h"
 #include "qemu-common.h"
 #include "qemu/config-file.h"
 #include "cpu.h"
 #include "monitor/monitor.h"
+#include "qapi/error.h"
 #include "qapi/qmp/qerror.h"
 #include "qemu/error-report.h"
 #include "sysemu/sysemu.h"
diff --git a/crypto/hash.c b/crypto/hash.c
index 8dab25d9ea..b97323cf90 100644
--- a/crypto/hash.c
+++ b/crypto/hash.c
@@ -19,7 +19,6 @@
  */
=20
 #include "qemu/osdep.h"
-#include "qapi/error.h"
 #include "crypto/hash.h"
 #include "hashpriv.h"
=20
diff --git a/crypto/hmac.c b/crypto/hmac.c
index f6c2d8db60..4de7e8c9cb 100644
--- a/crypto/hmac.c
+++ b/crypto/hmac.c
@@ -10,7 +10,6 @@
  */
=20
 #include "qemu/osdep.h"
-#include "qapi/error.h"
 #include "crypto/hmac.h"
 #include "hmacpriv.h"
=20
diff --git a/crypto/ivgen-essiv.c b/crypto/ivgen-essiv.c
index ad4d926c19..aeaa8fcd5b 100644
--- a/crypto/ivgen-essiv.c
+++ b/crypto/ivgen-essiv.c
@@ -19,7 +19,6 @@
  */
=20
 #include "qemu/osdep.h"
-#include "qapi/error.h"
 #include "qemu/bswap.h"
 #include "crypto/ivgen-essiv.h"
=20
diff --git a/crypto/ivgen-plain.c b/crypto/ivgen-plain.c
index 9b9b4ad0bf..bf2fb7aac4 100644
--- a/crypto/ivgen-plain.c
+++ b/crypto/ivgen-plain.c
@@ -19,7 +19,6 @@
  */
=20
 #include "qemu/osdep.h"
-#include "qapi/error.h"
 #include "qemu/bswap.h"
 #include "crypto/ivgen-plain.h"
=20
diff --git a/crypto/ivgen-plain64.c b/crypto/ivgen-plain64.c
index 6c6b1b44c3..e4679a1e6e 100644
--- a/crypto/ivgen-plain64.c
+++ b/crypto/ivgen-plain64.c
@@ -19,7 +19,6 @@
  */
=20
 #include "qemu/osdep.h"
-#include "qapi/error.h"
 #include "qemu/bswap.h"
 #include "crypto/ivgen-plain.h"
=20
diff --git a/crypto/random-gnutls.c b/crypto/random-gnutls.c
index 5350003a0b..445fd6a30b 100644
--- a/crypto/random-gnutls.c
+++ b/crypto/random-gnutls.c
@@ -21,6 +21,7 @@
 #include "qemu/osdep.h"
=20
 #include "crypto/random.h"
+#include "qapi/error.h"
=20
 #include <gnutls/gnutls.h>
 #include <gnutls/crypto.h>
diff --git a/crypto/random-platform.c b/crypto/random-platform.c
index 92eed0ee78..7541b4cae7 100644
--- a/crypto/random-platform.c
+++ b/crypto/random-platform.c
@@ -21,6 +21,7 @@
 #include "qemu/osdep.h"
=20
 #include "crypto/random.h"
+#include "qapi/error.h"
=20
 #ifdef _WIN32
 #include <wincrypt.h>
diff --git a/docs/devel/qapi-code-gen.txt b/docs/devel/qapi-code-gen.txt
index 06ab699066..5900b39b91 100644
--- a/docs/devel/qapi-code-gen.txt
+++ b/docs/devel/qapi-code-gen.txt
@@ -1170,7 +1170,6 @@ Example:
     #include "example-qapi-types.h"
     #include "qapi/qmp/qdict.h"
     #include "qapi/qmp/dispatch.h"
-    #include "qapi/error.h"
=20
     void example_qmp_init_marshal(QmpCommandList *cmds);
     UserDefOne *qmp_my_command(UserDefOneList *arg1, Error **errp);
@@ -1263,7 +1262,6 @@ Example:
     #ifndef EXAMPLE_QAPI_EVENT_H
     #define EXAMPLE_QAPI_EVENT_H
=20
-    #include "qapi/error.h"
     #include "qapi/qmp/qdict.h"
     #include "example-qapi-types.h"
=20
diff --git a/dump.c b/dump.c
index e9dfed060a..7b13baa413 100644
--- a/dump.c
+++ b/dump.c
@@ -22,6 +22,7 @@
 #include "sysemu/sysemu.h"
 #include "sysemu/memory_mapping.h"
 #include "sysemu/cpus.h"
+#include "qapi/error.h"
 #include "qapi/qmp/qerror.h"
 #include "qmp-commands.h"
 #include "qapi-event.h"
diff --git a/fsdev/qemu-fsdev-throttle.h b/fsdev/qemu-fsdev-throttle.h
index e418643ccb..4e83bdac25 100644
--- a/fsdev/qemu-fsdev-throttle.h
+++ b/fsdev/qemu-fsdev-throttle.h
@@ -18,7 +18,6 @@
 #include "block/aio.h"
 #include "qemu/main-loop.h"
 #include "qemu/coroutine.h"
-#include "qapi/error.h"
 #include "qemu/throttle.h"
=20
 typedef struct FsThrottle {
diff --git a/fsdev/qemu-fsdev.c b/fsdev/qemu-fsdev.c
index 941e309657..de819cf7a1 100644
--- a/fsdev/qemu-fsdev.c
+++ b/fsdev/qemu-fsdev.c
@@ -8,9 +8,10 @@
  *
  * This work is licensed under the terms of the GNU GPL, version 2.  See
  * the COPYING file in the top-level directory.
- *
  */
+
 #include "qemu/osdep.h"
+#include "qapi/error.h"
 #include "qemu-fsdev.h"
 #include "qemu/queue.h"
 #include "qemu-common.h"
diff --git a/hmp.c b/hmp.c
index 056bf70cf1..4fcf0e10d1 100644
--- a/hmp.c
+++ b/hmp.c
@@ -27,6 +27,7 @@
 #include "qemu/sockets.h"
 #include "monitor/monitor.h"
 #include "monitor/qdev.h"
+#include "qapi/error.h"
 #include "qapi/opts-visitor.h"
 #include "qapi/qmp/qerror.h"
 #include "qapi/string-input-visitor.h"
diff --git a/hw/9pfs/9p-local.c b/hw/9pfs/9p-local.c
index b25c185ff0..fe85726c97 100644
--- a/hw/9pfs/9p-local.c
+++ b/hw/9pfs/9p-local.c
@@ -8,7 +8,6 @@
  *
  * This work is licensed under the terms of the GNU GPL, version 2.  See
  * the COPYING file in the top-level directory.
- *
  */
=20
 #include "qemu/osdep.h"
@@ -23,6 +22,7 @@
 #include <sys/socket.h>
 #include <sys/un.h>
 #include "qemu/xattr.h"
+#include "qapi/error.h"
 #include "qemu/cutils.h"
 #include "qemu/error-report.h"
 #include <libgen.h>
diff --git a/hw/9pfs/9p-proxy.c b/hw/9pfs/9p-proxy.c
index f030c6a428..0f288b1300 100644
--- a/hw/9pfs/9p-proxy.c
+++ b/hw/9pfs/9p-proxy.c
@@ -9,10 +9,12 @@
  * This work is licensed under the terms of the GNU GPL, version 2.  See
  * the COPYING file in the top-level directory.
  */
+
 #include "qemu/osdep.h"
 #include <sys/socket.h>
 #include <sys/un.h>
 #include "9p.h"
+#include "qapi/error.h"
 #include "qemu/cutils.h"
 #include "qemu/error-report.h"
 #include "fsdev/qemu-fsdev.h"
diff --git a/hw/acpi/acpi-stub.c b/hw/acpi/acpi-stub.c
index 26bd22f7ec..7dfc8af316 100644
--- a/hw/acpi/acpi-stub.c
+++ b/hw/acpi/acpi-stub.c
@@ -19,6 +19,7 @@
  */
=20
 #include "qemu/osdep.h"
+#include "qapi/error.h"
 #include "qapi/qmp/qerror.h"
 #include "qmp-commands.h"
 #include "hw/acpi/acpi.h"
diff --git a/hw/acpi/core.c b/hw/acpi/core.c
index eb9b76f70b..5ee55414c1 100644
--- a/hw/acpi/core.c
+++ b/hw/acpi/core.c
@@ -18,12 +18,14 @@
  * Contributions after 2012-01-13 are licensed under the terms of the
  * GNU GPL, version 2 or (at your option) any later version.
  */
+
 #include "qemu/osdep.h"
 #include "sysemu/sysemu.h"
 #include "hw/hw.h"
 #include "hw/acpi/acpi.h"
 #include "hw/nvram/fw_cfg.h"
 #include "qemu/config-file.h"
+#include "qapi/error.h"
 #include "qapi/opts-visitor.h"
 #include "qapi-visit.h"
 #include "qapi-event.h"
diff --git a/hw/acpi/memory_hotplug.c b/hw/acpi/memory_hotplug.c
index cda2c9dd06..ea958a0e99 100644
--- a/hw/acpi/memory_hotplug.c
+++ b/hw/acpi/memory_hotplug.c
@@ -6,6 +6,7 @@
 #include "hw/qdev-core.h"
 #include "trace.h"
 #include "qapi-event.h"
+#include "qapi/error.h"
=20
 #define MEMORY_SLOTS_NUMBER          "MDNR"
 #define MEMORY_HOTPLUG_IO_REGION     "HPMR"
diff --git a/hw/acpi/vmgenid.c b/hw/acpi/vmgenid.c
index ba6f47b67b..f25eafc0ec 100644
--- a/hw/acpi/vmgenid.c
+++ b/hw/acpi/vmgenid.c
@@ -11,6 +11,7 @@
  */
=20
 #include "qemu/osdep.h"
+#include "qapi/error.h"
 #include "qmp-commands.h"
 #include "hw/acpi/acpi.h"
 #include "hw/acpi/aml-build.h"
diff --git a/hw/adc/stm32f2xx_adc.c b/hw/adc/stm32f2xx_adc.c
index 13f31ad2f7..329a8aa673 100644
--- a/hw/adc/stm32f2xx_adc.c
+++ b/hw/adc/stm32f2xx_adc.c
@@ -25,7 +25,6 @@
 #include "qemu/osdep.h"
 #include "hw/sysbus.h"
 #include "hw/hw.h"
-#include "qapi/error.h"
 #include "qemu/log.h"
 #include "hw/adc/stm32f2xx_adc.h"
=20
diff --git a/hw/char/mcf_uart.c b/hw/char/mcf_uart.c
index 56fa402b58..faae083e78 100644
--- a/hw/char/mcf_uart.c
+++ b/hw/char/mcf_uart.c
@@ -11,7 +11,6 @@
 #include "hw/m68k/mcf.h"
 #include "chardev/char-fe.h"
 #include "exec/address-spaces.h"
-#include "qapi/error.h"
=20
 typedef struct {
     SysBusDevice parent_obj;
diff --git a/hw/char/virtio-console.c b/hw/char/virtio-console.c
index 172c72d06c..4be5d4ee52 100644
--- a/hw/char/virtio-console.c
+++ b/hw/char/virtio-console.c
@@ -16,6 +16,7 @@
 #include "trace.h"
 #include "hw/virtio/virtio-serial.h"
 #include "qapi-event.h"
+#include "qapi/error.h"
=20
 #define TYPE_VIRTIO_CONSOLE_SERIAL_PORT "virtserialport"
 #define VIRTIO_CONSOLE(obj) \
diff --git a/hw/core/qdev.c b/hw/core/qdev.c
index 2456035d1a..f93f7d9388 100644
--- a/hw/core/qdev.c
+++ b/hw/core/qdev.c
@@ -28,6 +28,7 @@
 #include "qemu/osdep.h"
 #include "hw/qdev.h"
 #include "sysemu/sysemu.h"
+#include "qapi/error.h"
 #include "qapi/qmp/qerror.h"
 #include "qapi/visitor.h"
 #include "qapi/qmp/qjson.h"
diff --git a/hw/display/milkymist-tmu2.c b/hw/display/milkymist-tmu2.c
index 59120ddb67..3ce44fdfce 100644
--- a/hw/display/milkymist-tmu2.c
+++ b/hw/display/milkymist-tmu2.c
@@ -28,6 +28,7 @@
 #include "hw/hw.h"
 #include "hw/sysbus.h"
 #include "trace.h"
+#include "qapi/error.h"
 #include "qemu/error-report.h"
 #include "qapi/error.h"
=20
diff --git a/hw/display/qxl.c b/hw/display/qxl.c
index b9fa067f6e..a71714ccb4 100644
--- a/hw/display/qxl.c
+++ b/hw/display/qxl.c
@@ -21,6 +21,7 @@
 #include "qemu/osdep.h"
 #include <zlib.h>
=20
+#include "qapi/error.h"
 #include "qemu-common.h"
 #include "qemu/timer.h"
 #include "qemu/queue.h"
diff --git a/hw/display/virtio-gpu-3d.c b/hw/display/virtio-gpu-3d.c
index 8c106a662d..7db84efe89 100644
--- a/hw/display/virtio-gpu-3d.c
+++ b/hw/display/virtio-gpu-3d.c
@@ -17,7 +17,6 @@
 #include "trace.h"
 #include "hw/virtio/virtio.h"
 #include "hw/virtio/virtio-gpu.h"
-#include "qapi/error.h"
=20
 #ifdef CONFIG_VIRGL
=20
diff --git a/hw/display/xlnx_dp.c b/hw/display/xlnx_dp.c
index ead4e1a0e4..6715b9cc2b 100644
--- a/hw/display/xlnx_dp.c
+++ b/hw/display/xlnx_dp.c
@@ -23,6 +23,7 @@
  */
=20
 #include "qemu/osdep.h"
+#include "qapi/error.h"
 #include "qemu/log.h"
 #include "hw/display/xlnx_dp.h"
=20
diff --git a/hw/i2c/ppc4xx_i2c.c b/hw/i2c/ppc4xx_i2c.c
index e873a445da..ab64d196be 100644
--- a/hw/i2c/ppc4xx_i2c.c
+++ b/hw/i2c/ppc4xx_i2c.c
@@ -25,7 +25,6 @@
  */
=20
 #include "qemu/osdep.h"
-#include "qapi/error.h"
 #include "qemu-common.h"
 #include "qemu/log.h"
 #include "cpu.h"
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index ccc50baa85..f610253953 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -21,6 +21,7 @@
  * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALING=
S IN
  * THE SOFTWARE.
  */
+
 #include "qemu/osdep.h"
 #include "hw/hw.h"
 #include "hw/i386/pc.h"
@@ -64,6 +65,7 @@
 #include "hw/pci/pci_host.h"
 #include "acpi-build.h"
 #include "hw/mem/pc-dimm.h"
+#include "qapi/error.h"
 #include "qapi/visitor.h"
 #include "qapi-visit.h"
 #include "qom/cpu.h"
diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index a25619dfbf..456dc9e9f0 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -47,6 +47,7 @@
 #include "exec/address-spaces.h"
 #include "hw/acpi/acpi.h"
 #include "cpu.h"
+#include "qapi/error.h"
 #include "qemu/error-report.h"
 #ifdef CONFIG_XEN
 #include <xen/hvm/hvm_info_table.h>
diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
index ed3a0b8ff7..aba7541a82 100644
--- a/hw/i386/pc_q35.c
+++ b/hw/i386/pc_q35.c
@@ -27,6 +27,7 @@
  * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALING=
S IN
  * THE SOFTWARE.
  */
+
 #include "qemu/osdep.h"
 #include "hw/hw.h"
 #include "hw/loader.h"
@@ -48,6 +49,7 @@
 #include "hw/ide/pci.h"
 #include "hw/ide/ahci.h"
 #include "hw/usb.h"
+#include "qapi/error.h"
 #include "qemu/error-report.h"
 #include "sysemu/numa.h"
=20
diff --git a/hw/i386/xen/xen-hvm.c b/hw/i386/xen/xen-hvm.c
index 8028bed6fd..bfdbe55580 100644
--- a/hw/i386/xen/xen-hvm.c
+++ b/hw/i386/xen/xen-hvm.c
@@ -17,7 +17,7 @@
 #include "hw/xen/xen_common.h"
 #include "hw/xen/xen_backend.h"
 #include "qmp-commands.h"
-
+#include "qapi/error.h"
 #include "qemu/error-report.h"
 #include "qemu/range.h"
 #include "sysemu/xen-mapcache.h"
diff --git a/hw/ide/core.c b/hw/ide/core.c
index 5be72d41dc..257b429381 100644
--- a/hw/ide/core.c
+++ b/hw/ide/core.c
@@ -22,6 +22,7 @@
  * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALING=
S IN
  * THE SOFTWARE.
  */
+
 #include "qemu/osdep.h"
 #include "hw/hw.h"
 #include "hw/pci/pci.h"
@@ -33,6 +34,7 @@
 #include "sysemu/dma.h"
 #include "hw/block/block.h"
 #include "sysemu/block-backend.h"
+#include "qapi/error.h"
 #include "qemu/cutils.h"
=20
 #include "hw/ide/internal.h"
diff --git a/hw/intc/xics_pnv.c b/hw/intc/xics_pnv.c
index 2a955a8946..c87de2189c 100644
--- a/hw/intc/xics_pnv.c
+++ b/hw/intc/xics_pnv.c
@@ -19,7 +19,6 @@
=20
 #include "qemu/osdep.h"
 #include "sysemu/sysemu.h"
-#include "qapi/error.h"
 #include "qemu/log.h"
 #include "hw/ppc/xics.h"
=20
diff --git a/hw/intc/xics_spapr.c b/hw/intc/xics_spapr.c
index 5a0967caf4..2e27b92b87 100644
--- a/hw/intc/xics_spapr.c
+++ b/hw/intc/xics_spapr.c
@@ -34,7 +34,6 @@
 #include "hw/ppc/xics.h"
 #include "hw/ppc/fdt.h"
 #include "qapi/visitor.h"
-#include "qapi/error.h"
=20
 /*
  * Guest interfaces
diff --git a/hw/ipmi/ipmi.c b/hw/ipmi/ipmi.c
index b27babd504..adbbf6e4a6 100644
--- a/hw/ipmi/ipmi.c
+++ b/hw/ipmi/ipmi.c
@@ -28,6 +28,7 @@
 #include "sysemu/sysemu.h"
 #include "qmp-commands.h"
 #include "qom/object_interfaces.h"
+#include "qapi/error.h"
 #include "qapi/visitor.h"
=20
 static uint32_t ipmi_current_uuid =3D 1;
diff --git a/hw/mips/mips_jazz.c b/hw/mips/mips_jazz.c
index 0d2c0683ba..84a2a62be9 100644
--- a/hw/mips/mips_jazz.c
+++ b/hw/mips/mips_jazz.c
@@ -45,6 +45,7 @@
 #include "hw/sysbus.h"
 #include "exec/address-spaces.h"
 #include "sysemu/qtest.h"
+#include "qapi/error.h"
 #include "qemu/error-report.h"
 #include "qemu/help_option.h"
=20
diff --git a/hw/mips/mips_malta.c b/hw/mips/mips_malta.c
index 37f19428d6..e57b24c198 100644
--- a/hw/mips/mips_malta.c
+++ b/hw/mips/mips_malta.c
@@ -51,6 +51,7 @@
 #include "hw/sysbus.h"             /* SysBusDevice */
 #include "qemu/host-utils.h"
 #include "sysemu/qtest.h"
+#include "qapi/error.h"
 #include "qemu/error-report.h"
 #include "hw/empty_slot.h"
 #include "sysemu/kvm.h"
diff --git a/hw/misc/exynos4210_rng.c b/hw/misc/exynos4210_rng.c
index 31ebe38e26..4ecbebd2d7 100644
--- a/hw/misc/exynos4210_rng.c
+++ b/hw/misc/exynos4210_rng.c
@@ -20,6 +20,7 @@
 #include "qemu/osdep.h"
 #include "crypto/random.h"
 #include "hw/sysbus.h"
+#include "qapi/error.h"
 #include "qemu/log.h"
=20
 #define DEBUG_EXYNOS_RNG 0
diff --git a/hw/misc/mips_cmgcr.c b/hw/misc/mips_cmgcr.c
index 211f6097fd..d019d41a3c 100644
--- a/hw/misc/mips_cmgcr.c
+++ b/hw/misc/mips_cmgcr.c
@@ -10,7 +10,6 @@
  */
=20
 #include "qemu/osdep.h"
-#include "qapi/error.h"
 #include "qemu/log.h"
 #include "hw/hw.h"
 #include "hw/sysbus.h"
diff --git a/hw/misc/mps2-scc.c b/hw/misc/mps2-scc.c
index 32be2a9df1..6a9d251f18 100644
--- a/hw/misc/mps2-scc.c
+++ b/hw/misc/mps2-scc.c
@@ -19,7 +19,6 @@
=20
 #include "qemu/osdep.h"
 #include "qemu/log.h"
-#include "qapi/error.h"
 #include "trace.h"
 #include "hw/sysbus.h"
 #include "hw/registerfields.h"
diff --git a/hw/net/rocker/qmp-norocker.c b/hw/net/rocker/qmp-norocker.c
index 6acbcdb02b..94c1e480ae 100644
--- a/hw/net/rocker/qmp-norocker.c
+++ b/hw/net/rocker/qmp-norocker.c
@@ -18,6 +18,7 @@
 #include "qemu/osdep.h"
 #include "qemu-common.h"
 #include "qmp-commands.h"
+#include "qapi/error.h"
 #include "qapi/qmp/qerror.h"
=20
 RockerSwitch *qmp_query_rocker(const char *name, Error **errp)
diff --git a/hw/net/rocker/rocker.c b/hw/net/rocker/rocker.c
index 823a29df03..a2a76c2a74 100644
--- a/hw/net/rocker/rocker.c
+++ b/hw/net/rocker/rocker.c
@@ -21,6 +21,7 @@
 #include "hw/pci/msix.h"
 #include "net/net.h"
 #include "net/eth.h"
+#include "qapi/error.h"
 #include "qemu/iov.h"
 #include "qemu/bitops.h"
 #include "qmp-commands.h"
diff --git a/hw/net/rocker/rocker_of_dpa.c b/hw/net/rocker/rocker_of_dpa.=
c
index 191a58e0a7..9339df2d09 100644
--- a/hw/net/rocker/rocker_of_dpa.c
+++ b/hw/net/rocker/rocker_of_dpa.c
@@ -16,6 +16,7 @@
=20
 #include "qemu/osdep.h"
 #include "net/eth.h"
+#include "qapi/error.h"
 #include "qemu/iov.h"
 #include "qemu/timer.h"
 #include "qmp-commands.h"
diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index 38674b08aa..0dd3cb8de4 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -22,6 +22,7 @@
 #include "hw/virtio/virtio-net.h"
 #include "net/vhost_net.h"
 #include "hw/virtio/virtio-bus.h"
+#include "qapi/error.h"
 #include "qapi/qmp/qjson.h"
 #include "qapi-event.h"
 #include "hw/virtio/virtio-access.h"
diff --git a/hw/nios2/cpu_pic.c b/hw/nios2/cpu_pic.c
index 0f95987ef3..6bccce2f32 100644
--- a/hw/nios2/cpu_pic.c
+++ b/hw/nios2/cpu_pic.c
@@ -19,7 +19,6 @@
  */
=20
 #include "qemu/osdep.h"
-#include "qapi/error.h"
 #include "qemu-common.h"
 #include "cpu.h"
=20
diff --git a/hw/pci-bridge/i82801b11.c b/hw/pci-bridge/i82801b11.c
index cb522bf30c..b24c33ceb5 100644
--- a/hw/pci-bridge/i82801b11.c
+++ b/hw/pci-bridge/i82801b11.c
@@ -44,7 +44,6 @@
 #include "qemu/osdep.h"
 #include "hw/pci/pci.h"
 #include "hw/i386/ich9.h"
-#include "qapi/error.h"
=20
=20
 /***********************************************************************=
******/
diff --git a/hw/pci-bridge/ioh3420.c b/hw/pci-bridge/ioh3420.c
index 5f56a2feb6..79fa84d7b9 100644
--- a/hw/pci-bridge/ioh3420.c
+++ b/hw/pci-bridge/ioh3420.c
@@ -25,7 +25,6 @@
 #include "hw/pci/msi.h"
 #include "hw/pci/pcie.h"
 #include "ioh3420.h"
-#include "qapi/error.h"
=20
 #define PCI_DEVICE_ID_IOH_EPORT         0x3420  /* D0:F0 express mode */
 #define PCI_DEVICE_ID_IOH_REV           0x2
diff --git a/hw/pci-bridge/xio3130_upstream.c b/hw/pci-bridge/xio3130_ups=
tream.c
index 227997ce46..df5692501b 100644
--- a/hw/pci-bridge/xio3130_upstream.c
+++ b/hw/pci-bridge/xio3130_upstream.c
@@ -24,7 +24,6 @@
 #include "hw/pci/msi.h"
 #include "hw/pci/pcie.h"
 #include "xio3130_upstream.h"
-#include "qapi/error.h"
=20
 #define PCI_DEVICE_ID_TI_XIO3130U       0x8232  /* upstream port */
 #define XIO3130_REVISION                0x2
diff --git a/hw/pci-host/sabre.c b/hw/pci-host/sabre.c
index 2268a41dd9..e2f4ee480e 100644
--- a/hw/pci-host/sabre.c
+++ b/hw/pci-host/sabre.c
@@ -34,7 +34,6 @@
 #include "hw/pci-host/sabre.h"
 #include "sysemu/sysemu.h"
 #include "exec/address-spaces.h"
-#include "qapi/error.h"
 #include "qemu/log.h"
 #include "trace.h"
=20
diff --git a/hw/pci/pci-stub.c b/hw/pci/pci-stub.c
index d5ce00748e..74ce7316da 100644
--- a/hw/pci/pci-stub.c
+++ b/hw/pci/pci-stub.c
@@ -21,6 +21,7 @@
 #include "qemu/osdep.h"
 #include "sysemu/sysemu.h"
 #include "monitor/monitor.h"
+#include "qapi/error.h"
 #include "qapi/qmp/qerror.h"
 #include "hw/pci/pci.h"
 #include "qmp-commands.h"
diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index e8f9fc1c27..dec558311d 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -21,6 +21,7 @@
  * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALING=
S IN
  * THE SOFTWARE.
  */
+
 #include "qemu/osdep.h"
 #include "hw/hw.h"
 #include "hw/pci/pci.h"
@@ -40,6 +41,7 @@
 #include "exec/address-spaces.h"
 #include "hw/hotplug.h"
 #include "hw/boards.h"
+#include "qapi/error.h"
 #include "qemu/cutils.h"
=20
 //#define DEBUG_PCI
diff --git a/hw/ppc/fdt.c b/hw/ppc/fdt.c
index 38a7234b46..2ffc5866e4 100644
--- a/hw/ppc/fdt.c
+++ b/hw/ppc/fdt.c
@@ -8,7 +8,6 @@
  */
=20
 #include "qemu/osdep.h"
-#include "qapi/error.h"
 #include "target/ppc/cpu.h"
=20
 #include "hw/ppc/fdt.h"
diff --git a/hw/ppc/pnv_bmc.c b/hw/ppc/pnv_bmc.c
index b2cf441ee7..4b76d34f0a 100644
--- a/hw/ppc/pnv_bmc.c
+++ b/hw/ppc/pnv_bmc.c
@@ -20,7 +20,6 @@
 #include "hw/hw.h"
 #include "sysemu/sysemu.h"
 #include "target/ppc/cpu.h"
-#include "qapi/error.h"
 #include "qemu/log.h"
 #include "hw/ipmi/ipmi.h"
 #include "hw/ppc/fdt.h"
diff --git a/hw/ppc/pnv_xscom.c b/hw/ppc/pnv_xscom.c
index 99c40efecd..46fae41f32 100644
--- a/hw/ppc/pnv_xscom.c
+++ b/hw/ppc/pnv_xscom.c
@@ -17,7 +17,6 @@
  * License along with this library; if not, see <http://www.gnu.org/lice=
nses/>.
  */
 #include "qemu/osdep.h"
-#include "qapi/error.h"
 #include "hw/hw.h"
 #include "qemu/log.h"
 #include "sysemu/hw_accel.h"
diff --git a/hw/ppc/ppc.c b/hw/ppc/ppc.c
index 7ec35de5ae..ec4be25f49 100644
--- a/hw/ppc/ppc.c
+++ b/hw/ppc/ppc.c
@@ -33,7 +33,6 @@
 #include "hw/timer/m48t59.h"
 #include "qemu/log.h"
 #include "qemu/error-report.h"
-#include "qapi/error.h"
 #include "hw/loader.h"
 #include "sysemu/kvm.h"
 #include "kvm_ppc.h"
diff --git a/hw/ppc/spapr_pci_vfio.c b/hw/ppc/spapr_pci_vfio.c
index 053efb03bd..71491dbd28 100644
--- a/hw/ppc/spapr_pci_vfio.c
+++ b/hw/ppc/spapr_pci_vfio.c
@@ -19,7 +19,6 @@
=20
 #include "qemu/osdep.h"
 #include <linux/vfio.h>
-#include "qapi/error.h"
 #include "qemu-common.h"
 #include "cpu.h"
 #include "hw/ppc/spapr.h"
diff --git a/hw/ppc/spapr_rtc.c b/hw/ppc/spapr_rtc.c
index 9ec3078691..cfdb274bfd 100644
--- a/hw/ppc/spapr_rtc.c
+++ b/hw/ppc/spapr_rtc.c
@@ -23,14 +23,15 @@
  * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISI=
NG FROM,
  * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALING=
S IN
  * THE SOFTWARE.
- *
  */
+
 #include "qemu/osdep.h"
 #include "cpu.h"
 #include "qemu/timer.h"
 #include "sysemu/sysemu.h"
 #include "hw/ppc/spapr.h"
 #include "qapi-event.h"
+#include "qapi/error.h"
 #include "qemu/cutils.h"
=20
 void spapr_rtc_read(sPAPRRTCState *rtc, struct tm *tm, uint32_t *ns)
diff --git a/hw/s390x/s390-skeys.c b/hw/s390x/s390-skeys.c
index 53ad5d38d4..fd994f86b1 100644
--- a/hw/s390x/s390-skeys.c
+++ b/hw/s390x/s390-skeys.c
@@ -13,6 +13,7 @@
 #include "hw/boards.h"
 #include "qmp-commands.h"
 #include "hw/s390x/storage-keys.h"
+#include "qapi/error.h"
 #include "qemu/error-report.h"
 #include "sysemu/kvm.h"
 #include "migration/register.h"
diff --git a/hw/scsi/esp.c b/hw/scsi/esp.c
index ee586e7d6c..45975c21e8 100644
--- a/hw/scsi/esp.c
+++ b/hw/scsi/esp.c
@@ -27,7 +27,6 @@
 #include "hw/sysbus.h"
 #include "hw/scsi/esp.h"
 #include "trace.h"
-#include "qapi/error.h"
 #include "qemu/log.h"
=20
 /*
diff --git a/hw/scsi/vhost-scsi-common.c b/hw/scsi/vhost-scsi-common.c
index d434b3e99a..77e9897244 100644
--- a/hw/scsi/vhost-scsi-common.c
+++ b/hw/scsi/vhost-scsi-common.c
@@ -16,7 +16,6 @@
  */
=20
 #include "qemu/osdep.h"
-#include "qapi/error.h"
 #include "qemu/error-report.h"
 #include "migration/migration.h"
 #include "hw/virtio/vhost.h"
diff --git a/hw/sd/sdhci.c b/hw/sd/sdhci.c
index fac7fa5c72..37b217269b 100644
--- a/hw/sd/sdhci.c
+++ b/hw/sd/sdhci.c
@@ -32,7 +32,6 @@
 #include "qemu/bitops.h"
 #include "hw/sd/sdhci.h"
 #include "sdhci-internal.h"
-#include "qapi/error.h"
 #include "qemu/log.h"
 #include "trace.h"
=20
diff --git a/hw/smbios/smbios-stub.c b/hw/smbios/smbios-stub.c
index 308739410f..61becef4ae 100644
--- a/hw/smbios/smbios-stub.c
+++ b/hw/smbios/smbios-stub.c
@@ -21,6 +21,7 @@
  */
=20
 #include "qemu/osdep.h"
+#include "qapi/error.h"
 #include "qapi/qmp/qerror.h"
 #include "qmp-commands.h"
 #include "hw/smbios/smbios.h"
diff --git a/hw/sparc64/niagara.c b/hw/sparc64/niagara.c
index 7a723326c5..b6d4b14d17 100644
--- a/hw/sparc64/niagara.c
+++ b/hw/sparc64/niagara.c
@@ -23,7 +23,6 @@
  */
=20
 #include "qemu/osdep.h"
-#include "qapi/error.h"
 #include "qemu-common.h"
 #include "cpu.h"
 #include "hw/hw.h"
diff --git a/hw/sparc64/sun4u_iommu.c b/hw/sparc64/sun4u_iommu.c
index 4cf8e69be9..eb3aaa87e6 100644
--- a/hw/sparc64/sun4u_iommu.c
+++ b/hw/sparc64/sun4u_iommu.c
@@ -28,7 +28,6 @@
 #include "hw/sysbus.h"
 #include "hw/sparc/sun4u_iommu.h"
 #include "exec/address-spaces.h"
-#include "qapi/error.h"
 #include "qemu/log.h"
 #include "trace.h"
=20
diff --git a/hw/ssi/stm32f2xx_spi.c b/hw/ssi/stm32f2xx_spi.c
index 69514da9fb..930c616de3 100644
--- a/hw/ssi/stm32f2xx_spi.c
+++ b/hw/ssi/stm32f2xx_spi.c
@@ -23,7 +23,6 @@
  */
=20
 #include "qemu/osdep.h"
-#include "qapi/error.h"
 #include "qemu/log.h"
 #include "hw/ssi/stm32f2xx_spi.h"
=20
diff --git a/hw/timer/m48t59.c b/hw/timer/m48t59.c
index 844aad540e..742c576443 100644
--- a/hw/timer/m48t59.c
+++ b/hw/timer/m48t59.c
@@ -25,7 +25,6 @@
 #include "qemu/osdep.h"
 #include "hw/hw.h"
 #include "hw/timer/m48t59.h"
-#include "qapi/error.h"
 #include "qemu/timer.h"
 #include "sysemu/sysemu.h"
 #include "hw/sysbus.h"
diff --git a/hw/timer/mc146818rtc.c b/hw/timer/mc146818rtc.c
index 35a05a64cc..9d93a16e0f 100644
--- a/hw/timer/mc146818rtc.c
+++ b/hw/timer/mc146818rtc.c
@@ -21,6 +21,7 @@
  * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALING=
S IN
  * THE SOFTWARE.
  */
+
 #include "qemu/osdep.h"
 #include "qemu/cutils.h"
 #include "qemu/bcd.h"
@@ -29,6 +30,7 @@
 #include "sysemu/sysemu.h"
 #include "sysemu/replay.h"
 #include "hw/timer/mc146818rtc.h"
+#include "qapi/error.h"
 #include "qapi/visitor.h"
 #include "qapi-event.h"
 #include "qmp-commands.h"
diff --git a/hw/usb/ccid-card-passthru.c b/hw/usb/ccid-card-passthru.c
index 085ed2c667..b7dd3602dc 100644
--- a/hw/usb/ccid-card-passthru.c
+++ b/hw/usb/ccid-card-passthru.c
@@ -9,7 +9,6 @@
  */
=20
 #include "qemu/osdep.h"
-#include "qapi/error.h"
 #include <cacard/vscard_common.h>
 #include "chardev/char-fe.h"
 #include "qemu/error-report.h"
diff --git a/hw/virtio/virtio-balloon.c b/hw/virtio/virtio-balloon.c
index 14e08d20d0..e05df206fc 100644
--- a/hw/virtio/virtio-balloon.c
+++ b/hw/virtio/virtio-balloon.c
@@ -23,6 +23,7 @@
 #include "hw/virtio/virtio-balloon.h"
 #include "sysemu/kvm.h"
 #include "exec/address-spaces.h"
+#include "qapi/error.h"
 #include "qapi/visitor.h"
 #include "qapi-event.h"
 #include "trace.h"
diff --git a/hw/watchdog/watchdog.c b/hw/watchdog/watchdog.c
index 670114ecfe..25dcb25ff1 100644
--- a/hw/watchdog/watchdog.c
+++ b/hw/watchdog/watchdog.c
@@ -23,6 +23,7 @@
 #include "qemu/option.h"
 #include "qemu/config-file.h"
 #include "qemu/queue.h"
+#include "qapi/error.h"
 #include "qapi/qmp/types.h"
 #include "sysemu/sysemu.h"
 #include "sysemu/watchdog.h"
diff --git a/include/crypto/random.h b/include/crypto/random.h
index a07229ce96..32bb9c0038 100644
--- a/include/crypto/random.h
+++ b/include/crypto/random.h
@@ -22,7 +22,6 @@
 #define QCRYPTO_RANDOM_H
=20
 #include "qemu-common.h"
-#include "qapi/error.h"
=20
=20
 /**
diff --git a/include/crypto/xts.h b/include/crypto/xts.h
index da32ab82b6..719971afb7 100644
--- a/include/crypto/xts.h
+++ b/include/crypto/xts.h
@@ -27,7 +27,6 @@
 #define QCRYPTO_XTS_H
=20
 #include "qemu-common.h"
-#include "qapi/error.h"
=20
=20
 #define XTS_BLOCK_SIZE 16
diff --git a/include/hw/ide/internal.h b/include/hw/ide/internal.h
index 31851b44d1..88212f59df 100644
--- a/include/hw/ide/internal.h
+++ b/include/hw/ide/internal.h
@@ -12,7 +12,6 @@
 #include "sysemu/sysemu.h"
 #include "hw/block/block.h"
 #include "scsi/constants.h"
-#include "qapi/error.h"
=20
 /* debug IDE devices */
 #define USE_DMA_CDROM
diff --git a/include/ui/console.h b/include/ui/console.h
index d3312be322..d48bfcc4d9 100644
--- a/include/ui/console.h
+++ b/include/ui/console.h
@@ -6,7 +6,9 @@
 #include "qapi/qmp/qdict.h"
 #include "qemu/notify.h"
 #include "qemu/error-report.h"
+#ifndef CONFIG_VNC
 #include "qapi/error.h"
+#endif
=20
 #ifdef CONFIG_OPENGL
 # include <epoxy/gl.h>
diff --git a/iothread.c b/iothread.c
index d8b6c1fb27..4b9bbde4cd 100644
--- a/iothread.c
+++ b/iothread.c
@@ -19,6 +19,7 @@
 #include "block/block.h"
 #include "sysemu/iothread.h"
 #include "qmp-commands.h"
+#include "qapi/error.h"
 #include "qemu/error-report.h"
 #include "qemu/rcu.h"
 #include "qemu/main-loop.h"
diff --git a/migration/colo-failover.c b/migration/colo-failover.c
index 6563862b36..891785cb63 100644
--- a/migration/colo-failover.c
+++ b/migration/colo-failover.c
@@ -16,6 +16,7 @@
 #include "qemu/main-loop.h"
 #include "migration.h"
 #include "qmp-commands.h"
+#include "qapi/error.h"
 #include "qapi/qmp/qerror.h"
 #include "qemu/error-report.h"
 #include "trace.h"
diff --git a/migration/colo.c b/migration/colo.c
index dee3aa8bf7..245a46d59d 100644
--- a/migration/colo.c
+++ b/migration/colo.c
@@ -12,6 +12,7 @@
=20
 #include "qemu/osdep.h"
 #include "sysemu/sysemu.h"
+#include "qapi/error.h"
 #include "qemu-file-channel.h"
 #include "migration.h"
 #include "qemu-file.h"
diff --git a/migration/exec.c b/migration/exec.c
index f3be1baf2e..4d7d486382 100644
--- a/migration/exec.c
+++ b/migration/exec.c
@@ -18,7 +18,6 @@
  */
=20
 #include "qemu/osdep.h"
-#include "qapi/error.h"
 #include "channel.h"
 #include "exec.h"
 #include "io/channel-command.h"
diff --git a/migration/fd.c b/migration/fd.c
index 30de4b9847..6b2bdaa953 100644
--- a/migration/fd.c
+++ b/migration/fd.c
@@ -15,7 +15,6 @@
  */
=20
 #include "qemu/osdep.h"
-#include "qapi/error.h"
 #include "channel.h"
 #include "fd.h"
 #include "monitor/monitor.h"
diff --git a/migration/migration.c b/migration/migration.c
index c99a4e62d7..79ec88dba2 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -30,6 +30,7 @@
 #include "qemu-file.h"
 #include "migration/vmstate.h"
 #include "block/block.h"
+#include "qapi/error.h"
 #include "qapi/qmp/qerror.h"
 #include "qemu/rcu.h"
 #include "block.h"
diff --git a/migration/ram.c b/migration/ram.c
index cb1950f3eb..d67f564919 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -25,6 +25,7 @@
  * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALING=
S IN
  * THE SOFTWARE.
  */
+
 #include "qemu/osdep.h"
 #include "cpu.h"
 #include <zlib.h>
@@ -42,6 +43,7 @@
 #include "postcopy-ram.h"
 #include "migration/page_cache.h"
 #include "qemu/error-report.h"
+#include "qapi/error.h"
 #include "qapi/qmp/qerror.h"
 #include "trace.h"
 #include "exec/ram_addr.h"
diff --git a/migration/savevm.c b/migration/savevm.c
index b7908f62be..3f68a7a259 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -40,6 +40,7 @@
 #include "qemu-file.h"
 #include "savevm.h"
 #include "postcopy-ram.h"
+#include "qapi/error.h"
 #include "qapi/qmp/qerror.h"
 #include "qemu/error-report.h"
 #include "sysemu/cpus.h"
diff --git a/monitor.c b/monitor.c
index b9da5e20d1..2de69f648f 100644
--- a/monitor.c
+++ b/monitor.c
@@ -21,6 +21,7 @@
  * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALING=
S IN
  * THE SOFTWARE.
  */
+
 #include "qemu/osdep.h"
 #include <dirent.h>
 #include "qemu-common.h"
@@ -70,6 +71,7 @@
 #include "hmp.h"
 #include "qemu/thread.h"
 #include "block/qapi.h"
+#include "qapi/error.h"
 #include "qapi/qmp-event.h"
 #include "qapi-event.h"
 #include "qmp-introspect.h"
diff --git a/nbd/common.c b/nbd/common.c
index 6047d71748..6295526dd1 100644
--- a/nbd/common.c
+++ b/nbd/common.c
@@ -17,7 +17,6 @@
  */
=20
 #include "qemu/osdep.h"
-#include "qapi/error.h"
 #include "trace.h"
 #include "nbd-internal.h"
=20
diff --git a/net/filter-replay.c b/net/filter-replay.c
index cff65f86e5..09e68fd8f5 100644
--- a/net/filter-replay.c
+++ b/net/filter-replay.c
@@ -11,7 +11,6 @@
=20
 #include "qemu/osdep.h"
 #include "clients.h"
-#include "qapi/error.h"
 #include "qemu-common.h"
 #include "qemu/error-report.h"
 #include "qemu/iov.h"
diff --git a/net/filter-rewriter.c b/net/filter-rewriter.c
index 2be388f539..3ea3798276 100644
--- a/net/filter-rewriter.c
+++ b/net/filter-rewriter.c
@@ -15,7 +15,6 @@
 #include "net/filter.h"
 #include "net/net.h"
 #include "qemu-common.h"
-#include "qapi/error.h"
 #include "qapi/qmp/qerror.h"
 #include "qemu/error-report.h"
 #include "qapi-visit.h"
diff --git a/net/net.c b/net/net.c
index 2b81c93193..63068ce8e2 100644
--- a/net/net.c
+++ b/net/net.c
@@ -21,6 +21,7 @@
  * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALING=
S IN
  * THE SOFTWARE.
  */
+
 #include "qemu/osdep.h"
=20
 #include "net/net.h"
@@ -43,6 +44,7 @@
 #include "qemu/iov.h"
 #include "qemu/main-loop.h"
 #include "qapi-visit.h"
+#include "qapi/error.h"
 #include "qapi/opts-visitor.h"
 #include "sysemu/sysemu.h"
 #include "sysemu/qtest.h"
diff --git a/net/vhost-user.c b/net/vhost-user.c
index c23927c912..fd766504ab 100644
--- a/net/vhost-user.c
+++ b/net/vhost-user.c
@@ -13,6 +13,7 @@
 #include "net/vhost_net.h"
 #include "net/vhost-user.h"
 #include "chardev/char-fe.h"
+#include "qapi/error.h"
 #include "qemu/config-file.h"
 #include "qemu/error-report.h"
 #include "qmp-commands.h"
diff --git a/numa.c b/numa.c
index 83675a03f3..cc5d3f2947 100644
--- a/numa.c
+++ b/numa.c
@@ -30,6 +30,7 @@
 #include "qom/cpu.h"
 #include "qemu/error-report.h"
 #include "qapi-visit.h"
+#include "qapi/error.h"
 #include "qapi/opts-visitor.h"
 #include "hw/boards.h"
 #include "sysemu/hostmem.h"
diff --git a/qdev-monitor.c b/qdev-monitor.c
index c436616446..0aa8a6c60b 100644
--- a/qdev-monitor.c
+++ b/qdev-monitor.c
@@ -24,6 +24,7 @@
 #include "monitor/qdev.h"
 #include "qmp-commands.h"
 #include "sysemu/arch_init.h"
+#include "qapi/error.h"
 #include "qapi/qmp/qerror.h"
 #include "qemu/config-file.h"
 #include "qemu/error-report.h"
diff --git a/qga/commands-posix.c b/qga/commands-posix.c
index e809e382eb..88807f3c78 100644
--- a/qga/commands-posix.c
+++ b/qga/commands-posix.c
@@ -18,6 +18,7 @@
 #include <dirent.h>
 #include "qga/guest-agent-core.h"
 #include "qga-qmp-commands.h"
+#include "qapi/error.h"
 #include "qapi/qmp/qerror.h"
 #include "qemu/queue.h"
 #include "qemu/host-utils.h"
diff --git a/qga/commands-win32.c b/qga/commands-win32.c
index d79974f212..bedae32957 100644
--- a/qga/commands-win32.c
+++ b/qga/commands-win32.c
@@ -14,6 +14,7 @@
 #ifndef _WIN32_WINNT
 #   define _WIN32_WINNT 0x0600
 #endif
+
 #include "qemu/osdep.h"
 #include <wtypes.h>
 #include <powrprof.h>
@@ -34,6 +35,7 @@
 #include "qga/guest-agent-core.h"
 #include "qga/vss-win32.h"
 #include "qga-qmp-commands.h"
+#include "qapi/error.h"
 #include "qapi/qmp/qerror.h"
 #include "qemu/queue.h"
 #include "qemu/host-utils.h"
diff --git a/qga/commands.c b/qga/commands.c
index ff89e805cf..6d710dbb20 100644
--- a/qga/commands.c
+++ b/qga/commands.c
@@ -13,6 +13,7 @@
 #include "qemu/osdep.h"
 #include "qga/guest-agent-core.h"
 #include "qga-qmp-commands.h"
+#include "qapi/error.h"
 #include "qapi/qmp/qerror.h"
 #include "qemu/base64.h"
 #include "qemu/cutils.h"
diff --git a/qga/main.c b/qga/main.c
index 62a62755bd..57083ca10c 100644
--- a/qga/main.c
+++ b/qga/main.c
@@ -10,6 +10,7 @@
  * This work is licensed under the terms of the GNU GPL, version 2 or la=
ter.
  * See the COPYING file in the top-level directory.
  */
+
 #include "qemu/osdep.h"
 #include <getopt.h>
 #include <glib/gstdio.h>
@@ -23,6 +24,7 @@
 #include "qga/guest-agent-core.h"
 #include "qemu/module.h"
 #include "qapi/qmp/qerror.h"
+#include "qapi/error.h"
 #include "qapi/qmp/dispatch.h"
 #include "qga/channel.h"
 #include "qemu/bswap.h"
diff --git a/qga/vss-win32.c b/qga/vss-win32.c
index dcb27567bb..0199c2a792 100644
--- a/qga/vss-win32.c
+++ b/qga/vss-win32.c
@@ -12,6 +12,7 @@
=20
 #include "qemu/osdep.h"
 #include <windows.h>
+#include "qapi/error.h"
 #include "qemu/error-report.h"
 #include "qga/guest-agent-core.h"
 #include "qga/vss-win32.h"
diff --git a/qmp.c b/qmp.c
index 52cfd2d81c..a56faf1b9a 100644
--- a/qmp.c
+++ b/qmp.c
@@ -30,6 +30,7 @@
 #include "sysemu/blockdev.h"
 #include "sysemu/block-backend.h"
 #include "qom/qom-qobject.h"
+#include "qapi/error.h"
 #include "qapi/qmp/qerror.h"
 #include "qapi/qmp/qobject.h"
 #include "qapi/qobject-input-visitor.h"
diff --git a/qobject/qnum.c b/qobject/qnum.c
index 410686a611..517610d9da 100644
--- a/qobject/qnum.c
+++ b/qobject/qnum.c
@@ -13,7 +13,6 @@
  */
=20
 #include "qemu/osdep.h"
-#include "qapi/error.h"
 #include "qapi/qmp/qnum.h"
 #include "qapi/qmp/qobject.h"
 #include "qemu-common.h"
diff --git a/replay/replay-input.c b/replay/replay-input.c
index bd93554d8e..3ab1536bf7 100644
--- a/replay/replay-input.c
+++ b/replay/replay-input.c
@@ -10,7 +10,6 @@
  */
=20
 #include "qemu/osdep.h"
-#include "qapi/error.h"
 #include "qemu-common.h"
 #include "sysemu/replay.h"
 #include "replay-internal.h"
diff --git a/scripts/qapi-commands.py b/scripts/qapi-commands.py
index 974d0a4a80..dc7c418923 100644
--- a/scripts/qapi-commands.py
+++ b/scripts/qapi-commands.py
@@ -289,6 +289,7 @@ h_comment =3D '''
                             c_comment, h_comment)
=20
 fdef.write(mcgen('''
+
 #include "qemu/osdep.h"
 #include "qemu-common.h"
 #include "qemu/module.h"
@@ -297,6 +298,7 @@ fdef.write(mcgen('''
 #include "qapi/qobject-output-visitor.h"
 #include "qapi/qobject-input-visitor.h"
 #include "qapi/dealloc-visitor.h"
+#include "qapi/error.h"
 #include "%(prefix)sqapi-types.h"
 #include "%(prefix)sqapi-visit.h"
 #include "%(prefix)sqmp-commands.h"
@@ -308,7 +310,6 @@ fdecl.write(mcgen('''
 #include "%(prefix)sqapi-types.h"
 #include "qapi/qmp/qdict.h"
 #include "qapi/qmp/dispatch.h"
-#include "qapi/error.h"
=20
 void %(c_prefix)sqmp_init_marshal(QmpCommandList *cmds);
 ''',
diff --git a/scripts/qapi-event.py b/scripts/qapi-event.py
index 07b4b70199..9d7134658d 100644
--- a/scripts/qapi-event.py
+++ b/scripts/qapi-event.py
@@ -209,6 +209,7 @@ fdef.write(mcgen('''
 #include "qemu-common.h"
 #include "%(prefix)sqapi-event.h"
 #include "%(prefix)sqapi-visit.h"
+#include "qapi/error.h"
 #include "qapi/qobject-output-visitor.h"
 #include "qapi/qmp-event.h"
=20
@@ -216,7 +217,6 @@ fdef.write(mcgen('''
                  prefix=3Dprefix))
=20
 fdecl.write(mcgen('''
-#include "qapi/error.h"
 #include "qapi/util.h"
 #include "qapi/qmp/qdict.h"
 #include "%(prefix)sqapi-types.h"
diff --git a/stubs/arch-query-cpu-def.c b/stubs/arch-query-cpu-def.c
index cefe4beb82..d436f95314 100644
--- a/stubs/arch-query-cpu-def.c
+++ b/stubs/arch-query-cpu-def.c
@@ -1,6 +1,7 @@
 #include "qemu/osdep.h"
 #include "qemu-common.h"
 #include "sysemu/arch_init.h"
+#include "qapi/error.h"
 #include "qapi/qmp/qerror.h"
=20
 CpuDefinitionInfoList *arch_query_cpu_definitions(Error **errp)
diff --git a/stubs/arch-query-cpu-model-baseline.c b/stubs/arch-query-cpu=
-model-baseline.c
index 094ec13c2c..0d066da328 100644
--- a/stubs/arch-query-cpu-model-baseline.c
+++ b/stubs/arch-query-cpu-model-baseline.c
@@ -1,6 +1,7 @@
 #include "qemu/osdep.h"
 #include "qemu-common.h"
 #include "sysemu/arch_init.h"
+#include "qapi/error.h"
 #include "qapi/qmp/qerror.h"
=20
 CpuModelBaselineInfo *arch_query_cpu_model_baseline(CpuModelInfo *modela=
,
diff --git a/stubs/arch-query-cpu-model-comparison.c b/stubs/arch-query-c=
pu-model-comparison.c
index d5486ae980..8eb311a26c 100644
--- a/stubs/arch-query-cpu-model-comparison.c
+++ b/stubs/arch-query-cpu-model-comparison.c
@@ -1,6 +1,7 @@
 #include "qemu/osdep.h"
 #include "qemu-common.h"
 #include "sysemu/arch_init.h"
+#include "qapi/error.h"
 #include "qapi/qmp/qerror.h"
=20
 CpuModelCompareInfo *arch_query_cpu_model_comparison(CpuModelInfo *model=
a,
diff --git a/stubs/arch-query-cpu-model-expansion.c b/stubs/arch-query-cp=
u-model-expansion.c
index ae7cf554d1..26273a8b10 100644
--- a/stubs/arch-query-cpu-model-expansion.c
+++ b/stubs/arch-query-cpu-model-expansion.c
@@ -1,6 +1,7 @@
 #include "qemu/osdep.h"
 #include "qemu-common.h"
 #include "sysemu/arch_init.h"
+#include "qapi/error.h"
 #include "qapi/qmp/qerror.h"
=20
 CpuModelExpansionInfo *arch_query_cpu_model_expansion(CpuModelExpansionT=
ype type,
diff --git a/stubs/vmgenid.c b/stubs/vmgenid.c
index c64eb7a16e..3c8fe55bdf 100644
--- a/stubs/vmgenid.c
+++ b/stubs/vmgenid.c
@@ -1,5 +1,6 @@
 #include "qemu/osdep.h"
 #include "qmp-commands.h"
+#include "qapi/error.h"
 #include "qapi/qmp/qerror.h"
=20
 GuidInfo *qmp_query_vm_generation_id(Error **errp)
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 050644f820..ae44c9d8ad 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -16,6 +16,7 @@
  * You should have received a copy of the GNU Lesser General Public
  * License along with this library; if not, see <http://www.gnu.org/lice=
nses/>.
  */
+
 #include "qemu/osdep.h"
 #include "qemu/cutils.h"
=20
@@ -29,6 +30,7 @@
 #include "qemu/error-report.h"
 #include "qemu/option.h"
 #include "qemu/config-file.h"
+#include "qapi/error.h"
 #include "qapi/qmp/qerror.h"
 #include "qapi/qmp/types.h"
=20
diff --git a/target/i386/xsave_helper.c b/target/i386/xsave_helper.c
index ca735eee77..52ea7e654b 100644
--- a/target/i386/xsave_helper.c
+++ b/target/i386/xsave_helper.c
@@ -3,7 +3,6 @@
  * See the COPYING file in the top-level directory.
  */
 #include "qemu/osdep.h"
-#include "qapi/error.h"
=20
 #include "qemu-common.h"
 #include "cpu.h"
diff --git a/target/nios2/helper.c b/target/nios2/helper.c
index a169c91eaa..a8b8ec662a 100644
--- a/target/nios2/helper.c
+++ b/target/nios2/helper.c
@@ -22,7 +22,6 @@
=20
 #include "cpu.h"
 #include "qemu/host-utils.h"
-#include "qapi/error.h"
 #include "exec/exec-all.h"
 #include "exec/log.h"
 #include "exec/helper-proto.h"
diff --git a/target/ppc/mmu-book3s-v3.c b/target/ppc/mmu-book3s-v3.c
index e7798b3582..b60df4408f 100644
--- a/target/ppc/mmu-book3s-v3.c
+++ b/target/ppc/mmu-book3s-v3.c
@@ -18,7 +18,6 @@
  */
=20
 #include "qemu/osdep.h"
-#include "qapi/error.h"
 #include "cpu.h"
 #include "mmu-hash64.h"
 #include "mmu-book3s-v3.h"
diff --git a/target/ppc/mmu-hash64.c b/target/ppc/mmu-hash64.c
index 14d34e512f..c9b72b7429 100644
--- a/target/ppc/mmu-hash64.c
+++ b/target/ppc/mmu-hash64.c
@@ -18,7 +18,6 @@
  * License along with this library; if not, see <http://www.gnu.org/lice=
nses/>.
  */
 #include "qemu/osdep.h"
-#include "qapi/error.h"
 #include "cpu.h"
 #include "exec/exec-all.h"
 #include "exec/helper-proto.h"
diff --git a/target/ppc/mmu-radix64.c b/target/ppc/mmu-radix64.c
index bbd37e3c7d..ab76cbc835 100644
--- a/target/ppc/mmu-radix64.c
+++ b/target/ppc/mmu-radix64.c
@@ -18,7 +18,6 @@
  */
=20
 #include "qemu/osdep.h"
-#include "qapi/error.h"
 #include "cpu.h"
 #include "exec/exec-all.h"
 #include "exec/helper-proto.h"
diff --git a/target/ppc/mmu_helper.c b/target/ppc/mmu_helper.c
index 16ef5acaa2..5568d1642b 100644
--- a/target/ppc/mmu_helper.c
+++ b/target/ppc/mmu_helper.c
@@ -17,7 +17,6 @@
  * License along with this library; if not, see <http://www.gnu.org/lice=
nses/>.
  */
 #include "qemu/osdep.h"
-#include "qapi/error.h"
 #include "cpu.h"
 #include "exec/helper-proto.h"
 #include "sysemu/kvm.h"
diff --git a/target/ppc/translate_init.c b/target/ppc/translate_init.c
index 55c99c97e3..2913af912a 100644
--- a/target/ppc/translate_init.c
+++ b/target/ppc/translate_init.c
@@ -29,6 +29,7 @@
 #include "mmu-hash32.h"
 #include "mmu-hash64.h"
 #include "qemu/error-report.h"
+#include "qapi/error.h"
 #include "qapi/visitor.h"
 #include "hw/qdev-properties.h"
 #include "hw/ppc/ppc.h"
diff --git a/target/s390x/excp_helper.c b/target/s390x/excp_helper.c
index e8f7a40c2b..6967fbfa25 100644
--- a/target/s390x/excp_helper.c
+++ b/target/s390x/excp_helper.c
@@ -19,7 +19,6 @@
  */
=20
 #include "qemu/osdep.h"
-#include "qapi/error.h"
 #include "cpu.h"
 #include "internal.h"
 #include "qemu/timer.h"
diff --git a/target/s390x/helper.c b/target/s390x/helper.c
index 35d9741918..84aaef3a53 100644
--- a/target/s390x/helper.c
+++ b/target/s390x/helper.c
@@ -19,7 +19,6 @@
  */
=20
 #include "qemu/osdep.h"
-#include "qapi/error.h"
 #include "cpu.h"
 #include "internal.h"
 #include "exec/gdbstub.h"
diff --git a/target/s390x/kvm.c b/target/s390x/kvm.c
index 8736001156..63c531e028 100644
--- a/target/s390x/kvm.c
+++ b/target/s390x/kvm.c
@@ -31,6 +31,7 @@
 #include "cpu.h"
 #include "internal.h"
 #include "kvm_s390x.h"
+#include "qapi/error.h"
 #include "qemu/error-report.h"
 #include "qemu/timer.h"
 #include "sysemu/sysemu.h"
diff --git a/tests/check-qlist.c b/tests/check-qlist.c
index 894e9915e5..259980d523 100644
--- a/tests/check-qlist.c
+++ b/tests/check-qlist.c
@@ -11,7 +11,6 @@
  */
 #include "qemu/osdep.h"
=20
-#include "qapi/error.h"
 #include "qapi/qmp/qnum.h"
 #include "qapi/qmp/qlist.h"
=20
diff --git a/tests/check-qnum.c b/tests/check-qnum.c
index d702d5da9c..2b667f7ad7 100644
--- a/tests/check-qnum.c
+++ b/tests/check-qnum.c
@@ -15,7 +15,6 @@
 #include "qemu/osdep.h"
=20
 #include "qapi/qmp/qnum.h"
-#include "qapi/error.h"
 #include "qemu-common.h"
=20
 /*
diff --git a/tests/io-channel-helpers.c b/tests/io-channel-helpers.c
index 5430e1389d..ab988ef4fe 100644
--- a/tests/io-channel-helpers.c
+++ b/tests/io-channel-helpers.c
@@ -20,7 +20,6 @@
=20
 #include "qemu/osdep.h"
 #include "io-channel-helpers.h"
-#include "qapi/error.h"
 #include "qemu/iov.h"
=20
 struct QIOChannelTest {
diff --git a/tests/test-aio-multithread.c b/tests/test-aio-multithread.c
index c8bec81520..6440d54ac3 100644
--- a/tests/test-aio-multithread.c
+++ b/tests/test-aio-multithread.c
@@ -12,7 +12,6 @@
=20
 #include "qemu/osdep.h"
 #include "block/aio.h"
-#include "qapi/error.h"
 #include "qemu/coroutine.h"
 #include "qemu/thread.h"
 #include "qemu/error-report.h"
diff --git a/tests/test-qmp-commands.c b/tests/test-qmp-commands.c
index 904c89d4d4..52c1802eaf 100644
--- a/tests/test-qmp-commands.c
+++ b/tests/test-qmp-commands.c
@@ -2,6 +2,7 @@
 #include "qemu-common.h"
 #include "qapi/qmp/types.h"
 #include "test-qmp-commands.h"
+#include "qapi/error.h"
 #include "qapi/qmp/dispatch.h"
 #include "qemu/module.h"
 #include "qapi/qobject-input-visitor.h"
diff --git a/tests/test-qmp-event.c b/tests/test-qmp-event.c
index 46825b4f3f..5be2d8efcf 100644
--- a/tests/test-qmp-event.c
+++ b/tests/test-qmp-event.c
@@ -16,6 +16,7 @@
 #include "qemu-common.h"
 #include "test-qapi-visit.h"
 #include "test-qapi-event.h"
+#include "qapi/error.h"
 #include "qapi/qmp/types.h"
 #include "qapi/qmp/qobject.h"
 #include "qapi/qmp-event.h"
diff --git a/tests/test-x86-cpuid-compat.c b/tests/test-x86-cpuid-compat.=
c
index 58a2dd9fe8..c594b5bd97 100644
--- a/tests/test-x86-cpuid-compat.c
+++ b/tests/test-x86-cpuid-compat.c
@@ -1,6 +1,5 @@
 #include "qemu/osdep.h"
 #include "qemu-common.h"
-#include "qapi/error.h"
 #include "qapi/qmp/qdict.h"
 #include "qapi/qmp/qnum.h"
 #include "qapi/qmp/qbool.h"
diff --git a/tpm.c b/tpm.c
index 61a434185a..d11b10bed8 100644
--- a/tpm.c
+++ b/tpm.c
@@ -11,8 +11,10 @@
  *
  * Based on net.c
  */
+
 #include "qemu/osdep.h"
=20
+#include "qapi/error.h"
 #include "qapi/qmp/qerror.h"
 #include "sysemu/tpm_backend.h"
 #include "sysemu/tpm.h"
diff --git a/trace/qmp.c b/trace/qmp.c
index ac777d154f..ccd35cd840 100644
--- a/trace/qmp.c
+++ b/trace/qmp.c
@@ -8,6 +8,7 @@
  */
=20
 #include "qemu/osdep.h"
+#include "qapi/error.h"
 #include "qmp-commands.h"
 #include "trace/control.h"
=20
diff --git a/ui/console.c b/ui/console.c
index c4c95abed7..f678979f86 100644
--- a/ui/console.c
+++ b/ui/console.c
@@ -21,10 +21,12 @@
  * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALING=
S IN
  * THE SOFTWARE.
  */
+
 #include "qemu/osdep.h"
 #include "qemu-common.h"
 #include "ui/console.h"
 #include "hw/qdev-core.h"
+#include "qapi/error.h"
 #include "qemu/timer.h"
 #include "qmp-commands.h"
 #include "chardev/char-fe.h"
diff --git a/ui/gtk.c b/ui/gtk.c
index f0ad63e431..1537751afa 100644
--- a/ui/gtk.c
+++ b/ui/gtk.c
@@ -36,6 +36,7 @@
=20
 #include "qemu/osdep.h"
 #include "qemu-common.h"
+#include "qapi/error.h"
 #include "qemu/cutils.h"
=20
 #include "ui/console.h"
diff --git a/ui/input.c b/ui/input.c
index ab22c8423f..a5f1cbb3ca 100644
--- a/ui/input.c
+++ b/ui/input.c
@@ -1,5 +1,6 @@
 #include "qemu/osdep.h"
 #include "sysemu/sysemu.h"
+#include "qapi/error.h"
 #include "qemu/error-report.h"
 #include "qmp-commands.h"
 #include "trace.h"
diff --git a/ui/spice-core.c b/ui/spice-core.c
index 2baf0c7120..7a53db070c 100644
--- a/ui/spice-core.c
+++ b/ui/spice-core.c
@@ -30,6 +30,7 @@
 #include "qemu-x509.h"
 #include "qemu/sockets.h"
 #include "qmp-commands.h"
+#include "qapi/error.h"
 #include "qapi/qmp/qbool.h"
 #include "qapi/qmp/qstring.h"
 #include "qapi/qmp/qjson.h"
diff --git a/ui/vnc.c b/ui/vnc.c
index 33b087221f..8768691db8 100644
--- a/ui/vnc.c
+++ b/ui/vnc.c
@@ -34,6 +34,7 @@
 #include "qemu/timer.h"
 #include "qemu/acl.h"
 #include "qemu/config-file.h"
+#include "qapi/error.h"
 #include "qapi/qmp/qerror.h"
 #include "qapi/qmp/types.h"
 #include "qmp-commands.h"
diff --git a/util/qemu-config.c b/util/qemu-config.c
index 029fec53a9..26ea248062 100644
--- a/util/qemu-config.c
+++ b/util/qemu-config.c
@@ -1,4 +1,5 @@
 #include "qemu/osdep.h"
+#include "qapi/error.h"
 #include "qemu-common.h"
 #include "qemu/error-report.h"
 #include "qemu/option.h"
diff --git a/vl.c b/vl.c
index d7e4d97814..3400c7f06c 100644
--- a/vl.c
+++ b/vl.c
@@ -21,7 +21,9 @@
  * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALING=
S IN
  * THE SOFTWARE.
  */
+
 #include "qemu/osdep.h"
+#include "qapi/error.h"
 #include "qemu-version.h"
 #include "qemu/cutils.h"
 #include "qemu/help_option.h"
--=20
2.13.6

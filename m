Received: from eggs.gnu.org ([2001:4830:134:3::10]:38222)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lprosek@redhat.com>) id 1e4T3B-00021h-Jq
	for qemu-devel@nongnu.org; Tue, 17 Oct 2017 10:40:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lprosek@redhat.com>) id 1e4T39-0006mE-DQ
	for qemu-devel@nongnu.org; Tue, 17 Oct 2017 10:40:57 -0400
From: Ladi Prosek <lprosek@redhat.com>
Date: Tue, 17 Oct 2017 16:40:51 +0200
Message-Id: <20171017144051.8452-1-lprosek@redhat.com>
Subject: [Qemu-devel] [PATCH trivial] Remove empty statements
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-trivial@nongnu.org
Cc: lersek@redhat.com

Thanks to Laszlo Ersek for spotting the double semicolon in target/i386/kvm.c

I have trivially grepped the tree for ';;' in C files.

Suggested-by: Laszlo Ersek <lersek@redhat.com>
Signed-off-by: Ladi Prosek <lprosek@redhat.com>
---
 hw/misc/imx6_ccm.c     | 2 +-
 hw/s390x/virtio-ccw.c  | 2 +-
 linux-user/signal.c    | 2 +-
 migration/block.c      | 2 +-
 target/i386/cpu.c      | 2 +-
 target/i386/kvm.c      | 2 +-
 target/sh4/translate.c | 2 +-
 7 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/hw/misc/imx6_ccm.c b/hw/misc/imx6_ccm.c
index 1b421013a3..4fa94835fe 100644
--- a/hw/misc/imx6_ccm.c
+++ b/hw/misc/imx6_ccm.c
@@ -335,7 +335,7 @@ static uint64_t imx6_ccm_get_ipg_clk(IMX6CCMState *dev)
     uint64_t freq = 0;
 
     freq = imx6_ccm_get_ahb_clk(dev)
-           / (1 + EXTRACT(dev->ccm[CCM_CBCDR], IPG_PODF));;
+           / (1 + EXTRACT(dev->ccm[CCM_CBCDR], IPG_PODF));
 
     DPRINTF("freq = %d\n", (uint32_t)freq);
 
diff --git a/hw/s390x/virtio-ccw.c b/hw/s390x/virtio-ccw.c
index 085f17f871..429f10bc90 100644
--- a/hw/s390x/virtio-ccw.c
+++ b/hw/s390x/virtio-ccw.c
@@ -486,7 +486,7 @@ static int virtio_ccw_cb(SubchDev *sch, CCW1 ccw)
         } else {
             address_space_stb(&address_space_memory, ccw.cda, vdev->status,
                                         MEMTXATTRS_UNSPECIFIED, NULL);
-            sch->curr_status.scsw.count = ccw.count - sizeof(vdev->status);;
+            sch->curr_status.scsw.count = ccw.count - sizeof(vdev->status);
             ret = 0;
         }
         break;
diff --git a/linux-user/signal.c b/linux-user/signal.c
index cc0c3fcee9..09055e8920 100644
--- a/linux-user/signal.c
+++ b/linux-user/signal.c
@@ -6487,7 +6487,7 @@ static void setup_rt_frame(int sig, struct target_sigaction *ka,
         haddr = dest;
     }
     env->iaoq_f = haddr;
-    env->iaoq_b = haddr + 4;;
+    env->iaoq_b = haddr + 4;
     return;
 
  give_sigsegv:
diff --git a/migration/block.c b/migration/block.c
index 3282809583..565625b9b2 100644
--- a/migration/block.c
+++ b/migration/block.c
@@ -896,7 +896,7 @@ static int block_load(QEMUFile *f, void *opaque, int version_id)
     int len, flags;
     char device_name[256];
     int64_t addr;
-    BlockBackend *blk, *blk_prev = NULL;;
+    BlockBackend *blk, *blk_prev = NULL;
     Error *local_err = NULL;
     uint8_t *buf;
     int64_t total_sectors = 0;
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 98732cd65f..d44b0ed56c 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -2218,7 +2218,7 @@ static void x86_cpu_class_check_missing_features(X86CPUClass *xcc,
 
     if (xcc->kvm_required && !kvm_enabled()) {
         strList *new = g_new0(strList, 1);
-        new->value = g_strdup("kvm");;
+        new->value = g_strdup("kvm");
         *missing_feats = new;
         return;
     }
diff --git a/target/i386/kvm.c b/target/i386/kvm.c
index b1e32e95d3..d4b2ce2e94 100644
--- a/target/i386/kvm.c
+++ b/target/i386/kvm.c
@@ -1122,7 +1122,7 @@ static int kvm_get_supported_msrs(KVMState *s)
                     break;
                 case MSR_IA32_XSS:
                     has_msr_xss = true;
-                    break;;
+                    break;
                 case HV_X64_MSR_CRASH_CTL:
                     has_msr_hv_crash = true;
                     break;
diff --git a/target/sh4/translate.c b/target/sh4/translate.c
index 8db9fba26e..2b00cd2f35 100644
--- a/target/sh4/translate.c
+++ b/target/sh4/translate.c
@@ -679,7 +679,7 @@ static void _decode_opc(DisasContext * ctx)
 	return;
     case 0x6008:		/* swap.b Rm,Rn */
 	{
-            TCGv low = tcg_temp_new();;
+            TCGv low = tcg_temp_new();
 	    tcg_gen_ext16u_i32(low, REG(B7_4));
 	    tcg_gen_bswap16_i32(low, low);
             tcg_gen_deposit_i32(REG(B11_8), REG(B7_4), low, 0, 16);
-- 
2.13.5

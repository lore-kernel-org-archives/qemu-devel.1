Received: from eggs.gnu.org ([2001:4830:134:3::10]:42049)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1eQgcw-0007Eh-PU
	for qemu-devel@nongnu.org; Sun, 17 Dec 2017 16:37:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1eQgct-000152-MF
	for qemu-devel@nongnu.org; Sun, 17 Dec 2017 16:37:42 -0500
From: Michael Tokarev <mjt@tls.msk.ru>
Date: Mon, 18 Dec 2017 00:27:06 +0300
Message-Id: <320b69994d432ec08fe3cdc6bee10d04514688bb.1513545944.git.mjt@msgid.tls.msk.ru>
In-Reply-To: <cover.1513545944.git.mjt@msgid.tls.msk.ru>
References: <cover.1513545944.git.mjt@msgid.tls.msk.ru>
In-Reply-To: <cover.1513545944.git.mjt@msgid.tls.msk.ru>
References: <cover.1513545944.git.mjt@msgid.tls.msk.ru>
Subject: [Qemu-devel] [PULL 01/61] Remove empty statements
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Ladi Prosek <lprosek@redhat.com>, qemu-trivial@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>

From: Ladi Prosek <lprosek@redhat.com>

Thanks to Laszlo Ersek for spotting the double semicolon in target/i386/kvm.c

I have trivially grepped the tree for ';;' in C files.

Suggested-by: Laszlo Ersek <lersek@redhat.com>
Signed-off-by: Ladi Prosek <lprosek@redhat.com>
Reviewed-by: Laszlo Ersek <lersek@redhat.com>
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
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
index 3dd902a664..38f6a8afc9 100644
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
index cf35473671..dae14d4a89 100644
--- a/linux-user/signal.c
+++ b/linux-user/signal.c
@@ -6530,7 +6530,7 @@ static void setup_rt_frame(int sig, struct target_sigaction *ka,
         haddr = dest;
     }
     env->iaoq_f = haddr;
-    env->iaoq_b = haddr + 4;;
+    env->iaoq_b = haddr + 4;
     return;
 
  give_sigsegv:
diff --git a/migration/block.c b/migration/block.c
index 7147171bb7..e68e090c6f 100644
--- a/migration/block.c
+++ b/migration/block.c
@@ -897,7 +897,7 @@ static int block_load(QEMUFile *f, void *opaque, int version_id)
     int len, flags;
     char device_name[256];
     int64_t addr;
-    BlockBackend *blk, *blk_prev = NULL;;
+    BlockBackend *blk, *blk_prev = NULL;
     Error *local_err = NULL;
     uint8_t *buf;
     int64_t total_sectors = 0;
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 045d66191f..82603e3130 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -2220,7 +2220,7 @@ static void x86_cpu_class_check_missing_features(X86CPUClass *xcc,
 
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
index 703020fe87..8569179883 100644
--- a/target/sh4/translate.c
+++ b/target/sh4/translate.c
@@ -668,7 +668,7 @@ static void _decode_opc(DisasContext * ctx)
 	return;
     case 0x6008:		/* swap.b Rm,Rn */
 	{
-            TCGv low = tcg_temp_new();;
+            TCGv low = tcg_temp_new();
 	    tcg_gen_ext16u_i32(low, REG(B7_4));
 	    tcg_gen_bswap16_i32(low, low);
             tcg_gen_deposit_i32(REG(B11_8), REG(B7_4), low, 0, 16);
-- 
2.11.0

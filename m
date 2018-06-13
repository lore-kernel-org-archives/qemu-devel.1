Received: from eggs.gnu.org ([2001:4830:134:3::10]:56368)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1fT1Sg-00028W-8Q
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 04:49:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1fT1Se-0003r0-FN
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 04:49:02 -0400
From: Eric Auger <eric.auger@redhat.com>
Date: Wed, 13 Jun 2018 10:48:35 +0200
Message-Id: <1528879723-24675-2-git-send-email-eric.auger@redhat.com>
In-Reply-To: <1528879723-24675-1-git-send-email-eric.auger@redhat.com>
References: <1528879723-24675-1-git-send-email-eric.auger@redhat.com>
Subject: [Qemu-devel] [PATCH 1/9] linux-headers: Update to 4.18-rc0
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org, peter.maydell@linaro.org
Cc: drjones@redhat.com, wei@redhat.com, zhaoshenglong@huawei.com, lersek@redhat.com, ard.biesheuvel@linaro.org, christoffer.dall@arm.com, marc.zyngier@arm.com

commit b357bf6023a948cf6a9472f07a1b0caac0e4f8e8
Merge tag 'for-linus' of git://git.kernel.org/pub/scm/virt/kvm/kvm

Signed-off-by: Eric Auger <eric.auger@redhat.com>
---
 include/standard-headers/linux/pci_regs.h            |  8 ++++++++
 include/standard-headers/linux/virtio_gpu.h          |  1 +
 include/standard-headers/linux/virtio_net.h          |  3 +++
 linux-headers/LICENSES/exceptions/Linux-syscall-note |  2 +-
 linux-headers/LICENSES/preferred/GPL-2.0             |  6 ++++++
 linux-headers/asm-arm/kvm.h                          |  1 +
 linux-headers/asm-arm/unistd-common.h                |  1 +
 linux-headers/asm-arm64/kvm.h                        |  1 +
 linux-headers/asm-generic/unistd.h                   |  4 +++-
 linux-headers/asm-powerpc/unistd.h                   |  1 +
 linux-headers/asm-x86/unistd_32.h                    |  2 ++
 linux-headers/asm-x86/unistd_64.h                    |  2 ++
 linux-headers/asm-x86/unistd_x32.h                   |  2 ++
 linux-headers/linux/kvm.h                            |  5 +++--
 linux-headers/linux/psp-sev.h                        | 12 ++++++++++++
 15 files changed, 47 insertions(+), 4 deletions(-)

diff --git a/include/standard-headers/linux/pci_regs.h b/include/standard-headers/linux/pci_regs.h
index 103ba79..4da87e2 100644
--- a/include/standard-headers/linux/pci_regs.h
+++ b/include/standard-headers/linux/pci_regs.h
@@ -506,6 +506,8 @@
 #define  PCI_EXP_DEVCTL_READRQ_256B  0x1000 /* 256 Bytes */
 #define  PCI_EXP_DEVCTL_READRQ_512B  0x2000 /* 512 Bytes */
 #define  PCI_EXP_DEVCTL_READRQ_1024B 0x3000 /* 1024 Bytes */
+#define  PCI_EXP_DEVCTL_READRQ_2048B 0x4000 /* 2048 Bytes */
+#define  PCI_EXP_DEVCTL_READRQ_4096B 0x5000 /* 4096 Bytes */
 #define  PCI_EXP_DEVCTL_BCR_FLR 0x8000  /* Bridge Configuration Retry / FLR */
 #define PCI_EXP_DEVSTA		10	/* Device Status */
 #define  PCI_EXP_DEVSTA_CED	0x0001	/* Correctable Error Detected */
@@ -655,6 +657,11 @@
 #define  PCI_EXP_LNKCAP2_SLS_16_0GB	0x00000010 /* Supported Speed 16GT/s */
 #define  PCI_EXP_LNKCAP2_CROSSLINK	0x00000100 /* Crosslink supported */
 #define PCI_EXP_LNKCTL2		48	/* Link Control 2 */
+#define PCI_EXP_LNKCTL2_TLS		0x000f
+#define PCI_EXP_LNKCTL2_TLS_2_5GT	0x0001 /* Supported Speed 2.5GT/s */
+#define PCI_EXP_LNKCTL2_TLS_5_0GT	0x0002 /* Supported Speed 5GT/s */
+#define PCI_EXP_LNKCTL2_TLS_8_0GT	0x0003 /* Supported Speed 8GT/s */
+#define PCI_EXP_LNKCTL2_TLS_16_0GT	0x0004 /* Supported Speed 16GT/s */
 #define PCI_EXP_LNKSTA2		50	/* Link Status 2 */
 #define PCI_CAP_EXP_ENDPOINT_SIZEOF_V2	52	/* v2 endpoints with link end here */
 #define PCI_EXP_SLTCAP2		52	/* Slot Capabilities 2 */
@@ -981,6 +988,7 @@
 #define  PCI_EXP_DPC_CAP_DL_ACTIVE	0x1000	/* ERR_COR signal on DL_Active supported */
 
 #define PCI_EXP_DPC_CTL			6	/* DPC control */
+#define  PCI_EXP_DPC_CTL_EN_FATAL 	0x0001	/* Enable trigger on ERR_FATAL message */
 #define  PCI_EXP_DPC_CTL_EN_NONFATAL 	0x0002	/* Enable trigger on ERR_NONFATAL message */
 #define  PCI_EXP_DPC_CTL_INT_EN 	0x0008	/* DPC Interrupt Enable */
 
diff --git a/include/standard-headers/linux/virtio_gpu.h b/include/standard-headers/linux/virtio_gpu.h
index c1c8f07..52a830d 100644
--- a/include/standard-headers/linux/virtio_gpu.h
+++ b/include/standard-headers/linux/virtio_gpu.h
@@ -260,6 +260,7 @@ struct virtio_gpu_cmd_submit {
 };
 
 #define VIRTIO_GPU_CAPSET_VIRGL 1
+#define VIRTIO_GPU_CAPSET_VIRGL2 2
 
 /* VIRTIO_GPU_CMD_GET_CAPSET_INFO */
 struct virtio_gpu_get_capset_info {
diff --git a/include/standard-headers/linux/virtio_net.h b/include/standard-headers/linux/virtio_net.h
index e9f255e..260c368 100644
--- a/include/standard-headers/linux/virtio_net.h
+++ b/include/standard-headers/linux/virtio_net.h
@@ -57,6 +57,9 @@
 					 * Steering */
 #define VIRTIO_NET_F_CTRL_MAC_ADDR 23	/* Set MAC address */
 
+#define VIRTIO_NET_F_STANDBY	  62	/* Act as standby for another device
+					 * with the same MAC.
+					 */
 #define VIRTIO_NET_F_SPEED_DUPLEX 63	/* Device set linkspeed and duplex */
 
 #ifndef VIRTIO_NET_NO_LEGACY
diff --git a/linux-headers/LICENSES/exceptions/Linux-syscall-note b/linux-headers/LICENSES/exceptions/Linux-syscall-note
index 6b60b61..9abdad7 100644
--- a/linux-headers/LICENSES/exceptions/Linux-syscall-note
+++ b/linux-headers/LICENSES/exceptions/Linux-syscall-note
@@ -1,6 +1,6 @@
 SPDX-Exception-Identifier: Linux-syscall-note
 SPDX-URL: https://spdx.org/licenses/Linux-syscall-note.html
-SPDX-Licenses: GPL-2.0, GPL-2.0+, GPL-1.0+, LGPL-2.0, LGPL-2.0+, LGPL-2.1, LGPL-2.1+
+SPDX-Licenses: GPL-2.0, GPL-2.0+, GPL-1.0+, LGPL-2.0, LGPL-2.0+, LGPL-2.1, LGPL-2.1+, GPL-2.0-only, GPL-2.0-or-later
 Usage-Guide:
   This exception is used together with one of the above SPDX-Licenses
   to mark user space API (uapi) header files so they can be included
diff --git a/linux-headers/LICENSES/preferred/GPL-2.0 b/linux-headers/LICENSES/preferred/GPL-2.0
index b8db91d..ff0812f 100644
--- a/linux-headers/LICENSES/preferred/GPL-2.0
+++ b/linux-headers/LICENSES/preferred/GPL-2.0
@@ -1,5 +1,7 @@
 Valid-License-Identifier: GPL-2.0
+Valid-License-Identifier: GPL-2.0-only
 Valid-License-Identifier: GPL-2.0+
+Valid-License-Identifier: GPL-2.0-or-later
 SPDX-URL: https://spdx.org/licenses/GPL-2.0.html
 Usage-Guide:
   To use this license in source code, put one of the following SPDX
@@ -7,8 +9,12 @@ Usage-Guide:
   guidelines in the licensing rules documentation.
   For 'GNU General Public License (GPL) version 2 only' use:
     SPDX-License-Identifier: GPL-2.0
+  or
+    SPDX-License-Identifier: GPL-2.0-only
   For 'GNU General Public License (GPL) version 2 or any later version' use:
     SPDX-License-Identifier: GPL-2.0+
+  or
+    SPDX-License-Identifier: GPL-2.0-or-later
 License-Text:
 
 		    GNU GENERAL PUBLIC LICENSE
diff --git a/linux-headers/asm-arm/kvm.h b/linux-headers/asm-arm/kvm.h
index 670b43c..72aa226 100644
--- a/linux-headers/asm-arm/kvm.h
+++ b/linux-headers/asm-arm/kvm.h
@@ -91,6 +91,7 @@ struct kvm_regs {
 #define KVM_VGIC_V3_ADDR_TYPE_DIST	2
 #define KVM_VGIC_V3_ADDR_TYPE_REDIST	3
 #define KVM_VGIC_ITS_ADDR_TYPE		4
+#define KVM_VGIC_V3_ADDR_TYPE_REDIST_REGION	5
 
 #define KVM_VGIC_V3_DIST_SIZE		SZ_64K
 #define KVM_VGIC_V3_REDIST_SIZE		(2 * SZ_64K)
diff --git a/linux-headers/asm-arm/unistd-common.h b/linux-headers/asm-arm/unistd-common.h
index 8d5ceae..60c2d93 100644
--- a/linux-headers/asm-arm/unistd-common.h
+++ b/linux-headers/asm-arm/unistd-common.h
@@ -354,5 +354,6 @@
 #define __NR_pkey_alloc (__NR_SYSCALL_BASE + 395)
 #define __NR_pkey_free (__NR_SYSCALL_BASE + 396)
 #define __NR_statx (__NR_SYSCALL_BASE + 397)
+#define __NR_rseq (__NR_SYSCALL_BASE + 398)
 
 #endif /* _ASM_ARM_UNISTD_COMMON_H */
diff --git a/linux-headers/asm-arm64/kvm.h b/linux-headers/asm-arm64/kvm.h
index 17315ab..99cb9ad 100644
--- a/linux-headers/asm-arm64/kvm.h
+++ b/linux-headers/asm-arm64/kvm.h
@@ -91,6 +91,7 @@ struct kvm_regs {
 #define KVM_VGIC_V3_ADDR_TYPE_DIST	2
 #define KVM_VGIC_V3_ADDR_TYPE_REDIST	3
 #define KVM_VGIC_ITS_ADDR_TYPE		4
+#define KVM_VGIC_V3_ADDR_TYPE_REDIST_REGION	5
 
 #define KVM_VGIC_V3_DIST_SIZE		SZ_64K
 #define KVM_VGIC_V3_REDIST_SIZE		(2 * SZ_64K)
diff --git a/linux-headers/asm-generic/unistd.h b/linux-headers/asm-generic/unistd.h
index 8bcb186..4299067 100644
--- a/linux-headers/asm-generic/unistd.h
+++ b/linux-headers/asm-generic/unistd.h
@@ -732,9 +732,11 @@ __SYSCALL(__NR_pkey_alloc,    sys_pkey_alloc)
 __SYSCALL(__NR_pkey_free,     sys_pkey_free)
 #define __NR_statx 291
 __SYSCALL(__NR_statx,     sys_statx)
+#define __NR_io_pgetevents 292
+__SC_COMP(__NR_io_pgetevents, sys_io_pgetevents, compat_sys_io_pgetevents)
 
 #undef __NR_syscalls
-#define __NR_syscalls 292
+#define __NR_syscalls 293
 
 /*
  * 32 bit systems traditionally used different
diff --git a/linux-headers/asm-powerpc/unistd.h b/linux-headers/asm-powerpc/unistd.h
index 0c08edc..3629858 100644
--- a/linux-headers/asm-powerpc/unistd.h
+++ b/linux-headers/asm-powerpc/unistd.h
@@ -398,5 +398,6 @@
 #define __NR_pkey_alloc		384
 #define __NR_pkey_free		385
 #define __NR_pkey_mprotect	386
+#define __NR_rseq		387
 
 #endif /* _ASM_POWERPC_UNISTD_H_ */
diff --git a/linux-headers/asm-x86/unistd_32.h b/linux-headers/asm-x86/unistd_32.h
index 8a206df..c1b30a0 100644
--- a/linux-headers/asm-x86/unistd_32.h
+++ b/linux-headers/asm-x86/unistd_32.h
@@ -382,5 +382,7 @@
 #define __NR_pkey_free 382
 #define __NR_statx 383
 #define __NR_arch_prctl 384
+#define __NR_io_pgetevents 385
+#define __NR_rseq 386
 
 #endif /* _ASM_X86_UNISTD_32_H */
diff --git a/linux-headers/asm-x86/unistd_64.h b/linux-headers/asm-x86/unistd_64.h
index 336c2e4..c2e464c1 100644
--- a/linux-headers/asm-x86/unistd_64.h
+++ b/linux-headers/asm-x86/unistd_64.h
@@ -334,5 +334,7 @@
 #define __NR_pkey_alloc 330
 #define __NR_pkey_free 331
 #define __NR_statx 332
+#define __NR_io_pgetevents 333
+#define __NR_rseq 334
 
 #endif /* _ASM_X86_UNISTD_64_H */
diff --git a/linux-headers/asm-x86/unistd_x32.h b/linux-headers/asm-x86/unistd_x32.h
index cb98a52..3722902 100644
--- a/linux-headers/asm-x86/unistd_x32.h
+++ b/linux-headers/asm-x86/unistd_x32.h
@@ -287,6 +287,8 @@
 #define __NR_pkey_alloc (__X32_SYSCALL_BIT + 330)
 #define __NR_pkey_free (__X32_SYSCALL_BIT + 331)
 #define __NR_statx (__X32_SYSCALL_BIT + 332)
+#define __NR_io_pgetevents (__X32_SYSCALL_BIT + 333)
+#define __NR_rseq (__X32_SYSCALL_BIT + 334)
 #define __NR_rt_sigaction (__X32_SYSCALL_BIT + 512)
 #define __NR_rt_sigreturn (__X32_SYSCALL_BIT + 513)
 #define __NR_ioctl (__X32_SYSCALL_BIT + 514)
diff --git a/linux-headers/linux/kvm.h b/linux-headers/linux/kvm.h
index cdb148e..98f389a 100644
--- a/linux-headers/linux/kvm.h
+++ b/linux-headers/linux/kvm.h
@@ -677,10 +677,10 @@ struct kvm_ioeventfd {
 };
 
 #define KVM_X86_DISABLE_EXITS_MWAIT          (1 << 0)
-#define KVM_X86_DISABLE_EXITS_HTL            (1 << 1)
+#define KVM_X86_DISABLE_EXITS_HLT            (1 << 1)
 #define KVM_X86_DISABLE_EXITS_PAUSE          (1 << 2)
 #define KVM_X86_DISABLE_VALID_EXITS          (KVM_X86_DISABLE_EXITS_MWAIT | \
-                                              KVM_X86_DISABLE_EXITS_HTL | \
+                                              KVM_X86_DISABLE_EXITS_HLT | \
                                               KVM_X86_DISABLE_EXITS_PAUSE)
 
 /* for KVM_ENABLE_CAP */
@@ -948,6 +948,7 @@ struct kvm_ppc_resize_hpt {
 #define KVM_CAP_S390_BPB 152
 #define KVM_CAP_GET_MSR_FEATURES 153
 #define KVM_CAP_HYPERV_EVENTFD 154
+#define KVM_CAP_HYPERV_TLBFLUSH 155
 
 #ifdef KVM_CAP_IRQ_ROUTING
 
diff --git a/linux-headers/linux/psp-sev.h b/linux-headers/linux/psp-sev.h
index 33e2474..b7b933f 100644
--- a/linux-headers/linux/psp-sev.h
+++ b/linux-headers/linux/psp-sev.h
@@ -30,6 +30,7 @@ enum {
 	SEV_PDH_GEN,
 	SEV_PDH_CERT_EXPORT,
 	SEV_PEK_CERT_IMPORT,
+	SEV_GET_ID,
 
 	SEV_MAX,
 };
@@ -124,6 +125,17 @@ struct sev_user_data_pdh_cert_export {
 } __attribute__((packed));
 
 /**
+ * struct sev_user_data_get_id - GET_ID command parameters
+ *
+ * @socket1: Buffer to pass unique ID of first socket
+ * @socket2: Buffer to pass unique ID of second socket
+ */
+struct sev_user_data_get_id {
+	__u8 socket1[64];			/* Out */
+	__u8 socket2[64];			/* Out */
+} __attribute__((packed));
+
+/**
  * struct sev_issue_cmd - SEV ioctl parameters
  *
  * @cmd: SEV commands to execute
-- 
2.5.5

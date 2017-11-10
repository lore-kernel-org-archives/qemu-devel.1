Received: from eggs.gnu.org ([2001:4830:134:3::10]:55257)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <gengdongjiu@huawei.com>) id 1eD7HR-0001q9-MC
	for qemu-devel@nongnu.org; Fri, 10 Nov 2017 06:15:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <gengdongjiu@huawei.com>) id 1eD7HP-0001AI-5O
	for qemu-devel@nongnu.org; Fri, 10 Nov 2017 06:15:25 -0500
From: Dongjiu Geng <gengdongjiu@huawei.com>
Date: Sat, 11 Nov 2017 03:19:44 +0800
Message-ID: <1510341591-22817-6-git-send-email-gengdongjiu@huawei.com>
In-Reply-To: <1510341591-22817-1-git-send-email-gengdongjiu@huawei.com>
References: <1510341591-22817-1-git-send-email-gengdongjiu@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v12 05/12] linux-headers: sync against Linux
 v4.14-rc8
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: pbonzini@redhat.com, mst@redhat.com, imammedo@redhat.com, zhaoshenglong@huawei.com, peter.maydell@linaro.org, mtosatti@redhat.com, james.morse@arm.com, lersek@redhat.com, marc.zyngier@arm.com, christoffer.dall@linaro.org, rth@twiddle.net, ehabkost@redhat.com, kvm@vger.kernel.org, guohanjun@huawei.com, lijinyue@huawei.com, huangshaoyu@huawei.com, wuquanming@huawei.com, zhengqiang10@huawei.com, linuxarm@huawei.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org

Signed-off-by: Dongjiu Geng <gengdongjiu@huawei.com>

---
Suggested by here:
https://lkml.org/lkml/2017/9/5/575

---
 include/standard-headers/asm-s390/kvm_virtio.h     | 1 +
 include/standard-headers/asm-s390/virtio-ccw.h     | 1 +
 include/standard-headers/asm-x86/hyperv.h          | 1 +
 include/standard-headers/linux/input-event-codes.h | 1 +
 include/standard-headers/linux/input.h             | 1 +
 include/standard-headers/linux/pci_regs.h          | 1 +
 linux-headers/asm-arm/kvm.h                        | 1 +
 linux-headers/asm-arm/kvm_para.h                   | 1 +
 linux-headers/asm-arm/unistd.h                     | 1 +
 linux-headers/asm-arm64/kvm.h                      | 1 +
 linux-headers/asm-arm64/unistd.h                   | 1 +
 linux-headers/asm-powerpc/epapr_hcalls.h           | 1 +
 linux-headers/asm-powerpc/kvm.h                    | 1 +
 linux-headers/asm-powerpc/kvm_para.h               | 1 +
 linux-headers/asm-powerpc/unistd.h                 | 1 +
 linux-headers/asm-s390/kvm.h                       | 1 +
 linux-headers/asm-s390/kvm_para.h                  | 1 +
 linux-headers/asm-s390/unistd.h                    | 1 +
 linux-headers/asm-x86/kvm.h                        | 1 +
 linux-headers/asm-x86/kvm_para.h                   | 1 +
 linux-headers/asm-x86/unistd.h                     | 1 +
 linux-headers/linux/kvm.h                          | 4 ++++
 linux-headers/linux/kvm_para.h                     | 1 +
 linux-headers/linux/psci.h                         | 1 +
 linux-headers/linux/userfaultfd.h                  | 1 +
 linux-headers/linux/vfio.h                         | 1 +
 linux-headers/linux/vfio_ccw.h                     | 1 +
 linux-headers/linux/vhost.h                        | 1 +
 28 files changed, 31 insertions(+)

diff --git a/include/standard-headers/asm-s390/kvm_virtio.h b/include/standard-headers/asm-s390/kvm_virtio.h
index daad324..4af18ca 100644
--- a/include/standard-headers/asm-s390/kvm_virtio.h
+++ b/include/standard-headers/asm-s390/kvm_virtio.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
 /*
  * definition for virtio for kvm on s390
  *
diff --git a/include/standard-headers/asm-s390/virtio-ccw.h b/include/standard-headers/asm-s390/virtio-ccw.h
index a9a4ebf..967aad3 100644
--- a/include/standard-headers/asm-s390/virtio-ccw.h
+++ b/include/standard-headers/asm-s390/virtio-ccw.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
 /*
  * Definitions for virtio-ccw devices.
  *
diff --git a/include/standard-headers/asm-x86/hyperv.h b/include/standard-headers/asm-x86/hyperv.h
index fac7651..2c8a3ff 100644
--- a/include/standard-headers/asm-x86/hyperv.h
+++ b/include/standard-headers/asm-x86/hyperv.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
 #ifndef _ASM_X86_HYPERV_H
 #define _ASM_X86_HYPERV_H
 
diff --git a/include/standard-headers/linux/input-event-codes.h b/include/standard-headers/linux/input-event-codes.h
index 2fa0f4e..7cc0fcb 100644
--- a/include/standard-headers/linux/input-event-codes.h
+++ b/include/standard-headers/linux/input-event-codes.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
 /*
  * Input event codes
  *
diff --git a/include/standard-headers/linux/input.h b/include/standard-headers/linux/input.h
index 666e201..bc3e6d3 100644
--- a/include/standard-headers/linux/input.h
+++ b/include/standard-headers/linux/input.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
 /*
  * Copyright (c) 1999-2002 Vojtech Pavlik
  *
diff --git a/include/standard-headers/linux/pci_regs.h b/include/standard-headers/linux/pci_regs.h
index c22d3eb..92500c3 100644
--- a/include/standard-headers/linux/pci_regs.h
+++ b/include/standard-headers/linux/pci_regs.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
 /*
  *	pci_regs.h
  *
diff --git a/linux-headers/asm-arm/kvm.h b/linux-headers/asm-arm/kvm.h
index fa9fae8..17ffa87 100644
--- a/linux-headers/asm-arm/kvm.h
+++ b/linux-headers/asm-arm/kvm.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
 /*
  * Copyright (C) 2012 - Virtual Open Systems and Columbia University
  * Author: Christoffer Dall <c.dall@virtualopensystems.com>
diff --git a/linux-headers/asm-arm/kvm_para.h b/linux-headers/asm-arm/kvm_para.h
index 14fab8f..baacc49 100644
--- a/linux-headers/asm-arm/kvm_para.h
+++ b/linux-headers/asm-arm/kvm_para.h
@@ -1 +1,2 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
 #include <asm-generic/kvm_para.h>
diff --git a/linux-headers/asm-arm/unistd.h b/linux-headers/asm-arm/unistd.h
index 155571b..8ee6d25 100644
--- a/linux-headers/asm-arm/unistd.h
+++ b/linux-headers/asm-arm/unistd.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
 /*
  *  arch/arm/include/asm/unistd.h
  *
diff --git a/linux-headers/asm-arm64/kvm.h b/linux-headers/asm-arm64/kvm.h
index d254700..2c79c6f 100644
--- a/linux-headers/asm-arm64/kvm.h
+++ b/linux-headers/asm-arm64/kvm.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
 /*
  * Copyright (C) 2012,2013 - ARM Ltd
  * Author: Marc Zyngier <marc.zyngier@arm.com>
diff --git a/linux-headers/asm-arm64/unistd.h b/linux-headers/asm-arm64/unistd.h
index 043d17a..5072cbd 100644
--- a/linux-headers/asm-arm64/unistd.h
+++ b/linux-headers/asm-arm64/unistd.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
 /*
  * Copyright (C) 2012 ARM Ltd.
  *
diff --git a/linux-headers/asm-powerpc/epapr_hcalls.h b/linux-headers/asm-powerpc/epapr_hcalls.h
index 33b3f89..6cca559 100644
--- a/linux-headers/asm-powerpc/epapr_hcalls.h
+++ b/linux-headers/asm-powerpc/epapr_hcalls.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: ((GPL-2.0+ WITH Linux-syscall-note) OR BSD-3-Clause) */
 /*
  * ePAPR hcall interface
  *
diff --git a/linux-headers/asm-powerpc/kvm.h b/linux-headers/asm-powerpc/kvm.h
index 8cf8f0c..61d6049 100644
--- a/linux-headers/asm-powerpc/kvm.h
+++ b/linux-headers/asm-powerpc/kvm.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
 /*
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License, version 2, as
diff --git a/linux-headers/asm-powerpc/kvm_para.h b/linux-headers/asm-powerpc/kvm_para.h
index 2abcc46..9beb49c 100644
--- a/linux-headers/asm-powerpc/kvm_para.h
+++ b/linux-headers/asm-powerpc/kvm_para.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
 /*
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License, version 2, as
diff --git a/linux-headers/asm-powerpc/unistd.h b/linux-headers/asm-powerpc/unistd.h
index a178634..36abf58 100644
--- a/linux-headers/asm-powerpc/unistd.h
+++ b/linux-headers/asm-powerpc/unistd.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0+ WITH Linux-syscall-note */
 /*
  * This file contains the system call numbers.
  *
diff --git a/linux-headers/asm-s390/kvm.h b/linux-headers/asm-s390/kvm.h
index 8387d71..a0ed5b7 100644
--- a/linux-headers/asm-s390/kvm.h
+++ b/linux-headers/asm-s390/kvm.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
 #ifndef __LINUX_KVM_S390_H
 #define __LINUX_KVM_S390_H
 /*
diff --git a/linux-headers/asm-s390/kvm_para.h b/linux-headers/asm-s390/kvm_para.h
index ff1f4e7..0dc86b3 100644
--- a/linux-headers/asm-s390/kvm_para.h
+++ b/linux-headers/asm-s390/kvm_para.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
 /*
  * User API definitions for paravirtual devices on s390
  *
diff --git a/linux-headers/asm-s390/unistd.h b/linux-headers/asm-s390/unistd.h
index 65e7e59..4deb1fe 100644
--- a/linux-headers/asm-s390/unistd.h
+++ b/linux-headers/asm-s390/unistd.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
 /*
  *  S390 version
  *
diff --git a/linux-headers/asm-x86/kvm.h b/linux-headers/asm-x86/kvm.h
index c2824d0..f3a9604 100644
--- a/linux-headers/asm-x86/kvm.h
+++ b/linux-headers/asm-x86/kvm.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
 #ifndef _ASM_X86_KVM_H
 #define _ASM_X86_KVM_H
 
diff --git a/linux-headers/asm-x86/kvm_para.h b/linux-headers/asm-x86/kvm_para.h
index cefa127..ba3d11e 100644
--- a/linux-headers/asm-x86/kvm_para.h
+++ b/linux-headers/asm-x86/kvm_para.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
 #ifndef _ASM_X86_KVM_PARA_H
 #define _ASM_X86_KVM_PARA_H
 
diff --git a/linux-headers/asm-x86/unistd.h b/linux-headers/asm-x86/unistd.h
index 1f99b12..c04f638 100644
--- a/linux-headers/asm-x86/unistd.h
+++ b/linux-headers/asm-x86/unistd.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
 #ifndef _ASM_X86_UNISTD_H
 #define _ASM_X86_UNISTD_H
 
diff --git a/linux-headers/linux/kvm.h b/linux-headers/linux/kvm.h
index 7971a4f..0d6d52c 100644
--- a/linux-headers/linux/kvm.h
+++ b/linux-headers/linux/kvm.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
 #ifndef __LINUX_KVM_H
 #define __LINUX_KVM_H
 
@@ -929,6 +930,7 @@ struct kvm_ppc_resize_hpt {
 #define KVM_CAP_PPC_SMT_POSSIBLE 147
 #define KVM_CAP_HYPERV_SYNIC2 148
 #define KVM_CAP_HYPERV_VP_INDEX 149
+#define KVM_CAP_ARM_INJECT_SERROR_ESR 150
 
 #ifdef KVM_CAP_IRQ_ROUTING
 
@@ -1355,6 +1357,8 @@ struct kvm_s390_ucas_mapping {
 /* Available with KVM_CAP_S390_CMMA_MIGRATION */
 #define KVM_S390_GET_CMMA_BITS      _IOWR(KVMIO, 0xb8, struct kvm_s390_cmma_log)
 #define KVM_S390_SET_CMMA_BITS      _IOW(KVMIO, 0xb9, struct kvm_s390_cmma_log)
+/* Available with KVM_CAP_ARM_INJECT_SERROR_ESR */
+#define KVM_ARM_INJECT_SERROR_ESR       _IOW(KVMIO,  0xba, __u32)
 
 #define KVM_DEV_ASSIGN_ENABLE_IOMMU	(1 << 0)
 #define KVM_DEV_ASSIGN_PCI_2_3		(1 << 1)
diff --git a/linux-headers/linux/kvm_para.h b/linux-headers/linux/kvm_para.h
index 15b24ff..8bcd0aa 100644
--- a/linux-headers/linux/kvm_para.h
+++ b/linux-headers/linux/kvm_para.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
 #ifndef __LINUX_KVM_PARA_H
 #define __LINUX_KVM_PARA_H
 
diff --git a/linux-headers/linux/psci.h b/linux-headers/linux/psci.h
index 08d443f..ccd1773 100644
--- a/linux-headers/linux/psci.h
+++ b/linux-headers/linux/psci.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
 /*
  * ARM Power State and Coordination Interface (PSCI) header
  *
diff --git a/linux-headers/linux/userfaultfd.h b/linux-headers/linux/userfaultfd.h
index 9701772..f7fd160 100644
--- a/linux-headers/linux/userfaultfd.h
+++ b/linux-headers/linux/userfaultfd.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
 /*
  *  include/linux/userfaultfd.h
  *
diff --git a/linux-headers/linux/vfio.h b/linux-headers/linux/vfio.h
index 4e7ab4c..4312e96 100644
--- a/linux-headers/linux/vfio.h
+++ b/linux-headers/linux/vfio.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
 /*
  * VFIO API definition
  *
diff --git a/linux-headers/linux/vfio_ccw.h b/linux-headers/linux/vfio_ccw.h
index 3a56551..5bf96c3 100644
--- a/linux-headers/linux/vfio_ccw.h
+++ b/linux-headers/linux/vfio_ccw.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
 /*
  * Interfaces for vfio-ccw
  *
diff --git a/linux-headers/linux/vhost.h b/linux-headers/linux/vhost.h
index 1e86a3d..e336395 100644
--- a/linux-headers/linux/vhost.h
+++ b/linux-headers/linux/vhost.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
 #ifndef _LINUX_VHOST_H
 #define _LINUX_VHOST_H
 /* Userspace interface for in-kernel virtio accelerators. */
-- 
1.8.3.1

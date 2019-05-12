Return-Path: <SRS0=55mG=TM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B5FDC04A6B
	for <qemu-devel@archiver.kernel.org>; Sun, 12 May 2019 08:50:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E38182146F
	for <qemu-devel@archiver.kernel.org>; Sun, 12 May 2019 08:50:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E38182146F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:40640 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hPkBM-0005NG-7s
	for qemu-devel@archiver.kernel.org; Sun, 12 May 2019 04:50:08 -0400
Received: from eggs.gnu.org ([209.51.188.92]:38528)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <drjones@redhat.com>) id 1hPjza-0004NP-2e
	for qemu-devel@nongnu.org; Sun, 12 May 2019 04:37:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <drjones@redhat.com>) id 1hPjzY-0003pQ-Cr
	for qemu-devel@nongnu.org; Sun, 12 May 2019 04:37:57 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58296)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <drjones@redhat.com>)
	id 1hPjyR-0003IX-RN; Sun, 12 May 2019 04:37:49 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 23A4C3086201;
	Sun, 12 May 2019 08:36:47 +0000 (UTC)
Received: from kamzik.brq.redhat.com (ovpn-116-87.ams2.redhat.com
	[10.36.116.87])
	by smtp.corp.redhat.com (Postfix) with ESMTP id A0D535D706;
	Sun, 12 May 2019 08:36:43 +0000 (UTC)
From: Andrew Jones <drjones@redhat.com>
To: qemu-devel@nongnu.org,
	qemu-arm@nongnu.org
Date: Sun, 12 May 2019 10:36:14 +0200
Message-Id: <20190512083624.8916-4-drjones@redhat.com>
In-Reply-To: <20190512083624.8916-1-drjones@redhat.com>
References: <20190512083624.8916-1-drjones@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.42]);
	Sun, 12 May 2019 08:36:47 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH 03/13] HACK: linux header update
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: peter.maydell@linaro.org, richard.henderson@linaro.org, armbru@redhat.com,
	abologna@redhat.com, alex.bennee@linaro.org, Dave.Martin@arm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

---
 linux-headers/asm-arm64/kvm.h         | 41 +++++++++++++++++++++
 linux-headers/asm-arm64/sve_context.h | 53 +++++++++++++++++++++++++++
 linux-headers/linux/kvm.h             |  5 +++
 3 files changed, 99 insertions(+)
 create mode 100644 linux-headers/asm-arm64/sve_context.h

diff --git a/linux-headers/asm-arm64/kvm.h b/linux-headers/asm-arm64/kvm.=
h
index e6a98c14c848..3e73a4c67b67 100644
--- a/linux-headers/asm-arm64/kvm.h
+++ b/linux-headers/asm-arm64/kvm.h
@@ -35,6 +35,7 @@
 #include <linux/psci.h>
 #include <linux/types.h>
 #include <asm/ptrace.h>
+#include <asm/sve_context.h>
=20
 #define __KVM_HAVE_GUEST_DEBUG
 #define __KVM_HAVE_IRQ_LINE
@@ -102,6 +103,7 @@ struct kvm_regs {
 #define KVM_ARM_VCPU_EL1_32BIT		1 /* CPU running a 32bit VM */
 #define KVM_ARM_VCPU_PSCI_0_2		2 /* CPU uses PSCI v0.2 */
 #define KVM_ARM_VCPU_PMU_V3		3 /* Support guest PMUv3 */
+#define KVM_ARM_VCPU_SVE		4 /* enable SVE for this CPU */
=20
 struct kvm_vcpu_init {
 	__u32 target;
@@ -226,6 +228,45 @@ struct kvm_vcpu_events {
 					 KVM_REG_ARM_FW | ((r) & 0xffff))
 #define KVM_REG_ARM_PSCI_VERSION	KVM_REG_ARM_FW_REG(0)
=20
+/* SVE registers */
+#define KVM_REG_ARM64_SVE		(0x15 << KVM_REG_ARM_COPROC_SHIFT)
+
+/* Z- and P-regs occupy blocks at the following offsets within this rang=
e: */
+#define KVM_REG_ARM64_SVE_ZREG_BASE	0
+#define KVM_REG_ARM64_SVE_PREG_BASE	0x400
+#define KVM_REG_ARM64_SVE_FFR_BASE	0x600
+
+#define KVM_ARM64_SVE_NUM_ZREGS		__SVE_NUM_ZREGS
+#define KVM_ARM64_SVE_NUM_PREGS		__SVE_NUM_PREGS
+
+#define KVM_ARM64_SVE_MAX_SLICES	32
+
+#define KVM_REG_ARM64_SVE_ZREG(n, i)					\
+	(KVM_REG_ARM64 | KVM_REG_ARM64_SVE | KVM_REG_ARM64_SVE_ZREG_BASE | \
+	 KVM_REG_SIZE_U2048 |						\
+	 (((n) & (KVM_ARM64_SVE_NUM_ZREGS - 1)) << 5) |			\
+	 ((i) & (KVM_ARM64_SVE_MAX_SLICES - 1)))
+
+#define KVM_REG_ARM64_SVE_PREG(n, i)					\
+	(KVM_REG_ARM64 | KVM_REG_ARM64_SVE | KVM_REG_ARM64_SVE_PREG_BASE | \
+	 KVM_REG_SIZE_U256 |						\
+	 (((n) & (KVM_ARM64_SVE_NUM_PREGS - 1)) << 5) |			\
+	 ((i) & (KVM_ARM64_SVE_MAX_SLICES - 1)))
+
+#define KVM_REG_ARM64_SVE_FFR(i)					\
+	(KVM_REG_ARM64 | KVM_REG_ARM64_SVE | KVM_REG_ARM64_SVE_FFR_BASE | \
+	 KVM_REG_SIZE_U256 |						\
+	 ((i) & (KVM_ARM64_SVE_MAX_SLICES - 1)))
+
+#define KVM_ARM64_SVE_VQ_MIN __SVE_VQ_MIN
+#define KVM_ARM64_SVE_VQ_MAX __SVE_VQ_MAX
+
+/* Vector lengths pseudo-register: */
+#define KVM_REG_ARM64_SVE_VLS		(KVM_REG_ARM64 | KVM_REG_ARM64_SVE | \
+					 KVM_REG_SIZE_U512 | 0xffff)
+#define KVM_ARM64_SVE_VLS_WORDS	\
+	((KVM_ARM64_SVE_VQ_MAX - KVM_ARM64_SVE_VQ_MIN) / 64 + 1)
+
 /* Device Control API: ARM VGIC */
 #define KVM_DEV_ARM_VGIC_GRP_ADDR	0
 #define KVM_DEV_ARM_VGIC_GRP_DIST_REGS	1
diff --git a/linux-headers/asm-arm64/sve_context.h b/linux-headers/asm-ar=
m64/sve_context.h
new file mode 100644
index 000000000000..1d0e3e1d0950
--- /dev/null
+++ b/linux-headers/asm-arm64/sve_context.h
@@ -0,0 +1,53 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+/* Copyright (C) 2017-2018 ARM Limited */
+
+/*
+ * For use by other UAPI headers only.
+ * Do not make direct use of header or its definitions.
+ */
+
+#ifndef __ASM_SVE_CONTEXT_H
+#define __ASM_SVE_CONTEXT_H
+
+#include <linux/types.h>
+
+#define __SVE_VQ_BYTES		16	/* number of bytes per quadword */
+
+#define __SVE_VQ_MIN		1
+#define __SVE_VQ_MAX		512
+
+#define __SVE_VL_MIN		(__SVE_VQ_MIN * __SVE_VQ_BYTES)
+#define __SVE_VL_MAX		(__SVE_VQ_MAX * __SVE_VQ_BYTES)
+
+#define __SVE_NUM_ZREGS		32
+#define __SVE_NUM_PREGS		16
+
+#define __sve_vl_valid(vl)			\
+	((vl) % __SVE_VQ_BYTES =3D=3D 0 &&		\
+	 (vl) >=3D __SVE_VL_MIN &&		\
+	 (vl) <=3D __SVE_VL_MAX)
+
+#define __sve_vq_from_vl(vl)	((vl) / __SVE_VQ_BYTES)
+#define __sve_vl_from_vq(vq)	((vq) * __SVE_VQ_BYTES)
+
+#define __SVE_ZREG_SIZE(vq)	((__u32)(vq) * __SVE_VQ_BYTES)
+#define __SVE_PREG_SIZE(vq)	((__u32)(vq) * (__SVE_VQ_BYTES / 8))
+#define __SVE_FFR_SIZE(vq)	__SVE_PREG_SIZE(vq)
+
+#define __SVE_ZREGS_OFFSET	0
+#define __SVE_ZREG_OFFSET(vq, n) \
+	(__SVE_ZREGS_OFFSET + __SVE_ZREG_SIZE(vq) * (n))
+#define __SVE_ZREGS_SIZE(vq) \
+	(__SVE_ZREG_OFFSET(vq, __SVE_NUM_ZREGS) - __SVE_ZREGS_OFFSET)
+
+#define __SVE_PREGS_OFFSET(vq) \
+	(__SVE_ZREGS_OFFSET + __SVE_ZREGS_SIZE(vq))
+#define __SVE_PREG_OFFSET(vq, n) \
+	(__SVE_PREGS_OFFSET(vq) + __SVE_PREG_SIZE(vq) * (n))
+#define __SVE_PREGS_SIZE(vq) \
+	(__SVE_PREG_OFFSET(vq, __SVE_NUM_PREGS) - __SVE_PREGS_OFFSET(vq))
+
+#define __SVE_FFR_OFFSET(vq) \
+	(__SVE_PREGS_OFFSET(vq) + __SVE_PREGS_SIZE(vq))
+
+#endif /* ! _UAPI__ASM_SVE_CONTEXT_H */
diff --git a/linux-headers/linux/kvm.h b/linux-headers/linux/kvm.h
index b53ee5974802..1a639ae0ceed 100644
--- a/linux-headers/linux/kvm.h
+++ b/linux-headers/linux/kvm.h
@@ -988,6 +988,7 @@ struct kvm_ppc_resize_hpt {
 #define KVM_CAP_ARM_VM_IPA_SIZE 165
 #define KVM_CAP_MANUAL_DIRTY_LOG_PROTECT 166
 #define KVM_CAP_HYPERV_CPUID 167
+#define KVM_CAP_ARM_SVE 168
=20
 #ifdef KVM_CAP_IRQ_ROUTING
=20
@@ -1145,6 +1146,7 @@ struct kvm_dirty_tlb {
 #define KVM_REG_SIZE_U256	0x0050000000000000ULL
 #define KVM_REG_SIZE_U512	0x0060000000000000ULL
 #define KVM_REG_SIZE_U1024	0x0070000000000000ULL
+#define KVM_REG_SIZE_U2048	0x0080000000000000ULL
=20
 struct kvm_reg_list {
 	__u64 n; /* number of regs */
@@ -1440,6 +1442,9 @@ struct kvm_enc_region {
 /* Available with KVM_CAP_HYPERV_CPUID */
 #define KVM_GET_SUPPORTED_HV_CPUID _IOWR(KVMIO, 0xc1, struct kvm_cpuid2)
=20
+/* Available with KVM_CAP_ARM_SVE */
+#define KVM_ARM_VCPU_FINALIZE	  _IOW(KVMIO,  0xc2, int)
+
 /* Secure Encrypted Virtualization command */
 enum sev_cmd_id {
 	/* Guest initialization commands */
--=20
2.20.1



Return-Path: <SRS0=0TZc=4P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E94B7C4BA3B
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 11:55:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A2EE820726
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 11:55:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Slgu8Jgn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A2EE820726
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58062 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j7Hli-00019u-Gc
	for qemu-devel@archiver.kernel.org; Thu, 27 Feb 2020 06:55:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50978)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <cohuck@redhat.com>) id 1j7Hke-0007sT-JR
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 06:54:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <cohuck@redhat.com>) id 1j7Hkc-000114-Ec
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 06:54:48 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:31224
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1j7Hkc-00010m-9f
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 06:54:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582804485;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VgBV6X2JmWZIhuuk4iu7jWGWxXgkN+uf1Lt9GCbaWCA=;
 b=Slgu8JgnJiMOvXScjBXhM5/VEm1Ep3A+aXqNihJX+e9X4Dba2w5CfjYy7cWA23nbknKW+U
 sJpJHj2QhVL1n67fERiw4JLsk/4PGv5VnZvCkwByFq1s2ItOi1It+V6d1fo5rKh/phwf/Q
 JkCmO7Zsz7ZfHMAKJjDT0bQtGIQuNQA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-54-fk0Gfq_oPx6JUbjAE7DaSQ-1; Thu, 27 Feb 2020 06:54:43 -0500
X-MC-Unique: fk0Gfq_oPx6JUbjAE7DaSQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AA5171937FC0;
 Thu, 27 Feb 2020 11:54:42 +0000 (UTC)
Received: from localhost (ovpn-117-2.ams2.redhat.com [10.36.117.2])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 1EA9760BE2;
 Thu, 27 Feb 2020 11:54:41 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 2/7] linux-headers: update
Date: Thu, 27 Feb 2020 12:54:26 +0100
Message-Id: <20200227115431.32364-3-cohuck@redhat.com>
In-Reply-To: <20200227115431.32364-1-cohuck@redhat.com>
References: <20200227115431.32364-1-cohuck@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
Cc: qemu-s390x@nongnu.org, Cornelia Huck <cohuck@redhat.com>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Update to commit b1da3acc781c ("Merge tag 'ecryptfs-5.6-rc3-fixes' of
git://git.kernel.org/pub/scm/linux/kernel/git/tyhicks/ecryptfs")

Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 include/standard-headers/drm/drm_fourcc.h | 24 +++++++++++++++++++++++
 include/standard-headers/linux/ethtool.h  | 11 +++++++++++
 include/standard-headers/linux/input.h    |  1 +
 include/standard-headers/linux/pci_regs.h |  1 +
 linux-headers/asm-arm/unistd-common.h     |  2 ++
 linux-headers/asm-arm64/kvm.h             | 12 ++++++++++--
 linux-headers/asm-arm64/unistd.h          |  1 +
 linux-headers/asm-generic/mman-common.h   |  2 ++
 linux-headers/asm-generic/unistd.h        |  7 ++++++-
 linux-headers/asm-mips/unistd_n32.h       |  2 ++
 linux-headers/asm-mips/unistd_n64.h       |  2 ++
 linux-headers/asm-mips/unistd_o32.h       |  2 ++
 linux-headers/asm-powerpc/unistd_32.h     |  2 ++
 linux-headers/asm-powerpc/unistd_64.h     |  2 ++
 linux-headers/asm-s390/unistd_32.h        |  2 ++
 linux-headers/asm-s390/unistd_64.h        |  2 ++
 linux-headers/asm-x86/unistd_32.h         |  2 ++
 linux-headers/asm-x86/unistd_64.h         |  2 ++
 linux-headers/asm-x86/unistd_x32.h        |  2 ++
 linux-headers/linux/kvm.h                 |  5 +++++
 20 files changed, 83 insertions(+), 3 deletions(-)

diff --git a/include/standard-headers/drm/drm_fourcc.h b/include/standard-h=
eaders/drm/drm_fourcc.h
index 46d279f51586..66e838074c81 100644
--- a/include/standard-headers/drm/drm_fourcc.h
+++ b/include/standard-headers/drm/drm_fourcc.h
@@ -409,6 +409,30 @@ extern "C" {
 #define I915_FORMAT_MOD_Y_TILED_CCS=09fourcc_mod_code(INTEL, 4)
 #define I915_FORMAT_MOD_Yf_TILED_CCS=09fourcc_mod_code(INTEL, 5)
=20
+/*
+ * Intel color control surfaces (CCS) for Gen-12 render compression.
+ *
+ * The main surface is Y-tiled and at plane index 0, the CCS is linear and
+ * at index 1. A 64B CCS cache line corresponds to an area of 4x1 tiles in
+ * main surface. In other words, 4 bits in CCS map to a main surface cache
+ * line pair. The main surface pitch is required to be a multiple of four
+ * Y-tile widths.
+ */
+#define I915_FORMAT_MOD_Y_TILED_GEN12_RC_CCS fourcc_mod_code(INTEL, 6)
+
+/*
+ * Intel color control surfaces (CCS) for Gen-12 media compression
+ *
+ * The main surface is Y-tiled and at plane index 0, the CCS is linear and
+ * at index 1. A 64B CCS cache line corresponds to an area of 4x1 tiles in
+ * main surface. In other words, 4 bits in CCS map to a main surface cache
+ * line pair. The main surface pitch is required to be a multiple of four
+ * Y-tile widths. For semi-planar formats like NV12, CCS planes follow the
+ * Y and UV planes i.e., planes 0 and 1 are used for Y and UV surfaces,
+ * planes 2 and 3 for the respective CCS.
+ */
+#define I915_FORMAT_MOD_Y_TILED_GEN12_MC_CCS fourcc_mod_code(INTEL, 7)
+
 /*
  * Tiled, NV12MT, grouped in 64 (pixels) x 32 (lines) -sized macroblocks
  *
diff --git a/include/standard-headers/linux/ethtool.h b/include/standard-he=
aders/linux/ethtool.h
index 6e8a10ee1075..8adf3b018b95 100644
--- a/include/standard-headers/linux/ethtool.h
+++ b/include/standard-headers/linux/ethtool.h
@@ -593,6 +593,9 @@ struct ethtool_pauseparam {
  * @ETH_SS_RSS_HASH_FUNCS: RSS hush function names
  * @ETH_SS_PHY_STATS: Statistic names, for use with %ETHTOOL_GPHYSTATS
  * @ETH_SS_PHY_TUNABLES: PHY tunable names
+ * @ETH_SS_LINK_MODES: link mode names
+ * @ETH_SS_MSG_CLASSES: debug message class names
+ * @ETH_SS_WOL_MODES: wake-on-lan modes
  */
 enum ethtool_stringset {
 =09ETH_SS_TEST=09=09=3D 0,
@@ -604,6 +607,12 @@ enum ethtool_stringset {
 =09ETH_SS_TUNABLES,
 =09ETH_SS_PHY_STATS,
 =09ETH_SS_PHY_TUNABLES,
+=09ETH_SS_LINK_MODES,
+=09ETH_SS_MSG_CLASSES,
+=09ETH_SS_WOL_MODES,
+
+=09/* add new constants above here */
+=09ETH_SS_COUNT
 };
=20
 /**
@@ -1688,6 +1697,8 @@ static inline int ethtool_validate_duplex(uint8_t dup=
lex)
 #define WAKE_MAGICSECURE=09(1 << 6) /* only meaningful if WAKE_MAGIC */
 #define WAKE_FILTER=09=09(1 << 7)
=20
+#define WOL_MODE_COUNT=09=098
+
 /* L2-L4 network traffic flow types */
 #define=09TCP_V4_FLOW=090x01=09/* hash or spec (tcp_ip4_spec) */
 #define=09UDP_V4_FLOW=090x02=09/* hash or spec (udp_ip4_spec) */
diff --git a/include/standard-headers/linux/input.h b/include/standard-head=
ers/linux/input.h
index d8914f25a5e0..f89c986190de 100644
--- a/include/standard-headers/linux/input.h
+++ b/include/standard-headers/linux/input.h
@@ -31,6 +31,7 @@ struct input_event {
 =09unsigned long __sec;
 #if defined(__sparc__) && defined(__arch64__)
 =09unsigned int __usec;
+=09unsigned int __pad;
 #else
 =09unsigned long __usec;
 #endif
diff --git a/include/standard-headers/linux/pci_regs.h b/include/standard-h=
eaders/linux/pci_regs.h
index acb7d2bdb419..5437690483cd 100644
--- a/include/standard-headers/linux/pci_regs.h
+++ b/include/standard-headers/linux/pci_regs.h
@@ -676,6 +676,7 @@
 #define  PCI_EXP_LNKCTL2_TLS_32_0GT=090x0005 /* Supported Speed 32GT/s */
 #define  PCI_EXP_LNKCTL2_ENTER_COMP=090x0010 /* Enter Compliance */
 #define  PCI_EXP_LNKCTL2_TX_MARGIN=090x0380 /* Transmit Margin */
+#define  PCI_EXP_LNKCTL2_HASD=09=090x0020 /* HW Autonomous Speed Disable *=
/
 #define PCI_EXP_LNKSTA2=09=0950=09/* Link Status 2 */
 #define PCI_CAP_EXP_ENDPOINT_SIZEOF_V2=0952=09/* v2 endpoints with link en=
d here */
 #define PCI_EXP_SLTCAP2=09=0952=09/* Slot Capabilities 2 */
diff --git a/linux-headers/asm-arm/unistd-common.h b/linux-headers/asm-arm/=
unistd-common.h
index eb5d361b117b..23de64e44c44 100644
--- a/linux-headers/asm-arm/unistd-common.h
+++ b/linux-headers/asm-arm/unistd-common.h
@@ -390,5 +390,7 @@
 #define __NR_fspick (__NR_SYSCALL_BASE + 433)
 #define __NR_pidfd_open (__NR_SYSCALL_BASE + 434)
 #define __NR_clone3 (__NR_SYSCALL_BASE + 435)
+#define __NR_openat2 (__NR_SYSCALL_BASE + 437)
+#define __NR_pidfd_getfd (__NR_SYSCALL_BASE + 438)
=20
 #endif /* _ASM_ARM_UNISTD_COMMON_H */
diff --git a/linux-headers/asm-arm64/kvm.h b/linux-headers/asm-arm64/kvm.h
index 920af01c8b90..9e34f0f875a6 100644
--- a/linux-headers/asm-arm64/kvm.h
+++ b/linux-headers/asm-arm64/kvm.h
@@ -220,10 +220,18 @@ struct kvm_vcpu_events {
 #define KVM_REG_ARM_PTIMER_CVAL=09=09ARM64_SYS_REG(3, 3, 14, 2, 2)
 #define KVM_REG_ARM_PTIMER_CNT=09=09ARM64_SYS_REG(3, 3, 14, 0, 1)
=20
-/* EL0 Virtual Timer Registers */
+/*
+ * EL0 Virtual Timer Registers
+ *
+ * WARNING:
+ *      KVM_REG_ARM_TIMER_CVAL and KVM_REG_ARM_TIMER_CNT are not defined
+ *      with the appropriate register encodings.  Their values have been
+ *      accidentally swapped.  As this is set API, the definitions here
+ *      must be used, rather than ones derived from the encodings.
+ */
 #define KVM_REG_ARM_TIMER_CTL=09=09ARM64_SYS_REG(3, 3, 14, 3, 1)
-#define KVM_REG_ARM_TIMER_CNT=09=09ARM64_SYS_REG(3, 3, 14, 3, 2)
 #define KVM_REG_ARM_TIMER_CVAL=09=09ARM64_SYS_REG(3, 3, 14, 0, 2)
+#define KVM_REG_ARM_TIMER_CNT=09=09ARM64_SYS_REG(3, 3, 14, 3, 2)
=20
 /* KVM-as-firmware specific pseudo-registers */
 #define KVM_REG_ARM_FW=09=09=09(0x0014 << KVM_REG_ARM_COPROC_SHIFT)
diff --git a/linux-headers/asm-arm64/unistd.h b/linux-headers/asm-arm64/uni=
std.h
index 4703d218663a..f83a70e07df8 100644
--- a/linux-headers/asm-arm64/unistd.h
+++ b/linux-headers/asm-arm64/unistd.h
@@ -19,5 +19,6 @@
 #define __ARCH_WANT_NEW_STAT
 #define __ARCH_WANT_SET_GET_RLIMIT
 #define __ARCH_WANT_TIME32_SYSCALLS
+#define __ARCH_WANT_SYS_CLONE3
=20
 #include <asm-generic/unistd.h>
diff --git a/linux-headers/asm-generic/mman-common.h b/linux-headers/asm-ge=
neric/mman-common.h
index c160a5354eb6..f94f65d429be 100644
--- a/linux-headers/asm-generic/mman-common.h
+++ b/linux-headers/asm-generic/mman-common.h
@@ -11,6 +11,8 @@
 #define PROT_WRITE=090x2=09=09/* page can be written */
 #define PROT_EXEC=090x4=09=09/* page can be executed */
 #define PROT_SEM=090x8=09=09/* page may be used for atomic ops */
+/*=09=09=090x10=09=09   reserved for arch-specific use */
+/*=09=09=090x20=09=09   reserved for arch-specific use */
 #define PROT_NONE=090x0=09=09/* page can not be accessed */
 #define PROT_GROWSDOWN=090x01000000=09/* mprotect flag: extend change to s=
tart of growsdown vma */
 #define PROT_GROWSUP=090x02000000=09/* mprotect flag: extend change to end=
 of growsup vma */
diff --git a/linux-headers/asm-generic/unistd.h b/linux-headers/asm-generic=
/unistd.h
index 1fc8faa6e973..3a3201e4618e 100644
--- a/linux-headers/asm-generic/unistd.h
+++ b/linux-headers/asm-generic/unistd.h
@@ -851,8 +851,13 @@ __SYSCALL(__NR_pidfd_open, sys_pidfd_open)
 __SYSCALL(__NR_clone3, sys_clone3)
 #endif
=20
+#define __NR_openat2 437
+__SYSCALL(__NR_openat2, sys_openat2)
+#define __NR_pidfd_getfd 438
+__SYSCALL(__NR_pidfd_getfd, sys_pidfd_getfd)
+
 #undef __NR_syscalls
-#define __NR_syscalls 436
+#define __NR_syscalls 439
=20
 /*
  * 32 bit systems traditionally used different
diff --git a/linux-headers/asm-mips/unistd_n32.h b/linux-headers/asm-mips/u=
nistd_n32.h
index 659d5c9ade47..aec9f6081af7 100644
--- a/linux-headers/asm-mips/unistd_n32.h
+++ b/linux-headers/asm-mips/unistd_n32.h
@@ -365,6 +365,8 @@
 #define __NR_fspick=09(__NR_Linux + 433)
 #define __NR_pidfd_open=09(__NR_Linux + 434)
 #define __NR_clone3=09(__NR_Linux + 435)
+#define __NR_openat2=09(__NR_Linux + 437)
+#define __NR_pidfd_getfd=09(__NR_Linux + 438)
=20
=20
 #endif /* _ASM_MIPS_UNISTD_N32_H */
diff --git a/linux-headers/asm-mips/unistd_n64.h b/linux-headers/asm-mips/u=
nistd_n64.h
index 4b6310a05c23..1c75d83df53f 100644
--- a/linux-headers/asm-mips/unistd_n64.h
+++ b/linux-headers/asm-mips/unistd_n64.h
@@ -341,6 +341,8 @@
 #define __NR_fspick=09(__NR_Linux + 433)
 #define __NR_pidfd_open=09(__NR_Linux + 434)
 #define __NR_clone3=09(__NR_Linux + 435)
+#define __NR_openat2=09(__NR_Linux + 437)
+#define __NR_pidfd_getfd=09(__NR_Linux + 438)
=20
=20
 #endif /* _ASM_MIPS_UNISTD_N64_H */
diff --git a/linux-headers/asm-mips/unistd_o32.h b/linux-headers/asm-mips/u=
nistd_o32.h
index 4ce7b4e288a5..660716e240ec 100644
--- a/linux-headers/asm-mips/unistd_o32.h
+++ b/linux-headers/asm-mips/unistd_o32.h
@@ -411,6 +411,8 @@
 #define __NR_fspick=09(__NR_Linux + 433)
 #define __NR_pidfd_open=09(__NR_Linux + 434)
 #define __NR_clone3=09(__NR_Linux + 435)
+#define __NR_openat2=09(__NR_Linux + 437)
+#define __NR_pidfd_getfd=09(__NR_Linux + 438)
=20
=20
 #endif /* _ASM_MIPS_UNISTD_O32_H */
diff --git a/linux-headers/asm-powerpc/unistd_32.h b/linux-headers/asm-powe=
rpc/unistd_32.h
index 5584cc1b4fc1..4ba8e32f7344 100644
--- a/linux-headers/asm-powerpc/unistd_32.h
+++ b/linux-headers/asm-powerpc/unistd_32.h
@@ -418,6 +418,8 @@
 #define __NR_fspick=09433
 #define __NR_pidfd_open=09434
 #define __NR_clone3=09435
+#define __NR_openat2=09437
+#define __NR_pidfd_getfd=09438
=20
=20
 #endif /* _ASM_POWERPC_UNISTD_32_H */
diff --git a/linux-headers/asm-powerpc/unistd_64.h b/linux-headers/asm-powe=
rpc/unistd_64.h
index 251bcff77ea4..ac20bb4f95b2 100644
--- a/linux-headers/asm-powerpc/unistd_64.h
+++ b/linux-headers/asm-powerpc/unistd_64.h
@@ -390,6 +390,8 @@
 #define __NR_fspick=09433
 #define __NR_pidfd_open=09434
 #define __NR_clone3=09435
+#define __NR_openat2=09437
+#define __NR_pidfd_getfd=09438
=20
=20
 #endif /* _ASM_POWERPC_UNISTD_64_H */
diff --git a/linux-headers/asm-s390/unistd_32.h b/linux-headers/asm-s390/un=
istd_32.h
index 7cce3ee29609..e4a6b654f10e 100644
--- a/linux-headers/asm-s390/unistd_32.h
+++ b/linux-headers/asm-s390/unistd_32.h
@@ -408,5 +408,7 @@
 #define __NR_fspick 433
 #define __NR_pidfd_open 434
 #define __NR_clone3 435
+#define __NR_openat2 437
+#define __NR_pidfd_getfd 438
=20
 #endif /* _ASM_S390_UNISTD_32_H */
diff --git a/linux-headers/asm-s390/unistd_64.h b/linux-headers/asm-s390/un=
istd_64.h
index 2371ff1e7a79..472f732956e4 100644
--- a/linux-headers/asm-s390/unistd_64.h
+++ b/linux-headers/asm-s390/unistd_64.h
@@ -356,5 +356,7 @@
 #define __NR_fspick 433
 #define __NR_pidfd_open 434
 #define __NR_clone3 435
+#define __NR_openat2 437
+#define __NR_pidfd_getfd 438
=20
 #endif /* _ASM_S390_UNISTD_64_H */
diff --git a/linux-headers/asm-x86/unistd_32.h b/linux-headers/asm-x86/unis=
td_32.h
index e8ebec1cdc99..f6e06fcfbdcf 100644
--- a/linux-headers/asm-x86/unistd_32.h
+++ b/linux-headers/asm-x86/unistd_32.h
@@ -426,5 +426,7 @@
 #define __NR_fspick 433
 #define __NR_pidfd_open 434
 #define __NR_clone3 435
+#define __NR_openat2 437
+#define __NR_pidfd_getfd 438
=20
 #endif /* _ASM_X86_UNISTD_32_H */
diff --git a/linux-headers/asm-x86/unistd_64.h b/linux-headers/asm-x86/unis=
td_64.h
index a2f863d5493f..924f826d2d48 100644
--- a/linux-headers/asm-x86/unistd_64.h
+++ b/linux-headers/asm-x86/unistd_64.h
@@ -348,5 +348,7 @@
 #define __NR_fspick 433
 #define __NR_pidfd_open 434
 #define __NR_clone3 435
+#define __NR_openat2 437
+#define __NR_pidfd_getfd 438
=20
 #endif /* _ASM_X86_UNISTD_64_H */
diff --git a/linux-headers/asm-x86/unistd_x32.h b/linux-headers/asm-x86/uni=
std_x32.h
index 4cdc67d84810..010307757b1b 100644
--- a/linux-headers/asm-x86/unistd_x32.h
+++ b/linux-headers/asm-x86/unistd_x32.h
@@ -301,6 +301,8 @@
 #define __NR_fspick (__X32_SYSCALL_BIT + 433)
 #define __NR_pidfd_open (__X32_SYSCALL_BIT + 434)
 #define __NR_clone3 (__X32_SYSCALL_BIT + 435)
+#define __NR_openat2 (__X32_SYSCALL_BIT + 437)
+#define __NR_pidfd_getfd (__X32_SYSCALL_BIT + 438)
 #define __NR_rt_sigaction (__X32_SYSCALL_BIT + 512)
 #define __NR_rt_sigreturn (__X32_SYSCALL_BIT + 513)
 #define __NR_ioctl (__X32_SYSCALL_BIT + 514)
diff --git a/linux-headers/linux/kvm.h b/linux-headers/linux/kvm.h
index 9d647fad7648..265099100e65 100644
--- a/linux-headers/linux/kvm.h
+++ b/linux-headers/linux/kvm.h
@@ -1009,6 +1009,7 @@ struct kvm_ppc_resize_hpt {
 #define KVM_CAP_PPC_GUEST_DEBUG_SSTEP 176
 #define KVM_CAP_ARM_NISV_TO_USER 177
 #define KVM_CAP_ARM_INJECT_EXT_DABT 178
+#define KVM_CAP_S390_VCPU_RESETS 179
=20
 #ifdef KVM_CAP_IRQ_ROUTING
=20
@@ -1473,6 +1474,10 @@ struct kvm_enc_region {
 /* Available with KVM_CAP_ARM_SVE */
 #define KVM_ARM_VCPU_FINALIZE=09  _IOW(KVMIO,  0xc2, int)
=20
+/* Available with  KVM_CAP_S390_VCPU_RESETS */
+#define KVM_S390_NORMAL_RESET=09_IO(KVMIO,   0xc3)
+#define KVM_S390_CLEAR_RESET=09_IO(KVMIO,   0xc4)
+
 /* Secure Encrypted Virtualization command */
 enum sev_cmd_id {
 =09/* Guest initialization commands */
--=20
2.21.1



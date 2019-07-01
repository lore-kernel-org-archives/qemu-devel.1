Return-Path: <SRS0=a9ZG=U6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7222FC0650E
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2019 13:55:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 49BF521721
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2019 13:55:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 49BF521721
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59042 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hhwm8-0003jE-JW
	for qemu-devel@archiver.kernel.org; Mon, 01 Jul 2019 09:55:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41205)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hhwKk-0002Qr-QX
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 09:27:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hhwKj-0002U8-1x
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 09:27:02 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53972)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>)
 id 1hhwKe-0002DJ-6z; Mon, 01 Jul 2019 09:26:56 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 6AF6787620;
 Mon,  1 Jul 2019 13:26:47 +0000 (UTC)
Received: from x1w.redhat.com (unknown [10.40.205.170])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id AFBFA6085B;
 Mon,  1 Jul 2019 13:26:44 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Date: Mon,  1 Jul 2019 15:25:09 +0200
Message-Id: <20190701132516.26392-21-philmd@redhat.com>
In-Reply-To: <20190701132516.26392-1-philmd@redhat.com>
References: <20190701132516.26392-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.26]); Mon, 01 Jul 2019 13:26:47 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v3 20/27] target/arm: Declare
 arm_log_exception() function publicly
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
Cc: Yang Zhong <yang.zhong@intel.com>, Peter Maydell <peter.maydell@linaro.org>,
 Andrew Jones <drjones@redhat.com>, Samuel Ortiz <sameo@linux.intel.com>,
 Rob Bradford <robert.bradford@intel.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 qemu-arm@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

In few commits we will split the M-profile functions from this
file, and this function will also be called in the new file.
Declare it in the "internals.h" header.
Since it is in the middle of a block of M profile functions,
move it previous to this block to ease the later refactor.

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 target/arm/helper.c    | 76 +++++++++++++++++++++---------------------
 target/arm/internals.h |  2 ++
 2 files changed, 40 insertions(+), 38 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 1b4da7aa45..515a82af57 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -7697,6 +7697,44 @@ uint32_t arm_phys_excp_target_el(CPUState *cs, uin=
t32_t excp_idx,
     return target_el;
 }
=20
+void arm_log_exception(int idx)
+{
+    if (qemu_loglevel_mask(CPU_LOG_INT)) {
+        const char *exc =3D NULL;
+        static const char * const excnames[] =3D {
+            [EXCP_UDEF] =3D "Undefined Instruction",
+            [EXCP_SWI] =3D "SVC",
+            [EXCP_PREFETCH_ABORT] =3D "Prefetch Abort",
+            [EXCP_DATA_ABORT] =3D "Data Abort",
+            [EXCP_IRQ] =3D "IRQ",
+            [EXCP_FIQ] =3D "FIQ",
+            [EXCP_BKPT] =3D "Breakpoint",
+            [EXCP_EXCEPTION_EXIT] =3D "QEMU v7M exception exit",
+            [EXCP_KERNEL_TRAP] =3D "QEMU intercept of kernel commpage",
+            [EXCP_HVC] =3D "Hypervisor Call",
+            [EXCP_HYP_TRAP] =3D "Hypervisor Trap",
+            [EXCP_SMC] =3D "Secure Monitor Call",
+            [EXCP_VIRQ] =3D "Virtual IRQ",
+            [EXCP_VFIQ] =3D "Virtual FIQ",
+            [EXCP_SEMIHOST] =3D "Semihosting call",
+            [EXCP_NOCP] =3D "v7M NOCP UsageFault",
+            [EXCP_INVSTATE] =3D "v7M INVSTATE UsageFault",
+            [EXCP_STKOF] =3D "v8M STKOF UsageFault",
+            [EXCP_LAZYFP] =3D "v7M exception during lazy FP stacking",
+            [EXCP_LSERR] =3D "v8M LSERR UsageFault",
+            [EXCP_UNALIGNED] =3D "v7M UNALIGNED UsageFault",
+        };
+
+        if (idx >=3D 0 && idx < ARRAY_SIZE(excnames)) {
+            exc =3D excnames[idx];
+        }
+        if (!exc) {
+            exc =3D "unknown";
+        }
+        qemu_log_mask(CPU_LOG_INT, "Taking exception %d [%s]\n", idx, ex=
c);
+    }
+}
+
 /*
  * Return true if the v7M CPACR permits access to the FPU for the specif=
ied
  * security state and privilege level.
@@ -9436,44 +9474,6 @@ static bool do_v7m_function_return(ARMCPU *cpu)
     return true;
 }
=20
-static void arm_log_exception(int idx)
-{
-    if (qemu_loglevel_mask(CPU_LOG_INT)) {
-        const char *exc =3D NULL;
-        static const char * const excnames[] =3D {
-            [EXCP_UDEF] =3D "Undefined Instruction",
-            [EXCP_SWI] =3D "SVC",
-            [EXCP_PREFETCH_ABORT] =3D "Prefetch Abort",
-            [EXCP_DATA_ABORT] =3D "Data Abort",
-            [EXCP_IRQ] =3D "IRQ",
-            [EXCP_FIQ] =3D "FIQ",
-            [EXCP_BKPT] =3D "Breakpoint",
-            [EXCP_EXCEPTION_EXIT] =3D "QEMU v7M exception exit",
-            [EXCP_KERNEL_TRAP] =3D "QEMU intercept of kernel commpage",
-            [EXCP_HVC] =3D "Hypervisor Call",
-            [EXCP_HYP_TRAP] =3D "Hypervisor Trap",
-            [EXCP_SMC] =3D "Secure Monitor Call",
-            [EXCP_VIRQ] =3D "Virtual IRQ",
-            [EXCP_VFIQ] =3D "Virtual FIQ",
-            [EXCP_SEMIHOST] =3D "Semihosting call",
-            [EXCP_NOCP] =3D "v7M NOCP UsageFault",
-            [EXCP_INVSTATE] =3D "v7M INVSTATE UsageFault",
-            [EXCP_STKOF] =3D "v8M STKOF UsageFault",
-            [EXCP_LAZYFP] =3D "v7M exception during lazy FP stacking",
-            [EXCP_LSERR] =3D "v8M LSERR UsageFault",
-            [EXCP_UNALIGNED] =3D "v7M UNALIGNED UsageFault",
-        };
-
-        if (idx >=3D 0 && idx < ARRAY_SIZE(excnames)) {
-            exc =3D excnames[idx];
-        }
-        if (!exc) {
-            exc =3D "unknown";
-        }
-        qemu_log_mask(CPU_LOG_INT, "Taking exception %d [%s]\n", idx, ex=
c);
-    }
-}
-
 static bool v7m_read_half_insn(ARMCPU *cpu, ARMMMUIdx mmu_idx,
                                uint32_t addr, uint16_t *insn)
 {
diff --git a/target/arm/internals.h b/target/arm/internals.h
index 57e0253ef4..11bfdba512 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -1000,6 +1000,8 @@ bool get_phys_addr(CPUARMState *env, target_ulong a=
ddress,
                    target_ulong *page_size,
                    ARMMMUFaultInfo *fi, ARMCacheAttrs *cacheattrs);
=20
+void arm_log_exception(int idx);
+
 #endif /* !CONFIG_USER_ONLY */
=20
 #endif
--=20
2.20.1



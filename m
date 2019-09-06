Return-Path: <SRS0=KBml=XB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2963C43331
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Sep 2019 08:35:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AB5CE20842
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Sep 2019 08:35:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB5CE20842
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53532 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i69iM-00049z-Db
	for qemu-devel@archiver.kernel.org; Fri, 06 Sep 2019 04:35:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50238)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <zhengxiang9@huawei.com>) id 1i69gQ-00021A-7w
 for qemu-devel@nongnu.org; Fri, 06 Sep 2019 04:33:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <zhengxiang9@huawei.com>) id 1i69gO-0005cl-NV
 for qemu-devel@nongnu.org; Fri, 06 Sep 2019 04:33:30 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:2263 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <zhengxiang9@huawei.com>)
 id 1i69gJ-0005YN-OX; Fri, 06 Sep 2019 04:33:24 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.59])
 by Forcepoint Email with ESMTP id DA4513714BE49AC749E6;
 Fri,  6 Sep 2019 16:33:20 +0800 (CST)
Received: from HGHY1z004218071.china.huawei.com (10.177.29.32) by
 DGGEMS403-HUB.china.huawei.com (10.3.19.203) with Microsoft SMTP Server id
 14.3.439.0; Fri, 6 Sep 2019 16:33:12 +0800
From: Xiang Zheng <zhengxiang9@huawei.com>
To: <pbonzini@redhat.com>, <mst@redhat.com>, <imammedo@redhat.com>,
 <shannon.zhaosl@gmail.com>, <peter.maydell@linaro.org>, <lersek@redhat.com>,
 <james.morse@arm.com>, <gengdongjiu@huawei.com>, <mtosatti@redhat.com>,
 <rth@twiddle.net>, <ehabkost@redhat.com>, <jonathan.cameron@huawei.com>,
 <xuwei5@huawei.com>, <kvm@vger.kernel.org>, <qemu-devel@nongnu.org>,
 <qemu-arm@nongnu.org>, <linuxarm@huawei.com>
Date: Fri, 6 Sep 2019 16:31:51 +0800
Message-ID: <20190906083152.25716-6-zhengxiang9@huawei.com>
X-Mailer: git-send-email 2.15.1.windows.2
In-Reply-To: <20190906083152.25716-1-zhengxiang9@huawei.com>
References: <20190906083152.25716-1-zhengxiang9@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.177.29.32]
X-CFilter-Loop: Reflected
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 45.249.212.191
Subject: [Qemu-devel] [PATCH v18 5/6] target-arm: kvm64: inject synchronous
 External Abort
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
Cc: wanghaibin.wang@huawei.com, zhengxiang9@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Dongjiu Geng <gengdongjiu@huawei.com>

Introduce kvm_inject_arm_sea() function in which we will setup the type
of exception and the syndrome information in order to inject a virtual
synchronous external abort. When switching to guest, it will jump to the
synchronous external abort vector table entry.

The ESR_ELx.DFSC is set to synchronous external abort(0x10), and
ESR_ELx.FnV is set to not valid(0x1), which will tell guest that FAR is
not valid and hold an UNKNOWN value. These values will be set to KVM
register structures through KVM_SET_ONE_REG IOCTL.

Signed-off-by: Dongjiu Geng <gengdongjiu@huawei.com>
Signed-off-by: Xiang Zheng <zhengxiang9@huawei.com>
---
 target/arm/helper.c     |  2 +-
 target/arm/internals.h  |  5 +++--
 target/arm/kvm64.c      | 34 ++++++++++++++++++++++++++++++++++
 target/arm/tlb_helper.c |  2 +-
 4 files changed, 39 insertions(+), 4 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 507026c915..a13baeb085 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -3005,7 +3005,7 @@ static uint64_t do_ats_write(CPUARMState *env, uint64_t value,
              * Report exception with ESR indicating a fault due to a
              * translation table walk for a cache maintenance instruction.
              */
-            syn = syn_data_abort_no_iss(current_el == target_el,
+            syn = syn_data_abort_no_iss(current_el == target_el, 0,
                                         fi.ea, 1, fi.s1ptw, 1, fsc);
             env->exception.vaddress = value;
             env->exception.fsr = fsr;
diff --git a/target/arm/internals.h b/target/arm/internals.h
index 232d963875..98cde702ad 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -451,13 +451,14 @@ static inline uint32_t syn_insn_abort(int same_el, int ea, int s1ptw, int fsc)
         | ARM_EL_IL | (ea << 9) | (s1ptw << 7) | fsc;
 }
 
-static inline uint32_t syn_data_abort_no_iss(int same_el,
+static inline uint32_t syn_data_abort_no_iss(int same_el, int fnv,
                                              int ea, int cm, int s1ptw,
                                              int wnr, int fsc)
 {
     return (EC_DATAABORT << ARM_EL_EC_SHIFT) | (same_el << ARM_EL_EC_SHIFT)
            | ARM_EL_IL
-           | (ea << 9) | (cm << 8) | (s1ptw << 7) | (wnr << 6) | fsc;
+           | (fnv << 10) | (ea << 9) | (cm << 8) | (s1ptw << 7)
+           | (wnr << 6) | fsc;
 }
 
 static inline uint32_t syn_data_abort_with_iss(int same_el,
diff --git a/target/arm/kvm64.c b/target/arm/kvm64.c
index 28f6db57d5..bf6edaa3f6 100644
--- a/target/arm/kvm64.c
+++ b/target/arm/kvm64.c
@@ -710,6 +710,40 @@ int kvm_arm_cpreg_level(uint64_t regidx)
     return KVM_PUT_RUNTIME_STATE;
 }
 
+/* Inject synchronous external abort */
+static void kvm_inject_arm_sea(CPUState *c)
+{
+    ARMCPU *cpu = ARM_CPU(c);
+    CPUARMState *env = &cpu->env;
+    CPUClass *cc = CPU_GET_CLASS(c);
+    uint32_t esr;
+    bool same_el;
+
+    /**
+     * Set the exception type to synchronous data abort
+     * and the target exception Level to EL1.
+     */
+    c->exception_index = EXCP_DATA_ABORT;
+    env->exception.target_el = 1;
+
+    /*
+     * Set the DFSC to synchronous external abort and set FnV to not valid,
+     * this will tell guest the FAR_ELx is UNKNOWN for this abort.
+     */
+
+    /* This exception comes from lower or current exception level. */
+    same_el = arm_current_el(env) == env->exception.target_el;
+    esr = syn_data_abort_no_iss(same_el, 1, 0, 0, 0, 0, 0x10);
+
+    env->exception.syndrome = esr;
+
+    /**
+     * The vcpu thread already hold BQL, so no need hold again when
+     * calling do_interrupt
+     */
+    cc->do_interrupt(c);
+}
+
 #define AARCH64_CORE_REG(x)   (KVM_REG_ARM64 | KVM_REG_SIZE_U64 | \
                  KVM_REG_ARM_CORE | KVM_REG_ARM_CORE_REG(x))
 
diff --git a/target/arm/tlb_helper.c b/target/arm/tlb_helper.c
index 5feb312941..499672ebbc 100644
--- a/target/arm/tlb_helper.c
+++ b/target/arm/tlb_helper.c
@@ -33,7 +33,7 @@ static inline uint32_t merge_syn_data_abort(uint32_t template_syn,
      * ISV field.
      */
     if (!(template_syn & ARM_EL_ISV) || target_el != 2 || s1ptw) {
-        syn = syn_data_abort_no_iss(same_el,
+        syn = syn_data_abort_no_iss(same_el, 0,
                                     ea, 0, s1ptw, is_write, fsc);
     } else {
         /*
-- 
2.19.1




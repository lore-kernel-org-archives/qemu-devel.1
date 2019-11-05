Return-Path: <SRS0=HxLX=Y5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87953C49EAB
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2019 09:23:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3B305217F4
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2019 09:23:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B305217F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41954 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iRv3S-0001xi-28
	for qemu-devel@archiver.kernel.org; Tue, 05 Nov 2019 04:23:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43186)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <guoheyi@huawei.com>) id 1iRut0-00056Y-Fq
 for qemu-devel@nongnu.org; Tue, 05 Nov 2019 04:12:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <guoheyi@huawei.com>) id 1iRusz-0007pK-0S
 for qemu-devel@nongnu.org; Tue, 05 Nov 2019 04:12:26 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:52212 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <guoheyi@huawei.com>)
 id 1iRusv-0007jC-6m; Tue, 05 Nov 2019 04:12:21 -0500
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.58])
 by Forcepoint Email with ESMTP id 45AA184DA50D9691C0CB;
 Tue,  5 Nov 2019 17:12:18 +0800 (CST)
Received: from linux-OtBuvb.huawei.com (10.175.104.212) by
 DGGEMS404-HUB.china.huawei.com (10.3.19.204) with Microsoft SMTP Server id
 14.3.439.0; Tue, 5 Nov 2019 17:12:09 +0800
From: Heyi Guo <guoheyi@huawei.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
Subject: [RFC v2 11/14] linux-headers/kvm.h: add capability to forward
 hypercall
Date: Tue, 5 Nov 2019 17:10:53 +0800
Message-ID: <20191105091056.9541-12-guoheyi@huawei.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20191105091056.9541-1-guoheyi@huawei.com>
References: <20191105091056.9541-1-guoheyi@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.104.212]
X-CFilter-Loop: Reflected
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 45.249.212.35
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
Cc: Mark Rutland <mark.rutland@arm.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Marc Zyngier <marc.zyngier@arm.com>,
 Cornelia Huck <cohuck@redhat.com>, James Morse <james.morse@arm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Heyi Guo <guoheyi@huawei.com>,
 wanghaibin.wang@huawei.com, Dave Martin <Dave.Martin@arm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

To keep backward compatibility, we add new KVM capability
"KVM_CAP_FORWARD_HYPERCALL" to probe whether KVM supports forwarding
hypercall to userspace.

The capability should be enabled explicitly, for we don't want user
space application to deal with unexpected hypercall exits. After
enabling this cap, all HVC calls unhandled by kvm will be forwarded to
user space.

Signed-off-by: Heyi Guo <guoheyi@huawei.com>
Cc: Peter Maydell <peter.maydell@linaro.org>
Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Cornelia Huck <cohuck@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Dave Martin <Dave.Martin@arm.com>
Cc: Marc Zyngier <marc.zyngier@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: James Morse <james.morse@arm.com>
---
 linux-headers/linux/kvm.h |  1 +
 target/arm/sdei.c         | 16 ++++++++++++++++
 target/arm/sdei.h         |  2 ++
 3 files changed, 19 insertions(+)

diff --git a/linux-headers/linux/kvm.h b/linux-headers/linux/kvm.h
index 3d9b18f7f8..36c9b3859f 100644
--- a/linux-headers/linux/kvm.h
+++ b/linux-headers/linux/kvm.h
@@ -1000,6 +1000,7 @@ struct kvm_ppc_resize_hpt {
 #define KVM_CAP_PMU_EVENT_FILTER 173
 #define KVM_CAP_ARM_IRQ_LINE_LAYOUT_2 174
 #define KVM_CAP_HYPERV_DIRECT_TLBFLUSH 175
+#define KVM_CAP_FORWARD_HYPERCALL 176
=20
 #ifdef KVM_CAP_IRQ_ROUTING
=20
diff --git a/target/arm/sdei.c b/target/arm/sdei.c
index 4cc68e4acf..56e6874f6f 100644
--- a/target/arm/sdei.c
+++ b/target/arm/sdei.c
@@ -46,6 +46,7 @@
 #define SMCCC_RETURN_REG_COUNT 4
 #define PSTATE_M_EL_SHIFT      2
=20
+bool sdei_enabled;
 static QemuSDEState *sde_state;
=20
 typedef struct QemuSDEIBindNotifyEntry {
@@ -1524,6 +1525,7 @@ static const VMStateDescription vmstate_sde_state =3D=
 {
 static void sdei_initfn(Object *obj)
 {
     QemuSDEState *s =3D QEMU_SDEI(obj);
+    KVMState *kvm =3D KVM_STATE(current_machine->accelerator);
=20
     if (sde_state) {
         error_report("Only one SDEI dispatcher is allowed!");
@@ -1533,6 +1535,20 @@ static void sdei_initfn(Object *obj)
=20
     qemu_sde_init(s);
     qemu_register_reset(qemu_sde_reset, s);
+
+    if (kvm_check_extension(kvm, KVM_CAP_FORWARD_HYPERCALL)) {
+        int ret;
+        ret =3D kvm_vm_enable_cap(kvm, KVM_CAP_FORWARD_HYPERCALL, 0, 0);
+        if (ret < 0) {
+            error_report("Enable hypercall forwarding failed: %s",
+                         strerror(-ret));
+            abort();
+        }
+        sdei_enabled =3D true;
+        info_report("qemu sdei enabled");
+    } else {
+        info_report("KVM does not support forwarding hypercall.");
+    }
 }
=20
 static void qemu_sde_class_init(ObjectClass *klass, void *data)
diff --git a/target/arm/sdei.h b/target/arm/sdei.h
index 9c15cf3186..9f683ca2a0 100644
--- a/target/arm/sdei.h
+++ b/target/arm/sdei.h
@@ -29,6 +29,8 @@
=20
 #define SDEI_MAX_REQ        SDEI_1_0_FN(0x12)
=20
+extern bool sdei_enabled;
+
 void sdei_handle_request(CPUState *cs, struct kvm_run *run);
=20
 /*
--=20
2.19.1



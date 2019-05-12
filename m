Return-Path: <SRS0=55mG=TM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44188C04A6B
	for <qemu-devel@archiver.kernel.org>; Sun, 12 May 2019 08:40:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 10FEE2146F
	for <qemu-devel@archiver.kernel.org>; Sun, 12 May 2019 08:40:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 10FEE2146F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:40489 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hPk20-00061v-7s
	for qemu-devel@archiver.kernel.org; Sun, 12 May 2019 04:40:28 -0400
Received: from eggs.gnu.org ([209.51.188.92]:38413)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <drjones@redhat.com>) id 1hPjzX-0004J8-3Y
	for qemu-devel@nongnu.org; Sun, 12 May 2019 04:37:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <drjones@redhat.com>) id 1hPjzV-0003l9-Fc
	for qemu-devel@nongnu.org; Sun, 12 May 2019 04:37:55 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48314)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <drjones@redhat.com>)
	id 1hPjyv-0003SA-Vp; Sun, 12 May 2019 04:37:49 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 6F69E811DC;
	Sun, 12 May 2019 08:37:16 +0000 (UTC)
Received: from kamzik.brq.redhat.com (ovpn-116-87.ams2.redhat.com
	[10.36.116.87])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 72C0E5D706;
	Sun, 12 May 2019 08:37:10 +0000 (UTC)
From: Andrew Jones <drjones@redhat.com>
To: qemu-devel@nongnu.org,
	qemu-arm@nongnu.org
Date: Sun, 12 May 2019 10:36:20 +0200
Message-Id: <20190512083624.8916-10-drjones@redhat.com>
In-Reply-To: <20190512083624.8916-1-drjones@redhat.com>
References: <20190512083624.8916-1-drjones@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.27]);
	Sun, 12 May 2019 08:37:16 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH 09/13] target/arm/kvm: Export
 kvm_arm_get_sve_vls
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

Signed-off-by: Andrew Jones <drjones@redhat.com>
---
 target/arm/kvm64.c   |  7 +++++--
 target/arm/kvm_arm.h | 20 ++++++++++++++++++++
 2 files changed, 25 insertions(+), 2 deletions(-)

diff --git a/target/arm/kvm64.c b/target/arm/kvm64.c
index 0c666e405357..11c6334a7c08 100644
--- a/target/arm/kvm64.c
+++ b/target/arm/kvm64.c
@@ -446,7 +446,8 @@ void kvm_arm_pmu_set_irq(CPUState *cs, int irq)
     }
 }
=20
-static int kvm_arm_get_sve_vls(CPUState *cs, uint64_t sve_vls[])
+int kvm_arm_get_sve_vls(CPUState *cs,
+                        uint64_t sve_vls[KVM_ARM64_SVE_VLS_WORDS])
 {
     struct kvm_one_reg reg =3D {
         .id =3D KVM_REG_ARM64_SVE_VLS,
@@ -470,7 +471,9 @@ static int kvm_arm_get_sve_vls(CPUState *cs, uint64_t=
 sve_vls[])
     return ret;
 }
=20
-static int kvm_arm_set_sve_vls(CPUState *cs, uint64_t sve_vls[], int max=
_vq)
+static int kvm_arm_set_sve_vls(CPUState *cs,
+                               uint64_t sve_vls[KVM_ARM64_SVE_VLS_WORDS]=
,
+                               int max_vq)
 {
     struct kvm_one_reg reg =3D {
         .id =3D KVM_REG_ARM64_SVE_VLS,
diff --git a/target/arm/kvm_arm.h b/target/arm/kvm_arm.h
index c488ec3ab410..748ed8d54985 100644
--- a/target/arm/kvm_arm.h
+++ b/target/arm/kvm_arm.h
@@ -248,6 +248,26 @@ int kvm_arm_vgic_probe(void);
 void kvm_arm_pmu_set_irq(CPUState *cs, int irq);
 void kvm_arm_pmu_init(CPUState *cs);
=20
+/**
+ * kvm_arm_get_sve_vls
+ * @cs: CPUState
+ * @sve_vls: valid vector length bitmap
+ *
+ * Get the valid vector length bitmap. If a bit 'bit' is set
+ * then the host supports a vector length of (bit * 16) bytes.
+ *
+ * For example, if
+ *
+ *   sve_vls[0] =3D 0xb and
+ *   sve_vls[1 ... KVM_ARM64_SVE_VLS_WORDS-1] =3D 0,
+ *
+ * then the host supports 16, 32, and 64 byte vector lengths.
+ *
+ * Returns: the highest set bit if successful else < 0 error code
+ */
+int kvm_arm_get_sve_vls(CPUState *cs,
+                        uint64_t sve_vls[KVM_ARM64_SVE_VLS_WORDS]);
+
 #else
=20
 static inline void kvm_arm_set_cpu_features_from_host(ARMCPU *cpu)
--=20
2.20.1



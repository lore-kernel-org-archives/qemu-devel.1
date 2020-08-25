Return-Path: <SRS0=2GMi=CD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 423EFC433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 19:37:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 141AE2076C
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 19:37:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="W6zTlZli"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 141AE2076C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54020 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAelV-0006t3-CA
	for qemu-devel@archiver.kernel.org; Tue, 25 Aug 2020 15:37:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40474)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kAeX9-0001z1-8q
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 15:23:03 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:32743
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kAeX7-0006JJ-DT
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 15:23:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598383380;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1S4mF7XDn/YfLOhnobfaHo5m/GoS2/+BYL/uLLG3xxY=;
 b=W6zTlZli8Zyo08ZBJjt/Nt+7l40JGMcvqmS2ZsO9wzXcTHhdNEgU7q2FUtSnUd7imkt/JM
 icfWEnTuhIiKl8vlUhS2OzCILlgpKBY8wcukXleAJsZFaEu+KY0APLnC+yfgUB3rNIbgOk
 Ashh2+0kx82b09xln8isjt9M0npNJWI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-440-sNZBitIsN_-VJF1z5ti3sg-1; Tue, 25 Aug 2020 15:22:58 -0400
X-MC-Unique: sNZBitIsN_-VJF1z5ti3sg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8EAF4189E605;
 Tue, 25 Aug 2020 19:22:57 +0000 (UTC)
Received: from localhost (unknown [10.10.67.254])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 13FA5100238E;
 Tue, 25 Aug 2020 19:22:51 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 46/74] x86-iommu: Rename QOM type macros
Date: Tue, 25 Aug 2020 15:20:42 -0400
Message-Id: <20200825192110.3528606-47-ehabkost@redhat.com>
In-Reply-To: <20200825192110.3528606-1-ehabkost@redhat.com>
References: <20200825192110.3528606-1-ehabkost@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=ehabkost@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=ehabkost@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/25 01:35:36
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.958,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: "Daniel P. Berrange" <berrange@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Peter Xu <peterx@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Some QOM macros were using a X86_IOMMU_DEVICE prefix, and others
were using a X86_IOMMU prefix.  Rename all of them to use the
same X86_IOMMU_DEVICE prefix.

This will make future conversion to OBJECT_DECLARE* easier.

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
Changes series v2 -> v3: new patch added to series v3

---
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Richard Henderson <rth@twiddle.net>
Cc: Eduardo Habkost <ehabkost@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Cc: Peter Xu <peterx@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>
Cc: qemu-devel@nongnu.org

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 include/hw/i386/x86-iommu.h | 4 ++--
 hw/i386/amd_iommu.c         | 2 +-
 hw/i386/intel_iommu.c       | 2 +-
 hw/i386/x86-iommu.c         | 2 +-
 target/i386/kvm.c           | 2 +-
 5 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/include/hw/i386/x86-iommu.h b/include/hw/i386/x86-iommu.h
index 8e10383b11..18420ada15 100644
--- a/include/hw/i386/x86-iommu.h
+++ b/include/hw/i386/x86-iommu.h
@@ -27,9 +27,9 @@
 #define  TYPE_X86_IOMMU_DEVICE  ("x86-iommu")
 #define  X86_IOMMU_DEVICE(obj) \
     OBJECT_CHECK(X86IOMMUState, (obj), TYPE_X86_IOMMU_DEVICE)
-#define  X86_IOMMU_CLASS(klass) \
+#define  X86_IOMMU_DEVICE_CLASS(klass) \
     OBJECT_CLASS_CHECK(X86IOMMUClass, (klass), TYPE_X86_IOMMU_DEVICE)
-#define  X86_IOMMU_GET_CLASS(obj) \
+#define  X86_IOMMU_DEVICE_GET_CLASS(obj) \
     OBJECT_GET_CLASS(X86IOMMUClass, obj, TYPE_X86_IOMMU_DEVICE)
 
 #define X86_IOMMU_SID_INVALID             (0xffff)
diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
index 087f601666..88373047e2 100644
--- a/hw/i386/amd_iommu.c
+++ b/hw/i386/amd_iommu.c
@@ -1600,7 +1600,7 @@ static void amdvi_instance_init(Object *klass)
 static void amdvi_class_init(ObjectClass *klass, void* data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
-    X86IOMMUClass *dc_class = X86_IOMMU_CLASS(klass);
+    X86IOMMUClass *dc_class = X86_IOMMU_DEVICE_CLASS(klass);
 
     dc->reset = amdvi_reset;
     dc->vmsd = &vmstate_amdvi;
diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index 5284bb68b6..ac4c99258e 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -3854,7 +3854,7 @@ static void vtd_realize(DeviceState *dev, Error **errp)
 static void vtd_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
-    X86IOMMUClass *x86_class = X86_IOMMU_CLASS(klass);
+    X86IOMMUClass *x86_class = X86_IOMMU_DEVICE_CLASS(klass);
 
     dc->reset = vtd_reset;
     dc->vmsd = &vtd_vmstate;
diff --git a/hw/i386/x86-iommu.c b/hw/i386/x86-iommu.c
index 4104060e68..5f4301639c 100644
--- a/hw/i386/x86-iommu.c
+++ b/hw/i386/x86-iommu.c
@@ -107,7 +107,7 @@ IommuType x86_iommu_get_type(void)
 static void x86_iommu_realize(DeviceState *dev, Error **errp)
 {
     X86IOMMUState *x86_iommu = X86_IOMMU_DEVICE(dev);
-    X86IOMMUClass *x86_class = X86_IOMMU_GET_CLASS(dev);
+    X86IOMMUClass *x86_class = X86_IOMMU_DEVICE_GET_CLASS(dev);
     MachineState *ms = MACHINE(qdev_get_machine());
     MachineClass *mc = MACHINE_GET_CLASS(ms);
     PCMachineState *pcms =
diff --git a/target/i386/kvm.c b/target/i386/kvm.c
index 6f18d940a5..205b68bc0c 100644
--- a/target/i386/kvm.c
+++ b/target/i386/kvm.c
@@ -4607,7 +4607,7 @@ int kvm_arch_fixup_msi_route(struct kvm_irq_routing_entry *route,
     if (iommu) {
         int ret;
         MSIMessage src, dst;
-        X86IOMMUClass *class = X86_IOMMU_GET_CLASS(iommu);
+        X86IOMMUClass *class = X86_IOMMU_DEVICE_GET_CLASS(iommu);
 
         if (!class->int_remap) {
             return 0;
-- 
2.26.2



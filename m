Return-Path: <SRS0=ff1W=CL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD65DC433E7
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 11:56:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 98DBB206E7
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 11:56:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PBSAXgc2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 98DBB206E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43668 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDRMw-0006qW-Q7
	for qemu-devel@archiver.kernel.org; Wed, 02 Sep 2020 07:56:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46840)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kDRKb-00022K-RQ
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 07:53:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:30003)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kDRKZ-0006uJ-Rr
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 07:53:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599047614;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RvF/EgUOlRC4VugjM3rkfY1jPw+PmkOTEUrvUZ7/l4M=;
 b=PBSAXgc2Lj8h/rgLUrnhWI4Z4IToaVxgM2PmwaWlDT1KeIfbJVzmjEFBwlSMUTSo+k1BZN
 ZN5d1nj0t7Zd1Jq3fhynOgkB6X0lGivDdBlyDu/EMGPu681HbSs/8SGsBybhtRW5dC0xkx
 cSRht+RGnKfeK5LOgB2L8DtV2KlZ+bY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-240-Qgu-e1W7OL--C--Qswm3hg-1; Wed, 02 Sep 2020 07:53:33 -0400
X-MC-Unique: Qgu-e1W7OL--C--Qswm3hg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DADCC1DE00;
 Wed,  2 Sep 2020 11:53:31 +0000 (UTC)
Received: from localhost (ovpn-66-226.rdu2.redhat.com [10.10.66.226])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C94845C1C7;
 Wed,  2 Sep 2020 11:53:28 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
To: qemu-devel@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 03/20] x86-iommu: Rename QOM type macros
Date: Wed,  2 Sep 2020 07:53:06 -0400
Message-Id: <20200902115323.850385-4-ehabkost@redhat.com>
In-Reply-To: <20200902115323.850385-1-ehabkost@redhat.com>
References: <20200902115323.850385-1-ehabkost@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=ehabkost@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=ehabkost@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/02 02:42:29
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Peter Xu <peterx@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Some QOM macros were using a X86_IOMMU_DEVICE prefix, and others
were using a X86_IOMMU prefix.  Rename all of them to use the
same X86_IOMMU_DEVICE prefix.

This will make future conversion to OBJECT_DECLARE* easier.

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
Message-Id: <20200825192110.3528606-47-ehabkost@redhat.com>
Acked-by: Peter Xu <peterx@redhat.com>
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
index 18411f1dec..74a93a5d93 100644
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
index 0d7c4303b4..749eb6ad63 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -3853,7 +3853,7 @@ static void vtd_realize(DeviceState *dev, Error **errp)
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



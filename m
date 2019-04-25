Return-Path: <SRS0=VSQP=S3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2015DC43218
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Apr 2019 18:17:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 99F5B206C0
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Apr 2019 18:17:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 99F5B206C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:33529 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hJiwS-0006Na-9Y
	for qemu-devel@archiver.kernel.org; Thu, 25 Apr 2019 14:17:52 -0400
Received: from eggs.gnu.org ([209.51.188.92]:45883)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1hJisk-0003N7-RO
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 14:14:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1hJisj-0002Rb-Pj
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 14:14:02 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35118)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1hJisj-0002NC-JP
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 14:14:01 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B6CEF3082230;
	Thu, 25 Apr 2019 18:13:59 +0000 (UTC)
Received: from localhost (ovpn-116-9.gru2.redhat.com [10.97.116.9])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 2386E600C0;
	Thu, 25 Apr 2019 18:13:56 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>,
	qemu-devel@nongnu.org
Date: Thu, 25 Apr 2019 15:13:41 -0300
Message-Id: <20190425181342.15360-4-ehabkost@redhat.com>
In-Reply-To: <20190425181342.15360-1-ehabkost@redhat.com>
References: <20190425181342.15360-1-ehabkost@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.47]);
	Thu, 25 Apr 2019 18:13:59 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 3/4] Categorize devices: iommu
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
Cc: Eduardo Habkost <ehabkost@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>, Ernest Esene <eroken1@gmail.com>,
	Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190425181341.7oaTheTSFb5DcFwWQuGXZJYhZHnOzjDuGPkLj-YmhNw@z>

From: Ernest Esene <eroken1@gmail.com>

Set category and description for iommu devices.

Signed-off-by: Ernest Esene <eroken1@gmail.com>
Message-Id: <20190327170518.GA16887@erokenlabserver>
Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>
[ehabkost: edited commit message]
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 hw/i386/amd_iommu.c   | 2 ++
 hw/i386/intel_iommu.c | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
index 6eabdf9917..4a4e2c7fd4 100644
--- a/hw/i386/amd_iommu.c
+++ b/hw/i386/amd_iommu.c
@@ -1601,6 +1601,8 @@ static void amdvi_class_init(ObjectClass *klass, void* data)
     dc_class->int_remap = amdvi_int_remap;
     /* Supported by the pc-q35-* machine types */
     dc->user_creatable = true;
+    set_bit(DEVICE_CATEGORY_MISC, dc->categories);
+    dc->desc = "AMD IOMMU (AMD-Vi) DMA Remapping device";
 }
 
 static const TypeInfo amdvi = {
diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index 2558f48fe6..44b1231157 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -3741,6 +3741,8 @@ static void vtd_class_init(ObjectClass *klass, void *data)
     x86_class->int_remap = vtd_int_remap;
     /* Supported by the pc-q35-* machine types */
     dc->user_creatable = true;
+    set_bit(DEVICE_CATEGORY_MISC, dc->categories);
+    dc->desc = "Intel IOMMU (VT-d) DMA Remapping device";
 }
 
 static const TypeInfo vtd_info = {
-- 
2.18.0.rc1.1.g3f1ff2140



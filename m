Return-Path: <SRS0=ES4k=XM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3894C4CEC9
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2019 15:24:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B7089214AF
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2019 15:24:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B7089214AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47256 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iAFL3-0005bt-Md
	for qemu-devel@archiver.kernel.org; Tue, 17 Sep 2019 11:24:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60208)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1iAF8J-0002ej-Hu
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 11:11:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1iAF8I-0000Sq-9o
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 11:11:11 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59688)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1iAF8I-0000SN-1z
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 11:11:10 -0400
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 4A690C004E8D
 for <qemu-devel@nongnu.org>; Tue, 17 Sep 2019 15:11:09 +0000 (UTC)
Received: by mail-qt1-f198.google.com with SMTP id m6so4526365qtk.23
 for <qemu-devel@nongnu.org>; Tue, 17 Sep 2019 08:11:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=0SUJxzhl2HyacdazgtJ5RZ46nr04RGwmTyfEsUsCRm0=;
 b=Z66VkE0yjMhn/5H2+JR/Fp7SO8TX8ZNmtl8ogQS+3Ab3eK6iRZv5LLto0Ci0fseLdj
 AikR6B9dlx+oVORec1lFy88GCWCBnBb/9k3FoVzrQ7W41PeFAc4hOvchQ1qYOan6/rGw
 JGglgxxsTnzd/R0WHdRwscnURSKlH/XNn37PNUhP8i+dFGpS5/IshcLj37y7tZcKerCL
 3vzeNqzM4ZT7dLmacvzsH38u6/voMIjBhwE5SX9YZF8vEFqqLt5zZfWbQLQZlwYjkkKU
 0Gj9yRQqyhY3US0jWO1kP2v2pr512dwMiKfg3L6VYuvMBMOxT3rr5XL7V2i9+BrCeKUv
 2tjg==
X-Gm-Message-State: APjAAAUvBLgBgj/V5Ybs25DPkEDb6/B1/HJA1VFwJFaGb67UM35Xb/yo
 KPOnt/tKoSLt0ozYtqff3/bmMaI2rT5VBp5zDw1psKtfXLPfeYyqE7akjjXDjPw2oCw8Prfc+lb
 F4yIwUyotMDII8Aw=
X-Received: by 2002:ae9:f403:: with SMTP id y3mr4261430qkl.148.1568733068330; 
 Tue, 17 Sep 2019 08:11:08 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwJnaFs9GPFt1Dq4CfkEE+zoSqxbm7oEkfiZNWMXLgX+YnEz+NFh1vV0cMlXCVjmuan+XxE7A==
X-Received: by 2002:ae9:f403:: with SMTP id y3mr4261411qkl.148.1568733068154; 
 Tue, 17 Sep 2019 08:11:08 -0700 (PDT)
Received: from redhat.com (bzq-79-176-40-226.red.bezeqint.net. [79.176.40.226])
 by smtp.gmail.com with ESMTPSA id d25sm1093070qtn.51.2019.09.17.08.11.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Sep 2019 08:11:07 -0700 (PDT)
Date: Tue, 17 Sep 2019 11:11:03 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Message-ID: <20190916080718.3299-4-peterx@redhat.com>
References: <20190917151011.24588-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
In-Reply-To: <20190917151011.24588-1-mst@redhat.com>
X-Mailer: git-send-email 2.22.0.678.g13338e74b8
X-Mutt-Fcc: =sent
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 07/10] pc/q35: Disallow vfio-pci hotplug without
 VT-d caching mode
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Eduardo Habkost <ehabkost@redhat.com>, Peter Xu <peterx@redhat.com>,
 Eric Auger <eric.auger@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190917151103.QszxrNcT3PfOMqTPpliImpg1BjLQeKjNS1dXVFyVjwk@z>

From: Peter Xu <peterx@redhat.com>

Instead of bailing out when trying to hotplug a vfio-pci device with
below configuration:

  -device intel-iommu,caching-mode=off

With this we can return a warning message to the user via QMP/HMP and
the VM will continue to work after failing the hotplug:

  (qemu) device_add vfio-pci,bus=root.3,host=05:00.0,id=vfio1
  Error: Device assignment is not allowed without enabling caching-mode=on for Intel IOMMU.

Reviewed-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
Message-Id: <20190916080718.3299-4-peterx@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/i386/pc.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index bad866fe44..0a6fa6e549 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -2944,6 +2944,26 @@ static void x86_nmi(NMIState *n, int cpu_index, Error **errp)
     }
 }
 
+
+static bool pc_hotplug_allowed(MachineState *ms, DeviceState *dev, Error **errp)
+{
+    X86IOMMUState *iommu = x86_iommu_get_default();
+    IntelIOMMUState *intel_iommu;
+
+    if (iommu &&
+        object_dynamic_cast((Object *)iommu, TYPE_INTEL_IOMMU_DEVICE) &&
+        object_dynamic_cast((Object *)dev, "vfio-pci")) {
+        intel_iommu = INTEL_IOMMU_DEVICE(iommu);
+        if (!intel_iommu->caching_mode) {
+            error_setg(errp, "Device assignment is not allowed without "
+                       "enabling caching-mode=on for Intel IOMMU.");
+            return false;
+        }
+    }
+
+    return true;
+}
+
 static void pc_machine_class_init(ObjectClass *oc, void *data)
 {
     MachineClass *mc = MACHINE_CLASS(oc);
@@ -2968,6 +2988,7 @@ static void pc_machine_class_init(ObjectClass *oc, void *data)
     pcmc->pvh_enabled = true;
     assert(!mc->get_hotplug_handler);
     mc->get_hotplug_handler = pc_get_hotplug_handler;
+    mc->hotplug_allowed = pc_hotplug_allowed;
     mc->cpu_index_to_instance_props = pc_cpu_index_to_props;
     mc->get_default_cpu_node_id = pc_get_default_cpu_node_id;
     mc->possible_cpu_arch_ids = pc_possible_cpu_arch_ids;
-- 
MST



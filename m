Return-Path: <SRS0=kH2x=XL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 491BCC49ED7
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Sep 2019 08:01:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1D764206C2
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Sep 2019 08:01:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D764206C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59696 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i9lxE-0007m3-IO
	for qemu-devel@archiver.kernel.org; Mon, 16 Sep 2019 04:01:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54462)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peterx@redhat.com>) id 1i9luf-00065l-Ay
 for qemu-devel@nongnu.org; Mon, 16 Sep 2019 03:59:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peterx@redhat.com>) id 1i9lue-0006DL-21
 for qemu-devel@nongnu.org; Mon, 16 Sep 2019 03:59:09 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34430)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <peterx@redhat.com>) id 1i9lud-0006Cv-Q3
 for qemu-devel@nongnu.org; Mon, 16 Sep 2019 03:59:07 -0400
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id E92F94E926
 for <qemu-devel@nongnu.org>; Mon, 16 Sep 2019 07:59:06 +0000 (UTC)
Received: by mail-pl1-f198.google.com with SMTP id y2so3861649plk.19
 for <qemu-devel@nongnu.org>; Mon, 16 Sep 2019 00:59:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=yTFkaA7FK1OtMJ5ZNEIyQVGHTHHaCs6uZL+0B9ty2Rc=;
 b=UL8wS7wGoTP6UqD5GcKkO9CqTeieWiTlje3ZVYFb+OptiRuzLTfwrCNFhkfbfJFIjo
 WfaHWdGSW0ZCnze+Sg39QdFTyj57A3q27bErHl0IzsX1iFFeSpETdaRyE0FGHSdis9pB
 gsbJCB6IzQ7LEUNd0rrrQpGy4Q7TMHeNx4l7yYuOwe5EO78ibc9ZiBP6OCmvhHMq4Dza
 +jtnTAO1svgBgdiQjqS57pAC4HLmUDiCKPJyhvboCNhhc4IhlbRW1DO2H3X5Dz7fGZhU
 RxYY/nxkyWy2C7Aw/Bii9gI1FxopNyAEMrpS0jMduPOnF/7bra2ly1FYtgvVoB8OYpPC
 uxKQ==
X-Gm-Message-State: APjAAAUqpKf6xyqbi0bPx0sEwViuDSSZONMCiPmpx00gwegjbP4wAKwm
 HzvGu2EG+PhVm+zNlciywpZkHnvQIi0kYDICsfnCxDd9I6/n/Fk6PsY+K+vQZ/mWT8uMBuLnGoC
 aJzRo7VF5S5Zf7nY=
X-Received: by 2002:a62:3083:: with SMTP id
 w125mr70558233pfw.102.1568620745921; 
 Mon, 16 Sep 2019 00:59:05 -0700 (PDT)
X-Google-Smtp-Source: APXvYqyvVB+BB49/z3oDpVv8YcFiaZgt1auvp2Z+s4bu/1iUW9zj8mDLeKUZExmrMkLlbQMlbHhIlg==
X-Received: by 2002:a62:3083:: with SMTP id
 w125mr70558216pfw.102.1568620745766; 
 Mon, 16 Sep 2019 00:59:05 -0700 (PDT)
Received: from xz-x1.redhat.com ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id p20sm50321443pgi.81.2019.09.16.00.59.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Sep 2019 00:59:04 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Date: Mon, 16 Sep 2019 15:58:38 +0800
Message-Id: <20190916075839.390-4-peterx@redhat.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190916075839.390-1-peterx@redhat.com>
References: <20190916075839.390-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v2 3/4] pc/q35: Disallow vfio-pci hotplug
 without VT-d caching mode
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
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Jason Wang <jasowang@redhat.com>, Alex Williamson <alex.williamson@redhat.com>,
 peterx@redhat.com, Bandan Das <bsd@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Instead of bailing out when trying to hotplug a vfio-pci device with
below configuration:

  -device intel-iommu,caching-mode=3Doff

With this we can return a warning message to the user via QMP/HMP and
the VM will continue to work after failing the hotplug:

  (qemu) device_add vfio-pci,bus=3Droot.3,host=3D05:00.0,id=3Dvfio1
  Error: Device assignment is not allowed without enabling caching-mode=3D=
on for Intel IOMMU.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 hw/i386/pc.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index bad866fe44..0a6fa6e549 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -2944,6 +2944,26 @@ static void x86_nmi(NMIState *n, int cpu_index, Er=
ror **errp)
     }
 }
=20
+
+static bool pc_hotplug_allowed(MachineState *ms, DeviceState *dev, Error=
 **errp)
+{
+    X86IOMMUState *iommu =3D x86_iommu_get_default();
+    IntelIOMMUState *intel_iommu;
+
+    if (iommu &&
+        object_dynamic_cast((Object *)iommu, TYPE_INTEL_IOMMU_DEVICE) &&
+        object_dynamic_cast((Object *)dev, "vfio-pci")) {
+        intel_iommu =3D INTEL_IOMMU_DEVICE(iommu);
+        if (!intel_iommu->caching_mode) {
+            error_setg(errp, "Device assignment is not allowed without "
+                       "enabling caching-mode=3Don for Intel IOMMU.");
+            return false;
+        }
+    }
+
+    return true;
+}
+
 static void pc_machine_class_init(ObjectClass *oc, void *data)
 {
     MachineClass *mc =3D MACHINE_CLASS(oc);
@@ -2968,6 +2988,7 @@ static void pc_machine_class_init(ObjectClass *oc, =
void *data)
     pcmc->pvh_enabled =3D true;
     assert(!mc->get_hotplug_handler);
     mc->get_hotplug_handler =3D pc_get_hotplug_handler;
+    mc->hotplug_allowed =3D pc_hotplug_allowed;
     mc->cpu_index_to_instance_props =3D pc_cpu_index_to_props;
     mc->get_default_cpu_node_id =3D pc_get_default_cpu_node_id;
     mc->possible_cpu_arch_ids =3D pc_possible_cpu_arch_ids;
--=20
2.21.0



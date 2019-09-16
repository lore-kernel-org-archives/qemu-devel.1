Return-Path: <SRS0=kH2x=XL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D344C49ED7
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Sep 2019 08:13:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1240D206C2
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Sep 2019 08:13:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1240D206C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59826 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i9m8v-0002Z4-9F
	for qemu-devel@archiver.kernel.org; Mon, 16 Sep 2019 04:13:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55999)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peterx@redhat.com>) id 1i9m31-000520-Ve
 for qemu-devel@nongnu.org; Mon, 16 Sep 2019 04:07:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peterx@redhat.com>) id 1i9m30-0002A4-Rn
 for qemu-devel@nongnu.org; Mon, 16 Sep 2019 04:07:47 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36774)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <peterx@redhat.com>) id 1i9m30-00029o-KC
 for qemu-devel@nongnu.org; Mon, 16 Sep 2019 04:07:46 -0400
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id E28264E926
 for <qemu-devel@nongnu.org>; Mon, 16 Sep 2019 08:07:45 +0000 (UTC)
Received: by mail-pl1-f199.google.com with SMTP id y18so1946239pll.17
 for <qemu-devel@nongnu.org>; Mon, 16 Sep 2019 01:07:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=w4YQkHRbAbpUMWjqlM+JKSO/9Aa2mvQClFqu2zmR7Cs=;
 b=OtJoWD2amFJcBBplSHKTDMPTd4zp5aqMsXXU6kw6vXjuG846Z88JO+nOS9c9kwB3lB
 tbhdXuZ9VkrmWwXXzbMM5E15gxOyRqipyMaevAVUsiOZVpVMEFv6T14lXcuGybucAMWL
 gW5o0kWeHZZwyM6VmMUeI7eBcVhTdX0zFGlV/dXBQ3XdMld0ZRb8BHR5Bhw57uSbtiHs
 SH1srLOvDlfqUQD/TR+JAWZjAF5ja2hQSEHPX6WEkQ5fhn7Svy/x2HhZGH1MqwLTR0+y
 w2x8TE6gMKilG2QrnOW2F2KZOf7tOWjxoU1F6fl20awx4Fzg5La8deNNJtmU+eyhvVzm
 fMEQ==
X-Gm-Message-State: APjAAAWafuDC5NUo/lYv/mo+z59zWt0RJAebuoKL3vB8fevxIPEGYWiW
 lEIkPoc9u9ltBFPKAATm7UAtKCbqS2YFuhDrgGG8bUC9GofbYQ8daYDqjQwGtTR0qtYiyL9Psy+
 LzwSjgWIV2ZUfxB8=
X-Received: by 2002:a17:902:6f0f:: with SMTP id
 w15mr40939017plk.200.1568621265152; 
 Mon, 16 Sep 2019 01:07:45 -0700 (PDT)
X-Google-Smtp-Source: APXvYqyY8y/5KQ4cJjx+NMoALbWDhGCiryj/G1MdFekoqxjP9Th4h8FTBQllNinNiJs2BbHpTE9EIw==
X-Received: by 2002:a17:902:6f0f:: with SMTP id
 w15mr40938988plk.200.1568621264923; 
 Mon, 16 Sep 2019 01:07:44 -0700 (PDT)
Received: from xz-x1.redhat.com ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id r12sm43051515pgb.73.2019.09.16.01.07.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Sep 2019 01:07:44 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Date: Mon, 16 Sep 2019 16:07:17 +0800
Message-Id: <20190916080718.3299-4-peterx@redhat.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190916080718.3299-1-peterx@redhat.com>
References: <20190916080718.3299-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v3 3/4] pc/q35: Disallow vfio-pci hotplug
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
 peterx@redhat.com, Eric Auger <eric.auger@redhat.com>,
 Bandan Das <bsd@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>
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

Reviewed-by: Eric Auger <eric.auger@redhat.com>
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



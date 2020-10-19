Return-Path: <SRS0=qJMs=D2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22EE4C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2020 08:50:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7C75020790
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2020 08:50:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C75020790
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51518 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUQrx-0005Bd-88
	for qemu-devel@archiver.kernel.org; Mon, 19 Oct 2020 04:50:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38002)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1kUQq2-0003iq-Jk
 for qemu-devel@nongnu.org; Mon, 19 Oct 2020 04:48:20 -0400
Received: from us-smtp-delivery-44.mimecast.com ([207.211.30.44]:39966)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1kUQq1-0002ht-3f
 for qemu-devel@nongnu.org; Mon, 19 Oct 2020 04:48:18 -0400
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-127-BUdTnnOoMEe6vAsWEdgxnQ-1; Mon, 19 Oct 2020 04:48:12 -0400
X-MC-Unique: BUdTnnOoMEe6vAsWEdgxnQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D508E1084C81;
 Mon, 19 Oct 2020 08:48:10 +0000 (UTC)
Received: from bahia.lan (ovpn-112-78.ams2.redhat.com [10.36.112.78])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6C2FE5D9EF;
 Mon, 19 Oct 2020 08:48:05 +0000 (UTC)
Subject: [PATCH 1/5] pc-dimm: Drop @errp argument of pc_dimm_plug()
From: Greg Kurz <groug@kaod.org>
To: David Gibson <david@gibson.dropbear.id.au>
Date: Mon, 19 Oct 2020 10:48:04 +0200
Message-ID: <160309728447.2739814.12831204841251148202.stgit@bahia.lan>
In-Reply-To: <160309727218.2739814.14722724927730985344.stgit@bahia.lan>
References: <160309727218.2739814.14722724927730985344.stgit@bahia.lan>
User-Agent: StGit/0.21
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: kaod.org
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: softfail client-ip=207.211.30.44; envelope-from=groug@kaod.org;
 helo=us-smtp-delivery-44.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/19 04:48:16
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -11
X-Spam_score: -1.2
X-Spam_bar: -
X-Spam_report: (-1.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_SOFTFAIL=0.665 autolearn=no autolearn_force=no
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "Daniel P. Berrange" <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

pc_dimm_plug() doesn't use it. It only aborts on error.

Drop @errp and adapt the callers accordingly.

Signed-off-by: Greg Kurz <groug@kaod.org>
---
 hw/arm/virt.c            |    9 +--------
 hw/i386/pc.c             |    8 +-------
 hw/mem/pc-dimm.c         |    2 +-
 hw/ppc/spapr.c           |    5 +----
 include/hw/mem/pc-dimm.h |    2 +-
 5 files changed, 5 insertions(+), 21 deletions(-)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index e465a988d683..27dbeb549ef1 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -2261,12 +2261,8 @@ static void virt_memory_plug(HotplugHandler *hotplug=
_dev,
     VirtMachineState *vms =3D VIRT_MACHINE(hotplug_dev);
     MachineState *ms =3D MACHINE(hotplug_dev);
     bool is_nvdimm =3D object_dynamic_cast(OBJECT(dev), TYPE_NVDIMM);
-    Error *local_err =3D NULL;
=20
-    pc_dimm_plug(PC_DIMM(dev), MACHINE(vms), &local_err);
-    if (local_err) {
-        goto out;
-    }
+    pc_dimm_plug(PC_DIMM(dev), MACHINE(vms));
=20
     if (is_nvdimm) {
         nvdimm_plug(ms->nvdimms_state);
@@ -2274,9 +2270,6 @@ static void virt_memory_plug(HotplugHandler *hotplug_=
dev,
=20
     hotplug_handler_plug(HOTPLUG_HANDLER(vms->acpi_dev),
                          dev, &error_abort);
-
-out:
-    error_propagate(errp, local_err);
 }
=20
 static void virt_machine_device_pre_plug_cb(HotplugHandler *hotplug_dev,
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index e87be5d29a01..38b1be78e707 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -1265,24 +1265,18 @@ static void pc_memory_pre_plug(HotplugHandler *hotp=
lug_dev, DeviceState *dev,
 static void pc_memory_plug(HotplugHandler *hotplug_dev,
                            DeviceState *dev, Error **errp)
 {
-    Error *local_err =3D NULL;
     PCMachineState *pcms =3D PC_MACHINE(hotplug_dev);
     X86MachineState *x86ms =3D X86_MACHINE(hotplug_dev);
     MachineState *ms =3D MACHINE(hotplug_dev);
     bool is_nvdimm =3D object_dynamic_cast(OBJECT(dev), TYPE_NVDIMM);
=20
-    pc_dimm_plug(PC_DIMM(dev), MACHINE(pcms), &local_err);
-    if (local_err) {
-        goto out;
-    }
+    pc_dimm_plug(PC_DIMM(dev), MACHINE(pcms));
=20
     if (is_nvdimm) {
         nvdimm_plug(ms->nvdimms_state);
     }
=20
     hotplug_handler_plug(x86ms->acpi_dev, dev, &error_abort);
-out:
-    error_propagate(errp, local_err);
 }
=20
 static void pc_memory_unplug_request(HotplugHandler *hotplug_dev,
diff --git a/hw/mem/pc-dimm.c b/hw/mem/pc-dimm.c
index c30351070bb8..2ffc986734df 100644
--- a/hw/mem/pc-dimm.c
+++ b/hw/mem/pc-dimm.c
@@ -64,7 +64,7 @@ void pc_dimm_pre_plug(PCDIMMDevice *dimm, MachineState *m=
achine,
                            errp);
 }
=20
-void pc_dimm_plug(PCDIMMDevice *dimm, MachineState *machine, Error **errp)
+void pc_dimm_plug(PCDIMMDevice *dimm, MachineState *machine)
 {
     PCDIMMDeviceClass *ddc =3D PC_DIMM_GET_CLASS(dimm);
     MemoryRegion *vmstate_mr =3D ddc->get_vmstate_memory_region(dimm,
diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index ee716a12af73..4edd31b86915 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -3438,10 +3438,7 @@ static void spapr_memory_plug(HotplugHandler *hotplu=
g_dev, DeviceState *dev,
=20
     size =3D memory_device_get_region_size(MEMORY_DEVICE(dev), &error_abor=
t);
=20
-    pc_dimm_plug(dimm, MACHINE(ms), &local_err);
-    if (local_err) {
-        goto out;
-    }
+    pc_dimm_plug(dimm, MACHINE(ms));
=20
     if (!is_nvdimm) {
         addr =3D object_property_get_uint(OBJECT(dimm),
diff --git a/include/hw/mem/pc-dimm.h b/include/hw/mem/pc-dimm.h
index aec9527fdd96..3d3db82641f8 100644
--- a/include/hw/mem/pc-dimm.h
+++ b/include/hw/mem/pc-dimm.h
@@ -72,6 +72,6 @@ struct PCDIMMDeviceClass {
=20
 void pc_dimm_pre_plug(PCDIMMDevice *dimm, MachineState *machine,
                       const uint64_t *legacy_align, Error **errp);
-void pc_dimm_plug(PCDIMMDevice *dimm, MachineState *machine, Error **errp)=
;
+void pc_dimm_plug(PCDIMMDevice *dimm, MachineState *machine);
 void pc_dimm_unplug(PCDIMMDevice *dimm, MachineState *machine);
 #endif




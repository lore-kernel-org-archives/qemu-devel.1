Return-Path: <SRS0=gwGE=EC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 191D5C388F9
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 14:33:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 88ED520773
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 14:33:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="T/y4oVxa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 88ED520773
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32768 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXQ2R-00035j-Hh
	for qemu-devel@archiver.kernel.org; Tue, 27 Oct 2020 10:33:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42508)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1kXPnd-0002C3-5z; Tue, 27 Oct 2020 10:18:09 -0400
Received: from bilbo.ozlabs.org ([2401:3900:2:1::2]:56839 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1kXPnX-0007an-1v; Tue, 27 Oct 2020 10:18:08 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 4CLDLh41MVz9shn; Wed, 28 Oct 2020 01:17:48 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1603808268;
 bh=P4QF3AHoKu5yc1hRA000h5HhsxKSdyQqUikcF4VvZgQ=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=T/y4oVxa17mR4m2Gef07MJBeCiRqHTIprEhMe/FHtO+qEdGcD9g5aA5D4AFUGCQ9I
 1p9rHQNOGwr+wfXmcpOYRIpSduYtS+n5VpmuxEqZh4toldTpiJ6V3AvRYc1QF9jMzN
 MY1xj+ADoonUSdszHVio0eC2gG0QQtRbAnGs9Ids=
From: David Gibson <david@gibson.dropbear.id.au>
To: peter.maydell@linaro.org
Subject: [PULL 10/18] pc-dimm: Drop @errp argument of pc_dimm_plug()
Date: Wed, 28 Oct 2020 01:17:27 +1100
Message-Id: <20201027141735.728821-11-david@gibson.dropbear.id.au>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201027141735.728821-1-david@gibson.dropbear.id.au>
References: <20201027141735.728821-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2401:3900:2:1::2; envelope-from=dgibson@ozlabs.org;
 helo=ozlabs.org
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org, groug@kaod.org, qemu-ppc@nongnu.org,
 Igor Mammedov <imammedo@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Greg Kurz <groug@kaod.org>

pc_dimm_plug() doesn't use it. It only aborts on error.

Drop @errp and adapt the callers accordingly.

[dwg: Removed unused label to fix compile]
Signed-off-by: Greg Kurz <groug@kaod.org>
Message-Id: <160309728447.2739814.12831204841251148202.stgit@bahia.lan>
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/arm/virt.c            | 9 +--------
 hw/i386/pc.c             | 8 +-------
 hw/mem/pc-dimm.c         | 2 +-
 hw/ppc/spapr.c           | 6 +-----
 include/hw/mem/pc-dimm.h | 2 +-
 5 files changed, 5 insertions(+), 22 deletions(-)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index e465a988d6..27dbeb549e 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -2261,12 +2261,8 @@ static void virt_memory_plug(HotplugHandler *hotplug_dev,
     VirtMachineState *vms = VIRT_MACHINE(hotplug_dev);
     MachineState *ms = MACHINE(hotplug_dev);
     bool is_nvdimm = object_dynamic_cast(OBJECT(dev), TYPE_NVDIMM);
-    Error *local_err = NULL;
 
-    pc_dimm_plug(PC_DIMM(dev), MACHINE(vms), &local_err);
-    if (local_err) {
-        goto out;
-    }
+    pc_dimm_plug(PC_DIMM(dev), MACHINE(vms));
 
     if (is_nvdimm) {
         nvdimm_plug(ms->nvdimms_state);
@@ -2274,9 +2270,6 @@ static void virt_memory_plug(HotplugHandler *hotplug_dev,
 
     hotplug_handler_plug(HOTPLUG_HANDLER(vms->acpi_dev),
                          dev, &error_abort);
-
-out:
-    error_propagate(errp, local_err);
 }
 
 static void virt_machine_device_pre_plug_cb(HotplugHandler *hotplug_dev,
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 4e323755d0..0d9bd7d635 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -1265,24 +1265,18 @@ static void pc_memory_pre_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
 static void pc_memory_plug(HotplugHandler *hotplug_dev,
                            DeviceState *dev, Error **errp)
 {
-    Error *local_err = NULL;
     PCMachineState *pcms = PC_MACHINE(hotplug_dev);
     X86MachineState *x86ms = X86_MACHINE(hotplug_dev);
     MachineState *ms = MACHINE(hotplug_dev);
     bool is_nvdimm = object_dynamic_cast(OBJECT(dev), TYPE_NVDIMM);
 
-    pc_dimm_plug(PC_DIMM(dev), MACHINE(pcms), &local_err);
-    if (local_err) {
-        goto out;
-    }
+    pc_dimm_plug(PC_DIMM(dev), MACHINE(pcms));
 
     if (is_nvdimm) {
         nvdimm_plug(ms->nvdimms_state);
     }
 
     hotplug_handler_plug(x86ms->acpi_dev, dev, &error_abort);
-out:
-    error_propagate(errp, local_err);
 }
 
 static void pc_memory_unplug_request(HotplugHandler *hotplug_dev,
diff --git a/hw/mem/pc-dimm.c b/hw/mem/pc-dimm.c
index c30351070b..2ffc986734 100644
--- a/hw/mem/pc-dimm.c
+++ b/hw/mem/pc-dimm.c
@@ -64,7 +64,7 @@ void pc_dimm_pre_plug(PCDIMMDevice *dimm, MachineState *machine,
                            errp);
 }
 
-void pc_dimm_plug(PCDIMMDevice *dimm, MachineState *machine, Error **errp)
+void pc_dimm_plug(PCDIMMDevice *dimm, MachineState *machine)
 {
     PCDIMMDeviceClass *ddc = PC_DIMM_GET_CLASS(dimm);
     MemoryRegion *vmstate_mr = ddc->get_vmstate_memory_region(dimm,
diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index ee716a12af..05abf6cc57 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -3438,10 +3438,7 @@ static void spapr_memory_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
 
     size = memory_device_get_region_size(MEMORY_DEVICE(dev), &error_abort);
 
-    pc_dimm_plug(dimm, MACHINE(ms), &local_err);
-    if (local_err) {
-        goto out;
-    }
+    pc_dimm_plug(dimm, MACHINE(ms));
 
     if (!is_nvdimm) {
         addr = object_property_get_uint(OBJECT(dimm),
@@ -3469,7 +3466,6 @@ static void spapr_memory_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
 
 out_unplug:
     pc_dimm_unplug(dimm, MACHINE(ms));
-out:
     error_propagate(errp, local_err);
 }
 
diff --git a/include/hw/mem/pc-dimm.h b/include/hw/mem/pc-dimm.h
index aec9527fdd..3d3db82641 100644
--- a/include/hw/mem/pc-dimm.h
+++ b/include/hw/mem/pc-dimm.h
@@ -72,6 +72,6 @@ struct PCDIMMDeviceClass {
 
 void pc_dimm_pre_plug(PCDIMMDevice *dimm, MachineState *machine,
                       const uint64_t *legacy_align, Error **errp);
-void pc_dimm_plug(PCDIMMDevice *dimm, MachineState *machine, Error **errp);
+void pc_dimm_plug(PCDIMMDevice *dimm, MachineState *machine);
 void pc_dimm_unplug(PCDIMMDevice *dimm, MachineState *machine);
 #endif
-- 
2.26.2



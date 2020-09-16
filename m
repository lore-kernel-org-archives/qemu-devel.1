Return-Path: <SRS0=+YCa=CZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01900C43461
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2020 19:33:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EE2C02080C
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2020 19:33:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RG4ZR9hi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE2C02080C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55158 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIdAq-0001p3-SF
	for qemu-devel@archiver.kernel.org; Wed, 16 Sep 2020 15:33:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46838)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kId9H-0000Fk-SV
 for qemu-devel@nongnu.org; Wed, 16 Sep 2020 15:31:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:52633)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kId9C-000196-TR
 for qemu-devel@nongnu.org; Wed, 16 Sep 2020 15:31:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600284678;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MulXr2jdHzdlj32RRry9BTw34w3A6TsOP1hX9CIIHow=;
 b=RG4ZR9hiWvq8RGJHeJ4Zp0JZGnbhdAl9MrZ85K6W9/oIqHai5x3aH6WbDZLX3BoqMEKP1L
 6mGpQdfE4HI29FsoMxgClVdVbKeZRC2TvRmHrNdMkIY+CQ6SrRt2nY9z63r0YXKK61C5My
 YMLbuGoIvXj7AuSjLduudmC7DltLTEs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-122-GkjiCrO0MTGO1xMQqxlu9w-1; Wed, 16 Sep 2020 15:31:15 -0400
X-MC-Unique: GkjiCrO0MTGO1xMQqxlu9w-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4A9D0ADC0D;
 Wed, 16 Sep 2020 19:31:14 +0000 (UTC)
Received: from localhost (ovpn-119-217.rdu2.redhat.com [10.10.119.217])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9841E5FC36;
 Wed, 16 Sep 2020 19:31:10 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 3/3] [automated] Use DECLARE_*CHECKER* macros
Date: Wed, 16 Sep 2020 15:31:01 -0400
Message-Id: <20200916193101.511600-4-ehabkost@redhat.com>
In-Reply-To: <20200916193101.511600-1-ehabkost@redhat.com>
References: <20200916193101.511600-1-ehabkost@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=ehabkost@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=ehabkost@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/16 02:35:56
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.999,
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 "Daniel P. Berrange" <berrange@redhat.com>, Corey Minyard <minyard@acm.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-ppc@nongnu.org,
 Juan Quintela <quintela@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>, qemu-arm@nongnu.org,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Stefan Berger <stefanb@linux.ibm.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

New round of conversion of type checking macros to
DECLARE_*CHECKER, in the files that were previously using
INTERFACE_CHECK.

Genereated using:

 $ ./scripts/codeconverter/converter.py --passes=3 -i \
   --pattern=QOMStructTypedefSplit,MoveSymbols,TypeCheckMacro \
     include/hw/acpi/acpi_dev_interface.h \
     include/hw/arm/linux-boot-if.h \
     include/hw/fw-path-provider.h \
     include/hw/hotplug.h \
     include/hw/intc/intc.h \
     include/hw/ipmi/ipmi.h \
     include/hw/isa/isa.h \
     include/hw/mem/memory-device.h \
     include/hw/nmi.h \
     include/hw/ppc/pnv_xscom.h \
     include/hw/ppc/spapr_irq.h \
     include/hw/ppc/xics.h \
     include/hw/ppc/xive.h \
     include/hw/rdma/rdma.h \
     include/hw/rtc/m48t59.h \
     include/hw/stream.h \
     include/hw/vmstate-if.h \
     include/qom/object.h \
     include/qom/object_interfaces.h \
     include/sysemu/tpm.h \
     scripts/codeconverter/codeconverter/qom_macros.py \
     target/arm/idau.h \
     tests/check-qom-interface.c

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Igor Mammedov <imammedo@redhat.com>
Cc: Corey Minyard <minyard@acm.org>
Cc: "Cédric Le Goater" <clg@kaod.org>
Cc: David Gibson <david@gibson.dropbear.id.au>
Cc: "Hervé Poussineau" <hpoussin@reactos.org>
Cc: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Cc: Juan Quintela <quintela@redhat.com>
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: "Daniel P. Berrangé" <berrange@redhat.com>
Cc: Eduardo Habkost <ehabkost@redhat.com>
Cc: Stefan Berger <stefanb@linux.ibm.com>
Cc: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org
Cc: qemu-arm@nongnu.org
---
 include/hw/acpi/acpi_dev_interface.h |  7 +++----
 include/hw/arm/linux-boot-if.h       |  6 +++---
 include/hw/fw-path-provider.h        |  6 +++---
 include/hw/hotplug.h                 |  6 +++---
 include/hw/intc/intc.h               |  7 +++----
 include/hw/ipmi/ipmi.h               |  6 +++---
 include/hw/mem/memory-device.h       |  6 +++---
 include/hw/nmi.h                     |  6 +++---
 include/hw/ppc/pnv_xscom.h           |  4 ++--
 include/hw/ppc/spapr_irq.h           |  4 ++--
 include/hw/ppc/xics.h                |  4 ++--
 include/hw/ppc/xive.h                | 12 ++++++------
 include/hw/rdma/rdma.h               |  7 +++----
 include/hw/rtc/m48t59.h              |  6 +++---
 include/hw/stream.h                  |  6 +++---
 include/hw/vmstate-if.h              |  6 +++---
 include/qom/object_interfaces.h      |  7 +++----
 include/sysemu/tpm.h                 |  6 +++---
 target/arm/idau.h                    |  6 +++---
 tests/check-qom-interface.c          |  6 +++---
 20 files changed, 60 insertions(+), 64 deletions(-)

diff --git a/include/hw/acpi/acpi_dev_interface.h b/include/hw/acpi/acpi_dev_interface.h
index 5637a41936..d0e02451ba 100644
--- a/include/hw/acpi/acpi_dev_interface.h
+++ b/include/hw/acpi/acpi_dev_interface.h
@@ -21,11 +21,10 @@ typedef enum {
 typedef struct AcpiDeviceIfClass AcpiDeviceIfClass;
 DECLARE_CLASS_CHECKERS(AcpiDeviceIfClass, ACPI_DEVICE_IF,
                        TYPE_ACPI_DEVICE_IF)
-#define ACPI_DEVICE_IF(obj) \
-     OBJECT_CHECK(AcpiDeviceIf, (obj), \
-                     TYPE_ACPI_DEVICE_IF)
-
 typedef struct AcpiDeviceIf AcpiDeviceIf;
+DECLARE_INSTANCE_CHECKER(AcpiDeviceIf, ACPI_DEVICE_IF,
+                         TYPE_ACPI_DEVICE_IF)
+
 
 void acpi_send_event(DeviceState *dev, AcpiEventStatusBits event);
 
diff --git a/include/hw/arm/linux-boot-if.h b/include/hw/arm/linux-boot-if.h
index 4b86bb1067..645ef60a7b 100644
--- a/include/hw/arm/linux-boot-if.h
+++ b/include/hw/arm/linux-boot-if.h
@@ -12,10 +12,10 @@
 typedef struct ARMLinuxBootIfClass ARMLinuxBootIfClass;
 DECLARE_CLASS_CHECKERS(ARMLinuxBootIfClass, ARM_LINUX_BOOT_IF,
                        TYPE_ARM_LINUX_BOOT_IF)
-#define ARM_LINUX_BOOT_IF(obj) \
-    OBJECT_CHECK(ARMLinuxBootIf, (obj), TYPE_ARM_LINUX_BOOT_IF)
-
 typedef struct ARMLinuxBootIf ARMLinuxBootIf;
+DECLARE_INSTANCE_CHECKER(ARMLinuxBootIf, ARM_LINUX_BOOT_IF,
+                         TYPE_ARM_LINUX_BOOT_IF)
+
 
 struct ARMLinuxBootIfClass {
     /*< private >*/
diff --git a/include/hw/fw-path-provider.h b/include/hw/fw-path-provider.h
index 9b00b2eb37..85fd3256c6 100644
--- a/include/hw/fw-path-provider.h
+++ b/include/hw/fw-path-provider.h
@@ -25,10 +25,10 @@
 typedef struct FWPathProviderClass FWPathProviderClass;
 DECLARE_CLASS_CHECKERS(FWPathProviderClass, FW_PATH_PROVIDER,
                        TYPE_FW_PATH_PROVIDER)
-#define FW_PATH_PROVIDER(obj) \
-     OBJECT_CHECK(FWPathProvider, (obj), TYPE_FW_PATH_PROVIDER)
-
 typedef struct FWPathProvider FWPathProvider;
+DECLARE_INSTANCE_CHECKER(FWPathProvider, FW_PATH_PROVIDER,
+                         TYPE_FW_PATH_PROVIDER)
+
 
 struct FWPathProviderClass {
     InterfaceClass parent_class;
diff --git a/include/hw/hotplug.h b/include/hw/hotplug.h
index c87dfba941..914188b306 100644
--- a/include/hw/hotplug.h
+++ b/include/hw/hotplug.h
@@ -19,10 +19,10 @@
 typedef struct HotplugHandlerClass HotplugHandlerClass;
 DECLARE_CLASS_CHECKERS(HotplugHandlerClass, HOTPLUG_HANDLER,
                        TYPE_HOTPLUG_HANDLER)
-#define HOTPLUG_HANDLER(obj) \
-     OBJECT_CHECK(HotplugHandler, (obj), TYPE_HOTPLUG_HANDLER)
-
 typedef struct HotplugHandler HotplugHandler;
+DECLARE_INSTANCE_CHECKER(HotplugHandler, HOTPLUG_HANDLER,
+                         TYPE_HOTPLUG_HANDLER)
+
 
 /**
  * hotplug_fn:
diff --git a/include/hw/intc/intc.h b/include/hw/intc/intc.h
index c01d696937..bcc66f394b 100644
--- a/include/hw/intc/intc.h
+++ b/include/hw/intc/intc.h
@@ -8,11 +8,10 @@
 typedef struct InterruptStatsProviderClass InterruptStatsProviderClass;
 DECLARE_CLASS_CHECKERS(InterruptStatsProviderClass, INTERRUPT_STATS_PROVIDER,
                        TYPE_INTERRUPT_STATS_PROVIDER)
-#define INTERRUPT_STATS_PROVIDER(obj) \
-    OBJECT_CHECK(InterruptStatsProvider, (obj), \
-                    TYPE_INTERRUPT_STATS_PROVIDER)
-
 typedef struct InterruptStatsProvider InterruptStatsProvider;
+DECLARE_INSTANCE_CHECKER(InterruptStatsProvider, INTERRUPT_STATS_PROVIDER,
+                         TYPE_INTERRUPT_STATS_PROVIDER)
+
 
 struct InterruptStatsProviderClass {
     InterfaceClass parent;
diff --git a/include/hw/ipmi/ipmi.h b/include/hw/ipmi/ipmi.h
index 7073472ff8..9ec84b1bd8 100644
--- a/include/hw/ipmi/ipmi.h
+++ b/include/hw/ipmi/ipmi.h
@@ -109,13 +109,13 @@ uint32_t ipmi_next_uuid(void);
  * and the BMC.
  */
 #define TYPE_IPMI_INTERFACE "ipmi-interface"
-#define IPMI_INTERFACE(obj) \
-     OBJECT_CHECK(IPMIInterface, (obj), TYPE_IPMI_INTERFACE)
+typedef struct IPMIInterface IPMIInterface;
+DECLARE_INSTANCE_CHECKER(IPMIInterface, IPMI_INTERFACE,
+                         TYPE_IPMI_INTERFACE)
 typedef struct IPMIInterfaceClass IPMIInterfaceClass;
 DECLARE_CLASS_CHECKERS(IPMIInterfaceClass, IPMI_INTERFACE,
                        TYPE_IPMI_INTERFACE)
 
-typedef struct IPMIInterface IPMIInterface;
 
 struct IPMIInterfaceClass {
     InterfaceClass parent;
diff --git a/include/hw/mem/memory-device.h b/include/hw/mem/memory-device.h
index 5eaa106dc3..4d1a87441d 100644
--- a/include/hw/mem/memory-device.h
+++ b/include/hw/mem/memory-device.h
@@ -22,10 +22,10 @@
 typedef struct MemoryDeviceClass MemoryDeviceClass;
 DECLARE_CLASS_CHECKERS(MemoryDeviceClass, MEMORY_DEVICE,
                        TYPE_MEMORY_DEVICE)
-#define MEMORY_DEVICE(obj) \
-     OBJECT_CHECK(MemoryDeviceState, (obj), TYPE_MEMORY_DEVICE)
-
 typedef struct MemoryDeviceState MemoryDeviceState;
+DECLARE_INSTANCE_CHECKER(MemoryDeviceState, MEMORY_DEVICE,
+                         TYPE_MEMORY_DEVICE)
+
 
 /**
  * MemoryDeviceClass:
diff --git a/include/hw/nmi.h b/include/hw/nmi.h
index faa1c62aaa..a8fa9f7cff 100644
--- a/include/hw/nmi.h
+++ b/include/hw/nmi.h
@@ -29,10 +29,10 @@
 typedef struct NMIClass NMIClass;
 DECLARE_CLASS_CHECKERS(NMIClass, NMI,
                        TYPE_NMI)
-#define NMI(obj) \
-     OBJECT_CHECK(NMIState, (obj), TYPE_NMI)
-
 typedef struct NMIState NMIState;
+DECLARE_INSTANCE_CHECKER(NMIState, NMI,
+                         TYPE_NMI)
+
 
 struct NMIClass {
     InterfaceClass parent_class;
diff --git a/include/hw/ppc/pnv_xscom.h b/include/hw/ppc/pnv_xscom.h
index 597784393f..34c2f05177 100644
--- a/include/hw/ppc/pnv_xscom.h
+++ b/include/hw/ppc/pnv_xscom.h
@@ -25,8 +25,8 @@
 typedef struct PnvXScomInterface PnvXScomInterface;
 
 #define TYPE_PNV_XSCOM_INTERFACE "pnv-xscom-interface"
-#define PNV_XSCOM_INTERFACE(obj) \
-    OBJECT_CHECK(PnvXScomInterface, (obj), TYPE_PNV_XSCOM_INTERFACE)
+DECLARE_INSTANCE_CHECKER(PnvXScomInterface, PNV_XSCOM_INTERFACE,
+                         TYPE_PNV_XSCOM_INTERFACE)
 typedef struct PnvXScomInterfaceClass PnvXScomInterfaceClass;
 DECLARE_CLASS_CHECKERS(PnvXScomInterfaceClass, PNV_XSCOM_INTERFACE,
                        TYPE_PNV_XSCOM_INTERFACE)
diff --git a/include/hw/ppc/spapr_irq.h b/include/hw/ppc/spapr_irq.h
index c2f8665a51..95e0151154 100644
--- a/include/hw/ppc/spapr_irq.h
+++ b/include/hw/ppc/spapr_irq.h
@@ -34,8 +34,8 @@ struct SpaprMachineState;
 typedef struct SpaprInterruptController SpaprInterruptController;
 
 #define TYPE_SPAPR_INTC "spapr-interrupt-controller"
-#define SPAPR_INTC(obj)                                     \
-    OBJECT_CHECK(SpaprInterruptController, (obj), TYPE_SPAPR_INTC)
+DECLARE_INSTANCE_CHECKER(SpaprInterruptController, SPAPR_INTC,
+                         TYPE_SPAPR_INTC)
 typedef struct SpaprInterruptControllerClass SpaprInterruptControllerClass;
 DECLARE_CLASS_CHECKERS(SpaprInterruptControllerClass, SPAPR_INTC,
                        TYPE_SPAPR_INTC)
diff --git a/include/hw/ppc/xics.h b/include/hw/ppc/xics.h
index 884dc5ae28..cb2e30f932 100644
--- a/include/hw/ppc/xics.h
+++ b/include/hw/ppc/xics.h
@@ -137,8 +137,8 @@ struct ICSIRQState {
 };
 
 #define TYPE_XICS_FABRIC "xics-fabric"
-#define XICS_FABRIC(obj)                                     \
-    OBJECT_CHECK(XICSFabric, (obj), TYPE_XICS_FABRIC)
+DECLARE_INSTANCE_CHECKER(XICSFabric, XICS_FABRIC,
+                         TYPE_XICS_FABRIC)
 typedef struct XICSFabricClass XICSFabricClass;
 DECLARE_CLASS_CHECKERS(XICSFabricClass, XICS_FABRIC,
                        TYPE_XICS_FABRIC)
diff --git a/include/hw/ppc/xive.h b/include/hw/ppc/xive.h
index fba72e0304..b22f7f76f5 100644
--- a/include/hw/ppc/xive.h
+++ b/include/hw/ppc/xive.h
@@ -152,8 +152,8 @@
 typedef struct XiveNotifier XiveNotifier;
 
 #define TYPE_XIVE_NOTIFIER "xive-notifier"
-#define XIVE_NOTIFIER(obj)                                     \
-    OBJECT_CHECK(XiveNotifier, (obj), TYPE_XIVE_NOTIFIER)
+DECLARE_INSTANCE_CHECKER(XiveNotifier, XIVE_NOTIFIER,
+                         TYPE_XIVE_NOTIFIER)
 typedef struct XiveNotifierClass XiveNotifierClass;
 DECLARE_CLASS_CHECKERS(XiveNotifierClass, XIVE_NOTIFIER,
                        TYPE_XIVE_NOTIFIER)
@@ -389,8 +389,8 @@ typedef struct XiveTCTXMatch {
 } XiveTCTXMatch;
 
 #define TYPE_XIVE_PRESENTER "xive-presenter"
-#define XIVE_PRESENTER(obj)                                     \
-    OBJECT_CHECK(XivePresenter, (obj), TYPE_XIVE_PRESENTER)
+DECLARE_INSTANCE_CHECKER(XivePresenter, XIVE_PRESENTER,
+                         TYPE_XIVE_PRESENTER)
 typedef struct XivePresenterClass XivePresenterClass;
 DECLARE_CLASS_CHECKERS(XivePresenterClass, XIVE_PRESENTER,
                        TYPE_XIVE_PRESENTER)
@@ -414,8 +414,8 @@ int xive_presenter_tctx_match(XivePresenter *xptr, XiveTCTX *tctx,
  */
 
 #define TYPE_XIVE_FABRIC "xive-fabric"
-#define XIVE_FABRIC(obj)                                     \
-    OBJECT_CHECK(XiveFabric, (obj), TYPE_XIVE_FABRIC)
+DECLARE_INSTANCE_CHECKER(XiveFabric, XIVE_FABRIC,
+                         TYPE_XIVE_FABRIC)
 typedef struct XiveFabricClass XiveFabricClass;
 DECLARE_CLASS_CHECKERS(XiveFabricClass, XIVE_FABRIC,
                        TYPE_XIVE_FABRIC)
diff --git a/include/hw/rdma/rdma.h b/include/hw/rdma/rdma.h
index 3f46986550..9d30fc2169 100644
--- a/include/hw/rdma/rdma.h
+++ b/include/hw/rdma/rdma.h
@@ -22,11 +22,10 @@
 typedef struct RdmaProviderClass RdmaProviderClass;
 DECLARE_CLASS_CHECKERS(RdmaProviderClass, RDMA_PROVIDER,
                        INTERFACE_RDMA_PROVIDER)
-#define RDMA_PROVIDER(obj) \
-    OBJECT_CHECK(RdmaProvider, (obj), \
-                    INTERFACE_RDMA_PROVIDER)
-
 typedef struct RdmaProvider RdmaProvider;
+DECLARE_INSTANCE_CHECKER(RdmaProvider, RDMA_PROVIDER,
+                         INTERFACE_RDMA_PROVIDER)
+
 
 struct RdmaProviderClass {
     InterfaceClass parent;
diff --git a/include/hw/rtc/m48t59.h b/include/hw/rtc/m48t59.h
index 7e3b077741..6e103241dd 100644
--- a/include/hw/rtc/m48t59.h
+++ b/include/hw/rtc/m48t59.h
@@ -34,10 +34,10 @@
 typedef struct NvramClass NvramClass;
 DECLARE_CLASS_CHECKERS(NvramClass, NVRAM,
                        TYPE_NVRAM)
-#define NVRAM(obj) \
-    OBJECT_CHECK(Nvram, (obj), TYPE_NVRAM)
-
 typedef struct Nvram Nvram;
+DECLARE_INSTANCE_CHECKER(Nvram, NVRAM,
+                         TYPE_NVRAM)
+
 
 struct NvramClass {
     InterfaceClass parent;
diff --git a/include/hw/stream.h b/include/hw/stream.h
index afa6679c64..cd8fbdf382 100644
--- a/include/hw/stream.h
+++ b/include/hw/stream.h
@@ -9,10 +9,10 @@
 typedef struct StreamSlaveClass StreamSlaveClass;
 DECLARE_CLASS_CHECKERS(StreamSlaveClass, STREAM_SLAVE,
                        TYPE_STREAM_SLAVE)
-#define STREAM_SLAVE(obj) \
-     OBJECT_CHECK(StreamSlave, (obj), TYPE_STREAM_SLAVE)
-
 typedef struct StreamSlave StreamSlave;
+DECLARE_INSTANCE_CHECKER(StreamSlave, STREAM_SLAVE,
+                         TYPE_STREAM_SLAVE)
+
 
 typedef void (*StreamCanPushNotifyFn)(void *opaque);
 
diff --git a/include/hw/vmstate-if.h b/include/hw/vmstate-if.h
index 99bb1de7c2..f4e40ed022 100644
--- a/include/hw/vmstate-if.h
+++ b/include/hw/vmstate-if.h
@@ -16,10 +16,10 @@
 typedef struct VMStateIfClass VMStateIfClass;
 DECLARE_CLASS_CHECKERS(VMStateIfClass, VMSTATE_IF,
                        TYPE_VMSTATE_IF)
-#define VMSTATE_IF(obj)                             \
-    OBJECT_CHECK(VMStateIf, (obj), TYPE_VMSTATE_IF)
-
 typedef struct VMStateIf VMStateIf;
+DECLARE_INSTANCE_CHECKER(VMStateIf, VMSTATE_IF,
+                         TYPE_VMSTATE_IF)
+
 
 struct VMStateIfClass {
     InterfaceClass parent_class;
diff --git a/include/qom/object_interfaces.h b/include/qom/object_interfaces.h
index a6626e0ed6..80c3d34598 100644
--- a/include/qom/object_interfaces.h
+++ b/include/qom/object_interfaces.h
@@ -9,11 +9,10 @@
 typedef struct UserCreatableClass UserCreatableClass;
 DECLARE_CLASS_CHECKERS(UserCreatableClass, USER_CREATABLE,
                        TYPE_USER_CREATABLE)
-#define USER_CREATABLE(obj) \
-     OBJECT_CHECK(UserCreatable, (obj), \
-                     TYPE_USER_CREATABLE)
-
 typedef struct UserCreatable UserCreatable;
+DECLARE_INSTANCE_CHECKER(UserCreatable, USER_CREATABLE,
+                         TYPE_USER_CREATABLE)
+
 
 /**
  * UserCreatableClass:
diff --git a/include/sysemu/tpm.h b/include/sysemu/tpm.h
index 102217c348..922924b1d0 100644
--- a/include/sysemu/tpm.h
+++ b/include/sysemu/tpm.h
@@ -29,10 +29,10 @@ typedef enum TPMVersion {
 typedef struct TPMIfClass TPMIfClass;
 DECLARE_CLASS_CHECKERS(TPMIfClass, TPM_IF,
                        TYPE_TPM_IF)
-#define TPM_IF(obj)                             \
-    OBJECT_CHECK(TPMIf, (obj), TYPE_TPM_IF)
-
 typedef struct TPMIf TPMIf;
+DECLARE_INSTANCE_CHECKER(TPMIf, TPM_IF,
+                         TYPE_TPM_IF)
+
 
 struct TPMIfClass {
     InterfaceClass parent_class;
diff --git a/target/arm/idau.h b/target/arm/idau.h
index 6b28d26da9..f811b00f21 100644
--- a/target/arm/idau.h
+++ b/target/arm/idau.h
@@ -31,13 +31,13 @@
 #include "qom/object.h"
 
 #define TYPE_IDAU_INTERFACE "idau-interface"
-#define IDAU_INTERFACE(obj) \
-    OBJECT_CHECK(IDAUInterface, (obj), TYPE_IDAU_INTERFACE)
+typedef struct IDAUInterface IDAUInterface;
+DECLARE_INSTANCE_CHECKER(IDAUInterface, IDAU_INTERFACE,
+                         TYPE_IDAU_INTERFACE)
 typedef struct IDAUInterfaceClass IDAUInterfaceClass;
 DECLARE_CLASS_CHECKERS(IDAUInterfaceClass, IDAU_INTERFACE,
                        TYPE_IDAU_INTERFACE)
 
-typedef struct IDAUInterface IDAUInterface;
 
 #define IREGION_NOTVALID -1
 
diff --git a/tests/check-qom-interface.c b/tests/check-qom-interface.c
index 53bdcb8878..2c29af8100 100644
--- a/tests/check-qom-interface.c
+++ b/tests/check-qom-interface.c
@@ -19,10 +19,10 @@
 typedef struct TestIfClass TestIfClass;
 DECLARE_CLASS_CHECKERS(TestIfClass, TEST_IF,
                        TYPE_TEST_IF)
-#define TEST_IF(obj) \
-     OBJECT_CHECK(TestIf, (obj), TYPE_TEST_IF)
-
 typedef struct TestIf TestIf;
+DECLARE_INSTANCE_CHECKER(TestIf, TEST_IF,
+                         TYPE_TEST_IF)
+
 
 struct TestIfClass {
     InterfaceClass parent_class;
-- 
2.26.2



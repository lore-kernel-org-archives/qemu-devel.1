Return-Path: <SRS0=QvPl=BU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3780C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2020 11:30:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 574D420709
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2020 11:30:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=anisinha-ca.20150623.gappssmtp.com header.i=@anisinha-ca.20150623.gappssmtp.com header.b="Qr9eYjrC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 574D420709
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=anisinha.ca
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34236 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k560v-0002po-Jm
	for qemu-devel@archiver.kernel.org; Mon, 10 Aug 2020 07:30:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44368)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ani@anisinha.ca>) id 1k560D-0002LC-1M
 for qemu-devel@nongnu.org; Mon, 10 Aug 2020 07:30:05 -0400
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641]:40008)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ani@anisinha.ca>) id 1k560A-0001v7-T0
 for qemu-devel@nongnu.org; Mon, 10 Aug 2020 07:30:04 -0400
Received: by mail-pl1-x641.google.com with SMTP id u10so4640280plr.7
 for <qemu-devel@nongnu.org>; Mon, 10 Aug 2020 04:30:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=anisinha-ca.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id;
 bh=lPfCDODgZUcS20IzAK0sens4LanQKMofrc5tBOoJuwk=;
 b=Qr9eYjrCT2BoxdcjpJdWvCAgXorW9sdnKf/VOxBH7I3LyU29RNzb2gwEegkI+SktLE
 MlqFppfXfQlKT2O7DxRzC0yBI9SVXnbrcYas5D5fxelQaY/DPeGKjeSKpcGtb2uZ9gyJ
 y14LH8wx/mOOXVCEnJdHaM0d/lWUcoMxpAhxAbyYVqkevHuMxQQNfx7rGWg9qp+foYPy
 pUU+ij+q+dYvisdRZBQimOSh/Rj+Aj8czLbBaAB+qjMNV8KfasmBRJ8hm2C9kIQC0cas
 +6XAx24sq1zfsCyROI1JS5EiEnIvVRk5VbpwNM4NEBhMA5ShYoflAlu3noXbuNtMDds7
 q4hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=lPfCDODgZUcS20IzAK0sens4LanQKMofrc5tBOoJuwk=;
 b=uTrSd0zxmLU5CYbikseyCxsbSGl74twJXYoFYbaOCtzffapjeeltwFLjkSg1ymSIX6
 0FZYY1c2C4gDAqJGqJLXaQVQh7CIAIwGy8Emcc/mtz8Uc9gxpfutJxYVeYKAVIwlP7Pg
 Nu//jDFSnC5BvDg/4OfEPBHZOWXSQd4X69YCwzwnc+dq2RQ+4mXztwlc/UOJDCpCJT5Y
 F28FvzGenrPhF+T8hhj7VL4tTRhSE6sCmBbw5Sw2ScYUcUmsBA42Ww8emSNtzMcadyvb
 PYNaNJux9fOkh6bBwJchGoKMrmIzd2/74Ea1LjmnOINepJfe2t2WiN/9hz/P6AxPxj1+
 F4cA==
X-Gm-Message-State: AOAM53267VtZ0YrgR8oIrGHln5EDnrGIpatpHxSoqgOqr0Wz2YmV92Io
 kp6rTlEw9MjBhT/SqnsBw1qU7HEkNUBxlg==
X-Google-Smtp-Source: ABdhPJwSwlBh3b0o4JCL9v9LisOGxSDR+s9vdQpAMA0Xp64MQSF/b5m2cNn2zt3DDJ8xilybjcNkWQ==
X-Received: by 2002:a17:90a:1384:: with SMTP id
 i4mr27705192pja.157.1597058999986; 
 Mon, 10 Aug 2020 04:29:59 -0700 (PDT)
Received: from localhost.localdomain ([203.163.233.127])
 by smtp.gmail.com with ESMTPSA id t13sm18196985pgm.32.2020.08.10.04.29.54
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 10 Aug 2020 04:29:59 -0700 (PDT)
From: Ani Sinha <ani@anisinha.ca>
To: qemu-devel@nongnu.org
Subject: [PATCH] Introduce global piix flag to disable PCI hotplug
Date: Mon, 10 Aug 2020 16:59:41 +0530
Message-Id: <1597058982-70090-1-git-send-email-ani@anisinha.ca>
X-Mailer: git-send-email 2.7.4
Received-SPF: none client-ip=2607:f8b0:4864:20::641;
 envelope-from=ani@anisinha.ca; helo=mail-pl1-x641.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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
Cc: Eduardo Habkost <ehabkost@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, ani@anisinha.ca,
 Igor Mammedov <imammedo@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We introduce a new global flag for PIIX with which we can
turn on or off PCI device hotplug. This flag can be used
to prevent all PCI devices from getting hotplugged/unplugged
on the PCI bus. The new options disables all hotpluh HW
initialization code as well as the ACPI AMLs.

Signed-off-by: Ani Sinha <ani@anisinha.ca>
---
 hw/acpi/piix4.c      |  8 ++++++--
 hw/i386/acpi-build.c | 20 ++++++++++++++------
 2 files changed, 20 insertions(+), 8 deletions(-)

diff --git a/hw/acpi/piix4.c b/hw/acpi/piix4.c
index 26bac4f..8b13e86 100644
--- a/hw/acpi/piix4.c
+++ b/hw/acpi/piix4.c
@@ -78,6 +78,7 @@ typedef struct PIIX4PMState {
 
     AcpiPciHpState acpi_pci_hotplug;
     bool use_acpi_hotplug_bridge;
+    bool use_acpi_pci_hotplug;
 
     uint8_t disable_s3;
     uint8_t disable_s4;
@@ -595,8 +596,9 @@ static void piix4_acpi_system_hot_add_init(MemoryRegion *parent,
                           "acpi-gpe0", GPE_LEN);
     memory_region_add_subregion(parent, GPE_BASE, &s->io_gpe);
 
-    acpi_pcihp_init(OBJECT(s), &s->acpi_pci_hotplug, bus, parent,
-                    s->use_acpi_hotplug_bridge);
+    if (s->use_acpi_pci_hotplug)
+        acpi_pcihp_init(OBJECT(s), &s->acpi_pci_hotplug, bus, parent,
+                        s->use_acpi_hotplug_bridge);
 
     s->cpu_hotplug_legacy = true;
     object_property_add_bool(OBJECT(s), "cpu-hotplug-legacy",
@@ -635,6 +637,8 @@ static Property piix4_pm_properties[] = {
     DEFINE_PROP_UINT8(ACPI_PM_PROP_S4_VAL, PIIX4PMState, s4_val, 2),
     DEFINE_PROP_BOOL("acpi-pci-hotplug-with-bridge-support", PIIX4PMState,
                      use_acpi_hotplug_bridge, true),
+    DEFINE_PROP_BOOL("acpi-pci-hotplug", PIIX4PMState,
+                     use_acpi_pci_hotplug, true),
     DEFINE_PROP_BOOL("memory-hotplug-support", PIIX4PMState,
                      acpi_memory_hotplug.is_enabled, true),
     DEFINE_PROP_END_OF_LIST(),
diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
index b7bcbbb..343b9b6 100644
--- a/hw/i386/acpi-build.c
+++ b/hw/i386/acpi-build.c
@@ -95,6 +95,7 @@ typedef struct AcpiPmInfo {
     bool s3_disabled;
     bool s4_disabled;
     bool pcihp_bridge_en;
+    bool pcihp_en;
     uint8_t s4_val;
     AcpiFadtData fadt;
     uint16_t cpu_hp_io_base;
@@ -245,6 +246,9 @@ static void acpi_get_pm_info(MachineState *machine, AcpiPmInfo *pm)
     pm->pcihp_bridge_en =
         object_property_get_bool(obj, "acpi-pci-hotplug-with-bridge-support",
                                  NULL);
+    pm->pcihp_en =
+        object_property_get_bool(obj, "acpi-pci-hotplug", NULL);
+
 }
 
 static void acpi_get_misc_info(AcpiMiscInfo *info)
@@ -337,14 +341,16 @@ static void build_append_pcihp_notify_entry(Aml *method, int slot)
 }
 
 static void build_append_pci_bus_devices(Aml *parent_scope, PCIBus *bus,
-                                         bool pcihp_bridge_en)
+                                         bool pcihp_bridge_en, bool pcihp_en)
 {
     Aml *dev, *notify_method = NULL, *method;
-    QObject *bsel;
+    QObject *bsel = NULL;
     PCIBus *sec;
     int i;
 
-    bsel = object_property_get_qobject(OBJECT(bus), ACPI_PCIHP_PROP_BSEL, NULL);
+    if (pcihp_en)
+        bsel = object_property_get_qobject(OBJECT(bus),
+                                           ACPI_PCIHP_PROP_BSEL, NULL);
     if (bsel) {
         uint64_t bsel_val = qnum_get_uint(qobject_to(QNum, bsel));
 
@@ -439,7 +445,8 @@ static void build_append_pci_bus_devices(Aml *parent_scope, PCIBus *bus,
              */
             PCIBus *sec_bus = pci_bridge_get_sec_bus(PCI_BRIDGE(pdev));
 
-            build_append_pci_bus_devices(dev, sec_bus, pcihp_bridge_en);
+            build_append_pci_bus_devices(dev, sec_bus, pcihp_bridge_en,
+                                         pcihp_en);
         }
         /* slot descriptor has been composed, add it into parent context */
         aml_append(parent_scope, dev);
@@ -468,7 +475,7 @@ static void build_append_pci_bus_devices(Aml *parent_scope, PCIBus *bus,
     }
 
     /* Notify about child bus events in any case */
-    if (pcihp_bridge_en) {
+    if (pcihp_bridge_en && pcihp_en) {
         QLIST_FOREACH(sec, &bus->child, sibling) {
             int32_t devfn = sec->parent_dev->devfn;
 
@@ -1818,7 +1825,8 @@ build_dsdt(GArray *table_data, BIOSLinker *linker,
         if (bus) {
             Aml *scope = aml_scope("PCI0");
             /* Scan all PCI buses. Generate tables to support hotplug. */
-            build_append_pci_bus_devices(scope, bus, pm->pcihp_bridge_en);
+            build_append_pci_bus_devices(scope, bus, pm->pcihp_bridge_en,
+                                         pm->pcihp_en);
 
             if (TPM_IS_TIS_ISA(tpm)) {
                 if (misc->tpm_version == TPM_VERSION_2_0) {
-- 
2.7.4



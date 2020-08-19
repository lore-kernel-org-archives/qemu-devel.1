Return-Path: <SRS0=bVMU=B5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B0FAC433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2020 08:28:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4079C20738
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2020 08:28:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=anisinha-ca.20150623.gappssmtp.com header.i=@anisinha-ca.20150623.gappssmtp.com header.b="k20mdG4s"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4079C20738
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=anisinha.ca
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57960 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k8JS7-0005zK-Ir
	for qemu-devel@archiver.kernel.org; Wed, 19 Aug 2020 04:28:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59602)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ani@anisinha.ca>) id 1k8JRa-0005Zy-AT
 for qemu-devel@nongnu.org; Wed, 19 Aug 2020 04:27:38 -0400
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:42354)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ani@anisinha.ca>) id 1k8JRY-0001sp-By
 for qemu-devel@nongnu.org; Wed, 19 Aug 2020 04:27:38 -0400
Received: by mail-pf1-x441.google.com with SMTP id 17so11301493pfw.9
 for <qemu-devel@nongnu.org>; Wed, 19 Aug 2020 01:27:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=anisinha-ca.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id;
 bh=3xXKT/Ad++c9VHFUQ5pjzX3vqefkZJl2+thTgmehtEY=;
 b=k20mdG4sIRzfwyLrODHeF+FFg9VxSU6Ot1Befl928iA99nqa37lkSIqlpjni+NdEfo
 hEuY+sXMg/NSgv07J7/GJ877etqyPn4M7vi5kKmzOTWlStmTiCTgyBKScr0bLipdOIh9
 8V942CV1SvUQYvCp2a1+hdiqSzFTJ0PbdUpW1NuJl/QpGs0CNow+O1arkoyTyrKiBewc
 Y9OHGUcMtxPRwY5/+fQY8qH5yN0ezbRDiojGN9tAoDq1HBv0RaXIDKS7D30T8dohT0fg
 0zqTXJrdbhbKyCbGIbBnLptHrH49z+k3uDes4Lv5lNYgh7OE0iE18Nm9M+ILCFMwABu+
 /jaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=3xXKT/Ad++c9VHFUQ5pjzX3vqefkZJl2+thTgmehtEY=;
 b=TEDKSOJYATU5Xz7/pepyOynLMa3QLWUdMlWbpGMEONlqdvEYcJI51aV7x7YlvJ1hPD
 82w/n3BWWpF3y5DYNZJ1N8MjkWfO+jiP6VOZQK43tAxw4WQNXAHvvupfXh0EJlCJxOL+
 cIBCI3h4Jif/vPgnmlLVtSi5lamhqEiBD9zMS2fDXamrqlIlBu1SL2bk8WUNwFwdKUyH
 C3ckq+bytH3JDrTRf4oBdMOFvQvagyBz/EuLn01mNiLi9vKKvMqRQrDnMh/p0t9oAcD5
 F4pXslxrkVVQz88QQRxtygHZ/MWuBJXV2miAaURJg1HgSa4XTw2t8vCSfmcDlKUr41qf
 Z33A==
X-Gm-Message-State: AOAM5322gcQ/NO/7pmA5v713iO0foGYKOUusjSdoKaKJiwO5gr5W6KTj
 pQsoJgt2zk4R3mMO2NqySgw43FvcdoZM91Uh
X-Google-Smtp-Source: ABdhPJzInvUrzSj6A1Y4uAouNqCUNacpD/i1bFOTZpDOa9C0rW9cxn1QScfWdHbo7mxzW1KIcGx6Vw==
X-Received: by 2002:a63:5d50:: with SMTP id o16mr3026320pgm.61.1597825653796; 
 Wed, 19 Aug 2020 01:27:33 -0700 (PDT)
Received: from localhost.localdomain ([115.96.140.151])
 by smtp.googlemail.com with ESMTPSA id em20sm2130131pjb.37.2020.08.19.01.27.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Aug 2020 01:27:33 -0700 (PDT)
From: Ani Sinha <ani@anisinha.ca>
To: qemu-devel@nongnu.org
Subject: [PATCH V3] Introduce a new flag for i440fx to disable PCI hotplug on
 the root bus
Date: Wed, 19 Aug 2020 13:57:07 +0530
Message-Id: <20200819082707.5246-1-ani@anisinha.ca>
X-Mailer: git-send-email 2.17.1
Received-SPF: none client-ip=2607:f8b0:4864:20::441;
 envelope-from=ani@anisinha.ca; helo=mail-pf1-x441.google.com
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
 Paolo Bonzini <pbonzini@redhat.com>, Ani Sinha <ani@anisinha.ca>,
 Igor Mammedov <imammedo@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We introduce a new global flag 'acpi-root-pci-hotplug' for i440fx with which
we can turn on or off PCI device hotplug on the root bus. This flag can be
used to prevent all PCI devices from getting hotplugged or unplugged from the
root PCI bus.
The existing flag 'acpi-pci-hotplug-with-bridge-support' for PCI-PCI bridges
remain as is and can be used along with this new flag to control PCI hotplug
on PCI bridges.

This change has been tested using a Windows 2012R2 server image on a Ubuntu
18.04 host using the latest master qemu from upstream.

Signed-off-by: Ani Sinha <ani@anisinha.ca>
---
 hw/acpi/piix4.c      |  8 ++++++--
 hw/i386/acpi-build.c | 26 +++++++++++++++++++-------
 2 files changed, 25 insertions(+), 9 deletions(-)

Change Log:
V2..V3: removed some AMLs which are not needed when hotplug on the root
bus is disabled. Also prevented calling device initialization routine
related to hotplug when the hotplug is disabled for both pci root bus
and pci bridges. 
 
diff --git a/hw/acpi/piix4.c b/hw/acpi/piix4.c
index 26bac4f16c..4f436e5bf3 100644
--- a/hw/acpi/piix4.c
+++ b/hw/acpi/piix4.c
@@ -78,6 +78,7 @@ typedef struct PIIX4PMState {
 
     AcpiPciHpState acpi_pci_hotplug;
     bool use_acpi_hotplug_bridge;
+    bool use_acpi_root_pci_hotplug;
 
     uint8_t disable_s3;
     uint8_t disable_s4;
@@ -595,8 +596,9 @@ static void piix4_acpi_system_hot_add_init(MemoryRegion *parent,
                           "acpi-gpe0", GPE_LEN);
     memory_region_add_subregion(parent, GPE_BASE, &s->io_gpe);
 
-    acpi_pcihp_init(OBJECT(s), &s->acpi_pci_hotplug, bus, parent,
-                    s->use_acpi_hotplug_bridge);
+    if (s->use_acpi_hotplug_bridge || s->use_acpi_root_pci_hotplug)
+        acpi_pcihp_init(OBJECT(s), &s->acpi_pci_hotplug, bus, parent,
+                        s->use_acpi_hotplug_bridge);
 
     s->cpu_hotplug_legacy = true;
     object_property_add_bool(OBJECT(s), "cpu-hotplug-legacy",
@@ -635,6 +637,8 @@ static Property piix4_pm_properties[] = {
     DEFINE_PROP_UINT8(ACPI_PM_PROP_S4_VAL, PIIX4PMState, s4_val, 2),
     DEFINE_PROP_BOOL("acpi-pci-hotplug-with-bridge-support", PIIX4PMState,
                      use_acpi_hotplug_bridge, true),
+    DEFINE_PROP_BOOL("acpi-root-pci-hotplug", PIIX4PMState,
+                     use_acpi_root_pci_hotplug, true),
     DEFINE_PROP_BOOL("memory-hotplug-support", PIIX4PMState,
                      acpi_memory_hotplug.is_enabled, true),
     DEFINE_PROP_END_OF_LIST(),
diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
index b7bcbbbb2a..19a1702ad1 100644
--- a/hw/i386/acpi-build.c
+++ b/hw/i386/acpi-build.c
@@ -95,6 +95,7 @@ typedef struct AcpiPmInfo {
     bool s3_disabled;
     bool s4_disabled;
     bool pcihp_bridge_en;
+    bool pcihp_root_en;
     uint8_t s4_val;
     AcpiFadtData fadt;
     uint16_t cpu_hp_io_base;
@@ -245,6 +246,9 @@ static void acpi_get_pm_info(MachineState *machine, AcpiPmInfo *pm)
     pm->pcihp_bridge_en =
         object_property_get_bool(obj, "acpi-pci-hotplug-with-bridge-support",
                                  NULL);
+    pm->pcihp_root_en =
+        object_property_get_bool(obj, "acpi-root-pci-hotplug", NULL);
+
 }
 
 static void acpi_get_misc_info(AcpiMiscInfo *info)
@@ -337,15 +341,18 @@ static void build_append_pcihp_notify_entry(Aml *method, int slot)
 }
 
 static void build_append_pci_bus_devices(Aml *parent_scope, PCIBus *bus,
-                                         bool pcihp_bridge_en)
+                                         bool pcihp_bridge_en,
+                                         bool pcihp_root_en)
 {
     Aml *dev, *notify_method = NULL, *method;
     QObject *bsel;
     PCIBus *sec;
     int i;
+    bool root_bus = pci_bus_is_root(bus);
+    bool root_pcihp_disabled = (root_bus && !pcihp_root_en);
 
     bsel = object_property_get_qobject(OBJECT(bus), ACPI_PCIHP_PROP_BSEL, NULL);
-    if (bsel) {
+    if (bsel && !root_pcihp_disabled) {
         uint64_t bsel_val = qnum_get_uint(qobject_to(QNum, bsel));
 
         aml_append(parent_scope, aml_name_decl("BSEL", aml_int(bsel_val)));
@@ -361,6 +368,9 @@ static void build_append_pci_bus_devices(Aml *parent_scope, PCIBus *bus,
         bool bridge_in_acpi;
 
         if (!pdev) {
+            /* skip if pci hotplug for the root bus is disabled */
+            if (root_pcihp_disabled)
+                continue;
             if (bsel) { /* add hotplug slots for non present devices */
                 dev = aml_device("S%.02X", PCI_DEVFN(slot, 0));
                 aml_append(dev, aml_name_decl("_SUN", aml_int(slot)));
@@ -419,7 +429,7 @@ static void build_append_pci_bus_devices(Aml *parent_scope, PCIBus *bus,
             method = aml_method("_S3D", 0, AML_NOTSERIALIZED);
             aml_append(method, aml_return(aml_int(s3d)));
             aml_append(dev, method);
-        } else if (hotplug_enabled_dev) {
+        } else if (hotplug_enabled_dev && !root_pcihp_disabled) {
             /* add _SUN/_EJ0 to make slot hotpluggable  */
             aml_append(dev, aml_name_decl("_SUN", aml_int(slot)));
 
@@ -439,13 +449,14 @@ static void build_append_pci_bus_devices(Aml *parent_scope, PCIBus *bus,
              */
             PCIBus *sec_bus = pci_bridge_get_sec_bus(PCI_BRIDGE(pdev));
 
-            build_append_pci_bus_devices(dev, sec_bus, pcihp_bridge_en);
+            build_append_pci_bus_devices(dev, sec_bus, pcihp_bridge_en,
+                                         pcihp_root_en);
         }
         /* slot descriptor has been composed, add it into parent context */
         aml_append(parent_scope, dev);
     }
 
-    if (bsel) {
+    if (bsel && !root_pcihp_disabled) {
         aml_append(parent_scope, notify_method);
     }
 
@@ -455,7 +466,7 @@ static void build_append_pci_bus_devices(Aml *parent_scope, PCIBus *bus,
     method = aml_method("PCNT", 0, AML_NOTSERIALIZED);
 
     /* If bus supports hotplug select it and notify about local events */
-    if (bsel) {
+    if (bsel && !root_pcihp_disabled) {
         uint64_t bsel_val = qnum_get_uint(qobject_to(QNum, bsel));
 
         aml_append(method, aml_store(aml_int(bsel_val), aml_name("BNUM")));
@@ -1818,7 +1829,8 @@ build_dsdt(GArray *table_data, BIOSLinker *linker,
         if (bus) {
             Aml *scope = aml_scope("PCI0");
             /* Scan all PCI buses. Generate tables to support hotplug. */
-            build_append_pci_bus_devices(scope, bus, pm->pcihp_bridge_en);
+            build_append_pci_bus_devices(scope, bus, pm->pcihp_bridge_en,
+                                         pm->pcihp_root_en);
 
             if (TPM_IS_TIS_ISA(tpm)) {
                 if (misc->tpm_version == TPM_VERSION_2_0) {
-- 
2.17.1



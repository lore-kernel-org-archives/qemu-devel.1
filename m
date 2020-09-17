Return-Path: <SRS0=BocF=C2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D465FC2BBD1
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2020 07:59:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7110420665
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2020 07:59:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=anisinha-ca.20150623.gappssmtp.com header.i=@anisinha-ca.20150623.gappssmtp.com header.b="TAObXpPF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7110420665
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=anisinha.ca
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45238 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIopT-0006d6-Gm
	for qemu-devel@archiver.kernel.org; Thu, 17 Sep 2020 03:59:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50876)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ani@anisinha.ca>) id 1kIoei-0000C1-4S
 for qemu-devel@nongnu.org; Thu, 17 Sep 2020 03:48:36 -0400
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:44145)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ani@anisinha.ca>) id 1kIoef-0004rU-7v
 for qemu-devel@nongnu.org; Thu, 17 Sep 2020 03:48:35 -0400
Received: by mail-pf1-x441.google.com with SMTP id o20so676884pfp.11
 for <qemu-devel@nongnu.org>; Thu, 17 Sep 2020 00:48:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=anisinha-ca.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=HieR0JUcIVqOsEn9fSMCcXQosTZo8bCqKBMgyay5mK4=;
 b=TAObXpPFi0IbC7+gDYSJVWjfMGIMmNXNClqA/lX3fIKNmZ7HKOE8KTuzCAm2NZ//K3
 D89mQYOYgxwR0SBgQ0GxpWeM/tNYbEoeBr+WeZ/1Z26A2+bV7DxaMyg69RYGRqMsYWJL
 sDKpFt3RS9hQvxl7PpQqnZ7wwwmPTrUmp0/u7tsV9QGVWRc+uhs76aij09FG4MJy3MmU
 w2jbutbxMbwGgIJChPpMG9J9eBq+atoVEk2Q4wu0EaEJBRbqICLbSOQzZgoLaEAOi1Rm
 Xj15w33WL24vdHl5riG6CAfE2LTqra/aduQlWwQIMtjxIo8S9BATa9N5m071xhOzb6Mh
 gbVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=HieR0JUcIVqOsEn9fSMCcXQosTZo8bCqKBMgyay5mK4=;
 b=PkPpXXdffPiJj663YKHScm6l1M4MU2i0RXbviTwkjqqwpJjvc07HIMf/R0HXwBpx6/
 WfI5qARI6LKFRXFQx25eGcKStAur5Ias7MDMgnkwarAF/ATRKxzXjSGMiJ3Re8Q2OD4s
 Nph6g9A7koz2HFpIgOVmmw17Lo1BOLRa7K8V4MX2v89GUa7sWO+wgvK0Wtwcd97bq8zU
 /V0CZsx4COu2jUbygPIrzb7Jy3AP/THsnoGiTUqve+DTYLoQt5eDvcQ4ng2CtUs5dtWb
 Ta3rkajeNaU+mOsBrM9epa8MLoCBlitLqs/RPAiYuCI8DPvK6yQr0jJTXQ/ZrFAG3Fd8
 tR/Q==
X-Gm-Message-State: AOAM532FIKoH//wYKnOFIZ00F3zg4ikclNY+IEBB7/tBE4yjGOEsa7WI
 bsYzkDONiyXLA1zEO7Fl9U+fi0tMia279yqM
X-Google-Smtp-Source: ABdhPJxdBwaByixGxlxksDY17U0FfdnipzFCYgeAmBiDMHOgAtM7qneM1dfSpjB27mYvqGppfG3dcw==
X-Received: by 2002:a62:1648:0:b029:142:2501:39fb with SMTP id
 69-20020a6216480000b0290142250139fbmr10246947pfw.74.1600328911466; 
 Thu, 17 Sep 2020 00:48:31 -0700 (PDT)
Received: from localhost.localdomain ([115.96.122.113])
 by smtp.googlemail.com with ESMTPSA id y3sm20572516pfb.18.2020.09.17.00.48.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Sep 2020 00:48:30 -0700 (PDT)
From: Ani Sinha <ani@anisinha.ca>
To: qemu-devel@nongnu.org
Subject: [PATCH v6 09/12] piix4: don't reserve hw resources when hotplug is
 off globally
Date: Thu, 17 Sep 2020 13:17:29 +0530
Message-Id: <20200917074733.13612-10-ani@anisinha.ca>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200917074733.13612-1-ani@anisinha.ca>
References: <20200917074733.13612-1-ani@anisinha.ca>
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
 "Michael S. Tsirkin" <mst@redhat.com>, jusual@redhat.com,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Ani Sinha <ani@anisinha.ca>,
 Igor Mammedov <imammedo@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

When acpi hotplug is turned off for both root pci bus as well as for pci
bridges, we should not generate the related ACPI code for DSDT table or
initialize related hw ports or reserve hw resources. This change makes
sure all those operations are turned off in the case ACPI pci hotplug is
off globally.

In this change, we also make sure ACPI code for the PCNT method are only
added when bsel is enabled for the corresponding pci bus or bridge hotplug
is turned on.

As q35 machines do not use bsel for it's pci buses at this point in time, this
change affects DSDT acpi table for q35 machines as well. Therefore, we will
also need to commit the updated golden master DSDT table acpi binary blobs as
well. This is done in the following commit. Without the updated table blobs,
the unit tests would fail with this patch.

Signed-off-by: Ani Sinha <ani@anisinha.ca>
---
 hw/acpi/piix4.c      |  6 ++++--
 hw/i386/acpi-build.c | 25 ++++++++++++++++++-------
 2 files changed, 22 insertions(+), 9 deletions(-)

diff --git a/hw/acpi/piix4.c b/hw/acpi/piix4.c
index e6163bb6ce..b70b1f98af 100644
--- a/hw/acpi/piix4.c
+++ b/hw/acpi/piix4.c
@@ -596,8 +596,10 @@ static void piix4_acpi_system_hot_add_init(MemoryRegion *parent,
                           "acpi-gpe0", GPE_LEN);
     memory_region_add_subregion(parent, GPE_BASE, &s->io_gpe);
 
-    acpi_pcihp_init(OBJECT(s), &s->acpi_pci_hotplug, bus, parent,
-                    s->use_acpi_hotplug_bridge);
+    if (s->use_acpi_hotplug_bridge || s->use_acpi_root_pci_hotplug) {
+        acpi_pcihp_init(OBJECT(s), &s->acpi_pci_hotplug, bus, parent,
+                        s->use_acpi_hotplug_bridge);
+    }
 
     s->cpu_hotplug_legacy = true;
     object_property_add_bool(OBJECT(s), "cpu-hotplug-legacy",
diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
index e079b686f5..e41bb0992b 100644
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
+        object_property_get_bool(obj, "acpi-root-pci-hotplug",
+                                 NULL);
 }
 
 static void acpi_get_misc_info(AcpiMiscInfo *info)
@@ -450,10 +454,12 @@ static void build_append_pci_bus_devices(Aml *parent_scope, PCIBus *bus,
     }
 
     /* Append PCNT method to notify about events on local and child buses.
-     * Add unconditionally for root since DSDT expects it.
+     * Add this method for root bus only when hotplug is enabled since DSDT
+     * expects it.
      */
-    method = aml_method("PCNT", 0, AML_NOTSERIALIZED);
-
+    if (bsel || pcihp_bridge_en) {
+        method = aml_method("PCNT", 0, AML_NOTSERIALIZED);
+    }
     /* If bus supports hotplug select it and notify about local events */
     if (bsel) {
         uint64_t bsel_val = qnum_get_uint(qobject_to(QNum, bsel));
@@ -479,7 +485,10 @@ static void build_append_pci_bus_devices(Aml *parent_scope, PCIBus *bus,
             aml_append(method, aml_name("^S%.02X.PCNT", devfn));
         }
     }
-    aml_append(parent_scope, method);
+
+    if (bsel || pcihp_bridge_en) {
+        aml_append(parent_scope, method);
+    }
     qobject_unref(bsel);
 }
 
@@ -1504,7 +1513,9 @@ build_dsdt(GArray *table_data, BIOSLinker *linker,
         build_hpet_aml(dsdt);
         build_piix4_isa_bridge(dsdt);
         build_isa_devices_aml(dsdt);
-        build_piix4_pci_hotplug(dsdt);
+        if (pm->pcihp_bridge_en || pm->pcihp_root_en) {
+            build_piix4_pci_hotplug(dsdt);
+        }
         build_piix4_pci0_int(dsdt);
     } else {
         sb_scope = aml_scope("_SB");
@@ -1546,7 +1557,7 @@ build_dsdt(GArray *table_data, BIOSLinker *linker,
     {
         aml_append(scope, aml_name_decl("_HID", aml_string("ACPI0006")));
 
-        if (misc->is_piix4) {
+        if (misc->is_piix4 && (pm->pcihp_bridge_en || pm->pcihp_root_en)) {
             method = aml_method("_E01", 0, AML_NOTSERIALIZED);
             aml_append(method,
                 aml_acquire(aml_name("\\_SB.PCI0.BLCK"), 0xFFFF));
@@ -1698,7 +1709,7 @@ build_dsdt(GArray *table_data, BIOSLinker *linker,
     crs_range_set_free(&crs_range_set);
 
     /* reserve PCIHP resources */
-    if (pm->pcihp_io_len) {
+    if (pm->pcihp_io_len && (pm->pcihp_bridge_en || pm->pcihp_root_en)) {
         dev = aml_device("PHPR");
         aml_append(dev, aml_name_decl("_HID", aml_string("PNP0A06")));
         aml_append(dev,
-- 
2.17.1



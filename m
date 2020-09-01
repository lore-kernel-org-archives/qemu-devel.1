Return-Path: <SRS0=/2J2=CK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECFE1C433E6
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 09:52:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B5EBD2083B
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 09:52:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=anisinha-ca.20150623.gappssmtp.com header.i=@anisinha-ca.20150623.gappssmtp.com header.b="EL0IEcks"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B5EBD2083B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=anisinha.ca
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41284 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kD2xo-0000DJ-QQ
	for qemu-devel@archiver.kernel.org; Tue, 01 Sep 2020 05:52:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42726)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ani@anisinha.ca>) id 1kD2vV-00042t-8i
 for qemu-devel@nongnu.org; Tue, 01 Sep 2020 05:50:05 -0400
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:33688)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ani@anisinha.ca>) id 1kD2vT-0002wU-AQ
 for qemu-devel@nongnu.org; Tue, 01 Sep 2020 05:50:04 -0400
Received: by mail-pg1-x542.google.com with SMTP id e33so415784pgm.0
 for <qemu-devel@nongnu.org>; Tue, 01 Sep 2020 02:50:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=anisinha-ca.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=kWHo9X9OBZwhoM/Kz051GeLSEd1ecmj0d9rMesNU2TQ=;
 b=EL0IEckssDIUYNXznI64SCUfFOCCH0ox+LdLnG4P/HgAaDCgYaPNgpWJBKUgJNezKd
 2gnQBN+0sZX255g+Qt6XxhBzz04N1U/xwCDeaoJAk41TmHXF50fLbLOI+ltjgatPgQ9w
 2cPbyDWgRhxQuw5tW5aHjPAd7mnvkhxQFkJDTwODGBmQWM8Eia62Ibd8aMXZrERrN4YB
 howfkTurpnhWFx8oT2o21iWO5c19XyTqBBqeRx+JR/+d4KCzNGLjGmqG0jiJ8npVCCaW
 9aI/wQc67AXGL6mW29QleUCd1G+w5uUCj9xrdxhr0vzHS1oC2U/FR89KaKhIffCh95qn
 AzmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=kWHo9X9OBZwhoM/Kz051GeLSEd1ecmj0d9rMesNU2TQ=;
 b=rYzH+3VxgxLSQGhCmmerPY+fcmTlr2UBhzUi4aYTPVYm/SM8w05FzUd3QiGsfxtqGl
 j+TtwCpt09joF+lqv8ZbD8Bz4guMIY5iwh1YapDOJg4ztlsCRoHOxC7CGayfWeaP/XFR
 6rX7/KrE33291DLXVpUPPmabiixWc5ZWkt5VkLz3pbgaQm5dTT/2rDxjEIdyghyf5kWJ
 Zsf3af03dvyvb3tJ4ZjgISLunW0scUdmMh1GVvXb3NOK01qy/jYaX+GZeefYpX/of4AX
 o96kiqIr+k0fzOW841Lpq2yt5urrZA+4UN0GXmK4q7IjV3/Hl04RQFvIiOaM21O4kP7S
 8yrw==
X-Gm-Message-State: AOAM5314BRAwVlijzceooQr/lHI9kY4LBotxYzgKS93th9mu3b5ziZ5M
 6+B1DR62zdg+D+1jULFdhZeDhfasM8Mya3Zh
X-Google-Smtp-Source: ABdhPJxjLe9iLm4d58pLQQZm3E/SEfOIU2W+PPsMF7VTFZ8GXsC/6DsZk1qFfHQ2kwz4dOM0CZtfAg==
X-Received: by 2002:a62:1683:: with SMTP id 125mr426481pfw.189.1598953801414; 
 Tue, 01 Sep 2020 02:50:01 -0700 (PDT)
Received: from localhost.localdomain ([203.163.237.89])
 by smtp.googlemail.com with ESMTPSA id o63sm1081872pfb.190.2020.09.01.02.49.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Sep 2020 02:50:00 -0700 (PDT)
From: Ani Sinha <ani@anisinha.ca>
To: qemu-devel@nongnu.org
Subject: [PATCH] piix4: don't reserve hw resources when hotplug is off globally
Date: Tue,  1 Sep 2020 15:19:22 +0530
Message-Id: <20200901094922.25514-2-ani@anisinha.ca>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200901094922.25514-1-ani@anisinha.ca>
References: <20200901094922.25514-1-ani@anisinha.ca>
Received-SPF: none client-ip=2607:f8b0:4864:20::542;
 envelope-from=ani@anisinha.ca; helo=mail-pg1-x542.google.com
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
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Ani Sinha <ani@anisinha.ca>,
 Igor Mammedov <imammedo@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

When acpi hotplug is turned off for both root pci bus as well as for pci
bridges, we should not generate the related amls for DSDT table or initialize
related hw ports or reserve hw resources. This change makes sure all those
operations are turned off in the case acpi pci hotplug is off globally.

Signed-off-by: Ani Sinha <ani@anisinha.ca>
---
 hw/acpi/piix4.c      |  6 ++++--
 hw/i386/acpi-build.c | 10 ++++++++--
 2 files changed, 12 insertions(+), 4 deletions(-)

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
index b7bcbbbb2a..5365b3d290 100644
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
@@ -1504,7 +1508,9 @@ build_dsdt(GArray *table_data, BIOSLinker *linker,
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
@@ -1698,7 +1704,7 @@ build_dsdt(GArray *table_data, BIOSLinker *linker,
     crs_range_set_free(&crs_range_set);
 
     /* reserve PCIHP resources */
-    if (pm->pcihp_io_len) {
+    if (pm->pcihp_io_len && (pm->pcihp_bridge_en || pm->pcihp_root_en)) {
         dev = aml_device("PHPR");
         aml_append(dev, aml_name_decl("_HID", aml_string("PNP0A06")));
         aml_append(dev,
-- 
2.17.1



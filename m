Return-Path: <SRS0=atk5=B7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0192C433E1
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 16:54:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 98D5A20702
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 16:54:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=anisinha-ca.20150623.gappssmtp.com header.i=@anisinha-ca.20150623.gappssmtp.com header.b="ClF6DJRI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 98D5A20702
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=anisinha.ca
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60932 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k9AJV-00086r-NH
	for qemu-devel@archiver.kernel.org; Fri, 21 Aug 2020 12:54:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45010)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ani@anisinha.ca>) id 1k9AIy-0007ft-Mv
 for qemu-devel@nongnu.org; Fri, 21 Aug 2020 12:54:16 -0400
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643]:41999)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ani@anisinha.ca>) id 1k9AIw-0003kw-GX
 for qemu-devel@nongnu.org; Fri, 21 Aug 2020 12:54:16 -0400
Received: by mail-pl1-x643.google.com with SMTP id f5so1131492plr.9
 for <qemu-devel@nongnu.org>; Fri, 21 Aug 2020 09:54:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=anisinha-ca.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id;
 bh=14wpluU6NR6qwHDAbZG/4NWjd1z9J0dR1pJdUmBacr0=;
 b=ClF6DJRI92wTejCQWtSoWzI8Uhz/6Zn4YP2XdQXq3T2e1fxNi1obHkdxHYSVI2URUO
 z1TvXtIgDhGC5uGGTmNhEhdmmReizEiwxgPigAe/o/dXWq6f/QyORYvo/Ce6fNSoK1xU
 waM3PBBcfG4ljkVezVIMRaRQH0q0B/JOeLVpHVzXY1At1tnL38749HjzoUE/Y5Lduw3e
 QH0/01YjQuwoSkQj3sdZhm2tMEFq40YU+41p+RbCo7YkAT9ksi92rRfytQns1ozKG3Nu
 svyBDeo1pmpzfCkrgVU10CGjESGk1B9onGbR3g9cVJXdM+rY7b3zCtg5m11lojPVFE54
 YIWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=14wpluU6NR6qwHDAbZG/4NWjd1z9J0dR1pJdUmBacr0=;
 b=PTar7Yt0LdzLiyaghrytJznELTZKcKqhn7c1J9U9D93uvbFj3l/Al2Dy1Uh45lFrJ1
 QtUz1PWnCY+q1JoS2JEd6Nd+2G9HXNfReep5JnPWGDFRZPZkvVmFgSDII7IGglyh7/N1
 nHsd62sRIX5Z5phpeU0T2mEwNXP3y6TOzjG3rn9dCXYq+XZPUDqhXxbhrO0JlY4L0ZBs
 yIFQQ8isK9eiSq1ce8fafFqA9030tyWwB/18r32/hhRzcCAzWV0qFpu6/fqswWTX+YNw
 JD25f76EdoLiBvchLKcE8Uw/yPIGyb6g+ZE96bLIKp7OfjS8XS7awYOuRDVPM3D3xR4S
 eAGw==
X-Gm-Message-State: AOAM533PgdzphCsWCUOOsoF7usAWsFMzFUpmuLwrdfdLEpsFr6bFFl14
 fuWKoa1SnTJJyhni8W5ylrN7RYC1/2UHfSJZ
X-Google-Smtp-Source: ABdhPJzZv2ucdGWYyijfrMlngk+LXpCb8k8LWNSL+F4KLF/Ku7H52sK0e7R7qqquQZfDfMEYJ4NXrQ==
X-Received: by 2002:a17:902:221:: with SMTP id
 30mr3106665plc.222.1598028851887; 
 Fri, 21 Aug 2020 09:54:11 -0700 (PDT)
Received: from localhost.localdomain ([115.96.123.214])
 by smtp.googlemail.com with ESMTPSA id u15sm2420085pje.42.2020.08.21.09.54.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Aug 2020 09:54:11 -0700 (PDT)
From: Ani Sinha <ani@anisinha.ca>
To: qemu-devel@nongnu.org
Subject: [PATCH V8] Introduce a new flag for i440fx to disable PCI hotplug on
 the root bus
Date: Fri, 21 Aug 2020 22:24:03 +0530
Message-Id: <20200821165403.26589-1-ani@anisinha.ca>
X-Mailer: git-send-email 2.17.1
Received-SPF: none client-ip=2607:f8b0:4864:20::643;
 envelope-from=ani@anisinha.ca; helo=mail-pl1-x643.google.com
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
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Ani Sinha <ani@anisinha.ca>, Igor Mammedov <imammedo@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We introduce a new global flag 'acpi-root-pci-hotplug' for i440fx with which
we can turn on or off PCI device hotplug on the root bus. This flag can be
used to prevent all PCI devices from getting hotplugged or unplugged from the
root PCI bus.
This feature is targetted mostly towards Windows VMs. It is useful in cases
where some hypervisor admins want to deploy guest VMs in a way so that the
users of the guest OSes are not able to hot-eject certain PCI devices from
the Windows system tray. Laine has explained the use case here in detail:
https://www.redhat.com/archives/libvir-list/2020-February/msg00110.html

Julia has resolved this issue for PCIE buses with the following commit:
530a0963184e57e71a5b538 ("pcie_root_port: Add hotplug disabling option")

This commit attempts to introduce similar behavior for PCI root buses used in
i440fx machine types (although in this case, we do not have a per-slot
capability to turn hotplug on or off).

Usage:
   -global PIIX4_PM.acpi-root-pci-hotplug=off

By default, this option is enabled which means that hotplug is turned on for
the PCI root bus.

The previously existing flag 'acpi-pci-hotplug-with-bridge-support' for PCI-PCI
bridges remain as is and can be used along with this new flag to control PCI
hotplug on PCI bridges.

This change has been tested using a Windows 2012R2 server guest image and also
with a Windows 2019 server guest image on a Ubuntu 18.04 host using the latest
master qemu from upstream.

Signed-off-by: Ani Sinha <ani@anisinha.ca>
---
 hw/acpi/pcihp.c         | 23 ++++++++++++++++++++++-
 hw/acpi/piix4.c         |  5 ++++-
 include/hw/acpi/pcihp.h |  2 +-
 3 files changed, 27 insertions(+), 3 deletions(-)

Change Log:
V7..V8: Cosmetic. Removed extra new line in the patch. Rebased to latest
upstream master and retested with both versions of Windows.

diff --git a/hw/acpi/pcihp.c b/hw/acpi/pcihp.c
index 9e31ab2da4..39b1f74442 100644
--- a/hw/acpi/pcihp.c
+++ b/hw/acpi/pcihp.c
@@ -104,6 +104,24 @@ static void acpi_set_pci_info(void)
     }
 }
 
+static void acpi_pcihp_disable_root_bus(void)
+{
+    static bool root_hp_disabled;
+    PCIBus *bus;
+
+    if (root_hp_disabled) {
+        return;
+    }
+
+    bus = find_i440fx();
+    if (bus) {
+        /* setting the hotplug handler to NULL makes the bus non-hotpluggable */
+        qbus_set_hotplug_handler(BUS(bus), NULL);
+    }
+    root_hp_disabled = true;
+    return;
+}
+
 static void acpi_pcihp_test_hotplug_bus(PCIBus *bus, void *opaque)
 {
     AcpiPciHpFind *find = opaque;
@@ -209,8 +227,11 @@ static void acpi_pcihp_update(AcpiPciHpState *s)
     }
 }
 
-void acpi_pcihp_reset(AcpiPciHpState *s)
+void acpi_pcihp_reset(AcpiPciHpState *s, bool acpihp_root_off)
 {
+    if (acpihp_root_off) {
+        acpi_pcihp_disable_root_bus();
+    }
     acpi_set_pci_info();
     acpi_pcihp_update(s);
 }
diff --git a/hw/acpi/piix4.c b/hw/acpi/piix4.c
index 26bac4f16c..e6163bb6ce 100644
--- a/hw/acpi/piix4.c
+++ b/hw/acpi/piix4.c
@@ -78,6 +78,7 @@ typedef struct PIIX4PMState {
 
     AcpiPciHpState acpi_pci_hotplug;
     bool use_acpi_hotplug_bridge;
+    bool use_acpi_root_pci_hotplug;
 
     uint8_t disable_s3;
     uint8_t disable_s4;
@@ -324,7 +325,7 @@ static void piix4_pm_reset(DeviceState *dev)
         pci_conf[0x5B] = 0x02;
     }
     pm_io_space_update(s);
-    acpi_pcihp_reset(&s->acpi_pci_hotplug);
+    acpi_pcihp_reset(&s->acpi_pci_hotplug, !s->use_acpi_root_pci_hotplug);
 }
 
 static void piix4_pm_powerdown_req(Notifier *n, void *opaque)
@@ -635,6 +636,8 @@ static Property piix4_pm_properties[] = {
     DEFINE_PROP_UINT8(ACPI_PM_PROP_S4_VAL, PIIX4PMState, s4_val, 2),
     DEFINE_PROP_BOOL("acpi-pci-hotplug-with-bridge-support", PIIX4PMState,
                      use_acpi_hotplug_bridge, true),
+    DEFINE_PROP_BOOL("acpi-root-pci-hotplug", PIIX4PMState,
+                     use_acpi_root_pci_hotplug, true),
     DEFINE_PROP_BOOL("memory-hotplug-support", PIIX4PMState,
                      acpi_memory_hotplug.is_enabled, true),
     DEFINE_PROP_END_OF_LIST(),
diff --git a/include/hw/acpi/pcihp.h b/include/hw/acpi/pcihp.h
index 8bc4a4c01d..02f4665767 100644
--- a/include/hw/acpi/pcihp.h
+++ b/include/hw/acpi/pcihp.h
@@ -67,7 +67,7 @@ void acpi_pcihp_device_unplug_request_cb(HotplugHandler *hotplug_dev,
                                          Error **errp);
 
 /* Called on reset */
-void acpi_pcihp_reset(AcpiPciHpState *s);
+void acpi_pcihp_reset(AcpiPciHpState *s, bool acpihp_root_off);
 
 extern const VMStateDescription vmstate_acpi_pcihp_pci_status;
 
-- 
2.17.1



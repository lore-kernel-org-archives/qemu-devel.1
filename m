Return-Path: <SRS0=+YCa=CZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E16A5C31E49
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2020 06:22:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7C012221E5
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2020 06:22:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=anisinha-ca.20150623.gappssmtp.com header.i=@anisinha-ca.20150623.gappssmtp.com header.b="j4uNYF1L"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C012221E5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=anisinha.ca
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33712 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIQpY-0002fJ-70
	for qemu-devel@archiver.kernel.org; Wed, 16 Sep 2020 02:22:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59476)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ani@anisinha.ca>) id 1kIQhu-0001ul-Na
 for qemu-devel@nongnu.org; Wed, 16 Sep 2020 02:14:18 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b]:43856)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ani@anisinha.ca>) id 1kIQhr-0005lV-AQ
 for qemu-devel@nongnu.org; Wed, 16 Sep 2020 02:14:18 -0400
Received: by mail-pf1-x42b.google.com with SMTP id f18so3335930pfa.10
 for <qemu-devel@nongnu.org>; Tue, 15 Sep 2020 23:14:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=anisinha-ca.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=Q9e5WoPP1IxGkMk/UfsIYmbQR1ZYEM3M7sDwaoDUZm8=;
 b=j4uNYF1LKs7De9YVYy3TSc0dYYH7KLOD6hX2jOcuqePBg47UCEoSxuruXCf9pZxi7v
 82eB/tJ4hDq+OOj9BDW8AQ+SZLWwLG6+z7aFGu9VzAXFbmy6USO2vkkmLUDP2dErDcdB
 bXSP4nKuy5xhZJnld+41cjzUDPXajp57LtO2KLRqIRcnIWZhL/J4dwNZm6VLzT7HXvRu
 h8D4PqO2Jn7z+BjWvlyLBlEsfGbqRWhwMcbnYShACOzE0vt3pGfBo6XBUNsNB7At7nbp
 /FgrXiqUS1HlTW3bgw1lx8pNAXlJ8QGBjcAOHDNDRpKOcTKOzwMG7t01YFreNyYFoHea
 Eiwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=Q9e5WoPP1IxGkMk/UfsIYmbQR1ZYEM3M7sDwaoDUZm8=;
 b=An1VVnm/MBBbdbCbi2VLMBAlxCS71vF9n3voRlDM16PwKsVv4yV8pc+0k+XsVXVwZS
 WKF9k7sU4HU1qQfZnrkkTvG2DxdTGZn3s0uS4EBGKYDikl8Zw2tTzopz/oC0SpQJ22Me
 4QLM47PDkwnmIa0trMMuKL9yVQ09H9tFI6igLNvvCcgD5xYln7Di6dy4sK+3E314AdYu
 K7FkUno4car8SK0wcU81VdfY9lSOGZgUxGVKVCx+7g55CwA9aQaqwvGdL9AnS4FSvJYY
 oAXcwK8rLDrmoGrWecy4YlTznPmYVoWd9Kza3loMTHYtBUZS2RXnqDE3Iw8bzHKOVpm1
 kHBw==
X-Gm-Message-State: AOAM533EMb57U3btq+5Z/+5QwHPmqtRgkPOvRxWLRg8SEmyvIdtfPlFE
 zaZSTYe5wN8eYr7xzJfa8okhM+U2MRwSIleT
X-Google-Smtp-Source: ABdhPJwkNQvagdECH5/v3VzLffJt760XTVppSAaQcv7pJttCmfCcyJ0ERSSvaZkDx5Mp7mEyhCwd2A==
X-Received: by 2002:a63:1c4e:: with SMTP id c14mr16848858pgm.98.1600236853419; 
 Tue, 15 Sep 2020 23:14:13 -0700 (PDT)
Received: from localhost.localdomain ([203.163.234.244])
 by smtp.googlemail.com with ESMTPSA id c20sm583164pfc.209.2020.09.15.23.14.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Sep 2020 23:14:12 -0700 (PDT)
From: Ani Sinha <ani@anisinha.ca>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 05/11] i440fx/acpi: do not add hotplug related amls for
 cold plugged bridges
Date: Wed, 16 Sep 2020 11:43:29 +0530
Message-Id: <20200916061335.14045-6-ani@anisinha.ca>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200916061335.14045-1-ani@anisinha.ca>
References: <20200916061335.14045-1-ani@anisinha.ca>
Received-SPF: none client-ip=2607:f8b0:4864:20::42b;
 envelope-from=ani@anisinha.ca; helo=mail-pf1-x42b.google.com
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

Cold plugged bridges are not hot unpluggable, even when their hotplug
property (acpi-pci-hotplug-with-bridge-support) is turned off. Please see
the function acpi_pcihp_pc_no_hotplug() (thanks Julia). However, with
the current implementaton, windows would try to hot-unplug a pci bridge when
it's hotplug switch is off. This is regardless of whether there are devices
attached to the bridge. This is because we add amls like _EJ0 etc for the
pci slot where the bridge is cold plugged. We have a demo video here:
https://youtu.be/pME2sjyQweo

In this fix, we identify a cold plugged bridge and for cold plugged bridges,
we do not add the appropriate amls and acpi methods that are used by the OS
to identify a hot-pluggable/unpluggable pci device. After this change, Windows
does not show an option to eject the PCI bridge. A demo video is here:
https://youtu.be/kbgej5B9Hgs

As a result of the patch, the following are the changes to the DSDT ACPI table:

@@ -858,38 +858,33 @@
                     Return (Zero)
                 }

                 Method (_S2D, 0, NotSerialized)  // _S2D: S2 Device State
                 {
                     Return (Zero)
                 }

                 Method (_S3D, 0, NotSerialized)  // _S3D: S3 Device State
                 {
                     Return (Zero)
                 }
             }

             Device (S18)
             {
-                Name (_SUN, 0x03)  // _SUN: Slot User Number
                 Name (_ADR, 0x00030000)  // _ADR: Address
-                Method (_EJ0, 1, NotSerialized)  // _EJx: Eject Device
-                {
-                    PCEJ (BSEL, _SUN)
-                }
             }

             Device (S20)
             {
                 Name (_SUN, 0x04)  // _SUN: Slot User Number
                 Name (_ADR, 0x00040000)  // _ADR: Address
                 Method (_EJ0, 1, NotSerialized)  // _EJx: Eject Device
                 {
                     PCEJ (BSEL, _SUN)
                 }
             }

             Device (S28)
             {
                 Name (_SUN, 0x05)  // _SUN: Slot User Number
                 Name (_ADR, 0x00050000)  // _ADR: Address
@@ -1148,37 +1143,32 @@
                     PCEJ (BSEL, _SUN)
                 }
             }

             Device (SF8)
             {
                 Name (_SUN, 0x1F)  // _SUN: Slot User Number
                 Name (_ADR, 0x001F0000)  // _ADR: Address
                 Method (_EJ0, 1, NotSerialized)  // _EJx: Eject Device
                 {
                     PCEJ (BSEL, _SUN)
                 }
             }

             Method (DVNT, 2, NotSerialized)
             {
-                If ((Arg0 & 0x08))
-                {
-                    Notify (S18, Arg1)
-                }
-
                 If ((Arg0 & 0x10))
                 {
                     Notify (S20, Arg1)
                 }

                 If ((Arg0 & 0x20))
                 {
                     Notify (S28, Arg1)
                 }

                 If ((Arg0 & 0x40))
                 {
                     Notify (S30, Arg1)
                 }

                 If ((Arg0 & 0x80))

While at it, I have also updated a stale comment.

This change is tested with a Windows 2012R2 guest image and Windows 2019 server
guest image running on Ubuntu 18.04 host. This change is based off of upstream
qemu master branch tag v5.1.0.

Signed-off-by: Ani Sinha <ani@anisinha.ca>
---
 hw/i386/acpi-build.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
index 7a5a8b3521..e079b686f5 100644
--- a/hw/i386/acpi-build.c
+++ b/hw/i386/acpi-build.c
@@ -359,6 +359,7 @@ static void build_append_pci_bus_devices(Aml *parent_scope, PCIBus *bus,
         int slot = PCI_SLOT(i);
         bool hotplug_enabled_dev;
         bool bridge_in_acpi;
+        bool cold_plugged_bridge;
 
         if (!pdev) {
             if (bsel) { /* add hotplug slots for non present devices */
@@ -380,15 +381,14 @@ static void build_append_pci_bus_devices(Aml *parent_scope, PCIBus *bus,
         pc = PCI_DEVICE_GET_CLASS(pdev);
         dc = DEVICE_GET_CLASS(pdev);
 
-        /* When hotplug for bridges is enabled, bridges are
-         * described in ACPI separately (see build_pci_bus_end).
-         * In this case they aren't themselves hot-pluggable.
+        /*
+         * Cold plugged bridges aren't themselves hot-pluggable.
          * Hotplugged bridges *are* hot-pluggable.
          */
-        bridge_in_acpi = pc->is_bridge && pcihp_bridge_en &&
-            !DEVICE(pdev)->hotplugged;
+        cold_plugged_bridge = pc->is_bridge && !DEVICE(pdev)->hotplugged;
+        bridge_in_acpi =  cold_plugged_bridge && pcihp_bridge_en;
 
-        hotplug_enabled_dev = bsel && dc->hotpluggable && !bridge_in_acpi;
+        hotplug_enabled_dev = bsel && dc->hotpluggable && !cold_plugged_bridge;
 
         if (pc->class_id == PCI_CLASS_BRIDGE_ISA) {
             continue;
-- 
2.17.1



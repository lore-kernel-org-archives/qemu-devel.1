Return-Path: <SRS0=sZ46=CY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68CA7C433E2
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 14:47:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D7A44206B5
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 14:47:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=anisinha-ca.20150623.gappssmtp.com header.i=@anisinha-ca.20150623.gappssmtp.com header.b="kXM0I/bN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D7A44206B5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=anisinha.ca
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50496 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kICFF-0001l9-MC
	for qemu-devel@archiver.kernel.org; Tue, 15 Sep 2020 10:47:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33102)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ani@anisinha.ca>) id 1kICBV-0005Ru-C7
 for qemu-devel@nongnu.org; Tue, 15 Sep 2020 10:43:53 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a]:41907)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ani@anisinha.ca>) id 1kICBT-0003wI-9s
 for qemu-devel@nongnu.org; Tue, 15 Sep 2020 10:43:53 -0400
Received: by mail-pl1-x62a.google.com with SMTP id m15so1455340pls.8
 for <qemu-devel@nongnu.org>; Tue, 15 Sep 2020 07:43:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=anisinha-ca.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=Q9e5WoPP1IxGkMk/UfsIYmbQR1ZYEM3M7sDwaoDUZm8=;
 b=kXM0I/bNbbVYAjwGqu0lxtjyIREDGjmF0QTcNX8FGKlqNlbPbbw5laVe29gwbIDMNM
 +cwHXZWsoPcXcr02Y4wlGfbCNV9RjdQIyWyl4u4F5sdPFEHrHnQshb4nNKIUkgzBIEez
 P6PzCyAkTjlhdWd4/nR2YGtwGsxyDqaxGmh8CwI5RAHDKi+wG0SUl/F1N7hfv+fWTKyQ
 wqcij1trV5BNps0Pt/p8AM7C6TjtNDNMn6DTkuhW+rwYcD5yr/iX58QfIJVRxRv2sXRX
 9fvHBAnlQef9oJKknItUnzjt2iML5gNsso9ZCgJmKNcNf+Sc5L0Wh5H/MDRop9I3xi25
 /ysA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=Q9e5WoPP1IxGkMk/UfsIYmbQR1ZYEM3M7sDwaoDUZm8=;
 b=IN+38NkCt4+5YI5DM3vhKJ7bA0nBZIwaRJ09biQse/qP8UoNiYfsR7wxKJ5+fSH5fO
 YBaTAJXMeMHkQ0RjqJENv8JeH4QzE/kIHCQ4aNiKNwM8QmbALmdQC1UnhgZ/IVNAHCyX
 EvIVItj5OVGrkLDR1t8UUP/24fSOm025MSVRqrFzoWb1sRqA6u5F3lWa0JseHW0Ob+LY
 5A+wD7BTWeQmnNt7zagYCUfBXuSePQXEQm1W/WJMRJqaQmiuNsyfAA5u29b+58tXG6oE
 MUQaCoDV7rz6b5E02OennnTS6k3VButlQwlpHg9hEVJhhBa5yzBsqbOwg+IBsQx51h9f
 BTHw==
X-Gm-Message-State: AOAM5320JeBxyqo8pGUVeeIcwFQ9FsA3ZCcpBWZN7NvB7/4ZslZpl7Nn
 Efgq33T/e2gTbwL41/l/M8yfhFFdB3sIHWNo
X-Google-Smtp-Source: ABdhPJwTCdBuCG43qnXsV3ifrn+w1cqvrsuCpqGuOLs+5ewHi9nPgOWTIW4LtJLRxZfWsZ8G6hkKFw==
X-Received: by 2002:a17:90a:f686:: with SMTP id
 cl6mr4259672pjb.43.1600181029447; 
 Tue, 15 Sep 2020 07:43:49 -0700 (PDT)
Received: from localhost.localdomain ([115.96.128.178])
 by smtp.googlemail.com with ESMTPSA id r2sm11520693pga.94.2020.09.15.07.43.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Sep 2020 07:43:48 -0700 (PDT)
From: Ani Sinha <ani@anisinha.ca>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 5/9] i440fx/acpi: do not add hotplug related amls for cold
 plugged bridges
Date: Tue, 15 Sep 2020 20:13:09 +0530
Message-Id: <20200915144314.4997-6-ani@anisinha.ca>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200915144314.4997-1-ani@anisinha.ca>
References: <20200915144314.4997-1-ani@anisinha.ca>
Received-SPF: none client-ip=2607:f8b0:4864:20::62a;
 envelope-from=ani@anisinha.ca; helo=mail-pl1-x62a.google.com
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



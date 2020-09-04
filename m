Return-Path: <SRS0=8bV5=CN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A2D6C433E2
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2020 16:13:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2A59E2074D
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2020 16:13:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=anisinha-ca.20150623.gappssmtp.com header.i=@anisinha-ca.20150623.gappssmtp.com header.b="JgsH3HL8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A59E2074D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=anisinha.ca
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58320 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kEEKv-0003tx-Bc
	for qemu-devel@archiver.kernel.org; Fri, 04 Sep 2020 12:13:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34590)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ani@anisinha.ca>) id 1kEEI3-0000M2-1T
 for qemu-devel@nongnu.org; Fri, 04 Sep 2020 12:10:15 -0400
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:35821)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ani@anisinha.ca>) id 1kEEI0-0003ZF-U9
 for qemu-devel@nongnu.org; Fri, 04 Sep 2020 12:10:14 -0400
Received: by mail-pf1-x443.google.com with SMTP id o68so4868275pfg.2
 for <qemu-devel@nongnu.org>; Fri, 04 Sep 2020 09:10:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=anisinha-ca.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id;
 bh=ghFMA8BY0AfUwWC47JwaY8XB5Sm1/ORo3UrAREV6/J8=;
 b=JgsH3HL8Uawy0K6KjuaRIYj9Qb0IQOY+dlceVOHSgboBHa1FlnrRL21uSCN3lgTlsr
 o0afQmyKVcR9w+DE3u00yhkgS17gwB8VFFuSyRqtuyq3I4920gghcROWsRee0BfkrpQ3
 v9sYP+ZwZBaJ2OouYYckD0epGbf0wSz8lCrd9HqYZd8Medg353714gUzfH2Oydu9GWuO
 O8mJ120TT9AdgVK/uTxagC3OGSsvouWQEd/+QWBgVBE/E9+EMsC8dJK/aFolW9xlttO/
 UEhWxuD3GAdNAqCMb3KCOiJyuoWoDeaXZ8fPE5jte21ZDleU2470d4t16Z82CRGHf/i+
 eB9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=ghFMA8BY0AfUwWC47JwaY8XB5Sm1/ORo3UrAREV6/J8=;
 b=rPi6lNI+lYPWsz8xUp7lNp27bTNr709wKjDR2ohLneyXS+hC23erywkGHThdY5U2jm
 7vd/R5RslagSuVsEVOf22wvHGfSsWrKlzB1Zsq4cs1RG4kpAcJa6oGqVJ1iLGQlLoZWD
 1GEiU70zd3n4MX2lbfTqFoqUDxMIbX9c94iBe/5PuPKZGyahZHx/8v/vDNUlfHFo1arL
 41rYu+EZ2xGBdunC9RjqYrNMbLeLuH6GMBhywiZuPWAWbazwDKNjp+WACpr6dojr2QRd
 Wgt/k02r8+WkQaWTZ/U+mr7PfGch+ZwlbWSvFIX7FMlHcfZaCqrcOnOQmUTNICXIb0Te
 bcCA==
X-Gm-Message-State: AOAM530ztwivYmGUurxnyeSuJEU/2PHtXQfOtkM+hMp27LL8j6Okl1+s
 cJZbIF0tnv86+/d/Hs5ZjkPmbLiLe1GbBA==
X-Google-Smtp-Source: ABdhPJxkNCGYiyg/4aUWYJPOKZmu+Kbe/kZ0kpam84R+oPmk0V5j7QgYtxvkGsNH/41BKxviprcazg==
X-Received: by 2002:a63:a54a:: with SMTP id r10mr7884807pgu.5.1599235810854;
 Fri, 04 Sep 2020 09:10:10 -0700 (PDT)
Received: from localhost.localdomain ([115.96.104.177])
 by smtp.googlemail.com with ESMTPSA id u62sm7252607pfb.4.2020.09.04.09.10.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Sep 2020 09:10:09 -0700 (PDT)
From: Ani Sinha <ani@anisinha.ca>
To: qemu-devel@nongnu.org
Subject: [PATCH v3] i440fx/acpi: do not add hotplug related amls for cold
 plugged bridges
Date: Fri,  4 Sep 2020 21:40:00 +0530
Message-Id: <20200904161000.12115-1-ani@anisinha.ca>
X-Mailer: git-send-email 2.17.1
Received-SPF: none client-ip=2607:f8b0:4864:20::443;
 envelope-from=ani@anisinha.ca; helo=mail-pf1-x443.google.com
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
 Paolo Bonzini <pbonzini@redhat.com>, Ani Sinha <ani@anisinha.ca>,
 Igor Mammedov <imammedo@redhat.com>, Richard Henderson <rth@twiddle.net>
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

While at it, I have also updated a stale comment.

This change is tested with a Windows 2012R2 guest image and Windows 2019 server
guest image running on Ubuntu 18.04 host. This change is based off of upstream
qemu master branch tag v5.1.0.

Signed-off-by: Ani Sinha <ani@anisinha.ca>
---
 hw/i386/acpi-build.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

changelog:
v3: commit log updates providing more accurate information as received from Julia.
v2: cosmetic commit log updates with patch testing information.
v1: initial patch.


diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
index b7bcbbbb2a..90b863f4ec 100644
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



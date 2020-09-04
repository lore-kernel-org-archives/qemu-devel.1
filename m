Return-Path: <SRS0=8bV5=CN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F2DAC433E2
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2020 08:27:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4C283206C9
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2020 08:27:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=anisinha-ca.20150623.gappssmtp.com header.i=@anisinha-ca.20150623.gappssmtp.com header.b="WJgjmqiq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C283206C9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=anisinha.ca
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43786 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kE745-0004di-FE
	for qemu-devel@archiver.kernel.org; Fri, 04 Sep 2020 04:27:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48284)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ani@anisinha.ca>) id 1kE72F-0002La-9q
 for qemu-devel@nongnu.org; Fri, 04 Sep 2020 04:25:27 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434]:44571)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ani@anisinha.ca>) id 1kE72A-00041l-TF
 for qemu-devel@nongnu.org; Fri, 04 Sep 2020 04:25:26 -0400
Received: by mail-pf1-x434.google.com with SMTP id o20so4193484pfp.11
 for <qemu-devel@nongnu.org>; Fri, 04 Sep 2020 01:25:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=anisinha-ca.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=l6H9TdFBTaIJQuOiKqxbPbEeHp6Rmtm1RlfMmkyZP3k=;
 b=WJgjmqiq79iO9fh/QC0LEKE5DgkUFnlfejPHbY8gneyD+9fAmSLNI9OitxzOH77522
 IEEHg3c+N5zDwwiAIBgt2FLBTbDhejj6AJpMHX96fMr6fiXf6tD9VB03w0CvtdfdivQ+
 sNXYR9+GKINb1NedHiJ2IpDlbAKAYFC6ji0twnVwUF0nBJVaT2Agfv7deGZP9EODR9wo
 tGsma8E0+IkqWeNQwsMW1r20u/baG/uTqgXnopdtQra+K7eTJCXWN7yFoBa7aytcf5sv
 dVmEMqiFPKcfe2bVP5Ma8XTOeRz41BuGo6ydfBK9lKG3WVdLtDMl5NYu856BwZMzh2hB
 0B9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=l6H9TdFBTaIJQuOiKqxbPbEeHp6Rmtm1RlfMmkyZP3k=;
 b=buUET6TfZLSOc85a4nubJkHi9U4axEJ3rhmGESu9UZZ3nEzRCAc9N6NbSMKPOBOEoU
 rPV3MSguEGso6xOrMAlxx0gE1We81306fgzgKQLBxFBgcd/hPkL0GUNI7NnRTvKXiRc4
 g91o11cnQq4akRYJXCJQR9N3ySDFkXUZvOzI1Ae7y6/XiHVaYQTr2ZFr5dwbDtOrjxE3
 X45aWaShMFDjyE9K946zH143Qbak2xPLXHAqDwW0jIO6+s0L03RXIYQ9M8N3kAGTeSiq
 zY25w4vRF9442dWd0PAxsi3TFcGP5LDo24cs1saZDeAF52jH3jHcs4C8L3DM6T9kX4Yt
 SgrQ==
X-Gm-Message-State: AOAM531Wch4XDfXoqsopZxuqwl3kWKuCCtkvEBE4Yq7CbzOVpGvpFRgb
 zz5QYCQggyrwB6Yf+xWCEgL1ei3knZXwyw==
X-Google-Smtp-Source: ABdhPJwam5Dw2ypF7pPlIkt9TG+MN4L5e9Ug8Qu6ClOxkZd3erY9ViHbcv6wWFR8RrLcRTgXvij3vA==
X-Received: by 2002:a63:5ec6:: with SMTP id s189mr6383974pgb.40.1599207920760; 
 Fri, 04 Sep 2020 01:25:20 -0700 (PDT)
Received: from localhost.localdomain ([115.96.135.14])
 by smtp.googlemail.com with ESMTPSA id bj2sm4733098pjb.20.2020.09.04.01.25.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Sep 2020 01:25:20 -0700 (PDT)
From: Ani Sinha <ani@anisinha.ca>
To: qemu-devel@nongnu.org
Subject: [PATCH v1] i440fx/acpi: don't hot-unplug cold plugged bridges when
 their hotplug switch is off
Date: Fri,  4 Sep 2020 13:54:51 +0530
Message-Id: <20200904082451.1043-2-ani@anisinha.ca>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200904082451.1043-1-ani@anisinha.ca>
References: <20200904082451.1043-1-ani@anisinha.ca>
Received-SPF: none client-ip=2607:f8b0:4864:20::434;
 envelope-from=ani@anisinha.ca; helo=mail-pf1-x434.google.com
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

Cold plugged bridges should not be hot unpluggable, even when their hotplug property
(acpi-pci-hotplug-with-bridge-support) is turned off. However, with the current
implementaton, windows would try to hot-unplug a pci bridge when it's hotplug switch
is off. This is regardless of whether there are devices attached to the bridge. When
devices are attached to the bridge, the bridge is ultimately not hot-unpluggable. We
have a demo video here: https://youtu.be/pME2sjyQweo

In this fix, we identify a cold plugged bridge and for cold plugged bridges, we do not
add the appropriate amls and acpi methods that are used by the OS to identify a hot-
unpluggable pci device. After this change, Windows does not show an option to eject the
PCI bridge. A demo video is here:  https://youtu.be/kbgej5B9Hgs

While at it, I have also updated a stale comment.

This change is tested with a Windows 2012R2 guest image running on Ubuntu host. This
change is based off of upstream qemu master branch tag v5.1.0.

Signed-off-by: Ani Sinha <ani@anisinha.ca>
---
 hw/i386/acpi-build.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

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



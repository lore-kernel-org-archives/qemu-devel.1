Return-Path: <SRS0=9x1+=D5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A273C388F7
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2020 12:11:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C4679221FB
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2020 12:11:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IJnOPNT6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4679221FB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58272 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVZRL-000561-O9
	for qemu-devel@archiver.kernel.org; Thu, 22 Oct 2020 08:11:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38936)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcel.apfelbaum@gmail.com>)
 id 1kVYxN-0003yd-KX
 for qemu-devel@nongnu.org; Thu, 22 Oct 2020 07:40:33 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:50872)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcel.apfelbaum@gmail.com>)
 id 1kVYxL-0006KD-Le
 for qemu-devel@nongnu.org; Thu, 22 Oct 2020 07:40:33 -0400
Received: by mail-wm1-x344.google.com with SMTP id 13so1705037wmf.0
 for <qemu-devel@nongnu.org>; Thu, 22 Oct 2020 04:40:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id;
 bh=7vlc1q9nKe/z3Et5stKE6k9iGpG1kYAK5TMYr8yFI6U=;
 b=IJnOPNT6M9aESXlBIBLH8wF8A+a3pVAibF5prpKZOGInmHySsj6Ljhc5zCzxfNd2kM
 gXmNnMSALUNqn7D1fWw72aZ4oOos/7yFufGBDWpYEs/HtQ8w1bjwiB2R09jYE8Urhles
 QDYZzOcfHLbKPrpyW7TRJPX+5YDJBk0lvosZztgUqqon+PCFrKqt4Lnhdmr3ggHZxupb
 4pxXyGny/ZnnuXBpxVumt06HvyUU+7mpevH9RNr8OAH+pgk1B4GxmHdkbem8T29Da5mn
 fvs/3MVGd22kVlGexR4Bk8kBNGVjTjmbRgosFU5DjZUiN9MNzziU24vZmNm3wPsl4KOA
 +PCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=7vlc1q9nKe/z3Et5stKE6k9iGpG1kYAK5TMYr8yFI6U=;
 b=pvb8Cnc6iqGX6gR1pt2gq5bPiKcu/xY/1dsI8R8wgca7HmEq80tK+lgwjjR6WRcbqO
 gO3Ii6cUYyDJggBJuS83aepJN2v8aGxdZWWCSh2+4SQunWkwletiMFnMv09HrASRM+IS
 +18aFZF6D+6v/VaLcrEH0mxtUuqPbt2rchWAHZ3VD8awz2zQIsbYZNehxWyhx7hMvNZb
 MdEPwNAKbLgKO9s9JU0rvOjr62iAzGD6YUAcvyOKfDssh3O3CtcBUvPmhJRbZNEYicA6
 wQgDQW9Df//iGHQonmy/t/VaQx+8KCk3Me5t1FXTrxQ1i4R0FKEiEekyHamQY2gE8+V9
 hNpQ==
X-Gm-Message-State: AOAM530UrV1P4W5cfj7u0lf19y2+c9NCGvn/sX4ud3PD1O8n4ka8/Ou1
 6A5rghpTrvWQDgn44u3axOQKyrLypG0oOA==
X-Google-Smtp-Source: ABdhPJxVIv8in8tXnH+ulc6zBKfVKk0GJK//JL4+VYtWEENNzdZhz9eafJ+8Vxt9D83ztRDh67Vfbg==
X-Received: by 2002:a1c:6289:: with SMTP id w131mr2054880wmb.109.1603366829553; 
 Thu, 22 Oct 2020 04:40:29 -0700 (PDT)
Received: from localhost.localdomain ([77.138.162.106])
 by smtp.gmail.com with ESMTPSA id 10sm3574622wmn.9.2020.10.22.04.40.28
 (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 22 Oct 2020 04:40:28 -0700 (PDT)
From: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
To: qemu-devel@nongnu.org,
	mst@redhat.com
Subject: [PATCH] pci: Refuse to hotplug PCI Devices when the Guest OS is not
 ready
Date: Thu, 22 Oct 2020 14:40:26 +0300
Message-Id: <20201022114026.31968-1-marcel.apfelbaum@gmail.com>
X-Mailer: git-send-email 2.17.2
Received-SPF: pass client-ip=2a00:1450:4864:20::344;
 envelope-from=marcel.apfelbaum@gmail.com; helo=mail-wm1-x344.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: dgibson@redhat.com, jusual@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Marcel Apfelbaum <marcel@redhat.com>

During PCIe Root Port's transition from Power-Off to Power-ON (or vice-versa)
the "Slot Control Register" has the "Power Indicator Control"
set to "Blinking" expressing a "power transition" mode.

Any hotplug operation during the "power transition" mode is not permitted
or at least not expected by the Guest OS leading to strange failures.

Detect and refuse hotplug operations in such case.

Signed-off-by: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
---
 hw/pci/pcie.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/hw/pci/pcie.c b/hw/pci/pcie.c
index 5b48bae0f6..2fe5c1473f 100644
--- a/hw/pci/pcie.c
+++ b/hw/pci/pcie.c
@@ -410,6 +410,7 @@ void pcie_cap_slot_pre_plug_cb(HotplugHandler *hotplug_dev, DeviceState *dev,
     PCIDevice *hotplug_pdev = PCI_DEVICE(hotplug_dev);
     uint8_t *exp_cap = hotplug_pdev->config + hotplug_pdev->exp.exp_cap;
     uint32_t sltcap = pci_get_word(exp_cap + PCI_EXP_SLTCAP);
+    uint32_t sltctl = pci_get_word(exp_cap + PCI_EXP_SLTCTL);
 
     /* Check if hot-plug is disabled on the slot */
     if (dev->hotplugged && (sltcap & PCI_EXP_SLTCAP_HPC) == 0) {
@@ -418,6 +419,12 @@ void pcie_cap_slot_pre_plug_cb(HotplugHandler *hotplug_dev, DeviceState *dev,
         return;
     }
 
+    if ((sltctl & PCI_EXP_SLTCTL_PIC) == PCI_EXP_SLTCTL_PWR_IND_BLINK) {
+        error_setg(errp, "Hot-plug failed: %s is in Power Transition",
+                   DEVICE(hotplug_pdev)->id);
+        return;
+    }
+
     pcie_cap_slot_plug_common(PCI_DEVICE(hotplug_dev), dev, errp);
 }
 
-- 
2.17.2



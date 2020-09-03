Return-Path: <SRS0=d88l=CM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AC2AC2D0A8
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 10:35:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A314D20767
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 10:26:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=anisinha-ca.20150623.gappssmtp.com header.i=@anisinha-ca.20150623.gappssmtp.com header.b="huAnSH0+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A314D20767
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=anisinha.ca
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45644 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDmS4-0003t2-DY
	for qemu-devel@archiver.kernel.org; Thu, 03 Sep 2020 06:26:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51988)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ani@anisinha.ca>) id 1kDmRH-0003Qk-8B
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 06:25:55 -0400
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:38780)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ani@anisinha.ca>) id 1kDmRF-00083s-48
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 06:25:54 -0400
Received: by mail-pg1-x541.google.com with SMTP id l191so1777125pgd.5
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2020 03:25:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=anisinha-ca.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id;
 bh=YnsNWtu0nepE+lEXhJdiEE3Z99bu9PuFdPGKjbxGeW0=;
 b=huAnSH0+SV8FrvO9qWXoQbtkoBxUw2aTnoeUrTN5VPkPjzI5f9LuffSHZw2V7uAEW1
 gep6uOviKozUYdiKh5BbKMygOEclHd4kjkcJelelGoNMowmyNxIWbAfJRepUf0kS/MI6
 10L1jwbh/caIi/XpliawQaTzz7iplP8w4qQBrhiOpuOgYuxS+tdAPWv4U16xdOG9RE/A
 +mvj+ZErIr3pZ3NKU2s2WokJGWY7CBhv76VhPEuzXwcimEeEo4+AlW7XNj2lo0D8Etr6
 hWW43NGR8tNAYXJADqqIBhh418dtpbyD1a1ITCuNRo5s9YI7m3DMne17f5Sbh8qxhXtt
 kdLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=YnsNWtu0nepE+lEXhJdiEE3Z99bu9PuFdPGKjbxGeW0=;
 b=LK0iyySSdOp+XDXAQDAhH3qApvMwjB5sFaBdJj4nGlRebjmLxnA3kAoeu85+Im7md8
 mxVbuypLD5ljagZ15lvrnkok4lrawy2t73zhpeebBZNXJ8DY+JpBzZ8iiyEcSCES5+kJ
 QxCaya/nogJre8iUCk9Ll8MYYxbrXcLgGFoJ8kq2SgwAKddhfwISpNN+/eB1fXOmD024
 wrcmFKls5IHCHiyew/ybzkRamT8OGVem+7UDb3JI9oV9DO3xDotOM23wRnoSgDri2IMc
 OxL/4j8PXb7DJWhCKGK5PckKS+MWr1ejMiqtm6eEdgoZT7vNFOnkIM3l2Nuozb7zO93J
 b/5g==
X-Gm-Message-State: AOAM532nJhTi121ApsNbRkY2runz1DdVKsodYf4Wtv2UbJZazjJhdF+c
 EB4eJLOdFTZfWLjeplz/lgnZSB6CSv+7yw==
X-Google-Smtp-Source: ABdhPJzCmTglR1NsaL5J9SrU7xFOHLO19/yhl9rwzifit1ZhXPJS1AQkNXhOigWPAjb8OyYy5EwCdA==
X-Received: by 2002:a63:342:: with SMTP id 63mr2476209pgd.134.1599128750564;
 Thu, 03 Sep 2020 03:25:50 -0700 (PDT)
Received: from localhost.localdomain
 ([2401:4900:1044:6101:9952:7fd9:d8b6:3315])
 by smtp.googlemail.com with ESMTPSA id w10sm2099701pjq.46.2020.09.03.03.25.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Sep 2020 03:25:49 -0700 (PDT)
From: Ani Sinha <ani@anisinha.ca>
To: qemu-devel@nongnu.org
Subject: [PATCH v2] Fix a gap where acpi_pcihp_find_hotplug_bus() returns a
 non-hotpluggable bus
Date: Thu,  3 Sep 2020 15:55:30 +0530
Message-Id: <20200903102530.16846-1-ani@anisinha.ca>
X-Mailer: git-send-email 2.17.1
Received-SPF: none client-ip=2607:f8b0:4864:20::541;
 envelope-from=ani@anisinha.ca; helo=mail-pg1-x541.google.com
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
Cc: Ani Sinha <ani@anisinha.ca>, Igor Mammedov <imammedo@redhat.com>,
 jusual@redhat.com, "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

When ACPI hotplug for the root bus is disabled, the bsel property for that
bus is not set. Please see the following commit:

3d7e78aa7777f ("Introduce a new flag for i440fx to disable PCI hotplug on the root bus").

As a result, when acpi_pcihp_find_hotplug_bus() is called
with bsel set to 0, it may return the root bus. This can cause devices attached to
the root bus to get hot-unplugged if the user issues the following set of commmands:

outl 0xae10 0
outl 0xae08 your_slot

Thanks to Julia for pointing this out here:
https://www.mail-archive.com/qemu-devel@nongnu.org/msg734548.html

In this patch, we fix the issue in this function by checking if the bus which is
returned by the function is actually hotpluggable. If not, we simply return NULL.
This avoids the scenario where we were returning a non-hotpluggable bus.

Signed-off-by: Ani Sinha <ani@anisinha.ca>
---
 hw/acpi/pcihp.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/hw/acpi/pcihp.c b/hw/acpi/pcihp.c
index 39b1f74442..f148e73c89 100644
--- a/hw/acpi/pcihp.c
+++ b/hw/acpi/pcihp.c
@@ -147,6 +147,21 @@ static PCIBus *acpi_pcihp_find_hotplug_bus(AcpiPciHpState *s, int bsel)
     if (!bsel && !find.bus) {
         find.bus = s->root;
     }
+
+    /*
+     * Check if find.bus is actually hotpluggable. If bsel is set to
+     * NULL for example on the root bus in order to make it
+     * non-hotpluggable, find.bus will match the root bus when bsel
+     * is 0. See acpi_pcihp_test_hotplug_bus() above. Since the
+     * bus is not hotpluggable however, we should not select the bus.
+     * Instead, we should set find.bus to NULL in that case. In the check
+     * below, we generalize this case for all buses, not just the root bus.
+     * The callers of this function check for a null return value and
+     * handle them appropriately.
+     */
+    if (!qbus_is_hotpluggable(BUS(find.bus))) {
+        find.bus = NULL;
+    }
     return find.bus;
 }
 
-- 
2.17.1



Return-Path: <SRS0=OYoK=CH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBD68C433E2
	for <qemu-devel@archiver.kernel.org>; Sat, 29 Aug 2020 08:13:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ABE672076D
	for <qemu-devel@archiver.kernel.org>; Sat, 29 Aug 2020 08:13:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=anisinha-ca.20150623.gappssmtp.com header.i=@anisinha-ca.20150623.gappssmtp.com header.b="N/MHV2I+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ABE672076D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=anisinha.ca
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46670 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBvzM-0006iu-UK
	for qemu-devel@archiver.kernel.org; Sat, 29 Aug 2020 04:13:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36016)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ani@anisinha.ca>) id 1kBvyq-0006Jd-PQ
 for qemu-devel@nongnu.org; Sat, 29 Aug 2020 04:12:56 -0400
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644]:43903)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ani@anisinha.ca>) id 1kBvyo-0001Fi-T3
 for qemu-devel@nongnu.org; Sat, 29 Aug 2020 04:12:56 -0400
Received: by mail-pl1-x644.google.com with SMTP id y6so727324plk.10
 for <qemu-devel@nongnu.org>; Sat, 29 Aug 2020 01:12:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=anisinha-ca.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id;
 bh=pa/nGmYArA+W8XID/Wfow4kMcHrkgEAEcyP129IRBCU=;
 b=N/MHV2I+SgM+88F0+8FoGf1zKRcEdg2Gouf176q4UnyZaof/Yhvb+8qykAYOORpE98
 aH5yQQWsKWF5kx70ull6+Tpcmo2XNECl9W2HyKgb8pSwB2LovHlilQyP5jUWs2XepRHd
 q2WtkwALQJiXcy4lWMRBWlgqQO+0HTK9bvTUjY4MNavfllwbWozIxqGPZdiJeKfZLZpi
 dQ34HBlrkHCAt5C3xFEBYtX3TW629KDi6i2w2C5yo3hlKupRI3v0LAUd0HOT5L3EX+Cz
 SqH2rYIH/DD6FNSk31T4RaFPq4EwXAMsOXxVcocb6wRCU33hS0apZNywdrFvnMRMnX+D
 RrQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=pa/nGmYArA+W8XID/Wfow4kMcHrkgEAEcyP129IRBCU=;
 b=jtNElKNHy+U2Fdea46cc0l5GaYjvwaJh4F+NMsLGjlxenBQwfKVBbUu0NFx5/e30X2
 uVbCSoR06ggm/AlJ1UwifT7zrY/npHFXsJcOYtnQm9RTVx6HRaRKiAWntoBoz4riIZeI
 vy9yDdcOyXRKNGLlNdnWztSmybuRXNz2KZmOCFKg6eESPFv00o/uJ/YoVY14LSJzOXWn
 OUw1oaz8KM2WWdCf9ZrAEieJvTHOAWg87ritgJ+xH1LHrSCrQl/R189appIxNTvFX8up
 5zsUnkEo8fpyX93HaFbKhqmlmZUsN4d8Us+bEuaTPyyrEzCr3cBAIe2b6TLxgZRDzalE
 n3RQ==
X-Gm-Message-State: AOAM5302fLDEXE/iW32xl+ddTjuX/xkt0bU4ckafoSAZwEwWBvOf30DO
 WNJVcKLMCvqsSG6fwIzzASmuLtLwVVTW6Q==
X-Google-Smtp-Source: ABdhPJyZ+PXhtYOLozMB8rtERnvhAn7W8fMaq8kYNxhojHNvfhjFo6j6fg2Z7yjnfAs8j6bfQw0+XQ==
X-Received: by 2002:a17:90a:9418:: with SMTP id
 r24mr2267558pjo.69.1598688772359; 
 Sat, 29 Aug 2020 01:12:52 -0700 (PDT)
Received: from localhost.localdomain ([203.163.239.118])
 by smtp.googlemail.com with ESMTPSA id l1sm1820627pfc.164.2020.08.29.01.12.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 29 Aug 2020 01:12:51 -0700 (PDT)
From: Ani Sinha <ani@anisinha.ca>
To: qemu-devel@nongnu.org
Subject: [PATCH] Fix a gap where acpi_pcihp_find_hotplug_bus() returns a
 non-hotpluggable bus
Date: Sat, 29 Aug 2020 13:42:33 +0530
Message-Id: <20200829081233.10120-1-ani@anisinha.ca>
X-Mailer: git-send-email 2.17.1
Received-SPF: none client-ip=2607:f8b0:4864:20::644;
 envelope-from=ani@anisinha.ca; helo=mail-pl1-x644.google.com
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
with bsel set to 0, it may return the root bus. This would be wrong since the
root bus is not hotpluggable. In general, this can potentially happen to other
buses as well.
In this patch, we fix the issue in this function by checking if the bus returned
by the function is actually hotpluggable. If not, we simply return NULL. This
avoids the scenario where we are actually returning a non-hotpluggable bus.

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



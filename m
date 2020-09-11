Return-Path: <SRS0=/zFi=CU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 798EAC43461
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2020 18:09:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C7E44221F0
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2020 18:09:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=anisinha-ca.20150623.gappssmtp.com header.i=@anisinha-ca.20150623.gappssmtp.com header.b="u3W/o8P1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C7E44221F0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=anisinha.ca
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41272 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kGnUR-0004I1-My
	for qemu-devel@archiver.kernel.org; Fri, 11 Sep 2020 14:09:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53954)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ani@anisinha.ca>) id 1kGnTO-0002dn-46
 for qemu-devel@nongnu.org; Fri, 11 Sep 2020 14:08:34 -0400
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:35368)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ani@anisinha.ca>) id 1kGnTM-0005xW-Ab
 for qemu-devel@nongnu.org; Fri, 11 Sep 2020 14:08:33 -0400
Received: by mail-pg1-x542.google.com with SMTP id g29so7218732pgl.2
 for <qemu-devel@nongnu.org>; Fri, 11 Sep 2020 11:08:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=anisinha-ca.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=Gel2ySMpTt4f7XUoVi2e2wkLqL2QzwXiN3Z4/PyZJos=;
 b=u3W/o8P1eTKmxjWMX2yHNNkkKCgTsIAPquXKWN40MOr4kJXyETU1AvIGx6yL1tTQIo
 7PQHVM4DSV+yD4YnT3FtJFD8oi0aVTtT1HqgEOTDbYk7wIQcnYPpum6jP49j+6prR0p7
 58qBGlkoanNqYPxMPyWRfNotgOePELAryozSTW3DxHT+XZyBYcgS64JUOqoRvfJPlXJ0
 V4qdLZOPj7+GkoZsLr8EWd/wXjas0sClF0CP4TPKQwbvAA0M0tgWwk3BHNn6GPvXM7C5
 ZkGRYl02l1liPjJLFTZp1ZqR0zZWQrmb2B3iU8hnOs2gEGqXhUoz3EkKZkr+w/P4TgHG
 Gp/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=Gel2ySMpTt4f7XUoVi2e2wkLqL2QzwXiN3Z4/PyZJos=;
 b=bFIKmuSyVeitNEfXV68pRp5AY2EgZ68qyovMkWty6PYdCImuBG673TFDQVeg6uai9N
 5WTL/hp4FlWrjhfbt3s2t9B2eUTdIRfA7Z33VjxtHC/ePGuPLoHtJb19R/jK5buYa+fX
 wCxzq7wUkKCUOM9GEQP2N+DusCuuZ1lf/YtrlKfb3hSeXIyv/27SeVcidMkW2WO6DGzN
 +Ritx7dD6OAyZrjQyTEcnPvU/S3xbzGu+nZ2/mCcXbaxOeXSARBQNEaF0T2QWp5Rd84p
 u6noqk6L5w7JJoGzHkC4K/PBpk67e5ltmKkiLrlKCIS7153Ydi2ucqPS01vGqxrfkWpu
 sR5g==
X-Gm-Message-State: AOAM531AH6EaG8bSk+1MSHAvBmMhQ8tVQ0/MXYMVEsphjvXFY96o1Qhm
 /Dqp7dnEiFYo4wab1sx6KXswpID9a3EmEw==
X-Google-Smtp-Source: ABdhPJzqaDNA8P/A6MD5VC5ghPPF+/mEPI40V/fEGPDUFg82QlJsx6XF/bjdefD9CRdsXR8NkIbt+Q==
X-Received: by 2002:a17:902:b10a:: with SMTP id
 q10mr3247096plr.156.1599847710585; 
 Fri, 11 Sep 2020 11:08:30 -0700 (PDT)
Received: from localhost.localdomain ([115.96.135.201])
 by smtp.googlemail.com with ESMTPSA id n9sm2929135pfu.163.2020.09.11.11.08.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Sep 2020 11:08:29 -0700 (PDT)
From: Ani Sinha <ani@anisinha.ca>
To: qemu-devel@nongnu.org
Subject: [PATCH 4/9] Fix a gap where acpi_pcihp_find_hotplug_bus() returns a
 non-hotpluggable bus
Date: Fri, 11 Sep 2020 23:37:50 +0530
Message-Id: <20200911180755.28409-4-ani@anisinha.ca>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200911180755.28409-1-ani@anisinha.ca>
References: <20200911180755.28409-1-ani@anisinha.ca>
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

This patch is based off of tag v5.10

Signed-off-by: Ani Sinha <ani@anisinha.ca>
---
 hw/acpi/pcihp.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/hw/acpi/pcihp.c b/hw/acpi/pcihp.c
index 39b1f74442..32ae8b2c0a 100644
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
+    if (find.bus && !qbus_is_hotpluggable(BUS(find.bus))) {
+        find.bus = NULL;
+    }
     return find.bus;
 }
 
-- 
2.17.1



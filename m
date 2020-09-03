Return-Path: <SRS0=d88l=CM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CC93C433E9
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 14:44:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 71A7E206EF
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 14:44:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=anisinha-ca.20150623.gappssmtp.com header.i=@anisinha-ca.20150623.gappssmtp.com header.b="QTvTvRTU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 71A7E206EF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=anisinha.ca
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55292 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDqT7-0005gz-5m
	for qemu-devel@archiver.kernel.org; Thu, 03 Sep 2020 10:44:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36680)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ani@anisinha.ca>) id 1kDqSF-0005Cp-Js
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 10:43:11 -0400
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:45581)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ani@anisinha.ca>) id 1kDqSD-0001Qi-LR
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 10:43:11 -0400
Received: by mail-pg1-x544.google.com with SMTP id 67so2294133pgd.12
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2020 07:43:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=anisinha-ca.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id;
 bh=tEAwouppKcqLoUUt/zy+obwBHv3Stl5Siq36velS/qU=;
 b=QTvTvRTUYZIfA5H5sXYEejaZLytUJtROMKBHanqC7snMT5OWivkG25Yt5br50kgF4X
 +TcKDrzAZ3I7/MWk4pBYFZBwtwdMTfS1m8jcqrl8N0G8Fz28vWeHtB4GH1+3z25qs63J
 oT4Csj3shQR71lhYfdfLu0641iO5EzxD2ufCUdV2Z8UHKrZz5Si7AUFdUIESf9xpqo8B
 0IqiOnUzdtTHH87B1W3Mpv1lawmTltL/6l66B02SCG+3Teo78QFXeDAzKPCFu0jmLmpF
 5McaU5ULYv1Ug8DHAvDJiwT7yNcT4wM/mcCZ+VWNQg9anbc55VrxJWTJjS5Y2qrNznro
 HMJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=tEAwouppKcqLoUUt/zy+obwBHv3Stl5Siq36velS/qU=;
 b=VqnmD2ioQBqBHOPZZyo3wAqJy6bWjqxeMkVZtT6YdTmQgSaPLHiQgKofNS6IYrrfk9
 MRxntod1VjitZINS5FJpYWYG99iPu20gx6YIcU8tjRTweyoQdGqBq7KZ4274+AXGoUcG
 nysGSFvHzUKqA41IbXRVZSue8hM46v27Qoaw+uABKrRv2bdwM++BTocU/sp3GAY/iNE/
 GF22Rk1OewTlpTdYHqwycsyMu1ura4+Rq0NW9GD2kiwK2fHfdJk6Qw0lW5ybx7/lRArp
 pq2hLawUONumkZXwYopvwYty/Ma6NMr+LzcN+hRTWtknHWVBheLMWXigroqszIH/G/kT
 mepQ==
X-Gm-Message-State: AOAM5309nVCpDSu2ozOxSf1daxsm7BInD5hqrC4Iwagcy0Fts+zg4qso
 6Wlp2g80W8budigyvkRzC/q4zbcVOtFv4Q==
X-Google-Smtp-Source: ABdhPJxc/cn3KUzc2rpGZaTE+Jbyt9hxj6mX3HlH9yIWAgp1x4y6+hmoG0ECxLnhdGI4vO7POZWZaw==
X-Received: by 2002:aa7:9910:: with SMTP id z16mr4169032pff.120.1599144186948; 
 Thu, 03 Sep 2020 07:43:06 -0700 (PDT)
Received: from localhost.localdomain ([115.96.154.91])
 by smtp.googlemail.com with ESMTPSA id
 g206sm3565593pfb.178.2020.09.03.07.43.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Sep 2020 07:43:06 -0700 (PDT)
From: Ani Sinha <ani@anisinha.ca>
To: qemu-devel@nongnu.org
Subject: [PATCH v3] Fix a gap where acpi_pcihp_find_hotplug_bus() returns a
 non-hotpluggable bus
Date: Thu,  3 Sep 2020 20:12:48 +0530
Message-Id: <20200903144248.3790-1-ani@anisinha.ca>
X-Mailer: git-send-email 2.17.1
Received-SPF: none client-ip=2607:f8b0:4864:20::544;
 envelope-from=ani@anisinha.ca; helo=mail-pg1-x544.google.com
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
the root bus to get hot-unplugged if the user issues the following set of commands:

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

Changelog:
v3: fix a bug where we were dereferencing null pointer when find.bus was null.
v2: update commit log to include more details.


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



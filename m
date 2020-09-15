Return-Path: <SRS0=sZ46=CY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9262C43461
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 15:44:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3E48C208E4
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 15:44:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=anisinha-ca.20150623.gappssmtp.com header.i=@anisinha-ca.20150623.gappssmtp.com header.b="h0gIHu59"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E48C208E4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=anisinha.ca
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35380 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kID8R-000426-1y
	for qemu-devel@archiver.kernel.org; Tue, 15 Sep 2020 11:44:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48740)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ani@anisinha.ca>) id 1kID2h-0004BE-8s
 for qemu-devel@nongnu.org; Tue, 15 Sep 2020 11:38:51 -0400
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:43299)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ani@anisinha.ca>) id 1kID2f-0004Z0-Cl
 for qemu-devel@nongnu.org; Tue, 15 Sep 2020 11:38:50 -0400
Received: by mail-pf1-x443.google.com with SMTP id f18so2138635pfa.10
 for <qemu-devel@nongnu.org>; Tue, 15 Sep 2020 08:38:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=anisinha-ca.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=Gel2ySMpTt4f7XUoVi2e2wkLqL2QzwXiN3Z4/PyZJos=;
 b=h0gIHu59PjCkxjJJ6mB2oDg4VMhSxyMo2sbUP8cjTPwDxjnFDRx2pAOsHhSMEmgIAw
 +hJRC6mMBWSQHoI0yTWo3o2+oT5rsYkkl1eHmeb3md1sj8MWtQ45PUvhbPk7WeTnKEg8
 xUjalddJMUMTMv7tpriCdtdBBVShTBPTykxkYoOU4Yg4KO+5qDJTNAZQNJJirLFCOU/B
 qqVuJkgd1m/4gv62rDqnPrLVzR/h3juLhzFCToK/1Ano+n5bVpQiPnGIlyNG1GyXkIr8
 KgXBHa3aqYeRD6ZmpUr6j/vKetxDnyHd7ngWPdSzXHXcviKtaD+Uaug/lMT0vTXaJhkz
 CttQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=Gel2ySMpTt4f7XUoVi2e2wkLqL2QzwXiN3Z4/PyZJos=;
 b=bNL1xzG6v1lA+loa2C+r6hV2RQnzGAFuglf3gjAzQMwEwHJpGXBaT7JjbsTWrFyV7w
 ikIoPoWsarW7L/nmGIxlsgpXtD7xx3DaRIzNPGocPCgvhWAgLbhmhJZk0L45C9JShGTx
 OMQgWpkyDvp/Dy0dr5YAhKB/lazUdOlom5ErWLvWx2vjJgSc21oq2bCKpvr/+V1tYol7
 BXNkLxsl2eGvEXXET7kxaLUqrxEYCq9l9FRHBk3poujme8fg1136y81XXy10ZyDoddhJ
 j0TAx8G3muulPtnclyoogYqBSCvVtkMnEGX/1PvoIpbYvYJlTjHB2vrK+ICBy8ZMtppt
 INLg==
X-Gm-Message-State: AOAM530D+hU28inmLrV9tlAbuFwqVThPWcWnNT0hnw23+l0ot1oKbK3A
 6cWB4+3HGC6Un7w6d6pBdgxfC4a3KeYbLyeG
X-Google-Smtp-Source: ABdhPJxpYclKd8Uw3xLLmh8g4Urc8XgZiOzszycOl6z1gI3S2Y+I0M/zSo5tJqWhCO19is6o/N9UuQ==
X-Received: by 2002:aa7:8c09:0:b029:142:2501:3983 with SMTP id
 c9-20020aa78c090000b029014225013983mr2304467pfd.72.1600184327775; 
 Tue, 15 Sep 2020 08:38:47 -0700 (PDT)
Received: from localhost.localdomain ([115.96.130.76])
 by smtp.googlemail.com with ESMTPSA id 194sm13283547pfy.44.2020.09.15.08.38.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Sep 2020 08:38:46 -0700 (PDT)
From: Ani Sinha <ani@anisinha.ca>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 4/9] Fix a gap where acpi_pcihp_find_hotplug_bus() returns
 a non-hotpluggable bus
Date: Tue, 15 Sep 2020 21:08:13 +0530
Message-Id: <20200915153818.13020-5-ani@anisinha.ca>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200915153818.13020-1-ani@anisinha.ca>
References: <20200915153818.13020-1-ani@anisinha.ca>
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
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Ani Sinha <ani@anisinha.ca>,
 Igor Mammedov <imammedo@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>,
 Richard Henderson <rth@twiddle.net>
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



Return-Path: <SRS0=sZ46=CY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B231C433E2
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 15:40:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 93955206B2
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 15:40:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=anisinha-ca.20150623.gappssmtp.com header.i=@anisinha-ca.20150623.gappssmtp.com header.b="Bo5Bldeo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 93955206B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=anisinha.ca
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49496 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kID4G-0006PV-8f
	for qemu-devel@archiver.kernel.org; Tue, 15 Sep 2020 11:40:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48810)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ani@anisinha.ca>) id 1kID2v-0004ef-UI
 for qemu-devel@nongnu.org; Tue, 15 Sep 2020 11:39:05 -0400
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643]:35818)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ani@anisinha.ca>) id 1kID2u-0004ab-30
 for qemu-devel@nongnu.org; Tue, 15 Sep 2020 11:39:05 -0400
Received: by mail-pl1-x643.google.com with SMTP id bg9so1542808plb.2
 for <qemu-devel@nongnu.org>; Tue, 15 Sep 2020 08:39:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=anisinha-ca.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=1HJAcNNwPJS7p1FkxDsM+O9s3xr3SqwAfIoNSM2l/6c=;
 b=Bo5BldeofZNFTkhib8Ix36bXR5ZGImWy7Kvgoc+YxmbYZnbp9POTK4yyMKKAkAKYhZ
 HOQoC8IgQdISfMWT1cMKg3lxpuql7xRCJRjwStMDomeFFUsAIOvHQJelwglc++iDWkln
 cPtRmnFYqQjKtUvoAA0aX5mCCHgCBierHQ0o9DaGiNNOFU3Bf8fVCsl6KB1ehrErMlFr
 aQ9ghUPnZN1aeW1Kbz5aErYkRD96aY2XSB+gnujR/duT9A527uDh5/yWhqamRNrGhyGE
 zyekAwEsSV9laT1prkwehXSIz0vtVFwaC37TX/Di1boxUgjRe8Vjg3oKkxEknn6U6Vel
 E56A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=1HJAcNNwPJS7p1FkxDsM+O9s3xr3SqwAfIoNSM2l/6c=;
 b=YfnY20k4oV64yqG+QCZ/vxLimVzW+q19YKnniBJ5ZMRUgDKIFSGbxXWzK348qwHHJi
 j/TtDFje/ph8OpiDyq4jNETHftQz+s1L9nkY0uZSml2jj2fLTu54+Xqtp+qyJUniW9MF
 YTiYwNpeFdUcI/TWXlxnDPjzS/ykyJAbzk0RrOiIGvzUE3+pAyEUc5/NN0jPcGr+Y5FZ
 BW8yXfXhLi1TLAWrxFzoHPVN/Ty67nLcPYj7ExDs+oDXFOLspxb1flbC9aXBh1UkO+XZ
 UvuYRAA6/ZeqmheXOaw2Y/qwvagP6EuNzXs9wiuMrwhcQRo3Zbm7jnrnF3bmoSqk74jG
 2jvw==
X-Gm-Message-State: AOAM532ThLv7f5UuzPbZ+7WQp/+LG65BdDlxqT68Tnusz1YRqbn0yrWk
 OCkCDOtzntK4wFKQ1wUFlZjeuk0kbERZoZLe
X-Google-Smtp-Source: ABdhPJz1vekarnUew3B8cE7ywOW7/j0BdmyF8/lCJqo8JI67spFRbQ73snacrVJlLyKBVZoQokGJFQ==
X-Received: by 2002:a17:902:34f:b029:d1:e5e7:bdcf with SMTP id
 73-20020a170902034fb02900d1e5e7bdcfmr2351590pld.47.1600184342378; 
 Tue, 15 Sep 2020 08:39:02 -0700 (PDT)
Received: from localhost.localdomain ([115.96.130.76])
 by smtp.googlemail.com with ESMTPSA id 194sm13283547pfy.44.2020.09.15.08.38.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Sep 2020 08:39:01 -0700 (PDT)
From: Ani Sinha <ani@anisinha.ca>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 7/9] tests/acpi: unit test for
 'acpi-pci-hotplug-with-bridge-support' bridge flag
Date: Tue, 15 Sep 2020 21:08:16 +0530
Message-Id: <20200915153818.13020-8-ani@anisinha.ca>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200915153818.13020-1-ani@anisinha.ca>
References: <20200915153818.13020-1-ani@anisinha.ca>
Received-SPF: none client-ip=2607:f8b0:4864:20::643;
 envelope-from=ani@anisinha.ca; helo=mail-pl1-x643.google.com
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
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Ani Sinha <ani@anisinha.ca>,
 Igor Mammedov <imammedo@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This change adds a new unit test for the global flag
'acpi-pci-hotplug-with-bridge-support' which is available for cold plugged pci
bridges in i440fx. The flag can be used to turn off acpi based hotplug support
for all pci bridges.

Signed-off-by: Ani Sinha <ani@anisinha.ca>
---
 tests/qtest/bios-tables-test.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/tests/qtest/bios-tables-test.c b/tests/qtest/bios-tables-test.c
index d8c7d57557..7632cfe1be 100644
--- a/tests/qtest/bios-tables-test.c
+++ b/tests/qtest/bios-tables-test.c
@@ -754,6 +754,20 @@ static void test_acpi_piix4_root_hotplug(void)
     free_test_data(&data);
 }
 
+static void test_acpi_piix4_bridge_hotplug(void)
+{
+    test_data data;
+
+    memset(&data, 0, sizeof(data));
+    data.machine = MACHINE_PC;
+    data.variant = ".hpbridge";
+    data.required_struct_types = base_required_struct_types;
+    data.required_struct_types_len = ARRAY_SIZE(base_required_struct_types);
+    test_acpi_one("-global PIIX4_PM.acpi-pci-hotplug-with-bridge-support=off "
+                  "-device pci-bridge,chassis_nr=1", &data);
+    free_test_data(&data);
+}
+
 static void test_acpi_q35_tcg(void)
 {
     test_data data;
@@ -1159,6 +1173,7 @@ int main(int argc, char *argv[])
         qtest_add_func("acpi/piix4", test_acpi_piix4_tcg);
         qtest_add_func("acpi/piix4/bridge", test_acpi_piix4_tcg_bridge);
         qtest_add_func("acpi/piix4/hotplug", test_acpi_piix4_root_hotplug);
+        qtest_add_func("acpi/piix4/brhotplug", test_acpi_piix4_bridge_hotplug);
         qtest_add_func("acpi/q35", test_acpi_q35_tcg);
         qtest_add_func("acpi/q35/bridge", test_acpi_q35_tcg_bridge);
         qtest_add_func("acpi/q35/mmio64", test_acpi_q35_tcg_mmio64);
-- 
2.17.1



Return-Path: <SRS0=e36u=CI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FB12C433E6
	for <qemu-devel@archiver.kernel.org>; Sun, 30 Aug 2020 10:01:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5002E20714
	for <qemu-devel@archiver.kernel.org>; Sun, 30 Aug 2020 10:01:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=anisinha-ca.20150623.gappssmtp.com header.i=@anisinha-ca.20150623.gappssmtp.com header.b="nVKdPiYT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5002E20714
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=anisinha.ca
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33996 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kCK9Q-0006he-HX
	for qemu-devel@archiver.kernel.org; Sun, 30 Aug 2020 06:01:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54978)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ani@anisinha.ca>) id 1kCK7i-0005Mt-AV
 for qemu-devel@nongnu.org; Sun, 30 Aug 2020 05:59:42 -0400
Received: from mail-pj1-x1041.google.com ([2607:f8b0:4864:20::1041]:53271)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ani@anisinha.ca>) id 1kCK7g-00042k-RT
 for qemu-devel@nongnu.org; Sun, 30 Aug 2020 05:59:42 -0400
Received: by mail-pj1-x1041.google.com with SMTP id nv17so1581071pjb.3
 for <qemu-devel@nongnu.org>; Sun, 30 Aug 2020 02:59:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=anisinha-ca.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=IYFD+H+WguAnHrlGrrkimyIKrK+GJMq/0QUuqlX3ECE=;
 b=nVKdPiYTkaM/pvHIyBSfg5P1fkDKILUeimMo8war+Thk25zUq1h578dDVLqQD2qKKz
 f48AnrqMeVb1rHOH2qE/hV4Yz9ibZ87h0VqG2zxlDnZaeO2aR5Wxh05YPCPuYsE7fcSJ
 ZDITj+pZgqnpH6MEaJ1NpsWdQycDS7+NbBKkl53BXfb/89tQTYUWQ1YDDot04KWuldKe
 RdRlhJdw0RmSR2jpWrFtiZSl/OgAsJKZHWdMVL1OLP1kgTrU7zdR5+FBj8ZrtFJAoyQe
 ztCNbBY8ew7krGOU+DMR+0dl91xTEFZKpOxfK5IUGg6lD+RXD6Jtr/1IKg/f6hLovoRr
 nctw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=IYFD+H+WguAnHrlGrrkimyIKrK+GJMq/0QUuqlX3ECE=;
 b=Fsv9k2j8f+HCT2cGlDiCDHZkDEFLhUsWci4RSAaHFuxj72t7kw7V41zsxAVUAfu5wZ
 CJP3jTTBfYtCwoGPUbotR4IiOaioanhU1GKa83Eg1GQfGzpGUSBUgXMsRPP0msS9yLJV
 SQlIDlu4B5BcWZqp+LQJMXUnIvrx9+cQ9DFlobAoo9Ie7K5ziiFL5MPWoSR+h/s0k+Gz
 q/+fA1WBt0RgR480EnPZ+QGMz5vJomW/fHNf2gbDLWVxfEZTufhaQhN+Hoa6e4t187Y7
 0O3Fl2rgGwe/ouBwl4LXReu4o8VE4KL8fs2ErFUzkRAEd0eP7wFD2QT7YZnDfXeZwd3T
 PXQw==
X-Gm-Message-State: AOAM531zozUToXID5e9RbHWI6PzOZVEKYNb/NljbP1xI1xoegmlX/JsS
 bEaOGdCuKKXQePvWLdMdInCcOFl1Af6BRQ==
X-Google-Smtp-Source: ABdhPJzkbykoivyLWrAwfjs7fHc+juZjw4ce5pRbZ/qqOR+11NIdzazI9KhAVHoUpDzO0K7fthzexA==
X-Received: by 2002:a17:902:7b8a:: with SMTP id
 w10mr5011732pll.145.1598781579366; 
 Sun, 30 Aug 2020 02:59:39 -0700 (PDT)
Received: from localhost.localdomain ([115.96.143.103])
 by smtp.googlemail.com with ESMTPSA id c143sm4773722pfb.84.2020.08.30.02.59.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 30 Aug 2020 02:59:38 -0700 (PDT)
From: Ani Sinha <ani@anisinha.ca>
To: qemu-devel@nongnu.org
Subject: [PATCH 2/3] tests/acpi: add a new unit test to test hotplug off/on
 feature on the root pci bus
Date: Sun, 30 Aug 2020 15:29:13 +0530
Message-Id: <20200830095915.14402-3-ani@anisinha.ca>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200830095915.14402-1-ani@anisinha.ca>
References: <20200830095915.14402-1-ani@anisinha.ca>
Received-SPF: none client-ip=2607:f8b0:4864:20::1041;
 envelope-from=ani@anisinha.ca; helo=mail-pj1-x1041.google.com
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
 "Michael S. Tsirkin" <mst@redhat.com>, jusual@redhat.com,
 Paolo Bonzini <pbonzini@redhat.com>, Ani Sinha <ani@anisinha.ca>,
 Igor Mammedov <imammedo@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Ability to turn hotplug off on the pci root bus for i440fx was added in commit:
3d7e78aa7777f0 ("Introduce a new flag for i440fx to disable PCI hotplug on the root bus")

This change adds a unit test in order to test this feature.

This change has been tested against upstream qemu master branch on top of tag v5.1.0.

Signed-off-by: Ani Sinha <ani@anisinha.ca>
---
 tests/qtest/bios-tables-test.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/tests/qtest/bios-tables-test.c b/tests/qtest/bios-tables-test.c
index d49b3988ec..8f7d87c0f6 100644
--- a/tests/qtest/bios-tables-test.c
+++ b/tests/qtest/bios-tables-test.c
@@ -709,6 +709,19 @@ static void test_acpi_piix4_tcg_bridge(void)
     free_test_data(&data);
 }
 
+static void test_acpi_piix4_root_hotplug(void)
+{
+    test_data data;
+
+    memset(&data, 0, sizeof(data));
+    data.machine = MACHINE_PC;
+    data.variant = ".roothp";
+    data.required_struct_types = base_required_struct_types;
+    data.required_struct_types_len = ARRAY_SIZE(base_required_struct_types);
+    test_acpi_one("-global PIIX4_PM.acpi-root-pci-hotplug=off", &data);
+    free_test_data(&data);
+}
+
 static void test_acpi_q35_tcg(void)
 {
     test_data data;
@@ -1102,6 +1115,7 @@ int main(int argc, char *argv[])
         qtest_add_func("acpi/q35/tpm-tis", test_acpi_q35_tcg_tpm_tis);
         qtest_add_func("acpi/piix4", test_acpi_piix4_tcg);
         qtest_add_func("acpi/piix4/bridge", test_acpi_piix4_tcg_bridge);
+        qtest_add_func("acpi/piix4/hotplug", test_acpi_piix4_root_hotplug);
         qtest_add_func("acpi/q35", test_acpi_q35_tcg);
         qtest_add_func("acpi/q35/bridge", test_acpi_q35_tcg_bridge);
         qtest_add_func("acpi/q35/mmio64", test_acpi_q35_tcg_mmio64);
-- 
2.17.1



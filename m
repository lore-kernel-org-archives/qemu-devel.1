Return-Path: <SRS0=afRr=CX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79257C433E2
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 12:54:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 15B65206B2
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 12:54:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=anisinha-ca.20150623.gappssmtp.com header.i=@anisinha-ca.20150623.gappssmtp.com header.b="WITLPvNC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 15B65206B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=anisinha.ca
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46844 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kHo06-0000wH-9Y
	for qemu-devel@archiver.kernel.org; Mon, 14 Sep 2020 08:54:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41208)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ani@anisinha.ca>) id 1kHnsY-0000yd-J4
 for qemu-devel@nongnu.org; Mon, 14 Sep 2020 08:46:42 -0400
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:44508)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ani@anisinha.ca>) id 1kHnsW-0002Wv-Js
 for qemu-devel@nongnu.org; Mon, 14 Sep 2020 08:46:42 -0400
Received: by mail-pg1-x544.google.com with SMTP id 7so11446816pgm.11
 for <qemu-devel@nongnu.org>; Mon, 14 Sep 2020 05:46:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=anisinha-ca.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id;
 bh=yG5xlWr2lQRI+IJ71Zoym72UsKovjcpiQ/ZPFc5P+6U=;
 b=WITLPvNCDiT5D1k+tZFmd/iobNnp79eixFGSN31hcDNyssyhRSmZPZiX/xY8DO6B2E
 Thj9RzDTDsY2ydQYlvEYfbN3K2bTqIaavahnVDaFRaKqROmIu9cRmN6AGfUTC1x0ha+b
 1EE0UkMvzwKWaPbRNIc9I/1SM5ath5MVd6xx4uHU5JXVtr/TzVqrzBWcqbcZ92Se0oUR
 Gt/gUo0H5BxxgN2pyfs3doabQxUOg7eeOPtVAry8+ASjiKreFvun4YxSZAuTtOor4DgN
 r+RKtfpGos7LcoeTQKGG13Y4URNBiy/GRSbGpV21EObqLP7K51EUgKfZ2tX8AIUz+OGk
 U5fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=yG5xlWr2lQRI+IJ71Zoym72UsKovjcpiQ/ZPFc5P+6U=;
 b=M66svI1ESYuXnwa3ympjnGyFblM7vlLF0JTL3Sl/Iskv0XzvRo34BNeBz2Vh/j2cb0
 n52O15xqSAIKkHUktIA8VlVUYYlEp0ZN+sw8AsWKBP+djE2fvmh8Lk/KbpT9HWNjrV4R
 pvL60bXKD9zjS05FEDnZVQABaHk2KJ+XR/nprmPk9vJdCggVlkfhbV95GLwevOOt27Kd
 YA5UQadMeZuKT8ewKYoAQ1fnzZe5Bi6OGC2MwP7qP9zRxuCaJM4reMeN2Akn29DQ9cS0
 Qv5Ztg5O40pgeRMU/KDWI8TAZtbpCouX/R87lMhM1jMq3rvU05VTfE8sLhMH9lDKbYap
 k3QQ==
X-Gm-Message-State: AOAM530tgz9QP0s2cQV6T9NRvTNjZD8F6I9tji6KOx69q3BDOjogncJd
 +PpkSN2TAu9kHEs+4pPbFRYUO3AIm1KEHF/r
X-Google-Smtp-Source: ABdhPJzN89Tp3tRJDCK7xPLpT3dqIOnKCl78+jlLVUIIOTUBY+dmBq+HH5EfTePC3UrqTUAJQlsBIw==
X-Received: by 2002:a63:4554:: with SMTP id u20mr646286pgk.441.1600087598591; 
 Mon, 14 Sep 2020 05:46:38 -0700 (PDT)
Received: from localhost.localdomain ([203.212.240.177])
 by smtp.googlemail.com with ESMTPSA id ep4sm9156116pjb.39.2020.09.14.05.46.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Sep 2020 05:46:37 -0700 (PDT)
From: Ani Sinha <ani@anisinha.ca>
To: qemu-devel@nongnu.org
Subject: [PATCH 7/9 v2] tests/acpi: unit test for
 'acpi-pci-hotplug-with-bridge-support' bridge flag
Date: Mon, 14 Sep 2020 18:16:19 +0530
Message-Id: <20200914124619.4382-1-ani@anisinha.ca>
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
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, jusual@redhat.com,
 Paolo Bonzini <pbonzini@redhat.com>, Ani Sinha <ani@anisinha.ca>,
 Igor Mammedov <imammedo@redhat.com>
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

changelog:
v1 : initial patch
v2: commit log updated.

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



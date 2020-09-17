Return-Path: <SRS0=BocF=C2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80203C43461
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2020 07:58:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F0BC720665
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2020 07:58:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=anisinha-ca.20150623.gappssmtp.com header.i=@anisinha-ca.20150623.gappssmtp.com header.b="reM6Z6DH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F0BC720665
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=anisinha.ca
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40428 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIoo0-0004XT-Tw
	for qemu-devel@archiver.kernel.org; Thu, 17 Sep 2020 03:58:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50924)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ani@anisinha.ca>) id 1kIoer-0000ZY-Ld
 for qemu-devel@nongnu.org; Thu, 17 Sep 2020 03:48:45 -0400
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:41888)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ani@anisinha.ca>) id 1kIoep-0004tY-NX
 for qemu-devel@nongnu.org; Thu, 17 Sep 2020 03:48:45 -0400
Received: by mail-pl1-x642.google.com with SMTP id m15so684897pls.8
 for <qemu-devel@nongnu.org>; Thu, 17 Sep 2020 00:48:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=anisinha-ca.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=L+Ojah340YEaZaT0z94cZhpdvD+/mEogBpV/DpUZFRs=;
 b=reM6Z6DHzh1LDcoIFU8iWxDA/c1PaOWrcrrisTo8S5HVPaWXrQleCe8nkucnNaHwej
 hYvfTEA4JE399ZVh/Xl6UJXk9KhzdU9QFaaiBiK8a/cwYzhR+kvSpFu0avuAzAX/v/WP
 jfByW9O/FGAYwOR9ebnNXdKdYmiiKYOs+j9pi92L6LtXH6oSoFTj/aFPIw5RI32/ERoo
 3C7hlxpoGIjMw5IQXihpDCMqDMrC4mQyt2FF960qsAW15UWrQ8xrhti0rDl9iTndfjlM
 VP0OKOMqMM03hAEgTac+WZ3XJx9D1PSy+MSOp0Vmxl/iH+eu839YDT7uVL/1IikeVzaH
 SfOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=L+Ojah340YEaZaT0z94cZhpdvD+/mEogBpV/DpUZFRs=;
 b=nRhq9BQKBgXZ4kqrp7WazdfPqzvA4fp9q+85BdBzI+76S45ADup8jKpm885QuYBi8I
 W4Mk3OBmu6G9F0yRA6eQEuwonvAAySiGKqlabP6G50fK7Kl8EetSit4o0xe9X4HJ6grv
 1tAQwY7R58H2V1COGNFeEQa3OwGtWDI5nqx5R3OVVa/O5Rd5hiCjXxRXACnerwvsd4uM
 5t2efF/N0aqf21ocibBUSPnW2G/YUreeyuA0jt/yigNXM14zOtGuIpF0Qk4XDC59R7TN
 QbIaxW0l1TLSTX1MshyIlBsW1TOOT6LWUkHAF1ot13Oeq/M905HuXPzsziQjRRmaYygm
 vZ9A==
X-Gm-Message-State: AOAM533dRR2PyG/vCDJLLxZZSKzq7cT/UbHM/D69ZHFHOIjJ44LDv+Ma
 dcKTROi9JGydjNkze+lpVLCDjQ7zEUONc95p
X-Google-Smtp-Source: ABdhPJzEfG9MJaqr/sEvnvjMMeS2kpLyG6GWy8dER+ibYpJ30BWbXxo1EE1gcHsPcxLqCCtFEtuWdg==
X-Received: by 2002:a17:90b:f14:: with SMTP id
 br20mr7069904pjb.24.1600328922076; 
 Thu, 17 Sep 2020 00:48:42 -0700 (PDT)
Received: from localhost.localdomain ([115.96.122.113])
 by smtp.googlemail.com with ESMTPSA id y3sm20572516pfb.18.2020.09.17.00.48.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Sep 2020 00:48:41 -0700 (PDT)
From: Ani Sinha <ani@anisinha.ca>
To: qemu-devel@nongnu.org
Subject: [PATCH v6 11/12] tests/acpi: unit test exercising global pci hotplug
 off for i440fx
Date: Thu, 17 Sep 2020 13:17:31 +0530
Message-Id: <20200917074733.13612-12-ani@anisinha.ca>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200917074733.13612-1-ani@anisinha.ca>
References: <20200917074733.13612-1-ani@anisinha.ca>
Received-SPF: none client-ip=2607:f8b0:4864:20::642;
 envelope-from=ani@anisinha.ca; helo=mail-pl1-x642.google.com
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
 jusual@redhat.com, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Ani Sinha <ani@anisinha.ca>,
 Igor Mammedov <imammedo@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This change adds a unit test to exercise the case when hotplug is disabled
both for pci root bus and the pci bridges by passing the following two
switches to qemu:

  -global PIIX4_PM.acpi-root-pci-hotplug=off
  -global PIIX4_PM.acpi-pci-hotplug-with-bridge-support=off

bios-tables-test-allowed-diff.h documents the fact that a new DSDT acpi gold
master binary blob we need to be added to test this. We will do the actual
addition in the next patch in the series.

Signed-off-by: Ani Sinha <ani@anisinha.ca>
---
 tests/qtest/bios-tables-test-allowed-diff.h |  1 +
 tests/qtest/bios-tables-test.c              | 17 +++++++++++++++++
 2 files changed, 18 insertions(+)

diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest/bios-tables-test-allowed-diff.h
index dfb8523c8b..dea61d94f1 100644
--- a/tests/qtest/bios-tables-test-allowed-diff.h
+++ b/tests/qtest/bios-tables-test-allowed-diff.h
@@ -1 +1,2 @@
 /* List of comma-separated changed AML files to ignore */
+"tests/data/acpi/pc/DSDT.hpbrroot",
diff --git a/tests/qtest/bios-tables-test.c b/tests/qtest/bios-tables-test.c
index c970556795..3f7f1a8107 100644
--- a/tests/qtest/bios-tables-test.c
+++ b/tests/qtest/bios-tables-test.c
@@ -768,6 +768,21 @@ static void test_acpi_piix4_no_bridge_hotplug(void)
     free_test_data(&data);
 }
 
+static void test_acpi_piix4_no_acpi_pci_hotplug(void)
+{
+    test_data data;
+
+    memset(&data, 0, sizeof(data));
+    data.machine = MACHINE_PC;
+    data.variant = ".hpbrroot";
+    data.required_struct_types = base_required_struct_types;
+    data.required_struct_types_len = ARRAY_SIZE(base_required_struct_types);
+    test_acpi_one("-global PIIX4_PM.acpi-root-pci-hotplug=off "
+                  "-global PIIX4_PM.acpi-pci-hotplug-with-bridge-support=off "
+                  "-device pci-bridge,chassis_nr=1", &data);
+    free_test_data(&data);
+}
+
 static void test_acpi_q35_tcg(void)
 {
     test_data data;
@@ -1176,6 +1191,8 @@ int main(int argc, char *argv[])
                        test_acpi_piix4_no_root_hotplug);
         qtest_add_func("acpi/piix4/pci-hotplug/no_bridge_hotplug",
                        test_acpi_piix4_no_bridge_hotplug);
+        qtest_add_func("acpi/piix4/pci-hotplug/off",
+                       test_acpi_piix4_no_acpi_pci_hotplug);
         qtest_add_func("acpi/q35", test_acpi_q35_tcg);
         qtest_add_func("acpi/q35/bridge", test_acpi_q35_tcg_bridge);
         qtest_add_func("acpi/q35/mmio64", test_acpi_q35_tcg_mmio64);
-- 
2.17.1



Return-Path: <SRS0=nn+c=C3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 562DCC43463
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 08:59:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C5B9A21D42
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 08:59:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=anisinha-ca.20150623.gappssmtp.com header.i=@anisinha-ca.20150623.gappssmtp.com header.b="fLgz8+XY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C5B9A21D42
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=anisinha.ca
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50076 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kJCEO-0003k8-WE
	for qemu-devel@archiver.kernel.org; Fri, 18 Sep 2020 04:59:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37298)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ani@anisinha.ca>) id 1kJByJ-0002ov-BN
 for qemu-devel@nongnu.org; Fri, 18 Sep 2020 04:42:23 -0400
Received: from mail-pj1-x1044.google.com ([2607:f8b0:4864:20::1044]:50413)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ani@anisinha.ca>) id 1kJByH-0007wX-EL
 for qemu-devel@nongnu.org; Fri, 18 Sep 2020 04:42:22 -0400
Received: by mail-pj1-x1044.google.com with SMTP id fa1so2800273pjb.0
 for <qemu-devel@nongnu.org>; Fri, 18 Sep 2020 01:42:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=anisinha-ca.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=AWrCdAS9YrXdNthcKajxbUJ0zahd1eQ0Rfl6scNbHz8=;
 b=fLgz8+XYHn0xjKAPYxloleCayGTIofhZXbb8pAGkqVksfaHrFxiq26uXqR3Ec+dX51
 HtOaReWt1+YbsCd4Zw+5jmQDR0GUocpRrBRXAJU7QhJAYlGazL19e1XJMtWGuWwvsR1W
 +nZIW39FUEmj71fFeTiHw/vEk6chx8gbgPC/9CPCOkuXQW3bFcQQoZGNAZDcDuRK/9Mu
 333Qh/XlofHQmjuIxcaMbMfbWRunC9o9ZKq0uVm5t9JiR00E6n/1CtzG5kOnyyBej6V6
 jg4yjIyI2IZUlxd+NjDm20b9OajuD8Cj3GdpKaxPoxcwQr8HBSjaq3sqxhExn+yKZZIT
 XIUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=AWrCdAS9YrXdNthcKajxbUJ0zahd1eQ0Rfl6scNbHz8=;
 b=OEnPAqOUcJQayKTDa1C6Eu7R5u3Js5642XAMEK4qwhS5+1jQEaWopj4lVOEgzELqIs
 fBd/d+tMih1/Ced51Qq2QxCCcRVLZO13MaPm16Kp2YpQxkSzh1gnCQlEkEaSeFBDh7Ry
 4gQ5NOEtgnw+PMZqqdPy+YPZWBy8wRwuQ29efTgegKEuk9z+vn5jD3pamJ6RT36lfG2L
 iEmlw3b46Ft80jrOJ8hf2OF0/JkIoUdPXik59NU7Wj+tQfGrggff3rlIH9wWOeSp3LCy
 G+2nsPtEle2flPisvbdVqZztZDhRoLStPUQfJ+OXi7ltsVUIGj7BDuT0VxoZW1n1nI4g
 xI0Q==
X-Gm-Message-State: AOAM530sT05hIEc4veK+pLDwkHaTwQBatbJKa1bQwuWkPPiPBCAPwUc/
 9RkV91zosJMvPhIf0g+FD8DoGQ==
X-Google-Smtp-Source: ABdhPJwU+fchP6btYuuXuy3QSOpsTNnv/hO5ENu68g02PCQcCPBt0sFtWt/nYMSWNYpBBKwn6O0qKg==
X-Received: by 2002:a17:90a:d488:: with SMTP id
 s8mr12564718pju.176.1600418540276; 
 Fri, 18 Sep 2020 01:42:20 -0700 (PDT)
Received: from localhost.localdomain ([115.96.124.157])
 by smtp.googlemail.com with ESMTPSA id gi20sm2120603pjb.28.2020.09.18.01.42.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Sep 2020 01:42:19 -0700 (PDT)
From: Ani Sinha <ani@anisinha.ca>
To: mst@redhat.com,
	qemu-devel@nongnu.org
Subject: [PATCH v10 12/13] tests/acpi: unit test exercising global pci hotplug
 off for i440fx
Date: Fri, 18 Sep 2020 14:11:10 +0530
Message-Id: <20200918084111.15339-13-ani@anisinha.ca>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200918084111.15339-1-ani@anisinha.ca>
References: <20200918084111.15339-1-ani@anisinha.ca>
Received-SPF: none client-ip=2607:f8b0:4864:20::1044;
 envelope-from=ani@anisinha.ca; helo=mail-pj1-x1044.google.com
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
 Eduardo Habkost <ehabkost@redhat.com>, jusual@redhat.com,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
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
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
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



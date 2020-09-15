Return-Path: <SRS0=sZ46=CY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDFE4C433E2
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 14:49:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E6E60206B5
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 14:49:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=anisinha-ca.20150623.gappssmtp.com header.i=@anisinha-ca.20150623.gappssmtp.com header.b="q22YTofw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E6E60206B5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=anisinha.ca
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56670 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kICH1-0004Hp-01
	for qemu-devel@archiver.kernel.org; Tue, 15 Sep 2020 10:49:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33154)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ani@anisinha.ca>) id 1kICBf-0005rl-5O
 for qemu-devel@nongnu.org; Tue, 15 Sep 2020 10:44:03 -0400
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:44453)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ani@anisinha.ca>) id 1kICBd-0003x7-9g
 for qemu-devel@nongnu.org; Tue, 15 Sep 2020 10:44:02 -0400
Received: by mail-pg1-x544.google.com with SMTP id 7so2075460pgm.11
 for <qemu-devel@nongnu.org>; Tue, 15 Sep 2020 07:44:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=anisinha-ca.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=2ewfdud3Ii165X4VcRbJ5b/hyrisJxrCmECD6rzxA/4=;
 b=q22YTofwxqzTESX2hGeFOq23xTBebaBsxkQwTni3IwirBzqcGDEdijIngH+GOu6gcp
 R4p7A8DYtSoIIIcBqRtBLZvscNJBj8IYxl4WXtrPJ2gdaw5N4/HuAqgJgDJcL7Tvwn5t
 +gLhZeiL0k6zbrUldHxFp4sKZBbKiK+6KQWfWH9P9PM2sL6JEHl6gFFXnzgS4aQLzldC
 7ob2QZ9nn5pa3LCObLqRH7HdDRrGDYnDPvp+ZvWi2Iaxfak5CqpA4AqJNHXN0cWAGiGx
 kHlrlQ7QM8YFGv+58/4nL/hMFrws+Y4E7Bf6ZoSW7TANtCBdeIjNTLuuvHFph/pYvMe/
 cPvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=2ewfdud3Ii165X4VcRbJ5b/hyrisJxrCmECD6rzxA/4=;
 b=L7d7PhgeT5u7mXSzSpIELd10EtT9ZQu503YAt3iCszULergJrGtrkJyi850mmFM7FX
 30iVIaF16Hh9vPCM96Adwzs9NGWVhZJmh8s7z1VnWL8c7uRNMfqp5+dPLhMGan2/vDkE
 4iugBzXt5h/l+9hJBLLIJWi+SN3Bk5jxjzAs+8Jdemln7nui3wJGX6lST4WphjwB11L2
 xalWlToE/F0aqd9Kbvhj1FKFP4pBi6uA7DgoXEFA5pDc1sqs2jcEDSThxypyrrFSQMu9
 L2hWrHcOtz8qm4Y23+6g6DTm1YAmaXzX3OJGXUmGuyoDjspWJKOJDDH+MIaheoy/2YaS
 z7/Q==
X-Gm-Message-State: AOAM532opWyqYF2mjuSKnRq5jCtM3DEa5DtCRjXZoEy9GKwJGEJ0rQjC
 SSxmYyg1YqOIJNbpgECjKP+2mbvbuAg6ArOg6y4=
X-Google-Smtp-Source: ABdhPJzpuntK3DhpQNJmTt59Og6TibQEjnvpvTWyomW9ag8+xFbzmHIqDlojQLPpfFFA1Vo6zr27sA==
X-Received: by 2002:a63:5fc3:: with SMTP id
 t186mr14678983pgb.100.1600181039449; 
 Tue, 15 Sep 2020 07:43:59 -0700 (PDT)
Received: from localhost.localdomain ([115.96.128.178])
 by smtp.googlemail.com with ESMTPSA id r2sm11520693pga.94.2020.09.15.07.43.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Sep 2020 07:43:58 -0700 (PDT)
From: Ani Sinha <ani@anisinha.ca>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 7/9] tests/acpi: unit test for
 'acpi-pci-hotplug-with-bridge-support' bridge flag
Date: Tue, 15 Sep 2020 20:13:11 +0530
Message-Id: <20200915144314.4997-8-ani@anisinha.ca>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200915144314.4997-1-ani@anisinha.ca>
References: <20200915144314.4997-1-ani@anisinha.ca>
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

changelog:

v1: initial patch.
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



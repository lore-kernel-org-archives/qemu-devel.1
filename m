Return-Path: <SRS0=+YCa=CZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1BF8C433E2
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2020 06:16:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 65DEB21D7D
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2020 06:16:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=anisinha-ca.20150623.gappssmtp.com header.i=@anisinha-ca.20150623.gappssmtp.com header.b="fAntG7o1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 65DEB21D7D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=anisinha.ca
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44812 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIQjc-0003hJ-F3
	for qemu-devel@archiver.kernel.org; Wed, 16 Sep 2020 02:16:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59346)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ani@anisinha.ca>) id 1kIQhh-0001Ue-79
 for qemu-devel@nongnu.org; Wed, 16 Sep 2020 02:14:06 -0400
Received: from mail-pj1-x1044.google.com ([2607:f8b0:4864:20::1044]:37441)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ani@anisinha.ca>) id 1kIQhe-0005i7-MT
 for qemu-devel@nongnu.org; Wed, 16 Sep 2020 02:14:04 -0400
Received: by mail-pj1-x1044.google.com with SMTP id kk9so998756pjb.2
 for <qemu-devel@nongnu.org>; Tue, 15 Sep 2020 23:14:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=anisinha-ca.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=C+pxfabqqEbpbP52/uopOa9jod19U4/Iicx9HACbYdw=;
 b=fAntG7o1g3COtUByQ0LR9YeLC8MhgHtgdt5jxciwQL/RX1jOWf/q/ihOBx66/KGfQt
 HfgCufq69dM/t4qRvth+NMIRjYA0uUsY2ijZUofevP9Cp17WdYE+qXSpgyoQDs6x01NU
 MX5qwn8PnbLFYIHjXcF2b9XsichpaXl2jbuXOgDONBok1fyxa+eEj4nexYU+UU3mTfoq
 PHwWVheC57aWcUI6yGW7UxVJyiXY9kPBig7seAe7MVGbOiGuTzpdIvpLFgr/8T6CFMbS
 9yBIOmHrfXM92ytnyodzjuumYFyp1lviILQF9tvgZVYI3R+h7dK0NUSbQVIH20hNq8DT
 vDRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=C+pxfabqqEbpbP52/uopOa9jod19U4/Iicx9HACbYdw=;
 b=Iz+zL1EoQ7Q8rEI5eovgtU3aJf13Ku59Ns5dzo55dGLKSzgpyHQMoNfVR7tjHeYScC
 jZq9w6SjEs6OngFycVs895pQ3AVQB9a8uvhb2nIPykztvM/wSDGpEND9G98UelbHCFTl
 6fVFWVJlltkVu+9cqhgshlBn9NpfStVQHmXhzdRfCogLrdMzRJRlEzx8ytyusdkB9/A0
 bQ+imAP9CgW9ZXH9dYxh8EkxukpPqogh7b96hfh6MM6GHYw2P5Gxgg5KGdBVbrdGGkYr
 nU00M68OKKMnQfPVmNif2J7FNit2HtIoD6KVaajMOO70sAKkOGb+1XldipvbSY4XXqqi
 kBRA==
X-Gm-Message-State: AOAM531whJoG3i/RGRi+qPEDLUt/wKEcLcYh9FIQljsa4KHXpWJMk5iT
 jzQiaDmmP5lTgG1yK0YnwjKXvgCTKOF6xuVj
X-Google-Smtp-Source: ABdhPJxT+iKgo7g+CladthMAi/uBWj+hyVURu26boD2pshB0l2n1fc9ZXyN6L0EKHann4AhciWAOtw==
X-Received: by 2002:a17:90b:374b:: with SMTP id
 ne11mr2405635pjb.21.1600236838856; 
 Tue, 15 Sep 2020 23:13:58 -0700 (PDT)
Received: from localhost.localdomain ([203.163.234.244])
 by smtp.googlemail.com with ESMTPSA id c20sm583164pfc.209.2020.09.15.23.13.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Sep 2020 23:13:57 -0700 (PDT)
From: Ani Sinha <ani@anisinha.ca>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 02/11] tests/acpi: add a new unit test to test hotplug
 off/on feature on the root pci bus
Date: Wed, 16 Sep 2020 11:43:26 +0530
Message-Id: <20200916061335.14045-3-ani@anisinha.ca>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200916061335.14045-1-ani@anisinha.ca>
References: <20200916061335.14045-1-ani@anisinha.ca>
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
 Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 jusual@redhat.com, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Ani Sinha <ani@anisinha.ca>,
 Igor Mammedov <imammedo@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Ability to turn hotplug off on the pci root bus for i440fx was added in commit:
3d7e78aa7777f0 ("Introduce a new flag for i440fx to disable PCI hotplug on the root bus")

This change adds a unit test in order to test this feature.

This change has been tested against upstream qemu master branch tip.

Signed-off-by: Ani Sinha <ani@anisinha.ca>
---
 tests/qtest/bios-tables-test.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/tests/qtest/bios-tables-test.c b/tests/qtest/bios-tables-test.c
index 504b810af5..d8c7d57557 100644
--- a/tests/qtest/bios-tables-test.c
+++ b/tests/qtest/bios-tables-test.c
@@ -740,6 +740,20 @@ static void test_acpi_piix4_tcg_bridge(void)
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
+    test_acpi_one("-global PIIX4_PM.acpi-root-pci-hotplug=off "
+                  "-device pci-bridge,chassis_nr=1", &data);
+    free_test_data(&data);
+}
+
 static void test_acpi_q35_tcg(void)
 {
     test_data data;
@@ -1144,6 +1158,7 @@ int main(int argc, char *argv[])
         qtest_add_func("acpi/q35/tpm-tis", test_acpi_q35_tcg_tpm_tis);
         qtest_add_func("acpi/piix4", test_acpi_piix4_tcg);
         qtest_add_func("acpi/piix4/bridge", test_acpi_piix4_tcg_bridge);
+        qtest_add_func("acpi/piix4/hotplug", test_acpi_piix4_root_hotplug);
         qtest_add_func("acpi/q35", test_acpi_q35_tcg);
         qtest_add_func("acpi/q35/bridge", test_acpi_q35_tcg_bridge);
         qtest_add_func("acpi/q35/mmio64", test_acpi_q35_tcg_mmio64);
-- 
2.17.1



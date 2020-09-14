Return-Path: <SRS0=afRr=CX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F6B8C43461
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 12:20:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AF086223C8
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 12:20:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=anisinha-ca.20150623.gappssmtp.com header.i=@anisinha-ca.20150623.gappssmtp.com header.b="PFo8+vC7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF086223C8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=anisinha.ca
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35116 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kHnSk-0002KQ-QN
	for qemu-devel@archiver.kernel.org; Mon, 14 Sep 2020 08:20:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34140)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ani@anisinha.ca>) id 1kHnRG-0001RK-HC
 for qemu-devel@nongnu.org; Mon, 14 Sep 2020 08:18:30 -0400
Received: from mail-pj1-x1043.google.com ([2607:f8b0:4864:20::1043]:54458)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ani@anisinha.ca>) id 1kHnRE-0006vB-Kp
 for qemu-devel@nongnu.org; Mon, 14 Sep 2020 08:18:30 -0400
Received: by mail-pj1-x1043.google.com with SMTP id mm21so5458518pjb.4
 for <qemu-devel@nongnu.org>; Mon, 14 Sep 2020 05:18:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=anisinha-ca.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id;
 bh=yfXD2zBgmYZgPVxKBmr80THfM4wfEY9XMRnvrPT1WGI=;
 b=PFo8+vC7A6fUkcsSSLKWuBTPcQsuFBL7MWUdlw6+IgVL9x7m1ZvkfTrWS5NlM90U0g
 ywa+/raVx2gKk+xDCEQSf6gUc7+HaCaHwxx+3SrGjiYnKZ7tqjefGM3vMqRCCJgE1TZq
 QzsZfds9UXQRHrV+b28i7PfE5nETLUKyUuy3n27eMz6ANCZ9EdirMnM5ZyorKlKVUXl5
 wr+dXoPz0eW0ud5i0xTAXUtkImiaBbcnfum3uFqAvoScgkeZwTe6rwGLDvbEZPDC5vu6
 ME4znOJPxbIufe5zmi3wJ69kvPPPeTpHC1brCXe0X4iUgcy7dEbjQb5HIfxlogO67Wy5
 GGIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=yfXD2zBgmYZgPVxKBmr80THfM4wfEY9XMRnvrPT1WGI=;
 b=lJ+a3313o0N33uyxLTIMStg/PZP8aX8Zwu3EuuksDo3daIIWbjV8CkV+ULhdpNr7BS
 Juo5WhY5RyYLlgQSJa6ypgxPkBDcjA3zTHGU4Zii3q4xPfKvqGMFnTbzeHJ+EyAPVujD
 WWQSQIKWvSo+1YxxmEmyAJyb5fuhnvAK4o36q6d+HLcuxVNzld8fZrTQ3ut2fTbE5vPC
 ka/aP/Yqe07NdNi28lTnGzR14ESxTVHT/1E8un3qg0rH4VkeGGR/7gvQs9Bp57dM3tES
 nVC/QP9tz+bX9CwsfQqIh7aexRCUg7LYUjzZ62EUEmN1RTS9QYIPTL8Bnr0itLXqs0Ev
 efoQ==
X-Gm-Message-State: AOAM530sdXRoYsvUThp2OP9KEUbeAgb3ar9yyf/H3G8e3j3Sz4qXGdiK
 RfXt0pSECBa0nIjlmVRlspQ9+ZyVfVoPAaHa
X-Google-Smtp-Source: ABdhPJwfr7usPuSI7Bs7dE4gpsuXjvsLCeh9gv4wt83dLaOFxvsIH9g6uzGf5EQKXOcWdQS3ZgkOmw==
X-Received: by 2002:a17:90a:ea0c:: with SMTP id
 w12mr13644301pjy.65.1600085906471; 
 Mon, 14 Sep 2020 05:18:26 -0700 (PDT)
Received: from localhost.localdomain ([203.212.240.177])
 by smtp.googlemail.com with ESMTPSA id
 y202sm10484241pfc.179.2020.09.14.05.18.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Sep 2020 05:18:25 -0700 (PDT)
From: Ani Sinha <ani@anisinha.ca>
To: qemu-devel@nongnu.org
Subject: [PATCH 2/9] tests/acpi: add a new unit test to test hotplug off/on
 feature on the root pci bus
Date: Mon, 14 Sep 2020 17:48:14 +0530
Message-Id: <20200914121814.3988-1-ani@anisinha.ca>
X-Mailer: git-send-email 2.17.1
Received-SPF: none client-ip=2607:f8b0:4864:20::1043;
 envelope-from=ani@anisinha.ca; helo=mail-pj1-x1043.google.com
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

This change has been tested against upstream qemu master branch tip.

Signed-off-by: Ani Sinha <ani@anisinha.ca>
---
 tests/qtest/bios-tables-test.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

changelog:
v1: initial patch
v2:  updated comment to reflect that the patch was tested against qemu master branch tip.

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



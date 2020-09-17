Return-Path: <SRS0=BocF=C2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74603C433E2
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2020 10:16:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D83722083B
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2020 10:16:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=anisinha-ca.20150623.gappssmtp.com header.i=@anisinha-ca.20150623.gappssmtp.com header.b="gAaMx+Em"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D83722083B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=anisinha.ca
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40172 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIqxk-00082L-Nv
	for qemu-devel@archiver.kernel.org; Thu, 17 Sep 2020 06:16:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60240)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ani@anisinha.ca>) id 1kIqs6-0000VB-9v
 for qemu-devel@nongnu.org; Thu, 17 Sep 2020 06:10:34 -0400
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:46203)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ani@anisinha.ca>) id 1kIqrz-0003U9-Pe
 for qemu-devel@nongnu.org; Thu, 17 Sep 2020 06:10:33 -0400
Received: by mail-pl1-x642.google.com with SMTP id f1so854166plo.13
 for <qemu-devel@nongnu.org>; Thu, 17 Sep 2020 03:10:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=anisinha-ca.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=djDyPCHV2KQRcs6lHtT3AJbP4Jr32BITnAiU+WVBllU=;
 b=gAaMx+EmzcwUAOuWFFTGwymlUJO7h5i1EWMymBWem2OyH7OqMKjegD3dVCHD2S5h+U
 e9zZKpnCIiNqEisZwztGQwB6BmCCX8QgNc6hzX6/wC2RC98VYvolQRzbU/UmQ0zr8VoQ
 OqOenwWHLXwItdydYF5mMGvBkvkt62Z1CQUpqVrf8+prWwwMeXpfMGRAWlluUEuTowgB
 1Ju1b+hgMJglVZEUDL29uhjQpXAC9mjTc6QqCdHZGxc9supYnTzG2jnt9RmMVll2NSWe
 qZGQuK0AHS4XiAsAWbeHfPNDjt8aGzHnKau3smIc9tSRXOeRvl0XFacyli6qVXabShNY
 r9AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=djDyPCHV2KQRcs6lHtT3AJbP4Jr32BITnAiU+WVBllU=;
 b=hEGNZmN5f0jLayOfSEw0lhiiRHWA8cWp2OUNOk3j5KSxUDp2fv7zfBfWywYbQtvuDE
 PGuVyX+0fg0Y1ffCpX1WSSZGMWucd+UXLXE29gMVoEt1I+p+izGnQaB7CmLyex0hJ95L
 l+0oRtOy9GTFE2CYpRWN1tWMYanY4dLe6gTPZVZx2PTiF/eZfvvINBVJUQJ55i3Ewfuk
 UmrJ74CE7LGhVhit+0Phfn4ugcL4o4JsrTunagurRZVE+pFqgy7gX/VaCT+vGsKa3GzX
 o93srUYdIyl/TxoyePnOPnQmT8k3oIkGG9/sLp6Z6u543PEOJYdlU4xtY1ZasQTBZx6J
 MrkQ==
X-Gm-Message-State: AOAM530pXZSEsRbp2N2ISzTfPKuA1Nie1IWGfi5dNaoVw4punKvaHZE8
 y7t95lUTlGbc8ldneoEjto9mh/Nwx7S0k+SE
X-Google-Smtp-Source: ABdhPJz2vVgDMlBR4ZlbJ2JDfD+KjctWDWXH6tiVqHE7Kh7m/Q79Cr1RkHe6gqDs02mWddPfbpuSqw==
X-Received: by 2002:a17:902:aa49:b029:d0:cbe1:e7b3 with SMTP id
 c9-20020a170902aa49b02900d0cbe1e7b3mr28314684plr.36.1600337426012; 
 Thu, 17 Sep 2020 03:10:26 -0700 (PDT)
Received: from localhost.localdomain ([115.96.122.113])
 by smtp.googlemail.com with ESMTPSA id d20sm5241559pjv.39.2020.09.17.03.10.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Sep 2020 03:10:25 -0700 (PDT)
From: Ani Sinha <ani@anisinha.ca>
To: qemu-devel@nongnu.org
Subject: [PATCH v7 07/12] tests/acpi: unit test for
 'acpi-pci-hotplug-with-bridge-support' bridge flag
Date: Thu, 17 Sep 2020 15:39:42 +0530
Message-Id: <20200917100947.21106-8-ani@anisinha.ca>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200917100947.21106-1-ani@anisinha.ca>
References: <20200917100947.21106-1-ani@anisinha.ca>
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
 "Michael S. Tsirkin" <mst@redhat.com>, jusual@redhat.com,
 Paolo Bonzini <pbonzini@redhat.com>, Ani Sinha <ani@anisinha.ca>,
 Igor Mammedov <imammedo@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This change adds a new unit test for the global flag
'acpi-pci-hotplug-with-bridge-support' which is available for cold plugged pci
bridges in i440fx. The flag can be used to turn off ACPI based hotplug support
on all pci bridges.

Signed-off-by: Ani Sinha <ani@anisinha.ca>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
---
 tests/qtest/bios-tables-test.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/tests/qtest/bios-tables-test.c b/tests/qtest/bios-tables-test.c
index ad157ef05d..c970556795 100644
--- a/tests/qtest/bios-tables-test.c
+++ b/tests/qtest/bios-tables-test.c
@@ -754,6 +754,20 @@ static void test_acpi_piix4_no_root_hotplug(void)
     free_test_data(&data);
 }
 
+static void test_acpi_piix4_no_bridge_hotplug(void)
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
@@ -1160,6 +1174,8 @@ int main(int argc, char *argv[])
         qtest_add_func("acpi/piix4/bridge", test_acpi_piix4_tcg_bridge);
         qtest_add_func("acpi/piix4/pci-hotplug/no_root_hotplug",
                        test_acpi_piix4_no_root_hotplug);
+        qtest_add_func("acpi/piix4/pci-hotplug/no_bridge_hotplug",
+                       test_acpi_piix4_no_bridge_hotplug);
         qtest_add_func("acpi/q35", test_acpi_q35_tcg);
         qtest_add_func("acpi/q35/bridge", test_acpi_q35_tcg_bridge);
         qtest_add_func("acpi/q35/mmio64", test_acpi_q35_tcg_mmio64);
-- 
2.17.1



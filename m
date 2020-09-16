Return-Path: <SRS0=+YCa=CZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8FF0C433E2
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2020 06:32:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 49ED9206A5
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2020 06:32:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=anisinha-ca.20150623.gappssmtp.com header.i=@anisinha-ca.20150623.gappssmtp.com header.b="znBDVvFX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 49ED9206A5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=anisinha.ca
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60476 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIQzh-0005pq-U0
	for qemu-devel@archiver.kernel.org; Wed, 16 Sep 2020 02:32:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59642)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ani@anisinha.ca>) id 1kIQiH-0002uc-Vv
 for qemu-devel@nongnu.org; Wed, 16 Sep 2020 02:14:42 -0400
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641]:45027)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ani@anisinha.ca>) id 1kIQiF-0005or-Vq
 for qemu-devel@nongnu.org; Wed, 16 Sep 2020 02:14:41 -0400
Received: by mail-pl1-x641.google.com with SMTP id j7so2620769plk.11
 for <qemu-devel@nongnu.org>; Tue, 15 Sep 2020 23:14:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=anisinha-ca.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=0NuRMwOOuw4+A7XjAHXyfmzMXY8Mc8JPenZyhrOCMCk=;
 b=znBDVvFX1vhd+b+B6ErP7EipwCIKyT76EpIvW1JvKM1UaWudnLcZ7KIToZhiOnf034
 4hyY5U56q49o+jiPR1pWG0tyeNPK7rQmSuy/VUO5CH9ug6soqai3uqtnWurHckbsIU6P
 WhzDEuh1ZSkKNWt//fj3ayHlPXnKq2VKXZsYWTen20q6n4PP/8WU8imVbA9IsSsWpVs2
 pE9yCdeNAkr6DKOiNavIzHuOqXH9fvBEn7sb93OjBgggHaOtva8wzgB+DhySaRulyur+
 3dZVsTjYfw7UiV7gE+iggvL83eP8fVhUruEaTgq524/zksOVrKasCKoW2Tsiut/G6kdl
 j79Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=0NuRMwOOuw4+A7XjAHXyfmzMXY8Mc8JPenZyhrOCMCk=;
 b=bQ/XFBZgKuRn6gRtNkp9Ky3p/OJDga54/gAVb2KOmFHnPHN2UoUXnYTSmNS12CXG2b
 ObYYF2VNJ3FiZA37xhkEdkHla38CqfQXSSEeqaT58JFbbBO6jVOi+V2QGoOKE4UVHy+4
 joph4/QfzGYpn2aFVUMc1UfrJXJF6R2GmovxpKtYErjlf0mH4hPwFOoLtcXnDgeBnnFb
 Z05y+QDKZga0Lstin1dWR30fwace1Wt7tJfu1vZlaTDbbyxqeSQxJHOy0ZawjCBonOWT
 GEVUBYMTjPkzzBHyy8HDK2pHY8J01SzIetjKvDIEHO/232ji8qo6wWuUDkAlZkPYhnYx
 9qGg==
X-Gm-Message-State: AOAM530sQvN1Zfjxc2JJtHVFJZ1qmQSlF2nYz9oTjz7QDWMU1/6zy3H1
 tj+m/nxyPci+MumusqMIcGjLVI3o8CWRAqpP
X-Google-Smtp-Source: ABdhPJwZoBc988EOUNmW4S+5OeJ7DvqeKo71K/bxVwN333cxQ4HqWZzrnp4vPDjH9GrdRGS9dDVXQQ==
X-Received: by 2002:a17:90a:a591:: with SMTP id
 b17mr2655872pjq.159.1600236878334; 
 Tue, 15 Sep 2020 23:14:38 -0700 (PDT)
Received: from localhost.localdomain ([203.163.234.244])
 by smtp.googlemail.com with ESMTPSA id c20sm583164pfc.209.2020.09.15.23.14.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Sep 2020 23:14:37 -0700 (PDT)
From: Ani Sinha <ani@anisinha.ca>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 10/11] tests/acpi: unit test exercizing hotplug off for pci
 root bus & bridge in i440fx
Date: Wed, 16 Sep 2020 11:43:34 +0530
Message-Id: <20200916061335.14045-11-ani@anisinha.ca>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200916061335.14045-1-ani@anisinha.ca>
References: <20200916061335.14045-1-ani@anisinha.ca>
Received-SPF: none client-ip=2607:f8b0:4864:20::641;
 envelope-from=ani@anisinha.ca; helo=mail-pl1-x641.google.com
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

This change adds a unit test to exercize the case when hotplug is disabled both for
pci root bus and the pci bridges by passing the following two switches to qemu:

  -global PIIX4_PM.acpi-root-pci-hotplug=off
  -global PIIX4_PM.acpi-pci-hotplug-with-bridge-support=off

bios-tables-test-allowed-diff.h documents the fact that a new DSDT acpi gold master
binary blob we need to be added to test this. We will do the actual addition in the
next patch in the series.

The following link contains the disassembly of the DSDT table after passing the above
two switches to qemu: https://pastebin.ubuntu.com/p/WvpYYjpPN8/

Signed-off-by: Ani Sinha <ani@anisinha.ca>
---
 tests/qtest/bios-tables-test-allowed-diff.h |  1 +
 tests/qtest/bios-tables-test.c              | 19 ++++++++++++++++++-
 2 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest/bios-tables-test-allowed-diff.h
index dfb8523c8b..dea61d94f1 100644
--- a/tests/qtest/bios-tables-test-allowed-diff.h
+++ b/tests/qtest/bios-tables-test-allowed-diff.h
@@ -1 +1,2 @@
 /* List of comma-separated changed AML files to ignore */
+"tests/data/acpi/pc/DSDT.hpbrroot",
diff --git a/tests/qtest/bios-tables-test.c b/tests/qtest/bios-tables-test.c
index 7632cfe1be..4c834474ad 100644
--- a/tests/qtest/bios-tables-test.c
+++ b/tests/qtest/bios-tables-test.c
@@ -768,6 +768,21 @@ static void test_acpi_piix4_bridge_hotplug(void)
     free_test_data(&data);
 }
 
+static void test_acpi_piix4_bridge_root_hotplug(void)
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
@@ -1172,8 +1187,10 @@ int main(int argc, char *argv[])
         qtest_add_func("acpi/q35/tpm-tis", test_acpi_q35_tcg_tpm_tis);
         qtest_add_func("acpi/piix4", test_acpi_piix4_tcg);
         qtest_add_func("acpi/piix4/bridge", test_acpi_piix4_tcg_bridge);
-        qtest_add_func("acpi/piix4/hotplug", test_acpi_piix4_root_hotplug);
+        qtest_add_func("acpi/piix4/roothotplug", test_acpi_piix4_root_hotplug);
         qtest_add_func("acpi/piix4/brhotplug", test_acpi_piix4_bridge_hotplug);
+        qtest_add_func("acpi/piix4/disablehp",
+                       test_acpi_piix4_bridge_root_hotplug);
         qtest_add_func("acpi/q35", test_acpi_q35_tcg);
         qtest_add_func("acpi/q35/bridge", test_acpi_q35_tcg_bridge);
         qtest_add_func("acpi/q35/mmio64", test_acpi_q35_tcg_mmio64);
-- 
2.17.1



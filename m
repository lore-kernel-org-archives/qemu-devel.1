Return-Path: <SRS0=+YCa=CZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A61EC433E2
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2020 08:28:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 102DC20872
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2020 08:28:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=anisinha-ca.20150623.gappssmtp.com header.i=@anisinha-ca.20150623.gappssmtp.com header.b="Sj7vrBrC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 102DC20872
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=anisinha.ca
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54798 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kISnk-0002nf-7l
	for qemu-devel@archiver.kernel.org; Wed, 16 Sep 2020 04:28:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58048)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ani@anisinha.ca>) id 1kISfs-0000or-6v
 for qemu-devel@nongnu.org; Wed, 16 Sep 2020 04:20:22 -0400
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:39809)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ani@anisinha.ca>) id 1kISfm-0004sh-7B
 for qemu-devel@nongnu.org; Wed, 16 Sep 2020 04:20:18 -0400
Received: by mail-pf1-x441.google.com with SMTP id n14so3524856pff.6
 for <qemu-devel@nongnu.org>; Wed, 16 Sep 2020 01:20:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=anisinha-ca.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=JGmQF7dBOvevh3gZbauSGv+D+CEUL1Y8510g7/95cwg=;
 b=Sj7vrBrC6dn//bK7TWr5jvM9ByhPfO9RIwpDeJYDsDt+YXaBrmtXHl8D88cNbrflL7
 wKSuaQIjP1RKQneYpnwiBOCCGK7LuHGDt2hhoyHi47luXZeS8cmcZlpwukZmnagUHlQ9
 xSnSIH5x9ToaPUci9h+Mo9QBCBOlqxiNxNaf0aXe/x6uDnh1bfUCO0IVj6CTqCsNJxgI
 6XJjpAFKwp/SjgEnXBqRBZayJKzGpp9nT1He2shn3QoKsNPyL9uIii+nEmS+a4uDBwtY
 HHr8bFan+Ty8fWRHk11HpMsW11Z14e24m6dGfiINncWujZvgNPcfFNVjG8fOfu9i6Ay3
 d6Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=JGmQF7dBOvevh3gZbauSGv+D+CEUL1Y8510g7/95cwg=;
 b=IUZq7Q69MQWLEioAQ+2c3Uv+z4/w/+nlRyS/2AQLPW2QcVetH2IcWsRBRxqSIUVrHK
 +SIz3kZE3YXPEeII7yMPLNOFR5zvDC8G1Ec0fl3c9W5MKzMFKvmycEvDgkpYRyeIXjnn
 u0GPx1zHU6LVD5J/i+8c8nleKmzDzlXTrFj7LEGSt8PUn3JMnvEJTfhsUdR57RsTkYQo
 ElVZSY/I5aOlP5pJksXWTzEvA1YVarwALFbgO8FMzFfLQcsHY2c/Y3vq7C5wtiill/W1
 UAK1ORWSeVUwZF3tDbm3/Eol50ECZKaj6lHwP+FfGkPi3Y/k3kL+etOHlIcV/akJ/W3Q
 PSFA==
X-Gm-Message-State: AOAM531R8kHzTPGqMYPnHQ3r0nauGlCW8TVJ8tWVP3eHrTTltqjs0WA5
 dCLnZ0a/AapFp/XvwUIbmJeZ1g6uUSZtW3Gt
X-Google-Smtp-Source: ABdhPJwrRM6wuhGA30L/A8v8H88aBGYlQE9gN9C7HQrlxYJ/Mywc1gM/U6E3NXipvoeRt8GTWYWP0w==
X-Received: by 2002:a63:1257:: with SMTP id 23mr16286564pgs.401.1600244412416; 
 Wed, 16 Sep 2020 01:20:12 -0700 (PDT)
Received: from localhost.localdomain ([203.163.234.244])
 by smtp.googlemail.com with ESMTPSA id nl10sm1658254pjb.11.2020.09.16.01.20.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Sep 2020 01:20:11 -0700 (PDT)
From: Ani Sinha <ani@anisinha.ca>
To: qemu-devel@nongnu.org
Subject: [PATCH v5 10/11] tests/acpi: unit test exercising hotplug off for pci
 root bus & bridge in i440fx
Date: Wed, 16 Sep 2020 13:49:09 +0530
Message-Id: <20200916081910.977-11-ani@anisinha.ca>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200916081910.977-1-ani@anisinha.ca>
References: <20200916081910.977-1-ani@anisinha.ca>
Received-SPF: none client-ip=2607:f8b0:4864:20::441;
 envelope-from=ani@anisinha.ca; helo=mail-pf1-x441.google.com
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

This change adds a unit test to exercise the case when hotplug is disabled both for
pci root bus and the pci bridges by passing the following two switches to qemu:

  -global PIIX4_PM.acpi-root-pci-hotplug=off
  -global PIIX4_PM.acpi-pci-hotplug-with-bridge-support=off

bios-tables-test-allowed-diff.h documents the fact that a new DSDT acpi gold master
binary blob we need to be added to test this. We will do the actual addition in the
next patch in the series.

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
index e989afe35c..a9d41fc06a 100644
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
         qtest_add_func("acpi/piix4/nobrhotplug",
                        test_acpi_piix4_no_bridge_hotplug);
+        qtest_add_func("acpi/piix4/pci-hotplug/off",
+                       test_acpi_piix4_no_acpi_pci_hotplug);
         qtest_add_func("acpi/q35", test_acpi_q35_tcg);
         qtest_add_func("acpi/q35/bridge", test_acpi_q35_tcg_bridge);
         qtest_add_func("acpi/q35/mmio64", test_acpi_q35_tcg_mmio64);
-- 
2.17.1



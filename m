Return-Path: <SRS0=BocF=C2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AEF4C433E2
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2020 07:50:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DEC8521D7F
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2020 07:50:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=anisinha-ca.20150623.gappssmtp.com header.i=@anisinha-ca.20150623.gappssmtp.com header.b="BR6iJZR/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DEC8521D7F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=anisinha.ca
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43644 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIogF-0002F1-Ky
	for qemu-devel@archiver.kernel.org; Thu, 17 Sep 2020 03:50:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50604)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ani@anisinha.ca>) id 1kIoe7-0007hj-1u
 for qemu-devel@nongnu.org; Thu, 17 Sep 2020 03:47:59 -0400
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:45557)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ani@anisinha.ca>) id 1kIoe5-0004ng-7j
 for qemu-devel@nongnu.org; Thu, 17 Sep 2020 03:47:58 -0400
Received: by mail-pf1-x444.google.com with SMTP id k15so673467pfc.12
 for <qemu-devel@nongnu.org>; Thu, 17 Sep 2020 00:47:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=anisinha-ca.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=YfALMwALzeYbzwckrxN8lzSGcpwno9FZ6SZJMeQ9frI=;
 b=BR6iJZR/MsBxG/OM9f++UDPEmiYp7yyRi+lsiWPMo/B9KWzlISLareAJfNoj6pzYIt
 2XsO358iu6OLOfETPsSJoXffyobKzFv9xUwvOmnnLjVq4/dN8SvlalkXQh5w4kjOc2bZ
 qo3Qyl/MzM4Lgqc1Er/NXwFQMQd5dpBRpYPm67PORsb5fp9vvryMl/E9hF6XgvkhlPI2
 Qmebk/7Xhf+v3AJZgqvquVzVBW2vvnFeWBmP+JzPvGVBNebn1RRDNlvcEwa9/GkWkXNX
 4allbiA17F+5zUpTxq7BidhglFaNmARGNaJsQkfaEp8oyjugV7PjBcEJGlXGmGlhfAwC
 ShNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=YfALMwALzeYbzwckrxN8lzSGcpwno9FZ6SZJMeQ9frI=;
 b=kBf/Ozwu5fPcqzSKuxdjh+hxkNv9wv/ln8syI0AL5UwQUB2UzqxX2Apu91KgQ9D73w
 lFh0edXUzWItkVf0l0c7QR3DQreMaqtYIzTmRjDiAjzgb88CnX9oJkUw1/cgu2WxL50U
 R/NYqQFNkFH+V1lE4b2NWgCBFayw03pEejMHhR+z5igaMC6W6MJMQIzVeJS8ywnOkjhA
 f3rsgd4FrLkMZT8aJ/JKl9Cc9drC9XgwP8crTNJ+Pu05LkiJ9mtkVpaRE4ob1RjFEI65
 twTs/duRfGTe4xmhhgZLxBE8yweAwrVVPw1alvZyF6S0mU/et7vzWT3HJf83obSRORll
 p/cw==
X-Gm-Message-State: AOAM5314cAsKJVKVZAAytciTR8eaN/98ecHqe+et5xiUUiuJ0KDKFss8
 QHsAehSQQEY0n6NSqHz7fnIIS4JPWZYPDzbA
X-Google-Smtp-Source: ABdhPJyCYZ2VgIqGj9GVcuVqUqNjSevR4r5yAT+Mu4oSSKQyF4FNRRGDb2olSc07mbI0DzbK47MZfg==
X-Received: by 2002:aa7:9a90:0:b029:142:2501:39e7 with SMTP id
 w16-20020aa79a900000b0290142250139e7mr10037000pfi.54.1600328875493; 
 Thu, 17 Sep 2020 00:47:55 -0700 (PDT)
Received: from localhost.localdomain ([115.96.122.113])
 by smtp.googlemail.com with ESMTPSA id y3sm20572516pfb.18.2020.09.17.00.47.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Sep 2020 00:47:54 -0700 (PDT)
From: Ani Sinha <ani@anisinha.ca>
To: qemu-devel@nongnu.org
Subject: [PATCH v6 02/12] tests/acpi: add new unit test to test hotplug off/on
 feature on the root pci bus
Date: Thu, 17 Sep 2020 13:17:22 +0530
Message-Id: <20200917074733.13612-3-ani@anisinha.ca>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200917074733.13612-1-ani@anisinha.ca>
References: <20200917074733.13612-1-ani@anisinha.ca>
Received-SPF: none client-ip=2607:f8b0:4864:20::444;
 envelope-from=ani@anisinha.ca; helo=mail-pf1-x444.google.com
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
3d7e78aa7777f0 ("Introduce a new flag for i440fx to disable PCI hotplug on the
root bus")

This change adds a unit test in order to test this feature.

Signed-off-by: Ani Sinha <ani@anisinha.ca>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
---
 tests/qtest/bios-tables-test.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/tests/qtest/bios-tables-test.c b/tests/qtest/bios-tables-test.c
index 504b810af5..ad157ef05d 100644
--- a/tests/qtest/bios-tables-test.c
+++ b/tests/qtest/bios-tables-test.c
@@ -740,6 +740,20 @@ static void test_acpi_piix4_tcg_bridge(void)
     free_test_data(&data);
 }
 
+static void test_acpi_piix4_no_root_hotplug(void)
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
@@ -1144,6 +1158,8 @@ int main(int argc, char *argv[])
         qtest_add_func("acpi/q35/tpm-tis", test_acpi_q35_tcg_tpm_tis);
         qtest_add_func("acpi/piix4", test_acpi_piix4_tcg);
         qtest_add_func("acpi/piix4/bridge", test_acpi_piix4_tcg_bridge);
+        qtest_add_func("acpi/piix4/pci-hotplug/no_root_hotplug",
+                       test_acpi_piix4_no_root_hotplug);
         qtest_add_func("acpi/q35", test_acpi_q35_tcg);
         qtest_add_func("acpi/q35/bridge", test_acpi_q35_tcg_bridge);
         qtest_add_func("acpi/q35/mmio64", test_acpi_q35_tcg_mmio64);
-- 
2.17.1



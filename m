Return-Path: <SRS0=+YCa=CZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A45C9C433E2
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2020 08:22:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 30C212083B
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2020 08:22:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=anisinha-ca.20150623.gappssmtp.com header.i=@anisinha-ca.20150623.gappssmtp.com header.b="Z3k4Ha+q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 30C212083B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=anisinha.ca
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34836 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIShk-0002wR-70
	for qemu-devel@archiver.kernel.org; Wed, 16 Sep 2020 04:22:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57986)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ani@anisinha.ca>) id 1kISfY-0000Pr-4v
 for qemu-devel@nongnu.org; Wed, 16 Sep 2020 04:20:00 -0400
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:36376)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ani@anisinha.ca>) id 1kISfW-0004q2-DV
 for qemu-devel@nongnu.org; Wed, 16 Sep 2020 04:19:59 -0400
Received: by mail-pl1-x642.google.com with SMTP id k13so2789015plk.3
 for <qemu-devel@nongnu.org>; Wed, 16 Sep 2020 01:19:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=anisinha-ca.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=hr3QwXDcp0idTZAJ1Ej+Iw5mo+xgGhKi4dTafa8iA5M=;
 b=Z3k4Ha+qgzysJQs3oH9Skw1JBbQjix5E/jt0nKBstIf/wREQCVMWZvopPIEx/3W3BT
 efZfuvMF4K+y3SumZ133IgXQZs4fOqA2QUhjiP6ru6GEl9m2Gh9iIuOq8NTx1+mfJTPJ
 cNg/tCqEN7wEgdH5bUBojrHMZuf2KX5wEZA+ithCfxBw+rikT2rpxq5r/WJrJZQ2MqQC
 Wx73/Uhn49JWTTwXZaXWI1cUdxAdn+fTBMBmi3Wi7efQsKccf+esQzQu+lTlQR4gQaYb
 brYKQi9DAD0/964I/iDN7zs6XSG+IRrh/dZdBgodZZPrS2D6QnwQ70jQ1q5uo2edTIIE
 0TNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=hr3QwXDcp0idTZAJ1Ej+Iw5mo+xgGhKi4dTafa8iA5M=;
 b=T/Prezi6uPmPSrv0MXIEQaSJCvf3QiMiIv/XtGSOWZ/Y25hwELFbk2ogKVcFZ3/F73
 iH5huQ/wCTFtI8UtGMl9mXN5yy3AHXvrd+HVQzmRDxaMLRTANvcV5B6GomC5JYpmSyKA
 KIWbS5QDi9w2Ne7hh3Nur1jtFqCTv46VPbxpXaIWf+JwlIr5U/RJSMvRSVg3et1jvRkV
 95/P9vhXQss3wX3VjLXdMiQkzm6n+i0ujajPS4A74Br9wswtlZk0ogr6aeaw7c9jBkEB
 sbsQh3cmbdXbOhKk4vi09pQZ9hoiV8ZcMgBaqWwETAvrVNGX0e2e+rZmyItz5e0evi6x
 xfzw==
X-Gm-Message-State: AOAM533ZnfdWeT5wlVS9yHhQeq6McKGgmkU0U2PHEVjRrOoSer1OmrKa
 flYs4cmGDbw6Dep5zhEtLnJrcligyZqfesUz
X-Google-Smtp-Source: ABdhPJw3OAqhJFYuehrREIcLo/ruPH7WI0n0IRMh206BXX2ovy7cvm0xDIytQbpL+14NR8mczJcQvg==
X-Received: by 2002:a17:90a:6582:: with SMTP id
 k2mr2889726pjj.40.1600244396825; 
 Wed, 16 Sep 2020 01:19:56 -0700 (PDT)
Received: from localhost.localdomain ([203.163.234.244])
 by smtp.googlemail.com with ESMTPSA id nl10sm1658254pjb.11.2020.09.16.01.19.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Sep 2020 01:19:56 -0700 (PDT)
From: Ani Sinha <ani@anisinha.ca>
To: qemu-devel@nongnu.org
Subject: [PATCH v5 07/11] tests/acpi: unit test for
 'acpi-pci-hotplug-with-bridge-support' bridge flag
Date: Wed, 16 Sep 2020 13:49:06 +0530
Message-Id: <20200916081910.977-8-ani@anisinha.ca>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200916081910.977-1-ani@anisinha.ca>
References: <20200916081910.977-1-ani@anisinha.ca>
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

This change adds a new unit test for the global flag
'acpi-pci-hotplug-with-bridge-support' which is available for cold plugged pci
bridges in i440fx. The flag can be used to turn off acpi based hotplug support
on all pci bridges.

Signed-off-by: Ani Sinha <ani@anisinha.ca>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
---
 tests/qtest/bios-tables-test.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/tests/qtest/bios-tables-test.c b/tests/qtest/bios-tables-test.c
index 75d99f08e5..e989afe35c 100644
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
         qtest_add_func("acpi/piix4/no_root_hotplug",
                        test_acpi_piix4_no_root_hotplug);
+        qtest_add_func("acpi/piix4/nobrhotplug",
+                       test_acpi_piix4_no_bridge_hotplug);
         qtest_add_func("acpi/q35", test_acpi_q35_tcg);
         qtest_add_func("acpi/q35/bridge", test_acpi_q35_tcg_bridge);
         qtest_add_func("acpi/q35/mmio64", test_acpi_q35_tcg_mmio64);
-- 
2.17.1



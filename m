Return-Path: <SRS0=BocF=C2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22287C43461
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2020 07:57:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A19E920665
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2020 07:57:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=anisinha-ca.20150623.gappssmtp.com header.i=@anisinha-ca.20150623.gappssmtp.com header.b="05q0t7gb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A19E920665
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=anisinha.ca
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36928 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIomy-000319-K8
	for qemu-devel@archiver.kernel.org; Thu, 17 Sep 2020 03:57:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50780)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ani@anisinha.ca>) id 1kIoeY-0008Nu-Dx
 for qemu-devel@nongnu.org; Thu, 17 Sep 2020 03:48:27 -0400
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641]:37496)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ani@anisinha.ca>) id 1kIoeV-0004qO-Kr
 for qemu-devel@nongnu.org; Thu, 17 Sep 2020 03:48:26 -0400
Received: by mail-pl1-x641.google.com with SMTP id u9so694476plk.4
 for <qemu-devel@nongnu.org>; Thu, 17 Sep 2020 00:48:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=anisinha-ca.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=6ws6sW14Miny7HE5mF7XBug1H3oEwuuyS4+snZ7w4Xo=;
 b=05q0t7gbrug9rR6sz6PXPJTzqE4jnMPCBaLR/kIRaZud992WNoEqZ49xo3kMOlP6a7
 eAZKdifXn78h6um1vErAEdywaTJ0MHuvy/Jw3JkDJsOzWdClAg0VTezPsIvzRS4l56tZ
 K6zfs6s2iUjoDgM/jO6D80IHam5EEBEV++OGpNZC5fVfuO/nLzs4mOMktgK37hjQoDsF
 LhcmjLSGg8zgBHwQB+TIzOyry4qgl/AP0sLBEj0ni5FHwaLjfrNcQgEXkTx0FvFQTud6
 xBldUel0p40HjNUuahecb1QINwfZxCxiVkNYtYA51y43TTZnh7H1YTtgcaENZIoPXz1j
 Ue0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=6ws6sW14Miny7HE5mF7XBug1H3oEwuuyS4+snZ7w4Xo=;
 b=lQYNc1Qo3jaEl3PTgfkVz7enPp87nM4CfvekIVO8/JSKkFeTsfGJy+oOxQT+UKphI6
 wFW/3ge4szghJC/jPfBHOmixYgJQQVZ9DRTkppgnOIOVgWoZNjdd3f4tEz/tPkA1dL6R
 sQOM9VpuG5bjT5xhrOZOOpFh29vr+DQ/Drs+VdJmjfEOHgX7FF8byiwVOmz3lf19dNu8
 pRA7+X3TDf84gHagZQQ4FQgtEgQrUN/6dYcedP3+NVTduPzrzv7DAJrf1uZhr1ERSh7n
 wAk76990PaVkxkPGAq0jmLgasLiVE7Om8g0k3AkXMkaJnW8Mzr/RxqcA67MSvV2kpvRF
 Ryqg==
X-Gm-Message-State: AOAM530uzB5CApDhpD33zFlbKMfK5tbCUr3/r++3YLes6qTUfSNXl/bq
 UQLaYlvKrpQSfuGeD5aTQFcpMNQbWm5dt/eI
X-Google-Smtp-Source: ABdhPJyvcNPlcWAY3yg4tY7x9RKLNGa/geIoP+1G/PxN4/Y/UZd7PrtA5gQVC/aHLOBX8N659iaxdw==
X-Received: by 2002:a17:90b:360a:: with SMTP id
 ml10mr7093250pjb.198.1600328901169; 
 Thu, 17 Sep 2020 00:48:21 -0700 (PDT)
Received: from localhost.localdomain ([115.96.122.113])
 by smtp.googlemail.com with ESMTPSA id y3sm20572516pfb.18.2020.09.17.00.48.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Sep 2020 00:48:20 -0700 (PDT)
From: Ani Sinha <ani@anisinha.ca>
To: qemu-devel@nongnu.org
Subject: [PATCH v6 07/12] tests/acpi: unit test for
 'acpi-pci-hotplug-with-bridge-support' bridge flag
Date: Thu, 17 Sep 2020 13:17:27 +0530
Message-Id: <20200917074733.13612-8-ani@anisinha.ca>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200917074733.13612-1-ani@anisinha.ca>
References: <20200917074733.13612-1-ani@anisinha.ca>
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



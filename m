Return-Path: <SRS0=/zFi=CU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC0F6C433E2
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2020 18:11:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 36E62207FB
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2020 18:11:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=anisinha-ca.20150623.gappssmtp.com header.i=@anisinha-ca.20150623.gappssmtp.com header.b="Y3sDZ+MC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 36E62207FB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=anisinha.ca
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49306 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kGnWV-0007gX-9A
	for qemu-devel@archiver.kernel.org; Fri, 11 Sep 2020 14:11:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53990)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ani@anisinha.ca>) id 1kGnTZ-00037c-1f
 for qemu-devel@nongnu.org; Fri, 11 Sep 2020 14:08:45 -0400
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:40886)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ani@anisinha.ca>) id 1kGnTX-0005yD-Kr
 for qemu-devel@nongnu.org; Fri, 11 Sep 2020 14:08:44 -0400
Received: by mail-pg1-x542.google.com with SMTP id j34so7191102pgi.7
 for <qemu-devel@nongnu.org>; Fri, 11 Sep 2020 11:08:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=anisinha-ca.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=ppZphd05C86FqB7ckX7fxnS8pQWDT9kE9aEVt6BaDW8=;
 b=Y3sDZ+MCsragt3kOoiWr5zqXDdx4h/ifpmiN+wTsoNtrqqVMJzaOOgXeiAmpDZCiI1
 ljBqWWD3juHfHdBTaaC8fWDFe24n5qkHn74v9N7pqm6dxH3Rg3mLWcMOkeBnkw02ohFd
 iuu4RqpS2elB9SoMeQIYkYraUucdkzBETnlfk/Ioljb2YVyVR7EWJnujAogylxDhE5Ae
 clEk98i6WFifZwwveXyRkTrq3j/DWFa4HmgZKGynebxmSTX5z8fZ7kdgFb+1jjX6Y/Lm
 QngcpzClBjV5LAgiuLtctlznitkFiBByBlCXC/QVguFgq/NAkiz1iWe3jXkw/80BUFN4
 Lpgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=ppZphd05C86FqB7ckX7fxnS8pQWDT9kE9aEVt6BaDW8=;
 b=B6rH6iXRIUCN3i9Lo8m+09m06rzhmmpx4lbo4rElCG4K/ZHVAiRn9CQ7e7bUnuRGjv
 eJeGnQ9xa9U7b43mPnNq57y2axDRVrfRylAjhok/ekSeD7jdInBt86RszFYAkGv8mA9U
 vaLFT4utH7EwkRh5bdKF+018M1xPZ2lFZSMvsJ+wk2KfH1EUhNq4zjk/aXitZEZEE0dX
 y5/OoHOw8uDUcYFfgjCU5Os4Vs960s332QlsxN/4x3FL1225G+RfTdkuDLNCZTEF1a/W
 fZpQHfXI9K9OJKeQWUQCx9rb53pA1Od1Q7rvb685tHzsMsSHxzYfgOYeuwlT1aOP2KYX
 1DdA==
X-Gm-Message-State: AOAM531RNM4wSZq6MV3CPsxjX70xqUQkGcMhWmzdVgtDjunS7V/ilXa9
 L1juTHCD3KEECMFk0Rmf7Q/mN2afarZMww==
X-Google-Smtp-Source: ABdhPJy/ODe5yruky77As3yPf/mXwlsL4S/fE0e7DNdDOXM+rLiKTOIwF7bFvP29nWoOPqsTB03qMQ==
X-Received: by 2002:a63:60e:: with SMTP id 14mr2449177pgg.343.1599847721999;
 Fri, 11 Sep 2020 11:08:41 -0700 (PDT)
Received: from localhost.localdomain ([115.96.135.201])
 by smtp.googlemail.com with ESMTPSA id n9sm2929135pfu.163.2020.09.11.11.08.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Sep 2020 11:08:41 -0700 (PDT)
From: Ani Sinha <ani@anisinha.ca>
To: qemu-devel@nongnu.org
Subject: [PATCH 7/9] tests/acpi: unit test for
 'acpi-pci-hotplug-with-bridge-support' bridge flag
Date: Fri, 11 Sep 2020 23:37:53 +0530
Message-Id: <20200911180755.28409-7-ani@anisinha.ca>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200911180755.28409-1-ani@anisinha.ca>
References: <20200911180755.28409-1-ani@anisinha.ca>
Received-SPF: none client-ip=2607:f8b0:4864:20::542;
 envelope-from=ani@anisinha.ca; helo=mail-pg1-x542.google.com
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
bridges in i440fx. The flag can be used to turn off acpi based hotplug support
for all the slots of the pci bus.

Tested on the upstream qemu master branch.

Signed-off-by: Ani Sinha <ani@anisinha.ca>
---
 tests/qtest/bios-tables-test.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

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



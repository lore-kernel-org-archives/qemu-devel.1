Return-Path: <SRS0=/2J2=CK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 969A6C433E6
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 15:18:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5FE1C206FA
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 15:18:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=anisinha-ca.20150623.gappssmtp.com header.i=@anisinha-ca.20150623.gappssmtp.com header.b="EVghPcpf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5FE1C206FA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=anisinha.ca
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39410 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kD82z-0006db-JO
	for qemu-devel@archiver.kernel.org; Tue, 01 Sep 2020 11:18:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44586)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ani@anisinha.ca>) id 1kD7ut-0004LK-Jm
 for qemu-devel@nongnu.org; Tue, 01 Sep 2020 11:09:47 -0400
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:35628)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ani@anisinha.ca>) id 1kD7ur-0004aB-UK
 for qemu-devel@nongnu.org; Tue, 01 Sep 2020 11:09:47 -0400
Received: by mail-pg1-x542.google.com with SMTP id g29so837377pgl.2
 for <qemu-devel@nongnu.org>; Tue, 01 Sep 2020 08:09:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=anisinha-ca.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=WYlEF++H2fQB6p/zppKaZP8TTzNNhoD7egDkIjo/9Qo=;
 b=EVghPcpfln7FEO67mD2/mBrBEokAjOuOLMDAISgrrIhXUFWdws58qBzAkxePqe4CYv
 YzK/5IJni5gU8lBPpzJ9R7icsFNEyiskm5oVUBzHrjaP9+a3rkfW6NSnX9RTiV/6OBrK
 P2p4Fgp0reXsowIA9nQJlUEgbd/mkL4u6u0at1iDVfTz+4+VndhQy5c/uVezoNKqPLsS
 JU7WDhrtShtLyJRrsDuAvKTr9ZDHFrdFod4oQxRIrYLzs0T/za6ipasfDVz4IliX/WZ2
 QRRZvYe4Jeip32Is8yWDUCzAp61Baw4eXK6ajZhn2+kS/HR1/r+GxxjYywtEw1uluFpT
 4Bdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=WYlEF++H2fQB6p/zppKaZP8TTzNNhoD7egDkIjo/9Qo=;
 b=OSN0qDUgSJIsvfRumL0aiNogU9A/kKWALZG0aCJCrycAbNYMIvcbPANXE0mIDRo8ZU
 03hgzzUDnfz41toQ9IjEse06tm0CpxQle0iaj9i2KM1SYwSt+LB3bMtkkMxGzr5axbfd
 SmHdiXdY9Qy+5qGGTBNE4Xf1uxgPeTvJ+99t2Dy70mbyBRGkQQTHGTYzr5i5DL8p8lzm
 jTeJU+SEbH0KZJE9leS8TWZ2Xm0DNZ9hsMzxUv0kWG5bj+AMPLuHd+X12keD+OrZoT+N
 keVUszSdUj80sQPSs2KnOio9Cu2LhS0ikDqPiBZH8bXg9kJxI1ZSh3BDRYXae9LFcw1G
 BAIg==
X-Gm-Message-State: AOAM531tccsYZ8qs2sC+0W3MPS5QcqcLoROs0ZWghzz2D23Y3BlQ9mn9
 ZJSba8XX47754AQyiFQp2mZ7LpKPnvKx0O2F
X-Google-Smtp-Source: ABdhPJzJfZG1OzHRx+IvbSa2bdit+DgT/bJa9Dxb3fFH3EDW6XUNn2I8WagSxPzdULBceUr9hSKMyA==
X-Received: by 2002:aa7:9904:: with SMTP id z4mr2396130pff.32.1598972984108;
 Tue, 01 Sep 2020 08:09:44 -0700 (PDT)
Received: from localhost.localdomain ([203.163.237.89])
 by smtp.googlemail.com with ESMTPSA id gk19sm3315777pjb.2.2020.09.01.08.09.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Sep 2020 08:09:43 -0700 (PDT)
From: Ani Sinha <ani@anisinha.ca>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 2/3] tests/acpi: add a new unit test to test hotplug off/on
 feature on the root pci bus
Date: Tue,  1 Sep 2020 20:39:27 +0530
Message-Id: <20200901150928.12428-2-ani@anisinha.ca>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200901150928.12428-1-ani@anisinha.ca>
References: <20200901150928.12428-1-ani@anisinha.ca>
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

Ability to turn hotplug off on the pci root bus for i440fx was added in commit:
3d7e78aa7777f0 ("Introduce a new flag for i440fx to disable PCI hotplug on the root bus")

This change adds a unit test in order to test this feature.

This change has been tested against upstream qemu master branch on top of tag v5.1.0.

Signed-off-by: Ani Sinha <ani@anisinha.ca>
---
 tests/qtest/bios-tables-test.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/tests/qtest/bios-tables-test.c b/tests/qtest/bios-tables-test.c
index d49b3988ec..a2c0070306 100644
--- a/tests/qtest/bios-tables-test.c
+++ b/tests/qtest/bios-tables-test.c
@@ -709,6 +709,20 @@ static void test_acpi_piix4_tcg_bridge(void)
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
@@ -1102,6 +1116,7 @@ int main(int argc, char *argv[])
         qtest_add_func("acpi/q35/tpm-tis", test_acpi_q35_tcg_tpm_tis);
         qtest_add_func("acpi/piix4", test_acpi_piix4_tcg);
         qtest_add_func("acpi/piix4/bridge", test_acpi_piix4_tcg_bridge);
+        qtest_add_func("acpi/piix4/hotplug", test_acpi_piix4_root_hotplug);
         qtest_add_func("acpi/q35", test_acpi_q35_tcg);
         qtest_add_func("acpi/q35/bridge", test_acpi_q35_tcg_bridge);
         qtest_add_func("acpi/q35/mmio64", test_acpi_q35_tcg_mmio64);
-- 
2.17.1



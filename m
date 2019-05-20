Return-Path: <SRS0=S/IU=TU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91945C04AAC
	for <qemu-devel@archiver.kernel.org>; Mon, 20 May 2019 23:28:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6277E20863
	for <qemu-devel@archiver.kernel.org>; Mon, 20 May 2019 23:28:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6277E20863
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:43571 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hSri0-0005V2-IH
	for qemu-devel@archiver.kernel.org; Mon, 20 May 2019 19:28:44 -0400
Received: from eggs.gnu.org ([209.51.188.92]:45286)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1hSrRb-0008DP-4m
	for qemu-devel@nongnu.org; Mon, 20 May 2019 19:11:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1hSrRZ-0008S5-S3
	for qemu-devel@nongnu.org; Mon, 20 May 2019 19:11:47 -0400
Received: from mail-qk1-f175.google.com ([209.85.222.175]:38353)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1hSrRZ-0008QE-An
	for qemu-devel@nongnu.org; Mon, 20 May 2019 19:11:45 -0400
Received: by mail-qk1-f175.google.com with SMTP id a64so9929944qkg.5
	for <qemu-devel@nongnu.org>; Mon, 20 May 2019 16:11:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:date:from:to:cc:subject:message-id:references
	:mime-version:content-disposition:content-transfer-encoding
	:in-reply-to;
	bh=lzca6NWulS6pv/1tcVw0zN8HCANtPMpZRuX9LRkAXXI=;
	b=tJpPKSCKJUjUejcIY6RJqMT3CJtf/aeroQS8JA1sWkntwEQEFoTDMFaA+aN9g0MIbz
	C8UQGN14EDi/obd0CrrjpobrrsuNs3nqCly5BdYXG1nBtXm4NG7g3+fupnB0XQ4RJnuR
	5Or8K3gq+PZqNATpFUQT3VDVFjiOoHvjKUaio9tApv4lG3ZPDsfAo0IWHnscTjaZFdDH
	grzSAMajyKUYi+VKKgH7qKdjoby6e+SljCzg+5RDb/+3Bsn0AtbtSpcLglzt8M/4VtcX
	+8zIqSSkZ9Nb6Umjuz/w8prZhzFy/WXhCMdHisVu+Htl3RWH0y1T6EndCyUMgF6hYvIk
	XOcg==
X-Gm-Message-State: APjAAAWZ0wNMk1WM+NenojpzNXGxVnTwmmNh6SX/AZLPmYnj4/T2tz45
	h9eoDAu+XIktoJ1PF4F9co2sSqhHOUg=
X-Google-Smtp-Source: APXvYqypo3mfwbQCIO/xjKrZjsyanJ5E+pub0i73oSo2yJeKYLtW1CJTNzGbWPlK3edc5w1hywiIFw==
X-Received: by 2002:a37:2758:: with SMTP id n85mr23152878qkn.54.1558393901972; 
	Mon, 20 May 2019 16:11:41 -0700 (PDT)
Received: from redhat.com (pool-173-76-105-71.bstnma.fios.verizon.net.
	[173.76.105.71]) by smtp.gmail.com with ESMTPSA id
	c203sm8815719qkg.65.2019.05.20.16.11.40
	(version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
	Mon, 20 May 2019 16:11:41 -0700 (PDT)
Date: Mon, 20 May 2019 19:11:40 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Message-ID: <1556808723-226478-14-git-send-email-imammedo@redhat.com>
References: <20190520231008.20140-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190520231008.20140-1-mst@redhat.com>
X-Mailer: git-send-email 2.17.1.1206.gb667731e2e.dirty
X-Mutt-Fcc: =sent
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.222.175
Subject: [Qemu-devel] [PULL v2 34/36] tests: acpi: add simple arm/virt
 testcase
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Laurent Vivier <lvivier@redhat.com>,
	Peter Maydell <peter.maydell@linaro.org>,
	Thomas Huth <thuth@redhat.com>, Laszlo Ersek <lersek@redhat.com>,
	Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
	Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190520231140.RjlEt2AqzPUpn9g4faRfcJUR7ekfUeIYPjfYwZsx6t8@z>

From: Igor Mammedov <imammedo@redhat.com>

adds simple arm/virt test case that starts guest with
bios-tables-test.aarch64.iso.qcow2 boot image which
initializes UefiTestSupport* structure in RAM once
guest is booted.

 * see commit: tests: acpi: add acpi_find_rsdp_address_uefi() helper

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Laszlo Ersek <lersek@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-Id: <1556808723-226478-14-git-send-email-imammedo@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 tests/bios-tables-test.c | 18 ++++++++++++++++++
 tests/Makefile.include   |  1 +
 2 files changed, 19 insertions(+)

diff --git a/tests/bios-tables-test.c b/tests/bios-tables-test.c
index 39c1e24efd..eaa1b0cf62 100644
--- a/tests/bios-tables-test.c
+++ b/tests/bios-tables-test.c
@@ -810,6 +810,22 @@ static void test_acpi_piix4_tcg_dimm_pxm(void)
     test_acpi_tcg_dimm_pxm(MACHINE_PC);
 }
 
+static void test_acpi_virt_tcg(void)
+{
+    test_data data = {
+        .machine = "virt",
+        .accel = "tcg",
+        .uefi_fl1 = "pc-bios/edk2-aarch64-code.fd",
+        .uefi_fl2 = "pc-bios/edk2-arm-vars.fd",
+        .cd = "tests/data/uefi-boot-images/bios-tables-test.aarch64.iso.qcow2",
+        .ram_start = 0x40000000ULL,
+        .scan_len = 128ULL * 1024 * 1024,
+    };
+
+    test_acpi_one("-cpu cortex-a57", &data);
+    free_test_data(&data);
+}
+
 int main(int argc, char *argv[])
 {
     const char *arch = qtest_get_arch();
@@ -838,6 +854,8 @@ int main(int argc, char *argv[])
         qtest_add_func("acpi/q35/numamem", test_acpi_q35_tcg_numamem);
         qtest_add_func("acpi/piix4/dimmpxm", test_acpi_piix4_tcg_dimm_pxm);
         qtest_add_func("acpi/q35/dimmpxm", test_acpi_q35_tcg_dimm_pxm);
+    } else if (strcmp(arch, "aarch64") == 0) {
+        qtest_add_func("acpi/virt", test_acpi_virt_tcg);
     }
     ret = g_test_run();
     boot_sector_cleanup(disk);
diff --git a/tests/Makefile.include b/tests/Makefile.include
index 1865f6b322..5cf8bf4b8e 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -267,6 +267,7 @@ check-qtest-arm-y += tests/hexloader-test$(EXESUF)
 check-qtest-aarch64-y = tests/numa-test$(EXESUF)
 check-qtest-aarch64-y += tests/boot-serial-test$(EXESUF)
 check-qtest-aarch64-y += tests/migration-test$(EXESUF)
+check-qtest-aarch64-y += tests/bios-tables-test$(EXESUF)
 
 check-qtest-microblazeel-y += $(check-qtest-microblaze-y)
 
-- 
MST



Return-Path: <SRS0=3v23=UE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A462EC28CC5
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2019 20:14:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7E6382070B
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2019 20:14:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E6382070B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:49241 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hYcIK-0005EI-Id
	for qemu-devel@archiver.kernel.org; Wed, 05 Jun 2019 16:14:00 -0400
Received: from eggs.gnu.org ([209.51.188.92]:34217)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1hYc5h-0003KD-S3
	for qemu-devel@nongnu.org; Wed, 05 Jun 2019 16:00:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1hYc5g-00065P-G5
	for qemu-devel@nongnu.org; Wed, 05 Jun 2019 16:00:57 -0400
Received: from mail-qt1-f169.google.com ([209.85.160.169]:44850)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1hYc5c-00060D-KT
	for qemu-devel@nongnu.org; Wed, 05 Jun 2019 16:00:56 -0400
Received: by mail-qt1-f169.google.com with SMTP id x47so19468281qtk.11
	for <qemu-devel@nongnu.org>; Wed, 05 Jun 2019 13:00:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:date:from:to:cc:subject:message-id:references
	:mime-version:content-disposition:in-reply-to;
	bh=Az33VIQfAWUmZUJASY0fikCp9gImYMqs0VJ8kfQjk7U=;
	b=X+/d/ossCkXwDohitPGrg6j5VOBo+KAF/nF+Qgwy/QpJ47N1qyqLv4S9ayR1T51eWv
	AJ1ZjGMf3laUuj+kzj/ddXT9S2BIlEAMzuiRA1EV24jxFANF8vbQRjrwzxlowQzNh2I/
	R3Wenej+GGRyKt2Hzg1KJVACAteCF1hESzoH0G5gJz5s8P/bESIz6QoQ53SJBJENd2wn
	1h2FHkcDKcMa25AsX5j3EzxcP7NFcNgT8nLiViFijO/bFlF7qxjiHuamUraChg/LkvNe
	tXI78LF+pRs/S4GH7EJPhQrT+kYuRWNWKm4ClgP47zBMzD80VdmjTyn8GgD0EzdthJXI
	tJpg==
X-Gm-Message-State: APjAAAX8baNP1m9skyvqGZ8205sIdonBMsEd4nmEqv3RDg1tCMygRQ5p
	IstQLRqkgREJ1zRMNTMDz0AQmNvGUaQ=
X-Google-Smtp-Source: APXvYqzZS04ItuFifkanKA51ruc6aFeUN6uZFQXjoGmgvPNLHdmcOXVf/EZjUTj5P+PGixST+1uU7w==
X-Received: by 2002:a0c:eecd:: with SMTP id h13mr590230qvs.46.1559764850395;
	Wed, 05 Jun 2019 13:00:50 -0700 (PDT)
Received: from redhat.com (pool-100-0-197-103.bstnma.fios.verizon.net.
	[100.0.197.103]) by smtp.gmail.com with ESMTPSA id
	c30sm13847900qta.25.2019.06.05.13.00.49
	(version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
	Wed, 05 Jun 2019 13:00:49 -0700 (PDT)
Date: Wed, 5 Jun 2019 16:00:48 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Message-ID: <1559560929-260254-3-git-send-email-imammedo@redhat.com>
References: <20190605195913.12243-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
In-Reply-To: <20190605195913.12243-1-mst@redhat.com>
X-Mailer: git-send-email 2.17.1.1206.gb667731e2e.dirty
X-Mutt-Fcc: =sent
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.160.169
Subject: [Qemu-devel] [PULL v3 16/17] tests: acpi: add simple arm/virt
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
	Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
	Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190605200048.UjGag2FDaFO7f7BRZddN8_DGcPisXH3SuiH3EUASQEU@z>

From: Igor Mammedov <imammedo@redhat.com>

adds simple arm/virt test case that starts guest with
bios-tables-test.aarch64.iso.qcow2 boot image which
initializes UefiTestSupport* structure in RAM once
guest is booted.

 * see commit: tests: acpi: add acpi_find_rsdp_address_uefi() helper

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
Message-Id: <1559560929-260254-3-git-send-email-imammedo@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 tests/bios-tables-test.c                | 18 ++++++++++++++++++
 tests/Makefile.include                  |  4 ++++
 tests/data/acpi/rebuild-expected-aml.sh |  2 +-
 3 files changed, 23 insertions(+), 1 deletion(-)

diff --git a/tests/bios-tables-test.c b/tests/bios-tables-test.c
index 70895e1014..d80ea7f7f3 100644
--- a/tests/bios-tables-test.c
+++ b/tests/bios-tables-test.c
@@ -832,6 +832,22 @@ static void test_acpi_piix4_tcg_dimm_pxm(void)
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
@@ -860,6 +876,8 @@ int main(int argc, char *argv[])
         qtest_add_func("acpi/q35/numamem", test_acpi_q35_tcg_numamem);
         qtest_add_func("acpi/piix4/dimmpxm", test_acpi_piix4_tcg_dimm_pxm);
         qtest_add_func("acpi/q35/dimmpxm", test_acpi_q35_tcg_dimm_pxm);
+    } else if (strcmp(arch, "aarch64") == 0) {
+        qtest_add_func("acpi/virt", test_acpi_virt_tcg);
     }
     ret = g_test_run();
     boot_sector_cleanup(disk);
diff --git a/tests/Makefile.include b/tests/Makefile.include
index 1865f6b322..2334969f1f 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -267,6 +267,10 @@ check-qtest-arm-y += tests/hexloader-test$(EXESUF)
 check-qtest-aarch64-y = tests/numa-test$(EXESUF)
 check-qtest-aarch64-y += tests/boot-serial-test$(EXESUF)
 check-qtest-aarch64-y += tests/migration-test$(EXESUF)
+# TODO: once aarch64 TCG is fixed on ARM 32 bit host, make test unconditional
+ifneq ($(ARCH),arm)
+check-qtest-aarch64-y += tests/bios-tables-test$(EXESUF)
+endif
 
 check-qtest-microblazeel-y += $(check-qtest-microblaze-y)
 
diff --git a/tests/data/acpi/rebuild-expected-aml.sh b/tests/data/acpi/rebuild-expected-aml.sh
index ff7e62249d..d2853218dd 100755
--- a/tests/data/acpi/rebuild-expected-aml.sh
+++ b/tests/data/acpi/rebuild-expected-aml.sh
@@ -12,7 +12,7 @@
 # This work is licensed under the terms of the GNU GPLv2.
 # See the COPYING.LIB file in the top-level directory.
 
-qemu_bins="x86_64-softmmu/qemu-system-x86_64"
+qemu_bins="x86_64-softmmu/qemu-system-x86_64 aarch64-softmmu/qemu-system-aarch64"
 
 if [ ! -e "tests/bios-tables-test" ]; then
     echo "Test: bios-tables-test is required! Run make check before this script."
-- 
MST



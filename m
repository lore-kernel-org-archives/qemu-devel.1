Return-Path: <SRS0=ZEKs=WJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FDDAC32750
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2019 21:13:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 27A83205C9
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2019 21:13:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 27A83205C9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55546 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hxe6W-0005h4-FD
	for qemu-devel@archiver.kernel.org; Tue, 13 Aug 2019 17:13:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42107)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <shameerali.kolothum.thodi@huawei.com>)
 id 1hxe1X-0005Ia-Dc
 for qemu-devel@nongnu.org; Tue, 13 Aug 2019 17:08:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <shameerali.kolothum.thodi@huawei.com>)
 id 1hxe1V-0001oO-Db
 for qemu-devel@nongnu.org; Tue, 13 Aug 2019 17:08:06 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:2253 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <shameerali.kolothum.thodi@huawei.com>)
 id 1hxe1P-0001dE-37; Tue, 13 Aug 2019 17:08:00 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.60])
 by Forcepoint Email with ESMTP id 0E3FEE996CB23ADEC89A;
 Wed, 14 Aug 2019 05:07:57 +0800 (CST)
Received: from S00345302A-PC.china.huawei.com (10.47.94.0) by
 DGGEMS409-HUB.china.huawei.com (10.3.19.209) with Microsoft SMTP Server id
 14.3.439.0; Wed, 14 Aug 2019 05:07:47 +0800
From: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
To: <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>, <eric.auger@redhat.com>,
 <imammedo@redhat.com>
Date: Tue, 13 Aug 2019 22:05:39 +0100
Message-ID: <20190813210539.31164-13-shameerali.kolothum.thodi@huawei.com>
X-Mailer: git-send-email 2.12.0.windows.1
In-Reply-To: <20190813210539.31164-1-shameerali.kolothum.thodi@huawei.com>
References: <20190813210539.31164-1-shameerali.kolothum.thodi@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.47.94.0]
X-CFilter-Loop: Reflected
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 45.249.212.191
Subject: [Qemu-devel] [PATCH-for-4.2 v9 12/12] tests: Add bios tests to
 arm/virt
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
Cc: peter.maydell@linaro.org, sameo@linux.intel.com, ard.biesheuvel@linaro.org,
 linuxarm@huawei.com, xuwei5@hisilicon.com, shannon.zhaosl@gmail.com,
 sebastien.boeuf@intel.com, lersek@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This adds numamem and memhp tests for arm/virt platform

Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
---
 tests/bios-tables-test-allowed-diff.h |  1 +
 tests/bios-tables-test.c              | 49 +++++++++++++++++++++++++++
 2 files changed, 50 insertions(+)

diff --git a/tests/bios-tables-test-allowed-diff.h b/tests/bios-tables-test-allowed-diff.h
index 7b4adbc822..d181a4da4a 100644
--- a/tests/bios-tables-test-allowed-diff.h
+++ b/tests/bios-tables-test-allowed-diff.h
@@ -1,2 +1,3 @@
 /* List of comma-separated changed AML files to ignore */
 "tests/data/acpi/virt/DSDT",
+"tests/data/acpi/virt/SRAT",
diff --git a/tests/bios-tables-test.c b/tests/bios-tables-test.c
index a356ac3489..1d6f330d53 100644
--- a/tests/bios-tables-test.c
+++ b/tests/bios-tables-test.c
@@ -871,6 +871,53 @@ static void test_acpi_piix4_tcg_dimm_pxm(void)
     test_acpi_tcg_dimm_pxm(MACHINE_PC);
 }
 
+static void test_acpi_virt_tcg_memhp(void)
+{
+    test_data data = {
+        .machine = "virt",
+        .accel = "tcg",
+        .uefi_fl1 = "pc-bios/edk2-aarch64-code.fd",
+        .uefi_fl2 = "pc-bios/edk2-arm-vars.fd",
+        .cd = "tests/data/uefi-boot-images/bios-tables-test.aarch64.iso.qcow2",
+        .ram_start = 0x40000000ULL,
+        .scan_len = 256ULL * 1024 * 1024,
+    };
+
+    data.variant = ".memhp";
+    test_acpi_one(" -cpu cortex-a57"
+                  " -m 256M,slots=3,maxmem=1G"
+                  " -object memory-backend-ram,id=ram0,size=128M"
+                  " -object memory-backend-ram,id=ram1,size=128M"
+                  " -numa node,memdev=ram0 -numa node,memdev=ram1"
+                  " -numa dist,src=0,dst=1,val=21",
+                  &data);
+
+    free_test_data(&data);
+
+}
+
+static void test_acpi_virt_tcg_numamem(void)
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
+    data.variant = ".numamem";
+    test_acpi_one(" -cpu cortex-a57"
+                  " -object memory-backend-ram,id=ram0,size=128M"
+                  " -numa node,memdev=ram0",
+                  &data);
+
+    free_test_data(&data);
+
+}
+
 static void test_acpi_virt_tcg(void)
 {
     test_data data = {
@@ -917,6 +964,8 @@ int main(int argc, char *argv[])
         qtest_add_func("acpi/q35/dimmpxm", test_acpi_q35_tcg_dimm_pxm);
     } else if (strcmp(arch, "aarch64") == 0) {
         qtest_add_func("acpi/virt", test_acpi_virt_tcg);
+        qtest_add_func("acpi/virt/numamem", test_acpi_virt_tcg_numamem);
+        qtest_add_func("acpi/virt/memhp", test_acpi_virt_tcg_memhp);
     }
     ret = g_test_run();
     boot_sector_cleanup(disk);
-- 
2.17.1




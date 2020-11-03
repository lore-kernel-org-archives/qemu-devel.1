Return-Path: <SRS0=IkQf=EJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87652C2D0A3
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 12:28:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F394F22243
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 12:28:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F394F22243
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44152 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kZvPx-0000M0-0J
	for qemu-devel@archiver.kernel.org; Tue, 03 Nov 2020 07:28:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47900)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cenjiahui@huawei.com>)
 id 1kZvIP-0008UR-Hi
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 07:20:17 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:2325)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cenjiahui@huawei.com>)
 id 1kZvIJ-00086B-Od
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 07:20:17 -0500
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.60])
 by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4CQTPd0hTZzkcWD;
 Tue,  3 Nov 2020 20:20:05 +0800 (CST)
Received: from localhost (10.174.184.155) by DGGEMS407-HUB.china.huawei.com
 (10.3.19.207) with Microsoft SMTP Server id 14.3.487.0; Tue, 3 Nov 2020
 20:19:59 +0800
From: Jiahui Cen <cenjiahui@huawei.com>
To: <qemu-devel@nongnu.org>
Subject: [PATCH v9 7/8] unit-test: Add testcase for pxb
Date: Tue, 3 Nov 2020 20:01:56 +0800
Message-ID: <20201103120157.2286-8-cenjiahui@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201103120157.2286-1-cenjiahui@huawei.com>
References: <20201103120157.2286-1-cenjiahui@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.174.184.155]
X-CFilter-Loop: Reflected
Received-SPF: pass client-ip=45.249.212.190; envelope-from=cenjiahui@huawei.com;
 helo=szxga04-in.huawei.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/03 04:56:56
X-ACL-Warn: Detected OS   = Linux 3.1-3.10 [fuzzy]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: xieyingtai@huawei.com, peter.maydell@linaro.org,
 Jiahui Cen <cenjiahui@huawei.com>, berrange@redhat.com, mst@redhat.com,
 xiexiangyou@huawei.com, shannon.zhaosl@gmail.com, miaoyubo@huawei.com,
 imammedo@redhat.com, lersek@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Yubo Miao <miaoyubo@huawei.com>

Add testcase for pxb to make sure the ACPI table is correct for guest.

Signed-off-by: Yubo Miao <miaoyubo@huawei.com>
Signed-off-by: Jiahui Cen <cenjiahui@huawei.com>
---
 tests/qtest/bios-tables-test.c | 58 ++++++++++++++++++++++++++++++----
 1 file changed, 52 insertions(+), 6 deletions(-)

diff --git a/tests/qtest/bios-tables-test.c b/tests/qtest/bios-tables-test.c
index f23a5335a8..64a9a772ee 100644
--- a/tests/qtest/bios-tables-test.c
+++ b/tests/qtest/bios-tables-test.c
@@ -671,12 +671,21 @@ static void test_acpi_one(const char *params, test_data *data)
          * TODO: convert '-drive if=pflash' to new syntax (see e33763be7cd3)
          * when arm/virt boad starts to support it.
          */
-        args = g_strdup_printf("-machine %s %s -accel tcg -nodefaults -nographic "
-            "-drive if=pflash,format=raw,file=%s,readonly "
-            "-drive if=pflash,format=raw,file=%s,snapshot=on -cdrom %s %s",
-            data->machine, data->tcg_only ? "" : "-accel kvm",
-            data->uefi_fl1, data->uefi_fl2, data->cd, params ? params : "");
-
+        if (data->cd) {
+            args = g_strdup_printf("-machine %s %s -accel tcg "
+                "-nodefaults -nographic "
+                "-drive if=pflash,format=raw,file=%s,readonly "
+                "-drive if=pflash,format=raw,file=%s,snapshot=on -cdrom %s %s",
+                data->machine, data->tcg_only ? "" : "-accel kvm",
+                data->uefi_fl1, data->uefi_fl2, data->cd, params ? params : "");
+        } else {
+            args = g_strdup_printf("-machine %s %s -accel tcg "
+                "-nodefaults -nographic "
+                "-drive if=pflash,format=raw,file=%s,readonly "
+                "-drive if=pflash,format=raw,file=%s,snapshot=on %s",
+                data->machine, data->tcg_only ? "" : "-accel kvm",
+                data->uefi_fl1, data->uefi_fl2, params ? params : "");
+        }
     } else {
         args = g_strdup_printf("-machine %s %s -accel tcg "
             "-net none -display none %s "
@@ -1176,6 +1185,40 @@ static void test_acpi_virt_tcg_numamem(void)
 
 }
 
+#ifdef CONFIG_PXB
+static void test_acpi_virt_tcg_pxb(void)
+{
+    test_data data = {
+        .machine = "virt",
+        .tcg_only = true,
+        .uefi_fl1 = "pc-bios/edk2-aarch64-code.fd",
+        .uefi_fl2 = "pc-bios/edk2-arm-vars.fd",
+        .ram_start = 0x40000000ULL,
+        .scan_len = 128ULL * 1024 * 1024,
+    };
+    /*
+     * While using -cdrom, the cdrom would auto plugged into pxb-pcie,
+     * the reason is the bus of pxb-pcie is also root bus, it would lead
+     * to the error only PCI/PCIE bridge could plug onto pxb.
+     * Therefore,thr cdrom is defined and plugged onto the scsi controller
+     * to solve the conflicts.
+     */
+    data.variant = ".pxb";
+    test_acpi_one(" -device pcie-root-port,chassis=1,id=pci.1"
+                  " -device virtio-scsi-pci,id=scsi0,bus=pci.1"
+                  " -drive file="
+                  "tests/data/uefi-boot-images/bios-tables-test.aarch64.iso.qcow2,"
+                  "if=none,media=cdrom,id=drive-scsi0-0-0-1,readonly=on"
+                  " -device scsi-cd,bus=scsi0.0,scsi-id=0,"
+                  "drive=drive-scsi0-0-0-1,id=scsi0-0-0-1,bootindex=1"
+                  " -cpu cortex-a57"
+                  " -device pxb-pcie,bus_nr=128",
+                  &data);
+
+    free_test_data(&data);
+}
+#endif
+
 static void test_acpi_tcg_acpi_hmat(const char *machine)
 {
     test_data data;
@@ -1287,6 +1330,9 @@ int main(int argc, char *argv[])
         qtest_add_func("acpi/virt", test_acpi_virt_tcg);
         qtest_add_func("acpi/virt/numamem", test_acpi_virt_tcg_numamem);
         qtest_add_func("acpi/virt/memhp", test_acpi_virt_tcg_memhp);
+#ifdef CONFIG_PXB
+        qtest_add_func("acpi/virt/pxb", test_acpi_virt_tcg_pxb);
+#endif
     }
     ret = g_test_run();
     boot_sector_cleanup(disk);
-- 
2.19.1



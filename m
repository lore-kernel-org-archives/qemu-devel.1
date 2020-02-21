Return-Path: <SRS0=IEfc=4J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	HK_RANDOM_FROM,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73795C35641
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2020 06:36:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3A9E020722
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2020 06:36:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A9E020722
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52802 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j51vl-0000uD-EU
	for qemu-devel@archiver.kernel.org; Fri, 21 Feb 2020 01:36:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38552)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <miaoyubo@huawei.com>) id 1j51uZ-0007xl-RJ
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 01:35:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <miaoyubo@huawei.com>) id 1j51uX-0003M6-LH
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 01:35:43 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:57170 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <miaoyubo@huawei.com>) id 1j51uX-0002xP-0l
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 01:35:41 -0500
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.59])
 by Forcepoint Email with ESMTP id B3AF4CA46EF783EE4248;
 Fri, 21 Feb 2020 14:35:30 +0800 (CST)
Received: from DESKTOP-D7EVK5B.china.huawei.com (10.173.221.29) by
 DGGEMS411-HUB.china.huawei.com (10.3.19.211) with Microsoft SMTP Server id
 14.3.439.0; Fri, 21 Feb 2020 14:35:24 +0800
From: Yubo Miao <miaoyubo@huawei.com>
To: <peter.maydell@linaro.org>, <shannon.zhaosl@gmail.com>
Subject: [RFC v3 3/3] ACPI/unit-test: Add a new test for pxb-pcie for arm
Date: Fri, 21 Feb 2020 14:35:12 +0800
Message-ID: <20200221063512.1104-4-miaoyubo@huawei.com>
X-Mailer: git-send-email 2.24.1.windows.2
In-Reply-To: <20200221063512.1104-1-miaoyubo@huawei.com>
References: <20200221063512.1104-1-miaoyubo@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.173.221.29]
X-CFilter-Loop: Reflected
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 45.249.212.32
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
Cc: imammedo@redhat.com, miaoyubo@huawei.com, qemu-devel@nongnu.org,
 xiexiangyou@huawei.com, mst@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: miaoyubo <miaoyubo@huawei.com>

Currently, pxb-pcie could be defined by the cmdline like
    --device pxb-pcie,id=3Dpci.9,bus_nr=3D128
However pxb-pcie is not described in acpi tables for arm.

The formal two patches support pxb-pcie for arm, escpcially the
specification for pxb-pcie in DSDT table.

Add a testcase to make sure the ACPI table is correct for guest.

Signed-off-by: miaoyubo <miaoyubo@huawei.com>
---
 tests/data/acpi/virt/DSDT.pxb  | Bin 0 -> 34209 bytes
 tests/qtest/bios-tables-test.c |  54 +++++++++++++++++++++++++++++----
 2 files changed, 48 insertions(+), 6 deletions(-)
 create mode 100644 tests/data/acpi/virt/DSDT.pxb

diff --git a/tests/data/acpi/virt/DSDT.pxb b/tests/data/acpi/virt/DSDT.px=
b
new file mode 100644
index 0000000000000000000000000000000000000000..4eea3192c75ff28f7054d626a=
9363ca025b6c0ad
GIT binary patch
literal 34209
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
M
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
SMdHR1??VvNE&R1)JoqmftDW!w

literal 0
HcmV?d00001

diff --git a/tests/qtest/bios-tables-test.c b/tests/qtest/bios-tables-tes=
t.c
index b4752c644c..91e91e0fec 100644
--- a/tests/qtest/bios-tables-test.c
+++ b/tests/qtest/bios-tables-test.c
@@ -620,12 +620,21 @@ static void test_acpi_one(const char *params, test_=
data *data)
          * TODO: convert '-drive if=3Dpflash' to new syntax (see e33763b=
e7cd3)
          * when arm/virt boad starts to support it.
          */
-        args =3D g_strdup_printf("-machine %s %s -accel tcg -nodefaults =
-nographic "
-            "-drive if=3Dpflash,format=3Draw,file=3D%s,readonly "
-            "-drive if=3Dpflash,format=3Draw,file=3D%s,snapshot=3Don -cd=
rom %s %s",
-            data->machine, data->tcg_only ? "" : "-accel kvm",
-            data->uefi_fl1, data->uefi_fl2, data->cd, params ? params : =
"");
-
+        if (data->cd) {
+            args =3D g_strdup_printf("-machine %s %s -accel tcg "
+                "-nodefaults -nographic "
+                "-drive if=3Dpflash,format=3Draw,file=3D%s,readonly "
+                "-drive if=3Dpflash,format=3Draw,file=3D%s,snapshot=3Don=
 -cdrom %s %s",
+                data->machine, data->tcg_only ? "" : "-accel kvm",
+                data->uefi_fl1, data->uefi_fl2, data->cd, params ? param=
s : "");
+        } else {
+            args =3D g_strdup_printf("-machine %s %s -accel tcg "
+                "-nodefaults -nographic "
+                "-drive if=3Dpflash,format=3Draw,file=3D%s,readonly "
+                "-drive if=3Dpflash,format=3Draw,file=3D%s,snapshot=3Don=
 %s",
+                data->machine, data->tcg_only ? "" : "-accel kvm",
+                data->uefi_fl1, data->uefi_fl2, params ? params : "");
+        }
     } else {
         /* Disable kernel irqchip to be able to override apic irq0. */
         args =3D g_strdup_printf("-machine %s,kernel-irqchip=3Doff %s -a=
ccel tcg "
@@ -960,6 +969,38 @@ static void test_acpi_virt_tcg_numamem(void)
=20
 }
=20
+static void test_acpi_virt_tcg_pxb(void)
+{
+    test_data data =3D {
+        .machine =3D "virt",
+        .tcg_only =3D true,
+        .uefi_fl1 =3D "pc-bios/edk2-aarch64-code.fd",
+        .uefi_fl2 =3D "pc-bios/edk2-arm-vars.fd",
+        .ram_start =3D 0x40000000ULL,
+        .scan_len =3D 128ULL * 1024 * 1024,
+    };
+    /*
+     * While using -cdrom, the cdrom would auto plugged into pxb-pcie,
+     * the reason is the bus of pxb-pcie is also root bus, it would lead
+     * to the error only PCI/PCIE bridge could plug onto pxb.
+     * Therefore,thr cdrom is defined and plugged onto the scsi controll=
er
+     * to solve the conflicts.
+     */
+    data.variant =3D ".pxb";
+    test_acpi_one(" -device pcie-root-port,chassis=3D1,id=3Dpci.1"
+                  " -device virtio-scsi-pci,id=3Dscsi0,bus=3Dpci.1"
+                  " -drive file=3D"
+                  "tests/data/uefi-boot-images/bios-tables-test.aarch64.=
iso.qcow2,"
+                  "if=3Dnone,media=3Dcdrom,id=3Ddrive-scsi0-0-0-1,readon=
ly=3Don"
+                  " -device scsi-cd,bus=3Dscsi0.0,scsi-id=3D0,"
+                  "drive=3Ddrive-scsi0-0-0-1,id=3Dscsi0-0-0-1,bootindex=3D=
1"
+                  " -cpu cortex-a57"
+                  " -device pxb-pcie,bus_nr=3D128",
+                  &data);
+
+    free_test_data(&data);
+}
+
 static void test_acpi_tcg_acpi_hmat(const char *machine)
 {
     test_data data;
@@ -1052,6 +1093,7 @@ int main(int argc, char *argv[])
         qtest_add_func("acpi/virt", test_acpi_virt_tcg);
         qtest_add_func("acpi/virt/numamem", test_acpi_virt_tcg_numamem);
         qtest_add_func("acpi/virt/memhp", test_acpi_virt_tcg_memhp);
+        qtest_add_func("acpi/virt/pxb", test_acpi_virt_tcg_pxb);
     }
     ret =3D g_test_run();
     boot_sector_cleanup(disk);
--=20
2.19.1




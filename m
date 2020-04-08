Return-Path: <SRS0=OEAU=5Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	HK_RANDOM_FROM,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C4D4C2D0EA
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Apr 2020 13:02:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1A83B206F7
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Apr 2020 13:02:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A83B206F7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35760 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jMALZ-00055L-7g
	for qemu-devel@archiver.kernel.org; Wed, 08 Apr 2020 09:02:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39784)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <miaoyubo@huawei.com>) id 1jMAI7-0008VT-Cb
 for qemu-devel@nongnu.org; Wed, 08 Apr 2020 08:58:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <miaoyubo@huawei.com>) id 1jMAI6-00058X-3r
 for qemu-devel@nongnu.org; Wed, 08 Apr 2020 08:58:51 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:36624 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <miaoyubo@huawei.com>) id 1jMAI4-00056U-Hw
 for qemu-devel@nongnu.org; Wed, 08 Apr 2020 08:58:50 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.60])
 by Forcepoint Email with ESMTP id E17F99C76415CB7F967B;
 Wed,  8 Apr 2020 20:58:44 +0800 (CST)
Received: from DESKTOP-D7EVK5B.china.huawei.com (10.173.221.29) by
 DGGEMS402-HUB.china.huawei.com (10.3.19.202) with Microsoft SMTP Server id
 14.3.487.0; Wed, 8 Apr 2020 20:58:36 +0800
From: Yubo Miao <miaoyubo@huawei.com>
To: <peter.maydell@linaro.org>, <shannon.zhaosl@gmail.com>, <lersek@redhat.com>
Subject: [PATCH v6 7/8] unit-test: Add testcase for pxb
Date: Wed, 8 Apr 2020 20:58:15 +0800
Message-ID: <20200408125816.955-8-miaoyubo@huawei.com>
X-Mailer: git-send-email 2.24.1.windows.2
In-Reply-To: <20200408125816.955-1-miaoyubo@huawei.com>
References: <20200408125816.955-1-miaoyubo@huawei.com>
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
Cc: berrange@redhat.com, mst@redhat.com, qemu-devel@nongnu.org,
 xiexiangyou@huawei.com, miaoyubo@huawei.com, imammedo@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: miaoyubo <miaoyubo@huawei.com>

Add testcase for pxb to make sure the ACPI table is correct for guest.

Signed-off-by: miaoyubo <miaoyubo@huawei.com>
---
 tests/qtest/bios-tables-test.c | 58 ++++++++++++++++++++++++++++++----
 1 file changed, 52 insertions(+), 6 deletions(-)

diff --git a/tests/qtest/bios-tables-test.c b/tests/qtest/bios-tables-tes=
t.c
index 0a597bbacf..4bba680917 100644
--- a/tests/qtest/bios-tables-test.c
+++ b/tests/qtest/bios-tables-test.c
@@ -621,12 +621,21 @@ static void test_acpi_one(const char *params, test_=
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
@@ -961,6 +970,40 @@ static void test_acpi_virt_tcg_numamem(void)
=20
 }
=20
+#ifdef CONFIG_PXB
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
+#endif
+
 static void test_acpi_tcg_acpi_hmat(const char *machine)
 {
     test_data data;
@@ -1053,6 +1096,9 @@ int main(int argc, char *argv[])
         qtest_add_func("acpi/virt", test_acpi_virt_tcg);
         qtest_add_func("acpi/virt/numamem", test_acpi_virt_tcg_numamem);
         qtest_add_func("acpi/virt/memhp", test_acpi_virt_tcg_memhp);
+#ifdef CONFIG_PXB
+        qtest_add_func("acpi/virt/pxb", test_acpi_virt_tcg_pxb);
+#endif
     }
     ret =3D g_test_run();
     boot_sector_cleanup(disk);
--=20
2.19.1




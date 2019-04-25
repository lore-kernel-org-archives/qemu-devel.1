Return-Path: <SRS0=VSQP=S3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDBC6C10F03
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Apr 2019 05:40:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AE64C217FA
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Apr 2019 05:40:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE64C217FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:52072 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hJX7m-0007T2-Uo
	for qemu-devel@archiver.kernel.org; Thu, 25 Apr 2019 01:40:46 -0400
Received: from eggs.gnu.org ([209.51.188.92]:47203)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1hJX3D-0003hD-Jp
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 01:36:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1hJX2F-0000K9-Kx
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 01:35:04 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43870)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1hJX2F-0000J5-D4
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 01:35:03 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
	[10.5.11.23])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 9E0DC319936D;
	Thu, 25 Apr 2019 05:35:02 +0000 (UTC)
Received: from dell-r430-03.lab.eng.brq.redhat.com
	(dell-r430-03.lab.eng.brq.redhat.com [10.37.153.18])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 9CEB119491;
	Thu, 25 Apr 2019 05:35:00 +0000 (UTC)
From: Igor Mammedov <imammedo@redhat.com>
To: qemu-devel@nongnu.org
Date: Thu, 25 Apr 2019 07:34:47 +0200
Message-Id: <1556170489-131927-12-git-send-email-imammedo@redhat.com>
In-Reply-To: <1556170489-131927-1-git-send-email-imammedo@redhat.com>
References: <1556170489-131927-1-git-send-email-imammedo@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.41]);
	Thu, 25 Apr 2019 05:35:02 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v3 11/13] tests: acpi: add simple arm/virt
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
Cc: Andrew Jones <drjones@redhat.com>, Ben Warren <ben@skyportsystems.com>,
	"Michael S. Tsirkin" <mst@redhat.com>, Laszlo Ersek <lersek@redhat.com>,
	Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
	Shannon Zhao <shannon.zhaosl@gmail.com>, Gonglei <arei.gonglei@huawei.com>,
	Wei Yang <richardw.yang@linux.intel.com>,
	=?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190425053447.hlyZqC5z4-AzmqlGzU9_rI9cXy4ZcHn7aXS9aMTNYSc@z>

adds simple arm/virt test case that starts guest with
bios-tables-test.aarch64.iso.qcow2 boot image which
initializes UefiTestSupport* structure in RAM once
guest is booted.

 * see commit: tests: acpi: add acpi_find_rsdp_address_uefi() helper

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Laszlo Ersek <lersek@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
---
v3:
  * use firmware blobs directly from pc-bios directory
  * use bios-tables-test.aarch64.iso.qcow2 as test boot image
  * drop leftover qtest-uefi-images-aarch64 iMakefile rule from
    previos version (Laszlo)
  * add Makefile rule to include bios-tables-test into
    check-qtest-aarch64 target
v2:
  * specify in test_data where board's RAM starts and RAM size
---
 tests/Makefile.include   |  1 +
 tests/bios-tables-test.c | 17 +++++++++++++++++
 2 files changed, 18 insertions(+)

diff --git a/tests/Makefile.include b/tests/Makefile.include
index e2432d5..983c8b1 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -267,6 +267,7 @@ check-qtest-arm-y +=3D tests/hexloader-test$(EXESUF)
 check-qtest-aarch64-y =3D tests/numa-test$(EXESUF)
 check-qtest-aarch64-y +=3D tests/boot-serial-test$(EXESUF)
 check-qtest-aarch64-y +=3D tests/migration-test$(EXESUF)
+check-qtest-aarch64-y +=3D tests/bios-tables-test$(EXESUF)
=20
 check-qtest-microblazeel-y +=3D $(check-qtest-microblaze-y)
=20
diff --git a/tests/bios-tables-test.c b/tests/bios-tables-test.c
index 1be55a1..f117461 100644
--- a/tests/bios-tables-test.c
+++ b/tests/bios-tables-test.c
@@ -812,6 +812,21 @@ static void test_acpi_piix4_tcg_dimm_pxm(void)
     test_acpi_tcg_dimm_pxm(MACHINE_PC);
 }
=20
+static void test_acpi_virt_tcg(void)
+{
+    test_data data =3D {
+        .machine =3D "virt",
+        .uefi_fl1 =3D "pc-bios/edk2-aarch64-code.fd",
+        .uefi_fl2 =3D "pc-bios/edk2-arm-vars.fd",
+        .cd =3D "tests/data/uefi-boot-images/bios-tables-test.aarch64.is=
o.qcow2",
+        .ram_start =3D 0x40000000ULL,
+        .scan_len =3D 128ULL * 1024 * 1024,
+    };
+
+    test_acpi_one("-cpu cortex-a57 ", &data);
+    free_test_data(&data);
+}
+
 int main(int argc, char *argv[])
 {
     const char *arch =3D qtest_get_arch();
@@ -840,6 +855,8 @@ int main(int argc, char *argv[])
         qtest_add_func("acpi/q35/numamem", test_acpi_q35_tcg_numamem);
         qtest_add_func("acpi/piix4/dimmpxm", test_acpi_piix4_tcg_dimm_px=
m);
         qtest_add_func("acpi/q35/dimmpxm", test_acpi_q35_tcg_dimm_pxm);
+    } else if (strcmp(arch, "aarch64") =3D=3D 0) {
+        qtest_add_func("acpi/virt", test_acpi_virt_tcg);
     }
     ret =3D g_test_run();
     boot_sector_cleanup(disk);
--=20
2.7.4



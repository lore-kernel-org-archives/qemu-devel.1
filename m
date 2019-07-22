Return-Path: <SRS0=EA86=VT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D13B8C76188
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2019 14:52:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A46A121951
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2019 14:52:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A46A121951
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34284 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hpZfv-0006mK-SP
	for qemu-devel@archiver.kernel.org; Mon, 22 Jul 2019 10:52:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41669)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <shameerali.kolothum.thodi@huawei.com>)
 id 1hpZfi-0006Gg-76
 for qemu-devel@nongnu.org; Mon, 22 Jul 2019 10:52:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <shameerali.kolothum.thodi@huawei.com>)
 id 1hpZfg-0006Zj-QQ
 for qemu-devel@nongnu.org; Mon, 22 Jul 2019 10:52:14 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:45427 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <shameerali.kolothum.thodi@huawei.com>)
 id 1hpZfd-0006Wh-MT; Mon, 22 Jul 2019 10:52:09 -0400
Received: from lhreml704-cah.china.huawei.com (unknown [172.18.7.106])
 by Forcepoint Email with ESMTP id A9DC7F5A38973C54E288;
 Mon, 22 Jul 2019 15:52:06 +0100 (IST)
Received: from LHREML524-MBS.china.huawei.com ([169.254.2.132]) by
 lhreml704-cah.china.huawei.com ([10.201.108.45]) with mapi id 14.03.0415.000; 
 Mon, 22 Jul 2019 15:51:59 +0100
From: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
To: Igor Mammedov <imammedo@redhat.com>
Thread-Topic: [Qemu-devel] [PATCH-for-4.2 v7 10/10] tests: Update DSDT ACPI
 table for arm/virt board with PCDIMM related changes
Thread-Index: AQHVPWqzRM4xLYQgEESkRt3zEbbqr6bWtTVQ
Date: Mon, 22 Jul 2019 14:51:59 +0000
Message-ID: <5FC3163CFD30C246ABAA99954A238FA83F310B0C@lhreml524-mbs.china.huawei.com>
References: <20190716153816.17676-1-shameerali.kolothum.thodi@huawei.com>
 <20190716153816.17676-11-shameerali.kolothum.thodi@huawei.com>
 <20190718151315.2c1d3aff@redhat.com>
In-Reply-To: <20190718151315.2c1d3aff@redhat.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.202.227.237]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-CFilter-Loop: Reflected
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 185.176.76.210
Subject: Re: [Qemu-devel] [PATCH-for-4.2 v7 10/10] tests: Update DSDT ACPI
 table for arm/virt board with PCDIMM related changes
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
Cc: "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 "sameo@linux.intel.com" <sameo@linux.intel.com>,
 "ard.biesheuvel@linaro.org" <ard.biesheuvel@linaro.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Linuxarm <linuxarm@huawei.com>,
 "shannon.zhaosl@gmail.com" <shannon.zhaosl@gmail.com>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, "xuwei \(O\)" <xuwei5@huawei.com>,
 "sebastien.boeuf@intel.com" <sebastien.boeuf@intel.com>,
 "lersek@redhat.com" <lersek@redhat.com>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Igor,

> -----Original Message-----
> From: Qemu-devel
> [mailto:qemu-devel-bounces+shameerali.kolothum.thodi=3Dhuawei.com@nongn
> u.org] On Behalf Of Igor Mammedov
> Sent: 18 July 2019 14:13
> To: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
> Cc: peter.maydell@linaro.org; sameo@linux.intel.com;
> shannon.zhaosl@gmail.com; ard.biesheuvel@linaro.org;
> qemu-devel@nongnu.org; xuwei (O) <xuwei5@huawei.com>; Linuxarm
> <linuxarm@huawei.com>; eric.auger@redhat.com; qemu-arm@nongnu.org;
> sebastien.boeuf@intel.com; lersek@redhat.com
> Subject: Re: [Qemu-devel] [PATCH-for-4.2 v7 10/10] tests: Update DSDT ACP=
I
> table for arm/virt board with PCDIMM related changes
>=20
> On Tue, 16 Jul 2019 16:38:16 +0100
> Shameer Kolothum <shameerali.kolothum.thodi@huawei.com> wrote:
>=20
> > From: Eric Auger <eric.auger@redhat.com>
> >
> > PCDIMM hotplug addition updated the DSDT. Update the reference table.
>=20
> it's not correct process. series should be merged through Michael's pci b=
ranch
> and see
> commit ab50f22309a17c772c51931940596e707c200739 (mst/pci)
> Author: Michael S. Tsirkin <mst@redhat.com>
> Date:   Tue May 21 17:38:47 2019 -0400
>=20
>     bios-tables-test: add diff allowed list
>=20
> how to request table update.

Ok. Just to confirm, this means I can probably add the below diff to patch =
#6 and
remove this patch(10/10) from the series.=20

diff --git a/tests/bios-tables-test-allowed-diff.h b/tests/bios-tables-test=
-allowed-diff.h
index dfb8523c8b..7b4adbc822 100644
--- a/tests/bios-tables-test-allowed-diff.h
+++ b/tests/bios-tables-test-allowed-diff.h
@@ -1 +1,2 @@
 /* List of comma-separated changed AML files to ignore */
+"tests/data/acpi/virt/DSDT",

>=20
> Another thing:
> bios-tables-test has test_acpi_tcg_dimm_pxm() test case,
> pls make use of it to test arm/virt variant

I had a go with this, but has found an issue with this.

This is what I added in order to run the dimm_pxm test.

- - 8- -

diff --git a/tests/bios-tables-test.c b/tests/bios-tables-test.c
index a356ac3489..79af4f4874 100644
--- a/tests/bios-tables-test.c
+++ b/tests/bios-tables-test.c
@@ -871,6 +871,36 @@ static void test_acpi_piix4_tcg_dimm_pxm(void)
     test_acpi_tcg_dimm_pxm(MACHINE_PC);
 }
=20
+static void test_acpi_virt_tcg_dimm_pxm(void)
+{
+    test_data data =3D {
+        .machine =3D "virt",
+        .accel =3D "tcg",
+        .uefi_fl1 =3D "pc-bios/edk2-aarch64-code.fd",
+        .uefi_fl2 =3D "pc-bios/edk2-arm-vars.fd",
+        .cd =3D "tests/data/uefi-boot-images/bios-tables-test.aarch64.iso.=
qcow2",
+        .ram_start =3D 0x40000000ULL,
+        .scan_len =3D 128ULL * 1024 * 1024,
+    };
+
+    data.variant =3D ".dimmpxm";
+    test_acpi_one(" -cpu cortex-a57"
+                  " -smp 4"
+                  " -m 512M,slots=3D3,maxmem=3D2G"
+                  " -object memory-backend-ram,id=3Dram0,size=3D128M"
+                  " -object memory-backend-ram,id=3Dram1,size=3D128M"
+                  " -object memory-backend-ram,id=3Dram2,size=3D128M"
+                  " -object memory-backend-ram,id=3Dram3,size=3D128M"
+                  " -numa node,memdev=3Dram0,nodeid=3D0"
+                  " -numa node,memdev=3Dram1,nodeid=3D1"
+                  " -numa node,memdev=3Dram2,nodeid=3D2"
+                  " -numa node,memdev=3Dram3,nodeid=3D3"
+                  " -object memory-backend-ram,id=3Dram4,size=3D1G"
+                  " -device pc-dimm,id=3Ddimm0,memdev=3Dram4,node=3D0",
+                  &data);
+    free_test_data(&data);
+}
+
 static void test_acpi_virt_tcg(void)
 {
     test_data data =3D {
@@ -917,6 +947,7 @@ int main(int argc, char *argv[])
         qtest_add_func("acpi/q35/dimmpxm", test_acpi_q35_tcg_dimm_pxm);
     } else if (strcmp(arch, "aarch64") =3D=3D 0) {
         qtest_add_func("acpi/virt", test_acpi_virt_tcg);
+        qtest_add_func("acpi/virt/dimmpxm", test_acpi_virt_tcg_dimm_pxm);
     }
     ret =3D g_test_run();
     boot_sector_cleanup(disk);

- - 8- -

Then used the script to generate the acpi tables and "make check" runs fine=
.

But when I changed the memory configuration to,

test_acpi_one(" -cpu cortex-a57"
            " -smp 4"
            " -m 256M,slots=3D3,maxmem=3D2G"
            " -object memory-backend-ram,id=3Dram0,size=3D64M"
            " -object memory-backend-ram,id=3Dram1,size=3D64M"
            " -object memory-backend-ram,id=3Dram2,size=3D64M"
            " -object memory-backend-ram,id=3Dram3,size=3D64M"
            " -numa node,memdev=3Dram0,nodeid=3D0"
            " -numa node,memdev=3Dram1,nodeid=3D1"
            " -numa node,memdev=3Dram2,nodeid=3D2"
            " -numa node,memdev=3Dram3,nodeid=3D3"
            " -object memory-backend-ram,id=3Dram4,size=3D1G"
            " -device pc-dimm,id=3Ddimm0,memdev=3Dram4,node=3D0",
            &data);

"make check" gets stuck at,

  CC      tests/bios-tables-test.o
  LINK    tests/bios-tables-test
  TEST    check-qtest-aarch64: tests/numa-test
  TEST    check-qtest-aarch64: tests/boot-serial-test
  TEST    check-qtest-aarch64: tests/migration-test
  TEST    check-qtest-aarch64: tests/bios-tables-test -->stuck here.

But if I use the same memory configuration and run the qemu guest independe=
ntly
it boots fine.

./qemu-system-aarch64 -machine virt,accel=3Dtcg \
-cpu cortex-a57 \
-nographic -smp 4 \
-bios QEMU_EFI_Release.fd \
-kernel Image_5.2rc2 \
-drive if=3Dnone,file=3Dubuntu-est-5.0,id=3Dfs \
-device virtio-blk-device,drive=3Dfs \
-m 256M,slots=3D3,maxmem=3D2G \
-object memory-backend-ram,id=3Dram0,size=3D64M \
-object memory-backend-ram,id=3Dram1,size=3D64M \
-object memory-backend-ram,id=3Dram2,size=3D64M \
-object memory-backend-ram,id=3Dram3,size=3D64M \
-numa node,memdev=3Dram0,nodeid=3D0 \
-numa node,memdev=3Dram1,nodeid=3D1 \
-numa node,memdev=3Dram2,nodeid=3D2 \
-numa node,memdev=3Dram3,nodeid=3D3 \
-object memory-backend-ram,id=3Dram4,size=3D1G \
-device pc-dimm,id=3Ddimm1,memdev=3Dram4,node=3D0 \
-append "console=3DttyAMA0 root=3D/dev/vda rw acpi=3Dforce"
=20
root@ubuntu:~# numactl -H
available: 4 nodes (0-3)
node 0 cpus: 0
node 0 size: 1067 MB
node 0 free: 1015 MB
node 1 cpus: 1
node 1 size: 44 MB
node 1 free: 5 MB
node 2 cpus: 2
node 2 size: 63 MB
node 2 free: 24 MB
node 3 cpus: 3
node 3 size: 63 MB
node 3 free: 31 MB
node distances:
node   0   1   2   3=20
  0:  10  20  20  20=20
  1:  20  10  20  20=20
  2:  20  20  10  20=20
  3:  20  20  20  10=20
root@ubuntu:~#

I am not sure why "make check" hangs with 64M size!.=20
Please take a look and let me know if I missed anything obvious here.

Thanks,
Shameer


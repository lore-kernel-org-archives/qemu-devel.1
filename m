Return-Path: <SRS0=192v=3S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C73E3C33CB2
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2020 11:52:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9C2602070E
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2020 11:52:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C2602070E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44942 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwltA-0003Y3-PS
	for qemu-devel@archiver.kernel.org; Wed, 29 Jan 2020 06:52:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44963)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <salil.mehta@huawei.com>) id 1iwlsS-00032e-Rv
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 06:51:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <salil.mehta@huawei.com>) id 1iwlsR-00075F-OP
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 06:51:24 -0500
Received: from lhrrgout.huawei.com ([185.176.76.210]:2068 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <salil.mehta@huawei.com>)
 id 1iwlsO-0006y7-RJ; Wed, 29 Jan 2020 06:51:20 -0500
Received: from lhreml701-cah.china.huawei.com (unknown [172.18.7.106])
 by Forcepoint Email with ESMTP id E57DE94688458C62FB6F;
 Wed, 29 Jan 2020 11:51:14 +0000 (GMT)
Received: from lhreml703-chm.china.huawei.com (10.201.108.52) by
 lhreml701-cah.china.huawei.com (10.201.108.42) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Wed, 29 Jan 2020 11:51:14 +0000
Received: from lhreml703-chm.china.huawei.com (10.201.108.52) by
 lhreml703-chm.china.huawei.com (10.201.108.52) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1713.5; Wed, 29 Jan 2020 11:51:14 +0000
Received: from lhreml703-chm.china.huawei.com ([10.201.68.198]) by
 lhreml703-chm.china.huawei.com ([10.201.68.198]) with mapi id 15.01.1713.004; 
 Wed, 29 Jan 2020 11:51:14 +0000
From: Salil Mehta <salil.mehta@huawei.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-arm@nongnu.org"
 <qemu-arm@nongnu.org>
Subject: [Question] Regarding presence of duplicate ACPI CPU entries at two
 nodes \\_SB.CXXX and \\_SB.CPUS.CXXX  of namespace
Thread-Topic: [Question] Regarding presence of duplicate ACPI CPU entries at
 two nodes \\_SB.CXXX and \\_SB.CPUS.CXXX  of namespace
Thread-Index: AdXWmXYiOGpNwkpgSDKkSEKdULrKCQ==
Date: Wed, 29 Jan 2020 11:51:14 +0000
Message-ID: <590fb35353de473d9c689caead95c659@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.202.227.103]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-CFilter-Loop: Reflected
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 185.176.76.210
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
 "drjones@redhat.com" <drjones@redhat.com>,
 "sameo@linux.intel.com" <sameo@linux.intel.com>,
 "mst@redhat.com" <mst@redhat.com>, Linuxarm <linuxarm@huawei.com>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>,
 pbonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 "lersek@redhat.com" <lersek@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hello,

Observation:
If we launch Linux Guest VM using QEMU(running on any type host. I am using=
 x86) with
CPU based on any ARM64 architecture then I could see QEMU populating ACPI n=
odes
related to same CPU at 2 places of the ACPI namespace:
1. \\_SB.CXXX
2. \\_SB.CPUS.CXXX=20

Above results in Guest VM showing duplicate CPU entries in the sysfs for th=
e same CPUS.
I could make out the entries under \\_SB.CPUS.XXX are part of the container=
.

estuary:/$ ls -al /sys/bus/acpi/devices/

Observation 1: (belongs to \\_SB.C00X)
ACPI0007:00 -> ../../../devices/LNXSYSTM:00/LNXSYBUS:00/ACPI0007:00=20
ACPI0007:01 -> ../../../devices/LNXSYSTM:00/LNXSYBUS:00/ACPI0007:01
ACPI0007:02 -> ../../../devices/LNXSYSTM:00/LNXSYBUS:00/ACPI0007:02
ACPI0007:03 -> ../../../devices/LNXSYSTM:00/LNXSYBUS:00/ACPI0007:03
ACPI0007:04 -> ../../../devices/LNXSYSTM:00/LNXSYBUS:00/ACPI0007:04
ACPI0007:05 -> ../../../devices/LNXSYSTM:00/LNXSYBUS:00/ACPI0007:05

Observation 2: (belongs to \\_SB.CPUS.C00X and under container ACPI0010:00 =
part of \\_SB.CPUS)
ACPI0007:06 -> ../../../devices/LNXSYSTM:00/LNXSYBUS:00/ACPI0010:00/ACPI000=
7:06 =20
ACPI0007:07 -> ../../../devices/LNXSYSTM:00/LNXSYBUS:00/ACPI0010:00/ACPI000=
7:07=20
ACPI0007:08 -> ../../../devices/LNXSYSTM:00/LNXSYBUS:00/ACPI0010:00/ACPI000=
7:08
ACPI0007:09 -> ../../../devices/LNXSYSTM:00/LNXSYBUS:00/ACPI0010:00/ACPI000=
7:09
ACPI0007:0a -> ../../../devices/LNXSYSTM:00/LNXSYBUS:00/ACPI0010:00/ACPI000=
7:0a
ACPI0007:0b -> ../../../devices/LNXSYSTM:00/LNXSYBUS:00/ACPI0010:00/ACPI000=
7:0b
ACPI0010:00 -> ../../../devices/LNXSYSTM:00/LNXSYBUS:00/ACPI0010:00


estuary:/$ cat /sys/bus/acpi/devices/ACPI0010\:00/path=20
\_SB_.CPUS

estuary:/$ cat /sys/bus/acpi/devices/ACPI0007\:00/uid=20
0
estuary:/$ cat /sys/bus/acpi/devices/ACPI0007\:00/path
\_SB_.C000

estuary:/$ cat /sys/bus/acpi/devices/ACPI0007\:06/uid=20
0
estuary:/$ cat /sys/bus/acpi/devices/ACPI0007\:06/path
\_SB_.CPUS.C000



QEMU Code Excerpt:
I could trace with in QEMU AML code, the CPUS are being appended at 2 place=
s:


Code 1. File: hw/arm/virt-acpi-build.c (Cause of Observation 1 i.e. \\_SB.C=
XXX )

static void acpi_dsdt_add_cpus(Aml *scope, int smp_cpus)
{
    uint16_t i;

    for (i =3D 0; i < smp_cpus; i++) { --->{should be possible cpus anyways=
}
        Aml *dev =3D aml_device("C%.03X", i);
        aml_append(dev, aml_name_decl("_HID", aml_string("ACPI0007")));
        aml_append(dev, aml_name_decl("_UID", aml_int(i)));
        aml_append(scope, dev);
    }
}


Code 2. File: hw/acpi/cpu.c (Cause of Observation 2 i.e. \\_SB.CPUS.CXXX)

void build_cpus_aml(..)
{
[...]
  cpus_dev =3D aml_device("\\_SB.CPUS");
  {
    [...]
            /* build Processor object for each processor */
        for (i =3D 0; i < arch_ids->len; i++) {
            Aml *dev;
            Aml *uid =3D aml_int(i);
            GArray *madt_buf =3D g_array_new(0, 1, 1);
            int arch_id =3D arch_ids->cpus[i].arch_id;

            if (opts.acpi_1_compatible && arch_id < 255) {
                dev =3D aml_processor(i, 0, 0, CPU_NAME_FMT, i);
            } else {
                dev =3D aml_device(CPU_NAME_FMT, i);
                aml_append(dev, aml_name_decl("_HID", aml_string("ACPI0007"=
)));
                aml_append(dev, aml_name_decl("_UID", uid));
            }
    [...]
  }   =20
[...]
}



Questions:
Q1. I could not understand the purpose of keeping acpi_dsdt_add_cpus() afte=
r the code 2.
     was introduced as part of the below change and which is already adding=
 CPUS related
     AML to \\_SB.CPUS namespace?

acpi: cpuhp: add CPU devices AML with _STA method
commit 5e1b5d93887b52eede156f846b6c4c5c8bbcfcdb

Q2. Do we really require CPUs being added by acpi_dsdt_add_cpus() in \\_SB.=
CXXX
     Namespace OR is it a stray code left?



Please help to correct if there is a gap in my understanding here and pleas=
e
forgive me if I have terribly missed out something very basic here.

Many thanks!

Best Regards
Salil










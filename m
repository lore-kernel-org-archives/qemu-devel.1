Return-Path: <SRS0=fi8h=Z7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0159C43603
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2019 06:39:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 785D2206E0
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2019 06:39:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 785D2206E0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36510 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ieChv-0006VB-IP
	for qemu-devel@archiver.kernel.org; Mon, 09 Dec 2019 01:39:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36153)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <guoheyi@huawei.com>) id 1ieCh1-0005Kp-RO
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 01:38:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <guoheyi@huawei.com>) id 1ieCh0-0004cA-PL
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 01:38:51 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:60988 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <guoheyi@huawei.com>)
 id 1ieCgx-0004aM-Vu; Mon, 09 Dec 2019 01:38:48 -0500
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.60])
 by Forcepoint Email with ESMTP id A8D9E3A6E32C72004617;
 Mon,  9 Dec 2019 14:38:42 +0800 (CST)
Received: from linux-XCyijm.huawei.com (10.175.104.212) by
 DGGEMS413-HUB.china.huawei.com (10.3.19.213) with Microsoft SMTP Server id
 14.3.439.0; Mon, 9 Dec 2019 14:38:34 +0800
From: Heyi Guo <guoheyi@huawei.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
Subject: [PATCH v6 2/2] hw/arm/acpi: enable SHPC native hot plug
Date: Mon, 9 Dec 2019 14:37:19 +0800
Message-ID: <20191209063719.23086-3-guoheyi@huawei.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20191209063719.23086-1-guoheyi@huawei.com>
References: <20191209063719.23086-1-guoheyi@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.104.212]
X-CFilter-Loop: Reflected
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 45.249.212.35
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Shannon Zhao <shannon.zhaosl@gmail.com>,
 Igor Mammedov <imammedo@redhat.com>, Heyi Guo <guoheyi@huawei.com>,
 wanghaibin.wang@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

After the introduction of generic PCIe root port and PCIe-PCI bridge,
we will also have SHPC controller on ARM, so just enable SHPC native
hot plug.

Also update tests/data/acpi/virt/DSDT* to pass "make check".

Cc: Shannon Zhao <shannon.zhaosl@gmail.com>
Cc: Peter Maydell <peter.maydell@linaro.org>
Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Signed-off-by: Heyi Guo <guoheyi@huawei.com>
---
 hw/arm/virt-acpi-build.c          |   7 ++++++-
 tests/data/acpi/virt/DSDT         | Bin 18462 -> 18462 bytes
 tests/data/acpi/virt/DSDT.memhp   | Bin 19799 -> 19799 bytes
 tests/data/acpi/virt/DSDT.numamem | Bin 18462 -> 18462 bytes
 4 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
index 51b293e0a1..bd5f771e9b 100644
--- a/hw/arm/virt-acpi-build.c
+++ b/hw/arm/virt-acpi-build.c
@@ -267,7 +267,12 @@ static void acpi_dsdt_add_pci(Aml *scope, const MemM=
apEntry *memmap,
         aml_create_dword_field(aml_arg(3), aml_int(8), "CDW3"));
     aml_append(ifctx, aml_store(aml_name("CDW2"), aml_name("SUPP")));
     aml_append(ifctx, aml_store(aml_name("CDW3"), aml_name("CTRL")));
-    aml_append(ifctx, aml_and(aml_name("CTRL"), aml_int(0x1D),
+
+    /*
+     * Allow OS control for all 5 features:
+     * PCIeHotplug SHPCHotplug PME AER PCIeCapability.
+     */
+    aml_append(ifctx, aml_and(aml_name("CTRL"), aml_int(0x1F),
                               aml_name("CTRL")));
=20
     ifctx1 =3D aml_if(aml_lnot(aml_equal(aml_arg(1), aml_int(0x1))));
diff --git a/tests/data/acpi/virt/DSDT b/tests/data/acpi/virt/DSDT
index 05bcfc8a912f58f266aa906563ea01c24906717e..d0f3afeb134fdf1c11f64cd06=
dbcdd30be603b80 100644
GIT binary patch
delta 28
kcmbO?fpOjhMlP3Nmk>D*1_q{tja=3D*8809zbbW3Ff0C~9xM*si-

delta 28
kcmbO?fpOjhMlP3Nmk>D*1_q|2ja=3D*87-cu_bW3Ff0C~j-M*si-

diff --git a/tests/data/acpi/virt/DSDT.memhp b/tests/data/acpi/virt/DSDT.=
memhp
index c041a910fdf272cb89263bb636239ae3a5e1708d..41ccc6431b917252bcbaac86c=
33b340c796be5ce 100644
GIT binary patch
delta 28
kcmcaUi}Cs_MlP3NmymE@1_mbija=3D*8809zbbeqQp0Eq|*2mk;8

delta 28
kcmcaUi}Cs_MlP3NmymE@1_ma@ja=3D*87-cu_beqQp0ErX{2mk;8

diff --git a/tests/data/acpi/virt/DSDT.numamem b/tests/data/acpi/virt/DSD=
T.numamem
index 05bcfc8a912f58f266aa906563ea01c24906717e..d0f3afeb134fdf1c11f64cd06=
dbcdd30be603b80 100644
GIT binary patch
delta 28
kcmbO?fpOjhMlP3Nmk>D*1_q{tja=3D*8809zbbW3Ff0C~9xM*si-

delta 28
kcmbO?fpOjhMlP3Nmk>D*1_q|2ja=3D*87-cu_bW3Ff0C~j-M*si-

--=20
2.19.1



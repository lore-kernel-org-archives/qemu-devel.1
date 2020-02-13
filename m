Return-Path: <SRS0=ry7b=4B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 978B7C352A4
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 02:08:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6AC3B206DB
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 02:08:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6AC3B206DB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46232 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j23vO-00067l-Ho
	for qemu-devel@archiver.kernel.org; Wed, 12 Feb 2020 21:08:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52265)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <fangying1@huawei.com>) id 1j23ue-0004qb-J9
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 21:07:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <fangying1@huawei.com>) id 1j23ud-0005MK-Gg
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 21:07:32 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:37296 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <fangying1@huawei.com>)
 id 1j23ua-0005ER-LO; Wed, 12 Feb 2020 21:07:28 -0500
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.59])
 by Forcepoint Email with ESMTP id 0CE23A32EE050BCF1445;
 Thu, 13 Feb 2020 10:07:26 +0800 (CST)
Received: from localhost (10.133.205.53) by DGGEMS404-HUB.china.huawei.com
 (10.3.19.204) with Microsoft SMTP Server id 14.3.439.0; Thu, 13 Feb 2020
 10:07:17 +0800
From: <fangying1@huawei.com>
To: <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>
Subject: [PATCH 4/4] arm: Create the cpufreq device
Date: Thu, 13 Feb 2020 10:07:12 +0800
Message-ID: <20200213020712.447-5-fangying1@huawei.com>
X-Mailer: git-send-email 2.22.0.windows.1
In-Reply-To: <20200213020712.447-1-fangying1@huawei.com>
References: <20200213020712.447-1-fangying1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.133.205.53]
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
Cc: peter.maydell@linaro.org, zhang.zhanghailiang@huawei.com, mst@redhat.com,
 i.mitsyanko@gmail.com, shannon.zhaosl@gmail.com, guoheyi@huawei.com,
 fangying1@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Ying Fang <fangying1@huawei.com>

Signed-off-by: Heyi Guo <guoheyi@huawei.com>
Signed-off-by: Ying Fang <fangying1@huawei.com>
---
 default-configs/aarch64-softmmu.mak |  1 +
 hw/acpi/Kconfig                     |  4 ++++
 hw/arm/virt.c                       | 13 +++++++++++++
 3 files changed, 18 insertions(+)

diff --git a/default-configs/aarch64-softmmu.mak b/default-configs/aarch6=
4-softmmu.mak
index 958b1e08e4..0a030e853f 100644
--- a/default-configs/aarch64-softmmu.mak
+++ b/default-configs/aarch64-softmmu.mak
@@ -6,3 +6,4 @@ include arm-softmmu.mak
 CONFIG_XLNX_ZYNQMP_ARM=3Dy
 CONFIG_XLNX_VERSAL=3Dy
 CONFIG_SBSA_REF=3Dy
+CONFIG_CPUFREQ=3Dy
diff --git a/hw/acpi/Kconfig b/hw/acpi/Kconfig
index 54209c6f2f..7d8aa58492 100644
--- a/hw/acpi/Kconfig
+++ b/hw/acpi/Kconfig
@@ -38,3 +38,7 @@ config ACPI_VMGENID
     depends on PC
=20
 config ACPI_HW_REDUCED
+
+config CPUFREQ
+    bool
+    default y
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index ed9dc38b60..53638f9557 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -764,6 +764,17 @@ static void create_uart(const VirtMachineState *vms,=
 int uart,
     g_free(nodename);
 }
=20
+static void create_cpufreq(const VirtMachineState *vms, MemoryRegion *me=
m)
+{
+    hwaddr base =3D vms->memmap[VIRT_CPUFREQ].base;
+    DeviceState *dev =3D qdev_create(NULL, "cpufreq");
+    SysBusDevice *s =3D SYS_BUS_DEVICE(dev);
+
+    qdev_init_nofail(dev);
+    memory_region_add_subregion(mem, base, sysbus_mmio_get_region(s, 0))=
;
+}
+
+
 static void create_rtc(const VirtMachineState *vms)
 {
     char *nodename;
@@ -1723,6 +1734,8 @@ static void machvirt_init(MachineState *machine)
=20
     create_uart(vms, VIRT_UART, sysmem, serial_hd(0));
=20
+    create_cpufreq(vms, sysmem);
+
     if (vms->secure) {
         create_secure_ram(vms, secure_sysmem);
         create_uart(vms, VIRT_SECURE_UART, secure_sysmem, serial_hd(1));
--=20
2.19.1




Return-Path: <SRS0=ry7b=4B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BA5EC3B186
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 02:08:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 15361206DB
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 02:08:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 15361206DB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46236 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j23vQ-0006Bw-8e
	for qemu-devel@archiver.kernel.org; Wed, 12 Feb 2020 21:08:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52255)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <fangying1@huawei.com>) id 1j23ue-0004qK-9s
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 21:07:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <fangying1@huawei.com>) id 1j23ud-0005Lk-6S
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 21:07:32 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:60296 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <fangying1@huawei.com>)
 id 1j23ua-0005AD-EV; Wed, 12 Feb 2020 21:07:28 -0500
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.60])
 by Forcepoint Email with ESMTP id 152F291525B9B0CCAC38;
 Thu, 13 Feb 2020 10:07:22 +0800 (CST)
Received: from localhost (10.133.205.53) by DGGEMS412-HUB.china.huawei.com
 (10.3.19.212) with Microsoft SMTP Server id 14.3.439.0; Thu, 13 Feb 2020
 10:07:13 +0800
From: <fangying1@huawei.com>
To: <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>
Subject: [PATCH 1/4] acpi: Add aml_generic_register
Date: Thu, 13 Feb 2020 10:07:09 +0800
Message-ID: <20200213020712.447-2-fangying1@huawei.com>
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
Cc: peter.maydell@linaro.org, zhang.zhanghailiang@huawei.com, mst@redhat.com,
 i.mitsyanko@gmail.com, shannon.zhaosl@gmail.com, guoheyi@huawei.com,
 fangying1@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Ying Fang <fangying1@huawei.com>

The generic register descriptor describes the localtion of a
fixed width register within any of the ACPI-defined address space.

This is needed to declare the ACPI CPPC registers.

Signed-off-by: Heyi Guo <guoheyi@huawei.com>
Signed-off-by: Ying Fang <fangying1@huawei.com>
---
 hw/acpi/aml-build.c         | 22 ++++++++++++++++++++++
 include/hw/acpi/aml-build.h |  3 +++
 2 files changed, 25 insertions(+)

diff --git a/hw/acpi/aml-build.c b/hw/acpi/aml-build.c
index 2c3702b882..79b1431f07 100644
--- a/hw/acpi/aml-build.c
+++ b/hw/acpi/aml-build.c
@@ -1370,6 +1370,28 @@ Aml *aml_sleep(uint64_t msec)
     return var;
 }
=20
+/* ACPI 5.0b: 6.4.3.7 Generic Register Descriptor */
+Aml *aml_generic_register(AmlRegionSpace rs, uint8_t reg_width,
+                          uint8_t reg_offset, AmlAccessType type, uint64=
_t addr)
+{
+    int i;
+    Aml *var =3D aml_alloc();
+    build_append_byte(var->buf, 0x82); /* Generic Register Descriptor */
+    build_append_byte(var->buf, 0x0C); /* Length, bits[7:0] value =3D 0x=
0C */
+    build_append_byte(var->buf, 0);    /* Length, bits[15:8] value =3D 0=
 */
+    build_append_byte(var->buf, rs);   /* Address Space ID */
+    build_append_byte(var->buf, reg_width);   /* Register Bit Width */
+    build_append_byte(var->buf, reg_offset);  /* Register Bit Offset */
+    build_append_byte(var->buf, type);        /* Access Size */
+
+    /* Register address */
+    for (i =3D 0; i < 8; i++) {
+        build_append_byte(var->buf, extract64(addr, i * 8, 8));
+    }
+
+    return var;
+}
+
 static uint8_t Hex2Byte(const char *src)
 {
     int hi, lo;
diff --git a/include/hw/acpi/aml-build.h b/include/hw/acpi/aml-build.h
index de4a406568..37a047b156 100644
--- a/include/hw/acpi/aml-build.h
+++ b/include/hw/acpi/aml-build.h
@@ -364,6 +364,9 @@ Aml *aml_qword_memory(AmlDecode dec, AmlMinFixed min_=
fixed,
 Aml *aml_dma(AmlDmaType typ, AmlDmaBusMaster bm, AmlTransferSize sz,
              uint8_t channel);
 Aml *aml_sleep(uint64_t msec);
+Aml *aml_generic_register(AmlRegionSpace rs, uint8_t reg_width,
+                          uint8_t reg_offset, AmlAccessType type,
+                          uint64_t addr);
 Aml *aml_i2c_serial_bus_device(uint16_t address, const char *resource_so=
urce);
=20
 /* Block AML object primitives */
--=20
2.19.1




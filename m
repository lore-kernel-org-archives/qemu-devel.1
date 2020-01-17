Return-Path: <SRS0=+Hf+=3G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40454C33C9E
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2020 17:53:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 162F52072B
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2020 17:53:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 162F52072B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32962 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1isVoh-0002DN-2e
	for qemu-devel@archiver.kernel.org; Fri, 17 Jan 2020 12:53:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55939)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <shameerali.kolothum.thodi@huawei.com>)
 id 1isViI-0002cM-Gt
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 12:47:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <shameerali.kolothum.thodi@huawei.com>)
 id 1isViH-0007wi-D6
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 12:47:18 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:2742 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <shameerali.kolothum.thodi@huawei.com>)
 id 1isViE-0007sI-LM; Fri, 17 Jan 2020 12:47:14 -0500
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.58])
 by Forcepoint Email with ESMTP id D8FA28F48DA91834DA0B;
 Sat, 18 Jan 2020 01:47:11 +0800 (CST)
Received: from S00345302A-PC.china.huawei.com (10.202.227.237) by
 DGGEMS401-HUB.china.huawei.com (10.3.19.201) with Microsoft SMTP Server id
 14.3.439.0; Sat, 18 Jan 2020 01:47:00 +0800
From: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
To: <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>, <eric.auger@redhat.com>,
 <imammedo@redhat.com>
Subject: [PATCH v2 7/7] tests/bios-tables-test: Update arm/virt memhp test
Date: Fri, 17 Jan 2020 17:45:22 +0000
Message-ID: <20200117174522.22044-8-shameerali.kolothum.thodi@huawei.com>
X-Mailer: git-send-email 2.12.0.windows.1
In-Reply-To: <20200117174522.22044-1-shameerali.kolothum.thodi@huawei.com>
References: <20200117174522.22044-1-shameerali.kolothum.thodi@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.202.227.237]
X-CFilter-Loop: Reflected
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 45.249.212.191
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
Cc: peter.maydell@linaro.org, xiaoguangrong.eric@gmail.com, mst@redhat.com,
 linuxarm@huawei.com, xuwei5@hisilicon.com, shannon.zhaosl@gmail.com,
 lersek@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Since we now have both pc-dimm and nvdimm support, update
test_acpi_virt_tcg_memhp() to include those.

Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
---
 tests/data/acpi/virt/NFIT.memhp | 0
 tests/data/acpi/virt/SSDT.memhp | 0
 tests/qtest/bios-tables-test.c  | 9 +++++++--
 3 files changed, 7 insertions(+), 2 deletions(-)
 create mode 100644 tests/data/acpi/virt/NFIT.memhp
 create mode 100644 tests/data/acpi/virt/SSDT.memhp

diff --git a/tests/data/acpi/virt/NFIT.memhp b/tests/data/acpi/virt/NFIT.memhp
new file mode 100644
index 0000000000..e69de29bb2
diff --git a/tests/data/acpi/virt/SSDT.memhp b/tests/data/acpi/virt/SSDT.memhp
new file mode 100644
index 0000000000..e69de29bb2
diff --git a/tests/qtest/bios-tables-test.c b/tests/qtest/bios-tables-test.c
index f1ac2d7e96..695d2e7fac 100644
--- a/tests/qtest/bios-tables-test.c
+++ b/tests/qtest/bios-tables-test.c
@@ -913,12 +913,17 @@ static void test_acpi_virt_tcg_memhp(void)
     };
 
     data.variant = ".memhp";
-    test_acpi_one(" -cpu cortex-a57"
+    test_acpi_one(" -machine nvdimm=on"
+                  " -cpu cortex-a57"
                   " -m 256M,slots=3,maxmem=1G"
                   " -object memory-backend-ram,id=ram0,size=128M"
                   " -object memory-backend-ram,id=ram1,size=128M"
                   " -numa node,memdev=ram0 -numa node,memdev=ram1"
-                  " -numa dist,src=0,dst=1,val=21",
+                  " -numa dist,src=0,dst=1,val=21"
+                  " -object memory-backend-ram,id=ram2,size=128M"
+                  " -object memory-backend-ram,id=nvm0,size=128M"
+                  " -device pc-dimm,id=dimm0,memdev=ram2,node=0"
+                  " -device nvdimm,id=dimm1,memdev=nvm0,node=1",
                   &data);
 
     free_test_data(&data);
-- 
2.17.1




Return-Path: <SRS0=QLzr=44=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6044FC0044D
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 17:28:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C897620736
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 17:28:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C897620736
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56318 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jC59m-0003RL-Bo
	for qemu-devel@archiver.kernel.org; Wed, 11 Mar 2020 13:28:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58221)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <shameerali.kolothum.thodi@huawei.com>)
 id 1jC55P-0002mj-MB
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 13:24:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <shameerali.kolothum.thodi@huawei.com>)
 id 1jC55N-0004UO-Lf
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 13:24:02 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:52090 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <shameerali.kolothum.thodi@huawei.com>)
 id 1jC55K-0004D2-5b; Wed, 11 Mar 2020 13:23:59 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.58])
 by Forcepoint Email with ESMTP id E06B64BAE0408E864822;
 Thu, 12 Mar 2020 01:23:54 +0800 (CST)
Received: from S00345302A-PC.china.huawei.com (10.202.227.237) by
 DGGEMS414-HUB.china.huawei.com (10.3.19.214) with Microsoft SMTP Server id
 14.3.487.0; Thu, 12 Mar 2020 01:23:45 +0800
From: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
To: <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>, <eric.auger@redhat.com>,
 <imammedo@redhat.com>
Subject: [PATCH v3 09/10] tests/bios-tables-test: Update arm/virt memhp test
Date: Wed, 11 Mar 2020 17:20:13 +0000
Message-ID: <20200311172014.33052-10-shameerali.kolothum.thodi@huawei.com>
X-Mailer: git-send-email 2.12.0.windows.1
In-Reply-To: <20200311172014.33052-1-shameerali.kolothum.thodi@huawei.com>
References: <20200311172014.33052-1-shameerali.kolothum.thodi@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.202.227.237]
X-CFilter-Loop: Reflected
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
Cc: peter.maydell@linaro.org, xiaoguangrong.eric@gmail.com, david@redhat.com,
 mst@redhat.com, linuxarm@huawei.com, xuwei5@hisilicon.com,
 shannon.zhaosl@gmail.com, lersek@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Since we now have both pc-dimm and nvdimm support, update
test_acpi_virt_tcg_memhp() to include those.

Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
---
v2 -> v3
 -Moved addition of empty table files to the previous patch
---
 tests/qtest/bios-tables-test.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/tests/qtest/bios-tables-test.c b/tests/qtest/bios-tables-test.c
index 0a597bbacf..c9843829b3 100644
--- a/tests/qtest/bios-tables-test.c
+++ b/tests/qtest/bios-tables-test.c
@@ -927,12 +927,17 @@ static void test_acpi_virt_tcg_memhp(void)
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




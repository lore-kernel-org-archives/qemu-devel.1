Return-Path: <SRS0=w+gu=XN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87CC3C4CEC9
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2019 13:27:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5A58D20856
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2019 13:27:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A58D20856
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59048 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iAZzb-0005MD-Fx
	for qemu-devel@archiver.kernel.org; Wed, 18 Sep 2019 09:27:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58855)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <shameerali.kolothum.thodi@huawei.com>)
 id 1iAZhU-0004sT-7K
 for qemu-devel@nongnu.org; Wed, 18 Sep 2019 09:08:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <shameerali.kolothum.thodi@huawei.com>)
 id 1iAZhQ-0003fD-Ny
 for qemu-devel@nongnu.org; Wed, 18 Sep 2019 09:08:51 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:43854 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <shameerali.kolothum.thodi@huawei.com>)
 id 1iAZhI-0003Yx-OK; Wed, 18 Sep 2019 09:08:41 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.60])
 by Forcepoint Email with ESMTP id 296FD86B58D0B5171D67;
 Wed, 18 Sep 2019 21:08:38 +0800 (CST)
Received: from S00345302A-PC.china.huawei.com (10.202.227.237) by
 DGGEMS409-HUB.china.huawei.com (10.3.19.209) with Microsoft SMTP Server id
 14.3.439.0; Wed, 18 Sep 2019 21:08:27 +0800
From: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
To: <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>, <eric.auger@redhat.com>,
 <imammedo@redhat.com>
Date: Wed, 18 Sep 2019 14:06:32 +0100
Message-ID: <20190918130633.4872-11-shameerali.kolothum.thodi@huawei.com>
X-Mailer: git-send-email 2.12.0.windows.1
In-Reply-To: <20190918130633.4872-1-shameerali.kolothum.thodi@huawei.com>
References: <20190918130633.4872-1-shameerali.kolothum.thodi@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.202.227.237]
X-CFilter-Loop: Reflected
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 45.249.212.32
Subject: [Qemu-devel] [PATCH-for-4.2 v11 10/11] tests: Update ACPI tables
 list for upcoming arm/virt tests
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
Cc: peter.maydell@linaro.org, sameo@linux.intel.com, ard.biesheuvel@linaro.org,
 mst@redhat.com, linuxarm@huawei.com, xuwei5@hisilicon.com,
 shannon.zhaosl@gmail.com, sebastien.boeuf@intel.com, lersek@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is in preparation to add numamem and memhp tests to
arm/virt platform. The bios-tables-test-allowed-diff.h
is updated with a list of expected ACPI tables that needs to be
present in tests/data/acpi/virt folder.

Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
---
v10 --> v11

As per Michael's suggestion updated bios-tables-test-allowed-diff.h
instead of adding expected files directly.
---
 tests/bios-tables-test-allowed-diff.h | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/tests/bios-tables-test-allowed-diff.h b/tests/bios-tables-test-allowed-diff.h
index 7b4adbc822..3776dd2f3d 100644
--- a/tests/bios-tables-test-allowed-diff.h
+++ b/tests/bios-tables-test-allowed-diff.h
@@ -1,2 +1,17 @@
 /* List of comma-separated changed AML files to ignore */
 "tests/data/acpi/virt/DSDT",
+"tests/data/acpi/virt/APIC.memhp",
+"tests/data/acpi/virt/APIC.numamem",
+"tests/data/acpi/virt/DSDT.memhp",
+"tests/data/acpi/virt/DSDT.numamem",
+"tests/data/acpi/virt/FACP.memhp",
+"tests/data/acpi/virt/FACP.numamem",
+"tests/data/acpi/virt/GTDT.memhp",
+"tests/data/acpi/virt/GTDT.numamem",
+"tests/data/acpi/virt/MCFG.memhp",
+"tests/data/acpi/virt/MCFG.numamem",
+"tests/data/acpi/virt/SLIT.memhp",
+"tests/data/acpi/virt/SPCR.memhp",
+"tests/data/acpi/virt/SPCR.numamem",
+"tests/data/acpi/virt/SRAT.memhp",
+"tests/data/acpi/virt/SRAT.numamem",
-- 
2.17.1




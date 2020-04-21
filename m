Return-Path: <SRS0=H2wg=6F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DED0C54FC9
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2020 13:05:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 421F3206F4
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2020 13:05:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 421F3206F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58010 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jQsb7-00052D-A1
	for qemu-devel@archiver.kernel.org; Tue, 21 Apr 2020 09:05:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44794)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <shameerali.kolothum.thodi@huawei.com>)
 id 1jQsXn-0008FR-RV
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 09:02:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <shameerali.kolothum.thodi@huawei.com>)
 id 1jQsXl-0002Yi-UG
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 09:02:31 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:3676 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shameerali.kolothum.thodi@huawei.com>)
 id 1jQsXe-0002HT-M7; Tue, 21 Apr 2020 09:02:23 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.59])
 by Forcepoint Email with ESMTP id 7AF0B68FC3DBDB0C3C18;
 Tue, 21 Apr 2020 21:02:19 +0800 (CST)
Received: from S00345302A-PC.china.huawei.com (10.47.91.160) by
 DGGEMS412-HUB.china.huawei.com (10.3.19.212) with Microsoft SMTP Server id
 14.3.487.0; Tue, 21 Apr 2020 21:02:09 +0800
From: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
To: <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>, <eric.auger@redhat.com>,
 <imammedo@redhat.com>
Subject: [PATCH v4 5/7] tests: Update ACPI tables list for upcoming arm/virt
 test changes
Date: Tue, 21 Apr 2020 13:59:32 +0100
Message-ID: <20200421125934.14952-6-shameerali.kolothum.thodi@huawei.com>
X-Mailer: git-send-email 2.12.0.windows.1
In-Reply-To: <20200421125934.14952-1-shameerali.kolothum.thodi@huawei.com>
References: <20200421125934.14952-1-shameerali.kolothum.thodi@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.47.91.160]
X-CFilter-Loop: Reflected
Received-SPF: pass client-ip=45.249.212.190;
 envelope-from=shameerali.kolothum.thodi@huawei.com; helo=huawei.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/21 09:01:59
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Received-From: 45.249.212.190
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
 prime.zeng@hisilicon.com, lersek@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is in preparation to update test_acpi_virt_tcg_memhp()
with pc-dimm and nvdimm. Update the bios-tables-test-allowed-diff.h
with the affected ACPI tables so that "make check" doesn't fail.

Also add empty files for new tables required for new test.

Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
---
 tests/data/acpi/virt/NFIT.memhp             | 0
 tests/data/acpi/virt/SSDT.memhp             | 0
 tests/qtest/bios-tables-test-allowed-diff.h | 3 +++
 3 files changed, 3 insertions(+)
 create mode 100644 tests/data/acpi/virt/NFIT.memhp
 create mode 100644 tests/data/acpi/virt/SSDT.memhp

diff --git a/tests/data/acpi/virt/NFIT.memhp b/tests/data/acpi/virt/NFIT.memhp
new file mode 100644
index 0000000000..e69de29bb2
diff --git a/tests/data/acpi/virt/SSDT.memhp b/tests/data/acpi/virt/SSDT.memhp
new file mode 100644
index 0000000000..e69de29bb2
diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest/bios-tables-test-allowed-diff.h
index eb8bae1407..862c49e675 100644
--- a/tests/qtest/bios-tables-test-allowed-diff.h
+++ b/tests/qtest/bios-tables-test-allowed-diff.h
@@ -1,3 +1,6 @@
 /* List of comma-separated changed AML files to ignore */
 "tests/data/acpi/pc/SSDT.dimmpxm",
 "tests/data/acpi/q35/SSDT.dimmpxm",
+"tests/data/acpi/virt/DSDT.memhp",
+"tests/data/acpi/virt/SSDT.memhp",
+"tests/data/acpi/virt/NFIT.memhp",
-- 
2.17.1




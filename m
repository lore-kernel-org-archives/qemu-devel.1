Return-Path: <SRS0=IkQf=EJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D854C388F7
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 12:24:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9D96522226
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 12:24:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D96522226
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34208 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kZvMU-0004fQ-LZ
	for qemu-devel@archiver.kernel.org; Tue, 03 Nov 2020 07:24:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47862)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cenjiahui@huawei.com>)
 id 1kZvIM-0008Np-N3
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 07:20:14 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:2129)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cenjiahui@huawei.com>)
 id 1kZvII-000854-AB
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 07:20:14 -0500
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.58])
 by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4CQTPc74msz702w;
 Tue,  3 Nov 2020 20:20:04 +0800 (CST)
Received: from localhost (10.174.184.155) by DGGEMS408-HUB.china.huawei.com
 (10.3.19.208) with Microsoft SMTP Server id 14.3.487.0; Tue, 3 Nov 2020
 20:19:59 +0800
From: Jiahui Cen <cenjiahui@huawei.com>
To: <qemu-devel@nongnu.org>
Subject: [PATCH v9 8/8] unit-test: Add the binary file and clear diff.h
Date: Tue, 3 Nov 2020 20:01:57 +0800
Message-ID: <20201103120157.2286-9-cenjiahui@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201103120157.2286-1-cenjiahui@huawei.com>
References: <20201103120157.2286-1-cenjiahui@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.174.184.155]
X-CFilter-Loop: Reflected
Received-SPF: pass client-ip=45.249.212.35; envelope-from=cenjiahui@huawei.com;
 helo=szxga07-in.huawei.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/03 04:32:14
X-ACL-Warn: Detected OS   = Linux 3.1-3.10 [fuzzy]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: xieyingtai@huawei.com, peter.maydell@linaro.org,
 Jiahui Cen <cenjiahui@huawei.com>, berrange@redhat.com, mst@redhat.com,
 xiexiangyou@huawei.com, shannon.zhaosl@gmail.com, miaoyubo@huawei.com,
 imammedo@redhat.com, lersek@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Yubo Miao <miaoyubo@huawei.com>

Add the binary file DSDT.pxb and clear bios-tables-test-allowed-diff.h

Signed-off-by: Yubo Miao <miaoyubo@huawei.com>
Signed-off-by: Jiahui Cen <cenjiahui@huawei.com>
---
 tests/data/acpi/virt/DSDT.pxb               | Bin 0 -> 7802 bytes
 tests/qtest/bios-tables-test-allowed-diff.h |   1 -
 2 files changed, 1 deletion(-)
 create mode 100644 tests/data/acpi/virt/DSDT.pxb

diff --git a/tests/data/acpi/virt/DSDT.pxb b/tests/data/acpi/virt/DSDT.pxb
new file mode 100644
index 0000000000000000000000000000000000000000..d5f0533a02d62bc2ae2db9b9de9484e5c06652fe
GIT binary patch
literal 7802
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
ATL1t6

literal 0
HcmV?d00001

diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest/bios-tables-test-allowed-diff.h
index 90c53925fc..dfb8523c8b 100644
--- a/tests/qtest/bios-tables-test-allowed-diff.h
+++ b/tests/qtest/bios-tables-test-allowed-diff.h
@@ -1,2 +1 @@
 /* List of comma-separated changed AML files to ignore */
-"tests/data/acpi/virt/DSDT.pxb",
-- 
2.19.1



Return-Path: <SRS0=6DzB=ZD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95206C43331
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Nov 2019 01:47:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6948E206C3
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Nov 2019 01:47:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6948E206C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48444 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iTynG-0002iq-SE
	for qemu-devel@archiver.kernel.org; Sun, 10 Nov 2019 20:47:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52451)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <zhengxiang9@huawei.com>) id 1iTykq-0000wS-DP
 for qemu-devel@nongnu.org; Sun, 10 Nov 2019 20:44:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <zhengxiang9@huawei.com>) id 1iTykp-0004ra-F3
 for qemu-devel@nongnu.org; Sun, 10 Nov 2019 20:44:32 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:2200 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <zhengxiang9@huawei.com>)
 id 1iTykn-0004pP-Ap; Sun, 10 Nov 2019 20:44:29 -0500
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.60])
 by Forcepoint Email with ESMTP id 0D7E8820CD7FDC4E85F3;
 Mon, 11 Nov 2019 09:44:26 +0800 (CST)
Received: from HGHY4Z004218071.china.huawei.com (10.133.224.57) by
 DGGEMS403-HUB.china.huawei.com (10.3.19.203) with Microsoft SMTP Server id
 14.3.439.0; Mon, 11 Nov 2019 09:44:20 +0800
From: Xiang Zheng <zhengxiang9@huawei.com>
To: <pbonzini@redhat.com>, <mst@redhat.com>, <imammedo@redhat.com>,
 <shannon.zhaosl@gmail.com>, <peter.maydell@linaro.org>, <lersek@redhat.com>,
 <james.morse@arm.com>, <gengdongjiu@huawei.com>, <mtosatti@redhat.com>,
 <rth@twiddle.net>, <ehabkost@redhat.com>, <jonathan.cameron@huawei.com>,
 <xuwei5@huawei.com>, <kvm@vger.kernel.org>, <qemu-devel@nongnu.org>,
 <qemu-arm@nongnu.org>, <linuxarm@huawei.com>
Subject: [RESEND PATCH v21 6/6] MAINTAINERS: Add APCI/APEI/GHES entries
Date: Mon, 11 Nov 2019 09:40:48 +0800
Message-ID: <20191111014048.21296-7-zhengxiang9@huawei.com>
X-Mailer: git-send-email 2.15.1.windows.2
In-Reply-To: <20191111014048.21296-1-zhengxiang9@huawei.com>
References: <20191111014048.21296-1-zhengxiang9@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.133.224.57]
X-CFilter-Loop: Reflected
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: wanghaibin.wang@huawei.com, zhengxiang9@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Dongjiu Geng <gengdongjiu@huawei.com>

I and Xiang are willing to review the APEI-related patches and
volunteer as the reviewers for the APEI/GHES part.

Signed-off-by: Dongjiu Geng <gengdongjiu@huawei.com>
Signed-off-by: Xiang Zheng <zhengxiang9@huawei.com>
---
 MAINTAINERS | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 325e67a04e..043f7a928e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1414,6 +1414,15 @@ F: tests/bios-tables-test.c
 F: tests/acpi-utils.[hc]
 F: tests/data/acpi/
 
+ACPI/APEI/GHES
+R: Dongjiu Geng <gengdongjiu@huawei.com>
+R: Xiang Zheng <zhengxiang9@huawei.com>
+L: qemu-arm@nongnu.org
+S: Maintained
+F: hw/acpi/acpi_ghes.c
+F: include/hw/acpi/acpi_ghes.h
+F: docs/specs/acpi_hest_ghes.rst
+
 ppc4xx
 M: David Gibson <david@gibson.dropbear.id.au>
 L: qemu-ppc@nongnu.org
-- 
2.19.1




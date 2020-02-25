Return-Path: <SRS0=OzdF=4N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE353C35DEE
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 02:14:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B3DA821927
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 02:14:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B3DA821927
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47722 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6Pju-0005hm-RR
	for qemu-devel@archiver.kernel.org; Mon, 24 Feb 2020 21:14:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38678)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kuhn.chenqun@huawei.com>) id 1j6PgS-00071q-QF
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 21:10:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kuhn.chenqun@huawei.com>) id 1j6PgQ-0008Cd-NF
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 21:10:52 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:3249 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kuhn.chenqun@huawei.com>)
 id 1j6PgN-00085x-Nz; Mon, 24 Feb 2020 21:10:48 -0500
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.60])
 by Forcepoint Email with ESMTP id C8804C6C5159483D681F;
 Tue, 25 Feb 2020 10:10:42 +0800 (CST)
Received: from huawei.com (10.133.205.93) by DGGEMS412-HUB.china.huawei.com
 (10.3.19.212) with Microsoft SMTP Server id 14.3.439.0; Tue, 25 Feb 2020
 10:10:32 +0800
From: <kuhn.chenqun@huawei.com>
To: <qemu-devel@nongnu.org>, <qemu-trivial@nongnu.org>
Subject: [PATCH 06/13] display/pxa2xx_lcd: Remove redundant statement in
 pxa2xx_palette_parse()
Date: Tue, 25 Feb 2020 10:09:30 +0800
Message-ID: <20200225020937.25028-7-kuhn.chenqun@huawei.com>
X-Mailer: git-send-email 2.14.1.windows.1
In-Reply-To: <20200225020937.25028-1-kuhn.chenqun@huawei.com>
References: <20200225020937.25028-1-kuhn.chenqun@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.133.205.93]
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
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org,
 zhang.zhanghailiang@huawei.com, Chen Qun <kuhn.chenqun@huawei.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Chen Qun <kuhn.chenqun@huawei.com>

Clang static code analyzer show warning:
hw/display/pxa2xx_lcd.c:596:9: warning: Value stored to 'format' is never read
        format = 0;
        ^        ~

Reported-by: Euler Robot <euler.robot@huawei.com>
Signed-off-by: Chen Qun <kuhn.chenqun@huawei.com>
---
Cc: Andrzej Zaborowski <balrogg@gmail.com>
Cc: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm@nongnu.org
---
 hw/display/pxa2xx_lcd.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/hw/display/pxa2xx_lcd.c b/hw/display/pxa2xx_lcd.c
index 05f5f84671..464e93161a 100644
--- a/hw/display/pxa2xx_lcd.c
+++ b/hw/display/pxa2xx_lcd.c
@@ -593,7 +593,6 @@ static void pxa2xx_palette_parse(PXA2xxLCDState *s, int ch, int bpp)
         n = 256;
         break;
     default:
-        format = 0;
         return;
     }
 
-- 
2.23.0




Return-Path: <SRS0=IkQf=EJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E308EC2D0A3
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 11:51:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 61E3C21D40
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 11:51:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61E3C21D40
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34186 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kZuqh-0004yH-AX
	for qemu-devel@archiver.kernel.org; Tue, 03 Nov 2020 06:51:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41050)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhangxinhao1@huawei.com>)
 id 1kZump-0000hR-2W; Tue, 03 Nov 2020 06:47:39 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:2434)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhangxinhao1@huawei.com>)
 id 1kZumm-0005X7-Ru; Tue, 03 Nov 2020 06:47:38 -0500
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.59])
 by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4CQSgy07C6zLt5r;
 Tue,  3 Nov 2020 19:47:26 +0800 (CST)
Received: from huawei.com (10.175.101.6) by DGGEMS411-HUB.china.huawei.com
 (10.3.19.211) with Microsoft SMTP Server id 14.3.487.0; Tue, 3 Nov 2020
 19:47:20 +0800
From: Xinhao Zhang <zhangxinhao1@huawei.com>
To: <qemu-devel@nongnu.org>
Subject: [PATCH 3/3] target/arm: add space before the open parenthesis '('
Date: Tue, 3 Nov 2020 19:45:29 +0800
Message-ID: <20201103114529.638233-3-zhangxinhao1@huawei.com>
X-Mailer: git-send-email 2.29.0-rc1
In-Reply-To: <20201103114529.638233-1-zhangxinhao1@huawei.com>
References: <20201103114529.638233-1-zhangxinhao1@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.175.101.6]
X-CFilter-Loop: Reflected
Received-SPF: pass client-ip=45.249.212.191;
 envelope-from=zhangxinhao1@huawei.com; helo=szxga05-in.huawei.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/03 06:47:30
X-ACL-Warn: Detected OS   = Linux 3.1-3.10 [fuzzy]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
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
Cc: alex.chen@huawei.com, peter.maydell@linaro.org, qemu-arm@nongnu.org,
 qemu-trivial@nongnu.org, dengkai1@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Fix code style. Space required before the open parenthesis '('.

Signed-off-by: Xinhao Zhang <zhangxinhao1@huawei.com>
Signed-off-by: Kai Deng <dengkai1@huawei.com>
---
 target/arm/translate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/arm/translate.c b/target/arm/translate.c
index 38371db540..efa3b59d04 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -9094,7 +9094,7 @@ static void arm_tr_tb_stop(DisasContextBase *dcbase, CPUState *cpu)
             - Hardware watchpoints.
            Hardware breakpoints have already been handled and skip this code.
          */
-        switch(dc->base.is_jmp) {
+        switch (dc->base.is_jmp) {
         case DISAS_NEXT:
         case DISAS_TOO_MANY:
             gen_goto_tb(dc, 1, dc->base.pc_next);
-- 
2.29.0-rc1



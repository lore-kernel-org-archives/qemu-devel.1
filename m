Return-Path: <SRS0=q+n2=EF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F665C2D0A3
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 01:12:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8B4CC2072C
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 01:12:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B4CC2072C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59078 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kYIyF-0006yV-Hw
	for qemu-devel@archiver.kernel.org; Thu, 29 Oct 2020 21:12:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44956)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kuhn.chenqun@huawei.com>)
 id 1kYITq-0001Xm-94; Thu, 29 Oct 2020 20:41:23 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:2313)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kuhn.chenqun@huawei.com>)
 id 1kYITm-00013h-MX; Thu, 29 Oct 2020 20:41:21 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.58])
 by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4CMk574mdjzkbpt;
 Fri, 30 Oct 2020 08:41:15 +0800 (CST)
Received: from huawei.com (10.175.104.175) by DGGEMS409-HUB.china.huawei.com
 (10.3.19.209) with Microsoft SMTP Server id 14.3.487.0; Fri, 30 Oct 2020
 08:41:05 +0800
From: Chen Qun <kuhn.chenqun@huawei.com>
To: <qemu-devel@nongnu.org>, <qemu-trivial@nongnu.org>
Subject: [PATCH v2 2/8] hw/intc/arm_gicv3_kvm: silence the compiler warnings
Date: Fri, 30 Oct 2020 08:40:40 +0800
Message-ID: <20201030004046.2191790-3-kuhn.chenqun@huawei.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20201030004046.2191790-1-kuhn.chenqun@huawei.com>
References: <20201030004046.2191790-1-kuhn.chenqun@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.175.104.175]
X-CFilter-Loop: Reflected
Received-SPF: pass client-ip=45.249.212.190;
 envelope-from=kuhn.chenqun@huawei.com; helo=szxga04-in.huawei.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/29 20:41:14
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
Cc: Peter Maydell <peter.maydell@linaro.org>, zhang.zhanghailiang@huawei.com,
 qemu-arm@nongnu.org, ganqixin@huawei.com, Euler Robot <euler.robot@huawei.com>,
 Chen Qun <kuhn.chenqun@huawei.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

When using -Wimplicit-fallthrough in our CFLAGS, the compiler showed warning:
hw/intc/arm_gicv3_kvm.c: In function ‘kvm_arm_gicv3_put’:
hw/intc/arm_gicv3_kvm.c:484:13: warning: this statement may fall through [-Wimplicit-fallthrough=]
             kvm_gicc_access(s, ICC_AP0R_EL1(1), ncpu, &reg64, true);
             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
hw/intc/arm_gicv3_kvm.c:485:9: note: here
         default:
         ^~~~~~~
hw/intc/arm_gicv3_kvm.c:495:13: warning: this statement may fall through [-Wimplicit-fallthrough=]
             kvm_gicc_access(s, ICC_AP1R_EL1(2), ncpu, &reg64, true);
             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
hw/intc/arm_gicv3_kvm.c:496:9: note: here
         case 6:
         ^~~~
hw/intc/arm_gicv3_kvm.c:498:13: warning: this statement may fall through [-Wimplicit-fallthrough=]
             kvm_gicc_access(s, ICC_AP1R_EL1(1), ncpu, &reg64, true);
             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
hw/intc/arm_gicv3_kvm.c:499:9: note: here
         default:
         ^~~~~~~

hw/intc/arm_gicv3_kvm.c: In function ‘kvm_arm_gicv3_get’:
hw/intc/arm_gicv3_kvm.c:634:37: warning: this statement may fall through [-Wimplicit-fallthrough=]
             c->icc_apr[GICV3_G0][2] = reg64;
             ~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~
hw/intc/arm_gicv3_kvm.c:635:9: note: here
         case 6:
         ^~~~
hw/intc/arm_gicv3_kvm.c:637:37: warning: this statement may fall through [-Wimplicit-fallthrough=]
             c->icc_apr[GICV3_G0][1] = reg64;
             ~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~
hw/intc/arm_gicv3_kvm.c:638:9: note: here
         default:
         ^~~~~~~
hw/intc/arm_gicv3_kvm.c:648:39: warning: this statement may fall through [-Wimplicit-fallthrough=]
             c->icc_apr[GICV3_G1NS][2] = reg64;
             ~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~
hw/intc/arm_gicv3_kvm.c:649:9: note: here
         case 6:
         ^~~~
hw/intc/arm_gicv3_kvm.c:651:39: warning: this statement may fall through [-Wimplicit-fallthrough=]
             c->icc_apr[GICV3_G1NS][1] = reg64;
             ~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~
hw/intc/arm_gicv3_kvm.c:652:9: note: here
         default:
         ^~~~~~~

Reported-by: Euler Robot <euler.robot@huawei.com>
Signed-off-by: Chen Qun <kuhn.chenqun@huawei.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
---
Cc: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm@nongnu.org
---
 hw/intc/arm_gicv3_kvm.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/hw/intc/arm_gicv3_kvm.c b/hw/intc/arm_gicv3_kvm.c
index 187eb054e0..d040a5d1e9 100644
--- a/hw/intc/arm_gicv3_kvm.c
+++ b/hw/intc/arm_gicv3_kvm.c
@@ -478,9 +478,11 @@ static void kvm_arm_gicv3_put(GICv3State *s)
             kvm_gicc_access(s, ICC_AP0R_EL1(3), ncpu, &reg64, true);
             reg64 = c->icc_apr[GICV3_G0][2];
             kvm_gicc_access(s, ICC_AP0R_EL1(2), ncpu, &reg64, true);
+            /* fall through */
         case 6:
             reg64 = c->icc_apr[GICV3_G0][1];
             kvm_gicc_access(s, ICC_AP0R_EL1(1), ncpu, &reg64, true);
+            /* fall through */
         default:
             reg64 = c->icc_apr[GICV3_G0][0];
             kvm_gicc_access(s, ICC_AP0R_EL1(0), ncpu, &reg64, true);
@@ -492,9 +494,11 @@ static void kvm_arm_gicv3_put(GICv3State *s)
             kvm_gicc_access(s, ICC_AP1R_EL1(3), ncpu, &reg64, true);
             reg64 = c->icc_apr[GICV3_G1NS][2];
             kvm_gicc_access(s, ICC_AP1R_EL1(2), ncpu, &reg64, true);
+            /* fall through */
         case 6:
             reg64 = c->icc_apr[GICV3_G1NS][1];
             kvm_gicc_access(s, ICC_AP1R_EL1(1), ncpu, &reg64, true);
+            /* fall through */
         default:
             reg64 = c->icc_apr[GICV3_G1NS][0];
             kvm_gicc_access(s, ICC_AP1R_EL1(0), ncpu, &reg64, true);
@@ -631,9 +635,11 @@ static void kvm_arm_gicv3_get(GICv3State *s)
             c->icc_apr[GICV3_G0][3] = reg64;
             kvm_gicc_access(s, ICC_AP0R_EL1(2), ncpu, &reg64, false);
             c->icc_apr[GICV3_G0][2] = reg64;
+            /* fall through */
         case 6:
             kvm_gicc_access(s, ICC_AP0R_EL1(1), ncpu, &reg64, false);
             c->icc_apr[GICV3_G0][1] = reg64;
+            /* fall through */
         default:
             kvm_gicc_access(s, ICC_AP0R_EL1(0), ncpu, &reg64, false);
             c->icc_apr[GICV3_G0][0] = reg64;
@@ -645,9 +651,11 @@ static void kvm_arm_gicv3_get(GICv3State *s)
             c->icc_apr[GICV3_G1NS][3] = reg64;
             kvm_gicc_access(s, ICC_AP1R_EL1(2), ncpu, &reg64, false);
             c->icc_apr[GICV3_G1NS][2] = reg64;
+            /* fall through */
         case 6:
             kvm_gicc_access(s, ICC_AP1R_EL1(1), ncpu, &reg64, false);
             c->icc_apr[GICV3_G1NS][1] = reg64;
+            /* fall through */
         default:
             kvm_gicc_access(s, ICC_AP1R_EL1(0), ncpu, &reg64, false);
             c->icc_apr[GICV3_G1NS][0] = reg64;
-- 
2.27.0



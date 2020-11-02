Return-Path: <SRS0=N3Ri=EI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7946C00A89
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2020 10:05:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2EA402225E
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2020 10:05:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2EA402225E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50908 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kZWiY-0005mw-TM
	for qemu-devel@archiver.kernel.org; Mon, 02 Nov 2020 05:05:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50524)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.chen@huawei.com>)
 id 1kZWYz-0008JF-LL; Mon, 02 Nov 2020 04:55:45 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:2427)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.chen@huawei.com>)
 id 1kZWYw-0000dR-MW; Mon, 02 Nov 2020 04:55:45 -0500
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.58])
 by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4CPpFH1lyGzLpPM;
 Mon,  2 Nov 2020 17:55:31 +0800 (CST)
Received: from [10.174.187.138] (10.174.187.138) by
 DGGEMS413-HUB.china.huawei.com (10.3.19.213) with Microsoft SMTP Server id
 14.3.487.0; Mon, 2 Nov 2020 17:55:23 +0800
Message-ID: <5F9FD78B.8000300@huawei.com>
Date: Mon, 2 Nov 2020 17:55:23 +0800
From: AlexChen <alex.chen@huawei.com>
User-Agent: Mozilla/5.0 (Windows NT 6.2; WOW64;
 rv:17.0) Gecko/20130509 Thunderbird/17.0.6
MIME-Version: 1.0
To: <balrogg@gmail.com>, Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH] hw/arm: Fix bad print format specifiers
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.187.138]
X-CFilter-Loop: Reflected
Received-SPF: pass client-ip=45.249.212.191; envelope-from=alex.chen@huawei.com;
 helo=szxga05-in.huawei.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/02 04:55:35
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
Cc: QEMU Trivial <qemu-trivial@nongnu.org>, qemu-arm@nongnu.org,
 QEMU <qemu-devel@nongnu.org>, zhang.zhanghailiang@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We should use printf format specifier "%u" instead of "%i" for
argument of type "unsigned int".

Reported-by: Euler Robot <euler.robot@huawei.com>
Signed-off-by: Alex Chen <alex.chen@huawei.com>
---
 hw/arm/pxa2xx.c | 2 +-
 hw/arm/spitz.c  | 2 +-
 hw/arm/tosa.c   | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/hw/arm/pxa2xx.c b/hw/arm/pxa2xx.c
index 591776ba88..1a98f3bd5c 100644
--- a/hw/arm/pxa2xx.c
+++ b/hw/arm/pxa2xx.c
@@ -675,7 +675,7 @@ static void pxa2xx_ssp_write(void *opaque, hwaddr addr,
         if (value & SSCR0_MOD)
             printf("%s: Attempt to use network mode\n", __func__);
         if (s->enable && SSCR0_DSS(value) < 4)
-            printf("%s: Wrong data size: %i bits\n", __func__,
+            printf("%s: Wrong data size: %u bits\n", __func__,
                             SSCR0_DSS(value));
         if (!(value & SSCR0_SSE)) {
             s->sssr = 0;
diff --git a/hw/arm/spitz.c b/hw/arm/spitz.c
index 32bdeacfd3..772662f149 100644
--- a/hw/arm/spitz.c
+++ b/hw/arm/spitz.c
@@ -586,7 +586,7 @@ struct SpitzLCDTG {
 static void spitz_bl_update(SpitzLCDTG *s)
 {
     if (s->bl_power && s->bl_intensity)
-        zaurus_printf("LCD Backlight now at %i/63\n", s->bl_intensity);
+        zaurus_printf("LCD Backlight now at %u/63\n", s->bl_intensity);
     else
         zaurus_printf("LCD Backlight now off\n");
 }
diff --git a/hw/arm/tosa.c b/hw/arm/tosa.c
index fe88ed89fe..66b244aeff 100644
--- a/hw/arm/tosa.c
+++ b/hw/arm/tosa.c
@@ -150,7 +150,7 @@ static void tosa_gpio_setup(PXA2xxState *cpu,

 static uint32_t tosa_ssp_tansfer(SSISlave *dev, uint32_t value)
 {
-    fprintf(stderr, "TG: %d %02x\n", value >> 5, value & 0x1f);
+    fprintf(stderr, "TG: %u %02x\n", value >> 5, value & 0x1f);
     return 0;
 }

-- 
2.19.1


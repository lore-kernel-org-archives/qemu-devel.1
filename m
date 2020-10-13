Return-Path: <SRS0=rz2F=DU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3DD3C433E7
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 06:55:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EF9902078A
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 06:55:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF9902078A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38232 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kSEDB-0006ln-Um
	for qemu-devel@archiver.kernel.org; Tue, 13 Oct 2020 02:55:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32908)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1kSEBa-0004zj-Jp; Tue, 13 Oct 2020 02:53:26 -0400
Received: from mout.kundenserver.de ([212.227.126.130]:51999)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1kSEBX-0000EH-LL; Tue, 13 Oct 2020 02:53:26 -0400
Received: from localhost.localdomain ([82.252.141.186]) by
 mrelayeu.kundenserver.de (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MXY2Z-1kyMxV49Z1-00Yyn6; Tue, 13 Oct 2020 08:53:19 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL 03/15] hw/rtc/twl92230: Silence warnings about missing
 fallthrough statements
Date: Tue, 13 Oct 2020 08:53:01 +0200
Message-Id: <20201013065313.7349-4-laurent@vivier.eu>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201013065313.7349-1-laurent@vivier.eu>
References: <20201013065313.7349-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:ZtJvTo3dGjT6+a5UiQQYseHectvtReqizKvf8Wv6GDQoRyuzM9Y
 AcYsYLX+guxUGzgz1Dp0cQ9rTgBo91uQskMyZRdFNIMYFyeewfxQjUhi+qjy0xZSd6zJBRI
 h/LtwfDn6WIt//e4nbnyBwqBoR7l4Oti8rcBZQOXA/KmK/19Q322Z23aTz75gqk2EfDerYW
 1/7R4OdYkNSMfHre3+UPg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:9WaF3tBctDA=:4+XCNH6GPQuOjSLF6mfa91
 1Pc1r9D2RrsPW8fIe/0QsANQXbkTSITcbLhMxqNH8p7/qjw4oGeXSHQREHEzI7XTv1U04KMLU
 qHkaY9dYPFe+xmRVnm4VSM+GS3E9Au1xDHoOaKNKVRK7nviR00d2ej6olpqOziL6Z+dvl8P2m
 vriXwehxdAoOjbwVoUDRD7iAN4Pfu7hNY6K9Wtl76FaWs2peD27yC+DUQvxuvkWjKcMHyBjQ1
 OVnqU5TRXIUcvaxXsQ77MMPSDnlzMFTJE2X3X8yr/nXtWWIEc+GSeC6YlXsiKV7Qcl46hSLo+
 fWWqreiVRi6PGeyE5uYtuDqjb14wwG9Dqga+hJj2lm6IKWOdl6R13gnG+CacC05ueFdh2ziJU
 thcM7OtHyt6jIRw2/4kBjfQ1XuMLTzEi1T+pJbiEP7LvJyA6yofXP4MDeGqVinMv8xIHM1nOg
 Wr4BqT4JQ/hBqtnp87sVcZ6vqhOSq3a6pcZHudK7ub6T+ir4Uj834Gp7l+sxRSstZZLx9uMb3
 Z7RLH0QuSNakY5a3SD+CgICqdROD5LmJoUsHongn5iFtFtjqHm1HhYBx2hWSdpA7jbh6Ez/1D
 gBeRERGfXZZlZhVsBwGUCss03COOCmFKEZg0coQvucY7bTbRlmNmlg4VGpFnBs0eG5DvLxfoh
 PmJOxHoJx0drTTpSgl9k/4YFzHWfpwfdVNp0L21n5D669oiK/vPBqAAn72EGu3hsyGjXHLKGg
 Jd4rTdpL0rwCL2pyv4WkBMp0GwuFSrqMyXmLwQBSIgEA3ka8/W86Uo1YPHt8omWS4q13/+SAs
 k8edqdtG4k4z97E7qDrw5lCF5BJf1lDK4XSQ2qRFrRz09jYNyj+QGwt5qeW3fOZsG9rpjoq
Received-SPF: none client-ip=212.227.126.130; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/13 02:53:22
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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
Cc: qemu-trivial@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>,
 Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Thomas Huth <thuth@redhat.com>

When compiling with -Werror=implicit-fallthrough, gcc complains about
missing fallthrough annotations in this file. Looking at the code,
the fallthrough is indeed wanted here, but instead of adding the
annotations, it can be done more efficiently by simply calculating
the offset with a subtraction instead of increasing a local variable
one by one.

Signed-off-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-Id: <20201001182121.187122-1-thuth@redhat.com>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 hw/rtc/twl92230.c | 50 +++++++++++++++++++++++------------------------
 1 file changed, 24 insertions(+), 26 deletions(-)

diff --git a/hw/rtc/twl92230.c b/hw/rtc/twl92230.c
index f838913b378d..499f421932e6 100644
--- a/hw/rtc/twl92230.c
+++ b/hw/rtc/twl92230.c
@@ -271,37 +271,36 @@ static void menelaus_gpio_set(void *opaque, int line, int level)
 static uint8_t menelaus_read(void *opaque, uint8_t addr)
 {
     MenelausState *s = (MenelausState *) opaque;
-    int reg = 0;
 
     switch (addr) {
     case MENELAUS_REV:
         return 0x22;
 
-    case MENELAUS_VCORE_CTRL5: reg ++;
-    case MENELAUS_VCORE_CTRL4: reg ++;
-    case MENELAUS_VCORE_CTRL3: reg ++;
-    case MENELAUS_VCORE_CTRL2: reg ++;
+    case MENELAUS_VCORE_CTRL5:
+    case MENELAUS_VCORE_CTRL4:
+    case MENELAUS_VCORE_CTRL3:
+    case MENELAUS_VCORE_CTRL2:
     case MENELAUS_VCORE_CTRL1:
-        return s->vcore[reg];
+        return s->vcore[addr - MENELAUS_VCORE_CTRL1];
 
-    case MENELAUS_DCDC_CTRL3: reg ++;
-    case MENELAUS_DCDC_CTRL2: reg ++;
+    case MENELAUS_DCDC_CTRL3:
+    case MENELAUS_DCDC_CTRL2:
     case MENELAUS_DCDC_CTRL1:
-        return s->dcdc[reg];
-
-    case MENELAUS_LDO_CTRL8: reg ++;
-    case MENELAUS_LDO_CTRL7: reg ++;
-    case MENELAUS_LDO_CTRL6: reg ++;
-    case MENELAUS_LDO_CTRL5: reg ++;
-    case MENELAUS_LDO_CTRL4: reg ++;
-    case MENELAUS_LDO_CTRL3: reg ++;
-    case MENELAUS_LDO_CTRL2: reg ++;
+        return s->dcdc[addr - MENELAUS_VCORE_CTRL1];
+
+    case MENELAUS_LDO_CTRL8:
+    case MENELAUS_LDO_CTRL7:
+    case MENELAUS_LDO_CTRL6:
+    case MENELAUS_LDO_CTRL5:
+    case MENELAUS_LDO_CTRL4:
+    case MENELAUS_LDO_CTRL3:
+    case MENELAUS_LDO_CTRL2:
     case MENELAUS_LDO_CTRL1:
-        return s->ldo[reg];
+        return s->ldo[addr - MENELAUS_LDO_CTRL1];
 
-    case MENELAUS_SLEEP_CTRL2: reg ++;
+    case MENELAUS_SLEEP_CTRL2:
     case MENELAUS_SLEEP_CTRL1:
-        return s->sleep[reg];
+        return s->sleep[addr - MENELAUS_SLEEP_CTRL1];
 
     case MENELAUS_DEVICE_OFF:
         return 0;
@@ -395,10 +394,10 @@ static uint8_t menelaus_read(void *opaque, uint8_t addr)
     case MENELAUS_S2_PULL_DIR:
         return s->pull[3];
 
-    case MENELAUS_MCT_CTRL3: reg ++;
-    case MENELAUS_MCT_CTRL2: reg ++;
+    case MENELAUS_MCT_CTRL3:
+    case MENELAUS_MCT_CTRL2:
     case MENELAUS_MCT_CTRL1:
-        return s->mmc_ctrl[reg];
+        return s->mmc_ctrl[addr - MENELAUS_MCT_CTRL1];
     case MENELAUS_MCT_PIN_ST:
         /* TODO: return the real Card Detect */
         return 0;
@@ -418,7 +417,6 @@ static void menelaus_write(void *opaque, uint8_t addr, uint8_t value)
 {
     MenelausState *s = (MenelausState *) opaque;
     int line;
-    int reg = 0;
     struct tm tm;
 
     switch (addr) {
@@ -496,9 +494,9 @@ static void menelaus_write(void *opaque, uint8_t addr, uint8_t value)
         s->ldo[7] = value & 3;
         break;
 
-    case MENELAUS_SLEEP_CTRL2: reg ++;
+    case MENELAUS_SLEEP_CTRL2:
     case MENELAUS_SLEEP_CTRL1:
-        s->sleep[reg] = value;
+        s->sleep[addr - MENELAUS_SLEEP_CTRL1] = value;
         break;
 
     case MENELAUS_DEVICE_OFF:
-- 
2.26.2



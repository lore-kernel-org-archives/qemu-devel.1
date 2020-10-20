Return-Path: <SRS0=1sPN=D3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 325F8C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 10:52:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3EF0E20674
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 10:52:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dJDimuJj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3EF0E20674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40386 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUpFc-0007H5-1t
	for qemu-devel@archiver.kernel.org; Tue, 20 Oct 2020 06:52:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46814)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kUpEd-0006N0-AJ
 for qemu-devel@nongnu.org; Tue, 20 Oct 2020 06:51:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:53200)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kUpEb-0005As-IJ
 for qemu-devel@nongnu.org; Tue, 20 Oct 2020 06:51:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603191076;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type;
 bh=u98o9Gz5dIbSk3zFGgR2qDz5whghdbPkATmd+7ouTQQ=;
 b=dJDimuJjVxU5Ci/WkrAnLe6bD4P0aCaVl2FR3tRe9n70M5G8+JnIBE223aremu2o7DYJzs
 WxwIHxIEjZyjHJ/IpbB1RCTVcR0i/vDws0rh6uLs63FhkBWdaK3qZzKnm+zgxdNwXQiYX5
 60Y37IS8wyHCdP5o9t/wyqZeF2/GI+M=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-438-pIV9x-poMWmCTWERcb6YcA-1; Tue, 20 Oct 2020 06:51:12 -0400
X-MC-Unique: pIV9x-poMWmCTWERcb6YcA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7E35B845EE9;
 Tue, 20 Oct 2020 10:51:11 +0000 (UTC)
Received: from thuth.com (dhcp-192-238.str.redhat.com [10.33.192.238])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 462F21002393;
 Tue, 20 Oct 2020 10:51:10 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v2] hw/rtc/twl92230: Silence warnings about missing
 fallthrough statements
Date: Tue, 20 Oct 2020 12:51:08 +0200
Message-Id: <20201020105108.19733-1-thuth@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=thuth@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=63.128.21.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/20 01:15:43
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: qemu-trivial@nongnu.org, qemu-arm@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

When compiling with -Werror=implicit-fallthrough, gcc complains about
missing fallthrough annotations in this file. Looking at the code,
the fallthrough is indeed wanted here, but instead of adding the
annotations, it can be done more efficiently by simply calculating
the offset with a subtraction instead of increasing a local variable
one by one.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 v2: Fixed copy-n-paste bug

 hw/rtc/twl92230.c | 50 +++++++++++++++++++++++------------------------
 1 file changed, 24 insertions(+), 26 deletions(-)

diff --git a/hw/rtc/twl92230.c b/hw/rtc/twl92230.c
index f838913b37..50b97a1fce 100644
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
+        return s->dcdc[addr - MENELAUS_DCDC_CTRL1];
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
2.18.2



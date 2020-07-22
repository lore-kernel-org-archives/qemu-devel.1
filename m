Return-Path: <SRS0=zezO=BB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75276C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2020 17:00:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3CAC7206E3
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2020 17:00:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Y+96Sxxv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3CAC7206E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55352 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jyI6O-0000cH-GP
	for qemu-devel@archiver.kernel.org; Wed, 22 Jul 2020 13:00:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46080)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=465c3c755=alistair.francis@wdc.com>)
 id 1jyI4h-0005u2-KI
 for qemu-devel@nongnu.org; Wed, 22 Jul 2020 12:58:35 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:10279)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=465c3c755=alistair.francis@wdc.com>)
 id 1jyI4f-0002fu-PA
 for qemu-devel@nongnu.org; Wed, 22 Jul 2020 12:58:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1595437113; x=1626973113;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=EEcXoQzOEpyedNq1KqU81uQZwfqgkAVodrjSDY+pIyA=;
 b=Y+96SxxvWmO10FRshdM0VYIqr8E5B72E4oK+wTiJiVk4lgm4tYhkAyvj
 gFK3DbQHXhseoX1NnT7PJBeqZWt5OqWhXH1foPdIx3vbXf5PxT1RsfEtr
 8UIdUF9g2xdXMgwMw9adGYXmI5LPEfq/BRPzel+1mwhmgniCnVL7GRZkA
 DkA3Zk9FNX79Z30XX1Pl0ZCjThZRDBxL+AA7DEAw1+VBXxBe9xDMtwzAC
 OfYJbfpFiTOGO5hWD+sf8Emjc3DinR9Yvp9dEI/Og6teANgW7VuQkYjCo
 Gl8TbSlK7OK0elPhJaU31JembPPRRtBZ5DL+vjlVjKULNjN7qPVebtPln w==;
IronPort-SDR: nukzmwo5bl2eRh0EzRmGIWcdZAk5OX+NMPg4lYVVnjdftqGD9qdrMPZbvlusdLVVYqjXf3dqlU
 rE/IyYY1kSgWJxEZrw6I++eNFbcD8upPoyuzwye60CNmQQU9Trlhw6o+DGPzP78QnpQWpIrkOW
 cH4CueLxmO+Ja2U4BwWjlYkenpeaXk8a/CrgsGSdTyXySRyhXyNpZ/T9zXrYdVsL0pjT+TSoQC
 oaqoYDVY275M/3FrLDLhAZYAKQn6Dqh+0ZtaONq+x2d9FFFPISCsFu2/2m2i69fD+ej5tPy1tU
 Pzk=
X-IronPort-AV: E=Sophos;i="5.75,383,1589212800"; d="scan'208";a="252418633"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 23 Jul 2020 00:58:21 +0800
IronPort-SDR: 33U8veotb/MG5fTjjbi0i6gpe0jprWR/4u4bBYwV468M+qsE870JqDYMF8B7DtqBG6JNvg6HOk
 e8EHaBvdNzQKRf/poYa5S9x2Eeu5ocmvM=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Jul 2020 09:46:38 -0700
IronPort-SDR: hVNb4kZzjpLeKmIF9LS2qp96/k78/zaJzEgIhs14gIyntrFmuEtepi0QNfLqBpmQY6OLmMG+mN
 So+AwVHXh/DA==
WDCIronportException: Internal
Received: from usa001575.ad.shared (HELO risc6-mainframe.hgst.com)
 ([10.86.58.115])
 by uls-op-cesaip02.wdc.com with ESMTP; 22 Jul 2020 09:58:21 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Subject: [PULL 1/5] goldfish_rtc: Fix non-atomic read behaviour of
 TIME_LOW/TIME_HIGH
Date: Wed, 22 Jul 2020 09:48:34 -0700
Message-Id: <20200722164838.1591305-2-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200722164838.1591305-1-alistair.francis@wdc.com>
References: <20200722164838.1591305-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=68.232.141.245;
 envelope-from=prvs=465c3c755=alistair.francis@wdc.com;
 helo=esa1.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/22 12:58:21
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Jessica Clarke <jrtc27@jrtc27.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Jessica Clarke <jrtc27@jrtc27.com>

The specification says:

   0x00  TIME_LOW   R: Get current time, then return low-order 32-bits.
   0x04  TIME_HIGH  R: Return high 32-bits from previous TIME_LOW read.

   ...

   To read the value, the kernel must perform an IO_READ(TIME_LOW),
   which returns an unsigned 32-bit value, before an IO_READ(TIME_HIGH),
   which returns a signed 32-bit value, corresponding to the higher half
   of the full value.

However, we were just returning the current time for both. If the guest
is unlucky enough to read TIME_LOW and TIME_HIGH either side of an
overflow of the lower half, it will see time be in the future, before
jumping backwards on the next read, and Linux currently relies on the
atomicity guaranteed by the spec so is affected by this. Fix this
violation of the spec by caching the correct value for TIME_HIGH
whenever TIME_LOW is read, and returning that value for any TIME_HIGH
read.

Signed-off-by: Jessica Clarke <jrtc27@jrtc27.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20200718004934.83174-1-jrtc27@jrtc27.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 include/hw/rtc/goldfish_rtc.h |  1 +
 hw/rtc/goldfish_rtc.c         | 17 ++++++++++++++---
 2 files changed, 15 insertions(+), 3 deletions(-)

diff --git a/include/hw/rtc/goldfish_rtc.h b/include/hw/rtc/goldfish_rtc.h
index 16f9f9e29d..9bd8924f5f 100644
--- a/include/hw/rtc/goldfish_rtc.h
+++ b/include/hw/rtc/goldfish_rtc.h
@@ -41,6 +41,7 @@ typedef struct GoldfishRTCState {
     uint32_t alarm_running;
     uint32_t irq_pending;
     uint32_t irq_enabled;
+    uint32_t time_high;
 } GoldfishRTCState;
 
 #endif
diff --git a/hw/rtc/goldfish_rtc.c b/hw/rtc/goldfish_rtc.c
index 01e9d2b083..6ddd45cce0 100644
--- a/hw/rtc/goldfish_rtc.c
+++ b/hw/rtc/goldfish_rtc.c
@@ -94,12 +94,22 @@ static uint64_t goldfish_rtc_read(void *opaque, hwaddr offset,
     GoldfishRTCState *s = opaque;
     uint64_t r = 0;
 
+    /*
+     * From the documentation linked at the top of the file:
+     *
+     *   To read the value, the kernel must perform an IO_READ(TIME_LOW), which
+     *   returns an unsigned 32-bit value, before an IO_READ(TIME_HIGH), which
+     *   returns a signed 32-bit value, corresponding to the higher half of the
+     *   full value.
+     */
     switch (offset) {
     case RTC_TIME_LOW:
-        r = goldfish_rtc_get_count(s) & 0xffffffff;
+        r = goldfish_rtc_get_count(s);
+        s->time_high = r >> 32;
+        r &= 0xffffffff;
         break;
     case RTC_TIME_HIGH:
-        r = goldfish_rtc_get_count(s) >> 32;
+        r = s->time_high;
         break;
     case RTC_ALARM_LOW:
         r = s->alarm_next & 0xffffffff;
@@ -216,7 +226,7 @@ static const MemoryRegionOps goldfish_rtc_ops = {
 
 static const VMStateDescription goldfish_rtc_vmstate = {
     .name = TYPE_GOLDFISH_RTC,
-    .version_id = 1,
+    .version_id = 2,
     .pre_save = goldfish_rtc_pre_save,
     .post_load = goldfish_rtc_post_load,
     .fields = (VMStateField[]) {
@@ -225,6 +235,7 @@ static const VMStateDescription goldfish_rtc_vmstate = {
         VMSTATE_UINT32(alarm_running, GoldfishRTCState),
         VMSTATE_UINT32(irq_pending, GoldfishRTCState),
         VMSTATE_UINT32(irq_enabled, GoldfishRTCState),
+        VMSTATE_UINT32(time_high, GoldfishRTCState),
         VMSTATE_END_OF_LIST()
     }
 };
-- 
2.27.0



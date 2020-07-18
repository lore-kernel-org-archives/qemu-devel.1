Return-Path: <SRS0=NumX=A5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57F25C433E0
	for <qemu-devel@archiver.kernel.org>; Sat, 18 Jul 2020 00:23:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1A629206BE
	for <qemu-devel@archiver.kernel.org>; Sat, 18 Jul 2020 00:23:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=jrtc27.com header.i=@jrtc27.com header.b="PhmDI0UQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A629206BE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=jrtc27.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56396 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jwadV-00071F-AB
	for qemu-devel@archiver.kernel.org; Fri, 17 Jul 2020 20:23:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34674)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrtc27@jrtc27.com>) id 1jwacw-0006Zo-UE
 for qemu-devel@nongnu.org; Fri, 17 Jul 2020 20:22:54 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:46698)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jrtc27@jrtc27.com>) id 1jwacv-0006wj-A0
 for qemu-devel@nongnu.org; Fri, 17 Jul 2020 20:22:54 -0400
Received: by mail-wr1-x441.google.com with SMTP id r12so12751144wrj.13
 for <qemu-devel@nongnu.org>; Fri, 17 Jul 2020 17:22:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=jrtc27.com; s=gmail.jrtc27.user;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=BEhiojhcihfJEHuVOQphZXFsFvvyIPEH2kqJDjqAIpQ=;
 b=PhmDI0UQ5UOUhO7SNrzGAqMduP2bsvG5YoUKaEKC2L79+7nwraOFG084eMa6q0HvQC
 6iKyCvGrhuB11HIT3ffZp0KTFeH7mA0mVHlVsV9H4mPjeUb2VCvrzcnwil/IpaU3F5P8
 och4AWPv26+MLB1mJPAVzOPfZEt5S0349y4NBBGlB9yzp8/X07cQfPYAYdQhEk+bp7Q9
 3H+9+NgzU/7ah+AxxJzgA+2Zkyg6Qy6FR60ochIRcAkVAYER9Pspb0RTL2Dve93wZWP3
 aeHAog58dXoGnNZ5rli+XOs0u852gFDHIjavopoNA6PHbGh5FkNd8mZbPHGyUlnCEMxi
 xr2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=BEhiojhcihfJEHuVOQphZXFsFvvyIPEH2kqJDjqAIpQ=;
 b=T//68AslIHkF3NRn4VVDvTvcDxmy8kzAgE2Rt9wyrbHMmW2AiBPMqxSzCmqImdqv0z
 j0HDrwPD8ssBwPUEkwnOrlHt5v2lPZZ3N+sLH+cFC54OB/dFYDib5aX83Is5JipBMMha
 b9FUdsQykGHuENVGuDG3MQFjiFc/q1XLBDr3JxPrnbM/LV0fkLyZlRoaiDzw5/2ygAMR
 NIPwi5c3sKjC0ynTQLAgpMSOSFrgo5NyYg7ZcFiE8cA2uftV7ZiRlXjiG/cLXPV4IqRg
 pNwQ7Wj1JEsEilLkfU5hR74/OJWadB7mo3IinXN3cb+K9jo3kus7OdOSyt3jVo/cq0dc
 grXw==
X-Gm-Message-State: AOAM532kisRwH0u4C26cvJctkexJWdPeTLp3HOJxilrP4mF5gWWWX6fl
 6vEbreV4xpsKLFWUmEIrkC8p4A==
X-Google-Smtp-Source: ABdhPJwIHE0ZHFQFB4EmId391vk+MKPvN+0rIk8iApIXjplVnaYoIl+aLpdXCX40VdNBHUn/Z9zAnQ==
X-Received: by 2002:adf:c382:: with SMTP id p2mr12392183wrf.283.1595031771213; 
 Fri, 17 Jul 2020 17:22:51 -0700 (PDT)
Received: from Jessicas-MacBook.local (trinity-students-nat.trin.cam.ac.uk.
 [131.111.193.104])
 by smtp.gmail.com with ESMTPSA id h5sm17987536wrc.97.2020.07.17.17.22.50
 (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
 Fri, 17 Jul 2020 17:22:50 -0700 (PDT)
Received: by Jessicas-MacBook.local (Postfix, from userid 501)
 id 8FB90207A34267; Sat, 18 Jul 2020 01:22:49 +0100 (BST)
From: Jessica Clarke <jrtc27@jrtc27.com>
To: qemu-riscv@nongnu.org
Subject: [PATCH] goldfish_rtc: Fix non-atomic read behaviour of
 TIME_LOW/TIME_HIGH
Date: Sat, 18 Jul 2020 01:20:27 +0100
Message-Id: <20200718002027.82300-1-jrtc27@jrtc27.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::441;
 envelope-from=jrtc27@jrtc27.com; helo=mail-wr1-x441.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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
Cc: Alistair Francis <Alistair.Francis@wdc.com>,
 Anup Patel <anup.patel@wdc.com>, Jessica Clarke <jrtc27@jrtc27.com>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

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
---
 hw/rtc/goldfish_rtc.c         | 14 ++++++++++++--
 include/hw/rtc/goldfish_rtc.h |  1 +
 2 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/hw/rtc/goldfish_rtc.c b/hw/rtc/goldfish_rtc.c
index 01e9d2b083..9b577bf159 100644
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
-- 
2.20.1



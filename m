Return-Path: <SRS0=x6Qc=45=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE896C10DCE
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 19:44:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BB880206E9
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 19:44:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="maOYaX3+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB880206E9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49128 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jCTkN-00088f-T1
	for qemu-devel@archiver.kernel.org; Thu, 12 Mar 2020 15:43:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44978)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jCTis-0004aF-Fz
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 15:42:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1jCTir-0001fy-Aw
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 15:42:26 -0400
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641]:41414)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1jCTir-0001fG-5s
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 15:42:25 -0400
Received: by mail-pl1-x641.google.com with SMTP id t14so3061931plr.8
 for <qemu-devel@nongnu.org>; Thu, 12 Mar 2020 12:42:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=rGpxLm79CCdrNbLq46EhVbUpI55c0cfdmX2p0AxkOgU=;
 b=maOYaX3+B9tNyub/KhSP8AclpZeniqojXcZkHxnY3XmvWUR23nXZm2ZY/UCMhSfyUo
 uZt1om1FYgtxoaOtBizkswF2S4u2Vb644HxciOjxh/3JPTO0blJjUmcJG77w9fCU9+I9
 pKp6cumbkSGkWqLHzSZRrxLmP10BUGbeY4AN4dHD/Pqldk/EJiXw81+5Yk/0bQcXnTJ8
 n3VdHtAXuddMi9bZHWePe0vW7pyIiqG6YOUJjJSRJZhEZhh/mNhbyQpLJIbu4jTlMG4B
 bLO1/FBHGwJMw27+7L84PufVWfCblzOpm5wcNdyblBFM4gNSyq+tkYaI0pZtv6wegVDm
 6Ssg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=rGpxLm79CCdrNbLq46EhVbUpI55c0cfdmX2p0AxkOgU=;
 b=kRaQavoY71jy5x7ZVfsGSvOwab4F6608UkeD4v0Yh8BHFWJwcnH7/Cgl2TRUpFM7KZ
 es4/6p++TnGM4doYzY7LkfEidY311ejLPTfKjr9n6Bg6yAgq9ywLSStgBEayt96621UZ
 iiM8hQo1jvuqncLp8z872dUg2aL4Fl3k3blwaAJReSSEHJ9t7Gdb2PJmUUS5iCjouVXH
 j62VrOt2ByzUq9UEyKahfYkFhFYNg1CoQacha+9i5I/70XCFmkuptMTAu48PgfQDgkvu
 EyMrLY341xCY/dvH3HQH92owFFUEOn7caeFcTJStK6RHXIByP6dZMCLCdHg/+HFAeJTw
 zfyw==
X-Gm-Message-State: ANhLgQ2Y0jE33wyfEdOASV7+lNmDskx9w1UyW9xD9+fx9na/fUCh7/gu
 74FlNpSrX1s55yAQslHdixTj+F5MQrw=
X-Google-Smtp-Source: ADFU+vubA8FNHNaedG9rokcg0Goayg7BEHMdZicUkQpwfspkEmMMVuNj2hbwlC1y88XIE3eraDmmiQ==
X-Received: by 2002:a17:90a:6545:: with SMTP id
 f5mr5984646pjs.42.1584042143854; 
 Thu, 12 Mar 2020 12:42:23 -0700 (PDT)
Received: from localhost.localdomain (97-126-123-70.tukw.qwest.net.
 [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id g69sm6824842pje.34.2020.03.12.12.42.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Mar 2020 12:42:23 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v6 02/42] target/arm: Improve masking of SCR RES0 bits
Date: Thu, 12 Mar 2020 12:41:39 -0700
Message-Id: <20200312194219.24406-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200312194219.24406-1-richard.henderson@linaro.org>
References: <20200312194219.24406-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::641
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
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org, alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Protect reads of aa64 id registers with ARM_CP_STATE_AA64.
Use this as a simpler test than arm_el_is_aa64, since EL3
cannot change mode.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/helper.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 8f81ca4f54..d04fc0a140 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -1966,9 +1966,16 @@ static void scr_write(CPUARMState *env, const ARMCPRegInfo *ri, uint64_t value)
     uint32_t valid_mask = 0x3fff;
     ARMCPU *cpu = env_archcpu(env);
 
-    if (arm_el_is_aa64(env, 3)) {
+    if (ri->state == ARM_CP_STATE_AA64) {
         value |= SCR_FW | SCR_AW;   /* these two bits are RES1.  */
         valid_mask &= ~SCR_NET;
+
+        if (cpu_isar_feature(aa64_lor, cpu)) {
+            valid_mask |= SCR_TLOR;
+        }
+        if (cpu_isar_feature(aa64_pauth, cpu)) {
+            valid_mask |= SCR_API | SCR_APK;
+        }
     } else {
         valid_mask &= ~(SCR_RW | SCR_ST);
     }
@@ -1987,12 +1994,6 @@ static void scr_write(CPUARMState *env, const ARMCPRegInfo *ri, uint64_t value)
             valid_mask &= ~SCR_SMD;
         }
     }
-    if (cpu_isar_feature(aa64_lor, cpu)) {
-        valid_mask |= SCR_TLOR;
-    }
-    if (cpu_isar_feature(aa64_pauth, cpu)) {
-        valid_mask |= SCR_API | SCR_APK;
-    }
 
     /* Clear all-context RES0 bits.  */
     value &= valid_mask;
-- 
2.20.1



Return-Path: <SRS0=EQsI=67=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_LOCAL_NOVOWEL,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B67EBC433DF
	for <qemu-devel@archiver.kernel.org>; Sun, 17 May 2020 22:16:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6E4AB2065F
	for <qemu-devel@archiver.kernel.org>; Sun, 17 May 2020 22:16:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K6oSefrg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E4AB2065F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52998 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jaRaI-0006hF-Rg
	for qemu-devel@archiver.kernel.org; Sun, 17 May 2020 18:16:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33868)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jcmvbkbc@gmail.com>)
 id 1jaRIi-0001wc-My
 for qemu-devel@nongnu.org; Sun, 17 May 2020 17:58:33 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a]:33115)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jcmvbkbc@gmail.com>)
 id 1jaRIi-0005hr-0J
 for qemu-devel@nongnu.org; Sun, 17 May 2020 17:58:28 -0400
Received: by mail-pl1-x62a.google.com with SMTP id t7so3405447plr.0
 for <qemu-devel@nongnu.org>; Sun, 17 May 2020 14:58:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=K7IZYqiMOjR0HQghYXo05JFCNaL5rLGE+wUsI9wohsk=;
 b=K6oSefrg8DdYmiqRbnzY0/C7MXymusT6BUOrMCnS6TneDq7z4IdWhX+bUdqhs0S9V9
 4AZCdSQPcf7Aco5Yu5Fmi5vOwPNKYWgHENcIY9/DADwSpQgRlHVKtLhYfx8VRWy7YOoc
 4bmU6i1iK5C034HZ4y4wjh1HglQP+R6fwHv0b31BXZvVRtsBMfT9nz7LED8blOaonbrt
 S1/fW2Q94TFx5wncwRSXz92RvZdnmIXLFKDbOExxZ0XuoVL4ygqPGD5D5AzNkqs7Ku8X
 y+c+HwZ4y71/2X5cLgyGbhPmH5RqMbrccb0YRYCSw128ZndoPPuGAY76hcE43H1mwPMU
 elLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=K7IZYqiMOjR0HQghYXo05JFCNaL5rLGE+wUsI9wohsk=;
 b=E8qPsl41FdPpuq978i2PkCfaR3A3xyNuCsgjDm7I/W2z8CBy4cFwbvQp/EYicqX3Yh
 CeqXalUrIjBOQLrh/5Er/Yx9FzCrvACCPB5GgxQw9IlypfbyZCJfXuwUj5MxJqYNITRp
 c5X9aPi7jcwhwWYaLS00ZdUtnrJ1utJuK/Tyy2V6a7Eug6Qj7Amu2mak6UXaZF92XREv
 qEtkUDXra5f6nWra3D+S54GGoQB3q8Q5KXLyWFFC1YMp6pAMylKvXAKgbmy++P1k9PIj
 eGxblYbCYv6sGLCbsUi8BQjjhNiiHpxESM9pdD0UnMlD67A9w/kxGrzRSMmUoOs+n5OM
 5f9Q==
X-Gm-Message-State: AOAM533HFL4HbQI0TgXHYzZM0q82F3EdQsipgbH9Mx+K9KzagwJVyKyU
 v9//FfZTGv5yoSQj4eGRWYxzyu5d
X-Google-Smtp-Source: ABdhPJxh2IGhgm5+W2XBJf7h6TxmyC662A/NlKfBDpl8PbYrejqkXN0CXK7Xn2ImbEbG7S5r9d6TLQ==
X-Received: by 2002:a17:90a:d17:: with SMTP id
 t23mr16239808pja.77.1589752705836; 
 Sun, 17 May 2020 14:58:25 -0700 (PDT)
Received: from octofox.hsd1.ca.comcast.net
 ([2601:641:400:e00:ed54:ef93:7dc5:e673])
 by smtp.gmail.com with ESMTPSA id h14sm6670139pjc.46.2020.05.17.14.58.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 17 May 2020 14:58:25 -0700 (PDT)
From: Max Filippov <jcmvbkbc@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 1/2] target/xtensa: fetch HW version from configuration overlay
Date: Sun, 17 May 2020 14:58:13 -0700
Message-Id: <20200517215814.19623-2-jcmvbkbc@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200517215814.19623-1-jcmvbkbc@gmail.com>
References: <20200517215814.19623-1-jcmvbkbc@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=jcmvbkbc@gmail.com; helo=mail-pl1-x62a.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -15
X-Spam_score: -1.6
X-Spam_bar: -
X-Spam_report: (-1.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 FROM_LOCAL_NOVOWEL=0.5, HK_RANDOM_ENVFROM=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Max Filippov <jcmvbkbc@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Xtensa architecture has features which behavior depends on hardware
version. Provide hardware version information to translators: add
XtensaConfig::hw_version and use XCHAL_HW_VERSION from configuration
overlay to initialize it.

Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
---
 target/xtensa/cpu.h          | 1 +
 target/xtensa/overlay_tool.h | 8 +++++---
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/target/xtensa/cpu.h b/target/xtensa/cpu.h
index 7a46dccbe11b..32749378bfc7 100644
--- a/target/xtensa/cpu.h
+++ b/target/xtensa/cpu.h
@@ -464,6 +464,7 @@ struct XtensaConfig {
     XtensaMemory sysrom;
     XtensaMemory sysram;
 
+    unsigned hw_version;
     uint32_t configid[2];
 
     void *isa_internal;
diff --git a/target/xtensa/overlay_tool.h b/target/xtensa/overlay_tool.h
index cab532095c9e..a994e69b6e96 100644
--- a/target/xtensa/overlay_tool.h
+++ b/target/xtensa/overlay_tool.h
@@ -60,8 +60,9 @@
 #define XCHAL_RESET_VECTOR1_VADDR XCHAL_RESET_VECTOR_VADDR
 #endif
 
-#ifndef XCHAL_HW_MIN_VERSION
-#define XCHAL_HW_MIN_VERSION 0
+#ifndef XCHAL_HW_VERSION
+#define XCHAL_HW_VERSION (XCHAL_HW_VERSION_MAJOR * 100 \
+                          + XCHAL_HW_VERSION_MINOR)
 #endif
 
 #ifndef XCHAL_LOOP_BUFFER_SIZE
@@ -100,7 +101,7 @@
     XCHAL_OPTION(XCHAL_HAVE_FP, XTENSA_OPTION_FP_COPROCESSOR) | \
     XCHAL_OPTION(XCHAL_HAVE_RELEASE_SYNC, XTENSA_OPTION_MP_SYNCHRO) | \
     XCHAL_OPTION(XCHAL_HAVE_S32C1I, XTENSA_OPTION_CONDITIONAL_STORE) | \
-    XCHAL_OPTION(((XCHAL_HAVE_S32C1I && XCHAL_HW_MIN_VERSION >= 230000) || \
+    XCHAL_OPTION(((XCHAL_HAVE_S32C1I && XCHAL_HW_VERSION >= 230000) || \
                   XCHAL_HAVE_EXCLUSIVE), XTENSA_OPTION_ATOMCTL) | \
     XCHAL_OPTION(XCHAL_HAVE_DEPBITS, XTENSA_OPTION_DEPBITS) | \
     /* Interrupts and exceptions */ \
@@ -498,6 +499,7 @@
     }
 
 #define CONFIG_SECTION \
+    .hw_version = XCHAL_HW_VERSION, \
     .configid = { \
         XCHAL_HW_CONFIGID0, \
         XCHAL_HW_CONFIGID1, \
-- 
2.20.1



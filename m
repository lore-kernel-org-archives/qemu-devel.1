Return-Path: <SRS0=muh1=7E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50743C433E1
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2020 16:25:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1F8B720723
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2020 16:25:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GNUp0U1n"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F8B720723
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33340 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jcAUD-0006it-E8
	for qemu-devel@archiver.kernel.org; Fri, 22 May 2020 12:25:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40490)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1jcAKe-0003Rm-6P
 for qemu-devel@nongnu.org; Fri, 22 May 2020 12:15:36 -0400
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643]:43099)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1jcAKd-0006I8-86
 for qemu-devel@nongnu.org; Fri, 22 May 2020 12:15:35 -0400
Received: by mail-pl1-x643.google.com with SMTP id k22so4567170pls.10
 for <qemu-devel@nongnu.org>; Fri, 22 May 2020 09:15:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=A/nKw6Isa4Oy51HOhG9UE8FR/bJbLBceggcTqOyEfB0=;
 b=GNUp0U1nhxuxngkyDMTNsnpGA/d53w6KxMd8KlP/3m7zeATcCIG7xrrSyIBqYMFBuM
 aghOEnTh/k82NwcDMLQXbC+5HkJXN45Q3QxXbOVGGrC6jJFIx7Y2dUXaS/ookwmGRP/X
 qMGatvSQU975cg4iXHgLIS+nzHufl63e2b2u/xkMSBR+GZ1kx0Niewnir32DD0vyzwTv
 AaqKHdmAfU/7BHHpTPtfOAJUO0TXonPl+mkGHAPJkmGDhgUcEPFjjqOD0aRrtwFiaJho
 mriiQYnJbmC88D0wQzawIRCulCUwxhNNCU6YmIHEF4A1bLrJz/315PYXyojL5xrrwQjl
 ac6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=A/nKw6Isa4Oy51HOhG9UE8FR/bJbLBceggcTqOyEfB0=;
 b=A+F/KXf5RhaOSBV5e5OejE7EPgVgf3BFwiIIfEAIV+FSUVpnCMB/Z7J4iSiZ3oYNa4
 ks1HtUxCYDWb4lGt2ReymI2oRam9AbRCgELLJ5m7YgZ0wZpa/COVd01MTIb//f39NB4V
 OQPi8Y12ZW2H7NPHed3GT0cN9uw4hXnO/LlxUDACe70G34fLbl6hb9Q2JQyW8/FkDv4m
 EZXnxfWm7LCOqrRZnNJ16B4AQwe7gKZvYnMsDk8m7iJ0vUn+9VBcniRY9aNjxkLDyLdA
 dtkzciaajO+95LyxL0TiNOpgFKcTg++Ke+Hac0cpV/hPPqxkumErgcKp553m2Qxl4Ag0
 rgfg==
X-Gm-Message-State: AOAM531E/J8zeewGkPBolYzrrQaLnjtEarh8qc5nvgLBumhHKp63WUlV
 Db7UnwdBdvMtvxq5HnKNzyyEXlkl6OTbrA==
X-Google-Smtp-Source: ABdhPJys21ul8aDdEdjRji90tJOwobuTXZmcDYOj8bqY+tDMDzG35LNfgEPTjyTieiqNDSUhOZ27OQ==
X-Received: by 2002:a17:902:8d8d:: with SMTP id
 v13mr15554071plo.67.1590164133603; 
 Fri, 22 May 2020 09:15:33 -0700 (PDT)
Received: from Rfoley-MA01.hsd1.ma.comcast.net
 ([2601:199:4480:60c0:f1d9:5fce:c451:d2e2])
 by smtp.gmail.com with ESMTPSA id y75sm7255428pfb.212.2020.05.22.09.15.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 May 2020 09:15:33 -0700 (PDT)
From: Robert Foley <robert.foley@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 17/19] util: Added tsan annotate for thread name.
Date: Fri, 22 May 2020 12:07:53 -0400
Message-Id: <20200522160755.886-18-robert.foley@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200522160755.886-1-robert.foley@linaro.org>
References: <20200522160755.886-1-robert.foley@linaro.org>
Received-SPF: pass client-ip=2607:f8b0:4864:20::643;
 envelope-from=robert.foley@linaro.org; helo=mail-pl1-x643.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: peter.puhov@linaro.org, cota@braap.org, alex.bennee@linaro.org,
 robert.foley@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This allows us to see the name of the thread in tsan
warning reports such as this:

  Thread T7 'CPU 1/TCG' (tid=24317, running) created by main thread at:

Signed-off-by: Robert Foley <robert.foley@linaro.org>
---
 util/qemu-thread-posix.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/util/qemu-thread-posix.c b/util/qemu-thread-posix.c
index 838980aaa5..dcbc82d80f 100644
--- a/util/qemu-thread-posix.c
+++ b/util/qemu-thread-posix.c
@@ -15,6 +15,7 @@
 #include "qemu/atomic.h"
 #include "qemu/notify.h"
 #include "qemu-thread-common.h"
+#include "qemu/tsan.h"
 
 static bool name_threads;
 
@@ -513,6 +514,7 @@ static void *qemu_thread_start(void *args)
 # endif
     }
 #endif
+    TSAN_ANNOTATE_THREAD_NAME(qemu_thread_args->name);
     g_free(qemu_thread_args->name);
     g_free(qemu_thread_args);
     pthread_cleanup_push(qemu_thread_atexit_notify, NULL);
-- 
2.17.1



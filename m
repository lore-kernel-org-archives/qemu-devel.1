Return-Path: <SRS0=GK8b=7B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11C20C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2020 17:22:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D6BEF2075F
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2020 17:22:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KYOlebpO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D6BEF2075F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33830 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jb5wK-000493-0c
	for qemu-devel@archiver.kernel.org; Tue, 19 May 2020 13:22:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57080)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ahmedkhaledkaraman@gmail.com>)
 id 1jb50S-00008h-40
 for qemu-devel@nongnu.org; Tue, 19 May 2020 12:22:16 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:34112)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ahmedkhaledkaraman@gmail.com>)
 id 1jb50R-0008Uo-Ch
 for qemu-devel@nongnu.org; Tue, 19 May 2020 12:22:15 -0400
Received: by mail-wr1-x443.google.com with SMTP id y3so102797wrt.1
 for <qemu-devel@nongnu.org>; Tue, 19 May 2020 09:22:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=au8xXNArAeEcrfRxUdWVQbbVD0Wo1gkuJ3rS47HgeWw=;
 b=KYOlebpOeqwHdawsnyQ4lVO3w0fuQzmpHZdb1W4RidJjG19oPWzi6PLYph7wzOkgoq
 /M0IQaCllaXATUsC9EXaXLm8T3T5mcqW5FmOesM0mAKzjJMZTnbEx1/4eTM/Eqdzlzag
 4YAkYWG2R9DOS712Ov5yiRXgjMsuoZzvQGVcGYR2Cks821al1fVfpg9xLXa4FckegWIB
 +aST6Omnb7qaVKzm/llHAXFDabGDXFm3dE6Tod2WWFcaB2oQAZ8T5XXL2mWQTlwWkrhw
 oM+mT0YmKKw0ns+Fz7pVn0Hkt7+s/CIIAAf62ZdJj9gCVEmHfAfLhWIROzDxGIsy97IP
 TPNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=au8xXNArAeEcrfRxUdWVQbbVD0Wo1gkuJ3rS47HgeWw=;
 b=Up7pT7XfFstei1kRrwrHlIKA5Sx/5Ae7hqskhME0Dv1lqHioyN3p253GanGzCEV+vM
 UH62sd5YmxSmX9gL7qDdGwS14Zc6mOcOSyCFh0wkC2tY4SlmwHM3RQk7P4QJ3TMpINgT
 mGhX4HfvyVaCPv+y+Zlts/UWwDt3buRQWAi1CbAL2Bjo8/uvL8CfQq9O0cUw09n7sgyF
 puLyRLrqqVYCEHqGgXrnIbp6cK1EANhd0o8KjWhjZj0wW84a8HPW2HgKs/icrhGhMhhX
 2G6RtVcTB6bH1ACCbjOhbATkiSwtV6BxegsHTn1vzLomgfwTJr+YkKlSiiTCyxXYLzas
 FEwA==
X-Gm-Message-State: AOAM531RQxcTT38C2K6VyM/G8x/5aJ+QtMNAMNksH4wy2Ixooish+ZRs
 lyQEX8FDQmpUjJgfYoepVBJohVvz
X-Google-Smtp-Source: ABdhPJzZIcQp7k+eNmRdn4zDxF2hz/5aTFJDy42rNEPnM3B4PAMkG4RHJFtdl0+RUYc/e6K5VsZv4Q==
X-Received: by 2002:adf:f446:: with SMTP id f6mr25985527wrp.75.1589905333866; 
 Tue, 19 May 2020 09:22:13 -0700 (PDT)
Received: from AK-L.domain.name ([41.40.225.250])
 by smtp.gmail.com with ESMTPSA id j190sm202729wmb.33.2020.05.19.09.22.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 May 2020 09:22:13 -0700 (PDT)
From: Ahmed Karaman <ahmedkhaledkaraman@gmail.com>
To: qemu-devel@nongnu.org,
	rth@twiddle.net,
	ysato@users.sourceforge.jp
Subject: [PATCH 2/2] target/rx: Check for page crossings in use_goto_tb()
Date: Tue, 19 May 2020 18:21:44 +0200
Message-Id: <20200519162144.10831-3-ahmedkhaledkaraman@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200519162144.10831-1-ahmedkhaledkaraman@gmail.com>
References: <20200519162144.10831-1-ahmedkhaledkaraman@gmail.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::443;
 envelope-from=ahmedkhaledkaraman@gmail.com; helo=mail-wr1-x443.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_BL=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
X-Mailman-Approved-At: Tue, 19 May 2020 13:21:16 -0400
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
Cc: Ahmed Karaman <ahmedkhaledkaraman@gmail.com>,
 aleksandar.qemu.devel@gmail.com, alex.bennee@linaro.org, stefanha@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Add the page crossings check when using system mode. If this
fix is not applied, a number of bugs may occasionally occur during
target rx system mode emulation.

Rename parameter dc of type DisasContext* to the more common
name ctx, to keep consistency with other targets.

Signed-off-by: Ahmed Karaman <ahmedkhaledkaraman@gmail.com>
---
 target/rx/translate.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/target/rx/translate.c b/target/rx/translate.c
index 61e86653a4..77497ddbfb 100644
--- a/target/rx/translate.c
+++ b/target/rx/translate.c
@@ -143,13 +143,17 @@ void rx_cpu_dump_state(CPUState *cs, FILE *f, int flags)
     }
 }
 
-static bool use_goto_tb(DisasContext *dc, target_ulong dest)
+static bool use_goto_tb(DisasContext *ctx, target_ulong dest)
 {
-    if (unlikely(dc->base.singlestep_enabled)) {
+    if (unlikely(ctx->base.singlestep_enabled)) {
         return false;
-    } else {
-        return true;
     }
+
+#ifndef CONFIG_USER_ONLY
+    return (ctx->base.tb->pc & TARGET_PAGE_MASK) == (dest & TARGET_PAGE_MASK);
+#else
+    return true;
+#endif
 }
 
 static void gen_goto_tb(DisasContext *dc, int n, target_ulong dest)
-- 
2.17.1



Return-Path: <SRS0=UEgn=BO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6414FC433E0
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Aug 2020 16:11:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3B5352086A
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Aug 2020 16:11:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nx34AeO3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B5352086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42634 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k2zX8-0006rB-Gr
	for qemu-devel@archiver.kernel.org; Tue, 04 Aug 2020 12:11:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45148)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1k2zUp-0003MP-Gk
 for qemu-devel@nongnu.org; Tue, 04 Aug 2020 12:08:59 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435]:36197)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1k2zUn-0005mL-SS
 for qemu-devel@nongnu.org; Tue, 04 Aug 2020 12:08:59 -0400
Received: by mail-wr1-x435.google.com with SMTP id 88so37909034wrh.3
 for <qemu-devel@nongnu.org>; Tue, 04 Aug 2020 09:08:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=xPQDalBP2qoLIoG+4RRB4/KzO/Ml5Sn8Tuw/Y/ydU1E=;
 b=nx34AeO3PjOi9dmjw6bOs8pklE4xVIF3U3ca+BlpHY78BIMjaPLXQtCRsM4/c9h/MU
 M75k5lshsdWjPJr2Ragb301uJEFadwdYpJEPjP9lVWfdxZwO1gbx8MTz4dPHtCKDwxWj
 1irYrPOHxdG/z5uEnbrOOKJ2Mysjb1QSeEMsPv5KwISpYNirasbM23dStvwOHIxFGhIZ
 xL2crD8mHaB1q3pLNTIssatVLy/PyecmWY2OuxAxx+wAtmHjaISnScaYDBR5dAndrhmK
 VJcfWLafOKhiYiGgNb2iFg3Sp4vnRxh84AZouq6+fwWFzLQ8LAcOrM/LtFarwW9DFnBh
 i/zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=xPQDalBP2qoLIoG+4RRB4/KzO/Ml5Sn8Tuw/Y/ydU1E=;
 b=dG5HGRT4wrxfyK8D+Fgj7k+Tw2JecknI5PLKPZT6+riV9+3fjGsr0Kmy9VZ/nmi5P7
 ty18IFiwvcQjIo//OLVI3UhMGaHPcPHVxAPmdsQ1zSjYqyc2+FUHMuQjR5FPmdbJEc1V
 j2o0MP7fUv+2qBVXEwHo0oIB4gcqBeRw1I1r8S18gQeGLlogIViHYkBHIqQbmjVLKNY/
 L9RxNjYUJtxl+niBOIf++j/6RE/ryaPgCvP7BNJr66xF9IEgwSkOj7E8WLCEFAdMPPCW
 I9qwGRRRnUwwbghTt8TZj2ioaXsP78yXfNINI+9YMq74k8MuUYtOoVrLgM7tUVVw3ouu
 KmAg==
X-Gm-Message-State: AOAM533CDodPin5lLYX2HuiCER+eY5OJ73v3nBvjgo+Rg5D9nNHzvyKd
 bNBNkbRtC2+H/F+ao3CCI1y4vWHL9Ao38Q==
X-Google-Smtp-Source: ABdhPJy+YTo2UasLXqd1MTESAxHVO+SVn6dtFAjQYvT6sato5wS3JcyaebtWZGHVwD/wVgCfDA6Djg==
X-Received: by 2002:a5d:4603:: with SMTP id t3mr2344786wrq.175.1596557335484; 
 Tue, 04 Aug 2020 09:08:55 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id b186sm5625928wme.1.2020.08.04.09.08.50
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Aug 2020 09:08:52 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 2/2] target/arm: Fix decode of LDRA[AB] instructions
Date: Tue,  4 Aug 2020 17:08:43 +0100
Message-Id: <20200804160843.30245-3-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200804160843.30245-1-peter.maydell@linaro.org>
References: <20200804160843.30245-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x435.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Peter Collingbourne <pcc@google.com>

These instructions use zero as the discriminator, not SP.

Signed-off-by: Peter Collingbourne <pcc@google.com>
Message-id: 20200804002849.30268-1-pcc@google.com
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/translate-a64.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index c98dfb17a83..534c3ff5f37 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -3429,9 +3429,11 @@ static void disas_ldst_pac(DisasContext *s, uint32_t insn,
 
     if (s->pauth_active) {
         if (use_key_a) {
-            gen_helper_autda(dirty_addr, cpu_env, dirty_addr, cpu_X[31]);
+            gen_helper_autda(dirty_addr, cpu_env, dirty_addr,
+                             new_tmp_a64_zero(s));
         } else {
-            gen_helper_autdb(dirty_addr, cpu_env, dirty_addr, cpu_X[31]);
+            gen_helper_autdb(dirty_addr, cpu_env, dirty_addr,
+                             new_tmp_a64_zero(s));
         }
     }
 
-- 
2.20.1



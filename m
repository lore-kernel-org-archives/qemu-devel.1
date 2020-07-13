Return-Path: <SRS0=6r5r=AY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70BE0C433E6
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 14:23:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4054A2065F
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 14:23:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ddd+bg16"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4054A2065F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46290 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1juzMx-0002Q0-D3
	for qemu-devel@archiver.kernel.org; Mon, 13 Jul 2020 10:23:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35416)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1juzB7-0005fi-Qe
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 10:11:33 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e]:38397)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1juzB4-0006fX-JX
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 10:11:33 -0400
Received: by mail-wm1-x32e.google.com with SMTP id f18so13314615wml.3
 for <qemu-devel@nongnu.org>; Mon, 13 Jul 2020 07:11:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=Cdhqjn6DC+tyL4mM8vOGKC1yiyZ8aG8bFSKcjvY6BCA=;
 b=ddd+bg16ye3YpIR55s7DTgTJ3Q/eYBt/i5KRdpawkacrwJioidzHPROl3wWTN5GWsK
 15AsLXheXop8FlPL0R9ZpmzrNtqObyynutOGyVCjM7lNTGNz79fk/FS2q3mBykR1GmVH
 U50VU6GlJMlSjoWlahodHq17zm2890bxNRkAW581tAF49zwM8onoFRbNd1bZAkPH9KJJ
 ry9F6yopoE2mhrjxJl29/cZf6UTtNOGyXaTWTRZ+PNj27u+ebuPzhackdqRnK8tcr94N
 ZnJc8a0ZVwDpWnsQIPgYhXJiTV78NsSxL/E262xNYyxAOXtmafERPqq1SyzkQysTDueO
 NfOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Cdhqjn6DC+tyL4mM8vOGKC1yiyZ8aG8bFSKcjvY6BCA=;
 b=VG8gM0JEzIdL6WkC1FbrM4/q+n9cbfha+G8N8r0dL/CnLueWlGeCGC1ev9QDiFNd+9
 v0K7mavK9ZznWgvDecGjgS15d0WpfV17b2n71YinwyWg5Mzp668p/iSlnWLz6PnZveF9
 vmrkIpxht0p+sRLI9U9HxQv3laJsluuyw+bbWbb5qve/DuXSOfRckFpDDvdw2dCWXuiQ
 1BakOpj5XpZcbiCavOvwN6Xd/6zX1u/JIUjt5yX0Kz8j6bULdY3BaGnI8OlqzLJXsRJ/
 9AEIctl9YMDuXJRExmz2x9Q8d/iZNR0J9djQVrCLfAmRp4f+Xs0BZrbpIdA7eDKbwLLH
 0WSQ==
X-Gm-Message-State: AOAM532kA56+w8a7R2qyar61t420bIjseKBdNdkW2wZptP4WwkQ98Y0X
 C/QYbZQQ31wim8tG4hgbq9/zxbse3fiSvg==
X-Google-Smtp-Source: ABdhPJzWLscBjqxNvWfXtsAUt0ViBqfZqUsKYBiKVV+nj4B1tjQTBXjgvG1qDdikUbD5tw8m5YfKWg==
X-Received: by 2002:a1c:7313:: with SMTP id d19mr123377wmb.147.1594649488783; 
 Mon, 13 Jul 2020 07:11:28 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id c136sm24031297wmd.10.2020.07.13.07.11.27
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Jul 2020 07:11:28 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 20/25] hw/nios2: exit to main CPU loop only when unmasking
 interrupts
Date: Mon, 13 Jul 2020 15:10:59 +0100
Message-Id: <20200713141104.5139-21-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200713141104.5139-1-peter.maydell@linaro.org>
References: <20200713141104.5139-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32e.google.com
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

From: Wentong Wu <wentong.wu@intel.com>

Only when guest code is unmasking interrupts, terminate the excution
of translated code and exit to the main CPU loop to handle previous
pended interrupts because of the interrupts mask by guest code.

Signed-off-by: Wentong Wu <wentong.wu@intel.com>
Message-id: 20200710233433.19729-4-wentong.wu@intel.com
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/nios2/cpu_pic.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/nios2/cpu_pic.c b/hw/nios2/cpu_pic.c
index 1c1989d56a0..5ea7e52ab83 100644
--- a/hw/nios2/cpu_pic.c
+++ b/hw/nios2/cpu_pic.c
@@ -54,7 +54,8 @@ static void nios2_pic_cpu_handler(void *opaque, int irq, int level)
 
 void nios2_check_interrupts(CPUNios2State *env)
 {
-    if (env->irq_pending) {
+    if (env->irq_pending &&
+        (env->regs[CR_STATUS] & CR_STATUS_PIE)) {
         env->irq_pending = 0;
         cpu_interrupt(env_cpu(env), CPU_INTERRUPT_HARD);
     }
-- 
2.20.1



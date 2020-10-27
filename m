Return-Path: <SRS0=gwGE=EC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68D9CC388F9
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 12:25:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ABD5622447
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 12:25:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VMxeyaQf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ABD5622447
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49082 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXO2u-0006ZZ-Pl
	for qemu-devel@archiver.kernel.org; Tue, 27 Oct 2020 08:25:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51424)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kXNPG-0001BD-Tw
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 07:44:55 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330]:39774)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kXNPA-0004OM-FX
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 07:44:48 -0400
Received: by mail-wm1-x330.google.com with SMTP id d3so1100831wma.4
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2020 04:44:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=iTvc3T70pvdWTHtlfKDHy8YrwyuK0oy3wEHmDLwdEtk=;
 b=VMxeyaQfzXVNlvzc+YS68zACmnDQ3ktx72vQTzuYrDaNzbRQUxydJoZpMXqiO95h3r
 tKPZdqJVi5cD2SFw2n6qpIJhXs2D1tiCOPDB5WSvGNTYyeROybEht1TO09rcVMdoFad+
 wmeFjd+kO69L2ZFF7hrSmY/nnfbBc7D+Ihctc59q/ZsOrI/eCRGLySCN9jKkbbTprtWK
 W46R3YYuSQrz70G+6vaLpgY/qSV6PWI5zF6FSWcDCJg910/f2rXf2knd5f1+MaM2VITh
 pqy8QxEm4ET/G/AuyMh+AyoveraukH/D9Lg4rB++8aaf8yyJIEuBNxiDH1gocEm5+1lh
 qVxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=iTvc3T70pvdWTHtlfKDHy8YrwyuK0oy3wEHmDLwdEtk=;
 b=kwM2ire+hHwhZCcJFY/YJmocMu9r0iz2Dkjj2UKRQihgHt8hjs7PcTHaK+Rw1m86Cy
 lsZwl6+lT7IZrZ8AyuwCYT8ZNikkCigWEM2XCwQy3fxXec8rKitm0RhMphBdVXKemf/b
 6WOGjElBvmiY1bw7ZjRNV3gnTntv9kB/JA2Gjr9uKMPlFjxw3tFqQ3/FsudTP39rRU/S
 hW60UJne+6OFlaVc/yuL4Z3IUzilnPnHNXlaqj8KsbQ8em6AkVhlkb7Wk78waiJ2SB9I
 Np+/g92oxmoVW0Uw3RgjBFWEV4U/XgdU8i2ci3xBzfSOcXc68MarRRghFt57nD1DpDpZ
 N1Gg==
X-Gm-Message-State: AOAM530eCxdc2VZoS0XuKz8Oj2TovO35zIIpfbYOyvkasVUNI9YQrJ+X
 SrYuIzycIHz0CPiZkJLSWFgvPb5f1G+jJA==
X-Google-Smtp-Source: ABdhPJyDBi6pK2J7hOZjIDLLLC56owkJnXWGdpLsxBlp0hzjqrz06rOBW2msrEHIKJnvixS+r0Rdmg==
X-Received: by 2002:a7b:c387:: with SMTP id s7mr2266671wmj.52.1603799081931;
 Tue, 27 Oct 2020 04:44:41 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id 32sm1712203wro.31.2020.10.27.04.44.41
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Oct 2020 04:44:41 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 01/48] linux-user/aarch64: Reset btype for signals
Date: Tue, 27 Oct 2020 11:43:51 +0000
Message-Id: <20201027114438.17662-2-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201027114438.17662-1-peter.maydell@linaro.org>
References: <20201027114438.17662-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x330.google.com
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

From: Richard Henderson <richard.henderson@linaro.org>

The kernel sets btype for the signal handler as if for a call.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20201021173749.111103-2-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 linux-user/aarch64/signal.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/linux-user/aarch64/signal.c b/linux-user/aarch64/signal.c
index d50c1ae5838..b591790c22e 100644
--- a/linux-user/aarch64/signal.c
+++ b/linux-user/aarch64/signal.c
@@ -506,10 +506,16 @@ static void target_setup_frame(int usig, struct target_sigaction *ka,
             + offsetof(struct target_rt_frame_record, tramp);
     }
     env->xregs[0] = usig;
-    env->xregs[31] = frame_addr;
     env->xregs[29] = frame_addr + fr_ofs;
-    env->pc = ka->_sa_handler;
     env->xregs[30] = return_addr;
+    env->xregs[31] = frame_addr;
+    env->pc = ka->_sa_handler;
+
+    /* Invoke the signal handler as if by indirect call.  */
+    if (cpu_isar_feature(aa64_bti, env_archcpu(env))) {
+        env->btype = 2;
+    }
+
     if (info) {
         tswap_siginfo(&frame->info, info);
         env->xregs[1] = frame_addr + offsetof(struct target_rt_sigframe, info);
-- 
2.20.1



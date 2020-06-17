Return-Path: <SRS0=bzpH=76=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82C51C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 21:22:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4D6492168B
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 21:22:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wQf05jCF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D6492168B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49998 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlfWH-0001oq-Hj
	for qemu-devel@archiver.kernel.org; Wed, 17 Jun 2020 17:22:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37764)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1jlfEQ-0003xI-5T
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 17:04:26 -0400
Received: from mail-qt1-x843.google.com ([2607:f8b0:4864:20::843]:44356)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1jlfEO-0000L1-C0
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 17:04:25 -0400
Received: by mail-qt1-x843.google.com with SMTP id c12so2731224qtq.11
 for <qemu-devel@nongnu.org>; Wed, 17 Jun 2020 14:04:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=UmLKvFwmPDwDSuHmbH2s4seTobiEOYrK5RpLD5v7Faw=;
 b=wQf05jCFx79dmRxlxL1PmGqqSKLC9c6eW/LaqnWK1CEeBjBeKAVylzLKyCNhPWuqr9
 WQEb2HOvQXd4R1qzMd4+51sszktA5wNJ+Pwm5ziHlQWacWZPvHUwXOkFWt6soOtXQOqa
 M41I9N459JII+PpvLLlGfIunnmSgnzSlgEKEeDnx8t/dq7Y75l7/rvGHJJY/bdGilZ4k
 Znilb63gDiZEsnrLkrkuSltwcNbX13z7KTrc2wLWKMi2lF3bGV3Z2ULhZUPmPOp822Wn
 paMdRH++xtms45qrLN1p3ulJlrWyC+stAf7ckC9rR3FbhwJqWmQuhCEdzOO1h0UvV4X6
 3/Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=UmLKvFwmPDwDSuHmbH2s4seTobiEOYrK5RpLD5v7Faw=;
 b=fVahgagzvFlXyZVlSrfwAgVBV8J1jK8gWzBvqqk5B68McmiN2AXNgNcWAkgxqgKbcU
 oEfhgzScDxfjMGhnndgzVZ7Z58+q5jTO8c8OCpP0WsGPbKPBQkYNR616D7yZNK+u51sl
 lJdIiMV+RcO9P1Jk6iXdYH7uX58VIti38JT6+LuJt2WMSBZ08RiO5pK6xLRv38kC2PCc
 sHZRdInFlSV4bVEggO/TDjxa4zXUanhtdHA1NgUqZwU4FwiMlru33FXGmDM5Ih753l+s
 LAvIXpuoMgTK2SLwj1E+LOzxJia2GI8zqtnoloVBbEsgTOE8vhEO1qGsIDkkL9HgGwRT
 eAdg==
X-Gm-Message-State: AOAM531zn+v7HWgxcgTj1hgmIuT5YQLCA6okFB35Sk9OwreFHE1R0vO4
 wY6vg/4lL7Lo7OqN6faR3OrdsfNO03GTyA==
X-Google-Smtp-Source: ABdhPJzEegUqYHlHUUoAPmnDXDpbVwuxkP8Qapk/X915gRyaiqiu3E+d32E+Q5j5Ma3NvfVDF75JKw==
X-Received: by 2002:aed:33e2:: with SMTP id v89mr1126320qtd.129.1592427863196; 
 Wed, 17 Jun 2020 14:04:23 -0700 (PDT)
Received: from Rfoley-MA01.hsd1.ma.comcast.net
 ([2601:199:4480:60c0:fc79:714c:9711:2e9c])
 by smtp.gmail.com with ESMTPSA id w13sm997245qkb.91.2020.06.17.14.04.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jun 2020 14:04:22 -0700 (PDT)
From: Robert Foley <robert.foley@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v10 46/73] cris: convert to cpu_interrupt_request
Date: Wed, 17 Jun 2020 17:02:04 -0400
Message-Id: <20200617210231.4393-47-robert.foley@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200617210231.4393-1-robert.foley@linaro.org>
References: <20200617210231.4393-1-robert.foley@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::843;
 envelope-from=robert.foley@linaro.org; helo=mail-qt1-x843.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Cc: peter.puhov@linaro.org, cota@braap.org, alex.bennee@linaro.org,
 robert.foley@linaro.org, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Emilio G. Cota" <cota@braap.org>

Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Emilio G. Cota <cota@braap.org>
Signed-off-by: Robert Foley <robert.foley@linaro.org>
---
 target/cris/cpu.c    | 2 +-
 target/cris/helper.c | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/target/cris/cpu.c b/target/cris/cpu.c
index cff6b9eabf..6d7e266042 100644
--- a/target/cris/cpu.c
+++ b/target/cris/cpu.c
@@ -37,7 +37,7 @@ static void cris_cpu_set_pc(CPUState *cs, vaddr value)
 
 static bool cris_cpu_has_work(CPUState *cs)
 {
-    return cs->interrupt_request & (CPU_INTERRUPT_HARD | CPU_INTERRUPT_NMI);
+    return cpu_interrupt_request(cs) & (CPU_INTERRUPT_HARD | CPU_INTERRUPT_NMI);
 }
 
 static void cris_cpu_reset(DeviceState *dev)
diff --git a/target/cris/helper.c b/target/cris/helper.c
index b5159b8357..67946d9246 100644
--- a/target/cris/helper.c
+++ b/target/cris/helper.c
@@ -131,7 +131,7 @@ void crisv10_cpu_do_interrupt(CPUState *cs)
 
     D_LOG("exception index=%d interrupt_req=%d\n",
           cs->exception_index,
-          cs->interrupt_request);
+          cpu_interrupt_request(cs));
 
     if (env->dslot) {
         /* CRISv10 never takes interrupts while in a delay-slot.  */
@@ -193,7 +193,7 @@ void cris_cpu_do_interrupt(CPUState *cs)
 
     D_LOG("exception index=%d interrupt_req=%d\n",
           cs->exception_index,
-          cs->interrupt_request);
+          cpu_interrupt_request(cs));
 
     switch (cs->exception_index) {
     case EXCP_BREAK:
-- 
2.17.1



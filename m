Return-Path: <SRS0=QiA4=7D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1A30C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 17:14:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6863E20759
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 17:14:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AYshm8sm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6863E20759
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45742 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbolm-0007D4-It
	for qemu-devel@archiver.kernel.org; Thu, 21 May 2020 13:14:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50134)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1jboJ8-0004LX-E4
 for qemu-devel@nongnu.org; Thu, 21 May 2020 12:44:34 -0400
Received: from mail-qv1-xf43.google.com ([2607:f8b0:4864:20::f43]:41364)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1jboJ6-0006iM-Bz
 for qemu-devel@nongnu.org; Thu, 21 May 2020 12:44:34 -0400
Received: by mail-qv1-xf43.google.com with SMTP id v15so3358620qvr.8
 for <qemu-devel@nongnu.org>; Thu, 21 May 2020 09:44:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=1b+dD7RxLqaUPVVNgXTFGKKstOqQ+qP/ZFHAKJHyCiE=;
 b=AYshm8smL28Oeb1t6aqqiZYVQrMvEjRj6sVGSTq6eTH3Ez6KB0obAZIVm/dJrRO77O
 Z7cgyObMfKdmGt2IgDNnfLnGh6GYZWJHEyuxIqCIBoMYp2LhrUuDBksisUygP0jFIyWf
 btH/LCjZ8sDGZ+m6miMpOnekuCJFLAcOOYpTxNxCsH9guXwaENK24qiNbJMQXtItblRF
 qgmWllJH5K88LHXcer/LJWjgs7HnlyILmJpCZBudyqfXkCZSp1Ok+UMQM0fSgV7fwChx
 D2oumm7Z72Qnv+/tknijNfTXswVssZWw6R6fvCQxui7CKshDxbONJhboyavuAbyFFoyA
 VVQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=1b+dD7RxLqaUPVVNgXTFGKKstOqQ+qP/ZFHAKJHyCiE=;
 b=a5EfG+uO+qHKfVCHOie9v4l6duSWCB7rkns6Lu88cKHq/yJ4MJFhRuLDnJxq91R/tC
 EfZm97nFmtImWyEOIMcSYTepyxqr27L4zOsezJ2LUnZifMQKbjTPEg/S8gGyXMGsONya
 6rljbqcf5EbAJDbr9wHNXTt++e1xnMb2gsORKezpf2paXogj14SNW7DnTKFZBUvlUwzY
 ZFApwdrntMiAau6WkqTkpcwQv1IsUr3baoDEOtuxPDk3gDyp6aHRubvbPtqitx1AlC9T
 Coeoad2wUMz+bVTmvY19PVQ6RRPou+Tk1Sb7hzKkfS9OQ12zYV/i2TYgaYD8TYLb3UUV
 3Xtg==
X-Gm-Message-State: AOAM531Mh5ywzKaHnFECZ3s/Dj0y59YzIpncFRHnf5BR3hq8k6KhNXJQ
 FMAqguGFfSGmNEuEw0DBdu1kW30TNVrCvQ==
X-Google-Smtp-Source: ABdhPJwEX2e/2ePxWwf/PCCM2LwHHOfFyeBnlTON+yahqZJdmE2z/aCjk44QX4Bo6740BOgFeEjaSA==
X-Received: by 2002:ad4:4b01:: with SMTP id r1mr10604609qvw.38.1590079471367; 
 Thu, 21 May 2020 09:44:31 -0700 (PDT)
Received: from Rfoley-MA01.hsd1.ma.comcast.net
 ([2601:199:4480:60c0:1944:c530:655c:5583])
 by smtp.gmail.com with ESMTPSA id x24sm5923829qth.57.2020.05.21.09.44.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 May 2020 09:44:30 -0700 (PDT)
From: Robert Foley <robert.foley@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v9 57/74] openrisc: convert to cpu_interrupt_request
Date: Thu, 21 May 2020 12:39:54 -0400
Message-Id: <20200521164011.638-58-robert.foley@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200521164011.638-1-robert.foley@linaro.org>
References: <20200521164011.638-1-robert.foley@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::f43;
 envelope-from=robert.foley@linaro.org; helo=mail-qv1-xf43.google.com
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
Cc: robert.foley@linaro.org, richard.henderson@linaro.org, cota@braap.org,
 peter.puhov@linaro.org, Stafford Horne <shorne@gmail.com>,
 alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Emilio G. Cota" <cota@braap.org>

Cc: Stafford Horne <shorne@gmail.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Emilio G. Cota <cota@braap.org>
Signed-off-by: Robert Foley <robert.foley@linaro.org>
---
 hw/openrisc/cputimer.c | 2 +-
 target/openrisc/cpu.c  | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/hw/openrisc/cputimer.c b/hw/openrisc/cputimer.c
index 93268815d8..9475b77d0a 100644
--- a/hw/openrisc/cputimer.c
+++ b/hw/openrisc/cputimer.c
@@ -102,7 +102,7 @@ static void openrisc_timer_cb(void *opaque)
         CPUState *cs = CPU(cpu);
 
         cpu->env.ttmr |= TTMR_IP;
-        cs->interrupt_request |= CPU_INTERRUPT_TIMER;
+        cpu_interrupt_request_or(cs, CPU_INTERRUPT_TIMER);
     }
 
     switch (cpu->env.ttmr & TTMR_M) {
diff --git a/target/openrisc/cpu.c b/target/openrisc/cpu.c
index 5528c0918f..fd2da39124 100644
--- a/target/openrisc/cpu.c
+++ b/target/openrisc/cpu.c
@@ -32,8 +32,8 @@ static void openrisc_cpu_set_pc(CPUState *cs, vaddr value)
 
 static bool openrisc_cpu_has_work(CPUState *cs)
 {
-    return cs->interrupt_request & (CPU_INTERRUPT_HARD |
-                                    CPU_INTERRUPT_TIMER);
+    return cpu_interrupt_request(cs) & (CPU_INTERRUPT_HARD |
+                                        CPU_INTERRUPT_TIMER);
 }
 
 static void openrisc_disas_set_info(CPUState *cpu, disassemble_info *info)
-- 
2.17.1



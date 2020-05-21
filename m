Return-Path: <SRS0=QiA4=7D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E0EFC433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 17:12:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4D06A20759
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 17:12:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gyGnLVoc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D06A20759
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38730 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbokD-0003zY-Es
	for qemu-devel@archiver.kernel.org; Thu, 21 May 2020 13:12:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50070)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1jboIx-0004CU-Mn
 for qemu-devel@nongnu.org; Thu, 21 May 2020 12:44:23 -0400
Received: from mail-qk1-x744.google.com ([2607:f8b0:4864:20::744]:33294)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1jboIw-0006f2-RX
 for qemu-devel@nongnu.org; Thu, 21 May 2020 12:44:23 -0400
Received: by mail-qk1-x744.google.com with SMTP id z80so7920000qka.0
 for <qemu-devel@nongnu.org>; Thu, 21 May 2020 09:44:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=lvs+qOX6bs/iZi7N2ZR8e7cxDlqBQWqbjCB2CJTYkPk=;
 b=gyGnLVocNsqusg7aysasSPmEq8EbrQoPhaHALMkIrdkI+AvNly4pE78i1Bu1PYCNVD
 qlwnYH/llKom/fosGdp5qKqr4tG0Bvu1HorIXbHU2OdqMzKE/yMgU5yaAnJSKCNVmlPX
 JUCtdVcIqLC2ZHA2WjvAYgz6FO+Fxyu8aeBBJCJUnZpS4FTYGucfwybRYqvDR44cPSt3
 Fj99KATnODezSf+3PzcfC4DGqJY0aNyxit2B8gGq8iLoYOwWxJ524ZAV2stAqCYd5IAN
 NQ+ORLLPWNthNBYWAEEro2JtgzfmEPJWdkM6k9/P/T4XDJIk+bRtVv0VtXMmBCozn0i/
 8xnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=lvs+qOX6bs/iZi7N2ZR8e7cxDlqBQWqbjCB2CJTYkPk=;
 b=Dp5P22OouW/LEkMvxv2MD5TtNOAo+7B3wGoeAtE2ayY+5kegQRlO96Qw2isNCgyr6J
 A9J4oNnGIZsoBBMhWULW3ktK1LSvfHhuuh2TOMWe/PpGf7T39RjcpWU+8Mnicp/cet/z
 fGji7ywHe11pGePQRMRP6Q21x3M3x4AmxHr3XFwpFt5guu55i9d529oIafS6JX8EWw67
 VY2egJkbqd/VkXJVa9Zuhb75+rEF6c0ykfJ7HmpX1ltdO7bANU8zn/Jhr/1PLfqidEDd
 KXbm6MLedDLVVzREy8ynjoP8kBADaAQ+LLlFZo4kdz+7mm0jAvDl+YtyFvJKjHaVimZK
 Iujw==
X-Gm-Message-State: AOAM532vLt9h4dR1VJ9h2W3XmpJZGfnFyfZLTSA0HSwvrkFx8RvLF4yR
 jC4RwhPLqlBkMLM/wLAz/jRNNAsupF1l1g==
X-Google-Smtp-Source: ABdhPJxCRsKEYiJ3IXN2Q52UA5s5EvSSEwU90+lzihNA4bvHZNdyuNl2InPb3URfRHRSpFG/HqrcAw==
X-Received: by 2002:a37:6fc3:: with SMTP id k186mr7872318qkc.419.1590079461789; 
 Thu, 21 May 2020 09:44:21 -0700 (PDT)
Received: from Rfoley-MA01.hsd1.ma.comcast.net
 ([2601:199:4480:60c0:1944:c530:655c:5583])
 by smtp.gmail.com with ESMTPSA id x24sm5923829qth.57.2020.05.21.09.44.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 May 2020 09:44:21 -0700 (PDT)
From: Robert Foley <robert.foley@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v9 50/74] m68k: convert to cpu_interrupt_request
Date: Thu, 21 May 2020 12:39:47 -0400
Message-Id: <20200521164011.638-51-robert.foley@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200521164011.638-1-robert.foley@linaro.org>
References: <20200521164011.638-1-robert.foley@linaro.org>
Received-SPF: pass client-ip=2607:f8b0:4864:20::744;
 envelope-from=robert.foley@linaro.org; helo=mail-qk1-x744.google.com
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
Cc: richard.henderson@linaro.org, cota@braap.org, alex.bennee@linaro.org,
 robert.foley@linaro.org, peter.puhov@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Emilio G. Cota" <cota@braap.org>

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Signed-off-by: Emilio G. Cota <cota@braap.org>
Signed-off-by: Robert Foley <robert.foley@linaro.org>
---
 target/m68k/cpu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/m68k/cpu.c b/target/m68k/cpu.c
index 72c545149e..f2585154f5 100644
--- a/target/m68k/cpu.c
+++ b/target/m68k/cpu.c
@@ -33,7 +33,7 @@ static void m68k_cpu_set_pc(CPUState *cs, vaddr value)
 
 static bool m68k_cpu_has_work(CPUState *cs)
 {
-    return cs->interrupt_request & CPU_INTERRUPT_HARD;
+    return cpu_interrupt_request(cs) & CPU_INTERRUPT_HARD;
 }
 
 static void m68k_set_feature(CPUM68KState *env, int feature)
-- 
2.17.1



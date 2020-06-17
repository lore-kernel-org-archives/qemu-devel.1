Return-Path: <SRS0=bzpH=76=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA36AC433E1
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 21:33:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7732E2186A
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 21:33:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="q2dc5j9L"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7732E2186A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59026 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlfgt-0001Zg-JX
	for qemu-devel@archiver.kernel.org; Wed, 17 Jun 2020 17:33:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37946)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1jlfEh-0004Jt-FS
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 17:04:43 -0400
Received: from mail-qv1-xf41.google.com ([2607:f8b0:4864:20::f41]:40746)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1jlfEb-0000Ml-JM
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 17:04:42 -0400
Received: by mail-qv1-xf41.google.com with SMTP id e2so1757636qvw.7
 for <qemu-devel@nongnu.org>; Wed, 17 Jun 2020 14:04:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=cWfP+0MUzrrNImWYZpz2KO/NSgj5qKMFSKUqs77s2xU=;
 b=q2dc5j9LGIKDmehInfKJjEb6jmYURGpk8RoLvw8cVtWLlWYhcWg2N9AmUjEN5UUJHm
 2qfB9d7mVmnA4uh1TEKszpydB3ltf0YnJKZGU8y134vcwpanL/bO7N6UXCMMhFrmrPVL
 dPVkE6LfZmA/hvCdbl46rYkmTbgcgsyxlhnYgeeA3fjo3za5KMKYmOwsGB7ZxCng9uZk
 +qyMy3IX9BbjGGXcvizgB418I+XUJU/mb/sQ8+rrc54qvEkqr2UtzW47Ot7cPbLbfOl2
 tvFkpxKRdbA1uhB75Pi8ePAKEc1sO7uCi2/58VA2CgplS1Z/tKPz3krJb3My8FE6slBt
 uI5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=cWfP+0MUzrrNImWYZpz2KO/NSgj5qKMFSKUqs77s2xU=;
 b=Ib3+2JyJtPVnwAuhrmFtlAETOuIzNwakhzjL/j53WgbHpqkyrFnkpOesjEdH0WpaXi
 eKyALDhndu9MDPFssjkooH7a495VgQ4tSZwGeTvWnpAOQzlHxs449xeKNxLvtChJijTR
 TNFGR+D+uNsPixRebezOaSbk5oxxp0+gfyveVSksZ6pgeOJCfpf0VwgT1UPfvO/yQzQU
 7iR2xOQ3poJ8yZYTqh2Oc1imUuzh1GclSuIPx/flcsssy0fREmJsMb4Gy08AcQlK82iO
 yCSnDdLAtEIK4xDJd2gYE3ZjZmuQaN9Z0yu0LYKE+F6MukT5dutjplkSnwr8xjMtoIFr
 RaEg==
X-Gm-Message-State: AOAM531Y8R80E7msI7x4ZGkBDIv6H7micpN5kg+dUeG3jGIXL5TTFuw4
 4uSbN/1aTwVXYo9V6+H0j2ie/v76JrXM2g==
X-Google-Smtp-Source: ABdhPJzCTtcLN6/WDze13qgbwX91FaKVhh3OB6OSCdJxYdg7Xnf1X5gbtbJJ6URSuI6M63OK2GV/eQ==
X-Received: by 2002:a0c:806e:: with SMTP id 101mr524860qva.173.1592427875727; 
 Wed, 17 Jun 2020 14:04:35 -0700 (PDT)
Received: from Rfoley-MA01.hsd1.ma.comcast.net
 ([2601:199:4480:60c0:fc79:714c:9711:2e9c])
 by smtp.gmail.com with ESMTPSA id w13sm997245qkb.91.2020.06.17.14.04.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jun 2020 14:04:35 -0700 (PDT)
From: Robert Foley <robert.foley@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v10 55/73] sparc: convert to cpu_interrupt_request
Date: Wed, 17 Jun 2020 17:02:13 -0400
Message-Id: <20200617210231.4393-56-robert.foley@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200617210231.4393-1-robert.foley@linaro.org>
References: <20200617210231.4393-1-robert.foley@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::f41;
 envelope-from=robert.foley@linaro.org; helo=mail-qv1-xf41.google.com
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
Cc: robert.foley@linaro.org, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 cota@braap.org, peter.puhov@linaro.org, alex.bennee@linaro.org,
 Artyom Tarasenko <atar4qemu@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Emilio G. Cota" <cota@braap.org>

Cc: Artyom Tarasenko <atar4qemu@gmail.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Signed-off-by: Emilio G. Cota <cota@braap.org>
Signed-off-by: Robert Foley <robert.foley@linaro.org>
---
 hw/sparc64/sparc64.c | 4 ++--
 target/sparc/cpu.c   | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/hw/sparc64/sparc64.c b/hw/sparc64/sparc64.c
index fe9c678459..191ebfbb93 100644
--- a/hw/sparc64/sparc64.c
+++ b/hw/sparc64/sparc64.c
@@ -57,7 +57,7 @@ void cpu_check_irqs(CPUSPARCState *env)
     /* The bit corresponding to psrpil is (1<< psrpil), the next bit
        is (2 << psrpil). */
     if (pil < (2 << env->psrpil)) {
-        if (cs->interrupt_request & CPU_INTERRUPT_HARD) {
+        if (cpu_interrupt_request(cs) & CPU_INTERRUPT_HARD) {
             trace_sparc64_cpu_check_irqs_reset_irq(env->interrupt_index);
             env->interrupt_index = 0;
             cpu_reset_interrupt(cs, CPU_INTERRUPT_HARD);
@@ -88,7 +88,7 @@ void cpu_check_irqs(CPUSPARCState *env)
                 break;
             }
         }
-    } else if (cs->interrupt_request & CPU_INTERRUPT_HARD) {
+    } else if (cpu_interrupt_request(cs) & CPU_INTERRUPT_HARD) {
         trace_sparc64_cpu_check_irqs_disabled(pil, env->pil_in, env->softint,
                                               env->interrupt_index);
         env->interrupt_index = 0;
diff --git a/target/sparc/cpu.c b/target/sparc/cpu.c
index 3f05aba9d6..cef25238a5 100644
--- a/target/sparc/cpu.c
+++ b/target/sparc/cpu.c
@@ -704,7 +704,7 @@ static bool sparc_cpu_has_work(CPUState *cs)
     SPARCCPU *cpu = SPARC_CPU(cs);
     CPUSPARCState *env = &cpu->env;
 
-    return (cs->interrupt_request & CPU_INTERRUPT_HARD) &&
+    return (cpu_interrupt_request(cs) & CPU_INTERRUPT_HARD) &&
            cpu_interrupts_enabled(env);
 }
 
-- 
2.17.1



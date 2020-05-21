Return-Path: <SRS0=QiA4=7D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCDD4C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 17:11:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 90B1220759
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 17:11:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WOlVPG7o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 90B1220759
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33630 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbojI-0001ry-OE
	for qemu-devel@archiver.kernel.org; Thu, 21 May 2020 13:11:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50236)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1jboJL-0004m4-R9
 for qemu-devel@nongnu.org; Thu, 21 May 2020 12:44:47 -0400
Received: from mail-qk1-x742.google.com ([2607:f8b0:4864:20::742]:45697)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1jboJK-0006tD-PV
 for qemu-devel@nongnu.org; Thu, 21 May 2020 12:44:47 -0400
Received: by mail-qk1-x742.google.com with SMTP id i5so7791409qkl.12
 for <qemu-devel@nongnu.org>; Thu, 21 May 2020 09:44:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=xM5F5VKH4+4sC5/UG8rh4cawXyjUH8jNOSP42/FFGNs=;
 b=WOlVPG7otck/gVRhYO+Jc23elD7wfUNztElUGh7nG+igheI00J51UQJQnwIRTmqjde
 r2OUVB73e5ZfrGfinTwDfveRWcJYSCSCoZN330heJ9DkmVi766yaIN4l8bbsY3sPCjTA
 MZE1wRYzk+B9NLd7PmL1Ow+QnpgFTlPX5YnJEuz2wQMVuGX7uXw9dT2Lkk3+y5uK3ckN
 NEkIg55JonbPVUg7Xzaj7yrGU2VzMXBSbOWxmfKiq58HW6DfBfs09/DXG+6JAMZKNzvN
 sD66XKl6u9uVYSCM3Ic74b0h1cdpHZIHCpQB6sNC3uiNaiuQloCHOd7nQm67V2cNJSZo
 rHmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=xM5F5VKH4+4sC5/UG8rh4cawXyjUH8jNOSP42/FFGNs=;
 b=k+UW4guuhHqbjOjoLUGsUuycQXrqQ3EAm0uiCMVSzPDfuZ3PD+1RZPOcAstJe0Ppih
 gTli3o7qTu45BvaCLX39Er5yil11d/8gzhIgsy8OQOl+lORT8lebg6fm7H2Vu3Bjnc3u
 DZZGue1gF1I5qcgxFIUBiNDpDKizLN5vS91nXUH9KKtmuMmMqPuhLvXCA1144Sbjb6ex
 CmBYqARUHssmQkrEIMOUWY6sxVS/ozlCTNQZBlsWt5sw32R8OAqFq7TdrUW+cgAM249y
 phSzdq3s4/Cn7jVysswkjcpGJ6HdoWtR4LOEpSA+xKcJXoOclUgOGc6MEFthtnjCNJki
 /rkQ==
X-Gm-Message-State: AOAM533KmkmXFDK3TctC18aKkwDR01kg+V5by0J7s+gowITT4jLkAPV0
 NW2DPEc7W7tNGm7NCOadSz6g2S3rV1WNZg==
X-Google-Smtp-Source: ABdhPJxX5hXseZH8WZi3XJU4bMVgeGrhs/VO2QA9caPKh+vvAU/1WOMHJBk5WcDmk4Wa2wAc+co/xg==
X-Received: by 2002:a37:4e81:: with SMTP id
 c123mr10463609qkb.467.1590079485560; 
 Thu, 21 May 2020 09:44:45 -0700 (PDT)
Received: from Rfoley-MA01.hsd1.ma.comcast.net
 ([2601:199:4480:60c0:1944:c530:655c:5583])
 by smtp.gmail.com with ESMTPSA id x24sm5923829qth.57.2020.05.21.09.44.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 May 2020 09:44:45 -0700 (PDT)
From: Robert Foley <robert.foley@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v9 68/74] sparc: convert to cpu_has_work_with_iothread_lock
Date: Thu, 21 May 2020 12:40:05 -0400
Message-Id: <20200521164011.638-69-robert.foley@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200521164011.638-1-robert.foley@linaro.org>
References: <20200521164011.638-1-robert.foley@linaro.org>
Received-SPF: pass client-ip=2607:f8b0:4864:20::742;
 envelope-from=robert.foley@linaro.org; helo=mail-qk1-x742.google.com
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
 peter.puhov@linaro.org, alex.bennee@linaro.org,
 Artyom Tarasenko <atar4qemu@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Emilio G. Cota" <cota@braap.org>

Soon we will call cpu_has_work without the BQL.

Cc: Artyom Tarasenko <atar4qemu@gmail.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Acked-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Signed-off-by: Emilio G. Cota <cota@braap.org>
Signed-off-by: Robert Foley <robert.foley@linaro.org>
---
 target/sparc/cpu.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/target/sparc/cpu.c b/target/sparc/cpu.c
index cef25238a5..3fa1a535d9 100644
--- a/target/sparc/cpu.c
+++ b/target/sparc/cpu.c
@@ -704,6 +704,8 @@ static bool sparc_cpu_has_work(CPUState *cs)
     SPARCCPU *cpu = SPARC_CPU(cs);
     CPUSPARCState *env = &cpu->env;
 
+    g_assert(qemu_mutex_iothread_locked());
+
     return (cpu_interrupt_request(cs) & CPU_INTERRUPT_HARD) &&
            cpu_interrupts_enabled(env);
 }
@@ -863,7 +865,7 @@ static void sparc_cpu_class_init(ObjectClass *oc, void *data)
 
     cc->class_by_name = sparc_cpu_class_by_name;
     cc->parse_features = sparc_cpu_parse_features;
-    cc->has_work = sparc_cpu_has_work;
+    cc->has_work_with_iothread_lock = sparc_cpu_has_work;
     cc->do_interrupt = sparc_cpu_do_interrupt;
     cc->cpu_exec_interrupt = sparc_cpu_exec_interrupt;
     cc->dump_state = sparc_cpu_dump_state;
-- 
2.17.1



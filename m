Return-Path: <SRS0=QiA4=7D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CF1EC433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 17:21:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2A34D2072C
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 17:21:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ssOVXhEK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A34D2072C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52774 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbot6-0007Za-BE
	for qemu-devel@archiver.kernel.org; Thu, 21 May 2020 13:21:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50244)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1jboJN-0004pe-3n
 for qemu-devel@nongnu.org; Thu, 21 May 2020 12:44:49 -0400
Received: from mail-qk1-x731.google.com ([2607:f8b0:4864:20::731]:46885)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1jboJM-0006wx-5H
 for qemu-devel@nongnu.org; Thu, 21 May 2020 12:44:48 -0400
Received: by mail-qk1-x731.google.com with SMTP id f83so7783071qke.13
 for <qemu-devel@nongnu.org>; Thu, 21 May 2020 09:44:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=FcchR0Kiy3cS07PsythDlOBOqbmqT9MEDX8/TYIcoYY=;
 b=ssOVXhEK6Z62VXfIfsH/COP+Fd77hFrjpA8KjOFhyLqtpHqSG3Oyh0sIOHsjrjPUSL
 nyjYyXPxfHs8Wo/8OP+sUkzB+j25EH09I7m4C+pGWfjuSaVl6NDVULdvZu31A0q1lPgE
 44HIUcYV0ahm96G5y7TrfLwcOjOK3HrJjZoOuZWtqYuXtaVfnsUSBPr26kzJzeREt65C
 D/pCe+2bEuT7uZg1ecmRLZ6kuzKdiMwKpANF4Wm5ZxmliBx4Go69ALhBnSGfrt+LD5J1
 /yzUsOnFotN9/mdgRdiecSHFFPtQCIV+oXh86YMXJf1hSs9odlX0c4V+MpUGB3FLupl3
 9g2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=FcchR0Kiy3cS07PsythDlOBOqbmqT9MEDX8/TYIcoYY=;
 b=O5Alz5hgoAkwdHfElxmgqpcO6xakJR/8w6S3PqYQYHfR5++CX9ukp4of1hhbTYfq0y
 ug536XbHYRJYFcrVzRq8CxGucVNXStUS8CLMBKhilMd1nNBAjKdG4w09W9LnqD8NE5Wu
 wik5gHX50fQyXzme0v5wD530BQUWy/teNiaG94TH6anQdjwIJILxfqNUs6yiPDqV3hBx
 0clN0gYkw5qXDkOMJKrxEdKRWjL1Sp8FKU6c+WTNMbvW+X8AUtL3T7l7m7QqaNeCFzbQ
 3yCl+xrO7r9Gq7z7JDakhys6fvjwB9wdtrq+/Kr+544cNoZ0iELdyH3H6HdDmN0T7bcu
 E7fA==
X-Gm-Message-State: AOAM53122MVUxav4yPPJ/Pq8IAD62GMTdsCZPrn0VyBq6tlgnrMIRn29
 cJO1NW5XaMeTkz2GxPnpqTbkzNc2SvCCrw==
X-Google-Smtp-Source: ABdhPJwYDzCsf/NOUruPxe0+/ZMq+Xn2vKo0dk4BooVAsFboa0LdHnZzaQBwBPTieISf3DpDEh5FyQ==
X-Received: by 2002:a37:46c9:: with SMTP id t192mr7541261qka.3.1590079486957; 
 Thu, 21 May 2020 09:44:46 -0700 (PDT)
Received: from Rfoley-MA01.hsd1.ma.comcast.net
 ([2601:199:4480:60c0:1944:c530:655c:5583])
 by smtp.gmail.com with ESMTPSA id x24sm5923829qth.57.2020.05.21.09.44.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 May 2020 09:44:46 -0700 (PDT)
From: Robert Foley <robert.foley@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v9 69/74] xtensa: convert to cpu_has_work_with_iothread_lock
Date: Thu, 21 May 2020 12:40:06 -0400
Message-Id: <20200521164011.638-70-robert.foley@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200521164011.638-1-robert.foley@linaro.org>
References: <20200521164011.638-1-robert.foley@linaro.org>
Received-SPF: pass client-ip=2607:f8b0:4864:20::731;
 envelope-from=robert.foley@linaro.org; helo=mail-qk1-x731.google.com
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
Cc: robert.foley@linaro.org, richard.henderson@linaro.org,
 Max Filippov <jcmvbkbc@gmail.com>, cota@braap.org, peter.puhov@linaro.org,
 alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Emilio G. Cota" <cota@braap.org>

Soon we will call cpu_has_work without the BQL.

Cc: Max Filippov <jcmvbkbc@gmail.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Emilio G. Cota <cota@braap.org>
Signed-off-by: Robert Foley <robert.foley@linaro.org>
---
 target/xtensa/cpu.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/target/xtensa/cpu.c b/target/xtensa/cpu.c
index fda4a73722..0f96483563 100644
--- a/target/xtensa/cpu.c
+++ b/target/xtensa/cpu.c
@@ -47,6 +47,8 @@ static bool xtensa_cpu_has_work(CPUState *cs)
 #ifndef CONFIG_USER_ONLY
     XtensaCPU *cpu = XTENSA_CPU(cs);
 
+    g_assert(qemu_mutex_iothread_locked());
+
     return !cpu->env.runstall && cpu->env.pending_irq_level;
 #else
     return true;
@@ -187,7 +189,7 @@ static void xtensa_cpu_class_init(ObjectClass *oc, void *data)
     device_class_set_parent_reset(dc, xtensa_cpu_reset, &xcc->parent_reset);
 
     cc->class_by_name = xtensa_cpu_class_by_name;
-    cc->has_work = xtensa_cpu_has_work;
+    cc->has_work_with_iothread_lock = xtensa_cpu_has_work;
     cc->do_interrupt = xtensa_cpu_do_interrupt;
     cc->cpu_exec_interrupt = xtensa_cpu_exec_interrupt;
     cc->dump_state = xtensa_cpu_dump_state;
-- 
2.17.1



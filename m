Return-Path: <SRS0=Dj2y=5L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76BA2C43331
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 19:55:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 404FD206E6
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 19:55:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nwEmC8r1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 404FD206E6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59130 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jHYbM-0005sq-DW
	for qemu-devel@archiver.kernel.org; Thu, 26 Mar 2020 15:55:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59412)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <robert.foley@linaro.org>) id 1jHYLO-0000L9-GC
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 15:39:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <robert.foley@linaro.org>) id 1jHYLN-0002De-D7
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 15:39:10 -0400
Received: from mail-qt1-x844.google.com ([2607:f8b0:4864:20::844]:43647)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <robert.foley@linaro.org>)
 id 1jHYLN-0002DQ-8Z
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 15:39:09 -0400
Received: by mail-qt1-x844.google.com with SMTP id a5so6517423qtw.10
 for <qemu-devel@nongnu.org>; Thu, 26 Mar 2020 12:39:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=7dmbLyNmu9xq/SS96IeSzmgYogYuU9/UQWY9uoxtTSw=;
 b=nwEmC8r1Q+H6ijAsH9azvUMQFXdGB9y+kaG9fViFM7Kw0cE4tBkXURke/F/PCMl3TU
 N+AeeIcf+lEIMNKH054vuk+n2lLKBbWc7fL2oGG0hfORkkes3aBNADGAYlOgGIyuTRu4
 AVGoaMUwOlFJAbK2EXNRf1BD3ItJ5LTzVr3Gf+Jq8ctcMxX6aBpT8HKM6lWGzCvf06W5
 n6jkH3bXNHi1iQs9Oav9a73OP8tEZKNkJQJJY+rOnnWcQlMs/OyeIoxlGU3XNcq1envN
 nLrxEJldBvEsLa6IWa4MI8z61DirJtu+LJEs6/a7kXJiJTcX8rs7SlpVPTkOtTHeM4De
 J/5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=7dmbLyNmu9xq/SS96IeSzmgYogYuU9/UQWY9uoxtTSw=;
 b=GH10P+EjgbxOrWXSB61o2C3O8zvmzCiANPDV4hcvugamhRrbozdjAhUJdiTqeC5H1A
 1Q1i9KFT+F26ha8mq45Z3ntqO8sgLY/1S3avOxEgQuy0w7RERQfJUE/V7H8bDK9BnqGO
 9xbtsnWO9VMPrLK13hcPmQAyswC4+5LO87UUmZSUJE/VPhx96YD+AU4oO+VkFkYmTSOc
 oAKieGkoRZ/FMyBshYcgrLuxCx3kbR6ZxyV5bUfMEtySS2HMPajjwe+HKlSwYIpj30h2
 gCuyVe7ubQ6YJqCv7If4e2jD/Hu6BVstexAd7o+EmLgvCbdBImH7a5Rzfqga0r0D/fDj
 wmVw==
X-Gm-Message-State: ANhLgQ0lSQLkK+JQxESsinF1YkFn0Esi08bfO4U8Lm2n0ps/JRioPWMA
 WdHPL5wg9t3UU6cgpgi7fDdL5XYtC4Z39g==
X-Google-Smtp-Source: ADFU+vuJp6+1HrPOMzwdKvnos7wjOm+vZAQnicxd8kcsammfbgVEOX8/dtDCokvqMLCcG9sWUOhNJw==
X-Received: by 2002:ac8:18fb:: with SMTP id o56mr9704015qtk.97.1585251548468; 
 Thu, 26 Mar 2020 12:39:08 -0700 (PDT)
Received: from Rfoley-MA01.hsd1.ma.comcast.net
 ([2601:199:4480:60c0:fd55:4e67:1038:8302])
 by smtp.gmail.com with ESMTPSA id u51sm2161916qth.46.2020.03.26.12.39.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Mar 2020 12:39:07 -0700 (PDT)
From: Robert Foley <robert.foley@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v8 68/74] sparc: convert to cpu_has_work_with_iothread_lock
Date: Thu, 26 Mar 2020 15:31:50 -0400
Message-Id: <20200326193156.4322-69-robert.foley@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200326193156.4322-1-robert.foley@linaro.org>
References: <20200326193156.4322-1-robert.foley@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::844
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
 richard.henderson@linaro.org, "Emilio G. Cota" <cota@braap.org>,
 peter.puhov@linaro.org, alex.bennee@linaro.org,
 Artyom Tarasenko <atar4qemu@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Emilio G. Cota" <cota@braap.org>

Soon we will call cpu_has_work without the BQL.

Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
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



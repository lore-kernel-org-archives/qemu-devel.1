Return-Path: <SRS0=ZVNi=XW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48295C4360C
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2019 20:04:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 02586207E0
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2019 20:04:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aDT7Bxon"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 02586207E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57160 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iDwU3-0002tL-2R
	for qemu-devel@archiver.kernel.org; Fri, 27 Sep 2019 16:04:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46794)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iDw5x-0003W9-W3
 for qemu-devel@nongnu.org; Fri, 27 Sep 2019 15:40:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iDw5v-0006d8-MR
 for qemu-devel@nongnu.org; Fri, 27 Sep 2019 15:40:01 -0400
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641]:34027)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iDw5v-0006bG-0W
 for qemu-devel@nongnu.org; Fri, 27 Sep 2019 15:39:59 -0400
Received: by mail-pl1-x641.google.com with SMTP id k7so1479050pll.1
 for <qemu-devel@nongnu.org>; Fri, 27 Sep 2019 12:39:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=rr9SwpjvJyE9OAuq+Q5fU6KQ8tvMfOw0yzqcdXmDV6g=;
 b=aDT7BxonbwhBrtNiQmX53zn5ou3fwFVE475ELZ2hZu4zOdDFP+KFQLpH7OZnC6jesI
 d//jp4lLR/yEAZicDTnUWS80bdP8roJC2fzaxQi1kISAIITQ7xMyaUOlCNx5G92etJGO
 FX55EGLD5VvHr9biFtkOTTbpxizBgBBjXTDeCjxeDXL/x+hAu1giA4P6yGqLWrwOJf/A
 XkeFvGI4xNZfFS4kzx5wVDmdbuEE5dLpsvD0WWiVyAmTc+drBz5EP26WqUFI9/MpfCeA
 WVAHTrEeWrzDy5DgY646hJ0DnULm1WLHxKTC9rqDOB2Uv3wAYk8xAlAKTNYsqoZxbun7
 kEqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=rr9SwpjvJyE9OAuq+Q5fU6KQ8tvMfOw0yzqcdXmDV6g=;
 b=VUWe+xBTfQfhxwdzuBHHwn8aWlzL79RoilqmgETT+/yn0WM6CsE6QscjH1GNXQGI7k
 vruYGWztMokndOXKmuK/HD2+dR7vVYB5ulxLxW7wi+iwayGTUDpduHbRtVMwKnfbV+aR
 ezSUeaX4t/muVSazEl73MLeWQOGvIZIePNqQtwTwNMA/haXn1q6Dp5epUrQp0VQ6CW2i
 6IB7+CEs9BFoWi+IC0OzE8Iwz7iR2u+b4v3X/FSu3lImkebHoGDHk4zV/99NdcYc+GlO
 54XYO3ytp4F2dAZQAEaLPvjfdy+Ndt08DkkGv9n85e2KX4hQJ6RKFExNdqM8oaDBJ8d9
 6DmQ==
X-Gm-Message-State: APjAAAUqN8Q0dNiE95lHHDnmpw+itIXKGaH+UGnxVL8jNP2F42XrzaOt
 sR1ij9sjwB5Pbn9GZURShuVBrgtb1WM=
X-Google-Smtp-Source: APXvYqwFEenEauJG9F6Il4+5+f7rYk6ExMIz+HYF8HxlqJTMsf7wadlDAAL7q4ZZt0ba0dB868KepA==
X-Received: by 2002:a17:902:9a85:: with SMTP id
 w5mr6252924plp.316.1569613197162; 
 Fri, 27 Sep 2019 12:39:57 -0700 (PDT)
Received: from localhost.localdomain ([12.206.46.62])
 by smtp.gmail.com with ESMTPSA id 192sm3676403pfb.110.2019.09.27.12.39.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Sep 2019 12:39:56 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 16/18] target/s390x: Remove ilen argument from
 trigger_access_exception
Date: Fri, 27 Sep 2019 12:39:23 -0700
Message-Id: <20190927193925.23567-17-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190927193925.23567-1-richard.henderson@linaro.org>
References: <20190927193925.23567-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::641
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
Cc: qemu-s390x@nongnu.org, david@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The single caller passes ILEN_UNWIND; pass that along to
trigger_pgm_exception directly.

Reviewed-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/s390x/mmu_helper.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/target/s390x/mmu_helper.c b/target/s390x/mmu_helper.c
index 437e211366..768f50a255 100644
--- a/target/s390x/mmu_helper.c
+++ b/target/s390x/mmu_helper.c
@@ -33,7 +33,7 @@
 #define FS_WRITE 0x400
 
 static void trigger_access_exception(CPUS390XState *env, uint32_t type,
-                                     uint32_t ilen, uint64_t tec)
+                                     uint64_t tec)
 {
     S390CPU *cpu = env_archcpu(env);
 
@@ -44,7 +44,7 @@ static void trigger_access_exception(CPUS390XState *env, uint32_t type,
         if (type != PGM_ADDRESSING) {
             stq_phys(cs->as, env->psa + offsetof(LowCore, trans_exc_code), tec);
         }
-        trigger_pgm_exception(env, type, ilen);
+        trigger_pgm_exception(env, type, ILEN_UNWIND);
     }
 }
 
@@ -511,7 +511,7 @@ int s390_cpu_virt_mem_rw(S390CPU *cpu, vaddr laddr, uint8_t ar, void *hostbuf,
 
     ret = translate_pages(cpu, laddr, nr_pages, pages, is_write, &tec);
     if (ret) {
-        trigger_access_exception(&cpu->env, ret, ILEN_UNWIND, tec);
+        trigger_access_exception(&cpu->env, ret, tec);
     } else if (hostbuf != NULL) {
         /* Copy data by stepping through the area page by page */
         for (i = 0; i < nr_pages; i++) {
-- 
2.17.1



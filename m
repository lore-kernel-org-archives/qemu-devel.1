Return-Path: <SRS0=3xBk=XV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3200C4360C
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Sep 2019 16:55:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9DE5921A4A
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Sep 2019 16:55:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rAgFxqVq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9DE5921A4A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41082 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iDX2p-0006FO-4J
	for qemu-devel@archiver.kernel.org; Thu, 26 Sep 2019 12:55:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41246)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iDWcE-0002fd-19
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 12:27:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iDWc9-0004kW-0V
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 12:27:36 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:42963)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iDWc8-0004j2-Md
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 12:27:32 -0400
Received: by mail-pg1-f194.google.com with SMTP id z12so1826290pgp.9
 for <qemu-devel@nongnu.org>; Thu, 26 Sep 2019 09:27:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=cUqChLJA+fIshq8B7yRM6YeWhj6qyz75SemmNRFWmr4=;
 b=rAgFxqVqZkBEYMLrS1NZUjgw3larVh6yAuqyxZiEHcOPodACYtRiLpN0PeD3jbglMO
 yKXd69Qr8Tb6zpUUf4qZ5J4ib9QBQRjmzmKUlwaZZ2p/A3PhfJA1pODnvuLkgHdTnLKB
 HKqbjs3KwMqCUYy7mf2gGAtlrGm7WZ3mxqtWYhij3t+6qyi+F1+od60FQnsAW+BqFEjQ
 K1zBvwF6Z3/3yk6gCSIisJ2kF3KVnS7MiDq0CdJiG9zsbm94EAnHJbtt4gk6duOIvPQn
 hVCQeEfDz/9UCkkyWN0qTT5jmL7662f19B/v1BgyQk8KWUR4+3Gx2jGj+VVKVLNFvhUf
 v21Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=cUqChLJA+fIshq8B7yRM6YeWhj6qyz75SemmNRFWmr4=;
 b=SVAFoIU8bmDzd5nTf76w6y2Soe/QCU4eHaKfaZ2NKcVzSqi6Z2wGeB/Q8NrUdrZNQ9
 Iw+8EB++W/sfSVZ3elnzWkFeWw4RNk6RUI2l2VraiLAVBhv+rzAjNMXfoM+0IjrncixJ
 E3YGcImXQqcYvWrtGtT/TQ3IREkJtwD7A3umqGY/SGZeGIbhivwC6uDkmS0thUCubs9N
 WBvSiFXyL0AYZ9hZ1vcpSc4wFbNN0QAl7Bt4WXbPQJhuhoMVDbvuuzXL1cMBmAzRflKV
 RPBIiQPIIxoOvC/eccozgabQSjjNT8Yt9dMaLrN4irxg5R1C0lZM5NWomuRwxV3QemYo
 vsug==
X-Gm-Message-State: APjAAAUKqzUbE9fqGrTbBZaIDn3188N443cxxisO9F+XRlAi5PrEnKI+
 DTw01Tn0vdElOHtlMl4MY9dfHLlpHfo=
X-Google-Smtp-Source: APXvYqwI0trFvWUVqEEwz24Ij11aL319SF80w/mYVphiwhMzMP0sTpV7WeCOu/vG12Yf0yYTPvYghA==
X-Received: by 2002:a63:7556:: with SMTP id f22mr4327140pgn.222.1569515190896; 
 Thu, 26 Sep 2019 09:26:30 -0700 (PDT)
Received: from localhost.localdomain ([12.157.10.114])
 by smtp.gmail.com with ESMTPSA id 64sm4453169pfx.31.2019.09.26.09.26.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Sep 2019 09:26:30 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 09/18] target/s390x: Remove exc argument to
 mmu_translate_asce
Date: Thu, 26 Sep 2019 09:26:06 -0700
Message-Id: <20190926162615.31168-10-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190926162615.31168-1-richard.henderson@linaro.org>
References: <20190926162615.31168-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.215.194
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

Now that mmu_translate_asce returns the exception instead of
raising it, the argument is unused.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/s390x/mmu_helper.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/s390x/mmu_helper.c b/target/s390x/mmu_helper.c
index b783c62bd7..ed6570db62 100644
--- a/target/s390x/mmu_helper.c
+++ b/target/s390x/mmu_helper.c
@@ -113,7 +113,7 @@ static inline int read_table_entry(hwaddr gaddr, uint64_t *entry)
 
 static int mmu_translate_asce(CPUS390XState *env, target_ulong vaddr,
                               uint64_t asc, uint64_t asce, target_ulong *raddr,
-                              int *flags, int rw, bool exc)
+                              int *flags, int rw)
 {
     const bool edat1 = (env->cregs[0] & CR0_EDAT) &&
                        s390_has_feat(S390_FEAT_EDAT);
@@ -402,7 +402,7 @@ int mmu_translate(CPUS390XState *env, target_ulong vaddr, int rw, uint64_t asc,
     }
 
     /* perform the DAT translation */
-    r = mmu_translate_asce(env, vaddr, asc, asce, raddr, flags, rw, exc);
+    r = mmu_translate_asce(env, vaddr, asc, asce, raddr, flags, rw);
     if (unlikely(r)) {
         if (exc) {
             trigger_access_exception(env, r, ilen, tec);
-- 
2.17.1



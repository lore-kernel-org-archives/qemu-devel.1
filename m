Return-Path: <SRS0=3xBk=XV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC241ECE589
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Sep 2019 16:41:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A7924222C9
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Sep 2019 16:41:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RPLYePRB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A7924222C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40864 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iDWpI-0007ps-EJ
	for qemu-devel@archiver.kernel.org; Thu, 26 Sep 2019 12:41:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41239)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iDWcC-0002fO-Si
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 12:27:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iDWc8-0004jz-Sh
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 12:27:34 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:33024)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iDWc6-0004ff-LM
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 12:27:32 -0400
Received: by mail-pl1-f196.google.com with SMTP id d22so1550151pls.0
 for <qemu-devel@nongnu.org>; Thu, 26 Sep 2019 09:27:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=nOk3WYhtYahGat7iYj1GhM9dpB7AkH9Zaoypf0AhgeE=;
 b=RPLYePRBWAV6fWtJDMS7+OuMNADukAUIoZC2HprOk8qRgmmK5Wpy9uZHwuU34ixnwZ
 4WDUhNAzAm+laD7sekfwLDKHhqH4gqAuzWsx5wHmqeTTMdr5NJ22JAq0ofBqFOOfb3Bd
 D1nOYIyx5Y9H7QSjNQp3qsGmSnyT3woRyId0+IjxPlIYn21wu8RnTkbzt580r0/0TOZo
 x/r8yKskobDhK1G4MVAfDUeLogxRmMxgQPtFROWH/QtRFZYcm5JQjKO3tiiUxuyocTgi
 xF5ZwV5bYyGzL1rz7neLrtFSGxddov2MZ9uRxFKMmXS0mlbsTYt7AWc8IyI4nj1ebSiv
 vAtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=nOk3WYhtYahGat7iYj1GhM9dpB7AkH9Zaoypf0AhgeE=;
 b=XSPjhgrsP76NRUNdeQt5yvLCy8K3xSSboTSQ+NBVCEMsNgTv3jvSIap+PTaqPrXf/g
 UnkLQAwBHuuZ+1iAJ9Afn+kSxZrLuO8OVUXOYN4dY2Dui0hw9eP9rNX42K194apGsq3G
 L9+cS4NQcHEBA2f6g5FbcJfWlXei5B+Yasd3O0UbSR3Dj3slTl6BaMQgRsiRlzaR+2Vp
 LW+nl+7FRdHtOHvq62ayV9yxAQVgz07vimMTZLvKJSbN3aaBbyvVxhwta5aEG3e0x2/L
 hIER0kZ3ntjZpF/9sy6y+v8DI6LdftRpsX6kzrGw/hHtunzWoY5RtlT3QCobtHqA54Dj
 sY1g==
X-Gm-Message-State: APjAAAXeK5JxWHUHcXT0Tu0zJukNSL2zAVl17tdSXtC+SZ3/jdOcUn91
 IqtIuDO8HzOLRSX6acQKez1eU43z3tE=
X-Google-Smtp-Source: APXvYqwnZjD3y0kF8uAmXwb6Wixrs87O1RbcO5dFKVQ7RXtkjXiDyfJpB1jbdmkQ5CORgHZ9Iw11ew==
X-Received: by 2002:a17:902:7611:: with SMTP id
 k17mr4594355pll.314.1569515186521; 
 Thu, 26 Sep 2019 09:26:26 -0700 (PDT)
Received: from localhost.localdomain ([12.157.10.114])
 by smtp.gmail.com with ESMTPSA id 64sm4453169pfx.31.2019.09.26.09.26.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Sep 2019 09:26:25 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 06/18] target/s390x: Push trigger_pgm_exception lower in
 s390_cpu_tlb_fill
Date: Thu, 26 Sep 2019 09:26:03 -0700
Message-Id: <20190926162615.31168-7-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190926162615.31168-1-richard.henderson@linaro.org>
References: <20190926162615.31168-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.214.196
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

Delay triggering an exception until the end, after we have
determined ultimate success or failure, and also taken into
account whether this is a non-faulting probe.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/s390x/excp_helper.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/target/s390x/excp_helper.c b/target/s390x/excp_helper.c
index dbff772d34..552098be5f 100644
--- a/target/s390x/excp_helper.c
+++ b/target/s390x/excp_helper.c
@@ -127,7 +127,7 @@ bool s390_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
     CPUS390XState *env = &cpu->env;
     target_ulong vaddr, raddr;
     uint64_t asc;
-    int prot, fail;
+    int prot, fail, excp;
 
     qemu_log_mask(CPU_LOG_MMU, "%s: addr 0x%" VADDR_PRIx " rw %d mmu_idx %d\n",
                   __func__, address, access_type, mmu_idx);
@@ -141,12 +141,14 @@ bool s390_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
             vaddr &= 0x7fffffff;
         }
         fail = mmu_translate(env, vaddr, access_type, asc, &raddr, &prot, true);
+        excp = 0; /* exception already raised */
     } else if (mmu_idx == MMU_REAL_IDX) {
         /* 31-Bit mode */
         if (!(env->psw.mask & PSW_MASK_64)) {
             vaddr &= 0x7fffffff;
         }
         fail = mmu_translate_real(env, vaddr, access_type, &raddr, &prot);
+        excp = 0; /* exception already raised */
     } else {
         g_assert_not_reached();
     }
@@ -159,7 +161,7 @@ bool s390_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
         qemu_log_mask(CPU_LOG_MMU,
                       "%s: raddr %" PRIx64 " > ram_size %" PRIx64 "\n",
                       __func__, (uint64_t)raddr, (uint64_t)ram_size);
-        trigger_pgm_exception(env, PGM_ADDRESSING, ILEN_AUTO);
+        excp = PGM_ADDRESSING;
         fail = 1;
     }
 
@@ -175,6 +177,9 @@ bool s390_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
         return false;
     }
 
+    if (excp) {
+        trigger_pgm_exception(env, excp, ILEN_AUTO);
+    }
     cpu_restore_state(cs, retaddr, true);
 
     /*
-- 
2.17.1



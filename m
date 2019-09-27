Return-Path: <SRS0=ZVNi=XW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3938C4360C
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2019 19:42:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AA9AE20863
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2019 19:42:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HDp+bEsD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA9AE20863
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56758 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iDw8b-0005FI-3B
	for qemu-devel@archiver.kernel.org; Fri, 27 Sep 2019 15:42:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46489)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iDw5g-0003IP-ID
 for qemu-devel@nongnu.org; Fri, 27 Sep 2019 15:39:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iDw5d-0006JS-Gz
 for qemu-devel@nongnu.org; Fri, 27 Sep 2019 15:39:44 -0400
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:40518)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iDw5c-0006I8-TK
 for qemu-devel@nongnu.org; Fri, 27 Sep 2019 15:39:41 -0400
Received: by mail-pf1-x443.google.com with SMTP id x127so2133175pfb.7
 for <qemu-devel@nongnu.org>; Fri, 27 Sep 2019 12:39:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=/oqnU8JxcWk92yTF6oHqZ+/jW9Yk0vbg0OCD6IUFg00=;
 b=HDp+bEsDpl3Iwi+Cr90KoX4UN5uuGIkjbqsmAT++WG0QGM2kyzO0v18CeYwBNLRiI0
 A3nwh0MXL6o0YF0SJEX0SPem8DbTsIEsfRd0ynyCS9WtY4Myxr4ldi4tfkbemhc380Yr
 lwagiwhuxLILs4zNVByPe/TBEjLoeuRsvUN+B/vkdmFAT3SZRGu8V8UT2Cn3P0nXwGyX
 dcaESLsXzR0mm7d5R3+jDkbsghY4M0Fs1IZI4GPY9hEP53egIcQ+JdtiAVVNueGnHQXQ
 K8tf7U5a2tgxmIoWdhfaFjkOf4FC4+3VBHt0q5rcjYiVvBAwskaCJSCRyDpWijFjYocy
 NnvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=/oqnU8JxcWk92yTF6oHqZ+/jW9Yk0vbg0OCD6IUFg00=;
 b=tMW010k8Ji9XR65xWWsA2XyCCYMCp7mSPyA32Adv89VYG07QTrHzn+PqN04u9R9fan
 R3TWAl4n5hirhobQM0X8UhomfDbLbrnlFDQFIKgeNOPFkiJk5iVDDZi3m2miHC2ENswj
 RfmNrCCm3YccWCnCbaAM4OnFNL6yWN6+OKCwdz5e4eylf2bYkzke8klYXIcAubpmZKsf
 hBgLI5Ps8kbrA2a2VlLIDGA1Ow4c3hoUT2/Ff9xI4kzV1h0ndIlOs6boGwOi9vH8wwtt
 vm4fmGGAOC6K6z7vd1wYtzI8BaD0cxCYRTRaIFZVCiCbpTMk8mWBXOQuLUwrDWPBR5+x
 HybA==
X-Gm-Message-State: APjAAAV1IqRzn4s0gsmbWwtE204PzfbKPhpGE5Ogjl8+XqR+tR7hGzeF
 FJM+5d+R08uqWPXJUZzMGj5IvlOKjT8=
X-Google-Smtp-Source: APXvYqx/PRD0hs7Ml0S+OO50B3UqgQeOb+uxvgZFv4QZQSC2XlyHjMNQkpjwnjPB5YPp+Ap94VIZ2w==
X-Received: by 2002:a63:cb07:: with SMTP id p7mr11056760pgg.232.1569613179317; 
 Fri, 27 Sep 2019 12:39:39 -0700 (PDT)
Received: from localhost.localdomain ([12.206.46.62])
 by smtp.gmail.com with ESMTPSA id 192sm3676403pfb.110.2019.09.27.12.39.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Sep 2019 12:39:38 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 05/18] target/s390x: Push trigger_pgm_exception lower in
 s390_cpu_tlb_fill
Date: Fri, 27 Sep 2019 12:39:12 -0700
Message-Id: <20190927193925.23567-6-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190927193925.23567-1-richard.henderson@linaro.org>
References: <20190927193925.23567-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::443
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

Reviewed-by: David Hildenbrand <david@redhat.com>
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



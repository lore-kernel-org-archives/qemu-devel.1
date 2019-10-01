Return-Path: <SRS0=WBSu=X2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6BC8ECE587
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2019 17:23:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B564F215EA
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2019 17:23:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ed98YKuA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B564F215EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45692 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iFLsQ-0008IV-Jo
	for qemu-devel@archiver.kernel.org; Tue, 01 Oct 2019 13:23:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32783)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iFLlB-0001XA-UY
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 13:16:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iFLlA-0005Ud-MD
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 13:16:25 -0400
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641]:39702)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iFLlA-0005UO-H0
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 13:16:24 -0400
Received: by mail-pl1-x641.google.com with SMTP id s17so5790322plp.6
 for <qemu-devel@nongnu.org>; Tue, 01 Oct 2019 10:16:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=/oqnU8JxcWk92yTF6oHqZ+/jW9Yk0vbg0OCD6IUFg00=;
 b=ed98YKuAwq+zjiopuUUw17Se9XNlLEjoap99rd8tgJDhFMPTrbIWAJ/oSiWrmBZPxS
 6XKE9X8X/p4vmZJWJ4msWJK1ol4FEOlK6lbZ5le2Hw+FW3WWesLePW7I4TAR926CDeov
 LizPVKc/jF12odwp65LWgsCsoHRGyvGzK2gqMnY2pM0OJjzG199gd6h8c6aTd6vAB8T9
 hYfjSnssXLnnBGrq2UWw76By0+VFlj6saGGw1vaV/M3IJuB2oMSdpywd8Geezk3P7mTR
 3VPRVB+q2X9dde+/2MGH8pl+t3k0Gc7N90kGDWowjm5CyGV6bWCuOZUKHQELULgJsGWl
 a9pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=/oqnU8JxcWk92yTF6oHqZ+/jW9Yk0vbg0OCD6IUFg00=;
 b=OSdALtcRqOTafbzZFH23TLQZcPX+ESk5I1Hxttg2dA1kAQEq5ju8r4aRf6ryS+l87E
 x7OaoCORGefG3cg4ND6RF9xFIBrSzDdPoJ8SkJiSIaY4KI9J2e45L0WT/7ATFh/21RRs
 lzjJdpv8ZkJjt2fxpv6OBqNOSFQuB6kfF+PS31qfFDbIM39IkzNXQEjG73NWeSsMAKGB
 ZyReilcasqcEd+rfMNhkcZWc7XEsePip/YIyGTpmqYHCQEwtwa/7X3i/9GA0nVRtw/2/
 KDR/pCnbYwEOBbx+IhktuY1uMu+0l++vC+Q/4jIEh84+34lIlnSAyN3Q7rAaUox0Mgic
 IYNw==
X-Gm-Message-State: APjAAAXAKDCxv6AChVhmtQEotqRFn1i3v3JMEzLGZJELt1qhm6vbMf5o
 2/bxA+sw9PiuhKo6js1Sas+pnMIpBuQ=
X-Google-Smtp-Source: APXvYqxf7P11wWPoHFxYdNec1uuHzVs4nlAS3rCvvZw6Y1UkoM3Vs16B+t3nj4e0C2S9/OnIVpiAhw==
X-Received: by 2002:a17:902:7202:: with SMTP id
 ba2mr24281569plb.267.1569950183057; 
 Tue, 01 Oct 2019 10:16:23 -0700 (PDT)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id w7sm2863568pjn.1.2019.10.01.10.16.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Oct 2019 10:16:22 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v5 05/18] target/s390x: Push trigger_pgm_exception lower in
 s390_cpu_tlb_fill
Date: Tue,  1 Oct 2019 10:16:01 -0700
Message-Id: <20191001171614.8405-6-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191001171614.8405-1-richard.henderson@linaro.org>
References: <20191001171614.8405-1-richard.henderson@linaro.org>
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
Cc: david@redhat.com
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



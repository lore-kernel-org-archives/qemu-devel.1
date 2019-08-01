Return-Path: <SRS0=TBk9=V5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D4EFC19759
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Aug 2019 18:34:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 09EB6206A2
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Aug 2019 18:34:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="M5yAL39d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 09EB6206A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58310 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1htFtz-0001aa-8w
	for qemu-devel@archiver.kernel.org; Thu, 01 Aug 2019 14:34:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59322)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1htFqS-0005vS-U7
 for qemu-devel@nongnu.org; Thu, 01 Aug 2019 14:30:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1htFqR-0002SH-9d
 for qemu-devel@nongnu.org; Thu, 01 Aug 2019 14:30:32 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:37113)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1htFqP-0002OQ-6N
 for qemu-devel@nongnu.org; Thu, 01 Aug 2019 14:30:31 -0400
Received: by mail-wm1-x341.google.com with SMTP id f17so64042010wme.2
 for <qemu-devel@nongnu.org>; Thu, 01 Aug 2019 11:30:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Y8kQnNWj7L1RglFpXZuQmS8CMCen+lRIUG4/xhzv4ZM=;
 b=M5yAL39dhkc5GOLJIGQCNp/qjS7NA4Se4DEJNKG99MP/cwLl7TI/BVS8wdOJ22GeGu
 L2LBW3inV+2j+UshOt3zz1b2da6nGMcGMCj1ND0IDhJyelYA0IoG1uEFG1kpdYmhMkLL
 Bssm7bMtOC/RPAIcfg5W59OBpE2m98Y+K9q5QAG6deiOHTEI5VSjmQC7Uiy3vXM5mIL3
 cp9fgX03pWL46O5hEW/31PivBOd0p7pGufa5TpiAPRqBkrPTCRvRwgqR4NkICRAAyD8I
 1T7BgWNRpG3bHzqxrQ4T3ppXpgtW9GiRHinl/fghslG2le8MxL3LegOsz6KSKih/IkQR
 RSzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Y8kQnNWj7L1RglFpXZuQmS8CMCen+lRIUG4/xhzv4ZM=;
 b=da86EPUL8CTc4FXgGIbAsGpDPFE646EQ2GZks6ryHkuI58mBSWyCbghJvDKlwN0wlU
 MEdG7tHCMWnDChVfWSP8h5WElnl1SLtva1wHDVVBQn/9Xe3PRBFTA9Zjn3+0gz3/6wtb
 /H1I/YXoeTcQ1hT9VTKH9vkv8ddR70itcT2yPUHCTYdPFNcIsxJhfyi0THacEgKuJjW5
 ZhQtli3Tm3gX1znbsVJYN1K/yNHTG5A3C8Zy2Ya5WBrWwSPfGeOEopL7SPOVw7IPWghX
 ovwI7TiKSSD6TM2jt/MhibQYFWrBJnSY+710xVUnkcERasAXSHxsS0pjM9/zbAaWxaEz
 o17g==
X-Gm-Message-State: APjAAAX1QQCvV3AoVoSP4Xcf+crFl8Eoeok94AHkq2q9FVvvpstofOM5
 hJGH151ESxXKyT0vZJHsrBzS6o1KqeUmGA==
X-Google-Smtp-Source: APXvYqyN058HVBOiEQ0i8bYu6Q+XZ+SWWwvIJxtfaH0SXt7KQsoeUrKCVtQYZhO6nxV5R0sXzf23pQ==
X-Received: by 2002:a1c:544d:: with SMTP id p13mr121996wmi.78.1564684218157;
 Thu, 01 Aug 2019 11:30:18 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id e6sm71702104wrw.23.2019.08.01.11.30.17
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Thu, 01 Aug 2019 11:30:17 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Date: Thu,  1 Aug 2019 19:30:08 +0100
Message-Id: <20190801183012.17564-4-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190801183012.17564-1-peter.maydell@linaro.org>
References: <20190801183012.17564-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::341
Subject: [Qemu-devel] [PATCH 3/7] target/sparc: Check for transaction
 failures in MXCC stream ASI accesses
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
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Currently the ld/st_asi helper functions make calls to the
ld*_phys() and st*_phys() functions for those ASIs which
imply direct accesses to physical addresses. These implicitly
rely on the unassigned_access hook to cause them to generate
an MMU fault if the access fails.

Switch to using the address_space_* functions instead, which
return a MemTxResult that we can check. This means that when
we switch SPARC over to using the do_transaction_failed hook
we'll still get the same MMU faults we did before.

This commit converts the ASIs which do MXCC stream source
and destination accesses.

It's not clear to me whether raising an MMU fault like this
is the correct behaviour if we encounter a bus error, but
we retain the same behaviour that the old unassigned_access
hook would implement.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/sparc/ldst_helper.c | 57 +++++++++++++++++++++++++-------------
 1 file changed, 37 insertions(+), 20 deletions(-)

diff --git a/target/sparc/ldst_helper.c b/target/sparc/ldst_helper.c
index 39698c58859..91cd0b593ef 100644
--- a/target/sparc/ldst_helper.c
+++ b/target/sparc/ldst_helper.c
@@ -880,6 +880,9 @@ void helper_st_asi(CPUSPARCState *env, target_ulong addr, uint64_t val,
             }
             break;
         case 0x01c00100: /* MXCC stream source */
+        {
+            int i;
+
             if (size == 8) {
                 env->mxccregs[0] = val;
             } else {
@@ -887,20 +890,27 @@ void helper_st_asi(CPUSPARCState *env, target_ulong addr, uint64_t val,
                               "%08x: unimplemented access size: %d\n", addr,
                               size);
             }
-            env->mxccdata[0] = ldq_phys(cs->as,
-                                        (env->mxccregs[0] & 0xffffffffULL) +
-                                        0);
-            env->mxccdata[1] = ldq_phys(cs->as,
-                                        (env->mxccregs[0] & 0xffffffffULL) +
-                                        8);
-            env->mxccdata[2] = ldq_phys(cs->as,
-                                        (env->mxccregs[0] & 0xffffffffULL) +
-                                        16);
-            env->mxccdata[3] = ldq_phys(cs->as,
-                                        (env->mxccregs[0] & 0xffffffffULL) +
-                                        24);
+
+            for (i = 0; i < 4; i++) {
+                MemTxResult result;
+                hwaddr access_addr = (env->mxccregs[0] & 0xffffffffULL) + 8 * i;
+
+                env->mxccdata[i] = address_space_ldq(cs->as,
+                                                     access_addr,
+                                                     MEMTXATTRS_UNSPECIFIED,
+                                                     &result);
+                if (result != MEMTX_OK) {
+                    /* TODO: investigate whether this is the right behaviour */
+                    sparc_raise_mmu_fault(cs, access_addr, false, false,
+                                          false, size, GETPC());
+                }
+            }
             break;
+        }
         case 0x01c00200: /* MXCC stream destination */
+        {
+            int i;
+
             if (size == 8) {
                 env->mxccregs[1] = val;
             } else {
@@ -908,15 +918,22 @@ void helper_st_asi(CPUSPARCState *env, target_ulong addr, uint64_t val,
                               "%08x: unimplemented access size: %d\n", addr,
                               size);
             }
-            stq_phys(cs->as, (env->mxccregs[1] & 0xffffffffULL) +  0,
-                     env->mxccdata[0]);
-            stq_phys(cs->as, (env->mxccregs[1] & 0xffffffffULL) +  8,
-                     env->mxccdata[1]);
-            stq_phys(cs->as, (env->mxccregs[1] & 0xffffffffULL) + 16,
-                     env->mxccdata[2]);
-            stq_phys(cs->as, (env->mxccregs[1] & 0xffffffffULL) + 24,
-                     env->mxccdata[3]);
+
+            for (i = 0; i < 4; i++) {
+                MemTxResult result;
+                hwaddr access_addr = (env->mxccregs[1] & 0xffffffffULL) + 8 * i;
+
+                address_space_stq(cs->as, access_addr, env->mxccdata[i],
+                                  MEMTXATTRS_UNSPECIFIED, &result);
+
+                if (result != MEMTX_OK) {
+                    /* TODO: investigate whether this is the right behaviour */
+                    sparc_raise_mmu_fault(cs, access_addr, true, false,
+                                          false, size, GETPC());
+                }
+            }
             break;
+        }
         case 0x01c00a00: /* MXCC control register */
             if (size == 8) {
                 env->mxccregs[3] = val;
-- 
2.20.1



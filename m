Return-Path: <SRS0=x6Qc=45=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0170BC2BB1D
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 16:52:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C5E36206F1
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 16:52:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="w8bN2ukf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C5E36206F1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45514 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jCR43-0008VD-Ss
	for qemu-devel@archiver.kernel.org; Thu, 12 Mar 2020 12:52:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35603)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jCQxN-0008FI-P2
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 12:45:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1jCQxL-00053r-KG
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 12:45:13 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:41246)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1jCQxL-00051z-DW
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 12:45:11 -0400
Received: by mail-wr1-x441.google.com with SMTP id s14so8371939wrt.8
 for <qemu-devel@nongnu.org>; Thu, 12 Mar 2020 09:45:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=2a4oBo+1GmPL1/JooGpcol4Cf4xTWSFHxDnNoSO8Mq8=;
 b=w8bN2ukfZgL9OkxxFvPedxq0nhCZeuZ15NwgN8r4iVNaDPVO5E3zE+BYX7fFuOhtWA
 Q+5YKKCFQ49b6BjYuuSsfqG0W7r6hJiFIyN+BLF7BrQD2SS4B/7ShP4GgqnAOftCm6NT
 FvJzLtN0JRLQYBssQn7O2TX0mae4rwQL/v5LTAUTHzLcpI4zEEdyOIsjCKGLfO2H4khD
 15zYKM1LmX8q4SQqg1YYqFHqYYJJgxqLCsufME+DkyJodDMXOnYWUtJlJf+DcjlJjzGI
 LHmRNBDl7kOi4JBIUrnfh4e8/VoH/X0A1rkM0kFShXTgNtPbaKk/lODx07ZCuxnoR364
 KmqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=2a4oBo+1GmPL1/JooGpcol4Cf4xTWSFHxDnNoSO8Mq8=;
 b=PoJDpPSj9lbQh5Qew1JI9DIFX6kS8FpW491PM/GX/dcmr9AVYZVJ330zj5ufm+8bZT
 4sofm29brGunpV1L/hfgBXQYrGfr++hRGGtLUHTxN2lJpJ9Hffw2L/fV5Cn7g+BeavBs
 TkptmXWj6/S6e5kVuz4aj/IHDT3zYrnD8a/AZDmh/B3oDT0GmFuuhYt2iBiRyFBNWyk4
 RP1CYR3DZNfHB+FHeexlHEFr93pJwHRQJ7Kqt+wgptbhF1WLpWk2hC6Y9aB3wQbx1NBO
 2MCHKHA2/VqMguXVVndL4NOnPdDHzcyzeRXAcDx0+UX9CXTH9M63TkaQeodnZ946JKVd
 IBKg==
X-Gm-Message-State: ANhLgQ0qV5qbpqhyF0t0E7kLrWgTx9f5TcQpNg61gvSYfMMQKhhsdn8I
 Yb28SYufjay3uvay07ZQt0tcliBLuaFrMQ==
X-Google-Smtp-Source: ADFU+vuOlM3/MzJWPxjUFts6QnBDhG2odQjQ+ZGETnBmPe2Pj8MbMfAT6d23rTk03u5h1XEZCTQ51w==
X-Received: by 2002:a5d:4683:: with SMTP id u3mr12492793wrq.251.1584031510211; 
 Thu, 12 Mar 2020 09:45:10 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id j15sm36838640wrp.85.2020.03.12.09.45.09
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Mar 2020 09:45:09 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 07/36] target/arm: Check addresses for disabled regimes
Date: Thu, 12 Mar 2020 16:44:30 +0000
Message-Id: <20200312164459.25924-8-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200312164459.25924-1-peter.maydell@linaro.org>
References: <20200312164459.25924-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::441
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Richard Henderson <richard.henderson@linaro.org>

We fail to validate the upper bits of a virtual address on a
translation disabled regime, as per AArch64.TranslateAddressS1Off.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20200308012946.16303-2-richard.henderson@linaro.org
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/helper.c | 35 ++++++++++++++++++++++++++++++++++-
 1 file changed, 34 insertions(+), 1 deletion(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index fc1192d1204..b61ee73d18a 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -11780,7 +11780,40 @@ bool get_phys_addr(CPUARMState *env, target_ulong address,
     /* Definitely a real MMU, not an MPU */
 
     if (regime_translation_disabled(env, mmu_idx)) {
-        /* MMU disabled. */
+        /*
+         * MMU disabled.  S1 addresses within aa64 translation regimes are
+         * still checked for bounds -- see AArch64.TranslateAddressS1Off.
+         */
+        if (mmu_idx != ARMMMUIdx_Stage2) {
+            int r_el = regime_el(env, mmu_idx);
+            if (arm_el_is_aa64(env, r_el)) {
+                int pamax = arm_pamax(env_archcpu(env));
+                uint64_t tcr = env->cp15.tcr_el[r_el].raw_tcr;
+                int addrtop, tbi;
+
+                tbi = aa64_va_parameter_tbi(tcr, mmu_idx);
+                if (access_type == MMU_INST_FETCH) {
+                    tbi &= ~aa64_va_parameter_tbid(tcr, mmu_idx);
+                }
+                tbi = (tbi >> extract64(address, 55, 1)) & 1;
+                addrtop = (tbi ? 55 : 63);
+
+                if (extract64(address, pamax, addrtop - pamax + 1) != 0) {
+                    fi->type = ARMFault_AddressSize;
+                    fi->level = 0;
+                    fi->stage2 = false;
+                    return 1;
+                }
+
+                /*
+                 * When TBI is disabled, we've just validated that all of the
+                 * bits above PAMax are zero, so logically we only need to
+                 * clear the top byte for TBI.  But it's clearer to follow
+                 * the pseudocode set of addrdesc.paddress.
+                 */
+                address = extract64(address, 0, 52);
+            }
+        }
         *phys_ptr = address;
         *prot = PAGE_READ | PAGE_WRITE | PAGE_EXEC;
         *page_size = TARGET_PAGE_SIZE;
-- 
2.20.1



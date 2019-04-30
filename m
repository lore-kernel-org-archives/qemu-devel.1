Return-Path: <SRS0=TP+Q=TA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 966F9C43219
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2019 17:13:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5800421670
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2019 17:13:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YjeWPiwA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5800421670
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:50448 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hLWJY-00024Q-Hj
	for qemu-devel@archiver.kernel.org; Tue, 30 Apr 2019 13:13:08 -0400
Received: from eggs.gnu.org ([209.51.188.92]:40451)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hLW5U-0007Cl-Uu
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 12:58:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hLW5T-0003mO-0A
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 12:58:36 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:39618)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1hLW5S-0003lo-Pt
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 12:58:34 -0400
Received: by mail-wr1-x442.google.com with SMTP id a9so21866015wrp.6
	for <qemu-devel@nongnu.org>; Tue, 30 Apr 2019 09:58:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=gmFGO18R6wc6UEhG3xXAtJADNbztJhPGG+6VZwVsHPk=;
	b=YjeWPiwAXRvrcBmrLLYDDjlVMW5moWokvU97lMeQOX+3HCKRB89ZgJVXul9/mlsCf5
	0C2OQyCZOgeTnQGN8n9d7gqkvYoIb0xYBExs6O+Hn7so22xk5qu1qgIW0RV+OpjCop92
	DKRkxCEHQcLs91RIbVbkc6iP/fs3fDpMNuMAwUEHB6Z6/ZoSQujVKSIrw9D53WugfWI8
	VciEi+lG8dRP/P/+dwoaRM3SgW/B+5YO+STK6sI35fHygUd72SN2bL/d5BPbcK4WdDAN
	B0iAiD/061jH9FRH6ySZOdCJJzweYIYcQqaYyeImdPtwxN8aAv2HnT4Yx+fi9fVkcjsf
	VB5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=gmFGO18R6wc6UEhG3xXAtJADNbztJhPGG+6VZwVsHPk=;
	b=JpurGdDDDYSPntvMI/nMgSC9rDfuQCYVlF/etOKvtpSK+NGp7mKmU6Ae0oiFYlDWJK
	eUJIOyggBsqSL34ZgilYdLdOxdgRKDR3HSOXDEuo8BQRvx15l2SbJ8VzO59IiHD6RdK9
	SIlkIzDBV3vOnRquGNK0WLP8ncqMrjddmwpfxrwYOBVfexo10p1SaEU51kg/rh8C214f
	od/8fXKSChcf14LbK9cThmuR/aOUlaZac4kwwOepmwMtHE83hJictmxHvKr38Jr/F/cv
	DoSFNmNIAQ1AO/skIPkv12QhfLb8ocLsXpmRbIbOfEtkrNRczj8r5Q1f6OK+sSJtmGX/
	BKLw==
X-Gm-Message-State: APjAAAXiEjfPwcRWNndfqsnRSMy67y5ltteXCeuQ6RN9W/hqE8kyzKE6
	QpeCtWP2mAzhf88I4tjhZYtRBw==
X-Google-Smtp-Source: APXvYqzYmPi4oXC/xqlVJ6QawC+b6wq3Q591rynNBiTp/TUbkVhbT0A0FX2Npms753llnHJM+KYAeA==
X-Received: by 2002:adf:a202:: with SMTP id p2mr11994920wra.166.1556643513135; 
	Tue, 30 Apr 2019 09:58:33 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
	by smtp.gmail.com with ESMTPSA id
	w10sm3496524wrv.90.2019.04.30.09.58.32
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Tue, 30 Apr 2019 09:58:32 -0700 (PDT)
Received: from zen.linaroharston. (localhost [127.0.0.1])
	by zen.linaroharston (Postfix) with ESMTP id 1B1311FF9C;
	Tue, 30 Apr 2019 17:52:35 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Date: Tue, 30 Apr 2019 17:52:31 +0100
Message-Id: <20190430165234.32272-13-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190430165234.32272-1-alex.bennee@linaro.org>
References: <20190430165234.32272-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::442
Subject: [Qemu-devel] [PATCH v5 12/15] cputlb: Do unaligned store recursion
 to outermost function
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
	Richard Henderson <richard.henderson@linaro.org>,
	qemu-arm@nongnu.org, mark.cave-ayland@ilande.co.uk, cota@braap.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190430165231.R7EBoEnVd0_D0HA17ygS-tCQm7Lnw1ByDunnxKM4_hg@z>

From: Richard Henderson <richard.henderson@linaro.org>

This is less tricky than for loads, because we always fall
back to single byte stores to implement unaligned stores.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 accel/tcg/cputlb.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index e4d0c94301..a083324768 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -1413,9 +1413,9 @@ tcg_target_ulong helper_be_ldsl_mmu(CPUArchState *env, target_ulong addr,
  * Store Helpers
  */
 
-static void store_helper(CPUArchState *env, target_ulong addr, uint64_t val,
-                         TCGMemOpIdx oi, uintptr_t retaddr, size_t size,
-                         bool big_endian)
+static inline void __attribute__((always_inline))
+store_helper(CPUArchState *env, target_ulong addr, uint64_t val,
+             TCGMemOpIdx oi, uintptr_t retaddr, size_t size, bool big_endian)
 {
     uintptr_t mmu_idx = get_mmuidx(oi);
     uintptr_t index = tlb_index(env, mmu_idx, addr);
@@ -1514,7 +1514,7 @@ static void store_helper(CPUArchState *env, target_ulong addr, uint64_t val,
                 /* Little-endian extract.  */
                 val8 = val >> (i * 8);
             }
-            store_helper(env, addr + i, val8, oi, retaddr, 1, big_endian);
+            helper_ret_stb_mmu(env, addr + i, val8, oi, retaddr);
         }
         return;
     }
-- 
2.20.1



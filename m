Return-Path: <SRS0=QQWF=WY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E875C3A5A1
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2019 23:22:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 32058217F5
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2019 23:22:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="orlrpns2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 32058217F5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43652 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i37Gb-0001Fz-PX
	for qemu-devel@archiver.kernel.org; Wed, 28 Aug 2019 19:22:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52344)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1i37BW-0004FK-S3
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 19:17:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1i37BV-0008H5-Uo
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 19:17:02 -0400
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:38780)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1i37BV-0008Gn-Oc
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 19:17:01 -0400
Received: by mail-pg1-x541.google.com with SMTP id e11so516530pga.5
 for <qemu-devel@nongnu.org>; Wed, 28 Aug 2019 16:17:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=Gm01TIX2dgmE2RJ8CmJz1CGP7nGYi+1YuaceKCL3Jzs=;
 b=orlrpns2pUjBuMAHKF+faUFWHNQVF3WdegcMszTxlLr2nXp0hsLQ2IMUCoxy56T5GL
 gXfV+6fhHvTTfsDMLurG0ZWuoVflCrBHeaN6Dpq5ShbfLfrPYdzk07NoMaAxWPSCe8FE
 dk7qnKC/SDU1vi4/zJRoe+cAgit/sXFpk0851sxCTWSgo/fSzQm6JpVEB6G8OmRlO48O
 LLCiqZo3juMV1Tf/LvYXvlPf4v475mE4wvcA5LLsQisW/ybuapygUwA30P7ISW6MP9JX
 aXLntQ5Ffa+9/UOCHTifLlE9UxhViphb52IUvXDzFm7xbmDxixULjaPpQ963U4OE4bON
 fDTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=Gm01TIX2dgmE2RJ8CmJz1CGP7nGYi+1YuaceKCL3Jzs=;
 b=a4BibgxAnsSsSPyb/Qsz3M7dgmEKoiVjdesxKl04DGS/MyetPtIfl7laIauaJf86Ur
 omIcUDmKoRnsgxukKMjKUHWL3Zb/H21ywOX2GKoiDVZobYRgk7foQHWmX+U3vNykgkfl
 NCTdZLiat/uOW/lcCg47qhZaVjod/vea+lpLToEq0DVpWqvfC8IqlDdh7VTEnjfGMEpY
 /RLnzfiDWPFfxgzxlkQeNbF4ZAQngBh/pU6W7458x96dG3bhcI0hEbin87V3RJlUUDwK
 04HztF/4J0BLa9GfLNN7EVjeE3A1WPdH4d1hkF3NhJo1tFOpj6Xbjf6XgCr/8tp/eex2
 JTkw==
X-Gm-Message-State: APjAAAVYDVK4zg4DjoqJ7tNTstmrRFtRMlH3LFtMlYfytTljKf98aqqZ
 guxoxdmzV+OJ64TYT7hi3mHD7z7WWbY=
X-Google-Smtp-Source: APXvYqx8C/yfNoMPnwNHRygwbs14sIiKP8AhiXoS/PAwo2fp0UKjB7PF7tuLeIfwZzOZuGDFPaQ4gg==
X-Received: by 2002:a63:ed50:: with SMTP id m16mr5525536pgk.209.1567034220394; 
 Wed, 28 Aug 2019 16:17:00 -0700 (PDT)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id s5sm485197pfm.97.2019.08.28.16.16.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Aug 2019 16:16:59 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Wed, 28 Aug 2019 16:16:49 -0700
Message-Id: <20190828231651.17176-7-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190828231651.17176-1-richard.henderson@linaro.org>
References: <20190828231651.17176-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::541
Subject: [Qemu-devel] [PATCH v2 6/8] cputlb: Remove double-alignment in
 store_helper
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

We have already aligned page2 to the start of the next page.
There is no reason to do that a second time.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/cputlb.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index 7fb67d2f05..d0f8db33a2 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -1518,8 +1518,7 @@ store_helper(CPUArchState *env, target_ulong addr, uint64_t val,
         entry2 = tlb_entry(env, mmu_idx, page2);
         tlb_addr2 = tlb_addr_write(entry2);
         if (!tlb_hit_page(tlb_addr2, page2)
-            && !victim_tlb_hit(env, mmu_idx, index2, tlb_off,
-                               page2 & TARGET_PAGE_MASK)) {
+            && !victim_tlb_hit(env, mmu_idx, index2, tlb_off, page2)) {
             tlb_fill(env_cpu(env), page2, size2, MMU_DATA_STORE,
                      mmu_idx, retaddr);
         }
-- 
2.17.1



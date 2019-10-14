Return-Path: <SRS0=PUPy=YH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42875C4CECE
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 10:56:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0D8DE207FF
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 10:56:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XGLIPR6X"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D8DE207FF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47016 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iJy1v-0005m0-Ra
	for qemu-devel@archiver.kernel.org; Mon, 14 Oct 2019 06:56:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44565)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iJxvP-0007OU-S9
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 06:50:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iJxvO-00069H-GY
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 06:50:03 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:39768)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iJxvO-00064l-9R
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 06:50:02 -0400
Received: by mail-wr1-x442.google.com with SMTP id r3so19147941wrj.6
 for <qemu-devel@nongnu.org>; Mon, 14 Oct 2019 03:49:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=E4BbTLUhgH0gtmNgtyAxk8tGYN84mDNVyOEt1ck3Wbk=;
 b=XGLIPR6Xsw7LwxRHkhq6p6RCCGAAm7ICoPIEhGXbcTHBpVYqraazUia9Pj2fIzwWpg
 oM3eR8Mv5FfnFtsK0Jnu86/HgrT+H3PE/rzFuny+t0WlLcDidPh84I9aTeq8UTy4e7I+
 eBBVMsS6JniwfLc/ZdRc4DrZVl0QnNX+VUIECqSCkRDKZdMe28TmmscKR5QYkPkeLomn
 NrbPBHyApHqpaJmrQpvpjKYRBnq0ohdlpMUUR6IFi/aOzC08nGss3BF/hgcS+yOCdiEP
 wBtHCC6Vzp27CT2eGWFBOsIqoddYD5M11c+85uzcjTwAF2vjae6aP2KlFmPvtvZJsCHk
 uW5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=E4BbTLUhgH0gtmNgtyAxk8tGYN84mDNVyOEt1ck3Wbk=;
 b=fD5tvOPo/oVZ//0mt/hS8MId1CMHVK26aVCvO9F2iLfkiU474dLpN1fCZbzBXqru4+
 4IhglMvlQoEg2rn42JqK8tY0PQY6Cba6zmgjVnZRlbiz6GOW+2l3dRxpBECINkGDsFIo
 MAmnF07juhl+pr9P5bxy73KoAotvE1RYED6noa3kR+YsXeUMRcCyDluNRAghkZ7E1NQR
 0bnHIpSukRFFPxoXVjpPr7GfXbObxi2gKXmwziXTdi5iutNcTpLvXp8HGdI7pJaa2Iie
 Vz7G+f0sx+3AG3OgtQT0LrVOp2jWnm50lv26qqREobKNHa2SuwyCsryVDy4fTe+5TbPU
 Zg1g==
X-Gm-Message-State: APjAAAVx2uyfdiAG+972mhefADA0pT+INVsYKUd8sW18UMdzm1NtK+fn
 HDZpal0j/rGUKs8xYCokXgsAiQ==
X-Google-Smtp-Source: APXvYqzGKxdU6dRo7lGVZH95cJ622idO93uFEidxtXtRsWnze9lVMTd1lLlpxBFzXkDtoYVIqhWvpg==
X-Received: by 2002:a5d:638b:: with SMTP id p11mr18986022wru.372.1571050198810; 
 Mon, 14 Oct 2019 03:49:58 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id y13sm26345055wrg.8.2019.10.14.03.49.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Oct 2019 03:49:54 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 810321FF99;
 Mon, 14 Oct 2019 11:49:51 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v5 11/55] cputlb: document get_page_addr_code
Date: Mon, 14 Oct 2019 11:49:04 +0100
Message-Id: <20191014104948.4291-12-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191014104948.4291-1-alex.bennee@linaro.org>
References: <20191014104948.4291-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::442
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
Cc: robert.foley@futurewei.com,
 Richard Henderson <richard.henderson@linaro.org>, peter.puhov@futurewei.com,
 aaron@os.amperecomputing.com, cota@braap.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Emilio G. Cota" <cota@braap.org>

Suggested-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Emilio G. Cota <cota@braap.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/exec/exec-all.h | 24 +++++++++++++++++++++---
 1 file changed, 21 insertions(+), 3 deletions(-)

diff --git a/include/exec/exec-all.h b/include/exec/exec-all.h
index 49db07ba0b..6352316de1 100644
--- a/include/exec/exec-all.h
+++ b/include/exec/exec-all.h
@@ -487,7 +487,15 @@ void mmap_lock(void);
 void mmap_unlock(void);
 bool have_mmap_lock(void);
 
-static inline tb_page_addr_t get_page_addr_code(CPUArchState *env1, target_ulong addr)
+/**
+ * get_page_addr_code() - user-mode version
+ * @env: CPUArchState
+ * @addr: guest virtual address of guest code
+ *
+ * Returns @addr.
+ */
+static inline tb_page_addr_t get_page_addr_code(CPUArchState *env,
+                                                target_ulong addr)
 {
     return addr;
 }
@@ -495,8 +503,18 @@ static inline tb_page_addr_t get_page_addr_code(CPUArchState *env1, target_ulong
 static inline void mmap_lock(void) {}
 static inline void mmap_unlock(void) {}
 
-/* cputlb.c */
-tb_page_addr_t get_page_addr_code(CPUArchState *env1, target_ulong addr);
+/**
+ * get_page_addr_code() - full-system version
+ * @env: CPUArchState
+ * @addr: guest virtual address of guest code
+ *
+ * If we cannot translate and execute from the entire RAM page, or if
+ * the region is not backed by RAM, returns -1. Otherwise, returns the
+ * ram_addr_t corresponding to the guest code at @addr.
+ *
+ * Note: this function can trigger an exception.
+ */
+tb_page_addr_t get_page_addr_code(CPUArchState *env, target_ulong addr);
 
 void tlb_reset_dirty(CPUState *cpu, ram_addr_t start1, ram_addr_t length);
 void tlb_set_dirty(CPUState *cpu, target_ulong vaddr);
-- 
2.20.1



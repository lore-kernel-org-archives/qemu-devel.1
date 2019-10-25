Return-Path: <SRS0=bySr=YS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 171EECA9EA0
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 14:49:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D6F3A21929
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 14:49:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Yx0FCQUm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D6F3A21929
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33168 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iO0tp-0007QZ-Ar
	for qemu-devel@archiver.kernel.org; Fri, 25 Oct 2019 10:49:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44426)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iO0Tr-0005Hs-0I
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 10:22:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iO0To-0001hr-Sf
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 10:22:17 -0400
Received: from mail-qk1-x742.google.com ([2607:f8b0:4864:20::742]:36391)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iO0To-0001hd-Ou
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 10:22:16 -0400
Received: by mail-qk1-x742.google.com with SMTP id y189so1914231qkc.3
 for <qemu-devel@nongnu.org>; Fri, 25 Oct 2019 07:22:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Q9PA/XGaFb/7jgxWdyktquMDL4GhIzWDsxOacBvv2es=;
 b=Yx0FCQUmjnlC/9wLCFC/AqUil0d6MtaJ466kwyh+3F6W2HvrXAozjn/R9frjenq6m4
 o0h9eArCsFvGLrlGiikTT19M8drjyNC1edKt+qKufB2qgP5iWAGvVdpzPE6+ZTrzqu8r
 F5tRcYhN1K6Kn0nr1ML8eaVAU+VAev21XFk/2CQRNr8IaRdOojopO5tIi5XEWr1M5Nxp
 BY1TZ/9pcaYFXzrzNCB4rw4DbBrnmIkpcM6co5OkQic7VLPnGCUAFCiSXvsc7taFce2F
 KUmcpnFC6Ud9p2cdOnDIlRXJjZKwifAAM7fHIWpP03AYFpjZJDpDBE5SabcciJtWjgEp
 nKoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Q9PA/XGaFb/7jgxWdyktquMDL4GhIzWDsxOacBvv2es=;
 b=DW2hzuL7Dhttb4dXob3LERicuh2H2vOaVYpazUid+AL/Ma9A9u6Nnpl+HM3fvSYBrd
 3JGjEDoUBfSxNHWB8W7K1M09Rx5s/oCr95ggd0+9cCLhgiU47iDvQ5Ds8G6TQnPzoiBz
 RHhfRc3u1xfACKZEmmYhgGV7LgfU2H6PZoCseJnxI4yrQ01qTg9uc98urwXv24gWzXvk
 7LycfhwnX4FTs/apU026WCaoryyjsXjb0u/bzkQLfwubUlQrtBZjAODpivhUI4E+M6pp
 ics0XijGXeGo2fkERzEVlBP3OqfTIv2wxA/lWwTVow9CpFFEvu1vsebGULO/pGnwk+Tm
 qiJA==
X-Gm-Message-State: APjAAAWqopZCY08E1F57vkpHcfVA/NPdMbzh5lm5h4Gi8XEqQGyZouyo
 kv+lnNGwjUGKmIFoIkNE6IH3J5v0N1c=
X-Google-Smtp-Source: APXvYqws88YWxyBGLMZte4YCw7NNcZMhe9S478cfJn6qCSNFc1Dzop9UQjJhOR7Lui/gIhEKm9qVyg==
X-Received: by 2002:a05:620a:1321:: with SMTP id
 p1mr3093122qkj.272.1572013335810; 
 Fri, 25 Oct 2019 07:22:15 -0700 (PDT)
Received: from localhost.localdomain (rrcs-172-254-253-50.nyc.biz.rr.com.
 [172.254.253.50])
 by smtp.gmail.com with ESMTPSA id q17sm1137050qtq.58.2019.10.25.07.22.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Oct 2019 07:22:14 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 12/12] translate-all: Remove tb_alloc
Date: Fri, 25 Oct 2019 10:21:59 -0400
Message-Id: <20191025142159.12459-13-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191025142159.12459-1-richard.henderson@linaro.org>
References: <20191025142159.12459-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::742
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
Cc: peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Since 2ac01d6dafab, this function does only two things: assert a
lock is held, and call tcg_tb_alloc.  It is used exactly once,
and its user has already done the assert.

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Clement Deschamps <clement.deschamps@greensocs.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/translate-all.c | 20 ++------------------
 1 file changed, 2 insertions(+), 18 deletions(-)

diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
index f9b7ba159d..ae063b53f9 100644
--- a/accel/tcg/translate-all.c
+++ b/accel/tcg/translate-all.c
@@ -1156,23 +1156,6 @@ void tcg_exec_init(unsigned long tb_size)
 #endif
 }
 
-/*
- * Allocate a new translation block. Flush the translation buffer if
- * too many translation blocks or too much generated code.
- */
-static TranslationBlock *tb_alloc(target_ulong pc)
-{
-    TranslationBlock *tb;
-
-    assert_memory_lock();
-
-    tb = tcg_tb_alloc(tcg_ctx);
-    if (unlikely(tb == NULL)) {
-        return NULL;
-    }
-    return tb;
-}
-
 /* call with @p->lock held */
 static inline void invalidate_page_bitmap(PageDesc *p)
 {
@@ -1681,6 +1664,7 @@ TranslationBlock *tb_gen_code(CPUState *cpu,
     TCGProfile *prof = &tcg_ctx->prof;
     int64_t ti;
 #endif
+
     assert_memory_lock();
 
     phys_pc = get_page_addr_code(env, pc);
@@ -1706,7 +1690,7 @@ TranslationBlock *tb_gen_code(CPUState *cpu,
     }
 
  buffer_overflow:
-    tb = tb_alloc(pc);
+    tb = tcg_tb_alloc(tcg_ctx);
     if (unlikely(!tb)) {
         /* flush must be done */
         tb_flush(cpu);
-- 
2.17.1



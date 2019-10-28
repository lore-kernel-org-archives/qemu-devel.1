Return-Path: <SRS0=Szrt=YV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51C97C47E49
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Oct 2019 15:03:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1CF44214E0
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Oct 2019 15:03:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QJsBxjAe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1CF44214E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54786 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iP6YL-0002j7-Pb
	for qemu-devel@archiver.kernel.org; Mon, 28 Oct 2019 11:03:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44657)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iP6Us-0007Zd-AM
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 10:59:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iP6Ur-00046d-A4
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 10:59:54 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:40287)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iP6Ur-00045z-42
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 10:59:53 -0400
Received: by mail-wm1-x344.google.com with SMTP id w9so9478285wmm.5
 for <qemu-devel@nongnu.org>; Mon, 28 Oct 2019 07:59:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Q9PA/XGaFb/7jgxWdyktquMDL4GhIzWDsxOacBvv2es=;
 b=QJsBxjAeUya1E38QxU+EpNhYxqKnYUTcQa6vLp0TIjsiEtoH7rif02B86Qv/Vr+Rd1
 dBoY9UDqjHxE1OZXxQ+lvD08m6mBDbgFxD5NYiv92XnTQ3le1fcVmwP8LDh1WmX7LKtq
 i01yirOZZJD4o2kWz5rZV2KCFSeFxkdWa0DjvAJMVOBSuLotX/zPn3Tt79iYuWLLcVdC
 GOANLSbHgkaw4LZnfen06yrjzdWe3GnPvxiGYcRoqLXb0YsZYdyBU8z5F0GMEsygkvn9
 6XmEcY9LAaKlifH7WkbPkx7BUVK17ZBXvSZkNCh+LxXJCi2Kt1Ultxnpd0XxIcoKBFyc
 UpwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Q9PA/XGaFb/7jgxWdyktquMDL4GhIzWDsxOacBvv2es=;
 b=YCzbBwdDJmM5a0vLaYZ0/6fWaVDHagfHFasDkj6VxDbjO3TilbTC8rDuYuNco7BQM1
 +LddUihnCDA0V9lSDJtPWlA2XlUzvW84BZZv8xqO5C4fgLBwxMzVGInHrJb267CRDirC
 F4Vm8fjUaXX1a42xd/fxVznYocppE9D62GRMRD3/eNMzFFJa0zbSEeIU0wOAZ8EaDurT
 dUzoJ13uH6+st0mhfJ9DV0V7mmIPAsaRkExFAgi2p4H4iorvE6xKcOpWl+O6y0C8shwA
 pKlJr961OVz0yoXX5YVPiiRxfzDCtJimTJG8ILIiyc/aDlY/M9dPlIpfnPhFtTD+yGGi
 3eHg==
X-Gm-Message-State: APjAAAVPETGrtyZqiBl2WYLlXiqOqoGL9B79TzLsqaByl5UwNtGd8vlG
 lySDPGBJ5klvOlHMU0PnnDLFwIzW371DSg==
X-Google-Smtp-Source: APXvYqxx+M2uzGr09fMIa45wyr5mpiqlBhi78Bg8v068VK2aAOMWMdZ0Q8dVBLihqL+XaRMl8i6AuQ==
X-Received: by 2002:a1c:44:: with SMTP id 65mr369743wma.93.1572274791780;
 Mon, 28 Oct 2019 07:59:51 -0700 (PDT)
Received: from localhost.localdomain (230.106.138.88.rev.sfr.net.
 [88.138.106.230])
 by smtp.gmail.com with ESMTPSA id 143sm14842876wmb.33.2019.10.28.07.59.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Oct 2019 07:59:51 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL v2 12/12] translate-all: Remove tb_alloc
Date: Mon, 28 Oct 2019 15:59:37 +0100
Message-Id: <20191028145937.10914-13-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191028145937.10914-1-richard.henderson@linaro.org>
References: <20191028145937.10914-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::344
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



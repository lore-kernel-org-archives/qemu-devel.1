Return-Path: <SRS0=Oie8=3L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88359C2D0CE
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2020 02:52:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 504E12087E
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2020 02:52:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kz+qWa5+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 504E12087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35688 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iu67f-0007qR-7O
	for qemu-devel@archiver.kernel.org; Tue, 21 Jan 2020 21:52:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45212)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iu65m-0005eX-0f
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 21:50:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iu65k-0002lV-5j
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 21:50:05 -0500
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543]:45633)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iu65k-0002kx-0T
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 21:50:04 -0500
Received: by mail-pg1-x543.google.com with SMTP id b9so2608439pgk.12
 for <qemu-devel@nongnu.org>; Tue, 21 Jan 2020 18:50:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=6xOoTwiPWbJWg1dQvhdtD+14yzwztym6bWFoctdkQiM=;
 b=kz+qWa5+Z+v/qQftTxebP/DJ4lqYonIlT73ayK6t/p9ob/c3lzdsCrsA201cNA1Gll
 BcuYKQdWK8lqU5elp6mTA16gpqRBVbVOG26wZmMdk/QHpWT7vDiOP5Utx367FfeQnLAx
 rA46XRbP9JqZFfNS9ctyduB2uffw5+RUBBxHOokGBpyM4c9ViqfX7cYg22eFtJqtLS+m
 t2HdWFVanYyNcEgmNfpE/hi/FDeyyPlNvXMYfyqTLX07jRB0l6OqnABahMvwXn37fIcG
 J445cvq7Sd4f/PyK+FKaBPi/1+9gbHyd/lfQQfoPkNWSVkycIZhv2JZQEc5790U2ReFs
 Q3rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=6xOoTwiPWbJWg1dQvhdtD+14yzwztym6bWFoctdkQiM=;
 b=CHWA41Hc0AsGHYuK7m1pxLGLNxLndBOlsn1FCBPxkILMIeRLp2vqyR/MYYkGLTPrn+
 1Lv393sU8yyxRU82YjXWH7hGtYVjOqLBmFpP3eAC9m6fAyP7yI/6SrB2rSnFcQ315dFu
 RLEjNxnlVZdYDI84Fc8Enq6LaGdPcia4OK2Sr8o6WEfPwGsD6hRp/Fxb3vmO7mCidrRn
 wHWzfli/p8H7ujWg3wQAiqE+5Cdyyrs4jxX0OmNsbDdEsaPP5SI4une49yppvLUYuyE4
 JsbiyQ7oxncNRcBfR47He53Suy435VQHrVNVUzGzYV4/1EqCYkXnaimbu9cIn357vvfp
 6cow==
X-Gm-Message-State: APjAAAXP0njcRq7OZRqnvUvCvym1q3gU6SCMy9Dmpzy0m3tMlxi6Gfud
 SlYEEe0GhhsqoEio5pPD3FSYYTf26mw=
X-Google-Smtp-Source: APXvYqzNwo6Sr1TuBt4tfMN5kcXQ//tKME085H2vus2z0X4Og1j4uk4UZRsUmWJnOZrTGIms/LlgUw==
X-Received: by 2002:a65:4109:: with SMTP id w9mr8683687pgp.383.1579661401842; 
 Tue, 21 Jan 2020 18:50:01 -0800 (PST)
Received: from localhost.localdomain (rrcs-173-198-77-92.west.biz.rr.com.
 [173.198.77.92])
 by smtp.gmail.com with ESMTPSA id c22sm44149883pfo.50.2020.01.21.18.50.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Jan 2020 18:50:01 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 07/16] cputlb: Merge tlb_table_flush_by_mmuidx into
 tlb_flush_one_mmuidx_locked
Date: Tue, 21 Jan 2020 16:49:37 -1000
Message-Id: <20200122024946.28484-8-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200122024946.28484-1-richard.henderson@linaro.org>
References: <20200122024946.28484-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::543
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
Cc: peter.maydell@linaro.org, Alistair Francis <alistair.francis@wdc.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

There is only one caller for tlb_table_flush_by_mmuidx.  Place
the result at the earlier line number, due to an expected user
in the near future.

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/cputlb.c | 19 +++++++------------
 1 file changed, 7 insertions(+), 12 deletions(-)

diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index 02b381cf50..3a4881cf69 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -224,11 +224,16 @@ static void tlb_mmu_resize_locked(CPUArchState *env, int mmu_idx)
     }
 }
 
-static inline void tlb_table_flush_by_mmuidx(CPUArchState *env, int mmu_idx)
+static void tlb_flush_one_mmuidx_locked(CPUArchState *env, int mmu_idx)
 {
     tlb_mmu_resize_locked(env, mmu_idx);
-    memset(env_tlb(env)->f[mmu_idx].table, -1, sizeof_tlb(env, mmu_idx));
     env_tlb(env)->d[mmu_idx].n_used_entries = 0;
+    env_tlb(env)->d[mmu_idx].large_page_addr = -1;
+    env_tlb(env)->d[mmu_idx].large_page_mask = -1;
+    env_tlb(env)->d[mmu_idx].vindex = 0;
+    memset(env_tlb(env)->f[mmu_idx].table, -1, sizeof_tlb(env, mmu_idx));
+    memset(env_tlb(env)->d[mmu_idx].vtable, -1,
+           sizeof(env_tlb(env)->d[0].vtable));
 }
 
 static inline void tlb_n_used_entries_inc(CPUArchState *env, uintptr_t mmu_idx)
@@ -289,16 +294,6 @@ void tlb_flush_counts(size_t *pfull, size_t *ppart, size_t *pelide)
     *pelide = elide;
 }
 
-static void tlb_flush_one_mmuidx_locked(CPUArchState *env, int mmu_idx)
-{
-    tlb_table_flush_by_mmuidx(env, mmu_idx);
-    env_tlb(env)->d[mmu_idx].large_page_addr = -1;
-    env_tlb(env)->d[mmu_idx].large_page_mask = -1;
-    env_tlb(env)->d[mmu_idx].vindex = 0;
-    memset(env_tlb(env)->d[mmu_idx].vtable, -1,
-           sizeof(env_tlb(env)->d[0].vtable));
-}
-
 static void tlb_flush_by_mmuidx_async_work(CPUState *cpu, run_on_cpu_data data)
 {
     CPUArchState *env = cpu->env_ptr;
-- 
2.20.1



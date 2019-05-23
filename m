Return-Path: <SRS0=bvyN=TX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9881EC282DD
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2019 15:15:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 56172204EC
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2019 15:15:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zANyOXl8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 56172204EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:38607 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hTpQt-0004jQ-JT
	for qemu-devel@archiver.kernel.org; Thu, 23 May 2019 11:15:03 -0400
Received: from eggs.gnu.org ([209.51.188.92]:39705)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hTpKJ-0007Sc-RR
	for qemu-devel@nongnu.org; Thu, 23 May 2019 11:08:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hTpKI-0001st-MR
	for qemu-devel@nongnu.org; Thu, 23 May 2019 11:08:15 -0400
Received: from mail-ua1-x942.google.com ([2607:f8b0:4864:20::942]:36937)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hTpKI-0001si-HS
	for qemu-devel@nongnu.org; Thu, 23 May 2019 11:08:14 -0400
Received: by mail-ua1-x942.google.com with SMTP id t18so2299970uar.4
	for <qemu-devel@nongnu.org>; Thu, 23 May 2019 08:08:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=Ww2LSp6bczaair+HE3835uyxzaqJh3az+j6QKvIto98=;
	b=zANyOXl868k1DZ2O2uw27Zc+Ij5525RFDlxmgzWpoaQyraKh2FMJKjBYjcd1AtCWhV
	aEYdYaWntos3m5VseeFCeiatLTymiEoYaczJWghufdZrZvGihK1OGCQP2doidjLFJFmn
	bCOrpZy349QfP+ep6P/n0AuJZez+sHHDby90Uh2kc7BP4Nv0c4l3ti1kl/PTfhDbi7Sp
	udQJQXiWU/mEfa5W0VGVqHsKc8EKdz27zoteHp5xBtMTVd1ffejQ6QYWRo2SEj7QtXy4
	3Oq5Ca5yTzsl5KrFp7q9iCAiaCXMYjCYzzgPsQ+4xPvr7duZd/Q9ej7bfx7o126jNvRO
	tp6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=Ww2LSp6bczaair+HE3835uyxzaqJh3az+j6QKvIto98=;
	b=Jx5gTrKIdfq+qTBTOrIXMsBvhAw/jEq+9uZifvBnO/48URiNYTSUWk5cMJ22fsYgvE
	jsBdRq3vqP/ntia+x1Kijol0MePj04Yd878/Hc0Vz6o/vYPKS9ksLEMbf+SiihPYlxek
	L6vzfhCFutsCiLSH2Ko8a1wRI+YU/9LhMMBk3+1DA6o6RPiqswuTLwsw8sdxcILKG/xa
	q2n0sAR4Ij8KMHZ3xWM5jirK6veBbdXL+x685wXKJ5iblRv4fEtbl55cosSSeKx/Td86
	G9cX3xZignD53e2k7b+n07ADORehwpiJbCuHqrjYpjlmsmwVatxz40sCXgpFfDs0138d
	bt6g==
X-Gm-Message-State: APjAAAVdSj4FSEUIMz6WXJeM0v2Rwry6FC/HOyyfBN51+sDY/+nXEHhw
	a2rm/eNVpcQoY5h4nF8yb0yHulWkFTI=
X-Google-Smtp-Source: APXvYqwkEQObKS7sJQO6zxIML2xyzIK5J0zAG6KzWH+yYwoTod0hZze4s/DtGdb683gloYP/639d2g==
X-Received: by 2002:a9f:376e:: with SMTP id a43mr8798178uae.57.1558624093591; 
	Thu, 23 May 2019 08:08:13 -0700 (PDT)
Received: from localhost.localdomain (ip-173-130-215-183.orldfl.spcsdns.net.
	[173.130.215.183]) by smtp.gmail.com with ESMTPSA id
	p70sm4227462vsd.25.2019.05.23.08.08.12
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 23 May 2019 08:08:12 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Thu, 23 May 2019 11:08:02 -0400
Message-Id: <20190523150803.31504-6-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190523150803.31504-1-richard.henderson@linaro.org>
References: <20190523150803.31504-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::942
Subject: [Qemu-devel] [PATCH 5/6] target/rx: Collect all bytes during
 disassembly
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
Cc: ysato@users.sourceforge.jp
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Collected, to be used in the next patch.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/rx/disas.c | 62 ++++++++++++++++++++++++++++++++---------------
 1 file changed, 42 insertions(+), 20 deletions(-)

diff --git a/target/rx/disas.c b/target/rx/disas.c
index ebc1a44249..5a32a87534 100644
--- a/target/rx/disas.c
+++ b/target/rx/disas.c
@@ -25,43 +25,59 @@ typedef struct DisasContext {
     disassemble_info *dis;
     uint32_t addr;
     uint32_t pc;
+    uint8_t len;
+    uint8_t bytes[8];
 } DisasContext;
 
 
 static uint32_t decode_load_bytes(DisasContext *ctx, uint32_t insn,
-                           int i, int n)
+                                  int i, int n)
 {
-    bfd_byte buf;
+    uint32_t addr = ctx->addr;
+
+    g_assert(ctx->len == i);
+    g_assert(n <= ARRAY_SIZE(ctx->bytes));
+
     while (++i <= n) {
-        ctx->dis->read_memory_func(ctx->addr++, &buf, 1, ctx->dis);
-        insn |= buf << (32 - i * 8);
+        ctx->dis->read_memory_func(addr++, &ctx->bytes[i - 1], 1, ctx->dis);
+        insn |= ctx->bytes[i - 1] << (32 - i * 8);
     }
+    ctx->addr = addr;
+    ctx->len = n;
+
     return insn;
 }
 
 static int32_t li(DisasContext *ctx, int sz)
 {
-    int32_t addr;
-    bfd_byte buf[4];
-    addr = ctx->addr;
+    uint32_t addr = ctx->addr;
+    uintptr_t len = ctx->len;
 
     switch (sz) {
     case 1:
+        g_assert(len + 1 <= ARRAY_SIZE(ctx->bytes));
         ctx->addr += 1;
-        ctx->dis->read_memory_func(addr, buf, 1, ctx->dis);
-        return (int8_t)buf[0];
+        ctx->len += 1;
+        ctx->dis->read_memory_func(addr, ctx->bytes + len, 1, ctx->dis);
+        return (int8_t)ctx->bytes[len];
     case 2:
+        g_assert(len + 2 <= ARRAY_SIZE(ctx->bytes));
         ctx->addr += 2;
-        ctx->dis->read_memory_func(addr, buf, 2, ctx->dis);
-        return ldsw_le_p(buf);
+        ctx->len += 2;
+        ctx->dis->read_memory_func(addr, ctx->bytes + len, 2, ctx->dis);
+        return ldsw_le_p(ctx->bytes + len);
     case 3:
+        g_assert(len + 3 <= ARRAY_SIZE(ctx->bytes));
         ctx->addr += 3;
-        ctx->dis->read_memory_func(addr, buf, 3, ctx->dis);
-        return (int8_t)buf[2] << 16 | lduw_le_p(buf);
+        ctx->len += 3;
+        ctx->dis->read_memory_func(addr, ctx->bytes + len, 3, ctx->dis);
+        return (int8_t)ctx->bytes[len + 2] << 16 | lduw_le_p(ctx->bytes + len);
     case 0:
+        g_assert(len + 4 <= ARRAY_SIZE(ctx->bytes));
         ctx->addr += 4;
-        ctx->dis->read_memory_func(addr, buf, 4, ctx->dis);
-        return ldl_le_p(buf);
+        ctx->len += 4;
+        ctx->dis->read_memory_func(addr, ctx->bytes + len, 4, ctx->dis);
+        return ldl_le_p(ctx->bytes + len);
     default:
         g_assert_not_reached();
     }
@@ -110,7 +126,7 @@ static const char psw[] = {
 static void rx_index_addr(DisasContext *ctx, char out[8], int ld, int mi)
 {
     uint32_t addr = ctx->addr;
-    uint8_t buf[2];
+    uintptr_t len = ctx->len;
     uint16_t dsp;
 
     switch (ld) {
@@ -119,14 +135,18 @@ static void rx_index_addr(DisasContext *ctx, char out[8], int ld, int mi)
         out[0] = '\0';
         return;
     case 1:
+        g_assert(len + 1 <= ARRAY_SIZE(ctx->bytes));
         ctx->addr += 1;
-        ctx->dis->read_memory_func(addr, buf, 1, ctx->dis);
-        dsp = buf[0];
+        ctx->len += 1;
+        ctx->dis->read_memory_func(addr, ctx->bytes + len, 1, ctx->dis);
+        dsp = ctx->bytes[len];
         break;
     case 2:
+        g_assert(len + 2 <= ARRAY_SIZE(ctx->bytes));
         ctx->addr += 2;
-        ctx->dis->read_memory_func(addr, buf, 2, ctx->dis);
-        dsp = lduw_le_p(buf);
+        ctx->len += 2;
+        ctx->dis->read_memory_func(addr, ctx->bytes + len, 2, ctx->dis);
+        dsp = lduw_le_p(ctx->bytes + len);
         break;
     default:
         g_assert_not_reached();
@@ -1392,8 +1412,10 @@ int print_insn_rx(bfd_vma addr, disassemble_info *dis)
     DisasContext ctx;
     uint32_t insn;
     int i;
+
     ctx.dis = dis;
     ctx.pc = ctx.addr = addr;
+    ctx.len = 0;
 
     insn = decode_load(&ctx);
     if (!decode(&ctx, insn)) {
-- 
2.17.1



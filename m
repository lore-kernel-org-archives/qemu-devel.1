Return-Path: <SRS0=hY9S=T7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 946ABC04AB6
	for <qemu-devel@archiver.kernel.org>; Fri, 31 May 2019 14:07:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4C7A4269F8
	for <qemu-devel@archiver.kernel.org>; Fri, 31 May 2019 14:07:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XBTODAWN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C7A4269F8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:44155 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hWiCE-0000Sw-Iz
	for qemu-devel@archiver.kernel.org; Fri, 31 May 2019 10:07:50 -0400
Received: from eggs.gnu.org ([209.51.188.92]:34659)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hWhp2-0007i3-6B
	for qemu-devel@nongnu.org; Fri, 31 May 2019 09:43:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hWhp0-0000hY-TW
	for qemu-devel@nongnu.org; Fri, 31 May 2019 09:43:52 -0400
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:41522)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hWhp0-0000fL-Mk
	for qemu-devel@nongnu.org; Fri, 31 May 2019 09:43:50 -0400
Received: by mail-ot1-x341.google.com with SMTP id 107so3390922otj.8
	for <qemu-devel@nongnu.org>; Fri, 31 May 2019 06:43:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=PpQi8m0GZI0Rzy/CPFH3P+XfVLz124wPRty/co7AxNU=;
	b=XBTODAWNWjTtKZRhBdP6Wpb9GjHtF/WCHnoaabY8IIkyecepwIY5Pck1sHgdjBCsvY
	pVQqZnTM5C39Z7etum0+KzvAOod1WLwfdJ4dF6wvaNw2fxZ9Gy2/XEVG1KssHUFRHYEb
	kOF7XEevpxI2rwoMvcGS04Zs0giCKTTjKq+2+lib6yS3G/ynJ8ehQrNql3HWj9xd1AFy
	bU5Vxpu3mN+n9SEbVtY2awqVseDcrJKlW19/AvWPVNnyv/KckaiAMCL9wcf/jp4uscTH
	mFowUiMn3QVS4J+uc5Vu0/4LT5UzWmxeZi5DAVV9D2aOB7mQrsUafBg3hvv+57OvU+8b
	bnEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=PpQi8m0GZI0Rzy/CPFH3P+XfVLz124wPRty/co7AxNU=;
	b=ghymGSCOp+yybHw6JVeBrJp1Crf3xAu7lNalDPiE+uLE3c4EjH4nOl3mwtWqNRT/5r
	TjnwGhOyRrN1vy9BOCMb4vBZ4hkZqdpjVIufRJEcwkwtPRqCsYulIvH39z6S0OAeGr5+
	8LCEqKC1Fm7BoaedYnfKuUcxCSE7/pPsRGbOG96kW3Hd7j/+Wa9BCtXGVUbykegGuLdQ
	NmaAGde/pSHIvUWSaRw/VLrAH0yb1qMLqYFY0II6Z4H7uQf7o8Op2mCOE7L1Wz+nsGyf
	T3WqZI5bzN9D+bpXew7W1Vuu6pNfdy593BXk7AktPsi7OEl+rqVUqa61yMVUgA2gWvrt
	zGmg==
X-Gm-Message-State: APjAAAUfVm+6cFlqzuALM8OCmVXlxqc+oy1P796yBYqTC+f12uB3pcmH
	PoicGUkML4SCXtd+z2cNijC3/6VHoBFawQ==
X-Google-Smtp-Source: APXvYqyaOEJyioL/TAmjEJ6ZKoolygAzjUgu+/4VZYy7MoAbYQhtDSVTDro36m9Auyd5pAw5nOhR/g==
X-Received: by 2002:a9d:27e5:: with SMTP id c92mr1986036otb.318.1559310229886; 
	Fri, 31 May 2019 06:43:49 -0700 (PDT)
Received: from localhost.localdomain (168.189-204-159.bestelclientes.com.mx.
	[189.204.159.168]) by smtp.gmail.com with ESMTPSA id
	r23sm2391176otg.49.2019.05.31.06.43.48
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 31 May 2019 06:43:49 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Fri, 31 May 2019 08:43:14 -0500
Message-Id: <20190531134315.4109-23-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190531134315.4109-1-richard.henderson@linaro.org>
References: <20190531134315.4109-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::341
Subject: [Qemu-devel] [PATCH v16 22/23] target/rx: Collect all bytes during
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
Cc: philmd@redhat.com, ysato@users.sourceforge.jp
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Collected, to be used in the next patch.

Reviewed-by: Yoshinori Sato <ysato@users.sourceforge.jp>
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



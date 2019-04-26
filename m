Return-Path: <SRS0=QtPl=S4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE214C43218
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Apr 2019 04:49:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 74C12206BF
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Apr 2019 04:49:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SF69tbtu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 74C12206BF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:39102 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hJso4-0001ph-J1
	for qemu-devel@archiver.kernel.org; Fri, 26 Apr 2019 00:49:52 -0400
Received: from eggs.gnu.org ([209.51.188.92]:45317)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <arilou@gmail.com>) id 1hJsmG-0000dE-8i
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 00:48:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <arilou@gmail.com>) id 1hJsbJ-0004lK-11
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 00:36:41 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:37710)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <arilou@gmail.com>) id 1hJsbI-0004k6-R4
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 00:36:40 -0400
Received: by mail-wm1-x344.google.com with SMTP id y5so1351800wma.2
	for <qemu-devel@nongnu.org>; Thu, 25 Apr 2019 21:36:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=b1bpFqGwMibMAfq1pbDbHkF4Xk3yQKA0SG1CtWad0g4=;
	b=SF69tbtuEDfg+zVkwn3CyXSc7922uL/xeUTg2YwU2RWtPLiahhSeWdg7vTicTpoF/C
	lFxvg6MxTz1aqgpaTj+RlrkdR4pj96d+ja1btTuhI4xri/WdAiBTYaVksB90lfYsyREJ
	pYMZRK532vLySjDfA1ok8oH6wePv7eb7VlNLJuraxhOaPo8PGTSB/HEMx5OakAFBWhV1
	gZifn50K8LG6hRMt7s1dfHzN13fVh+hGVC3ABmp83w+buVz8eWfiKGlUMFpL7miTyQnb
	irU1W1V/D1ah0ExcRFy2wxHKOsQ9qY7Ps+iOAPEZhG1nrn0hs0iULJLJ+OrGKbKEl3sY
	SAYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=b1bpFqGwMibMAfq1pbDbHkF4Xk3yQKA0SG1CtWad0g4=;
	b=OpdbUNzst2os4Hzpas2y7O2+n/k6EG6Nuw9UPazw3UykTaufn5jsN5l8bYFVG8CJsM
	HTTwvlKX9vvbBZdQVC3D3yHhlUn8+BZk8ZN3ClBaFLnIHa4ECQCn0rzjCsQsjSHOT8vF
	VrEGhsJ1ekgzXXKmlSbb09jdpve8+8ImS64QJN/f8Qijr9UtPFt+vf6AsimMRbEwglhn
	Ksxcwvszj6LXtG+XS1AFPVhVZXEMiLl/MZ/09cueySHhywm7EULBl1K+i6/ZxwJQfZFX
	uhA4xeBnJrLB8VQROgvlnsNdkTpkUfTh4LlUXvjnFtO1rJVjdtwI/SoaIMPK72Pzy0Xn
	YRhA==
X-Gm-Message-State: APjAAAU9c20FOZHZooQ7J2rpeHTv3E0Ry4MN3m5b7kVymRERyP9X13+8
	laatLTXt42UxdXiw5hezvR2CU5g6
X-Google-Smtp-Source: APXvYqzOaBgVLX8/6c8SKgeDQv7EqNAdkemjvAZwCtNWrHPqkDAuRhldM4ZoW3o3pM8xqqdHv5qdFw==
X-Received: by 2002:a7b:cd93:: with SMTP id y19mr5830979wmj.113.1556253399095; 
	Thu, 25 Apr 2019 21:36:39 -0700 (PDT)
Received: from localhost.localdomain (bzq-79-178-247-46.red.bezeqint.net.
	[79.178.247.46])
	by smtp.gmail.com with ESMTPSA id h5sm3467088wmf.38.2019.04.25.21.36.36
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Thu, 25 Apr 2019 21:36:37 -0700 (PDT)
From: Jon Doron <arilou@gmail.com>
To: qemu-devel@nongnu.org
Date: Fri, 26 Apr 2019 07:35:51 +0300
Message-Id: <20190426043558.6888-15-arilou@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190426043558.6888-1-arilou@gmail.com>
References: <20190426043558.6888-1-arilou@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::344
Subject: [Qemu-devel] [PATCH v7 14/21] gdbstub: Implement read all registers
 (g pkt) with new infra
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
Cc: alex.bennee@linaro.org, Jon Doron <arilou@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190426043551.HT8gRexr2z7tMnGabS6oxAbguWvZdvYkLzF9LaqRWSo@z>

Signed-off-by: Jon Doron <arilou@gmail.com>
---
 gdbstub.c | 31 +++++++++++++++++++++++--------
 1 file changed, 23 insertions(+), 8 deletions(-)

diff --git a/gdbstub.c b/gdbstub.c
index adfe39b3a3..3478ac778d 100644
--- a/gdbstub.c
+++ b/gdbstub.c
@@ -1757,6 +1757,21 @@ static void handle_write_all_regs(GdbCmdContext *gdb_ctx, void *user_ctx)
     put_packet(gdb_ctx->s, "OK");
 }
 
+static void handle_read_all_regs(GdbCmdContext *gdb_ctx, void *user_ctx)
+{
+    target_ulong addr, len;
+
+    cpu_synchronize_state(gdb_ctx->s->g_cpu);
+    len = 0;
+    for (addr = 0; addr < gdb_ctx->s->g_cpu->gdb_num_g_regs; addr++) {
+        len += gdb_read_register(gdb_ctx->s->g_cpu, gdb_ctx->mem_buf + len,
+                                 addr);
+    }
+
+    memtohex(gdb_ctx->str_buf, gdb_ctx->mem_buf, len);
+    put_packet(gdb_ctx->s, gdb_ctx->str_buf);
+}
+
 static int gdb_handle_packet(GDBState *s, const char *line_buf)
 {
     CPUState *cpu;
@@ -1764,7 +1779,7 @@ static int gdb_handle_packet(GDBState *s, const char *line_buf)
     CPUClass *cc;
     const char *p;
     uint32_t pid, tid;
-    int ch, reg_size, type, res;
+    int ch, type, res;
     uint8_t mem_buf[MAX_PACKET_LENGTH];
     char buf[sizeof(mem_buf) + 1 /* trailing NUL */];
     char thread_id[16];
@@ -1923,14 +1938,14 @@ static int gdb_handle_packet(GDBState *s, const char *line_buf)
         }
         break;
     case 'g':
-        cpu_synchronize_state(s->g_cpu);
-        len = 0;
-        for (addr = 0; addr < s->g_cpu->gdb_num_g_regs; addr++) {
-            reg_size = gdb_read_register(s->g_cpu, mem_buf + len, addr);
-            len += reg_size;
+        {
+            static const GdbCmdParseEntry read_all_regs_cmd_desc = {
+                .handler = handle_read_all_regs,
+                .cmd = "g",
+                .cmd_startswith = 1
+            };
+            cmd_parser = &read_all_regs_cmd_desc;
         }
-        memtohex(buf, mem_buf, len);
-        put_packet(s, buf);
         break;
     case 'G':
         {
-- 
2.20.1



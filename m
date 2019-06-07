Return-Path: <SRS0=3yEa=UG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25BBCC28CC3
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 10:07:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E11C8208E3
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 10:07:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ST2Qu6Gn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E11C8208E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47810 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hZBmO-0004Vz-4H
	for qemu-devel@archiver.kernel.org; Fri, 07 Jun 2019 06:07:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42204)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alex.bennee@linaro.org>) id 1hZAvT-0002Fb-Ad
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 05:12:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1hZAvQ-0004zq-Us
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 05:12:43 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436]:42789)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1hZAvQ-0004wN-LI
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 05:12:40 -0400
Received: by mail-wr1-x436.google.com with SMTP id x17so1355992wrl.9
 for <qemu-devel@nongnu.org>; Fri, 07 Jun 2019 02:12:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=IdumfQ3u3Nl836FqdxSsx6BT98OtMa92VXr8v3RCJYs=;
 b=ST2Qu6Gn1Zt7sndEgUQGFFHhqh44jHqtPgmMJxkDS+tOMLAF+XkdboI9FiUq3eq7hq
 TmguoDZm0FZ37IORFjPILFWWVt+XuoITMLeckLJ2mhcfv6ZEPMizMEfw5rCqltIci5OL
 nsfE3ZhrhxAXvNVqkZVH1zK0vbLv3ULliBHPVfbQe9F9ABf7Fvu4ifr3h2X1yK5WMJAW
 f7rsujrXqX0d+ie4YpNblGoD2OSbSOOw5IbNfVyshtZXHFbq5qi9OuH4kHUDiYvDbX/N
 NkznSFTniT4THZTqjHYgATglcMN11UXC2qXfm/1gY3VIU5EZQU3hDsh0K2qfa35DUo1o
 MBdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=IdumfQ3u3Nl836FqdxSsx6BT98OtMa92VXr8v3RCJYs=;
 b=kILc4BjO2yvbNy2sBhXCcvaQd/X/zVyZJzgullkW5Bm+si71d4DL+B6zpgnmYMMBoa
 DrU79hyZoYfdp+RcUYOc93Ul/alhFe2YZ+e+Iyv+PXQzkIGjGZ6Pa/sn6al7wrcLvBX8
 jl3m9OAoLDBRIkxQ8SLabVnLLJ59PQ0LQn13vVb4s4onVMRw8QVc61ODY+3U2ujxoN73
 2qf6cyijgFryNKBkSLTbcbgq/Q7U7NT7tBfHfI+T7udbIpxaYzyWjfU/vO2GSxDWqWND
 fs4BaW2Z+OuG7gtOUq4b4a2DYuoYqClYt3aoXsGnXdberXPSESBYZCZumgiDGcR2Co+8
 N2fQ==
X-Gm-Message-State: APjAAAXdDW7dezfMw1zjf5pZHMNMUB2pQmVQW037JggERP43cUKkUlcs
 pX/MPE4EYvISsLvgxGPxTo6wvA==
X-Google-Smtp-Source: APXvYqxI2PzZGNCyAKL2h6p2wKPLnoAHYUOhVCIVUvkk4affql3jbrZbxoIbSD2vBDGeK3G6VGDkxQ==
X-Received: by 2002:adf:eb43:: with SMTP id u3mr19026914wrn.342.1559898759161; 
 Fri, 07 Jun 2019 02:12:39 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
 by smtp.gmail.com with ESMTPSA id f2sm2048681wrq.48.2019.06.07.02.12.32
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Fri, 07 Jun 2019 02:12:36 -0700 (PDT)
Received: from zen.linaroharston. (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 83CDE1FFC3;
 Fri,  7 Jun 2019 10:05:55 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Date: Fri,  7 Jun 2019 10:05:43 +0100
Message-Id: <20190607090552.12434-45-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190607090552.12434-1-alex.bennee@linaro.org>
References: <20190607090552.12434-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::436
Subject: [Qemu-devel] [PULL 44/52] gdbstub: Implement write all registers (G
 pkt) with new infra
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
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org,
 Jon Doron <arilou@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Jon Doron <arilou@gmail.com>

Signed-off-by: Jon Doron <arilou@gmail.com>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20190529064148.19856-13-arilou@gmail.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/gdbstub.c b/gdbstub.c
index ceaa47d184..880bbb469a 100644
--- a/gdbstub.c
+++ b/gdbstub.c
@@ -1751,6 +1751,29 @@ static void handle_read_mem(GdbCmdContext *gdb_ctx, void *user_ctx)
     put_packet(gdb_ctx->s, gdb_ctx->str_buf);
 }
 
+static void handle_write_all_regs(GdbCmdContext *gdb_ctx, void *user_ctx)
+{
+    target_ulong addr, len;
+    uint8_t *registers;
+    int reg_size;
+
+    if (!gdb_ctx->num_params) {
+        return;
+    }
+
+    cpu_synchronize_state(gdb_ctx->s->g_cpu);
+    registers = gdb_ctx->mem_buf;
+    len = strlen(gdb_ctx->params[0].data) / 2;
+    hextomem(registers, gdb_ctx->params[0].data, len);
+    for (addr = 0; addr < gdb_ctx->s->g_cpu->gdb_num_g_regs && len > 0;
+         addr++) {
+        reg_size = gdb_write_register(gdb_ctx->s->g_cpu, registers, addr);
+        len -= reg_size;
+        registers += reg_size;
+    }
+    put_packet(gdb_ctx->s, "OK");
+}
+
 static int gdb_handle_packet(GDBState *s, const char *line_buf)
 {
     CPUState *cpu;
@@ -1762,7 +1785,6 @@ static int gdb_handle_packet(GDBState *s, const char *line_buf)
     uint8_t mem_buf[MAX_PACKET_LENGTH];
     char buf[sizeof(mem_buf) + 1 /* trailing NUL */];
     char thread_id[16];
-    uint8_t *registers;
     target_ulong addr, len;
     const GdbCmdParseEntry *cmd_parser = NULL;
 
@@ -1928,16 +1950,15 @@ static int gdb_handle_packet(GDBState *s, const char *line_buf)
         put_packet(s, buf);
         break;
     case 'G':
-        cpu_synchronize_state(s->g_cpu);
-        registers = mem_buf;
-        len = strlen(p) / 2;
-        hextomem((uint8_t *)registers, p, len);
-        for (addr = 0; addr < s->g_cpu->gdb_num_g_regs && len > 0; addr++) {
-            reg_size = gdb_write_register(s->g_cpu, registers, addr);
-            len -= reg_size;
-            registers += reg_size;
+        {
+            static const GdbCmdParseEntry write_all_regs_cmd_desc = {
+                .handler = handle_write_all_regs,
+                .cmd = "G",
+                .cmd_startswith = 1,
+                .schema = "s0"
+            };
+            cmd_parser = &write_all_regs_cmd_desc;
         }
-        put_packet(s, "OK");
         break;
     case 'm':
         {
-- 
2.20.1



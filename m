Return-Path: <SRS0=QtPl=S4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9020C4321A
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Apr 2019 04:52:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BD8A020656
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Apr 2019 04:52:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FXTZ8XPV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD8A020656
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:39165 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hJsqg-00053F-T7
	for qemu-devel@archiver.kernel.org; Fri, 26 Apr 2019 00:52:34 -0400
Received: from eggs.gnu.org ([209.51.188.92]:45317)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <arilou@gmail.com>) id 1hJsmc-0000dE-Bq
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 00:48:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <arilou@gmail.com>) id 1hJsbG-0004hO-6t
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 00:36:39 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:39838)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <arilou@gmail.com>) id 1hJsbG-0004ff-0X
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 00:36:38 -0400
Received: by mail-wr1-x444.google.com with SMTP id a9so2450912wrp.6
	for <qemu-devel@nongnu.org>; Thu, 25 Apr 2019 21:36:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=brvpFyYDw1Z1o2sLMNd/sMXNZo4TYemLFYCJt79OgBg=;
	b=FXTZ8XPVS8D4pT7Cl+s3Qv6byaZMDwBpVhPZgTsGh72pNVfM+xxTBxYu9c/o0gGG6b
	rpoyn2liujoAXU5N+9jRcCz0YkHKWprYwYt0+VS7BvykmyEoRkU5bsYy28vxMuRrHBx5
	7c6mRui8gUJRRwDnLBG7WqxKD0NY9w7C/0bPL55o9aMdBDXMZv2d+sKtEKnjPhp2pz57
	ow3DC1hCMN7BCBM8aJQ5aQbmZV299OJ1JVJGp4yhLDCCDXv3c/AirwajsRZ2q1D4yEGj
	JX0Lgc9796msTOf7VyLADLRaajQdbGPa/L5KUbJjinCIBTWTIhpXjTdvsTqO4rgQ7/H3
	C0nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=brvpFyYDw1Z1o2sLMNd/sMXNZo4TYemLFYCJt79OgBg=;
	b=kX+ODuAvCyCN5lL7kJnO08q/0nfQifyOvUVLTAKvQbeU3vWjPIeWiuuY1iOaH5PguL
	hueBLqDVvAiPuiddR7bmByxjMnFiZpdDah4rJ2f9Pqkz/oV4CmAb370S6yAOaedgYxLr
	IyMCiO0RI11uV29cEwpvengrIe9SQVplKNYj3GF90kYBsQvBQ/td6Semzid97w7/SrCR
	ElWu6nj8szY/Umx5I3kG6vbgiFo3y0CydlMKAiw7fv7OY5CH+v0we7/uLzWvMqgZKrgM
	zJNR8/3QkxVYdE+xd4+ZHtTUziUOlloj89OlvY2tE4UvDHF8FaGejmXq2TRPqK7lWlED
	/AMw==
X-Gm-Message-State: APjAAAUak/1kGt3XcoUsfMm32W8O1ny58Gd3okQjkMqIyRdTCTe3Y7xW
	4WtYXAedqkOQxKmmaf0rkC+xUOJi
X-Google-Smtp-Source: APXvYqypD/bXasoSh60qqJm5uUQRcOsU0iDBc6IOBVQYCDPCSdNt/12J9JMDUfLi8MTU+t/FfbEHXA==
X-Received: by 2002:adf:e591:: with SMTP id l17mr2252727wrm.238.1556253396328; 
	Thu, 25 Apr 2019 21:36:36 -0700 (PDT)
Received: from localhost.localdomain (bzq-79-178-247-46.red.bezeqint.net.
	[79.178.247.46])
	by smtp.gmail.com with ESMTPSA id h5sm3467088wmf.38.2019.04.25.21.36.32
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Thu, 25 Apr 2019 21:36:34 -0700 (PDT)
From: Jon Doron <arilou@gmail.com>
To: qemu-devel@nongnu.org
Date: Fri, 26 Apr 2019 07:35:50 +0300
Message-Id: <20190426043558.6888-14-arilou@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190426043558.6888-1-arilou@gmail.com>
References: <20190426043558.6888-1-arilou@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::444
Subject: [Qemu-devel] [PATCH v7 13/21] gdbstub: Implement write all
 registers (G pkt) with new infra
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
Message-ID: <20190426043550.v4ZCi4jmwGqTyGMhfEMems1YnWn3vXgXbuXUVcRoMjE@z>

Signed-off-by: Jon Doron <arilou@gmail.com>
---
 gdbstub.c | 41 +++++++++++++++++++++++++++++++----------
 1 file changed, 31 insertions(+), 10 deletions(-)

diff --git a/gdbstub.c b/gdbstub.c
index daa602edc3..adfe39b3a3 100644
--- a/gdbstub.c
+++ b/gdbstub.c
@@ -1734,6 +1734,29 @@ static void handle_read_mem(GdbCmdContext *gdb_ctx, void *user_ctx)
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
@@ -1745,7 +1768,6 @@ static int gdb_handle_packet(GDBState *s, const char *line_buf)
     uint8_t mem_buf[MAX_PACKET_LENGTH];
     char buf[sizeof(mem_buf) + 1 /* trailing NUL */];
     char thread_id[16];
-    uint8_t *registers;
     target_ulong addr, len;
     const GdbCmdParseEntry *cmd_parser = NULL;
 
@@ -1911,16 +1933,15 @@ static int gdb_handle_packet(GDBState *s, const char *line_buf)
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



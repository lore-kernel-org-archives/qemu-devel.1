Return-Path: <SRS0=3XOk=S2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECB9AC10F11
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2019 19:52:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B051E20674
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2019 19:52:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s0Uu+djy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B051E20674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:46475 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hJNwQ-00067S-0b
	for qemu-devel@archiver.kernel.org; Wed, 24 Apr 2019 15:52:26 -0400
Received: from eggs.gnu.org ([209.51.188.92]:56425)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <arilou@gmail.com>) id 1hJNkE-0003t1-BN
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 15:39:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <arilou@gmail.com>) id 1hJNkD-00049n-C6
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 15:39:50 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:41540)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <arilou@gmail.com>) id 1hJNkD-000496-5y
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 15:39:49 -0400
Received: by mail-wr1-x442.google.com with SMTP id c12so20593494wrt.8
	for <qemu-devel@nongnu.org>; Wed, 24 Apr 2019 12:39:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=92zmbHtmaWdJBn6Gzt10L0qHEe/LVcd35bviZ9obj/o=;
	b=s0Uu+djyqdHS8AKiKTmt3UrxvMp9gUFFcQMav69ug47O/9q+r9/YWpUtrv9g+Tkzos
	Z6sI0qONwegWzOl0oI7j6R63C6yAa4qRC1MUaM9HsKj/xKYrNLW8Di8N0C4Yw8kOTIRQ
	b8FQAQsSxBg0QIci2Z48pfzdnusl7USAwkgObJ6votfbt4nrfmyYO+hse3gk7ZwrU/w/
	Ncaezbb0pAP5H9wBFx5NExXdHAq/Ud891/zKLCU9oA5zXXW6SNfXPcBVKKDaCrL5h+2c
	0I4KfpP/ndJ+FEAW/Lf/2/T/AEA5XOlrMp9queACxHv9QbrcDIpOq6OtVJ/Or4JCzhbw
	kNFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=92zmbHtmaWdJBn6Gzt10L0qHEe/LVcd35bviZ9obj/o=;
	b=r9mKktvIO6JWJFJpSdtomGUvroHESJsfrnMWcAUayD/HLBx12ptD9N4pRLpcUWCHFm
	h9Y0JE50Oyu61oeT5eXO+y/+LsbNlh9dpUsQr+ZyFzWwHSkXwMi84Ud8tATFRbK4YUqa
	/86nx82HZv3mJlVCiDSBDrztk4rlQ9WTriiPvux/r0F48J1lpxfIL2ZHve+19ioDbazB
	7Os+dT/j1ATgSS0IxntuieYbtPDfgtYv98HRvM9WES2LWAlVGAl7lapP+nsNe5aNLCjq
	qpit6GJ0Okkfy1vs9vy2dDRCeMpW6VCEUl6ntsMvUTZJYR20oRCa398C7oJds/svCCY3
	8sJQ==
X-Gm-Message-State: APjAAAWzYG2RY7O1yEUlU2nOUsqbqGnuzK+VVV6U2v0q62xYxbOLQNCe
	1bAc2Dy43W073I77QHB4lE6K+Xkn
X-Google-Smtp-Source: APXvYqyNw/R6DQ/cEAVGu+NmB+nJfk9GSbqnF67LIEP1Ch7UjK29j0F949r9QQ9y5Ntpzplg+HOdNQ==
X-Received: by 2002:adf:eb44:: with SMTP id u4mr9770438wrn.83.1556134787326;
	Wed, 24 Apr 2019 12:39:47 -0700 (PDT)
Received: from linux.local ([31.154.166.148]) by smtp.gmail.com with ESMTPSA id
	n18sm16281372wrt.16.2019.04.24.12.39.45
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Wed, 24 Apr 2019 12:39:46 -0700 (PDT)
From: Jon Doron <arilou@gmail.com>
To: qemu-devel@nongnu.org
Date: Wed, 24 Apr 2019 22:38:51 +0300
Message-Id: <20190424193859.31817-13-arilou@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190424193859.31817-1-arilou@gmail.com>
References: <20190424193859.31817-1-arilou@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::442
Subject: [Qemu-devel] [PATCH v5 13/21] gdbstub: Implement write all
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
Cc: Jon Doron <arilou@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190424193851.cQEgVryqFLto-8EAqgjYWJV9FTfna8M6yGz4ElikGBU@z>

Signed-off-by: Jon Doron <arilou@gmail.com>
---
 gdbstub.c | 41 +++++++++++++++++++++++++++++++----------
 1 file changed, 31 insertions(+), 10 deletions(-)

diff --git a/gdbstub.c b/gdbstub.c
index 5b60c1369c..acf0e75908 100644
--- a/gdbstub.c
+++ b/gdbstub.c
@@ -1735,6 +1735,29 @@ static void handle_read_mem(GdbCmdContext *gdb_ctx, void *user_ctx)
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
@@ -1746,7 +1769,6 @@ static int gdb_handle_packet(GDBState *s, const char *line_buf)
     uint8_t mem_buf[MAX_PACKET_LENGTH];
     char buf[sizeof(mem_buf) + 1 /* trailing NUL */];
     char thread_id[16];
-    uint8_t *registers;
     target_ulong addr, len;
     const GdbCmdParseEntry *cmd_parser = NULL;
 
@@ -1912,16 +1934,15 @@ static int gdb_handle_packet(GDBState *s, const char *line_buf)
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



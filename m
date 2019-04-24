Return-Path: <SRS0=3XOk=S2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D54C3C282CE
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2019 19:00:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9F742206BA
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2019 19:00:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jszLGKHv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F742206BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:45762 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hJN83-0003U7-TS
	for qemu-devel@archiver.kernel.org; Wed, 24 Apr 2019 15:00:23 -0400
Received: from eggs.gnu.org ([209.51.188.92]:45538)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <arilou@gmail.com>) id 1hJN6D-0001z4-8q
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 14:58:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <arilou@gmail.com>) id 1hJMum-0005yM-Jv
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 14:46:42 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:50184)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <arilou@gmail.com>) id 1hJMuk-0005ry-NH
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 14:46:39 -0400
Received: by mail-wm1-x343.google.com with SMTP id 10so5985445wmk.0
	for <qemu-devel@nongnu.org>; Wed, 24 Apr 2019 11:46:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=FJVTikkUicWvAfpJ8BpfdJseXsvuuGT8oDDrdrWscvA=;
	b=jszLGKHvLCyto3lkDXenTAs4LJ+EBQf2jFvhCZxITzEm+Lovq/gr5Nvf8B6iaABl/s
	ie74doJoxJSe4Z8tZcaV5cW1ka/TttKnJLOb67A0CmgRwES9U7Dqlk6Fad8PQaudl/L3
	qcufN7Z+sTKsQvCxaiBHSVvNuyDh4sjzVZKXKA9BFk7QESfX9Pk+2/7IGjNDL4LZn7Lr
	pcISM82AnCi1R6NT78UsBot5tb+nRi8PIQ3Zw3JOEob+p505DM6li7nwRSp1tNUbQtaE
	eaKnQWxAjRjZxqWF6Thb+Mcz0dRaILoEy3VeK0ZLykQ7NBwEI4+D84QFROwvHQv578sU
	DAYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=FJVTikkUicWvAfpJ8BpfdJseXsvuuGT8oDDrdrWscvA=;
	b=mW+q4c2JoOIhlveLWzYByn8V7MUdMDVdBAHMRYzFcvfb8ph415vbhVpbuBWLqPOSl/
	lDgiTWcBzJhQds67fLXRJ8wec3hRaRS8SzpiiMGPZ+umBn1jQ/AlOfm5ibPf+QOrClqu
	B1BQZNNUjWuBWSQTYUXjP3MI3AYrf7tcogD9Qlf4Rex6nQEn1vrc3gHzcdvRDw+6VBum
	Q3PjIZ32SDEtnn8YhpscI26+qSKmr5eSgGRwG3jhf84He8jWDBt1i8GROb6EqbstNCpB
	NIt+t5wlH6826YGBDgUZIcRoowna6TxNs9J50MyUJHcF4329TiIhiV+YTRRlBqKqkNPL
	ft0A==
X-Gm-Message-State: APjAAAVPIpgqU+Iysbr1toSQIEiZrSHtOFQIIAKe9unoIxKoXpc32jY7
	ly3x1T9X0xyA+2/4+GWGINNtUQDg
X-Google-Smtp-Source: APXvYqw+GB+nGObOfWZ8K+qfyOnPjNsf49BhntKeogcwgc4ECb2GhtyRuKel2hUCeddsjYDlhcH+UQ==
X-Received: by 2002:a1c:f311:: with SMTP id q17mr391412wmq.144.1556131593560; 
	Wed, 24 Apr 2019 11:46:33 -0700 (PDT)
Received: from linux.local ([31.154.166.148])
	by smtp.gmail.com with ESMTPSA id h9sm14720106wmb.5.2019.04.24.11.46.31
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Wed, 24 Apr 2019 11:46:32 -0700 (PDT)
From: Jon Doron <arilou@gmail.com>
To: qemu-devel@nongnu.org
Date: Wed, 24 Apr 2019 21:45:53 +0300
Message-Id: <20190424184600.8445-13-arilou@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190424184600.8445-1-arilou@gmail.com>
References: <20190424184600.8445-1-arilou@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::343
Subject: [Qemu-devel] [PATCH v4 13/20] gdbstub: Implement write all
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
Message-ID: <20190424184553.Y9Ab0gREZylMbUP_WO2JuTCB_B_lp_Lnmce64rhnl5E@z>

Signed-off-by: Jon Doron <arilou@gmail.com>
---
 gdbstub.c | 41 +++++++++++++++++++++++++++++++----------
 1 file changed, 31 insertions(+), 10 deletions(-)

diff --git a/gdbstub.c b/gdbstub.c
index af37222034..084c688f75 100644
--- a/gdbstub.c
+++ b/gdbstub.c
@@ -1744,6 +1744,29 @@ static void handle_read_mem(GdbCmdContext *gdb_ctx, void *user_ctx)
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
@@ -1755,7 +1778,6 @@ static int gdb_handle_packet(GDBState *s, const char *line_buf)
     uint8_t mem_buf[MAX_PACKET_LENGTH];
     char buf[sizeof(mem_buf) + 1 /* trailing NUL */];
     char thread_id[16];
-    uint8_t *registers;
     target_ulong addr, len;
 
     trace_gdbstub_io_command(line_buf);
@@ -1920,16 +1942,15 @@ static int gdb_handle_packet(GDBState *s, const char *line_buf)
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
+            static GdbCmdParseEntry write_all_regs_cmd_desc = {
+                .handler = handle_write_all_regs,
+                .cmd = "G",
+                .cmd_startswith = 1,
+                .schema = "s0"
+            };
+            process_string_cmd(s, NULL, line_buf, &write_all_regs_cmd_desc, 1);
         }
-        put_packet(s, "OK");
         break;
     case 'm':
         {
-- 
2.20.1



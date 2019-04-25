Return-Path: <SRS0=VSQP=S3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6281DC43219
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Apr 2019 13:54:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 393A8206BA
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Apr 2019 13:54:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y4WTXY8g"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 393A8206BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:57589 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hJepH-00069i-Fp
	for qemu-devel@archiver.kernel.org; Thu, 25 Apr 2019 09:54:11 -0400
Received: from eggs.gnu.org ([209.51.188.92]:60634)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <arilou@gmail.com>) id 1hJePu-00005E-8B
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 09:27:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <arilou@gmail.com>) id 1hJePs-0001Ns-73
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 09:27:58 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:35566)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <arilou@gmail.com>) id 1hJePq-0001Ix-D2
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 09:27:56 -0400
Received: by mail-wm1-x342.google.com with SMTP id y197so10622632wmd.0
	for <qemu-devel@nongnu.org>; Thu, 25 Apr 2019 06:27:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=92zmbHtmaWdJBn6Gzt10L0qHEe/LVcd35bviZ9obj/o=;
	b=Y4WTXY8gvPrIAUgJYa3I73PnuKUzw1lfd3+XIzPNBOSbyVUV8LgBBHrngxXweDjMD8
	/N2WYY9lkJME2EvLfmRFEVNS+yLmLBovtPLvk3PuOKQ63xvulpynFCVf71UW4KwvxyWc
	1BDw0IWHVVKfs9DPpAP24r7YHkKLne3sFqGIPjDH11yKi3XlkCxvaAIfq4xWRG3hR973
	DkV0T5EYpiUP68o6F+iLQHf0nrOzU1/qjrYxgxzZwcZ3ArJBeKz614B5vdXbGHu6BOLH
	LgNGdEikBYQG86orWGJQwpbNztyVGDvR3osNz6ejueGtUvMh6c+MAXkRM2vt3boQJE+a
	kimQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=92zmbHtmaWdJBn6Gzt10L0qHEe/LVcd35bviZ9obj/o=;
	b=J/1vWBeWVhioZLx71O5tzWoXIXs7Zmf2KqeV0UoDmbsAlB21tlbh0Jc1GBSSerU8Kj
	/mbmOe2pDa2dCzYUlwWf9ahe+JV16mWa7QuqZzcc61HDWbeV2Tg8IQ4+tTtgax3ecGaf
	3x6AZUwmFsn2QrI2tGsRHdN5ddvg4zFAjB6MEvjMQB4hK45QlCTNT5Ga+tLCxpQEkRAi
	RNTnGeG6PKgU0W0sTU/VPBhEKm+wQbMDVjZ82SgZBTmGOkdA7QY+Pa1exqcakeuUpiFa
	6zeIoqAVEsnrho/80RCrjy7qADflEZ1ojSKbdu1DFf7yiaYqSipX8QqqZMx1bLibwblU
	FGOg==
X-Gm-Message-State: APjAAAVrBnHzxKEniXCGkoJTSoqM/MTs9siv2ZadEVk5NRE/NhD9VLRP
	MdJcoeRG+nZ8sW99Tf4nbZuYX4xT
X-Google-Smtp-Source: APXvYqzXDD58IXwhECZcoQFkMBlvfHG1Wc4Xh2Cwpno5cPhYv3IoFOpwgoYtnnR4ezuHm28EBePxZw==
X-Received: by 2002:a7b:cc96:: with SMTP id p22mr3729239wma.17.1556198872314; 
	Thu, 25 Apr 2019 06:27:52 -0700 (PDT)
Received: from localhost.localdomain (bzq-79-178-247-46.red.bezeqint.net.
	[79.178.247.46])
	by smtp.gmail.com with ESMTPSA id y4sm2316540wrt.34.2019.04.25.06.27.49
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Thu, 25 Apr 2019 06:27:49 -0700 (PDT)
From: Jon Doron <arilou@gmail.com>
To: qemu-devel@nongnu.org
Date: Thu, 25 Apr 2019 16:26:28 +0300
Message-Id: <20190425132636.31636-14-arilou@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190425132636.31636-1-arilou@gmail.com>
References: <20190425132636.31636-1-arilou@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::342
Subject: [Qemu-devel] [PATCH v6 13/21] gdbstub: Implement write all
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
Message-ID: <20190425132628.S94B13FBR4ubXDtWbndnoKZ_CMtw-JyWjsyIiY1I7vA@z>

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



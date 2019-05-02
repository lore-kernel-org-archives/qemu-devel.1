Return-Path: <SRS0=nlPZ=TC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E84BC43219
	for <qemu-devel@archiver.kernel.org>; Thu,  2 May 2019 08:32:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E649820873
	for <qemu-devel@archiver.kernel.org>; Thu,  2 May 2019 08:32:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YEK7mRAp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E649820873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:47417 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hM78p-00010J-5V
	for qemu-devel@archiver.kernel.org; Thu, 02 May 2019 04:32:31 -0400
Received: from eggs.gnu.org ([209.51.188.92]:42813)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <arilou@gmail.com>) id 1hM6tg-0003YA-WE
	for qemu-devel@nongnu.org; Thu, 02 May 2019 04:16:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <arilou@gmail.com>) id 1hM6te-00083W-Cz
	for qemu-devel@nongnu.org; Thu, 02 May 2019 04:16:52 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:33068)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <arilou@gmail.com>) id 1hM6ta-0007Ul-C7
	for qemu-devel@nongnu.org; Thu, 02 May 2019 04:16:48 -0400
Received: by mail-wr1-x442.google.com with SMTP id e28so2044715wra.0
	for <qemu-devel@nongnu.org>; Thu, 02 May 2019 01:16:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=brvpFyYDw1Z1o2sLMNd/sMXNZo4TYemLFYCJt79OgBg=;
	b=YEK7mRApxN1jtYp79yHPw85pTuFYiKOvF1Nm8h+vaxhBKpCqb1RbIcRRgV6sQ8GfHq
	W/JrEUH/Ui3wM0fxnUIIbFIruanOJm6KovDEL7MlY9ay3Z5YVchkDmbzJfXCUlid/0BO
	nVJaY1MJifLxxOc1WbssZ89wxQJb4SKTlscHuIpvN0fOLQ00TAWuE/Uhtm1gcTImiKaB
	jVw+TuGZ6XXKPRcB2GzWaYJE3p5ASVl8Dci2QVE10cITgw8lmfMtdLRfnB7ZiGmA3NXN
	elQxyiszMKi0WMyQhnSz+FaKCbRdTBDUCi6scgmNP+hqA5xT95JENTexfKwiLJgUqqbB
	obWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=brvpFyYDw1Z1o2sLMNd/sMXNZo4TYemLFYCJt79OgBg=;
	b=kl3r1JoB78ooZ6xoqaP+naZmDSARibu0W+KWlevkqGBs6Y0eHGjwdZETzzb7dDKdmw
	uryPj+UnhMHT12Hi80pVFb/WOrDvAnSCX2mM9iXBGaLhN8EnF9CIzUxs6rAnAqhXmrFy
	FIDhCT/gjjyuttqr8SEKqlHaSviIP+RcFt4AlgWHQQCrA2pAdHJMvWQN1RO4T2VxR+qw
	cELSr9IvydSSwzcx3K8vY6Um9APaX4H1F3WQinhurQvAW8CTKNykPlY4oMccp8FKn7wJ
	e7q/If97IsZannB8I6p86BBGZDa6IdHNdY3eBXo4GqJ7NV9VC+Z9gX08lFK062+GyArm
	xtWQ==
X-Gm-Message-State: APjAAAXZ/0N/NcENlSZqwz3wXLO9jc74R7FWdq33Qqhj9LO++e0+3rYI
	SxtLYZZ4IrknfD5w8aC+yoRaacVT
X-Google-Smtp-Source: APXvYqzYj1+moPN5Co8qqVcDuJeD0DW/R7cGBK49qXpm1oL2+q4fWB2q+ngy9Plzj2G8G1zuTeiutA==
X-Received: by 2002:a5d:6189:: with SMTP id j9mr1680256wru.176.1556784988002; 
	Thu, 02 May 2019 01:16:28 -0700 (PDT)
Received: from localhost.localdomain ([176.230.64.186])
	by smtp.gmail.com with ESMTPSA id
	d16sm44698367wra.54.2019.05.02.01.16.26
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Thu, 02 May 2019 01:16:27 -0700 (PDT)
From: Jon Doron <arilou@gmail.com>
To: qemu-devel@nongnu.org
Date: Thu,  2 May 2019 11:15:40 +0300
Message-Id: <20190502081554.5521-14-arilou@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190502081554.5521-1-arilou@gmail.com>
References: <20190502081554.5521-1-arilou@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::442
Subject: [Qemu-devel] [PATCH v9 13/27] gdbstub: Implement write all
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
Message-ID: <20190502081540.k0CUh-isw_bZ6fFoqXEDSarthtRWajNGzmfntJE_stA@z>

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



Return-Path: <SRS0=3XOk=S2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35734C10F11
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2019 19:50:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EE9FB20674
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2019 19:50:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dilFgNPE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE9FB20674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:46430 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hJNub-0004WD-9H
	for qemu-devel@archiver.kernel.org; Wed, 24 Apr 2019 15:50:33 -0400
Received: from eggs.gnu.org ([209.51.188.92]:56414)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <arilou@gmail.com>) id 1hJNkC-0003sC-2l
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 15:39:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <arilou@gmail.com>) id 1hJNkA-000463-W7
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 15:39:48 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:50462)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <arilou@gmail.com>) id 1hJNkA-00045F-Oi
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 15:39:46 -0400
Received: by mail-wm1-x344.google.com with SMTP id 10so6169591wmk.0
	for <qemu-devel@nongnu.org>; Wed, 24 Apr 2019 12:39:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=FfGjSJV+pgCWpgIFev/Vk6a07sEAiskpgdyLpP9ye7A=;
	b=dilFgNPEr0jl+OGkp7dqh8lBagQrUcYGvVpZEA22jr4A6zQxvOg7jIhMF8BNp5hAiB
	J8V7aHaBCHYXMmw470mcwW/vSb3dNzd6o4PCMz90rXhNtPAS3u2VHb679hiBGS9GYbWd
	fI5kEUHVaXTbJReIIkWQlJ2lZ0aCa0Y9JEA4jdgiZhaOeQkrzGcdR1Pdk52xQHFZIcG1
	oZmyDdfBdHBwGrDgyD6IN6AIRMbuPw+mAm7I7sT+KyPpjJ54DSg1VEqNqTj8hdMDlK/U
	pZ5d2gSl+rb3X3pZhK2H0UDHGers/uHnBVWykq1dMa8bAQ3UZqbhIUEEi+bqKTmELHpz
	rhYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=FfGjSJV+pgCWpgIFev/Vk6a07sEAiskpgdyLpP9ye7A=;
	b=kk20pz8fV7CAvuSrk+tJnpBXm/Zl8LcxWPSRmwZUiU1AdeipYCfYUkZsZlAtAMKMau
	AGqeaXaLt0fhWNd6sn1dkPihgMN34kSZN4ErSfcMOUa/dBtb1NdWSolfmcBQNaV1rs4P
	2xHMuFELyG4fPBSc4au6NOx8mjuC6l3gK3/uLrw4Rsp5s4ub8zm5YHp+Umhnh9LbGosH
	0kYz7BZv11CgWLtUuiU1yTfzpE+B0Wom6rsxFHRe7vu7xWWH7OdFRg9H28k5gtVS5BUd
	gKfKeZ+37JDpNb2pU2zml4HfYMI2NnNVE8RbwLOnW23z21vt1jGpIh/LjjfI/N/X7O+w
	kcwA==
X-Gm-Message-State: APjAAAXITlO5QH+hfVu7olJIBPFubzzzyi4I96RtsyyKU14MuyuMa6EL
	Khn80Nl8nO0H+BJqVz2nO+PurmwX
X-Google-Smtp-Source: APXvYqx7ORUkcAaUJ19fN55VfDXsDS6FtYGz3fCbgazFNnK8wqLrBHQy72WwrRBM8lskxJW0ZiiXiw==
X-Received: by 2002:a1c:f115:: with SMTP id p21mr543916wmh.93.1556134784996;
	Wed, 24 Apr 2019 12:39:44 -0700 (PDT)
Received: from linux.local ([31.154.166.148]) by smtp.gmail.com with ESMTPSA id
	n18sm16281372wrt.16.2019.04.24.12.39.42
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Wed, 24 Apr 2019 12:39:43 -0700 (PDT)
From: Jon Doron <arilou@gmail.com>
To: qemu-devel@nongnu.org
Date: Wed, 24 Apr 2019 22:38:50 +0300
Message-Id: <20190424193859.31817-12-arilou@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190424193859.31817-1-arilou@gmail.com>
References: <20190424193859.31817-1-arilou@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::344
Subject: [Qemu-devel] [PATCH v5 12/21] gdbstub: Implement read memory (m
 pkt) with new infra
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
Message-ID: <20190424193850.Nd5WRS7Js9oiApr6FLWLKIs8U3p8p6Uhdm1aVmR0g9o@z>

Signed-off-by: Jon Doron <arilou@gmail.com>
---
 gdbstub.c | 48 ++++++++++++++++++++++++++++++++----------------
 1 file changed, 32 insertions(+), 16 deletions(-)

diff --git a/gdbstub.c b/gdbstub.c
index 4522c93fa2..5b60c1369c 100644
--- a/gdbstub.c
+++ b/gdbstub.c
@@ -1711,6 +1711,30 @@ static void handle_write_mem(GdbCmdContext *gdb_ctx, void *user_ctx)
     put_packet(gdb_ctx->s, "OK");
 }
 
+static void handle_read_mem(GdbCmdContext *gdb_ctx, void *user_ctx)
+{
+    if (gdb_ctx->num_params < 2) {
+        put_packet(gdb_ctx->s, "E22");
+        return;
+    }
+
+    /* memtohex() doubles the required space */
+    if (gdb_ctx->params[1].val_ull > MAX_PACKET_LENGTH / 2) {
+        put_packet(gdb_ctx->s, "E22");
+        return;
+    }
+
+    if (target_memory_rw_debug(gdb_ctx->s->g_cpu, gdb_ctx->params[0].val_ull,
+                               gdb_ctx->mem_buf,
+                               gdb_ctx->params[1].val_ull, false)) {
+        put_packet(gdb_ctx->s, "E14");
+        return;
+    }
+
+    memtohex(gdb_ctx->str_buf, gdb_ctx->mem_buf, gdb_ctx->params[1].val_ull);
+    put_packet(gdb_ctx->s, gdb_ctx->str_buf);
+}
+
 static int gdb_handle_packet(GDBState *s, const char *line_buf)
 {
     CPUState *cpu;
@@ -1900,22 +1924,14 @@ static int gdb_handle_packet(GDBState *s, const char *line_buf)
         put_packet(s, "OK");
         break;
     case 'm':
-        addr = strtoull(p, (char **)&p, 16);
-        if (*p == ',')
-            p++;
-        len = strtoull(p, NULL, 16);
-
-        /* memtohex() doubles the required space */
-        if (len > MAX_PACKET_LENGTH / 2) {
-            put_packet (s, "E22");
-            break;
-        }
-
-        if (target_memory_rw_debug(s->g_cpu, addr, mem_buf, len, false) != 0) {
-            put_packet (s, "E14");
-        } else {
-            memtohex(buf, mem_buf, len);
-            put_packet(s, buf);
+        {
+            static const GdbCmdParseEntry read_mem_cmd_desc = {
+                .handler = handle_read_mem,
+                .cmd = "m",
+                .cmd_startswith = 1,
+                .schema = "L,L0"
+            };
+            cmd_parser = &read_mem_cmd_desc;
         }
         break;
     case 'M':
-- 
2.20.1



Return-Path: <SRS0=VSQP=S3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41E90C43219
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Apr 2019 13:56:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1D36020717
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Apr 2019 13:56:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B73Mlehl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D36020717
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:57657 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hJerl-00084l-AE
	for qemu-devel@archiver.kernel.org; Thu, 25 Apr 2019 09:56:45 -0400
Received: from eggs.gnu.org ([209.51.188.92]:60653)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <arilou@gmail.com>) id 1hJePy-00008x-6Z
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 09:28:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <arilou@gmail.com>) id 1hJePw-0001Sf-82
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 09:28:02 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:52191)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <arilou@gmail.com>) id 1hJePv-0001Qh-4V
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 09:28:00 -0400
Received: by mail-wm1-x341.google.com with SMTP id 4so9299713wmf.1
	for <qemu-devel@nongnu.org>; Thu, 25 Apr 2019 06:27:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=3i2BqbPIZu3pJ1q7oaT6KMUZ5ADbICItlHWHixBftQQ=;
	b=B73MlehlyXJdcFaBz8Qj5G60CH3pQObavR3NCyld7o95j2UGUXoU66rntXtWC0VqHa
	ml+QVKLBxSq8XnCc00SZWJuOnU6ON49hQ05eN+UzPjjAokRAkOEFqW3VBlFagrwm9eTe
	p4/Ph89Ioq+xR/zF3LJ1PrG69ntVlxk6ADRdVDhnxOivNIz2Qx7iw5v4Pwl3TLLehqSU
	hnFBZA9Bs/dHitJwzbMozD6XD7b9HAaWHQ//5Q0QJad3vLPm6N6YAZde9Fnuhf8A9RpF
	JjsQjPYmiuevc8DnVI3Q9X7Tl0FN67Kp7MZj0KvzoYdiEuX6282jzq7iJ8rQIqasKBz0
	ZPNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=3i2BqbPIZu3pJ1q7oaT6KMUZ5ADbICItlHWHixBftQQ=;
	b=rBiwGuD0/DNuqO7kH2ZOxiWHt5QgCQa5rG1ChFDTJw8DqWcqSrSZ18Vu3ljYpCrDEL
	InMhT36yS4/3dCQox/ajpyfJcrTIwnitSOlsowZf5n6pA53LDVI6Yyu6vsZbN+eDxnJs
	jOTZdBK0tQ9txoar3mRqoKOlH3hqmMHXjzuXvud1Hh9g6fV3OpYVlT4tbwNL3IHfCJSM
	I3RYGI45zulZFPVG32iDPXJq2lRXnueMfswpWW3nf6ORzEGQoZTTdiZ99NvbB8OvidU4
	f9M0GRZYbC2nvIsdD7eDsm9iSkwboP8nP2i5slJO6WOgpx5X2AKv7RehNWiBlv/Sxt77
	qLCA==
X-Gm-Message-State: APjAAAVFXN7xIznNjU/07MOpDUWoCV9u39W38G9j1D2HYXGhtrkqLad0
	TadKvEs8u0GlvJ3FIia/R0bIpp38
X-Google-Smtp-Source: APXvYqz36xK5R7XhBeH+Go/q++uO99iewu/qxhupHOtZYeGcYxhzuy4IxAu5xCjTO+Iq/Zpf4fAgHg==
X-Received: by 2002:a7b:cb16:: with SMTP id u22mr3582662wmj.60.1556198876841; 
	Thu, 25 Apr 2019 06:27:56 -0700 (PDT)
Received: from localhost.localdomain (bzq-79-178-247-46.red.bezeqint.net.
	[79.178.247.46])
	by smtp.gmail.com with ESMTPSA id y4sm2316540wrt.34.2019.04.25.06.27.52
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Thu, 25 Apr 2019 06:27:54 -0700 (PDT)
From: Jon Doron <arilou@gmail.com>
To: qemu-devel@nongnu.org
Date: Thu, 25 Apr 2019 16:26:29 +0300
Message-Id: <20190425132636.31636-15-arilou@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190425132636.31636-1-arilou@gmail.com>
References: <20190425132636.31636-1-arilou@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::341
Subject: [Qemu-devel] [PATCH v6 14/21] gdbstub: Implement read all registers
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
Cc: Jon Doron <arilou@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190425132629.T8dm7YFdQgoNuMmMUaLyz5_eyVGmsWbECjxTavMXung@z>

Signed-off-by: Jon Doron <arilou@gmail.com>
---
 gdbstub.c | 31 +++++++++++++++++++++++--------
 1 file changed, 23 insertions(+), 8 deletions(-)

diff --git a/gdbstub.c b/gdbstub.c
index acf0e75908..3a7ef5eea6 100644
--- a/gdbstub.c
+++ b/gdbstub.c
@@ -1758,6 +1758,21 @@ static void handle_write_all_regs(GdbCmdContext *gdb_ctx, void *user_ctx)
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
@@ -1765,7 +1780,7 @@ static int gdb_handle_packet(GDBState *s, const char *line_buf)
     CPUClass *cc;
     const char *p;
     uint32_t pid, tid;
-    int ch, reg_size, type, res;
+    int ch, type, res;
     uint8_t mem_buf[MAX_PACKET_LENGTH];
     char buf[sizeof(mem_buf) + 1 /* trailing NUL */];
     char thread_id[16];
@@ -1924,14 +1939,14 @@ static int gdb_handle_packet(GDBState *s, const char *line_buf)
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



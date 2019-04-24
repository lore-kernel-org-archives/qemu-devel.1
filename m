Return-Path: <SRS0=3XOk=S2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C03CFC10F11
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2019 19:06:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 87B3E20835
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2019 19:06:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OAbAEOsw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 87B3E20835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:45872 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hJNEC-0000jE-Mb
	for qemu-devel@archiver.kernel.org; Wed, 24 Apr 2019 15:06:44 -0400
Received: from eggs.gnu.org ([209.51.188.92]:45555)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <arilou@gmail.com>) id 1hJN6D-0001zm-Na
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 14:58:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <arilou@gmail.com>) id 1hJMum-0005yS-KI
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 14:46:42 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:53565)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <arilou@gmail.com>) id 1hJMuk-0005un-Nk
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 14:46:40 -0400
Received: by mail-wm1-x343.google.com with SMTP id 26so99804wmj.3
	for <qemu-devel@nongnu.org>; Wed, 24 Apr 2019 11:46:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=EaCl9SsGwI5+JE82EjyjE4yVFH0TLyDPcizFjjdq7aM=;
	b=OAbAEOswep6xp/h3VnyynC9vrnK0ahklR43DYsHUaR1Pm/oS+mf8no0+mzP7lbDMJ+
	tQ8TalPeq455vviLLLto/EiQifzsdGW4/9KMCFFOhPt7AXMNyVTVhr0m5BuXkdVnNJxQ
	CzsFQl+yi0W2HTjy4H1e1UtGFuBWS4tCXIuqqjfj8U+Tk1YFYI+OWG8efQ0Tb/vtPXcw
	TNjpAl9y1FxDpH3RtEeVZK19MeB3EAFOLtYOGsg4GMMX8K8l6xwZOhZRbnJvnqWSEhYH
	CDNVmhyJLzg91/Mn1I8WNBzvB0r3utqbAlJwB9LDL4gklapRc1eBBwTOmSTyYPIcyVjZ
	kUPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=EaCl9SsGwI5+JE82EjyjE4yVFH0TLyDPcizFjjdq7aM=;
	b=YNaAO6tFGHUmqCRdMSu4vDkmbXQKOUuJ+iN8ThwN7TA8uQhEivCiS8jNs2LQPP4w4W
	ImqiDR0hW4i4H7bDC+bA4WAaH/KuJrJfOCG5fD/rselZfskUTZ92Ch8rIQhzu9/GlJnn
	0rkfLWwqpB4ZMi1598FYl+0updeEP07Ic1+TwfJcSvaWN0OPL95N42QO1/OJSUUaGXZe
	6ZjkXA3X0uaxuarBybD9LDOuRGbK02fyoNdKTj+vI9XN1FCIo6/u8FCXhAEpdl7L50rz
	wb4b+o4VzTgwAiK4M7Cb6CY+0Yf9mJtTw6mE1Ub+cXU+PI87Kr5DxUOAFk5N/GlZQWa0
	w0Ww==
X-Gm-Message-State: APjAAAXVHjGeZLwyBxDdxOoapXoR5tAJ9zRnkQWt86hDjoi4d9F8RKY+
	H3b1xSyPWDNtNG9aE124nuIFDLZO
X-Google-Smtp-Source: APXvYqwazn+AC3jTcKmkZ/Kn1+jM5gukSiRR8RUvoDjWDoGQ84LDkaTvKhcGo5LlvSnbcJuoEpno3A==
X-Received: by 2002:a1c:dc09:: with SMTP id t9mr387351wmg.142.1556131595527;
	Wed, 24 Apr 2019 11:46:35 -0700 (PDT)
Received: from linux.local ([31.154.166.148])
	by smtp.gmail.com with ESMTPSA id h9sm14720106wmb.5.2019.04.24.11.46.33
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Wed, 24 Apr 2019 11:46:34 -0700 (PDT)
From: Jon Doron <arilou@gmail.com>
To: qemu-devel@nongnu.org
Date: Wed, 24 Apr 2019 21:45:54 +0300
Message-Id: <20190424184600.8445-14-arilou@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190424184600.8445-1-arilou@gmail.com>
References: <20190424184600.8445-1-arilou@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::343
Subject: [Qemu-devel] [PATCH v4 14/20] gdbstub: Implement read all registers
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
Message-ID: <20190424184554.ekkEKYC3OQwVcntjdQQiid-Tl2lEBw29P-9RDQC8ef8@z>

Signed-off-by: Jon Doron <arilou@gmail.com>
---
 gdbstub.c | 31 +++++++++++++++++++++++--------
 1 file changed, 23 insertions(+), 8 deletions(-)

diff --git a/gdbstub.c b/gdbstub.c
index 084c688f75..b9ac9401ed 100644
--- a/gdbstub.c
+++ b/gdbstub.c
@@ -1767,6 +1767,21 @@ static void handle_write_all_regs(GdbCmdContext *gdb_ctx, void *user_ctx)
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
@@ -1774,7 +1789,7 @@ static int gdb_handle_packet(GDBState *s, const char *line_buf)
     CPUClass *cc;
     const char *p;
     uint32_t pid, tid;
-    int ch, reg_size, type, res;
+    int ch, type, res;
     uint8_t mem_buf[MAX_PACKET_LENGTH];
     char buf[sizeof(mem_buf) + 1 /* trailing NUL */];
     char thread_id[16];
@@ -1932,14 +1947,14 @@ static int gdb_handle_packet(GDBState *s, const char *line_buf)
         }
         break;
     case 'g':
-        cpu_synchronize_state(s->g_cpu);
-        len = 0;
-        for (addr = 0; addr < s->g_cpu->gdb_num_g_regs; addr++) {
-            reg_size = gdb_read_register(s->g_cpu, mem_buf + len, addr);
-            len += reg_size;
+        {
+            static GdbCmdParseEntry read_all_regs_cmd_desc = {
+                .handler = handle_read_all_regs,
+                .cmd = "g",
+                .cmd_startswith = 1
+            };
+            process_string_cmd(s, NULL, line_buf, &read_all_regs_cmd_desc, 1);
         }
-        memtohex(buf, mem_buf, len);
-        put_packet(s, buf);
         break;
     case 'G':
         {
-- 
2.20.1



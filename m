Return-Path: <SRS0=3XOk=S2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1A73C282CE
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2019 14:56:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8B9B72084F
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2019 14:56:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gF4ls4Hf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B9B72084F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:42746 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hJJ6l-0003KD-3n
	for qemu-devel@archiver.kernel.org; Wed, 24 Apr 2019 10:42:47 -0400
Received: from eggs.gnu.org ([209.51.188.92]:43914)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <arilou@gmail.com>) id 1hJIzK-0004gM-9M
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 10:35:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <arilou@gmail.com>) id 1hJIsP-0000tv-HB
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 10:27:59 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:38788)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <arilou@gmail.com>) id 1hJIsN-0000lo-Bz
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 10:27:55 -0400
Received: by mail-wm1-x342.google.com with SMTP id w15so5350063wmc.3
	for <qemu-devel@nongnu.org>; Wed, 24 Apr 2019 07:27:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=v2qJUM44akSSBaqAJasZXAgKOeZiMtI66+B3Dins8I8=;
	b=gF4ls4Hf8PGsrpOvzxyJFNVWOpO55kSyEsE8wgTCuATo4FaENyhW1lfPCGug9v52St
	Wud6Gc4wSSNmoDnGSqcnOrMM9/vc4Tm0983K0BpYZdRYnwHaGjkMfZcf1iphVD1BupTU
	0FhmG2wzTxaGotjVi6iwkoup/qbw0CNX29QfPhmLkNk44BDRaVaQ2SAgA1WwzUk8TGOe
	jmAnfi8rhaQV6dVCMwue/3nJNn64hA9Yo+UEjYWK7VSyxzMd5WrkAXiErAFiyJw4rlds
	WLAn9N3tsk9yY4S8lIDhHoKkggNEfuf1k5yniESOMKX5JD91Wr3NSNpaHKY/Chy1F+JR
	nWWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=v2qJUM44akSSBaqAJasZXAgKOeZiMtI66+B3Dins8I8=;
	b=kZiSkUK/022g7ztWXUpdheL8z6bQ6xP9MyEpu0OFj4ZbekvGoYdbrGD/50iKl9dHP7
	+ZiUEwGxYhIZhLKA22EqBVbJ3Xb9nblIaSpKfaiNdHiOfA2qR3Ts3lDBX9uGHD4KqZZr
	e8KoXWbda7wH2KiumSqIMEswA4w+nd9scSErB98bPY19KMsHUdm+bfXnlBzpmpuknQfv
	inDL1GgibSkx4hj9a2rylIX5ahfmNxEEslRO96fWK9GM/l5KMY5jRHHnolZ7lCn829rP
	liBK3rxVjtc9tXJG2TULoCysHum459e0VGX3yYdW7Y7akpa/X6Wg6w51ZSKlD3fB23bI
	ODGw==
X-Gm-Message-State: APjAAAXTKK2+cX3gh++K1dGjEuXM4TBmvumbzRXktLwcIk2aIx4snx9K
	n2HhU7maOF/RVbX2C2jV+yIHS225
X-Google-Smtp-Source: APXvYqxgsdvTgjUihbv+YyWUriOyGY/25kk98zJNWGhzbxFs7/+Yge94GkYrRHU81yDQAx3HkBxJdA==
X-Received: by 2002:a05:600c:203:: with SMTP id 3mr6721001wmi.77.1556116069609;
	Wed, 24 Apr 2019 07:27:49 -0700 (PDT)
Received: from linux.local ([31.154.166.148])
	by smtp.gmail.com with ESMTPSA id q7sm5518041wmc.11.2019.04.24.07.27.45
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Wed, 24 Apr 2019 07:27:46 -0700 (PDT)
From: arilou@gmail.com
To: qemu-devel@nongnu.org
Date: Wed, 24 Apr 2019 17:27:06 +0300
Message-Id: <20190424142714.28460-12-arilou@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190424142714.28460-1-arilou@gmail.com>
References: <20190424142714.28460-1-arilou@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::342
Subject: [Qemu-devel] [PATCH v3 12/20] gdbstub: Implement read memory (m
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
Message-ID: <20190424142706.0PkntWdf10BICjgDH0FnWtywytZJO1JAUR3WuS0rSF0@z>

From: Jon Doron <arilou@gmail.com>

Signed-off-by: Jon Doron <arilou@gmail.com>
---
 gdbstub.c | 48 ++++++++++++++++++++++++++++++++----------------
 1 file changed, 32 insertions(+), 16 deletions(-)

diff --git a/gdbstub.c b/gdbstub.c
index a58450ffab..deeb78c341 100644
--- a/gdbstub.c
+++ b/gdbstub.c
@@ -1726,6 +1726,30 @@ static void handle_write_mem(GdbCmdContext *gdb_ctx, void *user_ctx)
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
@@ -1914,22 +1938,14 @@ static int gdb_handle_packet(GDBState *s, const char *line_buf)
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
+            static GdbCmdParseEntry read_mem_cmd_desc = {
+                .handler = handle_read_mem,
+                .cmd = "m",
+                .cmd_startswith = 1,
+                .schema = "L,L0"
+            };
+            process_string_cmd(s, NULL, line_buf, &read_mem_cmd_desc, 1);
         }
         break;
     case 'M':
-- 
2.20.1



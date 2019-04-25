Return-Path: <SRS0=VSQP=S3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1422DC43218
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Apr 2019 13:53:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DFB84206BA
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Apr 2019 13:53:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EQ9x3BX8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DFB84206BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:57577 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hJeor-0005lv-Me
	for qemu-devel@archiver.kernel.org; Thu, 25 Apr 2019 09:53:45 -0400
Received: from eggs.gnu.org ([209.51.188.92]:60425)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <arilou@gmail.com>) id 1hJePe-0008Ev-9A
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 09:27:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <arilou@gmail.com>) id 1hJePc-0000xG-0A
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 09:27:42 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:47050)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <arilou@gmail.com>) id 1hJePa-0000pV-E6
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 09:27:38 -0400
Received: by mail-wr1-x443.google.com with SMTP id t17so30292125wrw.13
	for <qemu-devel@nongnu.org>; Thu, 25 Apr 2019 06:27:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=14VPjA11kd7BNRAewIUYoLzDl7QlL5dAdw5dQ8aqYZo=;
	b=EQ9x3BX8jvDHXr7ahkoFy6GLKpEIu5UVPKOvmNR2HvE+w/kvv/NBR0cY29+qkT20t+
	ovVil29wdl7HpaQPoohQ2NVAqdU889qPKPS/inhOCg8HK+wS8ffCPuXf9XE3kR8fZv20
	1hpp8oB42ShGQoWNk48X1QROYpG5NOkKvf/2PZ9QwNlKky2Khs/af8y99giCVJiQdn1C
	6xZS8XqCmpfLImiJ7hE5UesV4SFg2U83uXnLfLorfMidphqaAKYN70ArFGbMpkYmEGLc
	v+aaGM7LJt9ZZjUMSQrlZ80mtPuv1MLUVUF75J/gEphR5+lw/uFwudJuZG7SG3+3Wq/8
	ztMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=14VPjA11kd7BNRAewIUYoLzDl7QlL5dAdw5dQ8aqYZo=;
	b=XqDmKatIi5EUgHrSwYxXaVkFLSyfBiUuWDv5J7DD6SFTCyB88IX09P8CbepJwryGUF
	Zxf4ivhObwTolwoi2VysFx8EEaJt1dA5EXHTrONo+Bv1N7Y6/BTSOhDFTOJR0ZqXkYMO
	HTJYUf/S5ODA2vsmikjnVQPgXcOWGhqrluru+t/ZxZoNCsL755dTzKfGfHjjvUjKtlGy
	17NiBkIi+vsL/WWzc9lZQry2Sy+wUusAsGTEpX8mnlZCLrseeb9lX2ld7+dea+ZawYoE
	nO4c52TjVLbI4Sbegvbs06sUojHSJzr+iZRqQxMCM4Ze2Owyhyf+mCUKqx+t6eUZV8+w
	Ov6A==
X-Gm-Message-State: APjAAAXuuG6YbfsMsV7FVqvFs1sq9N6Wi0GnSfD3NRSoSO8/ePXFKkYn
	6wvEhh/Jl+HtESVJWpTUB2/Un6Hf
X-Google-Smtp-Source: APXvYqzZ1PYp7F9RnEny29x2lRUz9/RAI5cjv9rjQzqoRQanBIIYPWsLoz/GA5l0i2I9ptiZ1upIQQ==
X-Received: by 2002:a5d:4707:: with SMTP id y7mr9648503wrq.185.1556198852822; 
	Thu, 25 Apr 2019 06:27:32 -0700 (PDT)
Received: from localhost.localdomain (bzq-79-178-247-46.red.bezeqint.net.
	[79.178.247.46])
	by smtp.gmail.com with ESMTPSA id y4sm2316540wrt.34.2019.04.25.06.27.29
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Thu, 25 Apr 2019 06:27:30 -0700 (PDT)
From: Jon Doron <arilou@gmail.com>
To: qemu-devel@nongnu.org
Date: Thu, 25 Apr 2019 16:26:23 +0300
Message-Id: <20190425132636.31636-9-arilou@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190425132636.31636-1-arilou@gmail.com>
References: <20190425132636.31636-1-arilou@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::443
Subject: [Qemu-devel] [PATCH v6 08/21] gdbstub: Implement remove breakpoint
 (z pkt) with new infra
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
Message-ID: <20190425132623.0GzB5K7Cu7Jr0iMhiVmtxb9QvKECM95BECVcOZigLQ8@z>

Signed-off-by: Jon Doron <arilou@gmail.com>
---
 gdbstub.c | 49 ++++++++++++++++++++++++++++++++-----------------
 1 file changed, 32 insertions(+), 17 deletions(-)

diff --git a/gdbstub.c b/gdbstub.c
index 8e0446d305..80f2a92da6 100644
--- a/gdbstub.c
+++ b/gdbstub.c
@@ -1612,6 +1612,29 @@ static void handle_insert_bp(GdbCmdContext *gdb_ctx, void *user_ctx)
     put_packet(gdb_ctx->s, "E22");
 }
 
+static void handle_remove_bp(GdbCmdContext *gdb_ctx, void *user_ctx)
+{
+    int res;
+
+    if (gdb_ctx->num_params < 3) {
+        put_packet(gdb_ctx->s, "E22");
+        return;
+    }
+
+    res = gdb_breakpoint_remove(gdb_ctx->params[1].val_ull,
+                                gdb_ctx->params[2].val_ull,
+                                gdb_ctx->params[0].val_ul);
+    if (res >= 0) {
+        put_packet(gdb_ctx->s, "OK");
+        return;
+    } else if (res == -ENOSYS) {
+        put_packet(gdb_ctx->s, "");
+        return;
+    }
+
+    put_packet(gdb_ctx->s, "E22");
+}
+
 static int gdb_handle_packet(GDBState *s, const char *line_buf)
 {
     CPUState *cpu;
@@ -1878,23 +1901,15 @@ static int gdb_handle_packet(GDBState *s, const char *line_buf)
         }
         break;
     case 'z':
-        type = strtoul(p, (char **)&p, 16);
-        if (*p == ',')
-            p++;
-        addr = strtoull(p, (char **)&p, 16);
-        if (*p == ',')
-            p++;
-        len = strtoull(p, (char **)&p, 16);
-        if (ch == 'Z')
-            res = gdb_breakpoint_insert(addr, len, type);
-        else
-            res = gdb_breakpoint_remove(addr, len, type);
-        if (res >= 0)
-             put_packet(s, "OK");
-        else if (res == -ENOSYS)
-            put_packet(s, "");
-        else
-            put_packet(s, "E22");
+        {
+            static const GdbCmdParseEntry remove_bp_cmd_desc = {
+                .handler = handle_remove_bp,
+                .cmd = "z",
+                .cmd_startswith = 1,
+                .schema = "l?L?L0"
+            };
+            cmd_parser = &remove_bp_cmd_desc;
+        }
         break;
     case 'H':
         {
-- 
2.20.1



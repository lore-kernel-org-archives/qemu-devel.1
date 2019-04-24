Return-Path: <SRS0=3XOk=S2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E31EEC10F11
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2019 19:03:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AE08E206BA
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2019 19:03:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eG981Ae9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE08E206BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:45820 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hJNB9-0006OR-TJ
	for qemu-devel@archiver.kernel.org; Wed, 24 Apr 2019 15:03:35 -0400
Received: from eggs.gnu.org ([209.51.188.92]:45538)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <arilou@gmail.com>) id 1hJN6G-0001z4-CH
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 14:58:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <arilou@gmail.com>) id 1hJMuY-0005en-4M
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 14:46:26 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:43058)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <arilou@gmail.com>) id 1hJMuX-0005eN-Uf
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 14:46:26 -0400
Received: by mail-wr1-x443.google.com with SMTP id a12so3312528wrq.10
	for <qemu-devel@nongnu.org>; Wed, 24 Apr 2019 11:46:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=ElzHT48UxgaC/DzZnZdBwKI4HnEDP1VB6UBmf2Nb+nY=;
	b=eG981Ae9MjuyTR6czz4vCA9oempO/n0um5slZ06XnfMAB6ZpFgO1m3W1sgp1+jpcA5
	FxEbSVXPd3dfcIqhm2UpoACyYCoz4gtE/skqagjNm9Taq2SJK+IYUAKvWcex5iqNY3NG
	U4HPdDabohX/rPLZ1VThUHgUbHZMGAn+0WJQJDYbHgkkbIBwl0RV0wePX+zjSExG3pAq
	Qh8LRJfVJDWNsSWn47fuTNEmdFPBMliVjvMWUFywMQJFgCnivszXfhRq2CgeoUDLqH2n
	WveAfC7vP3pPFj0ug38be8YOhRXV2RYc1N3XBwQS8u+Cz1jUpcmkUNlqtFBoautny6C0
	8Wvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=ElzHT48UxgaC/DzZnZdBwKI4HnEDP1VB6UBmf2Nb+nY=;
	b=iHgRyE48yk53/HLAfJYFN7jnNHikNFm/AdpMcjwbg8ghF/OWvT8CdqQr1kdf5skv5o
	5s1DxWhpJLDpn3rS0EyxW7nZLANmVxD1HioWBVXgbj04GEviexqLEG7bDS+H9EqjgQyb
	UXomM25VPuG1OYd6tlWPWjnjMCyhIJG9P2KLaxc40oGKR6Y/qNKM4d8LZGp0INZ+RcY0
	ImbEFM5f+GF3ZEUQQwqrnUvu2NkyP81LFqhX5Vi9lVH0/SRrzYWo3oOjVBG2jRRI1VMs
	irm0xeBBmY2XHdL5uRe0ZUbw9JYje/jIMaT0i7tM4Hc4xYBuvxiv4QMkZhqKoMXtzgOk
	m9CA==
X-Gm-Message-State: APjAAAVHOtLX9xuEipsF5j07qhg92WCh5KXzAfbZSeY2RJXJN0wthFjH
	fKWAi4C4hVGbWcRCu7JIrjPHKozc
X-Google-Smtp-Source: APXvYqxi3uE8C06oZJyLFgq0RVN4EOJk4AarXQjw6Lp6C9hSawHwC4XNRBcEu3RqEsgTlyInAjn95w==
X-Received: by 2002:adf:eb03:: with SMTP id s3mr12520347wrn.170.1556131584628; 
	Wed, 24 Apr 2019 11:46:24 -0700 (PDT)
Received: from linux.local ([31.154.166.148])
	by smtp.gmail.com with ESMTPSA id h9sm14720106wmb.5.2019.04.24.11.46.22
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Wed, 24 Apr 2019 11:46:23 -0700 (PDT)
From: Jon Doron <arilou@gmail.com>
To: qemu-devel@nongnu.org
Date: Wed, 24 Apr 2019 21:45:48 +0300
Message-Id: <20190424184600.8445-8-arilou@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190424184600.8445-1-arilou@gmail.com>
References: <20190424184600.8445-1-arilou@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::443
Subject: [Qemu-devel] [PATCH v4 08/20] gdbstub: Implement remove breakpoint
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
Message-ID: <20190424184548.wn9H0Qial2AO_ZcHKZVPyIOceDvNFqOuW_YqlqaO-PE@z>

Signed-off-by: Jon Doron <arilou@gmail.com>
---
 gdbstub.c | 49 ++++++++++++++++++++++++++++++++-----------------
 1 file changed, 32 insertions(+), 17 deletions(-)

diff --git a/gdbstub.c b/gdbstub.c
index 03553a1a32..b5d568603c 100644
--- a/gdbstub.c
+++ b/gdbstub.c
@@ -1621,6 +1621,29 @@ static void handle_insert_bp(GdbCmdContext *gdb_ctx, void *user_ctx)
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
@@ -1886,23 +1909,15 @@ static int gdb_handle_packet(GDBState *s, const char *line_buf)
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
+            static GdbCmdParseEntry remove_bp_cmd_desc = {
+                .handler = handle_remove_bp,
+                .cmd = "z",
+                .cmd_startswith = 1,
+                .schema = "l?L?L0"
+            };
+            process_string_cmd(s, NULL, line_buf, &remove_bp_cmd_desc, 1);
+        }
         break;
     case 'H':
         {
-- 
2.20.1



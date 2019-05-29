Return-Path: <SRS0=DspQ=T5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CE74C04AB3
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2019 06:45:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 58FB521670
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2019 06:45:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CK384sZt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 58FB521670
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:48234 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hVsKg-0003L7-GQ
	for qemu-devel@archiver.kernel.org; Wed, 29 May 2019 02:45:06 -0400
Received: from eggs.gnu.org ([209.51.188.92]:45146)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <arilou@gmail.com>) id 1hVsHq-00010w-5t
	for qemu-devel@nongnu.org; Wed, 29 May 2019 02:42:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <arilou@gmail.com>) id 1hVsHp-0000wv-0A
	for qemu-devel@nongnu.org; Wed, 29 May 2019 02:42:10 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:36800)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <arilou@gmail.com>) id 1hVsHo-0000pu-Qq
	for qemu-devel@nongnu.org; Wed, 29 May 2019 02:42:08 -0400
Received: by mail-wm1-x344.google.com with SMTP id v22so691403wml.1
	for <qemu-devel@nongnu.org>; Tue, 28 May 2019 23:42:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=ULsli7t5tLBpSKOtDy0rVTDXfDiFz7yOCX2I2aNFHAE=;
	b=CK384sZtj6L/QtOGzs7I5gHCZED7s6Sz3Dvqq4yeiZN8WhMcsq5SyYDJGBKAyYkgP9
	X2WGQbyEDTABP2iS4lnrE/FlO3xQf1a+uICFuUVQ7zcR50mYU/EIMUAthtuiDeE13d2b
	0O6wjiPS4KUi6cukSRD2bofk/Q+zYItST1fkEbo9yip1ZzaXWPsIM7a8vSyENQojRhRO
	KkpfTpwPjmsD5aBB9O1OxPbC1DU3DIy575/Ojum0motv0dCylbVI1BUQpbeeEj6/ebLU
	AbO643tsN7H5ymFLEcnfKPRT0FGboOyNgcb0LUNhwKzjOAPqiKjFsdiHYKxuXrg3YAf6
	XVYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=ULsli7t5tLBpSKOtDy0rVTDXfDiFz7yOCX2I2aNFHAE=;
	b=eZU1F8TbLyvu8G5dWSqECmMY9Nh0KPxClSb9CEBpi2IMrHo5HKZlqu1J5pjJ8+5kLt
	/fwUIb8bmxogAblMIlFzAwuwwKjQ2ZEOx57fwi0baWVyf5lD6udn1tq78TTQW/Ref+Ny
	3TGnoG8cic58UQx9CynWAhUfZqU5sEezN5OqSAhY2t+a0H1VCdPNPvB/eXXWr1iCnCMN
	qoLvtZAj6B1V34Ac1NBqYD6UDGghvO/2VqSc8quZplN18m78UIVse//BgruF5k7cZRd+
	7j5dSD8C51rTe4WkdBi7vpqaP5Y1koINh2Co4XhEz8et1QtZ60s2InLkf2Tcq4BUb00k
	Exuw==
X-Gm-Message-State: APjAAAUKzY0zG0IRntys2nmUcc5mitI1KtPbebSXM8PvI49HnsjmPbiB
	O5X/xuj0zeHBfAd6uwoEy5B+oWFF
X-Google-Smtp-Source: APXvYqxwfelihn/niAltW+mz7cdxfPpUdgKQQZNM8b1d0txMnehQpXUxp7PAGCXM4sGb+5QOPxqXmg==
X-Received: by 2002:a1c:f610:: with SMTP id w16mr5336644wmc.37.1559112127827; 
	Tue, 28 May 2019 23:42:07 -0700 (PDT)
Received: from linux.local ([31.154.166.148])
	by smtp.gmail.com with ESMTPSA id f2sm6831168wme.12.2019.05.28.23.42.07
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Tue, 28 May 2019 23:42:07 -0700 (PDT)
From: Jon Doron <arilou@gmail.com>
To: qemu-devel@nongnu.org
Date: Wed, 29 May 2019 09:41:35 +0300
Message-Id: <20190529064148.19856-8-arilou@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190529064148.19856-1-arilou@gmail.com>
References: <20190529064148.19856-1-arilou@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::344
Subject: [Qemu-devel] [PATCH v12 07/20] gdbstub: Implement breakpoint
 commands (Z/z pkt) with new infra
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

Signed-off-by: Jon Doron <arilou@gmail.com>
---
 gdbstub.c | 86 +++++++++++++++++++++++++++++++++++++++++++------------
 1 file changed, 67 insertions(+), 19 deletions(-)

diff --git a/gdbstub.c b/gdbstub.c
index db213cf173..572222bfa4 100644
--- a/gdbstub.c
+++ b/gdbstub.c
@@ -950,7 +950,7 @@ static inline int xlat_gdb_type(CPUState *cpu, int gdbtype)
 }
 #endif
 
-static int gdb_breakpoint_insert(target_ulong addr, target_ulong len, int type)
+static int gdb_breakpoint_insert(int type, target_ulong addr, target_ulong len)
 {
     CPUState *cpu;
     int err = 0;
@@ -987,7 +987,7 @@ static int gdb_breakpoint_insert(target_ulong addr, target_ulong len, int type)
     }
 }
 
-static int gdb_breakpoint_remove(target_ulong addr, target_ulong len, int type)
+static int gdb_breakpoint_remove(int type, target_ulong addr, target_ulong len)
 {
     CPUState *cpu;
     int err = 0;
@@ -1605,6 +1605,52 @@ static void handle_set_thread(GdbCmdContext *gdb_ctx, void *user_ctx)
     }
 }
 
+static void handle_insert_bp(GdbCmdContext *gdb_ctx, void *user_ctx)
+{
+    int res;
+
+    if (gdb_ctx->num_params != 3) {
+        put_packet(gdb_ctx->s, "E22");
+        return;
+    }
+
+    res = gdb_breakpoint_insert(gdb_ctx->params[0].val_ul,
+                                gdb_ctx->params[1].val_ull,
+                                gdb_ctx->params[2].val_ull);
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
+static void handle_remove_bp(GdbCmdContext *gdb_ctx, void *user_ctx)
+{
+    int res;
+
+    if (gdb_ctx->num_params != 3) {
+        put_packet(gdb_ctx->s, "E22");
+        return;
+    }
+
+    res = gdb_breakpoint_remove(gdb_ctx->params[0].val_ul,
+                                gdb_ctx->params[1].val_ull,
+                                gdb_ctx->params[2].val_ull);
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
@@ -1860,24 +1906,26 @@ static int gdb_handle_packet(GDBState *s, const char *line_buf)
         put_packet(s, "OK");
         break;
     case 'Z':
+        {
+            static const GdbCmdParseEntry insert_bp_cmd_desc = {
+                .handler = handle_insert_bp,
+                .cmd = "Z",
+                .cmd_startswith = 1,
+                .schema = "l?L?L0"
+            };
+            cmd_parser = &insert_bp_cmd_desc;
+        }
+        break;
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
2.21.0



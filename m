Return-Path: <SRS0=nlPZ=TC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 666D7C43219
	for <qemu-devel@archiver.kernel.org>; Thu,  2 May 2019 07:43:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2CD8F2133F
	for <qemu-devel@archiver.kernel.org>; Thu,  2 May 2019 07:43:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m5E9d2F9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2CD8F2133F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:46722 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hM6NH-0000iy-Ee
	for qemu-devel@archiver.kernel.org; Thu, 02 May 2019 03:43:23 -0400
Received: from eggs.gnu.org ([209.51.188.92]:59784)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <arilou@gmail.com>) id 1hM6A7-0004vx-2u
	for qemu-devel@nongnu.org; Thu, 02 May 2019 03:29:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <arilou@gmail.com>) id 1hM69x-0002rY-Vu
	for qemu-devel@nongnu.org; Thu, 02 May 2019 03:29:40 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:52790)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <arilou@gmail.com>) id 1hM69n-0000QI-4g
	for qemu-devel@nongnu.org; Thu, 02 May 2019 03:29:32 -0400
Received: by mail-wm1-x342.google.com with SMTP id j13so1289280wmh.2
	for <qemu-devel@nongnu.org>; Thu, 02 May 2019 00:27:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=U4fLhEZHxeWF7Ph12MqOmpuk/185Eq0Ogcw/FW+Pwwg=;
	b=m5E9d2F9U4dYVg4+F0pH+UgqWgDvruGtc1VQ2n3bxtlKhHmufugUUBfjB0L3oJmn52
	slZ46/s72SSxP80fOOcU0rMV2e8ACUpIGprCYUCDRL+Cxq3jKvp6IHvixfU9wZmmHN0j
	1Ulx2gHtQdmsuGST8Rc1faMlXHjUPsc4vRUO2BnFN7rg4ycMWvoyIhlH1WNXIEUrIi1b
	0tHlyk1nlNRW7dcj5kOyu1wdBZN4YoAGssgMe9Hi8k8rmnzBjWbO2adoyvI48AjJ00Oy
	pAt06ruO2AfUGB2d7TIB2ZGrZKW2yE7kNAAKcZxsEotqVnmK8pmfECAG6l90d7dpRH/b
	ySuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=U4fLhEZHxeWF7Ph12MqOmpuk/185Eq0Ogcw/FW+Pwwg=;
	b=fDSNPUrOk7gz4XtlP1JlanKIzYyntrwou8H67sf8A2lPFUiS7JWu4tnRADHe9TuGZy
	iPP0td+n6IJWWKrD2uzhXjQ4Ay5EXuNzievKZqbCHsCdPvof3oTCE8FrtbFAZrCSWabH
	Qz0FIexAOS/Cz6rLlZ1WbE7r81zJymOWGIwWMl0hhARVhzz/DiINhgHSrN7xYdnUOhq6
	dyr//Hh3waO7y+U/luRwUBolrU/Qs7TL7lUATYfbaUs7X6tJuHAFj+bY6VYTNtSXcDlq
	YaC2rhZcaMXmJACBxu6hpr2GbNdsaMeDZYgmBKHH/5WddCWgTa0QpD/bOGmgZ0jlAsCJ
	R5TA==
X-Gm-Message-State: APjAAAXBOkGPyRvtVZV1v+xK9lAbdS93MlPESa3KSUmj1fGvHdWAPvt0
	9BO51nEbk1A66ojdX056wvb2skZG
X-Google-Smtp-Source: APXvYqxIRXLLiPe7S/zLl9FEA9jMPku6BOmrkhyGcDzgaAPpbklNMKOVc+N7O7DEvKyDY+fT8eCB8g==
X-Received: by 2002:a7b:c5d6:: with SMTP id n22mr1148797wmk.112.1556782027997; 
	Thu, 02 May 2019 00:27:07 -0700 (PDT)
Received: from localhost.localdomain ([176.230.64.186])
	by smtp.gmail.com with ESMTPSA id z5sm8769289wre.70.2019.05.02.00.27.06
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Thu, 02 May 2019 00:27:07 -0700 (PDT)
From: Jon Doron <arilou@gmail.com>
To: qemu-devel@nongnu.org
Date: Thu,  2 May 2019 10:26:22 +0300
Message-Id: <20190502072641.4667-9-arilou@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190502072641.4667-1-arilou@gmail.com>
References: <20190502072641.4667-1-arilou@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::342
Subject: [Qemu-devel] [PATCH v8 08/27] gdbstub: Implement remove breakpoint
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
Cc: liran.alon@oracle.com, alex.bennee@linaro.org, Jon Doron <arilou@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190502072622.iJL8ERwW7uhOV7YNtEr8iNlo4Xcq33fZjG8xjpE3svU@z>

Signed-off-by: Jon Doron <arilou@gmail.com>
---
 gdbstub.c | 49 ++++++++++++++++++++++++++++++++-----------------
 1 file changed, 32 insertions(+), 17 deletions(-)

diff --git a/gdbstub.c b/gdbstub.c
index 36c7353a22..b42425b24c 100644
--- a/gdbstub.c
+++ b/gdbstub.c
@@ -1611,6 +1611,29 @@ static void handle_insert_bp(GdbCmdContext *gdb_ctx, void *user_ctx)
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
@@ -1877,23 +1900,15 @@ static int gdb_handle_packet(GDBState *s, const char *line_buf)
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



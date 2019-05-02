Return-Path: <SRS0=nlPZ=TC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A09FC43219
	for <qemu-devel@archiver.kernel.org>; Thu,  2 May 2019 07:43:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B0FE220873
	for <qemu-devel@archiver.kernel.org>; Thu,  2 May 2019 07:43:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rNiBXRK/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B0FE220873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:46724 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hM6NV-0000xS-PT
	for qemu-devel@archiver.kernel.org; Thu, 02 May 2019 03:43:37 -0400
Received: from eggs.gnu.org ([209.51.188.92]:59629)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <arilou@gmail.com>) id 1hM69Z-0004SN-Bp
	for qemu-devel@nongnu.org; Thu, 02 May 2019 03:29:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <arilou@gmail.com>) id 1hM69X-0002XJ-7y
	for qemu-devel@nongnu.org; Thu, 02 May 2019 03:29:12 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:37728)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <arilou@gmail.com>) id 1hM69W-0000Kh-N5
	for qemu-devel@nongnu.org; Thu, 02 May 2019 03:29:11 -0400
Received: by mail-wr1-x442.google.com with SMTP id k23so1805725wrd.4
	for <qemu-devel@nongnu.org>; Thu, 02 May 2019 00:27:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=y+n9UknESyjS5ywhVhGmu6RRpXVVQXSmReCo/GVxG50=;
	b=rNiBXRK/JKmMxNge07z+Bz2snfs84Xu5EFlo9W2mo/jzQnBli1lCECI8cwaX1VjAt+
	3w6SIu8wqm0fJZWx3jrox4wh2ChuvkA2gxQ8n5Nc7vDrU+wW4tGAGdXCkyuD6bI96/wB
	3LoCMoYNR3KkoHhnM+9jpg8GC9LWSBKzYEsyz3K+xKRG5uM8DjADvrZcHsOcgI1uT2O0
	siDLS2t9AtJEycA7orHGx9w65eHEm3GTwIVvVVlEQbm3eZsaVKw0/WPlDQYDYHlJewbG
	I18/7/aNzRLEvGEoDOeoo5BXbAyXgneDYOdUVP1ZpMDoUBRHmDIb5obNg0Vao53/9QE/
	avcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=y+n9UknESyjS5ywhVhGmu6RRpXVVQXSmReCo/GVxG50=;
	b=lWHFOqjGlCEGRqIDUQp4+eGuREgza92uSo8g3W1wigv5vKfbGiC8rfBxYOlBdaI5fA
	S+w9L1LvROtsC3qf/fV6tIFbbz1g9hO8YHB8SZCIE4Zu3cxzKpfy4aiROsVcJME/i+51
	LmZMQtxuj7AMo//wGbAnj0tLeGHRMqtUpj3EVZ3dT+xGwgvv9g7mmRSo4okbt6VuDvHk
	UWFIL6TxiW62pbFTr0x/dbQ80t6nmbdGUsNnZJ8ddmVTSxd054fCDDD0YtZYi+zWKsn5
	GAwR3U7rzDyC83fOrXruH7DzpuRhu0Fa2RljFp9g0mdD1/ER1r9QuT9CdNoxrRG2rVYv
	uzrQ==
X-Gm-Message-State: APjAAAVVJBxoX5xy4CRNvXxJQMifqIGCZaPeYcz6f9WkNt4geDHVATzX
	ScWKHaXX+h4BLhFHvVKGrc8P52cv
X-Google-Smtp-Source: APXvYqy0Asze8qTxFPHUXqi46XiJ1cAvqzA0hMpd/dguu9gwzdt4ajcoXMVZLUJmHJU0w/XT/8HsaQ==
X-Received: by 2002:adf:80c3:: with SMTP id 61mr1589717wrl.123.1556782026360; 
	Thu, 02 May 2019 00:27:06 -0700 (PDT)
Received: from localhost.localdomain ([176.230.64.186])
	by smtp.gmail.com with ESMTPSA id z5sm8769289wre.70.2019.05.02.00.27.04
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Thu, 02 May 2019 00:27:05 -0700 (PDT)
From: Jon Doron <arilou@gmail.com>
To: qemu-devel@nongnu.org
Date: Thu,  2 May 2019 10:26:21 +0300
Message-Id: <20190502072641.4667-8-arilou@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190502072641.4667-1-arilou@gmail.com>
References: <20190502072641.4667-1-arilou@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::442
Subject: [Qemu-devel] [PATCH v8 07/27] gdbstub: Implement insert breakpoint
 (Z pkt) with new infra
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
Message-ID: <20190502072621.hka3L_8R8jaTGj37HvG0191E-aL7FIYMvlkVW4DDDAg@z>

Signed-off-by: Jon Doron <arilou@gmail.com>
---
 gdbstub.c | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/gdbstub.c b/gdbstub.c
index 21cdaf4678..36c7353a22 100644
--- a/gdbstub.c
+++ b/gdbstub.c
@@ -1588,6 +1588,29 @@ static void handle_set_thread(GdbCmdContext *gdb_ctx, void *user_ctx)
     }
 }
 
+static void handle_insert_bp(GdbCmdContext *gdb_ctx, void *user_ctx)
+{
+    int res;
+
+    if (gdb_ctx->num_params < 3) {
+        put_packet(gdb_ctx->s, "E22");
+        return;
+    }
+
+    res = gdb_breakpoint_insert(gdb_ctx->params[1].val_ull,
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
@@ -1843,6 +1866,16 @@ static int gdb_handle_packet(GDBState *s, const char *line_buf)
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
         type = strtoul(p, (char **)&p, 16);
         if (*p == ',')
-- 
2.20.1



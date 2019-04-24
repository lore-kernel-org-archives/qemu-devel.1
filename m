Return-Path: <SRS0=3XOk=S2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17970C282CE
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2019 14:59:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D8CB62084F
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2019 14:59:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="foBgZQSX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8CB62084F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:42773 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hJJ9I-0005fL-Km
	for qemu-devel@archiver.kernel.org; Wed, 24 Apr 2019 10:45:24 -0400
Received: from eggs.gnu.org ([209.51.188.92]:43917)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <arilou@gmail.com>) id 1hJIzM-0004gR-7z
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 10:35:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <arilou@gmail.com>) id 1hJIs1-0000Rd-3n
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 10:27:34 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:43416)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <arilou@gmail.com>) id 1hJIs0-0000Ql-Tt
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 10:27:33 -0400
Received: by mail-wr1-x442.google.com with SMTP id a12so2198618wrq.10
	for <qemu-devel@nongnu.org>; Wed, 24 Apr 2019 07:27:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=TfkE6Ar039zvehEi89kG1PU/hrNuG0kcx18XMkvwwEs=;
	b=foBgZQSXyHAPGWNLvw9odtZac0gYsDBsdqAg6HNJtqYFGCDaHyQYShd7Po9NvX6ZGU
	miCJ8Xzj6B+mArSKXaXvupf6aooq36hTHAPg+VgYZOgCbibtN18H3vzCtZp23EnAxi1r
	AeMP4JztslzNN2LQzgCZoylhGIyh7NpHr8/Q729az566SbLs982eFVinAzDLW73uGPwn
	NsB61XbI572t3Xf80mm2+fKn6hiK2/zouH2hQKoyZ0J7MoGun68+fg4l9+Z9VrAJ/Ql2
	ziy3Q6Pl8VWqybOGxNIFnCmjXeaoCYz22cRIB9lgnUDAggKMkxBNdGz9NsptUd5CZ+Do
	dl1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=TfkE6Ar039zvehEi89kG1PU/hrNuG0kcx18XMkvwwEs=;
	b=J691/OxjxyhLfP8my9tVyV/yXu8DX/QHdSoUedCUrtfkuZOAs7dZZ3ViRPCfCCRnBp
	28aFcx0h54yc8sWLLWsDrOz6bDwG2Uiv216wrtmHy4a8lDOMu64XYzd9rdVgr7JYbuvj
	PQtJexTtgSvDuA05qPG9wMxy/WKgVdfT168Alty90L9kTZiTXZ1Hn016BJ6Q7ogHiHP4
	YDBNpOXuJ3eFTxkja9KIiaYhGzuygIa8mfrPhMN/c3td9DouDshOa0gDeHV7bueH+z50
	gXYpWz5i5Fe0XZijOnHGHcwpXvBWCtVgRf2FqrPRpr8Jd4TneUahWcuVOVYjJE5M1+OE
	jxvQ==
X-Gm-Message-State: APjAAAUvAZCHeGPftjbx2H6YBREKT8WWyCHUzECN6LIDHBTaP1J9ybSJ
	yy56BJctOsUSXcIZ74yhXokBCFl0
X-Google-Smtp-Source: APXvYqw2yvZpgvIS91nz/XnAUzYnvKNMTuppXBBzayQs8i17LK5DSGzhg2fY5ZsAgzjG+cb6A1iztA==
X-Received: by 2002:a05:6000:12c7:: with SMTP id
	l7mr20535902wrx.4.1556116051407; 
	Wed, 24 Apr 2019 07:27:31 -0700 (PDT)
Received: from linux.local ([31.154.166.148])
	by smtp.gmail.com with ESMTPSA id q7sm5518041wmc.11.2019.04.24.07.27.29
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Wed, 24 Apr 2019 07:27:30 -0700 (PDT)
From: arilou@gmail.com
To: qemu-devel@nongnu.org
Date: Wed, 24 Apr 2019 17:26:59 +0300
Message-Id: <20190424142714.28460-5-arilou@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190424142714.28460-1-arilou@gmail.com>
References: <20190424142714.28460-1-arilou@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::442
Subject: [Qemu-devel] [PATCH v3 05/20] gdbstub: Implement continue with
 signal (C pkt) with new infra
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
Message-ID: <20190424142659.1ZVgPTPu5nD-xS--xw8TkHC44-6Vktw-vMfZOrC6SiA@z>

From: Jon Doron <arilou@gmail.com>

Signed-off-by: Jon Doron <arilou@gmail.com>
---
 gdbstub.c | 30 +++++++++++++++++++++++++-----
 1 file changed, 25 insertions(+), 5 deletions(-)

diff --git a/gdbstub.c b/gdbstub.c
index a6d5acd6f0..eaa42713ac 100644
--- a/gdbstub.c
+++ b/gdbstub.c
@@ -1548,6 +1548,21 @@ static void handle_continue(GdbCmdContext *gdb_ctx, void *user_ctx)
     gdb_continue(gdb_ctx->s);
 }
 
+static void handle_cont_with_sig(GdbCmdContext *gdb_ctx, void *user_ctx)
+{
+    unsigned long signal = 0;
+
+    if (gdb_ctx->num_params) {
+        signal = gdb_ctx->params[0].val_ul;
+    }
+
+    gdb_ctx->s->signal = gdb_signal_to_target(signal);
+    if (gdb_ctx->s->signal == -1) {
+        gdb_ctx->s->signal = 0;
+    }
+    gdb_continue(gdb_ctx->s);
+}
+
 static int gdb_handle_packet(GDBState *s, const char *line_buf)
 {
     CPUState *cpu;
@@ -1594,11 +1609,16 @@ static int gdb_handle_packet(GDBState *s, const char *line_buf)
         }
         break;
     case 'C':
-        s->signal = gdb_signal_to_target (strtoul(p, (char **)&p, 16));
-        if (s->signal == -1)
-            s->signal = 0;
-        gdb_continue(s);
-        return RS_IDLE;
+        {
+            static GdbCmdParseEntry cont_with_sig_cmd_desc = {
+                .handler = handle_cont_with_sig,
+                .cmd = "C",
+                .cmd_startswith = 1,
+                .schema = "l0"
+            };
+            process_string_cmd(s, NULL, line_buf, &cont_with_sig_cmd_desc, 1);
+        }
+        break;
     case 'v':
         if (strncmp(p, "Cont", 4) == 0) {
             p += 4;
-- 
2.20.1



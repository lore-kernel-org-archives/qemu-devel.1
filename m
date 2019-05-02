Return-Path: <SRS0=nlPZ=TC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82FDDC43219
	for <qemu-devel@archiver.kernel.org>; Thu,  2 May 2019 08:18:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4B16420651
	for <qemu-devel@archiver.kernel.org>; Thu,  2 May 2019 08:18:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fgrUIQ2j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B16420651
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:47194 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hM6vD-0004OH-E5
	for qemu-devel@archiver.kernel.org; Thu, 02 May 2019 04:18:27 -0400
Received: from eggs.gnu.org ([209.51.188.92]:42513)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <arilou@gmail.com>) id 1hM6t9-00039D-PZ
	for qemu-devel@nongnu.org; Thu, 02 May 2019 04:16:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <arilou@gmail.com>) id 1hM6t3-0007Id-Sg
	for qemu-devel@nongnu.org; Thu, 02 May 2019 04:16:17 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:33065)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <arilou@gmail.com>) id 1hM6t3-0007GP-IR
	for qemu-devel@nongnu.org; Thu, 02 May 2019 04:16:13 -0400
Received: by mail-wr1-x442.google.com with SMTP id e28so2043589wra.0
	for <qemu-devel@nongnu.org>; Thu, 02 May 2019 01:16:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=lYm7IhGBrxn52sVAeIC90HrrQ0q55SD5y2VdGObDHgY=;
	b=fgrUIQ2jOXqt4FTBaAvZCMwg+DNK+T8ejvDceyXZd0+G1n7AgUJfeWmcTYaACpkNny
	KIW7B6Kuk7meD7/QbdRrzc0KzKe/bllc/s8O60ZVA4D740MnYUrikWQAU99KYm6fDzCd
	XmaQm+KaFYi/3KR8S0F5op7czSND0Ge2ic1ZmHBq5lnnP1QNEYpGLATyQ0tfm/XWrzf3
	ERUm2FYb8JUPiYEFljYDO/zH/bVo8mXg6WhuLL9CDreU6X0c5J5gXAUE8dDLd2Hmbw8R
	HBErZgrzm7ppCMvulGsDC5EdJXMNKsil6y09AqM/LkJWR6xPw/aGunfQPxSpJlryWLJ3
	8+Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=lYm7IhGBrxn52sVAeIC90HrrQ0q55SD5y2VdGObDHgY=;
	b=IuHICTPES2KicIaaKAS0QfpSkKTNTOLDzTnU6EYZiG7E9FbrX51UfiHp1E6IFC53W5
	gWEXVek+0e1EgeSdSqquovCHMH4hM7iP/RGydXWHen7uPFuuvPUKIj9LQLNamtvhF0Mw
	5PbWgRV5Ri9o/hzDyllZwtgB8Uo5WjHyWN81tLCHM5HehazzUhaLKWvnLSed9C8hHt1Q
	cgQMvEQMye+ApSHEqLjzJoahldI1HYShtLAGttfxwgzY6NXIaFORT0N/NhkNJG14gLg6
	Ioge3n9nirzNfkHrtT4W+DRdYLTTNcrG6qhYlkdn75MG1B9wyu0PPOANAyAfaujAYUcU
	NXxg==
X-Gm-Message-State: APjAAAXyhLGz3lByL7U4j18zDUdsuB4c3l/4sJKLbm0W7ngSD7qxkiK+
	iUdc1YimKy34hYRlE+TFRCtvMqzj
X-Google-Smtp-Source: APXvYqzxHxKTutINtIGOIIj8ytrOEUi/C04Ck1pjkVEtm5U8xlENACvdYP7LnSMuqytVTBy1k2OzpA==
X-Received: by 2002:a5d:4acc:: with SMTP id y12mr1754378wrs.234.1556784970894; 
	Thu, 02 May 2019 01:16:10 -0700 (PDT)
Received: from localhost.localdomain ([176.230.64.186])
	by smtp.gmail.com with ESMTPSA id
	d16sm44698367wra.54.2019.05.02.01.16.08
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Thu, 02 May 2019 01:16:10 -0700 (PDT)
From: Jon Doron <arilou@gmail.com>
To: qemu-devel@nongnu.org
Date: Thu,  2 May 2019 11:15:30 +0300
Message-Id: <20190502081554.5521-4-arilou@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190502081554.5521-1-arilou@gmail.com>
References: <20190502081554.5521-1-arilou@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::442
Subject: [Qemu-devel] [PATCH v9 03/27] gdbstub: Implement thread_alive (T
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
Cc: alex.bennee@linaro.org, Jon Doron <arilou@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190502081530.HuuBxyGyyZce0npoR_KmCZy42MvIXcJkSklzk163l84@z>

Signed-off-by: Jon Doron <arilou@gmail.com>
---
 gdbstub.c | 43 ++++++++++++++++++++++++++++++++-----------
 1 file changed, 32 insertions(+), 11 deletions(-)

diff --git a/gdbstub.c b/gdbstub.c
index 621d689868..c47ef7dd9c 100644
--- a/gdbstub.c
+++ b/gdbstub.c
@@ -1498,6 +1498,30 @@ static void handle_detach(GdbCmdContext *gdb_ctx, void *user_ctx)
     put_packet(s, "OK");
 }
 
+static void handle_thread_alive(GdbCmdContext *gdb_ctx, void *user_ctx)
+{
+    CPUState *cpu;
+
+    if (!gdb_ctx->num_params) {
+        put_packet(gdb_ctx->s, "E22");
+        return;
+    }
+
+    if (gdb_ctx->params[0].thread_id.kind == GDB_READ_THREAD_ERR) {
+        put_packet(gdb_ctx->s, "E22");
+        return;
+    }
+
+    cpu = gdb_get_cpu(gdb_ctx->s, gdb_ctx->params[0].thread_id.pid,
+                      gdb_ctx->params[0].thread_id.tid);
+    if (!cpu) {
+        put_packet(gdb_ctx->s, "E22");
+        return;
+    }
+
+    put_packet(gdb_ctx->s, "OK");
+}
+
 static int gdb_handle_packet(GDBState *s, const char *line_buf)
 {
     CPUState *cpu;
@@ -1798,17 +1822,14 @@ static int gdb_handle_packet(GDBState *s, const char *line_buf)
         }
         break;
     case 'T':
-        thread_kind = read_thread_id(p, &p, &pid, &tid);
-        if (thread_kind == GDB_READ_THREAD_ERR) {
-            put_packet(s, "E22");
-            break;
-        }
-        cpu = gdb_get_cpu(s, pid, tid);
-
-        if (cpu != NULL) {
-            put_packet(s, "OK");
-        } else {
-            put_packet(s, "E22");
+        {
+            static const GdbCmdParseEntry thread_alive_cmd_desc = {
+                .handler = handle_thread_alive,
+                .cmd = "T",
+                .cmd_startswith = 1,
+                .schema = "t0"
+            };
+            cmd_parser = &thread_alive_cmd_desc;
         }
         break;
     case 'q':
-- 
2.20.1



Return-Path: <SRS0=nlPZ=TC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DB04C43219
	for <qemu-devel@archiver.kernel.org>; Thu,  2 May 2019 07:30:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 16A232081C
	for <qemu-devel@archiver.kernel.org>; Thu,  2 May 2019 07:30:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j2H5OfT5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 16A232081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:46510 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hM6AT-0004sM-9C
	for qemu-devel@archiver.kernel.org; Thu, 02 May 2019 03:30:09 -0400
Received: from eggs.gnu.org ([209.51.188.92]:59429)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <arilou@gmail.com>) id 1hM68q-0003q5-Uy
	for qemu-devel@nongnu.org; Thu, 02 May 2019 03:28:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <arilou@gmail.com>) id 1hM68m-0001jW-8S
	for qemu-devel@nongnu.org; Thu, 02 May 2019 03:28:27 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:42671)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <arilou@gmail.com>) id 1hM68j-0008Ux-Fi
	for qemu-devel@nongnu.org; Thu, 02 May 2019 03:28:22 -0400
Received: by mail-wr1-x442.google.com with SMTP id l2so1782364wrb.9
	for <qemu-devel@nongnu.org>; Thu, 02 May 2019 00:26:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=lYm7IhGBrxn52sVAeIC90HrrQ0q55SD5y2VdGObDHgY=;
	b=j2H5OfT5EN+cF9uHqNDHcFcN3+vD2wMCdsbE5xhIBscH0XWolZT2pBW9CtGFtsNBLS
	x8gMxteIm84u5K5SImBzHQzbmjNC3aLrZia1Cd5lStvizJ62oACK9rc1JDf6fGe5mVNf
	+Q6aAH1GK5w3Updc1XmXYLcbfinHjUXaniehWmYUQcD+BBS7rEDFlR/utlgCb1ZaUSBn
	0DjTG87dB9DNyoGYmTwJun6Y30pz8jWXGz78kKySuCa8DUSHGeapEbAjLOI0Nj/F7lYQ
	FXXUVhm4r0P5sYVvpTnGVKCtHUagG4Oqvm++RPxr3dx8/wH4rokXo/H5etWNbNca5UZz
	qVtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=lYm7IhGBrxn52sVAeIC90HrrQ0q55SD5y2VdGObDHgY=;
	b=mvYpvud6b9+g5uthvEiVSEyiX1fBwbJKwBlyNlbY2RvPdia+UGsrQ06CI72/0p/FR+
	3aawRpvhp7kZoTg99dV53WEZwqLAbaFQJR5QcriRT75RDxsoiW1qkxF56gkppJCRUR+E
	0eXMqUqTtUErjhPM78kQML2eqUnUkMjX5WBCqLHSXvDo7WizImWT1inUjoH9BBpfp7Lp
	ECtFZay2HIxfpDKbSv3+4qwzJogNmRAX4OVrTT0EAtIgc0KTZYIcPgs6g8UceKRzg0+b
	Kp6yeaDl95TSOeda3ENScVuOiVNOd0ORKKZzlVFWhikD2IOI8N0nRiTewoctohzgomVB
	jgRg==
X-Gm-Message-State: APjAAAVUPKKCjq7KXNzOhuZwpf0TBY+1hMvDYMjIFh9qp/UJ21kTOUMW
	CKVMo8T+37gcg/UGT63Vz8UIxkSV
X-Google-Smtp-Source: APXvYqz4eMZgXAvm8sksSyfgy2ueWBXsyRhv9Lb6AffXH1ic4xnTvFfG7nDDxwo2BQxkgIXDY6aNhA==
X-Received: by 2002:a5d:6189:: with SMTP id j9mr1501363wru.176.1556782017916; 
	Thu, 02 May 2019 00:26:57 -0700 (PDT)
Received: from localhost.localdomain ([176.230.64.186])
	by smtp.gmail.com with ESMTPSA id z5sm8769289wre.70.2019.05.02.00.26.56
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Thu, 02 May 2019 00:26:57 -0700 (PDT)
From: Jon Doron <arilou@gmail.com>
To: qemu-devel@nongnu.org
Date: Thu,  2 May 2019 10:26:17 +0300
Message-Id: <20190502072641.4667-4-arilou@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190502072641.4667-1-arilou@gmail.com>
References: <20190502072641.4667-1-arilou@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::442
Subject: [Qemu-devel] [PATCH v8 03/27] gdbstub: Implement thread_alive (T
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
Cc: liran.alon@oracle.com, alex.bennee@linaro.org, Jon Doron <arilou@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190502072617.UMA5Pv6Y70mTbOKTOtnyWkAMTE66OikhysMYu70WF4c@z>

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



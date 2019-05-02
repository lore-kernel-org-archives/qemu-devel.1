Return-Path: <SRS0=nlPZ=TC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB6CBC43219
	for <qemu-devel@archiver.kernel.org>; Thu,  2 May 2019 07:50:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A166020873
	for <qemu-devel@archiver.kernel.org>; Thu,  2 May 2019 07:50:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WL9fiPMG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A166020873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:46807 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hM6Tx-0006ST-U6
	for qemu-devel@archiver.kernel.org; Thu, 02 May 2019 03:50:17 -0400
Received: from eggs.gnu.org ([209.51.188.92]:59923)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <arilou@gmail.com>) id 1hM6AS-0005FM-D7
	for qemu-devel@nongnu.org; Thu, 02 May 2019 03:30:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <arilou@gmail.com>) id 1hM6AO-0003VD-MA
	for qemu-devel@nongnu.org; Thu, 02 May 2019 03:30:06 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:51312)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <arilou@gmail.com>) id 1hM6AL-0008Vy-Vs
	for qemu-devel@nongnu.org; Thu, 02 May 2019 03:30:02 -0400
Received: by mail-wm1-x343.google.com with SMTP id t76so1284464wmt.1
	for <qemu-devel@nongnu.org>; Thu, 02 May 2019 00:27:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=9IF4rsqYBB5CcGAeM/Zis8CV+HM8l1BP4iU1qHaXB5E=;
	b=WL9fiPMGBCF1NmRGm9kQzCB/NU7xF5Kj0HB7VgceGV3g6g4aMysoIOMOh9gDHU8/8H
	x4OreLILKjVz9iIOqpF2cbJLbOWpO+4pQwP8oetj7809N2pofhlJfvDcTv0dX0jhEZ3O
	YX0hIZ+GOMHR/W+e0UgTf/wsn5cHHAKlc9MQF3dw3zpqz2Y+/JIf2o2q+LiDUCsmh87X
	MnEvzybxP0xqoVqmsYRiSGnEpEQk+hTTZ4etatxvHbZ7z5GQT3I7GZj4Db4u0G77yEWQ
	RoQbVRchlZXW4hjzbWaP00o6s3HINKrUUivSE5zbU4jswl1R8j/fqY1U1nBmULAw/FUq
	yL9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=9IF4rsqYBB5CcGAeM/Zis8CV+HM8l1BP4iU1qHaXB5E=;
	b=j74yRedA36eXfrI/kNbT+QRkSM+GNhNJ0Q41tCddP4DoMkB6JD7YNiWs4B7lKJ8YvC
	W2O3DVuat4Bo9HLQlGPPFrmm0AN8WIba+0heNlSe7EFqi0DBaopJpOTnsx+jAFKpzzeH
	W6l0u2gn3kW9xdhqz439l/fM6N6/bihK3I6+czuLb179vs7egpwbL4WlrFhcSWfn/Arq
	ONKlB6qcuWB4uoIAAcD1wwp/ttZK0LnRMedMm7uKhqMHUlFjLXxv2kwRn2HqkM6syouy
	Q730JtJH9z/i6YpaqE9FZS1+jt8r4pPEzjr/GpsoSbAL6F5vRSh/vzmL8E5LP1Av0zaF
	5jVQ==
X-Gm-Message-State: APjAAAW9Qq38KY0EzW09cXGgUmqqRzHVvLEHhvalxJhsKUx7LTCS2BAM
	Gn4OK9qgfzzgLYMjX8GMEtQbzFTc
X-Google-Smtp-Source: APXvYqyBgmhYwBJitqIi2a4xYtc5FR5p1yOrW6H2Y8HsxrJMGOpo3mxGwKrm3YXZ4Ovr6RGNa3imHA==
X-Received: by 2002:a1c:3d6:: with SMTP id 205mr1264221wmd.66.1556782019896;
	Thu, 02 May 2019 00:26:59 -0700 (PDT)
Received: from localhost.localdomain ([176.230.64.186])
	by smtp.gmail.com with ESMTPSA id z5sm8769289wre.70.2019.05.02.00.26.57
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Thu, 02 May 2019 00:26:59 -0700 (PDT)
From: Jon Doron <arilou@gmail.com>
To: qemu-devel@nongnu.org
Date: Thu,  2 May 2019 10:26:18 +0300
Message-Id: <20190502072641.4667-5-arilou@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190502072641.4667-1-arilou@gmail.com>
References: <20190502072641.4667-1-arilou@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::343
Subject: [Qemu-devel] [PATCH v8 04/27] gdbstub: Implement continue (c pkt)
 with new infra
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
Message-ID: <20190502072618.KaxbjIQiVBg9RgrDA9X2NE04BwEf96QBj6mlwE7-04g@z>

Signed-off-by: Jon Doron <arilou@gmail.com>
---
 gdbstub.c | 25 +++++++++++++++++++------
 1 file changed, 19 insertions(+), 6 deletions(-)

diff --git a/gdbstub.c b/gdbstub.c
index c47ef7dd9c..89f1ab6524 100644
--- a/gdbstub.c
+++ b/gdbstub.c
@@ -1522,6 +1522,16 @@ static void handle_thread_alive(GdbCmdContext *gdb_ctx, void *user_ctx)
     put_packet(gdb_ctx->s, "OK");
 }
 
+static void handle_continue(GdbCmdContext *gdb_ctx, void *user_ctx)
+{
+    if (gdb_ctx->num_params) {
+        gdb_set_cpu_pc(gdb_ctx->s, gdb_ctx->params[0].val_ull);
+    }
+
+    gdb_ctx->s->signal = 0;
+    gdb_continue(gdb_ctx->s);
+}
+
 static int gdb_handle_packet(GDBState *s, const char *line_buf)
 {
     CPUState *cpu;
@@ -1558,13 +1568,16 @@ static int gdb_handle_packet(GDBState *s, const char *line_buf)
         gdb_breakpoint_remove_all();
         break;
     case 'c':
-        if (*p != '\0') {
-            addr = strtoull(p, (char **)&p, 16);
-            gdb_set_cpu_pc(s, addr);
+        {
+            static const GdbCmdParseEntry continue_cmd_desc = {
+                .handler = handle_continue,
+                .cmd = "c",
+                .cmd_startswith = 1,
+                .schema = "L0"
+            };
+            cmd_parser = &continue_cmd_desc;
         }
-        s->signal = 0;
-        gdb_continue(s);
-        return RS_IDLE;
+        break;
     case 'C':
         s->signal = gdb_signal_to_target (strtoul(p, (char **)&p, 16));
         if (s->signal == -1)
-- 
2.20.1



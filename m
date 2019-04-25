Return-Path: <SRS0=VSQP=S3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A4F5C43219
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Apr 2019 14:01:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 07BF2206BA
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Apr 2019 14:01:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lAZItkvB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 07BF2206BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:57918 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hJewg-0003yq-7F
	for qemu-devel@archiver.kernel.org; Thu, 25 Apr 2019 10:01:50 -0400
Received: from eggs.gnu.org ([209.51.188.92]:60699)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <arilou@gmail.com>) id 1hJeQ6-0000EG-Ex
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 09:28:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <arilou@gmail.com>) id 1hJeQ5-0001og-LJ
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 09:28:10 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:39578)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <arilou@gmail.com>) id 1hJeQ5-0001ln-Et
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 09:28:09 -0400
Received: by mail-wm1-x342.google.com with SMTP id n25so10602140wmk.4
	for <qemu-devel@nongnu.org>; Thu, 25 Apr 2019 06:28:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=L0b6ekwQ+2V0lpxiU3U4YMDKi4QNx+8EvSzJuNBfha8=;
	b=lAZItkvBwUDzADEYBIM0LD0VXSdPc27TXEQdB+TsWijWJMAKVB94dQXnw7Fqa8FNBy
	zG8iHbsmpCxsfyBy0q7srAA/QpV6sHplZIEJX1rGj/AqjOHnYSOFEa/upp9h66R5zZh9
	cCRLEA1YTgrP/GST63qNFyd8CFwJH7KVjqfqMCOhjNEb63b++hQNdGOOIJdvTL3Q9EcC
	haYVvVazGGdAa3yMwqcYV/3AWGhe5wmwgo3YVWaMfJsqDqSg9+5otOL1C4XOX7c2N3Ga
	giLFpHoiWR6U7SsxAS8kikcTkxEAllGjsraDrmafa6eEVI5H7i1n7mkiKVCT3RZMXUDw
	u9Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=L0b6ekwQ+2V0lpxiU3U4YMDKi4QNx+8EvSzJuNBfha8=;
	b=M86oPHkRYe6OgVmK89wNZE5EDPdTpvjpNa+0FHU5pazelmQwGURIDYG/V6B+cdewu8
	fFKFnDL2Gh/o4JGWF1qzWm73x7xBL7BhTolKLITdFhrDyfV4evGiZeSu6ukjVKn2JAhr
	6Rd3nqZf2BQTqazcsGcPhI8E/gv2qXajQWkBSOEBhOwGCLo7xtO9AJXXIIJlkkyXPguV
	RDsTjHwf2ldQ0Ftm9xZXRhjl4/nsC1lcTd/OcH0QBvHoWtElztGdF7PJXu939HU6T42R
	N4DfXmUEvma8SbwgOPoRFil+ptUJoLgzp3a7dqhLiSaps0Vp7nBz2nRurD0xPMFMM2yl
	HhFQ==
X-Gm-Message-State: APjAAAWqHPfcWTxcvl2c685ZoaT1mmqlvLpGuIGxqrJ4OKdz0YZp+VOL
	kXDnd/dLbhFVxbU8u84gTZ+fyNTq
X-Google-Smtp-Source: APXvYqzThWOtFlFpsk5ipejYzlW8N2CD3582XXpON+/+Dcsyfr/dT/4XH9lFSYbZWswj7fguVubznQ==
X-Received: by 2002:a7b:cc96:: with SMTP id p22mr3730153wma.17.1556198887241; 
	Thu, 25 Apr 2019 06:28:07 -0700 (PDT)
Received: from localhost.localdomain (bzq-79-178-247-46.red.bezeqint.net.
	[79.178.247.46])
	by smtp.gmail.com with ESMTPSA id y4sm2316540wrt.34.2019.04.25.06.28.02
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Thu, 25 Apr 2019 06:28:04 -0700 (PDT)
From: Jon Doron <arilou@gmail.com>
To: qemu-devel@nongnu.org
Date: Thu, 25 Apr 2019 16:26:31 +0300
Message-Id: <20190425132636.31636-17-arilou@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190425132636.31636-1-arilou@gmail.com>
References: <20190425132636.31636-1-arilou@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::342
Subject: [Qemu-devel] [PATCH v6 16/21] gdbstub: Implement step (s pkt) with
 new infra
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
Message-ID: <20190425132631.45WF83I0YMvP6ou6CfRsyU9Ix4ky70JqbnBqiRm_7G4@z>

Signed-off-by: Jon Doron <arilou@gmail.com>
---
 gdbstub.c | 25 +++++++++++++++++++------
 1 file changed, 19 insertions(+), 6 deletions(-)

diff --git a/gdbstub.c b/gdbstub.c
index 18949120be..809503c20a 100644
--- a/gdbstub.c
+++ b/gdbstub.c
@@ -1806,6 +1806,16 @@ static void handle_file_io(GdbCmdContext *gdb_ctx, void *user_ctx)
     gdb_continue(gdb_ctx->s);
 }
 
+static void handle_step(GdbCmdContext *gdb_ctx, void *user_ctx)
+{
+    if (gdb_ctx->num_params) {
+        gdb_set_cpu_pc(gdb_ctx->s, (target_ulong)gdb_ctx->params[0].val_ull);
+    }
+
+    cpu_single_step(gdb_ctx->s->c_cpu, sstep_flags);
+    gdb_continue(gdb_ctx->s);
+}
+
 static int gdb_handle_packet(GDBState *s, const char *line_buf)
 {
     CPUState *cpu;
@@ -1938,13 +1948,16 @@ static int gdb_handle_packet(GDBState *s, const char *line_buf)
         }
         break;
     case 's':
-        if (*p != '\0') {
-            addr = strtoull(p, (char **)&p, 16);
-            gdb_set_cpu_pc(s, addr);
+        {
+            static const GdbCmdParseEntry step_cmd_desc = {
+                .handler = handle_step,
+                .cmd = "s",
+                .cmd_startswith = 1,
+                .schema = "L0"
+            };
+            cmd_parser = &step_cmd_desc;
         }
-        cpu_single_step(s->c_cpu, sstep_flags);
-        gdb_continue(s);
-        return RS_IDLE;
+        break;
     case 'F':
         {
             static const GdbCmdParseEntry file_io_cmd_desc = {
-- 
2.20.1



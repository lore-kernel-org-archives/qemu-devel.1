Return-Path: <SRS0=3XOk=S2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D996EC10F11
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2019 19:03:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A18F6206BA
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2019 19:03:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nADDBX/2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A18F6206BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:45818 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hJNB7-0006MD-Rg
	for qemu-devel@archiver.kernel.org; Wed, 24 Apr 2019 15:03:33 -0400
Received: from eggs.gnu.org ([209.51.188.92]:45538)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <arilou@gmail.com>) id 1hJN6C-0001z4-Br
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 14:58:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <arilou@gmail.com>) id 1hJMuo-00060C-PZ
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 14:46:43 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:53043)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <arilou@gmail.com>) id 1hJMuo-0005y6-Ff
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 14:46:42 -0400
Received: by mail-wm1-x342.google.com with SMTP id j13so5983140wmh.2
	for <qemu-devel@nongnu.org>; Wed, 24 Apr 2019 11:46:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=Elov4xAnJGmngtlyMgW02/nKGr/yYVvmnCqDsLN4Wi0=;
	b=nADDBX/22khSfEbKsFyizO0PysBKg/goXoMD5hkwG0p/vIMG5mEEM3gR2Qel2qTvvk
	pnvFTevAtV0w1l60P84Int0gXJFLFalLD8d0EnipGmeZUGfOvge6M6x3o1OqcWg0PfhN
	aft2AkxMdDspbxSbLgqMWzgik3XDM8f3LFAoxPPDXTdOxzyVzjvDCGLD8RYXJK5g8BvV
	dNtioToflip11I16rqQ/uxRlXOdZh6l/JKkH56KDlWANRPtqHoWerQYJgpuEFRMMtUo+
	CoonoDvnPAaOGpYi5nMO8FqowSLH7bRWXemf29e8/POegwFDqcdeguxceDZcsVFWXv61
	w8gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=Elov4xAnJGmngtlyMgW02/nKGr/yYVvmnCqDsLN4Wi0=;
	b=SQH1S2bS17Yo+j8RENbXj7pQnmu/FkeIU0HGMfdeH1UUefCi2100SXmqhC+hk5g+SS
	iB/u79DvVr+BBAqtV4F6n58CTSNhw/kib+TG72IL68ooByXwP3GBWRw5/YMpne2VmcOJ
	4F1jaa9FQlhAu1LcmqHPVVgSc8ptg4URx7kSM8TwYRWv3CbAGHjLemwMcEeAvEm0oED7
	3TPICplQSyVS/MzicUUuLWeKLFGy+RaJ3V0cTNvoPxsV/JVps9jkpek+MmjQdyIHC+22
	Uidd81BLt6Aq/ghRIsAFj9FurHRQ/TQjYyrsRqrHbJeeRFzdUdlyTGDFq5Oz7Dsvpx5y
	4hjw==
X-Gm-Message-State: APjAAAWw/QRwM0FI23hmZOp272Aar3IQvE0VC0sN6Lo4kV6Jxb1iG8J6
	rZpuU0+ZwXUx6ziPSCgS6dUZPBdV
X-Google-Smtp-Source: APXvYqxM14Na4byrA5TTbh9r3QY9DEggUEvynjuE6YIKtWnMlyqnGOZfvwWWYp23DuxuFuSAib8Nmw==
X-Received: by 2002:a1c:2109:: with SMTP id h9mr404872wmh.68.1556131599463;
	Wed, 24 Apr 2019 11:46:39 -0700 (PDT)
Received: from linux.local ([31.154.166.148])
	by smtp.gmail.com with ESMTPSA id h9sm14720106wmb.5.2019.04.24.11.46.37
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Wed, 24 Apr 2019 11:46:38 -0700 (PDT)
From: Jon Doron <arilou@gmail.com>
To: qemu-devel@nongnu.org
Date: Wed, 24 Apr 2019 21:45:56 +0300
Message-Id: <20190424184600.8445-16-arilou@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190424184600.8445-1-arilou@gmail.com>
References: <20190424184600.8445-1-arilou@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::342
Subject: [Qemu-devel] [PATCH v4 16/20] gdbstub: Implement step (s pkt) with
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
Message-ID: <20190424184556.sj301u7c53Voi3g8QdF8BN_6MIVZgtSJ1HJI4raOPSo@z>

Signed-off-by: Jon Doron <arilou@gmail.com>
---
 gdbstub.c | 25 +++++++++++++++++++------
 1 file changed, 19 insertions(+), 6 deletions(-)

diff --git a/gdbstub.c b/gdbstub.c
index 772bcd2e1f..265a6e3aeb 100644
--- a/gdbstub.c
+++ b/gdbstub.c
@@ -1815,6 +1815,16 @@ static void handle_file_io(GdbCmdContext *gdb_ctx, void *user_ctx)
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
@@ -1946,13 +1956,16 @@ static int gdb_handle_packet(GDBState *s, const char *line_buf)
         }
         break;
     case 's':
-        if (*p != '\0') {
-            addr = strtoull(p, (char **)&p, 16);
-            gdb_set_cpu_pc(s, addr);
+        {
+            static GdbCmdParseEntry step_cmd_desc = {
+                .handler = handle_step,
+                .cmd = "s",
+                .cmd_startswith = 1,
+                .schema = "L0"
+            };
+            process_string_cmd(s, NULL, line_buf, &step_cmd_desc, 1);
         }
-        cpu_single_step(s->c_cpu, sstep_flags);
-        gdb_continue(s);
-        return RS_IDLE;
+        break;
     case 'F':
         {
             static GdbCmdParseEntry file_io_cmd_desc = {
-- 
2.20.1



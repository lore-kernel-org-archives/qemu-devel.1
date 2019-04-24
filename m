Return-Path: <SRS0=3XOk=S2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3D0CC10F11
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2019 19:51:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BE74920674
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2019 19:51:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OdCzmCW2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE74920674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:46469 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hJNvm-0005XC-S8
	for qemu-devel@archiver.kernel.org; Wed, 24 Apr 2019 15:51:46 -0400
Received: from eggs.gnu.org ([209.51.188.92]:56460)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <arilou@gmail.com>) id 1hJNkL-0003zs-VM
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 15:39:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <arilou@gmail.com>) id 1hJNkL-0004F8-28
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 15:39:57 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:39653)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <arilou@gmail.com>) id 1hJNkK-0004EV-Rs
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 15:39:56 -0400
Received: by mail-wr1-x443.google.com with SMTP id a9so9189140wrp.6
	for <qemu-devel@nongnu.org>; Wed, 24 Apr 2019 12:39:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=L0b6ekwQ+2V0lpxiU3U4YMDKi4QNx+8EvSzJuNBfha8=;
	b=OdCzmCW2qJ0fnNoXOMUg/JasfKGaNq2Zm+6qKecWJ5gj7datEFwCatflmW+GzYEXYI
	8KDTEjzHXCon/QngQgmKRZ85f90LdmfLlkr/FXTIDE0SnWdMaY13d1qGSYA0qq13iHNo
	I/gxrP2o/O0jGculu5dv1F5zOS6ytnOmHQtXCTMRGSMz/sk/YMl8t5jNZ/5GCdSuC64b
	gohHFQg5yE0dayciO3aGqpOn9f+4+MjGHNn64AHTXrfUEHtqVWIPuXVXwse21ZkkTLfc
	WJRjmZ8HsHawikbkk2+D8oIUtIztxqdylMFFLJjk9Fsn4T4TWtyzMYlJYGOMVc3WcWAa
	2c/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=L0b6ekwQ+2V0lpxiU3U4YMDKi4QNx+8EvSzJuNBfha8=;
	b=AdMqCSJhOgA3FzUr35px1Iyebv1hUYT+TrbQbDpNjB+Ow89QGXrgJT2zC7nDlMXLxy
	zMgv+5d4lXLDrUzwD8hN1Bj/KF7fVsB8nA4SrflJIQIAc6ttJmayNjhEHHK76GOw67RB
	GT38vs1EA4om+UI+LtWC0AfOSm1O1gu7bUNKT5SQT7Ul+qdvXaOK5nPUSE48uz2/RHFc
	krfUugLb9SHhHG1VKUzAXDhS/rrAqbfGJAuEBp334h/tK32oAG4vHd5ebzYywhzplbDA
	4Lgo41NMMfk5uh8aklm7Fk1dHCRgN8lL+GRTBKMm3PjUJ6aKayUiKU+n77mjcRr3bjWE
	EzuA==
X-Gm-Message-State: APjAAAWZMW1Otr0Ed0D8/3Nn07D1aAqVO5ghVMdVSpxfjn9Q4j6sr/qo
	7fjeRrGA4azXggxFH/xVame+BMwX
X-Google-Smtp-Source: APXvYqzPGGux3mKiZafdWEzHixzMg1SaExetc3v4s1b2Jv/8keOZTb5UHQZwdLOfD6oPTkrdx+aLGw==
X-Received: by 2002:adf:cf0e:: with SMTP id o14mr22435985wrj.182.1556134795262;
	Wed, 24 Apr 2019 12:39:55 -0700 (PDT)
Received: from linux.local ([31.154.166.148]) by smtp.gmail.com with ESMTPSA id
	n18sm16281372wrt.16.2019.04.24.12.39.52
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Wed, 24 Apr 2019 12:39:53 -0700 (PDT)
From: Jon Doron <arilou@gmail.com>
To: qemu-devel@nongnu.org
Date: Wed, 24 Apr 2019 22:38:54 +0300
Message-Id: <20190424193859.31817-16-arilou@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190424193859.31817-1-arilou@gmail.com>
References: <20190424193859.31817-1-arilou@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::443
Subject: [Qemu-devel] [PATCH v5 16/21] gdbstub: Implement step (s pkt) with
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
Message-ID: <20190424193854.TLhpjp8pm-q_M0tNP4Oqvu79cQeqaJeWbLw_PMOgNDA@z>

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



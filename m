Return-Path: <SRS0=3XOk=S2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66663C282E1
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2019 14:40:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C672521907
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2019 14:40:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dEmdck2f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C672521907
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:42692 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hJJ4P-0000pd-IP
	for qemu-devel@archiver.kernel.org; Wed, 24 Apr 2019 10:40:21 -0400
Received: from eggs.gnu.org ([209.51.188.92]:43914)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <arilou@gmail.com>) id 1hJIzJ-0004gM-3e
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 10:35:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <arilou@gmail.com>) id 1hJIsV-00012k-7d
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 10:28:05 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:35034)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <arilou@gmail.com>) id 1hJIsT-0000tU-9O
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 10:28:02 -0400
Received: by mail-wm1-x343.google.com with SMTP id y197so5380357wmd.0
	for <qemu-devel@nongnu.org>; Wed, 24 Apr 2019 07:27:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=QHRX3vrkkfr+XXALwGjewcGRMA15zptsxywkn/wXCOE=;
	b=dEmdck2f8NSrRqFQi6yyaIHnM/D6lwR9Dkex1c2rfT40qMQ5/1D/lQlE/2E3/Kv66I
	7XRIs3m9HVOeUv1ukgm+4ru/mjthaf+XB0l4WlzBasf8+vrNXYaHKiO6RBvwaaOiRWnR
	uL/IZ0UXgcVzrPWTNkZXdX1TtTcM3N+aNLsZCrBG9KKzanfK74iFDqIHcq+ft0zWhp0a
	gC8o2uZKTIWT8xP3eBLPdpERgtwf5WVboC6UiCg3qyYb5EUNAiox0PcWr1QvsUKTx873
	UUdJugqiqG62+AYOEVrZvGvSdwkz7XGsmUNXC4zLi+nEVXGBHAFMfElLXvAsnWx8MHlt
	pNmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=QHRX3vrkkfr+XXALwGjewcGRMA15zptsxywkn/wXCOE=;
	b=RiInObnQgS1ALCR88H+8m0IDsKTtVKkhLC1erKXK2Rzxp2vnlUK5Ws955/mybOIuiF
	64UGIM7Yrt3LMZWib37CsGwZA9SonfniMyz68rjTAjHWnOdYtrnkFO/BqWjDdzWW5lx9
	DmhP3GxJnZ7+cprcd6Q38f8SabpUllP/Fv9jYLbqffUN5kjC3F8ggiEBYAHSjiqERvoP
	ERfmGrOxrEscJIJrwNg7Y+hmEOccEtv2hH7ZGo4ta/5aBnFAdc30IX2rPk1ByaGrsoo/
	VJbyRvuIrgq16DQxW/jllHly7Aagd4hbOjUQSQLL4wfk0tnn7HvCs5kN7pZA5KWpsBVk
	QeQA==
X-Gm-Message-State: APjAAAUCfBI8dGMZSG+OlTRoeT/6quLbMNomgZ+QafrrPOGedDnwMQj6
	WGs35GxSWu+UN4cX7+xbrNr8x8mn
X-Google-Smtp-Source: APXvYqzMaBkp6mVNyL8gqe3Y2ITIsXAoTVihqaF0OPPyuFjiBZd2qhgmn1ys7I+ZHqIWXIic0IjSIQ==
X-Received: by 2002:a7b:c745:: with SMTP id w5mr2683921wmk.89.1556116076471;
	Wed, 24 Apr 2019 07:27:56 -0700 (PDT)
Received: from linux.local ([31.154.166.148])
	by smtp.gmail.com with ESMTPSA id q7sm5518041wmc.11.2019.04.24.07.27.52
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Wed, 24 Apr 2019 07:27:54 -0700 (PDT)
From: arilou@gmail.com
To: qemu-devel@nongnu.org
Date: Wed, 24 Apr 2019 17:27:08 +0300
Message-Id: <20190424142714.28460-14-arilou@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190424142714.28460-1-arilou@gmail.com>
References: <20190424142714.28460-1-arilou@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::343
Subject: [Qemu-devel] [PATCH v3 14/20] gdbstub: Implement read all registers
 (g pkt) with new infra
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
Message-ID: <20190424142708.Nl8DoxnN9fhP1p4BgUrpgc80zeOEF4QAEATOu-Tmrv0@z>

From: Jon Doron <arilou@gmail.com>

Signed-off-by: Jon Doron <arilou@gmail.com>
---
 gdbstub.c | 31 +++++++++++++++++++++++--------
 1 file changed, 23 insertions(+), 8 deletions(-)

diff --git a/gdbstub.c b/gdbstub.c
index 0523deaef2..b3278a66c7 100644
--- a/gdbstub.c
+++ b/gdbstub.c
@@ -1773,6 +1773,21 @@ static void handle_write_all_regs(GdbCmdContext *gdb_ctx, void *user_ctx)
     put_packet(gdb_ctx->s, "OK");
 }
 
+static void handle_read_all_regs(GdbCmdContext *gdb_ctx, void *user_ctx)
+{
+    target_ulong addr, len;
+
+    cpu_synchronize_state(gdb_ctx->s->g_cpu);
+    len = 0;
+    for (addr = 0; addr < gdb_ctx->s->g_cpu->gdb_num_g_regs; addr++) {
+        len += gdb_read_register(gdb_ctx->s->g_cpu, gdb_ctx->mem_buf + len,
+                                 addr);
+    }
+
+    memtohex(gdb_ctx->str_buf, gdb_ctx->mem_buf, len);
+    put_packet(gdb_ctx->s, gdb_ctx->str_buf);
+}
+
 static int gdb_handle_packet(GDBState *s, const char *line_buf)
 {
     CPUState *cpu;
@@ -1780,7 +1795,7 @@ static int gdb_handle_packet(GDBState *s, const char *line_buf)
     CPUClass *cc;
     const char *p;
     uint32_t pid, tid;
-    int ch, reg_size, type, res;
+    int ch, type, res;
     uint8_t mem_buf[MAX_PACKET_LENGTH];
     char buf[sizeof(mem_buf) + 1 /* trailing NUL */];
     char thread_id[16];
@@ -1938,14 +1953,14 @@ static int gdb_handle_packet(GDBState *s, const char *line_buf)
         }
         break;
     case 'g':
-        cpu_synchronize_state(s->g_cpu);
-        len = 0;
-        for (addr = 0; addr < s->g_cpu->gdb_num_g_regs; addr++) {
-            reg_size = gdb_read_register(s->g_cpu, mem_buf + len, addr);
-            len += reg_size;
+        {
+            static GdbCmdParseEntry read_all_regs_cmd_desc = {
+                .handler = handle_read_all_regs,
+                .cmd = "g",
+                .cmd_startswith = 1
+            };
+            process_string_cmd(s, NULL, line_buf, &read_all_regs_cmd_desc, 1);
         }
-        memtohex(buf, mem_buf, len);
-        put_packet(s, buf);
         break;
     case 'G':
         {
-- 
2.20.1



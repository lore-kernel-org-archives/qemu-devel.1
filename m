Return-Path: <SRS0=DspQ=T5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA2C9C04AB3
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2019 07:04:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 643E0208CB
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2019 07:04:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W8DVy6X3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 643E0208CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:48551 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hVsdV-000350-LZ
	for qemu-devel@archiver.kernel.org; Wed, 29 May 2019 03:04:33 -0400
Received: from eggs.gnu.org ([209.51.188.92]:45220)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <arilou@gmail.com>) id 1hVsHv-00016L-Fv
	for qemu-devel@nongnu.org; Wed, 29 May 2019 02:42:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <arilou@gmail.com>) id 1hVsHu-000224-GU
	for qemu-devel@nongnu.org; Wed, 29 May 2019 02:42:15 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:37981)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <arilou@gmail.com>) id 1hVsHu-0001uT-Af
	for qemu-devel@nongnu.org; Wed, 29 May 2019 02:42:14 -0400
Received: by mail-wr1-x443.google.com with SMTP id d18so793679wrs.5
	for <qemu-devel@nongnu.org>; Tue, 28 May 2019 23:42:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=znSiOGTnV63Iw4NoeCVkFq+8TJBRoFVxm4iUWeh4XxE=;
	b=W8DVy6X34OB183ztL9J5Uorl/nmQURkpqPMerzieAUEpyAIxzBwalKwG29Iwtvl3h8
	vh4ItqgaKPfgYOyahzoHLNhyXg5vzM8Bae2NEoyqXoyeK48GBZbw9Tczl8jAUcsf2KBO
	vDdFnu/cUHpQCGlc318qTTTyzX9GAOojWfZ3djD8XNxirmnATRMQSWnf7vDbw3WLDAhZ
	4kH2zB1nLOE/HBinDU+FML5VRNwWJJ0bAHTw4uyuVdC0/oRgQaaAztvFPp1R+FKvabJH
	rx8J55SWlH639Xw6NlUAfnHychKphrHr55ntcvWnWtFdkXqawpWj622wVEtDLTsYNgbE
	JAhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=znSiOGTnV63Iw4NoeCVkFq+8TJBRoFVxm4iUWeh4XxE=;
	b=fL6c1XRr0Sh3ofxKi/MZgeJaMjnb8CiHOk8Qld/UjR4njJG2KnYedy0dpQUl7iSVZQ
	igiXPLJmN2B9FC+Z8bwPiRXjUqEC9ckuufw+5wbdnnZ+2T+FYbgMpNNth0rZyIF5Ls3Z
	S81g7GsVuSw4XMWz35s3B9lQF7ffCHp/2/2UzPVhyZwHaapGEWNLXNfZD+H0sFA/nn++
	ueU+4ViUPe2KG6rjNHn4USX0KcZ/w6JKKoRVSYKO9UmPSzHJsfiPqxfY/j5yT3OaZotr
	woIp4/ssAJjK9y/IAK8g82JyXzI7YXnhM9Gb4bPZCcJqM7sTDWWHmULNQt4/fbXlyQcP
	YU3g==
X-Gm-Message-State: APjAAAWQXFUaRsCBWHFRWAsCJJeEGRv4WCTP3A/G7iPIxxuiVUK/DIto
	aA97D9Cla7mjQj+SBGRkA+E8xQ0A
X-Google-Smtp-Source: APXvYqxmIeA/W36rmi9TZKfKoRqq6hFsEZysWbqlu7eHpXQ3JJg1yamkcvf11V9ffVVQqjGcTsxanA==
X-Received: by 2002:a5d:6189:: with SMTP id j9mr16791438wru.151.1559112133229; 
	Tue, 28 May 2019 23:42:13 -0700 (PDT)
Received: from linux.local ([31.154.166.148])
	by smtp.gmail.com with ESMTPSA id f2sm6831168wme.12.2019.05.28.23.42.12
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Tue, 28 May 2019 23:42:12 -0700 (PDT)
From: Jon Doron <arilou@gmail.com>
To: qemu-devel@nongnu.org
Date: Wed, 29 May 2019 09:41:41 +0300
Message-Id: <20190529064148.19856-14-arilou@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190529064148.19856-1-arilou@gmail.com>
References: <20190529064148.19856-1-arilou@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::443
Subject: [Qemu-devel] [PATCH v12 13/20] gdbstub: Implement read all
 registers (g pkt) with new infra
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

Signed-off-by: Jon Doron <arilou@gmail.com>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
---
 gdbstub.c | 31 +++++++++++++++++++++++--------
 1 file changed, 23 insertions(+), 8 deletions(-)

diff --git a/gdbstub.c b/gdbstub.c
index a487e549d1..8a401e6527 100644
--- a/gdbstub.c
+++ b/gdbstub.c
@@ -1774,6 +1774,21 @@ static void handle_write_all_regs(GdbCmdContext *gdb_ctx, void *user_ctx)
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
@@ -1781,7 +1796,7 @@ static int gdb_handle_packet(GDBState *s, const char *line_buf)
     CPUClass *cc;
     const char *p;
     uint32_t pid, tid;
-    int ch, reg_size, type, res;
+    int ch, type, res;
     uint8_t mem_buf[MAX_PACKET_LENGTH];
     char buf[sizeof(mem_buf) + 1 /* trailing NUL */];
     char thread_id[16];
@@ -1940,14 +1955,14 @@ static int gdb_handle_packet(GDBState *s, const char *line_buf)
         }
         break;
     case 'g':
-        cpu_synchronize_state(s->g_cpu);
-        len = 0;
-        for (addr = 0; addr < s->g_cpu->gdb_num_g_regs; addr++) {
-            reg_size = gdb_read_register(s->g_cpu, mem_buf + len, addr);
-            len += reg_size;
+        {
+            static const GdbCmdParseEntry read_all_regs_cmd_desc = {
+                .handler = handle_read_all_regs,
+                .cmd = "g",
+                .cmd_startswith = 1
+            };
+            cmd_parser = &read_all_regs_cmd_desc;
         }
-        memtohex(buf, mem_buf, len);
-        put_packet(s, buf);
         break;
     case 'G':
         {
-- 
2.21.0



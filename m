Return-Path: <SRS0=oHhb=TY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBDECC072B5
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2019 16:13:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8638B20675
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2019 16:13:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hyu5AiS8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8638B20675
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:57031 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hUCom-0005Xi-Na
	for qemu-devel@archiver.kernel.org; Fri, 24 May 2019 12:13:16 -0400
Received: from eggs.gnu.org ([209.51.188.92]:37180)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <arilou@gmail.com>) id 1hUCdf-00044D-F0
	for qemu-devel@nongnu.org; Fri, 24 May 2019 12:01:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <arilou@gmail.com>) id 1hUCdd-00023p-BW
	for qemu-devel@nongnu.org; Fri, 24 May 2019 12:01:47 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:38538)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <arilou@gmail.com>) id 1hUCdZ-0001yD-DZ
	for qemu-devel@nongnu.org; Fri, 24 May 2019 12:01:43 -0400
Received: by mail-wr1-x441.google.com with SMTP id d18so10554791wrs.5
	for <qemu-devel@nongnu.org>; Fri, 24 May 2019 09:01:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=JBP05yP+oKTHN0+qEMyIVDJm99TfFag3Xoa9AN/GQ0I=;
	b=hyu5AiS8P8ilchgmBBDPmsuzUdXoaGggst7Tc6w+9i05dR5pPwZ31oUvtnUTlrmcjN
	8/K+iuGSjCui8px4fJ4yu01g6MwLwTgpsgubQ8s1pMhPM2YN0LBwlR6ZiBZXCYB9X/g1
	bwxmszp1SHH93BhDYQsmLse6aDlVjussxoQHd6dPiRpZMIQHoBSkadjlbm/549cu5yaO
	e+uZe5b8YdRRtB0ibe7i0M5m03jxSl66GGVO7bSCglm1Es19IrXstqJmHLxEyJkwNitI
	bvyvDRalT0a/R1RTKMMVBXN2Mb34ZfE3O+p8aXHPw2X7hX6B5zm32Ec3YJMjQTyVqXF7
	pnWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=JBP05yP+oKTHN0+qEMyIVDJm99TfFag3Xoa9AN/GQ0I=;
	b=CJ3ggouOCJzGEHGK9gwYcIviRAule6Xoa2gW8hzKhoXj/jhPGRIZTjpOaKXBxx7MM7
	Qb3sR+uJooW4OmjCHTQD6SnzV/OatpVVZWR6aihD3K2JegJWBdApEY6z7zCxNioDLyGB
	1gIWcb95bVwxnQ6PCTtxC4DWMurmhKw0zOsHjD6JZU/rhuNNWXRaOS2B/V9gO3FIlPx4
	hHSCSy24FXla0FvHPVSCpdIURt9KHnJiVPGXgvuQTsdYlGGuJjf5uejXok/5MDk8g5Qa
	Aqz+fwsS1eV4QrqhqXVToHysMuqYgjrjxoGmiZZ0mSECpa9P2VCPpuXMRmSofLWiz0GV
	0KXg==
X-Gm-Message-State: APjAAAWuxB5OToOTHftrOJfkKtL5vxkyI89/qQYqvIUJnBA0rg5+n4PA
	DqEFboZb5CR5qptgsdRSFxl5ZHVD
X-Google-Smtp-Source: APXvYqzOkx+SKEglllALZox9DWJ4TlTEqqOmtJQjszgMQMtZiGFyoeqUH1GN4Qla+kwszZa0Ue1t5A==
X-Received: by 2002:a5d:4fc1:: with SMTP id h1mr1926062wrw.323.1558713698528; 
	Fri, 24 May 2019 09:01:38 -0700 (PDT)
Received: from jondnuc.lan ([176.230.64.37])
	by smtp.gmail.com with ESMTPSA id s11sm370863wro.17.2019.05.24.09.01.37
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Fri, 24 May 2019 09:01:38 -0700 (PDT)
From: Jon Doron <arilou@gmail.com>
To: qemu-devel@nongnu.org
Date: Fri, 24 May 2019 19:01:05 +0300
Message-Id: <20190524160118.31134-8-arilou@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190524160118.31134-1-arilou@gmail.com>
References: <20190524160118.31134-1-arilou@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::441
Subject: [Qemu-devel] [PATCH v11 07/20] gdbstub: Implement breakpoint
 commands (Z/z pkt) with new infra
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
---
 gdbstub.c | 84 +++++++++++++++++++++++++++++++++++++++++++------------
 1 file changed, 66 insertions(+), 18 deletions(-)

diff --git a/gdbstub.c b/gdbstub.c
index 129a47230f..c59a6765cd 100644
--- a/gdbstub.c
+++ b/gdbstub.c
@@ -950,7 +950,7 @@ static inline int xlat_gdb_type(CPUState *cpu, int gdbtype)
 }
 #endif
 
-static int gdb_breakpoint_insert(target_ulong addr, target_ulong len, int type)
+static int gdb_breakpoint_insert(int type, target_ulong addr, target_ulong len)
 {
     CPUState *cpu;
     int err = 0;
@@ -1591,6 +1591,52 @@ static void handle_set_thread(GdbCmdContext *gdb_ctx, void *user_ctx)
     }
 }
 
+static void handle_insert_bp(GdbCmdContext *gdb_ctx, void *user_ctx)
+{
+    int res;
+
+    if (gdb_ctx->num_params != 3) {
+        put_packet(gdb_ctx->s, "E22");
+        return;
+    }
+
+    res = gdb_breakpoint_insert(gdb_ctx->params[0].val_ul,
+                                gdb_ctx->params[1].val_ull,
+                                gdb_ctx->params[2].val_ull);
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
+static void handle_remove_bp(GdbCmdContext *gdb_ctx, void *user_ctx)
+{
+    int res;
+
+    if (gdb_ctx->num_params != 3) {
+        put_packet(gdb_ctx->s, "E22");
+        return;
+    }
+
+    res = gdb_breakpoint_remove(gdb_ctx->params[0].val_ul,
+                                gdb_ctx->params[1].val_ull,
+                                gdb_ctx->params[2].val_ull);
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
@@ -1846,24 +1892,26 @@ static int gdb_handle_packet(GDBState *s, const char *line_buf)
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
-        type = strtoul(p, (char **)&p, 16);
-        if (*p == ',')
-            p++;
-        addr = strtoull(p, (char **)&p, 16);
-        if (*p == ',')
-            p++;
-        len = strtoull(p, (char **)&p, 16);
-        if (ch == 'Z')
-            res = gdb_breakpoint_insert(addr, len, type);
-        else
-            res = gdb_breakpoint_remove(addr, len, type);
-        if (res >= 0)
-             put_packet(s, "OK");
-        else if (res == -ENOSYS)
-            put_packet(s, "");
-        else
-            put_packet(s, "E22");
+        {
+            static const GdbCmdParseEntry remove_bp_cmd_desc = {
+                .handler = handle_remove_bp,
+                .cmd = "z",
+                .cmd_startswith = 1,
+                .schema = "l?L?L0"
+            };
+            cmd_parser = &remove_bp_cmd_desc;
+        }
         break;
     case 'H':
         {
-- 
2.21.0



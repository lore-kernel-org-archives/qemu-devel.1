Return-Path: <SRS0=oHhb=TY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A440C072B5
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2019 16:17:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EA8872070D
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2019 16:17:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fLItQb6g"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA8872070D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:57113 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hUCtJ-00013C-4J
	for qemu-devel@archiver.kernel.org; Fri, 24 May 2019 12:17:57 -0400
Received: from eggs.gnu.org ([209.51.188.92]:37245)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <arilou@gmail.com>) id 1hUCdn-0004D2-NN
	for qemu-devel@nongnu.org; Fri, 24 May 2019 12:01:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <arilou@gmail.com>) id 1hUCdl-0002Dp-RE
	for qemu-devel@nongnu.org; Fri, 24 May 2019 12:01:55 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:42917)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <arilou@gmail.com>) id 1hUCdf-00022D-F4
	for qemu-devel@nongnu.org; Fri, 24 May 2019 12:01:51 -0400
Received: by mail-wr1-x442.google.com with SMTP id l2so10555729wrb.9
	for <qemu-devel@nongnu.org>; Fri, 24 May 2019 09:01:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=Iqrsskq+v4Yl7Dt6mWyZemV9b36J+YLnKtc5/VCxFeU=;
	b=fLItQb6gDmGP2lj+8iW3ffAToBMQ0P0X3PAUBEJ7Lyy9WWBseyBcCGWqG2NGDxO761
	6NEnTSAKph6gySYJuL8G2gLnLANxecZ8C4GRyINA4hnxVgrtghAdg1Z1fs4NCrJDtEcX
	NYEP/TIKBo8CR6twvgWeavbCRdV4NyX6ndwlOOxozLDUsvjEUT0h7YS148g9k44wijfr
	BuU0d1tzSDR0tLrHY7FDrn6HNDbtA7kalsP/tezDtnaF6SAZrmsUpMhRRHRHMof8b+jF
	GBWOYmF4Ar0emZdHJaOl/zli4Xx/tGiC9gqM096XcKMBGjAEPBBWyqIUOGaTR9WudtTW
	NfbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=Iqrsskq+v4Yl7Dt6mWyZemV9b36J+YLnKtc5/VCxFeU=;
	b=ZRALK3K6GWZmyCRgeKV/L8x3mqNmTxSpYOKroFdfR571RT4o5sjKBPRBv5uylaw7bI
	ADvypjPwlN8NLPq41Kwh1A+T5U9I96agjRpJ1np/v1OYKTVETWq9SgxVLA73LiKgY8bI
	VTQ3N+OfYPkBIFWSwt0hG9myIr8C535srwW2ebKdomW6FQx1OMJQSC3B8urGuRGY9wNK
	aDOG5ZWJteE8mUqTGnp1zrtXmoh0l+iMgMRVGkg00Pfo60TMrnP+RnxfyoeyrV6k/piK
	qL1J4InpH3DpkqyRWw+nQYvL0PMtwZeBvYx3Ix9Ya2iiHpgrGxGViA8NnaFCBCyTx7QY
	zRjw==
X-Gm-Message-State: APjAAAWTpWZn9MtzroA6xohEtzEuTJwgrn/5/k63p1F4Gr8HjSd7DjRL
	U1go2j74W46UPM3qSx2vyQ0G0Ir8
X-Google-Smtp-Source: APXvYqwZj/RujIdDHaK+Hog1JVu0Qx59zozHnMvDnBodFbkZ0RwO1ON66tJFloPb0FMEMwSjvbAyKw==
X-Received: by 2002:adf:db0b:: with SMTP id s11mr6562199wri.180.1558713703055; 
	Fri, 24 May 2019 09:01:43 -0700 (PDT)
Received: from jondnuc.lan ([176.230.64.37])
	by smtp.gmail.com with ESMTPSA id s11sm370863wro.17.2019.05.24.09.01.42
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Fri, 24 May 2019 09:01:42 -0700 (PDT)
From: Jon Doron <arilou@gmail.com>
To: qemu-devel@nongnu.org
Date: Fri, 24 May 2019 19:01:09 +0300
Message-Id: <20190524160118.31134-12-arilou@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190524160118.31134-1-arilou@gmail.com>
References: <20190524160118.31134-1-arilou@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::442
Subject: [Qemu-devel] [PATCH v11 11/20] gdbstub: Implement read memory (m
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

Signed-off-by: Jon Doron <arilou@gmail.com>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
---
 gdbstub.c | 48 ++++++++++++++++++++++++++++++++----------------
 1 file changed, 32 insertions(+), 16 deletions(-)

diff --git a/gdbstub.c b/gdbstub.c
index c798d93e22..c957b0d8a7 100644
--- a/gdbstub.c
+++ b/gdbstub.c
@@ -1713,6 +1713,30 @@ static void handle_write_mem(GdbCmdContext *gdb_ctx, void *user_ctx)
     put_packet(gdb_ctx->s, "OK");
 }
 
+static void handle_read_mem(GdbCmdContext *gdb_ctx, void *user_ctx)
+{
+    if (gdb_ctx->num_params != 2) {
+        put_packet(gdb_ctx->s, "E22");
+        return;
+    }
+
+    /* memtohex() doubles the required space */
+    if (gdb_ctx->params[1].val_ull > MAX_PACKET_LENGTH / 2) {
+        put_packet(gdb_ctx->s, "E22");
+        return;
+    }
+
+    if (target_memory_rw_debug(gdb_ctx->s->g_cpu, gdb_ctx->params[0].val_ull,
+                               gdb_ctx->mem_buf,
+                               gdb_ctx->params[1].val_ull, false)) {
+        put_packet(gdb_ctx->s, "E14");
+        return;
+    }
+
+    memtohex(gdb_ctx->str_buf, gdb_ctx->mem_buf, gdb_ctx->params[1].val_ull);
+    put_packet(gdb_ctx->s, gdb_ctx->str_buf);
+}
+
 static int gdb_handle_packet(GDBState *s, const char *line_buf)
 {
     CPUState *cpu;
@@ -1902,22 +1926,14 @@ static int gdb_handle_packet(GDBState *s, const char *line_buf)
         put_packet(s, "OK");
         break;
     case 'm':
-        addr = strtoull(p, (char **)&p, 16);
-        if (*p == ',')
-            p++;
-        len = strtoull(p, NULL, 16);
-
-        /* memtohex() doubles the required space */
-        if (len > MAX_PACKET_LENGTH / 2) {
-            put_packet (s, "E22");
-            break;
-        }
-
-        if (target_memory_rw_debug(s->g_cpu, addr, mem_buf, len, false) != 0) {
-            put_packet (s, "E14");
-        } else {
-            memtohex(buf, mem_buf, len);
-            put_packet(s, buf);
+        {
+            static const GdbCmdParseEntry read_mem_cmd_desc = {
+                .handler = handle_read_mem,
+                .cmd = "m",
+                .cmd_startswith = 1,
+                .schema = "L,L0"
+            };
+            cmd_parser = &read_mem_cmd_desc;
         }
         break;
     case 'M':
-- 
2.21.0



Return-Path: <SRS0=3XOk=S2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8D8FC10F11
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2019 14:56:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A35912084F
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2019 14:56:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ht3oNd6D"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A35912084F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:42809 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hJJA0-0006Lb-7R
	for qemu-devel@archiver.kernel.org; Wed, 24 Apr 2019 10:46:08 -0400
Received: from eggs.gnu.org ([209.51.188.92]:43933)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <arilou@gmail.com>) id 1hJIzL-0004hj-R3
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 10:35:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <arilou@gmail.com>) id 1hJIs5-0000UO-7u
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 10:27:38 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:33639)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <arilou@gmail.com>) id 1hJIs5-0000To-23
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 10:27:37 -0400
Received: by mail-wr1-x443.google.com with SMTP id s18so631451wrp.0
	for <qemu-devel@nongnu.org>; Wed, 24 Apr 2019 07:27:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=L/ntZTxQqbWbh47gRffGNOALcSxerPUuXFaXMjdEz80=;
	b=Ht3oNd6DAFodZwbDAYEL5n/Z9eSbh63flG9lUSCT/+HfurtHwyAdmKe7v1yer3oBQ5
	VZQXxsa6767LMs8FZZSC6GnEbeKu8BIN7ks8VkgxTuhG18gT6bCGHEi2x4Wjae1WTE3B
	JuibktgVxOAN/RXGtSSw/ycjAqtKiDmiIF0Mdr0AARuwO8OhmO5A1E0ZQ0DrYYqzToRA
	QQYiVQwPUOlaIJ9yfkhc/us96vmwSwo5vMIJDOAnm1KSReiN9BSZIsSdV+MhOvGhv7HI
	zqrmb8BFqMJuXbzoLqCxwkrqe9merJ4UltzeLGq/u8UMGLEDs7BBq7mDLC4Cm3UIwNUs
	672A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=L/ntZTxQqbWbh47gRffGNOALcSxerPUuXFaXMjdEz80=;
	b=IeDkRqLZob/SuG7oM502jwur82hFKzjocE7BWv9wWW+e52tzFaAnbUHCEZ8ROfN1IW
	s3K6+gH/xTuSwSANYSadVUY1o1zG721LrfoyMNZQE0hbQxLi24vnD1i2RibYXo2Pey6c
	ZkIR8nUdmRuBmksvSxD3cpKKiecGvXi9zXpzOc/9dFyKx8iiN9HnklrpdG0eFz0Ixjaq
	qktQOIQDc6ryswM7tW2D11F3NeMTe9oQDCCXtMeisSaqMsMq1sn6lpDA0k442QOt76eP
	M52uIu2IyuWYrF/Uruws5UU0os2sugr5P2pHmPCv0+8/9AhNEuzgse//d8QZGFi63jSx
	m43w==
X-Gm-Message-State: APjAAAX9rg1r1Lo75eDTsKmxG6HaVeDYNexCSzzwf2dIfK/cNeLgdua/
	xAdb0TcJMeBIICx3VoPDD9fmZvUx
X-Google-Smtp-Source: APXvYqzo0n7+WSNTxKRZmBWMMPKvgmr/hP82aX/tOnzluCT5rmRZUkaPpcZ9aJprrSR/GomldBeYlg==
X-Received: by 2002:a5d:550b:: with SMTP id b11mr6782518wrv.81.1556116055468; 
	Wed, 24 Apr 2019 07:27:35 -0700 (PDT)
Received: from linux.local ([31.154.166.148])
	by smtp.gmail.com with ESMTPSA id q7sm5518041wmc.11.2019.04.24.07.27.33
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Wed, 24 Apr 2019 07:27:34 -0700 (PDT)
From: arilou@gmail.com
To: qemu-devel@nongnu.org
Date: Wed, 24 Apr 2019 17:27:01 +0300
Message-Id: <20190424142714.28460-7-arilou@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190424142714.28460-1-arilou@gmail.com>
References: <20190424142714.28460-1-arilou@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::443
Subject: [Qemu-devel] [PATCH v3 07/20] gdbstub: Implement insert breakpoint
 (Z pkt) with new infra
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
Message-ID: <20190424142701.1Kmx9EquMTrzrzG7feD0pxVuiCL2T6_lVl06PWy7mfk@z>

From: Jon Doron <arilou@gmail.com>

Signed-off-by: Jon Doron <arilou@gmail.com>
---
 gdbstub.c | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/gdbstub.c b/gdbstub.c
index 87b364b1d0..67cb140031 100644
--- a/gdbstub.c
+++ b/gdbstub.c
@@ -1604,6 +1604,29 @@ static void handle_set_thread(GdbCmdContext *gdb_ctx, void *user_ctx)
     }
 }
 
+static void handle_insert_bp(GdbCmdContext *gdb_ctx, void *user_ctx)
+{
+    int res;
+
+    if (gdb_ctx->num_params < 3) {
+        put_packet(gdb_ctx->s, "E22");
+        return;
+    }
+
+    res = gdb_breakpoint_insert(gdb_ctx->params[1].val_ull,
+                                gdb_ctx->params[2].val_ull,
+                                gdb_ctx->params[0].val_ul);
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
@@ -1858,6 +1881,16 @@ static int gdb_handle_packet(GDBState *s, const char *line_buf)
         put_packet(s, "OK");
         break;
     case 'Z':
+        {
+            static GdbCmdParseEntry insert_bp_cmd_desc = {
+                .handler = handle_insert_bp,
+                .cmd = "Z",
+                .cmd_startswith = 1,
+                .schema = "l?L?L0"
+            };
+            process_string_cmd(s, NULL, line_buf, &insert_bp_cmd_desc, 1);
+        }
+        break;
     case 'z':
         type = strtoul(p, (char **)&p, 16);
         if (*p == ',')
-- 
2.20.1



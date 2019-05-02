Return-Path: <SRS0=nlPZ=TC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E9EFC43219
	for <qemu-devel@archiver.kernel.org>; Thu,  2 May 2019 07:43:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 37BA320873
	for <qemu-devel@archiver.kernel.org>; Thu,  2 May 2019 07:43:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JlMWL/cd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 37BA320873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:46726 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hM6Nd-00014P-G9
	for qemu-devel@archiver.kernel.org; Thu, 02 May 2019 03:43:45 -0400
Received: from eggs.gnu.org ([209.51.188.92]:59814)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <arilou@gmail.com>) id 1hM6AE-000537-8E
	for qemu-devel@nongnu.org; Thu, 02 May 2019 03:29:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <arilou@gmail.com>) id 1hM6A5-0002vX-Ot
	for qemu-devel@nongnu.org; Thu, 02 May 2019 03:29:48 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:39148)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <arilou@gmail.com>) id 1hM69w-0000cj-PC
	for qemu-devel@nongnu.org; Thu, 02 May 2019 03:29:39 -0400
Received: by mail-wr1-x442.google.com with SMTP id a9so1793624wrp.6
	for <qemu-devel@nongnu.org>; Thu, 02 May 2019 00:27:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=b1bpFqGwMibMAfq1pbDbHkF4Xk3yQKA0SG1CtWad0g4=;
	b=JlMWL/cdb/JdMWck4utPHKmKXZNMuVdtGzPl6moponzy9+h6WUnWE3eHDVxh6bP6C9
	6CzngYtwwVoS4LKmVxufZIK3OaBl6CvL1lIXTuoFCDU1w1jrXMcJUrzKQAwl2LGP+mW9
	Xhu/SfBaQlXc9ejQZA30cOwWN6V9p4+WJ8uBqZwVqXryS0olGhuEogQhhoO1ltmxmwER
	NVnXCLQbbS46gr5izAlqEz3NlaZD1SBerEvV8R7dNhoG4UtS5p8A4UQvfKNNf41HTEi2
	VSfJakhsO+ewcd91qjY4y6CmGTTdi3G7f2o0j8RxRYY3TchW/nc5B8tR9bjzOSegfpNb
	WbfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=b1bpFqGwMibMAfq1pbDbHkF4Xk3yQKA0SG1CtWad0g4=;
	b=NSAC2v0vCugOS32/7CsEczQEqXe2vRMzEg2cRPWNodalGlNIyxsys60Havpy7HG670
	GTVqaSfhOrz5y926w8OccdOcLicn+8Iq0kzTX3Xh3NqFluIRLCFViD9LUVm5PORjBt31
	Z9mkEEwuCFx9Lv9wVmI2mxhDqcDBDHo61oppPkKZ8Tx2vQNGyeTiFV84WOEjsScMhohZ
	B2jVWUMgG0LXJKADWmN7fOY5Oq4uacH7SipESzl9GF/xsfkv6GbfdjV1PUEx5roR/tpl
	rxXStws+ZYl85J40SiwLK1EdKi54Or6Ka5EXg+c3UOOyfE5g969rc7BDfLdrj7FILLSd
	Mztw==
X-Gm-Message-State: APjAAAUWKxig/VI+I/xtC1LznXhvC00VOe2eBT1oPDTWUvGpFDW7njBM
	C3zjendT4dQFPgS6MvFQF2VkWTLZ
X-Google-Smtp-Source: APXvYqxDajLgHlymwSlOWbfC2Qa+akH9rev2md+FNIJYyP8sSH18j6TXnoTaxA1OW4q8JKk8+rfITQ==
X-Received: by 2002:a05:6000:ca:: with SMTP id
	q10mr1527382wrx.148.1556782039588; 
	Thu, 02 May 2019 00:27:19 -0700 (PDT)
Received: from localhost.localdomain ([176.230.64.186])
	by smtp.gmail.com with ESMTPSA id z5sm8769289wre.70.2019.05.02.00.27.16
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Thu, 02 May 2019 00:27:19 -0700 (PDT)
From: Jon Doron <arilou@gmail.com>
To: qemu-devel@nongnu.org
Date: Thu,  2 May 2019 10:26:28 +0300
Message-Id: <20190502072641.4667-15-arilou@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190502072641.4667-1-arilou@gmail.com>
References: <20190502072641.4667-1-arilou@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::442
Subject: [Qemu-devel] [PATCH v8 14/27] gdbstub: Implement read all registers
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
Cc: liran.alon@oracle.com, alex.bennee@linaro.org, Jon Doron <arilou@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190502072628.fiEifGmaL8EX2sB_RAfieknUZzfdOcuFokgZXAwNaG8@z>

Signed-off-by: Jon Doron <arilou@gmail.com>
---
 gdbstub.c | 31 +++++++++++++++++++++++--------
 1 file changed, 23 insertions(+), 8 deletions(-)

diff --git a/gdbstub.c b/gdbstub.c
index adfe39b3a3..3478ac778d 100644
--- a/gdbstub.c
+++ b/gdbstub.c
@@ -1757,6 +1757,21 @@ static void handle_write_all_regs(GdbCmdContext *gdb_ctx, void *user_ctx)
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
@@ -1764,7 +1779,7 @@ static int gdb_handle_packet(GDBState *s, const char *line_buf)
     CPUClass *cc;
     const char *p;
     uint32_t pid, tid;
-    int ch, reg_size, type, res;
+    int ch, type, res;
     uint8_t mem_buf[MAX_PACKET_LENGTH];
     char buf[sizeof(mem_buf) + 1 /* trailing NUL */];
     char thread_id[16];
@@ -1923,14 +1938,14 @@ static int gdb_handle_packet(GDBState *s, const char *line_buf)
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
2.20.1



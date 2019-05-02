Return-Path: <SRS0=nlPZ=TC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9333C43219
	for <qemu-devel@archiver.kernel.org>; Thu,  2 May 2019 08:24:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A24E020873
	for <qemu-devel@archiver.kernel.org>; Thu,  2 May 2019 08:24:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lt1UjKI0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A24E020873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:47272 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hM70n-00015B-TH
	for qemu-devel@archiver.kernel.org; Thu, 02 May 2019 04:24:13 -0400
Received: from eggs.gnu.org ([209.51.188.92]:42695)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <arilou@gmail.com>) id 1hM6te-0003Ux-AX
	for qemu-devel@nongnu.org; Thu, 02 May 2019 04:16:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <arilou@gmail.com>) id 1hM6ta-0007zA-CA
	for qemu-devel@nongnu.org; Thu, 02 May 2019 04:16:48 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:55513)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <arilou@gmail.com>) id 1hM6tY-0007Lr-Dj
	for qemu-devel@nongnu.org; Thu, 02 May 2019 04:16:46 -0400
Received: by mail-wm1-x344.google.com with SMTP id y2so1154116wmi.5
	for <qemu-devel@nongnu.org>; Thu, 02 May 2019 01:16:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=y+n9UknESyjS5ywhVhGmu6RRpXVVQXSmReCo/GVxG50=;
	b=lt1UjKI06APntNZRaAWb7B1QGAwHDHvMiZXPszIVTaUrA55sHZQHRc/6AROAXrWwhf
	lzoANLTD+RHndEhLVLrICx6CojBmzMTu18Pb/lS9cOTsgQL3KLQ2EnTCaK5s//l2maMS
	P3RcNmgAKBN8V0KbITx9GF4IFq8EAWeMNKhaf3QgKHXTyBTvV1re1YKOwXQh7lMa4TM5
	CG1T20XU5G/p2nkfNq24s3i4B7A0RHj+UDa3iZYyFpQ9oxwTSmJN60q/3BrQPzPY9M7I
	ZrR5Z9IlCf/cwBsyDDJ1+Fi0n2QEpN2B8APn5HXOEkCQHI6SlAD++bskfiC9/T1pKuYN
	stVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=y+n9UknESyjS5ywhVhGmu6RRpXVVQXSmReCo/GVxG50=;
	b=J53vTyOLsnzRB7qWPbHosTEpFax5zPU17uixG9Fa6POWYC+x98rWrFoiAiuvQOOEc5
	kDuANMLm3Q5xOJojXXaT7vLBpkplYHvd7xwWrLzRuyJDPQWr9XkYfpE8VVLas5V+FUtj
	V4GxhVpXbz8GjXA45j8ENDjwYbS3/ZSOsTduZaLj8SOLgDSSHBIWaHtuKt7C3HHy2HAU
	naLjlaSllwDciwmv9cOg+3/iz1B7uBD2tK+LFKn1glZaJiCvJIDXhiT+SeSAzuKVznyY
	AFBni4p4svoFWpS1ybSgXvbhOLLQxtHVwf46MhZWUf67z2hi9UMLuVrMx/KnNxdfScad
	iWLw==
X-Gm-Message-State: APjAAAWgzgfGVdaNTAbKxBLLTVDnUN06opGM5PBtf1e6qp11IltvzPOC
	fVV3xTDRPE+JR20K1puX4rhECHid
X-Google-Smtp-Source: APXvYqwl3kjSJi+Be1jR4+6VvhNE/RLIEd5hn8WhmBZaZjmJpQCLqlpQwISulfucyOQedJhkhhzJ3Q==
X-Received: by 2002:a7b:c390:: with SMTP id s16mr1313169wmj.111.1556784979175; 
	Thu, 02 May 2019 01:16:19 -0700 (PDT)
Received: from localhost.localdomain ([176.230.64.186])
	by smtp.gmail.com with ESMTPSA id
	d16sm44698367wra.54.2019.05.02.01.16.18
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Thu, 02 May 2019 01:16:18 -0700 (PDT)
From: Jon Doron <arilou@gmail.com>
To: qemu-devel@nongnu.org
Date: Thu,  2 May 2019 11:15:34 +0300
Message-Id: <20190502081554.5521-8-arilou@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190502081554.5521-1-arilou@gmail.com>
References: <20190502081554.5521-1-arilou@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::344
Subject: [Qemu-devel] [PATCH v9 07/27] gdbstub: Implement insert breakpoint
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
Cc: alex.bennee@linaro.org, Jon Doron <arilou@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190502081534.mSGuulx_G44MQ5PnKC3bKaMAy1k_pXOZOTT7I8ZtYG0@z>

Signed-off-by: Jon Doron <arilou@gmail.com>
---
 gdbstub.c | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/gdbstub.c b/gdbstub.c
index 21cdaf4678..36c7353a22 100644
--- a/gdbstub.c
+++ b/gdbstub.c
@@ -1588,6 +1588,29 @@ static void handle_set_thread(GdbCmdContext *gdb_ctx, void *user_ctx)
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
@@ -1843,6 +1866,16 @@ static int gdb_handle_packet(GDBState *s, const char *line_buf)
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
         type = strtoul(p, (char **)&p, 16);
         if (*p == ',')
-- 
2.20.1



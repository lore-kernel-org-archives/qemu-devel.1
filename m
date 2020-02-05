Return-Path: <SRS0=Tmh/=3Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FC73C35247
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2020 17:23:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4BE8920702
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2020 17:23:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ea0B9cGr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4BE8920702
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54118 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izOOp-000151-Fz
	for qemu-devel@archiver.kernel.org; Wed, 05 Feb 2020 12:23:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37935)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1izOIV-0007dR-3I
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 12:17:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1izOIT-00062c-ON
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 12:17:06 -0500
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:42607)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1izOIT-0005va-HJ
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 12:17:05 -0500
Received: by mail-wr1-x444.google.com with SMTP id k11so3687029wrd.9
 for <qemu-devel@nongnu.org>; Wed, 05 Feb 2020 09:17:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=CSaTZJFIuVQ1omKPNOe/5wVS6aybIDfIvPKxevpi+Xg=;
 b=Ea0B9cGryTq14bPh8JN1Rt9JSZwPDYQc2rZxdqwGmqfO2zd+hPmsxX4AZG0VQdkgOL
 Xgh+Oe57fSlc1r9QdRYRNHeRuluQM9XKVdcR+z57Sh6QmrJ86odQmztICwv5IHHCpUm3
 YEEBrc7Y4TFcaNCqAA+AGyoeheljdkE113ximuonifTerOGgS/itaBDzKaRS2iL2sT7e
 6k3mRLJIlM9ZRe8WbKc4QviNvT0EM1uHlm3sHmxJqiXRHS6o6tZD4U822UPLWtdaPB1o
 6FBNyFmzFvkBz/n2vgYlRPLXcf1MaMYYYihDS4fkixzwMjnN7nwiLzudhk+Dk/yLP5eq
 wugg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=CSaTZJFIuVQ1omKPNOe/5wVS6aybIDfIvPKxevpi+Xg=;
 b=p3su6eCPWoM0mdexlgdK9nADGk7Jeq3YYfGIT4YnW6dvfxqzOnQyV8NbyzIb/+dlkI
 oslxywkgaUay8L2Kq3DXmcDhiehchYWmCzUTFu7q9V1lXTV5s3yCCWUgoXsJtdDQZWlP
 4epLYewrDoExoYsWxOD9VknOcCWMNTeVd+YD7E9ZT4BKljRnHEHcAsJAk4N94POTSZ4z
 VDLR+0wqA7O2hlxABxCmo0Obo6DEg8fwQeF3EKJx+ZjgbV5U/RitF8jhRXw5paDuObom
 pCBxWg070pVTkcTCkQae+bgHD6nVOoJR5fE9PyADdoHSdzX3IYps7cWRJthHjrX2SXyc
 8CHw==
X-Gm-Message-State: APjAAAUy7VikX4V4YcFFq+3EdUtbo9MQc2lnd3Qf2Tw5/GrB93pVB14e
 F3mwoIEo7wdbuvKJTMZk7FNjyg==
X-Google-Smtp-Source: APXvYqwIf8lCNbJYJpqzUvU3chuhyiI0QeiMbEk5HEBfk/vxMOByD3zYzqpU3yBDgTAcs8MTubi8ww==
X-Received: by 2002:adf:f406:: with SMTP id g6mr18201457wro.189.1580923024070; 
 Wed, 05 Feb 2020 09:17:04 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id x10sm598659wrp.58.2020.02.05.09.17.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Feb 2020 09:17:02 -0800 (PST)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id CA53A1FFAE;
 Wed,  5 Feb 2020 17:10:33 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v6 22/22] gdbstub: do not split gdb_monitor_write payload
Date: Wed,  5 Feb 2020 17:10:31 +0000
Message-Id: <20200205171031.22582-23-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200205171031.22582-1-alex.bennee@linaro.org>
References: <20200205171031.22582-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::444
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: damien.hedde@greensocs.com, luis.machado@linaro.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 richard.henderson@linaro.org, alan.hayward@arm.com,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Luc Michel <luc.michel@greensocs.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Damien Hedde <damien.hedde@greensocs.com>

Since we can now send packets of arbitrary length:
simplify gdb_monitor_write() and send the whole payload
in one packet.

Suggested-by: Luc Michel <luc.michel@greensocs.com>
Signed-off-by: Damien Hedde <damien.hedde@greensocs.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20191211160514.58373-3-damien.hedde@greensocs.com>
---
 gdbstub.c | 23 +++--------------------
 1 file changed, 3 insertions(+), 20 deletions(-)

diff --git a/gdbstub.c b/gdbstub.c
index b9fb8c0a95a..6e461d871e0 100644
--- a/gdbstub.c
+++ b/gdbstub.c
@@ -3200,28 +3200,11 @@ static void gdb_chr_event(void *opaque, QEMUChrEvent event)
     }
 }
 
-static void gdb_monitor_output(const char *msg, int len)
-{
-    g_autoptr(GString) buf = g_string_new("O");
-    memtohex(buf, (uint8_t *)msg, len);
-    put_packet(buf->str);
-}
-
 static int gdb_monitor_write(Chardev *chr, const uint8_t *buf, int len)
 {
-    const char *p = (const char *)buf;
-    int max_sz;
-
-    max_sz = (MAX_PACKET_LENGTH / 2) + 1;
-    for (;;) {
-        if (len <= max_sz) {
-            gdb_monitor_output(p, len);
-            break;
-        }
-        gdb_monitor_output(p, max_sz);
-        p += max_sz;
-        len -= max_sz;
-    }
+    g_autoptr(GString) hex_buf = g_string_new("O");
+    memtohex(hex_buf, buf, len);
+    put_packet(hex_buf->str);
     return len;
 }
 
-- 
2.20.1



Return-Path: <SRS0=4PQo=7I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C547C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2020 09:41:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4785320671
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2020 09:41:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tC2MBLlu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4785320671
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57528 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jdW5r-0008Nf-H7
	for qemu-devel@archiver.kernel.org; Tue, 26 May 2020 05:41:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56380)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jdW4w-00078y-Mk; Tue, 26 May 2020 05:40:58 -0400
Received: from mail-ej1-x644.google.com ([2a00:1450:4864:20::644]:45656)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jdW4w-0005EN-3L; Tue, 26 May 2020 05:40:58 -0400
Received: by mail-ej1-x644.google.com with SMTP id o15so1711868ejm.12;
 Tue, 26 May 2020 02:40:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=vwOWgyl3PJNBjfcQLWQdQPXndI4SzNbhsrwUUVNJv3o=;
 b=tC2MBLluviIs04WpqQO4U5gX1dA59ALZVpvThawGKaodx6m0Mnm3tCgmdCZRNZX7vQ
 alnpYImZXYNffNq6DQx4b2KR5mR4gSOKYF7gYuminVnt1GrNvhqXQ3iDvhjC3kgnGQoZ
 mozFh6rmDxP3wcsYMl1CTDeLY7TGKzEK5nv9VibQ98hXh9b3QVlUWkw+fSkfgmmrF1kw
 AO5MYDDE9KXAiUBIrtmFuDfR5KXqpFnu7fh8HDxAZZjliv4Qk3WToJ30x7xRc0CxUQJV
 Kx+POK1W0iRf1lMZWaeH0RGhlSftx0xVY8qZyL/TV1WZ39oSM2hseXYhIqOyDTb4JJoW
 SVpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=vwOWgyl3PJNBjfcQLWQdQPXndI4SzNbhsrwUUVNJv3o=;
 b=L4SA6ud1lIoS8zLc4XAJMTAaZzxqBLG7KJRGJ8qdP6nXRyxwA7b3xsYj11y3zp72WS
 hlTJSP2kb/uiiEKaoWC0rrd02xQes8kDVOo6miWMZ3LKUTZG6L2Bp8m5W7zqboSmntq+
 aIP1T2toJ+OvJxHTqBJehO5KhJRHPx5gLKuqf/EbwN5like8gaECahIPtJI4kULK3V2V
 8+YtEbC+RZRccodpeDz2xxbHIRzAEylVWkD/pJGBCm3CYKHfqBzwiLlZSIlmB5uRt2mB
 uPPgNLXRvGzNx+obN0CPXCv2Ws+tCRGJPaDq7FRpKzOLKbsgNfVUQu3oSzCHpEsVTSTj
 /Eqg==
X-Gm-Message-State: AOAM5320B8LuyrGct5gaz7T49LKUfR7zrT2bw7YBymubm1wGq6BCkQ7n
 mWQMQSnQgZle/3kCGlTZFvVnpaBpZk8=
X-Google-Smtp-Source: ABdhPJx+c5D3luxbX5jC25S/t3Oisnbq4G/Dcu7FxK98ejGIgBo2zfrycj8+cQaaBKmODtAHo6lgtQ==
X-Received: by 2002:a17:906:415b:: with SMTP id
 l27mr372418ejk.240.1590486055997; 
 Tue, 26 May 2020 02:40:55 -0700 (PDT)
Received: from x1w.redhat.com (71.red-88-21-204.staticip.rima-tde.net.
 [88.21.204.71])
 by smtp.gmail.com with ESMTPSA id s1sm18337981ejh.81.2020.05.26.02.40.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 May 2020 02:40:55 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 1/2] hw/m68k/mcf5206: Reduce m5206_mbar_read/write() offset
 arg to 16-bit
Date: Tue, 26 May 2020 11:40:51 +0200
Message-Id: <20200526094052.1723-2-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200526094052.1723-1-f4bug@amsat.org>
References: <20200526094052.1723-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::644;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-ej1-x644.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: qemu-trivial@nongnu.org, Thomas Huth <huth@tuxfamily.org>,
 Jason Wang <jasowang@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Thomas Huth <thuth@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

All calls to m5206_mbar_read/m5206_mbar_write are used with
'offset = hwaddr & 0x3ff', so we are sure the offset fits
in 16-bit.

Suggested-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
v3: Use PRIx16
---
 hw/m68k/mcf5206.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/hw/m68k/mcf5206.c b/hw/m68k/mcf5206.c
index b155dd8170..187291e1f6 100644
--- a/hw/m68k/mcf5206.c
+++ b/hw/m68k/mcf5206.c
@@ -273,7 +273,7 @@ static void m5206_mbar_reset(m5206_mbar_state *s)
 }
 
 static uint64_t m5206_mbar_read(m5206_mbar_state *s,
-                                uint64_t offset, unsigned size)
+                                uint16_t offset, unsigned size)
 {
     if (offset >= 0x100 && offset < 0x120) {
         return m5206_timer_read(s->timer[0], offset - 0x100);
@@ -306,11 +306,11 @@ static uint64_t m5206_mbar_read(m5206_mbar_state *s,
     case 0x170: return s->uivr[0];
     case 0x1b0: return s->uivr[1];
     }
-    hw_error("Bad MBAR read offset 0x%x", (int)offset);
+    hw_error("Bad MBAR read offset 0x%"PRIx16, offset);
     return 0;
 }
 
-static void m5206_mbar_write(m5206_mbar_state *s, uint32_t offset,
+static void m5206_mbar_write(m5206_mbar_state *s, uint16_t offset,
                              uint64_t value, unsigned size)
 {
     if (offset >= 0x100 && offset < 0x120) {
@@ -360,7 +360,7 @@ static void m5206_mbar_write(m5206_mbar_state *s, uint32_t offset,
         s->uivr[1] = value;
         break;
     default:
-        hw_error("Bad MBAR write offset 0x%x", (int)offset);
+        hw_error("Bad MBAR write offset 0x%"PRIx16, offset);
         break;
     }
 }
-- 
2.21.3



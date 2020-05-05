Return-Path: <SRS0=1jZz=6T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1990CC47254
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2020 10:00:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D6418206B9
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2020 10:00:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qxeUGu7z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D6418206B9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59638 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVuNO-0007jX-0B
	for qemu-devel@archiver.kernel.org; Tue, 05 May 2020 06:00:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54534)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jVuMh-00078N-0n; Tue, 05 May 2020 05:59:51 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:33422)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jVuMg-0004OJ-0s; Tue, 05 May 2020 05:59:50 -0400
Received: by mail-wm1-x343.google.com with SMTP id v8so2083411wma.0;
 Tue, 05 May 2020 02:59:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=EkplecsBlPPnRuZXHE6e7jrbnG0gHvt4a5C9/IO/Jn4=;
 b=qxeUGu7zd/oq5+AkjIqIIv4AbwIjrr2CS1GlsoHs/2IwErU9jL5p8nTg/rnrOi0+Hs
 era/vVIFq2Fn0c+N/zEgg8RtcjI3rErFOkAiEBhcbRViM9pY9PQoKrr8JtFXnBrPxB8U
 dYAAM/9nOBmwrEvFbBQyFoM4nLYG7/1VTx9juSHRWqUMdHdZ/gMA6KgZiDTjjg1tvx2t
 XzKHmX9ffT/usEqxPNpKfM4MAWSch2o6dp0PgoTGgPQELt66edWS0/Qfzf2nxNiebBy1
 Yjp7ogELJL5Z/wVnCRA6LGvBJPmzzqLHzEk65i4hoi/ziakFo1nSYTjN1ShlVhYApYUp
 Ln9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=EkplecsBlPPnRuZXHE6e7jrbnG0gHvt4a5C9/IO/Jn4=;
 b=MILe16i+DptK7/+FLWuEuzAURVc35F6mFWjonFBt9qoWDZywJx5erJt8HrsiPXdahF
 b5FDpj23jNw4BYkjShFQA9/DPCUXqZbKMV51r+Ck6N2UCiaSLlA1UNUoP5iRHjAZ7Q2N
 DjxmW4zid7nw6648fsAlatkiMc4tax7mEGTDQq4P5Q6wAkGFd7WJcIZRuOOKCsjmF/kF
 UN/lw98uA43UK5vc6vqhNEYFc0ayPwn/k6TJ0YQxYTWmwIGt/cKBQIorkNK3sjDJk4JZ
 3tI3QgwR/mPBVhMDp4aoNWoFpBXuMaXKY27oSog3xBq38jNA0OONbZAb0zGlc4kciuRb
 VK3A==
X-Gm-Message-State: AGi0PubMkZcoPFcJUY2Pj3e5aB8jYlnCijV3gxBvXU+GyqY3I99c3WSE
 CTWFKtc8Ch3aAZJSL9V/FzONryv9
X-Google-Smtp-Source: APiQypKyFJ5xMsui8MoA133za5FCya/SqUJWChQoP18iHA4UA3DilmOORgWEXBb7+n5FKKU0PIWMQQ==
X-Received: by 2002:a05:600c:1008:: with SMTP id
 c8mr2340956wmc.14.1588672787793; 
 Tue, 05 May 2020 02:59:47 -0700 (PDT)
Received: from localhost.localdomain (26.red-88-21-207.staticip.rima-tde.net.
 [88.21.207.26])
 by smtp.gmail.com with ESMTPSA id s17sm2894725wmc.48.2020.05.05.02.59.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 May 2020 02:59:46 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [RFC PATCH] hw/arm/musicpal: Map the UART devices unconditionally
Date: Tue,  5 May 2020 11:59:45 +0200
Message-Id: <20200505095945.23146-1-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::343;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x343.google.com
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Jan Kiszka <jan.kiszka@web.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

I can't find proper documentation or datasheet, but it is likely
a MMIO mapped serial device mapped in the 0x80000000..0x8000ffff
range belongs to the SoC address space, thus is always mapped in
the memory bus.
Map the devices on the bus regardless a chardev is attached to it.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
from 2019... found while doing housekeeping
---
 hw/arm/musicpal.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/hw/arm/musicpal.c b/hw/arm/musicpal.c
index b2d0cfdac8..92f33ed87e 100644
--- a/hw/arm/musicpal.c
+++ b/hw/arm/musicpal.c
@@ -1619,14 +1619,10 @@ static void musicpal_init(MachineState *machine)
                           pic[MP_TIMER2_IRQ], pic[MP_TIMER3_IRQ],
                           pic[MP_TIMER4_IRQ], NULL);
 
-    if (serial_hd(0)) {
-        serial_mm_init(address_space_mem, MP_UART1_BASE, 2, pic[MP_UART1_IRQ],
-                       1825000, serial_hd(0), DEVICE_NATIVE_ENDIAN);
-    }
-    if (serial_hd(1)) {
-        serial_mm_init(address_space_mem, MP_UART2_BASE, 2, pic[MP_UART2_IRQ],
-                       1825000, serial_hd(1), DEVICE_NATIVE_ENDIAN);
-    }
+    serial_mm_init(address_space_mem, MP_UART1_BASE, 2, pic[MP_UART1_IRQ],
+                   1825000, serial_hd(0), DEVICE_NATIVE_ENDIAN);
+    serial_mm_init(address_space_mem, MP_UART2_BASE, 2, pic[MP_UART2_IRQ],
+                   1825000, serial_hd(1), DEVICE_NATIVE_ENDIAN);
 
     /* Register flash */
     dinfo = drive_get(IF_PFLASH, 0, 0);
-- 
2.21.3



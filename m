Return-Path: <SRS0=Dt9u=7G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4630EC433DF
	for <qemu-devel@archiver.kernel.org>; Sun, 24 May 2020 11:06:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0B12A2077D
	for <qemu-devel@archiver.kernel.org>; Sun, 24 May 2020 11:06:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lo3lQdKe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B12A2077D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41892 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jcoSB-0007EG-76
	for qemu-devel@archiver.kernel.org; Sun, 24 May 2020 07:06:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56882)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jcoNl-0002dp-3w; Sun, 24 May 2020 07:01:29 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:43389)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jcoNk-0007ln-7p; Sun, 24 May 2020 07:01:28 -0400
Received: by mail-wr1-x444.google.com with SMTP id i15so14536749wrx.10;
 Sun, 24 May 2020 04:01:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=cAS9vKi2N/HAp/t/0K9X49WNII1M7/uVCyjiDB52u+M=;
 b=lo3lQdKe8TFpxIRIkqXBrjp4OBAQh5+3+uxNafsm/rR7iIx2eVdslobgev+I5n9+ps
 zoLnFI1gGZoEinXkJoCwPR0hB5xX6g39hUFkRYRzaFJOXvxf3zQ6n76ZJEIFr35extP5
 XSvhOFtKPUapkfxCQYYV7BfoJ0nV0dGkB8emVQyTi3QKHo2qTZvDxGsW+bvaRebwR95O
 ZtJ19v6O/ypyMNKjhg1qe7ilKZTbnASqGAPDkiEX5cbn1ulyRKJc8Ef4nUMQcf5V6AIN
 WIuRGkIu4MGTOZLcrSQfYYuJ/8Dn0PlHOog8SsI2EyR+OA2yxJG5KnezIXvlS6ddhWxG
 uzaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=cAS9vKi2N/HAp/t/0K9X49WNII1M7/uVCyjiDB52u+M=;
 b=Dxy0qpKUzlljo399CHns7J6m8VDqQRUOypHIBqiXfuw7pkXJvI+MoJ3To/InwQVZSJ
 jT+h1++VVdKRAcQ0S4Yy3k38dJ0C2u7bb5orbI3/Cai6akUaH+nbqdw1CJ4cvHrwts17
 NqkKaXVYOTLvf4tkPvmyAPJonMpGiWw+1IYlst6MLzdznEP9anUMt/B6w8uBLF1/EbjE
 UzgTtgDHwS/69ccwheGcn+RISlPoecuiRwdKsNTfk4htkkABdWg6c+ZX6p2NPmeQFXem
 ZoVJ5ll/BfVXaAe3+40UECr+Ru45z2nO3OOYxfyexcy7q19lUZnbPdqvIdPmtzhSNDJ9
 oFGw==
X-Gm-Message-State: AOAM531nYwVC5SfwMoIFVb0JdafmgymGOp15RDpiuEaOLKq+tEwpRTeJ
 XBoEkCJeCMsCCiW7Xgo+bFeLDi9ZUbA=
X-Google-Smtp-Source: ABdhPJwOSKNIQrq+4JyXAHkTCsw1WxiJFLhAXmiXwecpskUzlhVtgbSnYzxJSlkmdaRivgIPusj5cQ==
X-Received: by 2002:a5d:5449:: with SMTP id w9mr10883881wrv.106.1590318086193; 
 Sun, 24 May 2020 04:01:26 -0700 (PDT)
Received: from localhost.localdomain (17.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.17])
 by smtp.gmail.com with ESMTPSA id r3sm14321555wmh.48.2020.05.24.04.01.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 24 May 2020 04:01:25 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 2/4] hw/display/cirrus_vga: Use qemu_log_mask(UNIMP) instead
 of debug printf
Date: Sun, 24 May 2020 13:01:19 +0200
Message-Id: <20200524110121.12686-3-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200524110121.12686-1-f4bug@amsat.org>
References: <20200524110121.12686-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::444;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x444.google.com
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
Cc: qemu-trivial@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Replace some debug printf() calls by qemu_log_mask(LOG_UNIMP),
and add a new one in cirrus_linear_bitblt_read().

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/display/cirrus_vga.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/hw/display/cirrus_vga.c b/hw/display/cirrus_vga.c
index 33ccdde000..f9f837b850 100644
--- a/hw/display/cirrus_vga.c
+++ b/hw/display/cirrus_vga.c
@@ -35,6 +35,7 @@
 #include "qemu/osdep.h"
 #include "qemu/module.h"
 #include "qemu/units.h"
+#include "qemu/log.h"
 #include "sysemu/reset.h"
 #include "qapi/error.h"
 #include "trace.h"
@@ -905,9 +906,8 @@ static int cirrus_bitblt_cputovideo(CirrusVGAState * s)
 static int cirrus_bitblt_videotocpu(CirrusVGAState * s)
 {
     /* XXX */
-#ifdef DEBUG_BITBLT
-    printf("cirrus: bitblt (video to cpu) is not implemented yet\n");
-#endif
+    qemu_log_mask(LOG_UNIMP,
+                  "cirrus: bitblt (video to cpu) is not implemented\n");
     return 0;
 }
 
@@ -989,9 +989,8 @@ static void cirrus_bitblt_start(CirrusVGAState * s)
 	 cirrus_blt_mode & (CIRRUS_BLTMODE_MEMSYSSRC |
 			    CIRRUS_BLTMODE_MEMSYSDEST))
 	== (CIRRUS_BLTMODE_MEMSYSSRC | CIRRUS_BLTMODE_MEMSYSDEST)) {
-#ifdef DEBUG_BITBLT
-	printf("cirrus: bitblt - memory-to-memory copy is requested\n");
-#endif
+        qemu_log_mask(LOG_UNIMP,
+                      "cirrus: bitblt - memory-to-memory copy requested\n");
 	goto bitblt_ignore;
     }
 
@@ -2412,6 +2411,9 @@ static uint64_t cirrus_linear_bitblt_read(void *opaque,
 
     /* XXX handle bitblt */
     (void)s;
+    qemu_log_mask(LOG_UNIMP,
+                  "cirrus: linear bitblt is not implemented\n");
+
     return 0xff;
 }
 
-- 
2.21.3



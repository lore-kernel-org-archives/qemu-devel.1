Return-Path: <SRS0=4PQo=7I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B84F6C433E1
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2020 06:26:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7AF0220776
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2020 06:26:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TyjTa/Dj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7AF0220776
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33116 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jdT2W-000428-K8
	for qemu-devel@archiver.kernel.org; Tue, 26 May 2020 02:26:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34246)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jdSzP-0006bj-R8; Tue, 26 May 2020 02:23:03 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:41036)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jdSzP-0002TG-1q; Tue, 26 May 2020 02:23:03 -0400
Received: by mail-wr1-x442.google.com with SMTP id j10so3583918wrw.8;
 Mon, 25 May 2020 23:23:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=cAS9vKi2N/HAp/t/0K9X49WNII1M7/uVCyjiDB52u+M=;
 b=TyjTa/DjX6XKXLJv2jKOeTH3KRs9IkO/poDsu5k8Nndv2RPiiuNSCKRpy1lZcp/O+a
 ip3X+CMdZqolqMlTCEd5t+MMAFL60vkDnI+IWyk+q2p4507J2UNSNcNHbMvB9RYukDPL
 +5qErcgg0ZJ1Zk441ZHSOoxdWuaaO0ltFZp0mk74VQOkfqfh4LhZcHXfskrXQeVnnW3C
 9Lh7GwTNDX0wJruOSYc671TIN7yvi3NOx46n7eKrUV/LhuxiNzW64dDHS9hjzEc78dBr
 kex5/yYV/C7C7XdOQpSDhZsimB1OjaejlHa0eicWy/HZT18WrahpGlJx5AOTFMmdR4SP
 MTYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=cAS9vKi2N/HAp/t/0K9X49WNII1M7/uVCyjiDB52u+M=;
 b=SI3KYVstngmFv/DF7vg489PyUxEY8PMDk6VIDVcOYIN6U1EkfazZPiAYQKopjPOxOr
 29PEKxXQdEggI8uQq0UsNsTcaavdOuY9iNSZI0BmCwmk5mXb4SU7J+z8/twNGy5+avST
 /TpTSYdj6REl/ZoYm81JLrdt7V0SZTtf1nBRguxe+ppEpkw5NzHW0KfumydMPHsgl7+5
 dcjDSo8TrFsErweBAKE8Dn66PbGz6fchFhL/Xh2FiLdWnl2S1c8Gj71D+cc2T+JU5k8o
 2GRL+4bm0WuLl8v9C8ygDNSksxq8yA5bZV5VoG6+k5c/9Vy0PacxxsJLg3GBDiSQqMvO
 0zGQ==
X-Gm-Message-State: AOAM531ivOhFQ9iDEJxECBD66Ne/gAZtO5ejkbG5LKks+GH4u3z+rjfn
 kmBVEzA97SJ8bIwfzC3M3BCqYNpYVvQ=
X-Google-Smtp-Source: ABdhPJwqo1VwsKLgqyHXTUMsC53fzvBqxGIRb8oyMDkrnso26nRZzkOFIxid2kGorFJHMkKqIkRoHg==
X-Received: by 2002:adf:ea11:: with SMTP id q17mr16484093wrm.75.1590474181081; 
 Mon, 25 May 2020 23:23:01 -0700 (PDT)
Received: from localhost.localdomain (71.red-88-21-204.staticip.rima-tde.net.
 [88.21.204.71])
 by smtp.gmail.com with ESMTPSA id a16sm5764745wrx.8.2020.05.25.23.22.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 May 2020 23:23:00 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: Gerd Hoffmann <kraxel@redhat.com>,
	qemu-devel@nongnu.org
Subject: [PATCH 04/14] hw/display/cirrus_vga: Use qemu_log_mask(UNIMP) instead
 of debug printf
Date: Tue, 26 May 2020 08:22:42 +0200
Message-Id: <20200526062252.19852-5-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200526062252.19852-1-f4bug@amsat.org>
References: <20200526062252.19852-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::442;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x442.google.com
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-trivial@nongnu.org,
 Alistair Francis <alistair@alistair23.me>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Igor Mitsyanko <i.mitsyanko@gmail.com>, qemu-arm@nongnu.org,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
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



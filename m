Return-Path: <SRS0=4PQo=7I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB0A3C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2020 06:30:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 828E92073B
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2020 06:30:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cj+Z5OJD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 828E92073B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47430 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jdT6v-0001al-N2
	for qemu-devel@archiver.kernel.org; Tue, 26 May 2020 02:30:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34274)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jdSzX-0006wN-0s; Tue, 26 May 2020 02:23:11 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:37646)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jdSzW-0002UQ-88; Tue, 26 May 2020 02:23:10 -0400
Received: by mail-wr1-x442.google.com with SMTP id x13so4549745wrv.4;
 Mon, 25 May 2020 23:23:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Yn9oNpTD/XdTf2DEjAkyFUg8dJuNz3jGF81w8HFPrT8=;
 b=Cj+Z5OJDXje6OrxIPtC/pOTk/A8GILcMS8bEqcnmQs8Xd7Bt4SdPNteB3iLgzsCTYr
 0r907ofrtp2JZkANGLQ85LK+xQWP4leINpXeqTSvND/KOIw3jpIT87ISFVZI9+fDKdKd
 jH361tcM8Rv52EfgDlMbSUX/cDiKplWsPfAdX9zje740JI20TzsLsAZuIXqvhi/YXUkN
 5JSmipdY2jv5dAx5s/69+CH11WnUGYMkdaC8kEkw3iFTIM3cWhXHeFLg+MRBRskPC/uW
 mIOcuSmhxUtVNcDZHVix6+Y224wF2qTdPmnWk9h9298Kp/j2igjMfOrZJy7CoJHjcDVe
 WDRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=Yn9oNpTD/XdTf2DEjAkyFUg8dJuNz3jGF81w8HFPrT8=;
 b=FIA6A9yBCtfpfRWipcgG/E2WIWPBt+a10v9UJgR7eT3BggzqbWxuZetJm2xmsrpT9L
 YYgeYWwycxBUEczWtArChFzUcCpQL8QxXhpAH0A/CD6vTY8j9qp42+kb0nDlBbpJZ2sA
 kwi5MlR/vZfNvEZnFokNAt9IH1qJsWbHvEdj1Pxv2PyWQX5buxGPV1epWg7337MSKUAk
 mvaaXk3tpeYfv54Nlr3mHKiw4+aIws0P9qaChsCWsrDlQkSohn+1dzHhNMbEIjNOOeg7
 cab5qJFAfa6YCkT9GelAFJjKdVjP+w7MubPCQz0NOwbxJUg42ki0NDCMhRV8DHSMSYYo
 o4zQ==
X-Gm-Message-State: AOAM533z+NSFCLBPHAhYXOfd+OU91HJhyRdQJMW97K33lXr/mv7wFfqV
 wr/QaC/oUkX/M3sgVK/i6KE=
X-Google-Smtp-Source: ABdhPJyQJgC6Im2iv6SQVJj2fCbaI66cdfGMaddDYp+LZ4U/gYJTfm6gbgqaaX/CdSYHYNLtg+XW2g==
X-Received: by 2002:adf:92c1:: with SMTP id 59mr4016354wrn.401.1590474188282; 
 Mon, 25 May 2020 23:23:08 -0700 (PDT)
Received: from localhost.localdomain (71.red-88-21-204.staticip.rima-tde.net.
 [88.21.204.71])
 by smtp.gmail.com with ESMTPSA id a16sm5764745wrx.8.2020.05.25.23.23.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 May 2020 23:23:07 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: Gerd Hoffmann <kraxel@redhat.com>,
	qemu-devel@nongnu.org
Subject: [PATCH 09/14] hw/display/xlnx_dp: Replace disabled DPRINTF() by
 error_report()
Date: Tue, 26 May 2020 08:22:47 +0200
Message-Id: <20200526062252.19852-10-f4bug@amsat.org>
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

DPRINTF() calls are disabled by default, so when unexpected
data is used, the whole process abort without information.

Display a bit of information with error_report() before crashing.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/display/xlnx_dp.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/hw/display/xlnx_dp.c b/hw/display/xlnx_dp.c
index 3e5fb44e06..8d940cd8d1 100644
--- a/hw/display/xlnx_dp.c
+++ b/hw/display/xlnx_dp.c
@@ -1,5 +1,5 @@
 /*
- * xlnx_dp.c
+ * Xilinx Display Port
  *
  *  Copyright (C) 2015 : GreenSocs Ltd
  *      http://www.greensocs.com/ , email: info@greensocs.com
@@ -24,6 +24,7 @@
 
 #include "qemu/osdep.h"
 #include "qapi/error.h"
+#include "qemu/error-report.h"
 #include "qemu/log.h"
 #include "qemu/module.h"
 #include "hw/display/xlnx_dp.h"
@@ -465,7 +466,7 @@ static uint8_t xlnx_dp_aux_pop_tx_fifo(XlnxDPState *s)
     uint8_t ret;
 
     if (fifo8_is_empty(&s->tx_fifo)) {
-        DPRINTF("tx_fifo underflow..\n");
+        error_report("%s: TX_FIFO underflow", __func__);
         abort();
     }
     ret = fifo8_pop(&s->tx_fifo);
@@ -525,6 +526,7 @@ static void xlnx_dp_aux_set_command(XlnxDPState *s, uint32_t value)
         qemu_log_mask(LOG_UNIMP, "xlnx_dp: Write i2c status not implemented\n");
         break;
     default:
+        error_report("%s: invalid command: %u", __func__, cmd);
         abort();
     }
 
@@ -631,8 +633,8 @@ static void xlnx_dp_change_graphic_fmt(XlnxDPState *s)
         s->g_plane.format = PIXMAN_b8g8r8;
         break;
     default:
-        DPRINTF("error: unsupported graphic format %u.\n",
-                s->avbufm_registers[AV_BUF_FORMAT] & DP_GRAPHIC_MASK);
+        error_report("%s: unsupported graphic format %u", __func__,
+                     s->avbufm_registers[AV_BUF_FORMAT] & DP_GRAPHIC_MASK);
         abort();
     }
 
@@ -647,8 +649,8 @@ static void xlnx_dp_change_graphic_fmt(XlnxDPState *s)
         s->v_plane.format = PIXMAN_x8b8g8r8;
         break;
     default:
-        DPRINTF("error: unsupported video format %u.\n",
-                s->avbufm_registers[AV_BUF_FORMAT] & DP_NL_VID_FMT_MASK);
+        error_report("%s: unsupported video format %u", __func__,
+                     s->avbufm_registers[AV_BUF_FORMAT] & DP_NL_VID_FMT_MASK);
         abort();
     }
 
-- 
2.21.3



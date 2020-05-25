Return-Path: <SRS0=XKWp=7H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C0B7C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 25 May 2020 03:50:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1BDDD2075F
	for <qemu-devel@archiver.kernel.org>; Mon, 25 May 2020 03:50:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YTsJ8e0+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1BDDD2075F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33854 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jd47r-0005J9-AC
	for qemu-devel@archiver.kernel.org; Sun, 24 May 2020 23:50:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46682)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jd432-0008Dw-LQ; Sun, 24 May 2020 23:45:39 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:46260)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jd431-0006w4-VW; Sun, 24 May 2020 23:45:08 -0400
Received: by mail-wr1-x443.google.com with SMTP id x6so2180951wrm.13;
 Sun, 24 May 2020 20:45:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Yn9oNpTD/XdTf2DEjAkyFUg8dJuNz3jGF81w8HFPrT8=;
 b=YTsJ8e0+PTxDbvUYE2ayqqzJip9j1uODs7C7J3amq7FdME6qeXgAN8sFwd30G4vVM7
 SwME9glYze7P5MbFUtRbudCApwsS27/8GBrW45Lc6P7mBYA00mrY9f0q4ZtiLL2R25OQ
 MAST4CMEc95IKuQXRisfiilTtQRe9ZtFaBBWAvv2wwq7EUKFA9xbrhpZPNrrtiTOMyVX
 Qiht6UCHCUXoYjoznACgoUywGuk+tDGGmZ6YrRabRlo6MT49DbpX2cQMazknpc8yvPlD
 j4Y4hul/v0+NJBNWJK8VMdSooE80FwX9hgBtQPaqWoWNPJPAiTzE7/kKJOfxw1hlJGaz
 apDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=Yn9oNpTD/XdTf2DEjAkyFUg8dJuNz3jGF81w8HFPrT8=;
 b=MG/i1aeLqTa2/iAtIyjEwLY3dvQ0cRJFWWm6ONL3s8MeICVpcGHGj2hGBWv0MGFEdN
 kGhWQ9xxLU+/S4dfUIzglRXBFioEwKEew55eHvelPc1Ls+OMyaJokJsyvfGX7TmNY8NO
 gvZuHbgJV1kY4FYneTaWCN4pywcYuafGJN2QR2ItvD6EFdOuUloimgrBHLU6oeydpcIZ
 7wtyUzrccz3gbQtqfw+GTr/qHTTZ1QcpRMexLciBuYeiMoEvRGtN9k38CeXRqvPApw5H
 8yrT+4ZJhynHN/F1+UyfH/4UVthIKtUUpFt+Tv23Vmj8hfmse2UTmphCrERt4ozOb3iF
 1CcQ==
X-Gm-Message-State: AOAM530Gtuw3Fj34sF8YqDoAFrh2281xh4OBq+rvwm6oKMvkRsuSi6FP
 tAanUWXzxPRAAYuJOaCCFn3LS5QxWTw=
X-Google-Smtp-Source: ABdhPJyiCthpzx/WxWavDLvMR+ZuI38xNOQeNonAuLrUqrPZT4EuVstmP8dWIEyT94wtvISf/TVAWA==
X-Received: by 2002:a5d:52c6:: with SMTP id r6mr9244142wrv.269.1590378305788; 
 Sun, 24 May 2020 20:45:05 -0700 (PDT)
Received: from localhost.localdomain (71.red-88-21-204.staticip.rima-tde.net.
 [88.21.204.71])
 by smtp.gmail.com with ESMTPSA id n9sm17555150wmj.5.2020.05.24.20.45.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 24 May 2020 20:45:05 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 4/4] hw/display/xlnx_dp: Replace disabled DPRINTF() by
 error_report()
Date: Mon, 25 May 2020 05:44:59 +0200
Message-Id: <20200525034459.28535-5-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200525034459.28535-1-f4bug@amsat.org>
References: <20200525034459.28535-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::443;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x443.google.com
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
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 qemu-arm@nongnu.org, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
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



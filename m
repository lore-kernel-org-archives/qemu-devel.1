Return-Path: <SRS0=atk5=B7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61AB8C433E1
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 17:48:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2F3ED20702
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 17:48:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b/bdVI6B"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F3ED20702
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59918 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k9B9r-00081C-FH
	for qemu-devel@archiver.kernel.org; Fri, 21 Aug 2020 13:48:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57606)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1k9ArX-0001vT-Bx; Fri, 21 Aug 2020 13:29:59 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d]:40002)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1k9ArV-0001H4-14; Fri, 21 Aug 2020 13:29:58 -0400
Received: by mail-wm1-x32d.google.com with SMTP id k20so2553034wmi.5;
 Fri, 21 Aug 2020 10:29:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=l6Svpz1zFgu3rW3hNJEs7xxdWfxftjayMdaBJY3QTHs=;
 b=b/bdVI6BmoT9zR6l2THzuwd6jo381NwqczDg7GfTuRvYrwWr4j5s6PDlgurFxwAKu1
 h4KX5KuoOe6CCGkTryy4UDrKPAQPvWCtYmHw9IYCFNJRzfornJce1HMfnjus9us2YM+q
 KBAHWqZVwQ98C5bzfLk+sGlTyXg0T0nNB6czmQV2ygH08Y/07D+bp0KezGBpnXNHDIwS
 nFvaCRwKoio/AFFyMbBltmLC4BiKkUQzNMfFY+tS9xlIXP1NfF6oOVb1/VYNaYdV2X1/
 rVyZzxTUobirV1SStB+YoaJg48PfQfYbJSoU7FNW7YdbG4TwLeM5J0Da2WhisOQu0Btr
 Avtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=l6Svpz1zFgu3rW3hNJEs7xxdWfxftjayMdaBJY3QTHs=;
 b=SQXxrk6dYAdejlIMRFYrSY+4au400bb9GG7Dh7whOVmE4xaNFoFyjKjtKMPY/x+Zbw
 /TuozJYjc1aFkkULwAktAc6Ir/49Kb6cBdoNJsqKPPBSglIJ+xEYUVx6/oIMijFyzziM
 d1AtTnFqPLvlG4cWtRd078Ty6UWn8FNJt21r/VRef1LpBW1dp24IlQgXT1ukEtYSrzkr
 nvFmDv7BPTXEzFr20/BKn53YDz9ydGd5lGHiEjOaTsaaa3oVL6yuhw/vEmAXMX5ebWxl
 BpYIQu2dcjdtvif2Hf/uGhGQw9eDlEJD+nGmA0+XbCqRCx9vYxOEcJn4NaA7hBvb67LI
 ykxg==
X-Gm-Message-State: AOAM532V0f466mDNUikHfUUxQx3viHn0VsMXVX67q0y9HXDad7grJhrA
 cBXmyCNo963Cw0al+U+EAwAOEvv8DXU=
X-Google-Smtp-Source: ABdhPJwQpHIg1LMSejO2yqn/omEVev3KClz0r5g/zOycenPE+TllxFDPy9t4oYUgBGuX7Uz7TELGmg==
X-Received: by 2002:a7b:c40b:: with SMTP id k11mr4208451wmi.19.1598030994911; 
 Fri, 21 Aug 2020 10:29:54 -0700 (PDT)
Received: from localhost.localdomain (121.red-81-40-121.staticip.rima-tde.net.
 [81.40.121.121])
 by smtp.gmail.com with ESMTPSA id 32sm5315471wrn.86.2020.08.21.10.29.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Aug 2020 10:29:54 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PULL 23/23] hw/sd: Correct the maximum size of a Standard Capacity
 SD Memory Card
Date: Fri, 21 Aug 2020 19:29:16 +0200
Message-Id: <20200821172916.1260954-24-f4bug@amsat.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200821172916.1260954-1-f4bug@amsat.org>
References: <20200821172916.1260954-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x32d.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-block@nongnu.org,
 Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Bin Meng <bin.meng@windriver.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Andrew Baumann <Andrew.Baumann@microsoft.com>,
 Beniamino Galvani <b.galvani@gmail.com>, Michael Walle <michael@walle.cc>,
 qemu-arm@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Bin Meng <bin.meng@windriver.com>

Per the SD spec, Standard Capacity SD Memory Card (SDSC) supports
capacity up to and including 2 GiB.

Fixes: 2d7adea4fe ("hw/sd: Support SDHC size cards")
Signed-off-by: Bin Meng <bin.meng@windriver.com>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Tested-by: Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>
Message-Id: <1598021136-49525-2-git-send-email-bmeng.cn@gmail.com>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/sd/sd.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index 805e21fc883..483c4f17204 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -51,6 +51,8 @@
 
 //#define DEBUG_SD 1
 
+#define SDSC_MAX_CAPACITY   (2 * GiB)
+
 typedef enum {
     sd_r0 = 0,    /* no response */
     sd_r1,        /* normal response command */
@@ -314,7 +316,7 @@ static void sd_ocr_powerup(void *opaque)
     /* card power-up OK */
     sd->ocr = FIELD_DP32(sd->ocr, OCR, CARD_POWER_UP, 1);
 
-    if (sd->size > 1 * GiB) {
+    if (sd->size > SDSC_MAX_CAPACITY) {
         sd->ocr = FIELD_DP32(sd->ocr, OCR, CARD_CAPACITY, 1);
     }
 }
@@ -386,7 +388,7 @@ static void sd_set_csd(SDState *sd, uint64_t size)
     uint32_t sectsize = (1 << (SECTOR_SHIFT + 1)) - 1;
     uint32_t wpsize = (1 << (WPGROUP_SHIFT + 1)) - 1;
 
-    if (size <= 1 * GiB) { /* Standard Capacity SD */
+    if (size <= SDSC_MAX_CAPACITY) { /* Standard Capacity SD */
         sd->csd[0] = 0x00;	/* CSD structure */
         sd->csd[1] = 0x26;	/* Data read access-time-1 */
         sd->csd[2] = 0x00;	/* Data read access-time-2 */
-- 
2.26.2



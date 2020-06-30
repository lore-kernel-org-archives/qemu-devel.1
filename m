Return-Path: <SRS0=gXk/=AL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60364C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 13:50:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2A89B206BE
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 13:50:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cAIOek2+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A89B206BE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37828 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqGeD-0003G1-Bx
	for qemu-devel@archiver.kernel.org; Tue, 30 Jun 2020 09:50:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35090)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jqGTz-0001KO-SS; Tue, 30 Jun 2020 09:39:31 -0400
Received: from mail-ed1-x544.google.com ([2a00:1450:4864:20::544]:41732)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jqGTy-0006Kw-7Q; Tue, 30 Jun 2020 09:39:31 -0400
Received: by mail-ed1-x544.google.com with SMTP id e22so16227400edq.8;
 Tue, 30 Jun 2020 06:39:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=/74ZOEVtWoI92Rhuv9NWA62JHOdD9/euQUb+Sj4+JZg=;
 b=cAIOek2+VUlEPq6VZObms5zcks/UNF8orPh7ODrxUf93whGbPppvaEOUNBNgIjVtwb
 RnJJj+a10P+abz3HB4QjiMILLCTSI24rjITO7ftpDHypTR8DOiiEcibRZZt63Ilqzcba
 EobA8YDO+yZG1yEm4piNn/Bbt9tvLnQxlkwuBMAE1gcDJB0zwm3+zh2Bf7IKS82auT89
 4tNgB4vnS92LOGUAcEsCY+Idnu32vr336tODo/LknvGOGYBvtHLoTqH3HWaOcSL4/W+Y
 Q+Xrr+Ut4rtN0OEpHOQO01B/+3pGd+Ea9uwi90XJC4B8M1rLH8Y84C5XM6azBvUnbzbV
 NB5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=/74ZOEVtWoI92Rhuv9NWA62JHOdD9/euQUb+Sj4+JZg=;
 b=MOhs38O//AeCM+oZzqMGvwtyEhg7+NrVeWoJoi3Do83A6Y4WtOCXmxySHLCcYjb+k3
 TSGgPF0BM37AUPaVZBsHvRXjRRQwLZolHJCt6fBn2VVdDyLMGHXV2/XN77eHssU8k+X+
 Tk2+rKmL7/jz85ieYo/SpwYx+V8/d+4L4Aus4yKTNPHieERTO+MjJr250+on3LeudPEx
 eqfxCBbzPAZyg46GHr0k2e2vcOMuT4vSVyrMaDSW/G6X2PtQg7pw2dJBed5x/D9mNP9m
 O9P3jkqFaSqPakEPZQLaSMcbsG35Dx9E0b30g6hLZvktDC8PT4+6vPgLELaUP5vG0Zc+
 oIsg==
X-Gm-Message-State: AOAM533ngooLykBgIBsC9sCcHx8lRu1YaM97Casva4Iq9W1BamjXwOY1
 Oprh8y6Tm8u59LvEdX5jJ47si8jzmxk=
X-Google-Smtp-Source: ABdhPJwmVWhsHgXMGS5UDv329YVKJlrZm5l0XYS5jrAFMnCZIJaBqp9mxejIJt6y33aYA1cAzbYKoQ==
X-Received: by 2002:aa7:c442:: with SMTP id n2mr13672084edr.309.1593524368446; 
 Tue, 30 Jun 2020 06:39:28 -0700 (PDT)
Received: from x1w.redhat.com (1.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.1])
 by smtp.gmail.com with ESMTPSA id p18sm2099172ejm.55.2020.06.30.06.39.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Jun 2020 06:39:27 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v7 13/17] hw/sd/sdcard: Constify sd_crc*()'s message argument
Date: Tue, 30 Jun 2020 15:39:07 +0200
Message-Id: <20200630133912.9428-14-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200630133912.9428-1-f4bug@amsat.org>
References: <20200630133912.9428-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::544;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-ed1-x544.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

CRC functions don't modify the buffer argument,
make it const.

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/sd/sd.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index 2946fe3040..364a6d1fcd 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -255,11 +255,11 @@ static const int sd_cmd_class[SDMMC_CMD_MAX] = {
     7,  7, 10,  7,  9,  9,  9,  8,  8, 10,  8,  8,  8,  8,  8,  8,
 };
 
-static uint8_t sd_crc7(void *message, size_t width)
+static uint8_t sd_crc7(const void *message, size_t width)
 {
     int i, bit;
     uint8_t shift_reg = 0x00;
-    uint8_t *msg = (uint8_t *) message;
+    const uint8_t *msg = (const uint8_t *)message;
 
     for (i = 0; i < width; i ++, msg ++)
         for (bit = 7; bit >= 0; bit --) {
@@ -271,11 +271,11 @@ static uint8_t sd_crc7(void *message, size_t width)
     return shift_reg;
 }
 
-static uint16_t sd_crc16(void *message, size_t width)
+static uint16_t sd_crc16(const void *message, size_t width)
 {
     int i, bit;
     uint16_t shift_reg = 0x0000;
-    uint16_t *msg = (uint16_t *) message;
+    const uint16_t *msg = (const uint16_t *)message;
     width <<= 1;
 
     for (i = 0; i < width; i ++, msg ++)
-- 
2.21.3



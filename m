Return-Path: <SRS0=ZyMj=EB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E34FEC4363A
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 11:13:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6452622263
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 11:13:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dzfljq8f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6452622263
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34158 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kX0Rh-0004cw-2m
	for qemu-devel@archiver.kernel.org; Mon, 26 Oct 2020 07:13:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54246)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kX0Hq-0008Hm-Q9; Mon, 26 Oct 2020 07:03:40 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434]:38099)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kX0Hm-0002fn-4l; Mon, 26 Oct 2020 07:03:35 -0400
Received: by mail-wr1-x434.google.com with SMTP id n18so11898877wrs.5;
 Mon, 26 Oct 2020 04:03:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=3PqeCvMaRSfOqr/6xhOfmbV28LZjwldqha7vO+7WnUc=;
 b=Dzfljq8fBMOykHo/ksRTTp5iGGkuIy5dPJHu6b4p5BLmM4tyMbfIvgS6BwRBgId/6l
 ImdPHDmN4/Uu4EV++mPxvJScZZpf3VcKyU8DlSJBxRMham/HvasbhKW2wvtLmgAcE/Tk
 755Va/3x+YMrTaD35I+JHNuL35h0h3m/joSMHZZ9XmsPiG976L0+nnpDj08yKUfuvrhr
 fDDTTo66XCptH8gO5oI29S6m0kWBOXnU+F/3wBbnW8TzUBzzmg8ou3HhFxLi3VHomkiq
 swF6F+GOr7NHDKgJfyFRJxk6cjbv6+bN42MKhsSLm6HPvo3KOMdFDN3NnA/IBQsmvRxw
 1KfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=3PqeCvMaRSfOqr/6xhOfmbV28LZjwldqha7vO+7WnUc=;
 b=sP0Xvkfq74HYlA4BmFHaZODPZW3D7nAyqc1wzFiBJ4v3Wc71kfijlxx7Nf3fZTWd32
 g8vlTbGSXDOJnOgBbcd8IE9ghF/IOQP76ok5ENOxG1svs/+aAwxh2TXXemyN31MrmyH3
 dL7IWtGKtJ6Jj2F8WdSoPV+CaqDtj+XubgV+3YY5oOuKPXq1OBxC2b1e1JPQ3F19w307
 xJ4Go+ydZ/vc+lEp+cKdtcFdElu8zH3zvVhlFuWDM7cdSo54vOeedd1nYi5tyHLbwDG1
 5OF7slZtzrPLYGCDcbyYAmEypgz53ivmxR9EYeZQR6Mi1c0XUYlnFTabrBcxq5eG+1ln
 gZUA==
X-Gm-Message-State: AOAM533+cSdLvSAjKHBA4jH1J6PSZaf8Uv+8ji3MfQSDHS7UKw65mHTg
 VfowuC4jfURxwd+hrD9YMDM/xrCKxAg=
X-Google-Smtp-Source: ABdhPJxXPyQANOS53JmNBde6/D2k8al9tvWCuQLC+USjzFwj6ItTzX25RiIhbfb1ulBKL8GLsWuq6w==
X-Received: by 2002:adf:ee4c:: with SMTP id w12mr16429071wro.22.1603710212265; 
 Mon, 26 Oct 2020 04:03:32 -0700 (PDT)
Received: from localhost.localdomain (237.red-88-18-140.staticip.rima-tde.net.
 [88.18.140.237])
 by smtp.gmail.com with ESMTPSA id d129sm20226273wmf.19.2020.10.26.04.03.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Oct 2020 04:03:31 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PULL 3/5] hw/sd/sdcard: Constify sd_crc*()'s message argument
Date: Mon, 26 Oct 2020 12:03:13 +0100
Message-Id: <20201026110315.4026183-4-f4bug@amsat.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201026110315.4026183-1-f4bug@amsat.org>
References: <20201026110315.4026183-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x434.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.249,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

CRC functions don't modify the buffer argument,
make it const.

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Message-Id: <20200630133912.9428-14-f4bug@amsat.org>
---
 hw/sd/sd.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index 5510a64401b..aa6059d2ad6 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -254,11 +254,11 @@ static const int sd_cmd_class[SDMMC_CMD_MAX] = {
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
@@ -270,11 +270,11 @@ static uint8_t sd_crc7(void *message, size_t width)
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
2.26.2



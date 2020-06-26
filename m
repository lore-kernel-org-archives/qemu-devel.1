Return-Path: <SRS0=ZkAM=AH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7555C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 16:34:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 71153207D8
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 16:34:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZZxJPx41"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 71153207D8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47278 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jorJU-0006fN-D9
	for qemu-devel@archiver.kernel.org; Fri, 26 Jun 2020 12:34:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54200)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jorDP-0005ep-Eb; Fri, 26 Jun 2020 12:28:35 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:47036)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jorDO-0003M7-02; Fri, 26 Jun 2020 12:28:35 -0400
Received: by mail-wr1-x442.google.com with SMTP id r12so10025024wrj.13;
 Fri, 26 Jun 2020 09:28:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=JbDqgfPHpizj2Xr97jabygp2Vi8eQjOpNs5caV4op9Q=;
 b=ZZxJPx41H/UkyyTgJmq9CsOhjw9pZVvtam7IX/v4TM7ifyEbYVMWIjowqONG6Iu96E
 vNne6Q3HWHDYEZ1xa+uzMLplzXCLZc4PGgHpvG+AVOiL+1+uEm+DNy1QdeGi0ENG75oI
 /jec3YSsxJ+HkCkNmjRo0wr2FUkVJ51fE97KJmn9698MjrjFaHouggf6bBLYtEFSi+av
 J8wcZCMMSDruu4rQG+I1+sfLr8n3KZHjg98mo5Ka7YSlfFWLnXTLlRsuFBSrrQ2mTQHA
 WNLDBf9mqlsuM9uqPqEb5mjdD7V60O3a+Rrmjk1YXNI/yQN1Fifinjuv3HXdm2EkNLlv
 2QlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=JbDqgfPHpizj2Xr97jabygp2Vi8eQjOpNs5caV4op9Q=;
 b=ASYNN1r2AGFlp+8xBrl6xuBd5LtOjGAiYdtNLVmjqalKiCnN141fqZr7OB5qRelDcz
 b83dbgpYNjeuxSnp4G/c1TxsnewQPxMj0l5p5bfAXYOqkN6a1yNaHQ+LozIkguO8BiuG
 vRF17G2JMwyWh0P9+Vzj+BiypYnkE5c3pbm6um/MVOV/eWilexqdMgzm2lqs+IIUBpXZ
 KCNdRH8F9huOYPEl42GJOIBL/lJl5Y/qfzKnDf2AZk6hZqtFAvG0uBVlJkkjxNjPiSGN
 TUrXTfFBl/uE1R1wcqseB5Zd2iQATeqDUoROKurSFG8yFYuy0XXRl//6ApXweCfH/+YU
 U9uw==
X-Gm-Message-State: AOAM530uD0+copJp/cS68E82c25/n17XRC5K4vus4R4Olmt6AI7L+LWx
 kk5Q3RnXZy17eC1TggIBJd3X/nU2
X-Google-Smtp-Source: ABdhPJwPpDsDCj1k8H5EKnGvTCUUHTsCVV0utlAE0FFIAmbmtRo4I636sFB2cps9EmDC8SU8+3Ou4A==
X-Received: by 2002:a5d:630d:: with SMTP id i13mr4671593wru.208.1593188912169; 
 Fri, 26 Jun 2020 09:28:32 -0700 (PDT)
Received: from localhost.localdomain (1.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.1])
 by smtp.gmail.com with ESMTPSA id 12sm4867255wmg.6.2020.06.26.09.28.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Jun 2020 09:28:31 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 10/14] hw/sd/sdcard: Constify sd_crc*()'s message argument
Date: Fri, 26 Jun 2020 18:28:14 +0200
Message-Id: <20200626162818.25840-11-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200626162818.25840-1-f4bug@amsat.org>
References: <20200626162818.25840-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::442;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x442.google.com
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
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 qemu-block@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
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
index b887dce0e1..a0500f4551 100644
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



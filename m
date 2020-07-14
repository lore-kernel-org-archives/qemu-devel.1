Return-Path: <SRS0=DUFB=AZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 886D2C433E3
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2020 14:05:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5894A222C8
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2020 14:05:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I6pAIttM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5894A222C8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42098 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jvLZ3-0006Rx-Na
	for qemu-devel@archiver.kernel.org; Tue, 14 Jul 2020 10:05:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35018)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jvLS0-0004Ej-0c; Tue, 14 Jul 2020 09:58:28 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430]:33381)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jvLRy-0003Ri-Bv; Tue, 14 Jul 2020 09:58:27 -0400
Received: by mail-wr1-x430.google.com with SMTP id f18so21795698wrs.0;
 Tue, 14 Jul 2020 06:58:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=NesnoNVp8mV726mwx9/wPWtnd6LQdD+PlLDlGLZ9HWI=;
 b=I6pAIttMUqG98BijImPqRzKmcrSjPxvRWNG2VWuXWiMOHZr8UsKxnIZKzBaumPvIHK
 3VUKjJQ3ZjXYj4V5RQ4F6OO9FD4cdR0w7k7FlwhV4MLiewVtYXXvdcQ1j0od3e9b9abc
 YM8YxpUlxidF2I2PS2AmI2RxUNaSLXp1Che6Kr0RI/tYvUBiEn8iHeDLZkXQQIsFQhV9
 Np72SxihJgRyxOecDmQvDxX8BK8gQK/CFNSee1Dv0eAwLEBPmH/GoUGjAUHEs6VtnMeE
 R7RoxziprebmQOvAAdUdwJP2EFBXWPOSImd7ZxsRnQUOxoBdy/KaJRxr0n/7D3d0bthD
 QVzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=NesnoNVp8mV726mwx9/wPWtnd6LQdD+PlLDlGLZ9HWI=;
 b=iRMnItcrAbpHqaNl4+M4H6rFndWY5xzfEsCuHEcSM58ja5ugP1gpt5oIMShH6zneFY
 BGYcbIXlz4Op4UByojprWfhhZWqhJj3uZss6xAwvJJ9oTXFakz2Jwu3EUFnF5b8dqpv8
 OGl6tBOOnXjlOawgpDtxdya1MfsXA5RZFUGM1o8Xcr7T0m20pWuuSuDPBnWASl77EkUB
 yRxjGPQ2VuRn1CHs2yNa/h4jSgB9F3B4utYmIxqjaPUWtuoLiVvGaQ/5L29MDAoktnok
 Z7BeAILeAKDZCGBsb6JGgWQwOyi0LOUrX076xtdKfmf7OrSI4dKj1ihZy6E8gPIrI/8g
 O4VA==
X-Gm-Message-State: AOAM532iErHFjButma+EBE1zFO77XiCtwSWVP2hAGBgPuTat1ymffyQC
 j0yFCIPzZEFYOVzgXVmOo+aFVtVI5Es=
X-Google-Smtp-Source: ABdhPJyN+lvL+athT0CXrcnfjGhVJt2CDbAdXkR2mAm2I4kWR+XepSiklRqASrecGHaFZC3HyChTmw==
X-Received: by 2002:adf:c3c7:: with SMTP id d7mr5535242wrg.51.1594735104542;
 Tue, 14 Jul 2020 06:58:24 -0700 (PDT)
Received: from localhost.localdomain
 (138.red-83-57-170.dynamicip.rima-tde.net. [83.57.170.138])
 by smtp.gmail.com with ESMTPSA id k14sm29145343wrn.76.2020.07.14.06.58.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Jul 2020 06:58:23 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PULL 6/9] hw/sd/sdcard: Simplify realize() a bit
Date: Tue, 14 Jul 2020 15:58:11 +0200
Message-Id: <20200714135814.19910-7-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200714135814.19910-1-f4bug@amsat.org>
References: <20200714135814.19910-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x430.google.com
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
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Prasad J Pandit <ppandit@redhat.com>, Alexander Bulekov <alxndr@bu.edu>,
 Alistair Francis <alistair.francis@wdc.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We don't need to check if sd->blk is set twice.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-Id: <20200630133912.9428-18-f4bug@amsat.org>
---
 hw/sd/sd.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index 1cc16bfd31..edd60a09c0 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -2105,12 +2105,12 @@ static void sd_realize(DeviceState *dev, Error **errp)
         return;
     }
 
-    if (sd->blk && blk_is_read_only(sd->blk)) {
-        error_setg(errp, "Cannot use read-only drive as SD card");
-        return;
-    }
-
     if (sd->blk) {
+        if (blk_is_read_only(sd->blk)) {
+            error_setg(errp, "Cannot use read-only drive as SD card");
+            return;
+        }
+
         ret = blk_set_perm(sd->blk, BLK_PERM_CONSISTENT_READ | BLK_PERM_WRITE,
                            BLK_PERM_ALL, errp);
         if (ret < 0) {
-- 
2.21.3



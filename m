Return-Path: <SRS0=tSBD=YP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F66BCA9EA0
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2019 13:54:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DB2A92184C
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2019 13:54:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AeKXDNb+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB2A92184C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57794 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iMubt-0002eI-IF
	for qemu-devel@archiver.kernel.org; Tue, 22 Oct 2019 09:54:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37217)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iMuHU-0003TV-Do
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 09:33:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iMuHT-0001c5-7b
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 09:33:00 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:33285)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iMuHT-0001bn-1b
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 09:32:59 -0400
Received: by mail-wm1-x341.google.com with SMTP id 6so3707928wmf.0
 for <qemu-devel@nongnu.org>; Tue, 22 Oct 2019 06:32:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=mHOfSzeg99iHQUMRCgLtiz+W3r24W00ST4fut/Vk9N4=;
 b=AeKXDNb+/JPvn7em9LceA1KRRhxCZcVj6KjATbNIwZh3JDA7dQFwAhFsgNzPpZgp0z
 1j4Kb2pvMJ6xQ/9RH4eppT8Dq8HXTEuDSNeV2P6DmXEaepuZXoGNHpYeBvBqkntktO9r
 H61PtTDZk8V3xRe2O1QgkjfyZTbljgQ9pSZc16SklAeASid8khp3oMQT7NxsauxXLuCl
 uaTPpMp7h0z/OhAfHH1YzWWn5pJath/zMSDKvv1ida+VBi832/XdBricEs+gUbwnvHA6
 Qg4ubp1Ndurjd1aCjUMk2LdXAq9Bhp5cLbAOEyP7EcwNyegB9jNBaacDEUaOK2zQIYUV
 66zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=mHOfSzeg99iHQUMRCgLtiz+W3r24W00ST4fut/Vk9N4=;
 b=KKFq8uk64PLbCQnY6OlWipEl+JfBVF450EvDT8Kc4EjhYQvy5lsIYPjCbfdy2sl4yl
 u50+UTywhtiCrU5aEPjE7XSLWJEQeNlDYOEcSjbZjHKKjqkK/I/LWnB1dxaDoCHusr54
 WmYR84PVOXXVRgcj1gumuJGEOWdd1u5wJhFD6luqTCvZpvXAoIbf5Q3sDq5UJEKhP3+7
 d46MGoOYLiAWNNAWB658F0/rToDHcg62Bj/bA5Flxkbc9G/ID2mAydTRPZVrfZKuP1Ww
 z8J/pRrtCBve6Xh6xPG+9xW0EQTMqu7yNnRBhZ35K9Er4qY7tvgaEB40gF4fDuZ7MA8E
 aFHA==
X-Gm-Message-State: APjAAAXUTggOJ/3TRbbI5wqNBvHBF1KvTvWHy1TmfxNFWAxKAnFIXnD3
 UAbMev/7NRCY7QdWkdAC22v4MtUtU/I=
X-Google-Smtp-Source: APXvYqyDzbcysnjcplocArihL7Gn+MTBco/nxSVJSL8JOmE3+b8BkMpRdpoSluRsjLi2F7dB1Jo/mg==
X-Received: by 2002:a05:600c:2908:: with SMTP id
 i8mr3267209wmd.142.1571751177462; 
 Tue, 22 Oct 2019 06:32:57 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id r2sm20263856wma.1.2019.10.22.06.32.55
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Oct 2019 06:32:56 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 35/41] hw/arm/exynos4210: Use the Samsung s3c SDHCI controller
Date: Tue, 22 Oct 2019 14:31:28 +0100
Message-Id: <20191022133134.14487-36-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191022133134.14487-1-peter.maydell@linaro.org>
References: <20191022133134.14487-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::341
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <f4bug@amsat.org>

The Exynos SoC has specific SDHCI registers. Use the s3c SDHCI
model which handle these specific registers.

This silents the following "SDHC ... not implemented" warnings so
we can focus on the important registers missing:

  $ qemu-system-arm ... -d unimp \
    -append "... root=/dev/mmcblk0 rootfstype=ext4 rw rootwait" \
    -drive file=linux-build-test/rootfs/arm/rootfs-armv5.ext2,if=sd,format=raw
  [...]
  [   25.744858] sdhci: Secure Digital Host Controller Interface driver
  [   25.745862] sdhci: Copyright(c) Pierre Ossman
  [   25.783188] s3c-sdhci 12530000.sdhci: clock source 2: mmc_busclk.2 (12000000 Hz)
  SDHC rd_4b @0x80 not implemented
  SDHC wr_4b @0x80 <- 0x00000020 not implemented
  SDHC wr_4b @0x8c <- 0x00030000 not implemented
  SDHC rd_4b @0x80 not implemented
  SDHC wr_4b @0x80 <- 0xc0004100 not implemented
  SDHC wr_4b @0x84 <- 0x80808080 not implemented
  [   26.013318] mmc0: SDHCI controller on samsung-hsmmc [12530000.sdhci] using ADMA
  [   26.032318] Synopsys Designware Multimedia Card Interface Driver
  [   42.024885] Waiting for root device /dev/mmcblk0...

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>
Message-id: 20191005154748.21718-5-f4bug@amsat.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/exynos4210.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/arm/exynos4210.c b/hw/arm/exynos4210.c
index a9f8a5c8688..77fbe1baabc 100644
--- a/hw/arm/exynos4210.c
+++ b/hw/arm/exynos4210.c
@@ -405,7 +405,7 @@ static void exynos4210_realize(DeviceState *socdev, Error **errp)
          * public datasheet which is very similar (implementing
          * MMC Specification Version 4.0 being the only difference noted)
          */
-        dev = qdev_create(NULL, TYPE_SYSBUS_SDHCI);
+        dev = qdev_create(NULL, TYPE_S3C_SDHCI);
         qdev_prop_set_uint64(dev, "capareg", EXYNOS4210_SDHCI_CAPABILITIES);
         qdev_init_nofail(dev);
 
-- 
2.20.1



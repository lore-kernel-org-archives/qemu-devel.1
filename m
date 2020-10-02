Return-Path: <SRS0=fJPX=DJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 094D8C4363D
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2020 18:12:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7642820719
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2020 18:12:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JrWnoIFI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7642820719
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41478 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kOPXJ-0005ek-Lh
	for qemu-devel@archiver.kernel.org; Fri, 02 Oct 2020 14:12:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51864)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kOPVw-0004he-KJ; Fri, 02 Oct 2020 14:10:40 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:36429)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kOPVv-0007Cc-0m; Fri, 02 Oct 2020 14:10:40 -0400
Received: by mail-wm1-x343.google.com with SMTP id e2so2655478wme.1;
 Fri, 02 Oct 2020 11:10:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=oTau936JDmi68zMscEvO3SnFMJ5UWYiOUeAh8uEyVYs=;
 b=JrWnoIFISmwb7byO4ARGM8f4MeKI/bMTCRH6oDGM9X7j8J0h8nCLCHVlQB51/dwAwT
 HnF1YFhh6p9skliv8MgMQOaDNmp8haw3rGwAhXDQsCoeepYEQXebXIAO9sMzuyGduDqG
 hGHkIJ2UYu76EhCLhYpnEdB49RsUyEKrT2p3ksHxROU9EUPmNmBskTdiPpRK0JduYim1
 0cxp0taVH/KVeCn9p5LtTTNfCzjQw7daC5ssjEbCweDtYvRo/pqP81PFBlAVqUFlf6Wx
 fXvHnA5JdlEBydsQO/L5Zc2A90mdpS8v7y8iqB2ig+w58b7vWrO6yGOhnpxtCOXStrpM
 prJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=oTau936JDmi68zMscEvO3SnFMJ5UWYiOUeAh8uEyVYs=;
 b=KX0mIatYOGMFIi/ezcXwQqNhNMTp51IUoe8W7XzymS6Th+Wpbr/SegA4xPohla+4ze
 x2ai6OwCigWWdwmLQ0wXgCRQGXBYCbIPuLKRYuYGjM/NsttucoYYHknpBHCK3Ih6xBCV
 4kFi+z5+9falyqYGYnskEEecxxtzBpfIoucg2z6U7JQB4mw+KWxvKxpaHzucqvHCSbBx
 6UwYrdGpAFkn5Jc2i7K4gCvLmW1YqncSZLkrXP/GIbyM+6Eq3C1nnCZ6Et4WF/WSPpLZ
 XazCgpx/ajY7uhlKraSo8xLe3tirvyL7yCkZSYnvfP0mdrwcNDyZ8J0tT1ZXQFR1Vfta
 +kCg==
X-Gm-Message-State: AOAM531fCFuH8uOT6EDZWQhsZnkcIkMYkm3krYzAxNl2nnr8ubCkEI3v
 7kNVoj41aPw7xBRj8gPdHAoeJLcqdPM=
X-Google-Smtp-Source: ABdhPJzxBMlMGzn93saWRnAAfEI5nE1abnmEK+XMALF8jrsiz2+sSHOb+dmUkt6T5e+DJFxSg31U6Q==
X-Received: by 2002:a05:600c:2906:: with SMTP id
 i6mr4304400wmd.48.1601662234847; 
 Fri, 02 Oct 2020 11:10:34 -0700 (PDT)
Received: from localhost.localdomain (74.red-83-53-161.dynamicip.rima-tde.net.
 [83.53.161.74])
 by smtp.gmail.com with ESMTPSA id b8sm2615170wmb.4.2020.10.02.11.10.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Oct 2020 11:10:34 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH] hw/char/bcm2835_aux: Allow less than 32-bit accesses
Date: Fri,  2 Oct 2020 20:10:32 +0200
Message-Id: <20201002181032.1899463-1-f4bug@amsat.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::343;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x343.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Luc Michel <luc@lmichel.fr>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Andrew Baumann <Andrew.Baumann@microsoft.com>,
 Paul Zimmerman <pauldzim@gmail.com>, qemu-arm@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The "BCM2835 ARM Peripherals" datasheet [*] chapter 2
("Auxiliaries: UART1 & SPI1, SPI2"), list the register
sizes as 3/8/16/32 bits. We assume this means this
peripheral allows 8-bit accesses.

This was not an issue until commit 5d971f9e67 which reverted
("memory: accept mismatching sizes in memory_region_access_valid").

The model is implemented as 32-bit accesses (see commit 97398d900c,
all registers are 32-bit) so replace MemoryRegionOps.valid as
MemoryRegionOps.impl, and re-introduce MemoryRegionOps.valid
with a 8/32-bit range.

[*] https://www.raspberrypi.org/app/uploads/2012/02/BCM2835-ARM-Peripherals.pdf

Fixes: 97398d900c ("bcm2835_aux: add emulation of BCM2835 AUX (aka UART1) block")
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
Noticed while running Trusted Firmware-A on the raspi3:
https://www.mail-archive.com/qemu-devel@nongnu.org/msg680115.html
---
 hw/char/bcm2835_aux.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/hw/char/bcm2835_aux.c b/hw/char/bcm2835_aux.c
index ee3dd40e3c..dade2ab5fd 100644
--- a/hw/char/bcm2835_aux.c
+++ b/hw/char/bcm2835_aux.c
@@ -249,7 +249,9 @@ static const MemoryRegionOps bcm2835_aux_ops = {
     .read = bcm2835_aux_read,
     .write = bcm2835_aux_write,
     .endianness = DEVICE_NATIVE_ENDIAN,
-    .valid.min_access_size = 4,
+    .impl.min_access_size = 4,
+    .impl.max_access_size = 4,
+    .valid.min_access_size = 1,
     .valid.max_access_size = 4,
 };
 
-- 
2.26.2



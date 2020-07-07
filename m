Return-Path: <SRS0=B5/Q=AS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A660C433E0
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 13:22:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 054C220771
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 13:22:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="efHjcK57"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 054C220771
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54784 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jsnYN-0004GY-8m
	for qemu-devel@archiver.kernel.org; Tue, 07 Jul 2020 09:22:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45486)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jsnXN-0002nV-Oh; Tue, 07 Jul 2020 09:21:29 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b]:55353)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jsnXI-00015f-GV; Tue, 07 Jul 2020 09:21:29 -0400
Received: by mail-wm1-x32b.google.com with SMTP id g75so43237419wme.5;
 Tue, 07 Jul 2020 06:21:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=wnOaMihuL3Qtq6KxugJtx107vcQI3FbnYUUnIhtkWZY=;
 b=efHjcK57yX1/JaV6eaZnho4ElyhmDUJjHy88ef8UsbWe+f8zmdqJuAim5aIkIQ7ZmY
 +qqjm5EGERaAOBhB+rD3Kp018SFcNGvM4yHHSoW7xIPPfh7h8GHUotX8AWNvy+KRk5hS
 haZI31b8RqLmNvzHQSbPDs3jr6N6U5/2rweDLnNRkXO1BbtsU/x9txLt3kIFHzbTKCnV
 kn137VhQQv9xowt9Ok0TplmXY2zkWxIXTsrlI594kjp+g7gOUNz1AGTfKEWxPei/OwR2
 XNnyiaQX9iZ0lF8TxTDe5Afldx5MWs9VoosyqzduAyAuO9vXt+qMKWReLu38MJe3k1ud
 jEkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=wnOaMihuL3Qtq6KxugJtx107vcQI3FbnYUUnIhtkWZY=;
 b=Q677QzL4PORVyJzDf1V1wwfmF5ykIA+eTKGvd74LT1V9zLot12dU4GMgo8TAnVR/sN
 LXcSwh4JkyQeDtx/eq8Z0i+J/wHOJrqbE+CCO9KRu9VtNRWrHHQYRB6e6mOK0A154NcR
 eAVwad9brCOSPx1/7YC+ukf/f/VT9R8tKvEjBn40ZB05S6YWXT7yIkPh91JVz3NA6f2E
 j5Ypxrto7cdhz2+x9jHiV84BMUZ0e95Og+cEikU/1+j8zwTlhJy53dyXxrw/dBdv6PYC
 iO5hbl6WsGWQLbCq3KMH7mZ3wVni0lcU5a7/QbGGn/ByITnxQ7vx7VaY4hGxHS5H9fis
 CxaA==
X-Gm-Message-State: AOAM5325A3wZsv2CBbb/9qukZTArLOphXEfCcfaKc2YznFZGIF69Z3Ob
 S6LiqouCjr4B68QKEvxrgtyxgp+m
X-Google-Smtp-Source: ABdhPJyCCMSQAvxYaZRTUjpQTMb0n1ewf6YZqCRGbH4q8dfEK5aMU8cmxS6n1CDjeGiOL+eWkuZ+8g==
X-Received: by 2002:a7b:cf16:: with SMTP id l22mr4506908wmg.68.1594128082442; 
 Tue, 07 Jul 2020 06:21:22 -0700 (PDT)
Received: from localhost.localdomain
 (138.red-83-57-170.dynamicip.rima-tde.net. [83.57.170.138])
 by smtp.gmail.com with ESMTPSA id 1sm1040130wmf.0.2020.07.07.06.21.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jul 2020 06:21:21 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 2/2] hw/sd/sdcard: Do not allow invalid SD card sizes
Date: Tue,  7 Jul 2020 15:21:16 +0200
Message-Id: <20200707132116.26207-3-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200707132116.26207-1-f4bug@amsat.org>
References: <20200707132116.26207-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x32b.google.com
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-block@nongnu.org,
 Alistair Francis <alistair@alistair23.me>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Niek Linnenbank <nieklinnenbank@gmail.com>, Cleber Rosa <crosa@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

QEMU allows to create SD card with unrealistic sizes. This could work,
but some guests (at least Linux) consider sizes that are not a power
of 2 as a firmware bug and fix the card size to the next power of 2.

Before CVE-2020-13253 fix, this would allow OOB read/write accesses
past the image size end.

CVE-2020-13253 has been fixed as:

    Read command is rejected if BLOCK_LEN_ERROR or ADDRESS_ERROR
    occurred and no data transfer is performed.

    Write command is rejected if BLOCK_LEN_ERROR or ADDRESS_ERROR
    occurred and no data transfer is performed.

    WP_VIOLATION errors are not modified: the error bit is set, we
    stay in receive-data state, wait for a stop command. All further
    data transfer is ignored. See the check on sd->card_status at the
    beginning of sd_read_data() and sd_write_data().

While this is the correct behavior, in case QEMU create smaller SD
cards, guests still try to access past the image size end, and QEMU
considers this is an invalid address, thus "all further data transfer
is ignored". This is wrong and make the guest looping until
eventually timeouts.

Fix by not allowing invalid SD card sizes.  Suggesting the expected
size as a hint:

  $ qemu-system-arm -M orangepi-pc -drive file=rootfs.ext2,if=sd,format=raw
  qemu-system-arm: Invalid SD card size: 60 MiB (expecting at least 64 MiB)

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/sd/sd.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index cb81487e5c..c45106b78e 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -32,6 +32,7 @@
 
 #include "qemu/osdep.h"
 #include "qemu/units.h"
+#include "qemu/cutils.h"
 #include "hw/irq.h"
 #include "hw/registerfields.h"
 #include "sysemu/block-backend.h"
@@ -2130,11 +2131,26 @@ static void sd_realize(DeviceState *dev, Error **errp)
     }
 
     if (sd->blk) {
+        int64_t blk_size;
+
         if (blk_is_read_only(sd->blk)) {
             error_setg(errp, "Cannot use read-only drive as SD card");
             return;
         }
 
+        blk_size = blk_getlength(sd->blk);
+        if (blk_size > 0 && !is_power_of_2(blk_size)) {
+            int64_t blk_size_aligned = pow2ceil(blk_size);
+            char *blk_size_str = size_to_str(blk_size);
+            char *blk_size_aligned_str = size_to_str(blk_size_aligned);
+
+            error_setg(errp, "Invalid SD card size: %s (expecting at least %s)",
+                       blk_size_str, blk_size_aligned_str);
+            g_free(blk_size_str);
+            g_free(blk_size_aligned_str);
+            return;
+        }
+
         ret = blk_set_perm(sd->blk, BLK_PERM_CONSISTENT_READ | BLK_PERM_WRITE,
                            BLK_PERM_ALL, errp);
         if (ret < 0) {
-- 
2.21.3



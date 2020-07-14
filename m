Return-Path: <SRS0=DUFB=AZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71617C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2020 14:01:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3BD1522267
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2020 14:01:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kPMFKtAm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3BD1522267
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57590 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jvLVF-0001Co-DK
	for qemu-devel@archiver.kernel.org; Tue, 14 Jul 2020 10:01:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35048)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jvLS1-0004HT-Iq; Tue, 14 Jul 2020 09:58:29 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c]:42884)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jvLS0-0003Rw-0W; Tue, 14 Jul 2020 09:58:29 -0400
Received: by mail-wr1-x42c.google.com with SMTP id o11so21819163wrv.9;
 Tue, 14 Jul 2020 06:58:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=OgXNH+mo7JKklLu9qpEEEuuMSFXzixG0CeB5oAL2ys8=;
 b=kPMFKtAmJi6RrjZ2Th33EPcuBpK2HbrWwcOUfvE6ljXSrz/a8eabjwFjLP/GG0JUS9
 zDlhfLDH+NQlm0nwbV7TdV7ymnysl9gCgKHrxwZO5wuCLOh4iTMqXo0xqfNs+QlwZxCV
 7T0TOwU03rTnGk29Pfaowa8lCSAoVVNvoEUX0blhJM+ejyEKf0I/FzFnaIuZBEddfiGP
 5hfYqpiKx+gz7sg9mycHfLsLede2XHpnlNS9NsIAt9AR/MXFTrZDqi2usmXTmL6Drtmk
 9O/34dwY8zi/6uQ7efwi/qUOs9jvSSlrHfFG410GtZY3QVQHj3zGvDLBdiJY4Q1sLeMI
 JlTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=OgXNH+mo7JKklLu9qpEEEuuMSFXzixG0CeB5oAL2ys8=;
 b=jq1Rr+nTL1sOh1afxmME7JdCv4KrMXWK8qQGg4A3hAPUcW91aY+Tbb1SgTSEeoheBY
 no9PYYIt6w3RExt3MQG3Zbr8cTSyZTyNHvcueabF5y9oGS19RbtDDPBJO4dNhnrofixj
 aWsho6c/ZxcNfaOfneW3oBlhrs9mfnq/ZY9AM0igbmsTTdRfG9JyqlygFC6dJ6LOFzgP
 iobw3ruG1AlcwJ2EXyy73ZGe1ApSDaL7Ukca+10EnUIRZ50Kr2m2r5s0OdJ+m+72vf03
 f31JASFu07ugLYQrXmiPnrzrbF3/qBL0zKbw0HXfTtE0E28AOJMLJ1wwO0rX3kQXIBPw
 KiGA==
X-Gm-Message-State: AOAM5314nj9iO7Q+hkAkoYx6z/aE3raH790/3T9Kglw/rF9bJa7aun6z
 UxWXGK7gDE6H7LXamY/Ild8up03yif4=
X-Google-Smtp-Source: ABdhPJw2KNDs5CWDaXQToY2owl6wW2f2eOz4nnT7mIBGo+CyzoTFVIULuX8KLhnAKu06AwFzyWEACQ==
X-Received: by 2002:a5d:424f:: with SMTP id s15mr6078414wrr.342.1594735105632; 
 Tue, 14 Jul 2020 06:58:25 -0700 (PDT)
Received: from localhost.localdomain
 (138.red-83-57-170.dynamicip.rima-tde.net. [83.57.170.138])
 by smtp.gmail.com with ESMTPSA id k14sm29145343wrn.76.2020.07.14.06.58.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Jul 2020 06:58:25 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PULL 7/9] hw/sd/sdcard: Do not allow invalid SD card sizes
Date: Tue, 14 Jul 2020 15:58:12 +0200
Message-Id: <20200714135814.19910-8-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200714135814.19910-1-f4bug@amsat.org>
References: <20200714135814.19910-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x42c.google.com
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
 qemu-stable@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Alexander Bulekov <alxndr@bu.edu>, Alistair Francis <alistair.francis@wdc.com>,
 Prasad J Pandit <ppandit@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

QEMU allows to create SD card with unrealistic sizes. This could
work, but some guests (at least Linux) consider sizes that are not
a power of 2 as a firmware bug and fix the card size to the next
power of 2.

While the possibility to use small SD card images has been seen as
a feature, it became a bug with CVE-2020-13253, where the guest is
able to do OOB read/write accesses past the image size end.

In a pair of commits we will fix CVE-2020-13253 as:

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

Fix by not allowing invalid SD card sizes (suggesting the expected
size as a hint):

  $ qemu-system-arm -M orangepi-pc -drive file=rootfs.ext2,if=sd,format=raw
  qemu-system-arm: Invalid SD card size: 60 MiB
  SD card size has to be a power of 2, e.g. 64 MiB.
  You can resize disk images with 'qemu-img resize <imagefile> <new-size>'
  (note that this will lose data if you make the image smaller than it currently is).

Cc: qemu-stable@nongnu.org
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-Id: <20200713183209.26308-8-f4bug@amsat.org>
---
 hw/sd/sd.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index edd60a09c0..76d68359a4 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -32,6 +32,7 @@
 
 #include "qemu/osdep.h"
 #include "qemu/units.h"
+#include "qemu/cutils.h"
 #include "hw/irq.h"
 #include "hw/registerfields.h"
 #include "sysemu/block-backend.h"
@@ -2106,11 +2107,35 @@ static void sd_realize(DeviceState *dev, Error **errp)
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
+            char *blk_size_str;
+
+            blk_size_str = size_to_str(blk_size);
+            error_setg(errp, "Invalid SD card size: %s", blk_size_str);
+            g_free(blk_size_str);
+
+            blk_size_str = size_to_str(blk_size_aligned);
+            error_append_hint(errp,
+                              "SD card size has to be a power of 2, e.g. %s.\n"
+                              "You can resize disk images with"
+                              " 'qemu-img resize <imagefile> <new-size>'\n"
+                              "(note that this will lose data if you make the"
+                              " image smaller than it currently is).\n",
+                              blk_size_str);
+            g_free(blk_size_str);
+
+            return;
+        }
+
         ret = blk_set_perm(sd->blk, BLK_PERM_CONSISTENT_READ | BLK_PERM_WRITE,
                            BLK_PERM_ALL, errp);
         if (ret < 0) {
-- 
2.21.3



Return-Path: <SRS0=d88l=CM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BC4FC433E2
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 21:31:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4BE9D206D4
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 21:31:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Clv9uVjf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4BE9D206D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47918 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDwpo-0005Wh-Fo
	for qemu-devel@archiver.kernel.org; Thu, 03 Sep 2020 17:31:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59192)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <flukshun@gmail.com>)
 id 1kDwLo-0004fL-IG; Thu, 03 Sep 2020 17:00:56 -0400
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:35052)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <flukshun@gmail.com>)
 id 1kDwLm-0007no-La; Thu, 03 Sep 2020 17:00:56 -0400
Received: by mail-ot1-x342.google.com with SMTP id i4so4038592ota.2;
 Thu, 03 Sep 2020 14:00:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=ZILyJy1nBWpJrZHi1uzFvLmVU4Jp6kAKnyaWcu8nswA=;
 b=Clv9uVjffYFXUVLDfiEodN/TslU59h5Bg0WaWJSGDP198TnWg4/n44x3g5v9q/zw8I
 y1WlFu9igpVmSqrrxY58ZgKqrTscD2IrAt6R8QjhuvaFTajW9C12soRHUGNmcWiY9k3E
 D396CSb6hrIqBMIejNhuArSlpI2sNXGQbFmH2ljCxlk2JxbWTfNjmdzGGqyNR61OMY5Q
 tgujt45eKn7kW5vR+niV4/oqYsL9kEUIe471rx+4AM6DP3UEbYJFlBu4lX2nFVGIFFMp
 Nprm5qXKd1pIN8lawHCxmC9Hzyl0GWeB18g6LIoJ/WlepxNnBVtnUXzmb0ZkcfKwl7Tn
 X/kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=ZILyJy1nBWpJrZHi1uzFvLmVU4Jp6kAKnyaWcu8nswA=;
 b=erPDFTM9Ai4o8PTmH4nl5e94k7nRCZ5LLT96ayu5b7bdrjH/UhS3nhb9JPDKrfBzv7
 X9omx41Eav37qqzLaJu3KmqL0kc6H0jNHaxW9tvRFG6FHYJryY8Xr8f8tsNTo6fV4Su3
 dSxTKeOS/f6S3E2Ko1yrX2/4/7o7LdgCmtVnDTqzIrJJSRvAyhCRuB/yP2h7WmLPJt/l
 p4Piq+pp0UsxLho24u0K7SbtkGuPkjm+8gbEioGrdhVHl3qc2E2xEYce4aZyLJZSw2m/
 RhMLVWZTwq4MdACZn5QEEN5DnUlWV69pjZ/299zN8a0ObUN3+SvEUBE7Iuou1WAQlW/J
 78XQ==
X-Gm-Message-State: AOAM532yGiRSMzOtxNI1/Oj8TG3bP4xxANvBStndYTXiawCP3zAVXQwF
 QaQQDCFo2DS8WEmMIwyt+RxC+4mR8sM=
X-Google-Smtp-Source: ABdhPJwM++6LzX4HTR1xyk+ivDuvEvim/0s7nyID5EMvqQE3qxi/bnz+TKqOHMosXyv2bY23ET6bcA==
X-Received: by 2002:a9d:37b5:: with SMTP id x50mr2906344otb.57.1599166852742; 
 Thu, 03 Sep 2020 14:00:52 -0700 (PDT)
Received: from localhost (76-251-165-188.lightspeed.austtx.sbcglobal.net.
 [76.251.165.188])
 by smtp.gmail.com with ESMTPSA id y10sm849793ooh.9.2020.09.03.14.00.51
 (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 03 Sep 2020 14:00:52 -0700 (PDT)
From: Michael Roth <mdroth@linux.vnet.ibm.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 53/77] hw/sd/sdcard: Do not allow invalid SD card sizes
Date: Thu,  3 Sep 2020 15:59:11 -0500
Message-Id: <20200903205935.27832-54-mdroth@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200903205935.27832-1-mdroth@linux.vnet.ibm.com>
References: <20200903205935.27832-1-mdroth@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::342;
 envelope-from=flukshun@gmail.com; helo=mail-ot1-x342.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.249,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.001,
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
Cc: qemu-stable@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <f4bug@amsat.org>

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
(cherry picked from commit a9bcedd15a5834ca9ae6c3a97933e85ac7edbd36)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 hw/sd/sd.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index 04258f1816..c34435ede4 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -32,6 +32,7 @@
 
 #include "qemu/osdep.h"
 #include "qemu/units.h"
+#include "qemu/cutils.h"
 #include "hw/irq.h"
 #include "hw/registerfields.h"
 #include "sysemu/block-backend.h"
@@ -2091,11 +2092,35 @@ static void sd_realize(DeviceState *dev, Error **errp)
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
2.17.1



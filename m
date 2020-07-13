Return-Path: <SRS0=6r5r=AY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 329A0C433E3
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 18:34:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F2DFD2075D
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 18:34:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RrTzR7+0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F2DFD2075D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51612 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jv3Hb-0005dA-6w
	for qemu-devel@archiver.kernel.org; Mon, 13 Jul 2020 14:34:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40370)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jv3FZ-0002Fx-GA; Mon, 13 Jul 2020 14:32:25 -0400
Received: from mail-ej1-x629.google.com ([2a00:1450:4864:20::629]:41885)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jv3FX-0004IV-P0; Mon, 13 Jul 2020 14:32:25 -0400
Received: by mail-ej1-x629.google.com with SMTP id dp18so18410911ejc.8;
 Mon, 13 Jul 2020 11:32:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=A45CZTNPoBUm1W95oEJT02xG5DfWi0IK+venM/Qt9bs=;
 b=RrTzR7+0l7YaevPSpaniWmb86Wlj4IrrZlKRLeAhQ6KZAG3sski4737esWwL5su6Pp
 Ce3l1UH/qBNR+ynPijOSaUcCEK+Lk0GI/gPp1slF2LjS79HcHNnWwPDBBJqZuH94tYt4
 CikzDbl0L1RZJ2prXPK06kqm5YjCHy8oFoJqBUgGLGgIEY0JXumZeY+vxssK4u3/SjUF
 XRGYnPAmgqjuaLt9Qa9mUmnqX2yjDv6iNRYN1ueAjde0GFW+Az5Ykxalo0DN8Rh8kWwQ
 gZ9xflMSO6vAArf4ulsQ1qf4P6/opS1i2PuXT/0ALg3pL3L0HbZ6gDbnD0ipiLHA/wI0
 3IVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=A45CZTNPoBUm1W95oEJT02xG5DfWi0IK+venM/Qt9bs=;
 b=giWewntv2U9q831HP0bffGFOs42DWtygnoIrXe4EV+kdKPgV/JSGi8I3hg5HK/9U3H
 ci5V51O3vOppTG0piKWYczgu1uC80biYu40sR5SaR9SbE3LPXHssWq3Us7yOO3RYRaWM
 f7ijlL9Qg00ZNg/cT+ZiQ27x5zQqUWdEh2LgdRd8JMX4TLypos8ZEVte5b9aNh7fbZuV
 pSyRdTO8zThgj/f3P5A0BJoykIqObRBrgMzBGYfZmgpedZ3chIZjfz0o2M6Sx26yZaoO
 YuTK/ZYMe6nQAY4LLWYtO69QwXNtqgAxieSO8/nc1mFetsKxjNZeBARZjRX55LCfUAkN
 CzLA==
X-Gm-Message-State: AOAM5326NujSmeDX1UBDuJX4oYj6phAw2X1pwjGk0KGT1yBCspFHVLBI
 ke2A0ZyUb38jwbrMHfAEUaZtTmJ0iqA=
X-Google-Smtp-Source: ABdhPJz0Qw8SlxeFe9OpDRbyHyGFrAh21kTo5G35ARfVjmG9nKS4QXR+N8grcx7i+gAD69uapIJ+iQ==
X-Received: by 2002:a17:907:20d1:: with SMTP id
 qq17mr1032942ejb.214.1594665141592; 
 Mon, 13 Jul 2020 11:32:21 -0700 (PDT)
Received: from x1w.redhat.com (138.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.138])
 by smtp.gmail.com with ESMTPSA id ce12sm4353148edb.4.2020.07.13.11.32.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Jul 2020 11:32:21 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 7/9] hw/sd/sdcard: Do not allow invalid SD card sizes
Date: Mon, 13 Jul 2020 20:32:07 +0200
Message-Id: <20200713183209.26308-8-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200713183209.26308-1-f4bug@amsat.org>
References: <20200713183209.26308-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::629;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-ej1-x629.google.com
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Prasad J Pandit <pjp@fedoraproject.org>, qemu-block@nongnu.org,
 Alistair Francis <alistair@alistair23.me>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Alexander Bulekov <alxndr@bu.edu>, Niek Linnenbank <nieklinnenbank@gmail.com>,
 Cleber Rosa <crosa@redhat.com>,
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

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
Since v1:
  Addressed Alistair & Peter comments (error_append_hint message)
---
 hw/sd/sd.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index edd60a09c0..5ab945dade 100644
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
+                              "You can resize disk images with "
+                              "'qemu-img resize <imagefile> <new-size>'\n"
+                              "(note that this will lose data if you make the "
+                              "image smaller than it currently is).\n",
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



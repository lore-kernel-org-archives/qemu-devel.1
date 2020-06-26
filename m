Return-Path: <SRS0=ZkAM=AH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E090C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 16:37:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5810120781
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 16:37:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uF9Tw83D"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5810120781
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57314 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jorLu-0002rq-Jm
	for qemu-devel@archiver.kernel.org; Fri, 26 Jun 2020 12:37:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54254)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jorDT-0005oL-VT; Fri, 26 Jun 2020 12:28:39 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:44508)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jorDS-0003My-DZ; Fri, 26 Jun 2020 12:28:39 -0400
Received: by mail-wr1-x444.google.com with SMTP id b6so10058414wrs.11;
 Fri, 26 Jun 2020 09:28:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=+8tgefUeT5/9N4gOvIe9EAniXsDLRRPR141VmG/d0+0=;
 b=uF9Tw83Dk1rUCojYgrRS2FHYPs0sJSZpDX5J04Eb8q/I0Z6DiJsa91d1zkEJUXnPKG
 sEbbAwVtuBehmQw0IpuT8R4f66+Lo5bHSooSmpOo1J5l3QXlck8/QA2GFRp+ugY6jmyO
 uIqbVVJTRGKNVqfiT2YFS3twdCwMoc2i3yFzLRlrVc9l7o8oMZY2wR73RyxAlIcLdsYY
 roipTu18JZeIG9eXCHEhp8ipS24bYNHexDLLs1RClhimLxQzSfHmcRYEGtG/vkTadevg
 r8poti930etTbV78F8vd/A0+5RSCkVDzuyF2Xv4uDueGD6z8igzoNmOVyDAx05urrFBE
 6EtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=+8tgefUeT5/9N4gOvIe9EAniXsDLRRPR141VmG/d0+0=;
 b=nsscnbwG1hI/esYvFqHghUjrvsVOHSehe9PG5O8isUfAT9qhCjDeftSengHWK0EZxt
 GY+QfaehfZ4yx/wlEreaXkAYbFcY41CpfloB8jBCMAJAwSLaU5b/LSkfBkxZZqVUEAua
 ySeBKFWMdL3CvXAUxJkTI14Pylf0U9e/k8IeHFIO3D/mpy6oPbrgOE3NjMzlKhUgNyNp
 +Zyg8YxvNccIzF4BJH4/q/JuxEXkGSwmzHp/way/sNfsc66il9q1HjpCukS+3rMHkEhU
 hrFAdx3Briy3XNyPwZX+y91B4O+s0Pha6z2tPHq4lRHrkmPvvKpKC/5PoQS6XHnc69qt
 7/jw==
X-Gm-Message-State: AOAM531pKtwUBe8ClQtZ8c7AZpiaCt7c66HoD4LuZR2XBfLLbUEIn0IT
 qBbY8MS3Jm98oSydldYyfZR0/ljI
X-Google-Smtp-Source: ABdhPJwoLvgUORYfhq/Vqw1lTQGmJjFbltOQcumKDJS8d4fAbaxKEc0vt+2G4sxod8H7FAkJbFKkqg==
X-Received: by 2002:a5d:4202:: with SMTP id n2mr4466653wrq.171.1593188916688; 
 Fri, 26 Jun 2020 09:28:36 -0700 (PDT)
Received: from localhost.localdomain (1.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.1])
 by smtp.gmail.com with ESMTPSA id 12sm4867255wmg.6.2020.06.26.09.28.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Jun 2020 09:28:36 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 14/14] hw/sd/sdcard: Simplify realize() a bit
Date: Fri, 26 Jun 2020 18:28:18 +0200
Message-Id: <20200626162818.25840-15-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200626162818.25840-1-f4bug@amsat.org>
References: <20200626162818.25840-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::444;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x444.google.com
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
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We don't need to check if sd->blk is set twice.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/sd/sd.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index 8fdee4ed56..46cd7c1aba 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -2140,12 +2140,12 @@ static void sd_realize(DeviceState *dev, Error **errp)
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



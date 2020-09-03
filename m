Return-Path: <SRS0=d88l=CM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 963A2C433E2
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 21:28:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 53900206CA
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 21:28:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="II1RWNGE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 53900206CA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34358 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDwmq-0008F7-Dl
	for qemu-devel@archiver.kernel.org; Thu, 03 Sep 2020 17:28:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59166)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <flukshun@gmail.com>)
 id 1kDwLm-0004cG-J9; Thu, 03 Sep 2020 17:00:54 -0400
Received: from mail-oo1-xc44.google.com ([2607:f8b0:4864:20::c44]:45660)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <flukshun@gmail.com>)
 id 1kDwLl-0007nN-1y; Thu, 03 Sep 2020 17:00:54 -0400
Received: by mail-oo1-xc44.google.com with SMTP id u28so1122121ooe.12;
 Thu, 03 Sep 2020 14:00:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=+vCCI2xx9GVvmEfubwpcsIW6FrRaSKZ9xWlva5k5xWQ=;
 b=II1RWNGE5KaeU8hFLd78cQ2fOlhwfXb0Rf5ycQath3mMC8TSEY1ZFo6VEFQpVkSEog
 qzqjUeLQK4gR0ju65GIOWY5zZviYLFWmojydKRD1x1DwA8jzqcWyfGdNEkl/n70vF6wg
 ZK4MkAfTDQVuxoh8DURknqtaQQ3l/b0K1efeIYYdke6y/+V1WRNVcgQePb+pfqBXlV1D
 5un/DOB4gn55Fap9F9t9HazrNhIea8uSyctZ/VIKfLXj9F+RZioJyCawuFzdrsIh/rzR
 Y/p/YgbJ8Oh2XQulNiy5muxPwE4RjHiew2CpZT7L+IagNhSG5O0gvC2LqLKHWBDBDNZu
 AnsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=+vCCI2xx9GVvmEfubwpcsIW6FrRaSKZ9xWlva5k5xWQ=;
 b=snvOXD4zqoOEc4HZVUIdhjBqplNF8mEHK1TJK3KDSkdxAbZGP3pO5GbJdo+TzzOKjA
 DzoLg+B2WKOP+GJan2NEi4r/sMifDYYBOncLuuglqj2wTXglEjg38W2GFvSmqZxitFVg
 Zrn0guqq7UevL11ogSDsAaFm0L9hXYFpAnl/QypJ0HgyOqckTDvRC2WMiF1G0d3XCjDC
 GeHpc/s2SE20vuq3wPeUHsLz3Glw/2e7hcMWCxYVZWIQ813CVSiI2qsTabtN8brg4EA4
 g6sEQIzrChsKtOcONQw8v64scStriddY4ad+aRlqfn9v/FdVMrB2x595aI/ddDFvveS4
 ePRQ==
X-Gm-Message-State: AOAM531ZBMT0r+RymPhlrx2LuSVnQ9Cda5yGY6oxoj6MfuSP/yceAVYo
 vm/srQp+Lul7AkBS6ye9K1b9bf0T86w=
X-Google-Smtp-Source: ABdhPJwOU7dDRvZsAVANagrnVEa2H0Eksz5BhR8KsWAeU298YxcApWj9dCzBd1WMADGMMJjpx1GFjQ==
X-Received: by 2002:a4a:4910:: with SMTP id z16mr3327291ooa.41.1599166851303; 
 Thu, 03 Sep 2020 14:00:51 -0700 (PDT)
Received: from localhost (76-251-165-188.lightspeed.austtx.sbcglobal.net.
 [76.251.165.188])
 by smtp.gmail.com with ESMTPSA id l3sm842779oom.18.2020.09.03.14.00.50
 (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 03 Sep 2020 14:00:50 -0700 (PDT)
From: Michael Roth <mdroth@linux.vnet.ibm.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 52/77] hw/sd/sdcard: Simplify realize() a bit
Date: Thu,  3 Sep 2020 15:59:10 -0500
Message-Id: <20200903205935.27832-53-mdroth@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200903205935.27832-1-mdroth@linux.vnet.ibm.com>
References: <20200903205935.27832-1-mdroth@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c44;
 envelope-from=flukshun@gmail.com; helo=mail-oo1-xc44.google.com
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

We don't need to check if sd->blk is set twice.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-Id: <20200630133912.9428-18-f4bug@amsat.org>
(cherry picked from commit 6dd3a164f5b31c703c7d8372841ad3bd6a57de6d)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 hw/sd/sd.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index da39590f58..04258f1816 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -2090,12 +2090,12 @@ static void sd_realize(DeviceState *dev, Error **errp)
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
2.17.1



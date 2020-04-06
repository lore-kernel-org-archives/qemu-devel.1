Return-Path: <SRS0=By5p=5W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7900C2BA17
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Apr 2020 17:54:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 999E4206F8
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Apr 2020 17:54:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BzmpXXpW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 999E4206F8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35956 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jLVxB-0005RG-Nl
	for qemu-devel@archiver.kernel.org; Mon, 06 Apr 2020 13:54:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35929)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jLVqt-0001gR-Vs
 for qemu-devel@nongnu.org; Mon, 06 Apr 2020 13:48:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jLVqs-0001sc-IB
 for qemu-devel@nongnu.org; Mon, 06 Apr 2020 13:48:03 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:37326)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jLVqr-0001ng-Bi; Mon, 06 Apr 2020 13:48:02 -0400
Received: by mail-wr1-x443.google.com with SMTP id w10so513991wrm.4;
 Mon, 06 Apr 2020 10:48:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=3C5u9DrXZj6rRyHI74cwCLmjedB/NXARv4QiTEDtzdw=;
 b=BzmpXXpW7EEA5jqIDETxNdtM+2Y/Ra/w9UV/aPg/syX2t5t7NrXFDnQS0d9IgSaWnn
 vzN4hqnvcKpcdVYe6pxdKHyEJ63mJQtLsDYD2DKwLwiwideF82cL+KDW4TC6Ao2eVhgN
 aEpBnjBpRsvgvg2UdMMNGw2m16z+jsIaRCSOVmybyourCKbhVcp5YKs1x8NxeMEMaL0I
 eU3YAktle+U7ghEkm+BDl38xUbxzq74QZ35tN7TmEMz20t27N/X/4EkLduiELZVw2kaw
 JkZGRmwIiEaIAIyq1b/2VGgGaWSABTCmqFA36hadQjP0xMu3VCt0PgwyVIWEUUxeQdJG
 s/rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=3C5u9DrXZj6rRyHI74cwCLmjedB/NXARv4QiTEDtzdw=;
 b=ZrjT8eh/WyIby44lzz0CYpuqsHyWLKsL14/lxeOIlXh21RKggkq2paYBbCwQNRs4lX
 xMikwGhl8OyUd9mApeU2JJqmJxX7bc5pIF/juxy4PgBnicwy+ROYiCr1AxrX/xRHWYIB
 Kh93Yn1aGEPVsaoyZZwlk5PdvkI73MotSpyhjogkYsvuaYh38ACy+6YFIs3Z0s+mv5kX
 zp9VILi2YUHUqTFgtdgNHOyxNRrL3EDZBZ0Sh79tsK71zP6NZ74wcGGf3sqCav4UmkNr
 WMInmWfMhWsNgWXO1qunCgLz1VLaPVpDws/ATFfrjwdCk3h/wpT80/yLzaKTW6rlneNN
 l/4A==
X-Gm-Message-State: AGi0PuZ2KJwZuWOs6UNN2Ulj1VNOdapBSdKIL198jMbwJKkgRakmO06a
 FnT3VnNnl2ZqO6B18IDTydEsoYbmbD0=
X-Google-Smtp-Source: APiQypIMxwSmnEtOgCvmsz39WSmC/Oia50+cLhNzfAQJwO+V8sHTK+hVoi1jZIeeZ4Iw8sb/42fzoQ==
X-Received: by 2002:a5d:5228:: with SMTP id i8mr389256wra.156.1586195280250;
 Mon, 06 Apr 2020 10:48:00 -0700 (PDT)
Received: from x1w.redhat.com (116.red-83-42-57.dynamicip.rima-tde.net.
 [83.42.57.116])
 by smtp.gmail.com with ESMTPSA id a67sm364880wmc.30.2020.04.06.10.47.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Apr 2020 10:47:59 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org,
	Markus Armbruster <armbru@redhat.com>
Subject: [PATCH-for-5.1 v2 10/54] hw/arm/fsl-imx31: Move some code from
 realize() to init()
Date: Mon,  6 Apr 2020 19:46:59 +0200
Message-Id: <20200406174743.16956-11-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200406174743.16956-1-f4bug@amsat.org>
References: <20200406174743.16956-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::443
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
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 Peter Chubb <peter.chubb@nicta.com.au>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 "open list:i.MX31 kzm" <qemu-arm@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Coccinelle reported:

  $ spatch ... --timeout 60 --sp-file \
    scripts/coccinelle/simplify-init-realize-error_propagate.cocci
  HANDLING: hw/arm/fsl-imx31.c
  >>> possible moves from fsl_imx31_init() to fsl_imx31_realize() in hw/arm/fsl-imx31.c:68

Move the calls using &error_abort which don't depend of input
updated before realize() to init().

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/arm/fsl-imx31.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/arm/fsl-imx31.c b/hw/arm/fsl-imx31.c
index 8472d2e911..61287e24f6 100644
--- a/hw/arm/fsl-imx31.c
+++ b/hw/arm/fsl-imx31.c
@@ -62,6 +62,8 @@ static void fsl_imx31_init(Object *obj)
     for (i = 0; i < FSL_IMX31_NUM_GPIOS; i++) {
         sysbus_init_child_obj(obj, "gpio[*]", &s->gpio[i], sizeof(s->gpio[i]),
                               TYPE_IMX_GPIO);
+        object_property_set_bool(OBJECT(&s->gpio[i]), false, "has-edge-sel",
+                                 &error_abort);
     }
 }
 
@@ -191,8 +193,6 @@ static void fsl_imx31_realize(DeviceState *dev, Error **errp)
             { FSL_IMX31_GPIO3_ADDR, FSL_IMX31_GPIO3_IRQ }
         };
 
-        object_property_set_bool(OBJECT(&s->gpio[i]), false, "has-edge-sel",
-                                 &error_abort);
         object_property_set_bool(OBJECT(&s->gpio[i]), true, "realized", &err);
         if (err) {
             error_propagate(errp, err);
-- 
2.21.1



Return-Path: <SRS0=SLMP=AQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BB07C433E0
	for <qemu-devel@archiver.kernel.org>; Sun,  5 Jul 2020 20:50:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 058002073E
	for <qemu-devel@archiver.kernel.org>; Sun,  5 Jul 2020 20:50:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mc2aaxRi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 058002073E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47048 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jsBaJ-0001Hf-BL
	for qemu-devel@archiver.kernel.org; Sun, 05 Jul 2020 16:49:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50672)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jsBX6-0004Wa-Vg; Sun, 05 Jul 2020 16:46:40 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:40836)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jsBX5-0000pR-F5; Sun, 05 Jul 2020 16:46:40 -0400
Received: by mail-wr1-x441.google.com with SMTP id f2so10762416wrp.7;
 Sun, 05 Jul 2020 13:46:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=WxPjkbT1Cf+fTJhIz6EA4Q+a6g7EtjSauXqyKUUtqbs=;
 b=mc2aaxRiAz5Y+OEAGL+ybYmW+l0Bz0R2Ha60762Wtp6AqE1nSMUAWgkSgzcfZOUWBE
 or23TPDUpHb4t/cC+k8K7o+tDy8stfHAWygt+CpZ/ExKqIJIkaBGTY1xn5sgytoBFG/U
 refyFb9/5P+yQK0JEBuTckvRtmyo4dgBOKxPvza5YMh6HSgq+ZrMjs3UNOxWjxYRdsDj
 fXEX72oVKjWAqGDVEHEtk5Sqg6QOfFj4BXql57UdkBq0Kq8qzalcG4JFXFSPsclNEuI+
 HOu49jQHSFE93+ITlUirQHQbGh4w+jzeLOmnQhLZLQqd6pI5a9JLh0oOd/jfg2U2v3H0
 0hLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=WxPjkbT1Cf+fTJhIz6EA4Q+a6g7EtjSauXqyKUUtqbs=;
 b=TIkKK/Tc9lloLNORhMAugF9dYWsFvMYQRV9RJKHgf0016KstBMDbH5gkm8kEd+ma1x
 2xi+4K9jrYSwACd1Ika43PFmUFsN/Vtxy5O91hk45DCSHbiYpFtZIpSKi0pM0GXsk9/J
 Vi3Lp2tO108/TUO8yr1hlcf/dv6DZwe4pHDpE1+Xiod4fz4uqwf+v+hjomsrz2QDz245
 oxHnsDGM6CIgb/34jyohzBMJSYX1ZfZNWd1ogkOJ0Vs3OfhpOnFpm2skhgN7hjoJRGwd
 x/G4bPA1C8u7euadBK9OVzVpY2MQvIxiMoSNEH6a5sSMrDDHwwM1vYLutdyVSPRSVagM
 fEcA==
X-Gm-Message-State: AOAM530q1qIrKl9U8USm+m8twdBPYZm3kTbHRxbJPk0YJ8qDypho1F1a
 0VYxCIjJ345du2yYCVqj7RW1zmv4YeM=
X-Google-Smtp-Source: ABdhPJw91Wwsgy9yklgukYdN1oyXPDCzUEIFnV6ARwpc631pb89EqxuL+33SqYWbyZ97j4i35SQlbg==
X-Received: by 2002:adf:e6c8:: with SMTP id y8mr48495990wrm.40.1593981997457; 
 Sun, 05 Jul 2020 13:46:37 -0700 (PDT)
Received: from localhost.localdomain (1.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.1])
 by smtp.gmail.com with ESMTPSA id g144sm51397817wme.2.2020.07.05.13.46.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 05 Jul 2020 13:46:36 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 04/10] hw/arm/versatilepb: Comment to remember some IRQs
 lines are left unwired
Date: Sun,  5 Jul 2020 22:46:24 +0200
Message-Id: <20200705204630.4133-5-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200705204630.4133-1-f4bug@amsat.org>
References: <20200705204630.4133-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::441;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x441.google.com
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Alistair Francis <alistair@alistair23.me>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The 'card is readonly' and 'card inserted' IRQs are not wired.
Add a comment in case someone know where to wire them.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/arm/versatilepb.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/hw/arm/versatilepb.c b/hw/arm/versatilepb.c
index e596b8170f..45a13ae2b9 100644
--- a/hw/arm/versatilepb.c
+++ b/hw/arm/versatilepb.c
@@ -310,7 +310,9 @@ static void versatile_init(MachineState *machine, int board_id)
     qdev_connect_gpio_out(sysctl, 0, qdev_get_gpio_in(dev, 0));
 
     sysbus_create_varargs("pl181", 0x10005000, sic[22], sic[1], NULL);
+    /* FIXME wire 'card is readonly' and 'card inserted' IRQs? */
     sysbus_create_varargs("pl181", 0x1000b000, sic[23], sic[2], NULL);
+    /* FIXME wire 'card is readonly' and 'card inserted' IRQs? */
 
     /* Add PL031 Real Time Clock. */
     sysbus_create_simple("pl031", 0x101e8000, pic[10]);
-- 
2.21.3



Return-Path: <SRS0=SLMP=AQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0876C433E0
	for <qemu-devel@archiver.kernel.org>; Sun,  5 Jul 2020 21:11:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 79AA520739
	for <qemu-devel@archiver.kernel.org>; Sun,  5 Jul 2020 21:11:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aRn2T70d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 79AA520739
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44684 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jsBvZ-0000w2-GA
	for qemu-devel@archiver.kernel.org; Sun, 05 Jul 2020 17:11:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54806)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jsBu6-0007Cb-P3
 for qemu-devel@nongnu.org; Sun, 05 Jul 2020 17:10:26 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:53527)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jsBu3-0004rr-WA
 for qemu-devel@nongnu.org; Sun, 05 Jul 2020 17:10:25 -0400
Received: by mail-wm1-x343.google.com with SMTP id j18so37117815wmi.3
 for <qemu-devel@nongnu.org>; Sun, 05 Jul 2020 14:10:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=USmnM0sdBNCY4V6MFVCaDnSU9PQa4HFTC5SUnR3ioHU=;
 b=aRn2T70dr+tLX6R/ToDrhbt4Eyy9mIow/saapukBfQyUcmKImpV6D2cGbXTwuPTJkf
 Yqxf/PsIjtxyK7KidPrXMsJbDMtcoHxtWhkjRBW8j0hoxREcVHyjJj/sAdjxSM+nCy+p
 EpWpGQ6Ge1lBHZkyPg3/5D1WYRzhDKUUobruMFWtzl128SumCUSwq6YfUFufjnascyd7
 WaGCuQ6V+/8++gSpYEDcsSFEfFzVfPIalTtO7uEct83Kd6MDTbW/HmZmc7f56GfRj7d8
 rCPg6lgPK73y1oOrAsB/SWTrbMosG0YbDR5YmUBbHvHqku8fVJg22Tb3OWWN1V8fwvZf
 GpTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=USmnM0sdBNCY4V6MFVCaDnSU9PQa4HFTC5SUnR3ioHU=;
 b=OZ5gO/BtwW6SUnj+aLl6M0VtlS83ZmezFpFky2OtYY697xm9G33ZASg/d8tHMrv0+T
 6KVYlR5Ll9LgjBNTJvsOJhs4biSCIMRSN8ATAAHczRwD9wYI0xstNZXoMPlyuqAmJ9rv
 qU2DVKg8rVlSVunh30Ru/MYD244XWNMtpu+umd/4MqzMjAOlI7ya95PmrTMn9UJtNUrH
 ha6VwhvyrGjW+atr+EKSleH9HL9XKu6nHJgvMMgR0dV19z179CLyOgElaQQewgYrY+2O
 noXitCYuyitCM7fv269QV8TP5qOnPg8+Bq6PMhF2/x0R3j9lK7bvCzSWtndR0aNRxBVt
 F7cw==
X-Gm-Message-State: AOAM531zwoWvWuzd59vyKIosi9jB0KLosLzSJB+mH4x31myWTPQY7ktD
 LPfvB5GOmbpMaHY/5pbEMJjTnadBPi0=
X-Google-Smtp-Source: ABdhPJwQuzpQBiEmalIjadR3IXS6fJMe7GkesAKQx1BtbbrGjWQDgTvpwFIBVY3vlo5b4wP/h11k1A==
X-Received: by 2002:a1c:dd09:: with SMTP id u9mr44695796wmg.70.1593983422134; 
 Sun, 05 Jul 2020 14:10:22 -0700 (PDT)
Received: from localhost.localdomain (1.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.1])
 by smtp.gmail.com with ESMTPSA id r8sm21102004wrp.40.2020.07.05.14.10.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 05 Jul 2020 14:10:21 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 3/4] hw/sd/milkymist: Create the SDBus at init()
Date: Sun,  5 Jul 2020 23:10:15 +0200
Message-Id: <20200705211016.15241-4-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200705211016.15241-1-f4bug@amsat.org>
References: <20200705211016.15241-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::343;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x343.google.com
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Michael Walle <michael@walle.cc>,
 Alistair Francis <alistair@alistair23.me>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We don't need to wait until realize() to create the SDBus,
create it in init() directly.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/sd/milkymist-memcard.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/hw/sd/milkymist-memcard.c b/hw/sd/milkymist-memcard.c
index afdb8aa0c0..fb02309f07 100644
--- a/hw/sd/milkymist-memcard.c
+++ b/hw/sd/milkymist-memcard.c
@@ -261,6 +261,9 @@ static void milkymist_memcard_init(Object *obj)
     memory_region_init_io(&s->regs_region, OBJECT(s), &memcard_mmio_ops, s,
             "milkymist-memcard", R_MAX * 4);
     sysbus_init_mmio(dev, &s->regs_region);
+
+    qbus_create_inplace(&s->sdbus, sizeof(s->sdbus), TYPE_SD_BUS,
+                        DEVICE(obj), "sd-bus");
 }
 
 static void milkymist_memcard_realize(DeviceState *dev, Error **errp)
@@ -271,9 +274,6 @@ static void milkymist_memcard_realize(DeviceState *dev, Error **errp)
     DriveInfo *dinfo;
     Error *err = NULL;
 
-    qbus_create_inplace(&s->sdbus, sizeof(s->sdbus), TYPE_SD_BUS,
-                        dev, "sd-bus");
-
     /* Create and plug in the sd card */
     /* FIXME use a qdev drive property instead of drive_get_next() */
     dinfo = drive_get_next(IF_SD);
-- 
2.21.3



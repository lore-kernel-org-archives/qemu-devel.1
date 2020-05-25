Return-Path: <SRS0=XKWp=7H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B1B9C433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 25 May 2020 03:49:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 31C962075F
	for <qemu-devel@archiver.kernel.org>; Mon, 25 May 2020 03:49:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p3o1UhSH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 31C962075F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59380 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jd46l-00044a-Ef
	for qemu-devel@archiver.kernel.org; Sun, 24 May 2020 23:48:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46674)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jd431-0008Ap-1b; Sun, 24 May 2020 23:45:07 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:35812)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jd430-0006vb-1A; Sun, 24 May 2020 23:45:06 -0400
Received: by mail-wm1-x344.google.com with SMTP id n5so15455951wmd.0;
 Sun, 24 May 2020 20:45:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Xkslp0bcUbSqRBvOaVQSgMmVi3d4Gn9gVFXVfSGdOCE=;
 b=p3o1UhSHcL1RF1FW1OUze2JJ2p/w0TmE/a54omUR2LncONL1M3KyHs8OlX0t2d/a1G
 9ms71OanUt/8x5+NPlW42t077SUQVtT3X1KerdXSg85njVg37yZTk7HATO+J4F2GoSkm
 dhNJVk00f2Sf4Hee5TLVoC4qD4shMVetenr+oSJP9jE9c3KxeBesZIVO586dn1Ql5f1q
 MpIVs5kh9ow0lNx2n1D9yJ4MvhJWe78fW1hPN/cMGie0Dn56zgimmBc8GVGNbGIJvJih
 U5/5opBxsYmkSU2izMqEtx402+Dv2d2eHrKmgcPqSDsXau2IV+HKJuJt4FJYhh3CcpsP
 aPPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=Xkslp0bcUbSqRBvOaVQSgMmVi3d4Gn9gVFXVfSGdOCE=;
 b=c/yPQKEwPdWWpn4Fmx/SF6tdWP7oisG/Sj2CZttXMvXTPKE7zF2XsaO2egPJJw9tif
 mcMk/ZWNnJbNKqPOPe3YYFfYRJeyov9f7a0/zaNmG8OqL4U+7/Xf3Eu31PcXYhscEwLz
 hQaI8GsGy25HOIR7LUhza0p3y012OfdN37Ggot20Nqr1OWt+Osmh955+1bM2Rp8Vf9+l
 nBDumUU5v0kysRWT+szg1iPZdDCk5xPIS5bBjStG1Ii55BJidpX0+ocEuAvv0pqckTTG
 sCfalQRwpx3QeAzax05EPpCH2AqJHnNYHRK4yZV+PIftMpTBtzfGXnMqvQKrLnozv04M
 eyLA==
X-Gm-Message-State: AOAM530gHhiN3jDmOhnrJERm/anHlz/d9nzRB2xQqIWVBptR/gMoqBfy
 /F3K6FJ5MnGFMZURsZ41MkWLkNz/hUM=
X-Google-Smtp-Source: ABdhPJzR8JVfw0S5M36v0bNBGQtde4r8uiIOX2J/wq2Jh7THGrwde9MgbuPecMqdrbOzz0BW0aSY5g==
X-Received: by 2002:a7b:cbc5:: with SMTP id n5mr23647343wmi.110.1590378303557; 
 Sun, 24 May 2020 20:45:03 -0700 (PDT)
Received: from localhost.localdomain (71.red-88-21-204.staticip.rima-tde.net.
 [88.21.204.71])
 by smtp.gmail.com with ESMTPSA id n9sm17555150wmj.5.2020.05.24.20.45.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 24 May 2020 20:45:02 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 2/4] hw/display/dpcd: Fix memory region size
Date: Mon, 25 May 2020 05:44:57 +0200
Message-Id: <20200525034459.28535-3-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200525034459.28535-1-f4bug@amsat.org>
References: <20200525034459.28535-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::344;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x344.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-trivial@nongnu.org,
 Alistair Francis <alistair@alistair23.me>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 qemu-arm@nongnu.org, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The memory region size is 512K.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/display/dpcd.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/display/dpcd.c b/hw/display/dpcd.c
index 170545c605..0c1b7b35fb 100644
--- a/hw/display/dpcd.c
+++ b/hw/display/dpcd.c
@@ -1,5 +1,5 @@
 /*
- * dpcd.c
+ * Xilinx Display Port Control Data
  *
  *  Copyright (C) 2015 : GreenSocs Ltd
  *      http://www.greensocs.com/ , email: info@greensocs.com
@@ -137,7 +137,7 @@ static void dpcd_init(Object *obj)
 {
     DPCDState *s = DPCD(obj);
 
-    memory_region_init_io(&s->iomem, obj, &aux_ops, s, TYPE_DPCD, 0x7FFFF);
+    memory_region_init_io(&s->iomem, obj, &aux_ops, s, TYPE_DPCD, 0x80000);
     aux_init_mmio(AUX_SLAVE(obj), &s->iomem);
 }
 
-- 
2.21.3



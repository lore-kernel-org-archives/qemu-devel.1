Return-Path: <SRS0=rz2F=DU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3883EC433E7
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 20:50:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9A6E720878
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 20:50:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rajKc07J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A6E720878
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58900 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kSRFx-0006t6-EH
	for qemu-devel@archiver.kernel.org; Tue, 13 Oct 2020 16:50:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32922)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kSREm-0005lA-Pu
 for qemu-devel@nongnu.org; Tue, 13 Oct 2020 16:49:36 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c]:41295)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kSREl-0002s5-9m
 for qemu-devel@nongnu.org; Tue, 13 Oct 2020 16:49:36 -0400
Received: by mail-wr1-x42c.google.com with SMTP id s9so982800wro.8
 for <qemu-devel@nongnu.org>; Tue, 13 Oct 2020 13:49:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=6qMlhkEv9iKK/AzILGVv++UgKiF/26CFqopHWYu/hic=;
 b=rajKc07J3mY7U2PABxj/aJvWzXSqs2J9CMV/Ke9q+2rZDt5FvoHDWQ0O6nuAlrQNmd
 rhbiWjyn49ELobw4orVjaG/7zERAyUwfQTuCd5ClHi68xRwwR13WVbuY5R7qpDNSSsGG
 bxYnBAPT9sYZ5c4jOmhdfS3hSE0i1TBcGCnnK82h9eaKpX+TGh2taqkn8fduHTHJJL2y
 WExi1pE+msBBWVMC43tPH94t8BWUOh3iFP6SNusWHeKIggVQqDw+aLHg3GT9z1WJ4x2u
 OUIY2G8WJqbmwU6CfunKzrWTlUrhSs2VQEOyadECiBO/1Dcg7FuymexjCUz4xoFGqOQi
 nK6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=6qMlhkEv9iKK/AzILGVv++UgKiF/26CFqopHWYu/hic=;
 b=t/taBHC2WgfprgjNLBfx8ZnKU85YUYJ9m6OUzumGMu1X0l6IQJ7Gy1ZBAOIw7gzGYZ
 Sw2l7hN8cJsj+S14yGF7TbrwI5U4RIupWHs1fvXE4HARyKPiL0hYUtorRWQxPw+vTxQ4
 TwAi8aLAE/8i9R76qbtV0PzmWmvGbh0CQmGa+R8vs22PkYdnN6agpfUIF7SzkVqCapD6
 lOGPSY6NHMI3aP3zcht3haqmxK/8IXqGTgrZSAKdvY8adSVSSRfzOj+BbN5RYOPZfOIz
 IJt2nvLUM5x8REIRnSPI9Ai7fsNI3UF0FYqLeV2/ib+rkTByLoCeEutidc5BizWx5wF/
 zfIw==
X-Gm-Message-State: AOAM532Y9TXUtq5GlZl5S30aBoGF8ps2b7+G6vu5JTWlZN4nCZnq/WvB
 +BJe0ktaSGI7VvpmQapuHJND7/ARDdo=
X-Google-Smtp-Source: ABdhPJxyvpP0pSvBkWbixki03S6cs+o2gpNBe3yLdFpF0vMs4bo59C4Nyv7WJK90o1dwmENE50+vwA==
X-Received: by 2002:adf:f1c8:: with SMTP id z8mr1677165wro.371.1602622173746; 
 Tue, 13 Oct 2020 13:49:33 -0700 (PDT)
Received: from x1w.redhat.com (106.red-83-59-162.dynamicip.rima-tde.net.
 [83.59.162.106])
 by smtp.gmail.com with ESMTPSA id l8sm1089196wrn.28.2020.10.13.13.49.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Oct 2020 13:49:33 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 1/3] hw/misc/mac_via: Make generic via_irq_request() from
 via1_irq_request()
Date: Tue, 13 Oct 2020 22:49:25 +0200
Message-Id: <20201013204927.3660030-2-f4bug@amsat.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201013204927.3660030-1-f4bug@amsat.org>
References: <20201013204927.3660030-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x42c.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.249,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25,
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
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Rewrite via1_irq_request() as generic via_irq_request().

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/misc/mac_via.c | 31 +++++++++++++++----------------
 1 file changed, 15 insertions(+), 16 deletions(-)

diff --git a/hw/misc/mac_via.c b/hw/misc/mac_via.c
index 6db62dab7db..9e64c2521fc 100644
--- a/hw/misc/mac_via.c
+++ b/hw/misc/mac_via.c
@@ -324,6 +324,20 @@ static void via1_one_second_update(MOS6522Q800VIA1State *v1s)
     }
 }
 
+static void via_irq_request(void *opaque, int irq, int level)
+{
+    MOS6522State *s = MOS6522(opaque);
+    MOS6522DeviceClass *mdc = MOS6522_GET_CLASS(s);
+
+    if (level) {
+        s->ifr |= 1 << irq;
+    } else {
+        s->ifr &= ~(1 << irq);
+    }
+
+    mdc->update_irq(s);
+}
+
 static void via1_VBL(void *opaque)
 {
     MOS6522Q800VIA1State *v1s = opaque;
@@ -348,21 +362,6 @@ static void via1_one_second(void *opaque)
     via1_one_second_update(v1s);
 }
 
-static void via1_irq_request(void *opaque, int irq, int level)
-{
-    MOS6522Q800VIA1State *v1s = opaque;
-    MOS6522State *s = MOS6522(v1s);
-    MOS6522DeviceClass *mdc = MOS6522_GET_CLASS(s);
-
-    if (level) {
-        s->ifr |= 1 << irq;
-    } else {
-        s->ifr &= ~(1 << irq);
-    }
-
-    mdc->update_irq(s);
-}
-
 static void via2_irq_request(void *opaque, int irq, int level)
 {
     MOS6522Q800VIA2State *v2s = opaque;
@@ -1195,7 +1194,7 @@ static void mos6522_q800_via1_reset(DeviceState *dev)
 
 static void mos6522_q800_via1_init(Object *obj)
 {
-    qdev_init_gpio_in_named(DEVICE(obj), via1_irq_request, "via1-irq",
+    qdev_init_gpio_in_named(DEVICE(obj), via_irq_request, "via1-irq",
                             VIA1_IRQ_NB);
 }
 
-- 
2.26.2



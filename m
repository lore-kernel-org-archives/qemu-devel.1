Return-Path: <SRS0=QiA4=7D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E35D9C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 19:27:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A123C207D3
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 19:27:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bmzlmqcj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A123C207D3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57060 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbqr1-0001JK-S9
	for qemu-devel@archiver.kernel.org; Thu, 21 May 2020 15:27:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38140)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jbqgN-0002ts-Oo
 for qemu-devel@nongnu.org; Thu, 21 May 2020 15:16:43 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c]:38701)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jbqgM-0000Te-M4
 for qemu-devel@nongnu.org; Thu, 21 May 2020 15:16:43 -0400
Received: by mail-wm1-x32c.google.com with SMTP id u12so2758361wmd.3
 for <qemu-devel@nongnu.org>; Thu, 21 May 2020 12:16:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=YOXfD2pneFZXI2RE/b2MMOUSrD0bIY/e/3jbjeg7p5o=;
 b=bmzlmqcj9N1OqivZfhyLltPCg/Xfn88Ygb3/8HP2oZ5ZE2bsemkdA59jaXM7GcTrRu
 3hOjHfW4U6BtmVvZA30IpkGTB0UCQgH2Pp3nw3lywiB97sksBc5gpdneyKpn9BcmLU+0
 yxExqlPlOG9/d+uUEGdGjhPxKRnFYvXq6IrYfOb/QfYThRlkCp2bal0tmIrPiadE3CkT
 GzO2QIQkQ3STRIq/i2KmOK9KT6+ofweAu5x/hqa7eiJCR18Xx6olXLh9LeqjTawBXzOU
 O2JsP26oS5oQmI0u2RTQoJQZwPqg4unZd+a/pbFYVeHEO9u2mb/BYIV/VWjxMWHocb5P
 F6Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=YOXfD2pneFZXI2RE/b2MMOUSrD0bIY/e/3jbjeg7p5o=;
 b=TaZATwlm1Kxclwc+ZgnDZ9U+mJ37bkko2OjHDBdiGJ1RVL79zKnW/iIIA1ft2VSyHx
 VIWOdGK6blAqoPxwDCvIDpc7quukzquWb1G6CiOwkGSG957hpq/UENuBUnZgaqL5QB7k
 3P74WYeFX57DXfr63EyWxTDBpeayGg3hHB7+pMw0UYOmktbbWNe0vDvDGAnWd4176wvm
 oF0REvMbs4FHrfmTRosaRmUtpVsVpk31/1Z//ohh55IZz2gNSHAd5N3bg71XiUe3I8Cg
 5d+dOzrfo2VBBUwOn4WEnkprN0KNC99u/V8qyLKKHf9WJVG7gl3xhqnYX5LjT21fApRM
 N51g==
X-Gm-Message-State: AOAM531HQEcyPfE71lmFlNgNbK+oP+46mEpmf1eBi1oY0ir8fcbF17eI
 LpNHilsvCn7RKpJkWaHTPKwFaW7mDpRdxA==
X-Google-Smtp-Source: ABdhPJwqWMU6/Qjy8eiERVROpgr9+gxiuoozc6AP00ZURpMDVBfT4QHIGirvo+s60Cns7PX/AFGrHw==
X-Received: by 2002:a1c:1904:: with SMTP id 4mr9689280wmz.125.1590088600884;
 Thu, 21 May 2020 12:16:40 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id z124sm7335100wmg.20.2020.05.21.12.16.39
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 May 2020 12:16:40 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 24/29] ARM: PL061: Introduce N_GPIOS
Date: Thu, 21 May 2020 20:16:05 +0100
Message-Id: <20200521191610.10941-25-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200521191610.10941-1-peter.maydell@linaro.org>
References: <20200521191610.10941-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32c.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Geert Uytterhoeven <geert+renesas@glider.be>

Add a definition for the number of GPIO lines controlled by a PL061
instance, and use it instead of the hardcoded magic value 8.

Suggested-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Message-id: 20200519085143.1376-1-geert+renesas@glider.be
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/gpio/pl061.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/hw/gpio/pl061.c b/hw/gpio/pl061.c
index 2a828260bdb..6d3c36bc16c 100644
--- a/hw/gpio/pl061.c
+++ b/hw/gpio/pl061.c
@@ -36,6 +36,8 @@ static const uint8_t pl061_id_luminary[12] =
 #define TYPE_PL061 "pl061"
 #define PL061(obj) OBJECT_CHECK(PL061State, (obj), TYPE_PL061)
 
+#define N_GPIOS 8
+
 typedef struct PL061State {
     SysBusDevice parent_obj;
 
@@ -62,7 +64,7 @@ typedef struct PL061State {
     uint32_t cr;
     uint32_t amsel;
     qemu_irq irq;
-    qemu_irq out[8];
+    qemu_irq out[N_GPIOS];
     const unsigned char *id;
     uint32_t rsvd_start; /* reserved area: [rsvd_start, 0xfcc] */
 } PL061State;
@@ -112,7 +114,7 @@ static void pl061_update(PL061State *s)
     changed = s->old_out_data ^ out;
     if (changed) {
         s->old_out_data = out;
-        for (i = 0; i < 8; i++) {
+        for (i = 0; i < N_GPIOS; i++) {
             mask = 1 << i;
             if (changed & mask) {
                 DPRINTF("Set output %d = %d\n", i, (out & mask) != 0);
@@ -125,7 +127,7 @@ static void pl061_update(PL061State *s)
     changed = (s->old_in_data ^ s->data) & ~s->dir;
     if (changed) {
         s->old_in_data = s->data;
-        for (i = 0; i < 8; i++) {
+        for (i = 0; i < N_GPIOS; i++) {
             mask = 1 << i;
             if (changed & mask) {
                 DPRINTF("Changed input %d = %d\n", i, (s->data & mask) != 0);
@@ -364,8 +366,8 @@ static void pl061_init(Object *obj)
     memory_region_init_io(&s->iomem, obj, &pl061_ops, s, "pl061", 0x1000);
     sysbus_init_mmio(sbd, &s->iomem);
     sysbus_init_irq(sbd, &s->irq);
-    qdev_init_gpio_in(dev, pl061_set_irq, 8);
-    qdev_init_gpio_out(dev, s->out, 8);
+    qdev_init_gpio_in(dev, pl061_set_irq, N_GPIOS);
+    qdev_init_gpio_out(dev, s->out, N_GPIOS);
 }
 
 static void pl061_class_init(ObjectClass *klass, void *data)
-- 
2.20.1



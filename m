Return-Path: <SRS0=4umr=AO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA4F8C433E1
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 17:07:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 97D3220760
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 17:07:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Xh8MW3xB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97D3220760
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44558 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jrP9g-0000Rz-Or
	for qemu-devel@archiver.kernel.org; Fri, 03 Jul 2020 13:07:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50276)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jrOxQ-0005I9-1w
 for qemu-devel@nongnu.org; Fri, 03 Jul 2020 12:54:36 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335]:35620)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jrOxO-0005iJ-68
 for qemu-devel@nongnu.org; Fri, 03 Jul 2020 12:54:35 -0400
Received: by mail-wm1-x335.google.com with SMTP id l2so33241445wmf.0
 for <qemu-devel@nongnu.org>; Fri, 03 Jul 2020 09:54:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=ZVAij/KCpWXCOhgRXrDw7xB6C1uHCslS7BtBDspLBtw=;
 b=Xh8MW3xB9bUBnI1gzX3cmnQ7sa+uRTGG5OpR43q86k4qx0dbCVhdSlVyGow/qTqQCb
 WGlwQ1IkRAvSzOKvMgEhesTo7LHulDlZ4zo09if4Olqx2j3lKAvFlBFthBb4XN1nYOQ/
 fy4Dq/WU2sF9df5w3ooqN1bWRgv87sYezkSVSO/uHjIjRyNIpELHdum+uDD/tqDJTSyi
 trD2q8y/Z7IwTJxDq+57UWXOBNIJOqlgMhJECbkI21WUwmQIreed/3Edvnf61tGVx/0W
 0nnIy/+4UjYn/5YUDvv4c43pmDeO6MbWx6G1UJaSwcFbCIJpXRClGLukcZHSr7B3Y6w5
 bT7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=ZVAij/KCpWXCOhgRXrDw7xB6C1uHCslS7BtBDspLBtw=;
 b=SHftWq3S25HPNt22Hd/2uFzx+RYUcA2I4ZcQKjZG0MKkBFiQI1E5QTCn/8UZ9iKAvi
 3qVNBlRMZ5kSImYUUf/LL4KCti597Ayq97GcQ5K0AGFXE5teZcPL4L4G+T5fmNPxZ2MB
 Hc22d6QZyoMLsHYVzjmYnhsC+Y6xK9ijVKncIK1+Yx9zoMWbdT3p2efnaj6R/UBEMW1I
 ZP7u99AqU181wKFPLRtf8X5+ggcoypkUtZ5ew0ttpnBwrkFvnn8r/czLtzx+p/cnl7EV
 uJDMD4bTYm9NvUdBNIH7ekxChpygLU1OnnuVAOmbBAlAPVkSNsu9P0RK/+7bUxRoy5iG
 G++g==
X-Gm-Message-State: AOAM530KAKPTjewCDYGHMo1yUZE2gsWP9Q41yyIF2Pjgpjiny+IZqkB9
 uiE3cy9yTTo1seVjwLbisyvPKnUA2RR3ng==
X-Google-Smtp-Source: ABdhPJxI/9MfGAAzGkMIZMLDKjfnCzLVGLJcmzF62rKHAVhPstFLaXbZf2Q/O5sLn41+T/hM5bzrLg==
X-Received: by 2002:a1c:3dc3:: with SMTP id k186mr39360530wma.66.1593795272401; 
 Fri, 03 Jul 2020 09:54:32 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id j15sm5574224wrx.69.2020.07.03.09.54.31
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Jul 2020 09:54:31 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 22/34] hw/misc/max111x: provide QOM properties for setting
 initial values
Date: Fri,  3 Jul 2020 17:53:53 +0100
Message-Id: <20200703165405.17672-23-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200703165405.17672-1-peter.maydell@linaro.org>
References: <20200703165405.17672-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x335.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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

Add some QOM properties to the max111x ADC device to allow the
initial values to be configured. Currently this is done by
board code calling max111x_set_input() after it creates the
device, which doesn't work on system reset.

This requires us to implement a reset method for this device,
so while we're doing that make sure we reset the other parts
of the device state.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-id: 20200628142429.17111-7-peter.maydell@linaro.org
---
 hw/misc/max111x.c | 57 ++++++++++++++++++++++++++++++++++++++---------
 1 file changed, 47 insertions(+), 10 deletions(-)

diff --git a/hw/misc/max111x.c b/hw/misc/max111x.c
index 2b87bdee5b7..d0e5534e4f5 100644
--- a/hw/misc/max111x.c
+++ b/hw/misc/max111x.c
@@ -15,11 +15,15 @@
 #include "hw/ssi/ssi.h"
 #include "migration/vmstate.h"
 #include "qemu/module.h"
+#include "hw/qdev-properties.h"
 
 typedef struct {
     SSISlave parent_obj;
 
     qemu_irq interrupt;
+    /* Values of inputs at system reset (settable by QOM property) */
+    uint8_t reset_input[8];
+
     uint8_t tb1, rb2, rb3;
     int cycle;
 
@@ -135,16 +139,6 @@ static int max111x_init(SSISlave *d, int inputs)
     qdev_init_gpio_out(dev, &s->interrupt, 1);
 
     s->inputs = inputs;
-    /* TODO: add a user interface for setting these */
-    s->input[0] = 0xf0;
-    s->input[1] = 0xe0;
-    s->input[2] = 0xd0;
-    s->input[3] = 0xc0;
-    s->input[4] = 0xb0;
-    s->input[5] = 0xa0;
-    s->input[6] = 0x90;
-    s->input[7] = 0x80;
-    s->com = 0;
 
     vmstate_register(VMSTATE_IF(dev), VMSTATE_INSTANCE_ID_ANY,
                      &vmstate_max111x, s);
@@ -168,11 +162,50 @@ void max111x_set_input(DeviceState *dev, int line, uint8_t value)
     s->input[line] = value;
 }
 
+static void max111x_reset(DeviceState *dev)
+{
+    MAX111xState *s = MAX_111X(dev);
+    int i;
+
+    for (i = 0; i < s->inputs; i++) {
+        s->input[i] = s->reset_input[i];
+    }
+    s->com = 0;
+    s->tb1 = 0;
+    s->rb2 = 0;
+    s->rb3 = 0;
+    s->cycle = 0;
+}
+
+static Property max1110_properties[] = {
+    /* Reset values for ADC inputs */
+    DEFINE_PROP_UINT8("input0", MAX111xState, reset_input[0], 0xf0),
+    DEFINE_PROP_UINT8("input1", MAX111xState, reset_input[1], 0xe0),
+    DEFINE_PROP_UINT8("input2", MAX111xState, reset_input[2], 0xd0),
+    DEFINE_PROP_UINT8("input3", MAX111xState, reset_input[3], 0xc0),
+    DEFINE_PROP_END_OF_LIST(),
+};
+
+static Property max1111_properties[] = {
+    /* Reset values for ADC inputs */
+    DEFINE_PROP_UINT8("input0", MAX111xState, reset_input[0], 0xf0),
+    DEFINE_PROP_UINT8("input1", MAX111xState, reset_input[1], 0xe0),
+    DEFINE_PROP_UINT8("input2", MAX111xState, reset_input[2], 0xd0),
+    DEFINE_PROP_UINT8("input3", MAX111xState, reset_input[3], 0xc0),
+    DEFINE_PROP_UINT8("input4", MAX111xState, reset_input[4], 0xb0),
+    DEFINE_PROP_UINT8("input5", MAX111xState, reset_input[5], 0xa0),
+    DEFINE_PROP_UINT8("input6", MAX111xState, reset_input[6], 0x90),
+    DEFINE_PROP_UINT8("input7", MAX111xState, reset_input[7], 0x80),
+    DEFINE_PROP_END_OF_LIST(),
+};
+
 static void max111x_class_init(ObjectClass *klass, void *data)
 {
     SSISlaveClass *k = SSI_SLAVE_CLASS(klass);
+    DeviceClass *dc = DEVICE_CLASS(klass);
 
     k->transfer = max111x_transfer;
+    dc->reset = max111x_reset;
 }
 
 static const TypeInfo max111x_info = {
@@ -186,8 +219,10 @@ static const TypeInfo max111x_info = {
 static void max1110_class_init(ObjectClass *klass, void *data)
 {
     SSISlaveClass *k = SSI_SLAVE_CLASS(klass);
+    DeviceClass *dc = DEVICE_CLASS(klass);
 
     k->realize = max1110_realize;
+    device_class_set_props(dc, max1110_properties);
 }
 
 static const TypeInfo max1110_info = {
@@ -199,8 +234,10 @@ static const TypeInfo max1110_info = {
 static void max1111_class_init(ObjectClass *klass, void *data)
 {
     SSISlaveClass *k = SSI_SLAVE_CLASS(klass);
+    DeviceClass *dc = DEVICE_CLASS(klass);
 
     k->realize = max1111_realize;
+    device_class_set_props(dc, max1111_properties);
 }
 
 static const TypeInfo max1111_info = {
-- 
2.20.1



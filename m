Return-Path: <SRS0=gwGE=EC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DD56C388F9
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 12:42:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C9848218AC
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 12:42:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XmdBuYLG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C9848218AC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33236 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXOJR-0007Hg-KZ
	for qemu-devel@archiver.kernel.org; Tue, 27 Oct 2020 08:42:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52470)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kXNPy-00021z-EX
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 07:45:34 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c]:42537)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kXNPt-0004lU-Ey
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 07:45:34 -0400
Received: by mail-wr1-x42c.google.com with SMTP id j7so1510781wrt.9
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2020 04:45:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=5F318VQce9jxLOpALrXTlZ2x/bb4+aO6Wok/6fUKBPA=;
 b=XmdBuYLGjBTdtE+5Q8cU6/YS9P5IySvTv1blz3zByxSVnmW5v8s/K3IG3hCpLNdyk2
 bYG8BbA8wPwUSwwiq24VGqXseuZU9fozWSMXMHvKDY1O7ziGirBqgzAgQKOCgXmxA5Uf
 +qrNnLQQv7/Ci/+1vK5eudP0nvWkMrv200l70jpL+sETIvakvdGTxk4VBbQk3jzct8l0
 2V24VEVFEz683/XobsJQc4+JoDSW58a0P7aElRA+L/6MvLgabm+azvowuhb8mayfjlUZ
 DuxNN/bnWwQvM1yAqFcG6dNgA+ID7f2VmskuqK31Rhr49Eaz3fn4R6UFpflFXFRREWyR
 VKqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=5F318VQce9jxLOpALrXTlZ2x/bb4+aO6Wok/6fUKBPA=;
 b=k8PReuSiAW7Qe2wd+YONv403iAERH8GDpUVPGTso68+WE2KWXV2bdNquRgXrjkL2Yu
 vg5Lp2MDT4oM+u8B/SdoP8uY+7knrLqsgVmncC2DjgLrhxEQBTco1DmzZnBkEBeKvSzX
 z6bL7sjB4SuGk5KOC/lvOhT27GPQ+JWCOvqGC9ccQE5cyx+1IQQ25zJYOmZMQ2stMHbV
 dU7ZeurV4TcI9Qy7PGalhTfc2T2VUtS4xFXHJuYFPAlg07HpzcJhqXQL/Mlcn7wEmMtO
 bUyfqx4USPZFxuLcgrobGmPWIeS41kL9OulVupctPpcrZttguDob/6WvQJeVsacEcRp7
 SPjQ==
X-Gm-Message-State: AOAM530hUivdCYXN2oHU5LP+Rl0/Dg2pwyN7jDVJCaInt0h1FZBh9O+3
 gnD92bqeobuxCVvDXj0A1/4XiYEzEWpcCQ==
X-Google-Smtp-Source: ABdhPJw/z5IE6cXX5igW8SYjygtuwLIKlocZ/JDuJiFehILFJ1cujkC5oRQ1VXBRgbh94szza9fzSg==
X-Received: by 2002:adf:9f4c:: with SMTP id f12mr2415066wrg.108.1603799127517; 
 Tue, 27 Oct 2020 04:45:27 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id 32sm1712203wro.31.2020.10.27.04.45.25
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Oct 2020 04:45:26 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 37/48] hw/misc/bcm2835_cprman: add a PLL channel skeleton
 implementation
Date: Tue, 27 Oct 2020 11:44:27 +0000
Message-Id: <20201027114438.17662-38-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201027114438.17662-1-peter.maydell@linaro.org>
References: <20201027114438.17662-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42c.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Luc Michel <luc@lmichel.fr>

PLLs are composed of multiple channels. Each channel outputs one clock
signal. They are modeled as one device taking the PLL generated clock as
input, and outputting a new clock.

A channel shares the CM register with its parent PLL, and has its own
A2W_CTRL register. A write to the CM register will trigger an update of
the PLL and all its channels, while a write to an A2W_CTRL channel
register will update the required channel only.

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Tested-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Signed-off-by: Luc Michel <luc@lmichel.fr>
Tested-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/misc/bcm2835_cprman.h           |  44 ++++++
 include/hw/misc/bcm2835_cprman_internals.h | 146 +++++++++++++++++++
 hw/misc/bcm2835_cprman.c                   | 155 +++++++++++++++++++--
 3 files changed, 337 insertions(+), 8 deletions(-)

diff --git a/include/hw/misc/bcm2835_cprman.h b/include/hw/misc/bcm2835_cprman.h
index 5c442e6ff93..e1a1b33f8b8 100644
--- a/include/hw/misc/bcm2835_cprman.h
+++ b/include/hw/misc/bcm2835_cprman.h
@@ -31,6 +31,31 @@ typedef enum CprmanPll {
     CPRMAN_NUM_PLL
 } CprmanPll;
 
+typedef enum CprmanPllChannel {
+    CPRMAN_PLLA_CHANNEL_DSI0 = 0,
+    CPRMAN_PLLA_CHANNEL_CORE,
+    CPRMAN_PLLA_CHANNEL_PER,
+    CPRMAN_PLLA_CHANNEL_CCP2,
+
+    CPRMAN_PLLC_CHANNEL_CORE2,
+    CPRMAN_PLLC_CHANNEL_CORE1,
+    CPRMAN_PLLC_CHANNEL_PER,
+    CPRMAN_PLLC_CHANNEL_CORE0,
+
+    CPRMAN_PLLD_CHANNEL_DSI0,
+    CPRMAN_PLLD_CHANNEL_CORE,
+    CPRMAN_PLLD_CHANNEL_PER,
+    CPRMAN_PLLD_CHANNEL_DSI1,
+
+    CPRMAN_PLLH_CHANNEL_AUX,
+    CPRMAN_PLLH_CHANNEL_RCAL,
+    CPRMAN_PLLH_CHANNEL_PIX,
+
+    CPRMAN_PLLB_CHANNEL_ARM,
+
+    CPRMAN_NUM_PLL_CHANNEL,
+} CprmanPllChannel;
+
 typedef struct CprmanPllState {
     /*< private >*/
     DeviceState parent_obj;
@@ -48,6 +73,24 @@ typedef struct CprmanPllState {
     Clock *out;
 } CprmanPllState;
 
+typedef struct CprmanPllChannelState {
+    /*< private >*/
+    DeviceState parent_obj;
+
+    /*< public >*/
+    CprmanPllChannel id;
+    CprmanPll parent;
+
+    uint32_t *reg_cm;
+    uint32_t hold_mask;
+    uint32_t load_mask;
+    uint32_t *reg_a2w_ctrl;
+    int fixed_divider;
+
+    Clock *pll_in;
+    Clock *out;
+} CprmanPllChannelState;
+
 struct BCM2835CprmanState {
     /*< private >*/
     SysBusDevice parent_obj;
@@ -56,6 +99,7 @@ struct BCM2835CprmanState {
     MemoryRegion iomem;
 
     CprmanPllState plls[CPRMAN_NUM_PLL];
+    CprmanPllChannelState channels[CPRMAN_NUM_PLL_CHANNEL];
 
     uint32_t regs[CPRMAN_NUM_REGS];
     uint32_t xosc_freq;
diff --git a/include/hw/misc/bcm2835_cprman_internals.h b/include/hw/misc/bcm2835_cprman_internals.h
index 7aa46c6e188..7409ddb024b 100644
--- a/include/hw/misc/bcm2835_cprman_internals.h
+++ b/include/hw/misc/bcm2835_cprman_internals.h
@@ -13,9 +13,12 @@
 #include "hw/misc/bcm2835_cprman.h"
 
 #define TYPE_CPRMAN_PLL "bcm2835-cprman-pll"
+#define TYPE_CPRMAN_PLL_CHANNEL "bcm2835-cprman-pll-channel"
 
 DECLARE_INSTANCE_CHECKER(CprmanPllState, CPRMAN_PLL,
                          TYPE_CPRMAN_PLL)
+DECLARE_INSTANCE_CHECKER(CprmanPllChannelState, CPRMAN_PLL_CHANNEL,
+                         TYPE_CPRMAN_PLL_CHANNEL)
 
 /* Register map */
 
@@ -100,6 +103,31 @@ REG32(A2W_PLLD_FRAC, 0x1240)
 REG32(A2W_PLLH_FRAC, 0x1260)
 REG32(A2W_PLLB_FRAC, 0x12e0)
 
+/* PLL channels */
+REG32(A2W_PLLA_DSI0, 0x1300)
+    FIELD(A2W_PLLx_CHANNELy, DIV, 0, 8)
+    FIELD(A2W_PLLx_CHANNELy, DISABLE, 8, 1)
+REG32(A2W_PLLA_CORE, 0x1400)
+REG32(A2W_PLLA_PER, 0x1500)
+REG32(A2W_PLLA_CCP2, 0x1600)
+
+REG32(A2W_PLLC_CORE2, 0x1320)
+REG32(A2W_PLLC_CORE1, 0x1420)
+REG32(A2W_PLLC_PER, 0x1520)
+REG32(A2W_PLLC_CORE0, 0x1620)
+
+REG32(A2W_PLLD_DSI0, 0x1340)
+REG32(A2W_PLLD_CORE, 0x1440)
+REG32(A2W_PLLD_PER, 0x1540)
+REG32(A2W_PLLD_DSI1, 0x1640)
+
+REG32(A2W_PLLH_AUX, 0x1360)
+REG32(A2W_PLLH_RCAL, 0x1460)
+REG32(A2W_PLLH_PIX, 0x1560)
+REG32(A2W_PLLH_STS, 0x1660)
+
+REG32(A2W_PLLB_ARM, 0x13e0)
+
 /* misc registers */
 REG32(CM_LOCK, 0x114)
     FIELD(CM_LOCK, FLOCKH, 12, 1)
@@ -173,4 +201,122 @@ static inline void set_pll_init_info(BCM2835CprmanState *s,
     pll->reg_a2w_frac = &s->regs[PLL_INIT_INFO[id].a2w_frac_offset];
 }
 
+
+/* PLL channel init info */
+typedef struct PLLChannelInitInfo {
+    const char *name;
+    CprmanPll parent;
+    size_t cm_offset;
+    uint32_t cm_hold_mask;
+    uint32_t cm_load_mask;
+    size_t a2w_ctrl_offset;
+    unsigned int fixed_divider;
+} PLLChannelInitInfo;
+
+#define FILL_PLL_CHANNEL_INIT_INFO_common(pll_, channel_)            \
+    .parent = CPRMAN_ ## pll_,                                       \
+    .cm_offset = R_CM_ ## pll_,                                      \
+    .cm_load_mask = R_CM_ ## pll_ ## _ ## LOAD ## channel_ ## _MASK, \
+    .a2w_ctrl_offset = R_A2W_ ## pll_ ## _ ## channel_
+
+#define FILL_PLL_CHANNEL_INIT_INFO(pll_, channel_)                   \
+    FILL_PLL_CHANNEL_INIT_INFO_common(pll_, channel_),               \
+    .cm_hold_mask = R_CM_ ## pll_ ## _ ## HOLD ## channel_ ## _MASK, \
+    .fixed_divider = 1
+
+#define FILL_PLL_CHANNEL_INIT_INFO_nohold(pll_, channel_) \
+    FILL_PLL_CHANNEL_INIT_INFO_common(pll_, channel_),    \
+    .cm_hold_mask = 0
+
+static PLLChannelInitInfo PLL_CHANNEL_INIT_INFO[] = {
+    [CPRMAN_PLLA_CHANNEL_DSI0] = {
+        .name = "plla-dsi0",
+        FILL_PLL_CHANNEL_INIT_INFO(PLLA, DSI0),
+    },
+    [CPRMAN_PLLA_CHANNEL_CORE] = {
+        .name = "plla-core",
+        FILL_PLL_CHANNEL_INIT_INFO(PLLA, CORE),
+    },
+    [CPRMAN_PLLA_CHANNEL_PER] = {
+        .name = "plla-per",
+        FILL_PLL_CHANNEL_INIT_INFO(PLLA, PER),
+    },
+    [CPRMAN_PLLA_CHANNEL_CCP2] = {
+        .name = "plla-ccp2",
+        FILL_PLL_CHANNEL_INIT_INFO(PLLA, CCP2),
+    },
+
+    [CPRMAN_PLLC_CHANNEL_CORE2] = {
+        .name = "pllc-core2",
+        FILL_PLL_CHANNEL_INIT_INFO(PLLC, CORE2),
+    },
+    [CPRMAN_PLLC_CHANNEL_CORE1] = {
+        .name = "pllc-core1",
+        FILL_PLL_CHANNEL_INIT_INFO(PLLC, CORE1),
+    },
+    [CPRMAN_PLLC_CHANNEL_PER] = {
+        .name = "pllc-per",
+        FILL_PLL_CHANNEL_INIT_INFO(PLLC, PER),
+    },
+    [CPRMAN_PLLC_CHANNEL_CORE0] = {
+        .name = "pllc-core0",
+        FILL_PLL_CHANNEL_INIT_INFO(PLLC, CORE0),
+    },
+
+    [CPRMAN_PLLD_CHANNEL_DSI0] = {
+        .name = "plld-dsi0",
+        FILL_PLL_CHANNEL_INIT_INFO(PLLD, DSI0),
+    },
+    [CPRMAN_PLLD_CHANNEL_CORE] = {
+        .name = "plld-core",
+        FILL_PLL_CHANNEL_INIT_INFO(PLLD, CORE),
+    },
+    [CPRMAN_PLLD_CHANNEL_PER] = {
+        .name = "plld-per",
+        FILL_PLL_CHANNEL_INIT_INFO(PLLD, PER),
+    },
+    [CPRMAN_PLLD_CHANNEL_DSI1] = {
+        .name = "plld-dsi1",
+        FILL_PLL_CHANNEL_INIT_INFO(PLLD, DSI1),
+    },
+
+    [CPRMAN_PLLH_CHANNEL_AUX] = {
+        .name = "pllh-aux",
+        .fixed_divider = 1,
+        FILL_PLL_CHANNEL_INIT_INFO_nohold(PLLH, AUX),
+    },
+    [CPRMAN_PLLH_CHANNEL_RCAL] = {
+        .name = "pllh-rcal",
+        .fixed_divider = 10,
+        FILL_PLL_CHANNEL_INIT_INFO_nohold(PLLH, RCAL),
+    },
+    [CPRMAN_PLLH_CHANNEL_PIX] = {
+        .name = "pllh-pix",
+        .fixed_divider = 10,
+        FILL_PLL_CHANNEL_INIT_INFO_nohold(PLLH, PIX),
+    },
+
+    [CPRMAN_PLLB_CHANNEL_ARM] = {
+        .name = "pllb-arm",
+        FILL_PLL_CHANNEL_INIT_INFO(PLLB, ARM),
+    },
+};
+
+#undef FILL_PLL_CHANNEL_INIT_INFO_nohold
+#undef FILL_PLL_CHANNEL_INIT_INFO
+#undef FILL_PLL_CHANNEL_INIT_INFO_common
+
+static inline void set_pll_channel_init_info(BCM2835CprmanState *s,
+                                             CprmanPllChannelState *channel,
+                                             CprmanPllChannel id)
+{
+    channel->id = id;
+    channel->parent = PLL_CHANNEL_INIT_INFO[id].parent;
+    channel->reg_cm = &s->regs[PLL_CHANNEL_INIT_INFO[id].cm_offset];
+    channel->hold_mask = PLL_CHANNEL_INIT_INFO[id].cm_hold_mask;
+    channel->load_mask = PLL_CHANNEL_INIT_INFO[id].cm_load_mask;
+    channel->reg_a2w_ctrl = &s->regs[PLL_CHANNEL_INIT_INFO[id].a2w_ctrl_offset];
+    channel->fixed_divider = PLL_CHANNEL_INIT_INFO[id].fixed_divider;
+}
+
 #endif
diff --git a/hw/misc/bcm2835_cprman.c b/hw/misc/bcm2835_cprman.c
index 144bcc289d6..12fa78181b5 100644
--- a/hw/misc/bcm2835_cprman.c
+++ b/hw/misc/bcm2835_cprman.c
@@ -132,6 +132,69 @@ static const TypeInfo cprman_pll_info = {
 };
 
 
+/* PLL channel */
+
+static void pll_channel_update(CprmanPllChannelState *channel)
+{
+    clock_update(channel->out, 0);
+}
+
+/* Update a PLL and all its channels */
+static void pll_update_all_channels(BCM2835CprmanState *s,
+                                    CprmanPllState *pll)
+{
+    size_t i;
+
+    pll_update(pll);
+
+    for (i = 0; i < CPRMAN_NUM_PLL_CHANNEL; i++) {
+        CprmanPllChannelState *channel = &s->channels[i];
+        if (channel->parent == pll->id) {
+            pll_channel_update(channel);
+        }
+    }
+}
+
+static void pll_channel_pll_in_update(void *opaque)
+{
+    pll_channel_update(CPRMAN_PLL_CHANNEL(opaque));
+}
+
+static void pll_channel_init(Object *obj)
+{
+    CprmanPllChannelState *s = CPRMAN_PLL_CHANNEL(obj);
+
+    s->pll_in = qdev_init_clock_in(DEVICE(s), "pll-in",
+                                   pll_channel_pll_in_update, s);
+    s->out = qdev_init_clock_out(DEVICE(s), "out");
+}
+
+static const VMStateDescription pll_channel_vmstate = {
+    .name = TYPE_CPRMAN_PLL_CHANNEL,
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .fields = (VMStateField[]) {
+        VMSTATE_CLOCK(pll_in, CprmanPllChannelState),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+static void pll_channel_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    dc->vmsd = &pll_channel_vmstate;
+}
+
+static const TypeInfo cprman_pll_channel_info = {
+    .name = TYPE_CPRMAN_PLL_CHANNEL,
+    .parent = TYPE_DEVICE,
+    .instance_size = sizeof(CprmanPllChannelState),
+    .class_init = pll_channel_class_init,
+    .instance_init = pll_channel_init,
+};
+
+
 /* CPRMAN "top level" model */
 
 static uint32_t get_cm_lock(const BCM2835CprmanState *s)
@@ -174,8 +237,32 @@ static uint64_t cprman_read(void *opaque, hwaddr offset,
     return r;
 }
 
-#define CASE_PLL_REGS(pll_)       \
-    case R_CM_ ## pll_:           \
+static inline void update_pll_and_channels_from_cm(BCM2835CprmanState *s,
+                                                   size_t idx)
+{
+    size_t i;
+
+    for (i = 0; i < CPRMAN_NUM_PLL; i++) {
+        if (PLL_INIT_INFO[i].cm_offset == idx) {
+            pll_update_all_channels(s, &s->plls[i]);
+            return;
+        }
+    }
+}
+
+static inline void update_channel_from_a2w(BCM2835CprmanState *s, size_t idx)
+{
+    size_t i;
+
+    for (i = 0; i < CPRMAN_NUM_PLL_CHANNEL; i++) {
+        if (PLL_CHANNEL_INIT_INFO[i].a2w_ctrl_offset == idx) {
+            pll_channel_update(&s->channels[i]);
+            return;
+        }
+    }
+}
+
+#define CASE_PLL_A2W_REGS(pll_) \
     case R_A2W_ ## pll_ ## _CTRL: \
     case R_A2W_ ## pll_ ## _ANA0: \
     case R_A2W_ ## pll_ ## _ANA1: \
@@ -200,29 +287,57 @@ static void cprman_write(void *opaque, hwaddr offset,
     s->regs[idx] = value;
 
     switch (idx) {
-    CASE_PLL_REGS(PLLA) :
+    case R_CM_PLLA ... R_CM_PLLH:
+    case R_CM_PLLB:
+        /*
+         * A given CM_PLLx register is shared by both the PLL and the channels
+         * of this PLL.
+         */
+        update_pll_and_channels_from_cm(s, idx);
+        break;
+
+    CASE_PLL_A2W_REGS(PLLA) :
         pll_update(&s->plls[CPRMAN_PLLA]);
         break;
 
-    CASE_PLL_REGS(PLLC) :
+    CASE_PLL_A2W_REGS(PLLC) :
         pll_update(&s->plls[CPRMAN_PLLC]);
         break;
 
-    CASE_PLL_REGS(PLLD) :
+    CASE_PLL_A2W_REGS(PLLD) :
         pll_update(&s->plls[CPRMAN_PLLD]);
         break;
 
-    CASE_PLL_REGS(PLLH) :
+    CASE_PLL_A2W_REGS(PLLH) :
         pll_update(&s->plls[CPRMAN_PLLH]);
         break;
 
-    CASE_PLL_REGS(PLLB) :
+    CASE_PLL_A2W_REGS(PLLB) :
         pll_update(&s->plls[CPRMAN_PLLB]);
         break;
+
+    case R_A2W_PLLA_DSI0:
+    case R_A2W_PLLA_CORE:
+    case R_A2W_PLLA_PER:
+    case R_A2W_PLLA_CCP2:
+    case R_A2W_PLLC_CORE2:
+    case R_A2W_PLLC_CORE1:
+    case R_A2W_PLLC_PER:
+    case R_A2W_PLLC_CORE0:
+    case R_A2W_PLLD_DSI0:
+    case R_A2W_PLLD_CORE:
+    case R_A2W_PLLD_PER:
+    case R_A2W_PLLD_DSI1:
+    case R_A2W_PLLH_AUX:
+    case R_A2W_PLLH_RCAL:
+    case R_A2W_PLLH_PIX:
+    case R_A2W_PLLB_ARM:
+        update_channel_from_a2w(s, idx);
+        break;
     }
 }
 
-#undef CASE_PLL_REGS
+#undef CASE_PLL_A2W_REGS
 
 static const MemoryRegionOps cprman_ops = {
     .read = cprman_read,
@@ -254,6 +369,10 @@ static void cprman_reset(DeviceState *dev)
         device_cold_reset(DEVICE(&s->plls[i]));
     }
 
+    for (i = 0; i < CPRMAN_NUM_PLL_CHANNEL; i++) {
+        device_cold_reset(DEVICE(&s->channels[i]));
+    }
+
     clock_update_hz(s->xosc, s->xosc_freq);
 }
 
@@ -268,6 +387,13 @@ static void cprman_init(Object *obj)
         set_pll_init_info(s, &s->plls[i], i);
     }
 
+    for (i = 0; i < CPRMAN_NUM_PLL_CHANNEL; i++) {
+        object_initialize_child(obj, PLL_CHANNEL_INIT_INFO[i].name,
+                                &s->channels[i],
+                                TYPE_CPRMAN_PLL_CHANNEL);
+        set_pll_channel_init_info(s, &s->channels[i], i);
+    }
+
     s->xosc = clock_new(obj, "xosc");
 
     memory_region_init_io(&s->iomem, obj, &cprman_ops,
@@ -289,6 +415,18 @@ static void cprman_realize(DeviceState *dev, Error **errp)
             return;
         }
     }
+
+    for (i = 0; i < CPRMAN_NUM_PLL_CHANNEL; i++) {
+        CprmanPllChannelState *channel = &s->channels[i];
+        CprmanPll parent = PLL_CHANNEL_INIT_INFO[i].parent;
+        Clock *parent_clk = s->plls[parent].out;
+
+        clock_set_source(channel->pll_in, parent_clk);
+
+        if (!qdev_realize(DEVICE(channel), NULL, errp)) {
+            return;
+        }
+    }
 }
 
 static const VMStateDescription cprman_vmstate = {
@@ -328,6 +466,7 @@ static void cprman_register_types(void)
 {
     type_register_static(&cprman_info);
     type_register_static(&cprman_pll_info);
+    type_register_static(&cprman_pll_channel_info);
 }
 
 type_init(cprman_register_types);
-- 
2.20.1



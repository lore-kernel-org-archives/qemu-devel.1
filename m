Return-Path: <SRS0=gwGE=EC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02D81C55178
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 12:43:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 645D620757
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 12:43:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="U4hlTn6W"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 645D620757
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34982 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXOK0-00084O-87
	for qemu-devel@archiver.kernel.org; Tue, 27 Oct 2020 08:43:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52632)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kXNQ7-00027v-F9
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 07:45:43 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:38448)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kXNQ0-0004pI-2Q
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 07:45:42 -0400
Received: by mail-wr1-x442.google.com with SMTP id n18so1539700wrs.5
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2020 04:45:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=eLmAjeDKIfRfdkkfHTfNDX6JqKRxk4eYW61W1Q0ubJ8=;
 b=U4hlTn6WbkF1k+st7jZdovgciC9nVswCsIp8hROOXs9hUtHvBSLRfEbRDC8nLZLj2n
 wuS8qRhyATGPLo537UUOw/ffNRwFn8ELGNmbT7kbMvyufcNy4Ltw9XbkUatLgVM6Fwso
 aCmgNJ6H29cuj2YinEL9T88ds7gZ3JSVcYZ6K3fXW/5uxB2ePT8tslGGtCDK0H9xYdtl
 X312+ZFHvzpMOZIe+W/YAkT/s+ylEhMx7mYz936DsA3xXkzJKVIDUBTPRKdB0fEjf5By
 /MN3C+2C+FJS/AqDMEh7qU76SvwpbVuN3186pzf92UMzFUapmhh+qqDqZSv24IIW7qEa
 S/tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=eLmAjeDKIfRfdkkfHTfNDX6JqKRxk4eYW61W1Q0ubJ8=;
 b=I3W8uKAFMA6I8a6Fw223fbic5/y4OD1PvrkpgcnoUCX/4mWj/dMgnVOHNrSpkZjpf7
 LU1UyAMzzqD87EyLZn+KALWZv2qZbDV5VWAfak2Y5gwreqTPHMfmMhsj78DSTqm17GNx
 2jAnjREhb5Z7Qf5qwWx8PwBsPGQZtWyhyvg8fL9hgeWnGp7lxpALB0R5tDTa7jx8wagf
 NKYMR/pDvFtXWb3HV/GPw7b13LBr8AE06+kweHi7F6/fhIhLcZU+VI3Mvgos/Glk0WNB
 Cv6L5xfq2OJB9yNZzoWNOayDyGFZkuiEmzPFnDuO4j+B6HXm3j/YDyKYn6zQnuJkavWU
 8Q8A==
X-Gm-Message-State: AOAM533yNGjDxxYLgGJzKCPSehtxhRcsL5nNMI0epR8L4y9Dq38qZuVi
 1MFdj5ZcE60AZNEUGdNRnzFu3jU18cRTVg==
X-Google-Smtp-Source: ABdhPJzjtIh9tnJN1YnpIOieAmyoe50dRXT+rj5NJ0nTaPsfLzpaiW853q2tVMQdeQ9Sa+qVBd0RpQ==
X-Received: by 2002:adf:e650:: with SMTP id b16mr2468781wrn.350.1603799133718; 
 Tue, 27 Oct 2020 04:45:33 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id 32sm1712203wro.31.2020.10.27.04.45.32
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Oct 2020 04:45:32 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 42/48] hw/misc/bcm2835_cprman: add sane reset values to the
 registers
Date: Tue, 27 Oct 2020 11:44:32 +0000
Message-Id: <20201027114438.17662-43-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201027114438.17662-1-peter.maydell@linaro.org>
References: <20201027114438.17662-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::442;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x442.google.com
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

Those reset values have been extracted from a Raspberry Pi 3 model B
v1.2, using the 2020-08-20 version of raspios. The dump was done using
the debugfs interface of the CPRMAN driver in Linux (under
'/sys/kernel/debug/clk'). Each exposed clock tree stage (PLLs, channels
and muxes) can be observed by reading the 'regdump' file (e.g.
'plla/regdump').

Those values are set by the Raspberry Pi firmware at boot time (Linux
expects them to be set when it boots up).

Some stages are not exposed by the Linux driver (e.g. the PLL B). For
those, the reset values are unknown and left to 0 which implies a
disabled output.

Once booted in QEMU, the final clock tree is very similar to the one
visible on real hardware. The differences come from some unimplemented
devices for which the driver simply disable the corresponding clock.

Tested-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Signed-off-by: Luc Michel <luc@lmichel.fr>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Tested-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/misc/bcm2835_cprman_internals.h | 269 +++++++++++++++++++++
 hw/misc/bcm2835_cprman.c                   |  31 +++
 2 files changed, 300 insertions(+)

diff --git a/include/hw/misc/bcm2835_cprman_internals.h b/include/hw/misc/bcm2835_cprman_internals.h
index a6e799075f7..339759b3071 100644
--- a/include/hw/misc/bcm2835_cprman_internals.h
+++ b/include/hw/misc/bcm2835_cprman_internals.h
@@ -747,4 +747,273 @@ static inline void set_clock_mux_init_info(BCM2835CprmanState *s,
     mux->frac_bits = CLOCK_MUX_INIT_INFO[id].frac_bits;
 }
 
+
+/*
+ * Object reset info
+ * Those values have been dumped from a Raspberry Pi 3 Model B v1.2 using the
+ * clk debugfs interface in Linux.
+ */
+typedef struct PLLResetInfo {
+    uint32_t cm;
+    uint32_t a2w_ctrl;
+    uint32_t a2w_ana[4];
+    uint32_t a2w_frac;
+} PLLResetInfo;
+
+static const PLLResetInfo PLL_RESET_INFO[] = {
+    [CPRMAN_PLLA] = {
+        .cm = 0x0000008a,
+        .a2w_ctrl = 0x0002103a,
+        .a2w_frac = 0x00098000,
+        .a2w_ana = { 0x00000000, 0x00144000, 0x00000000, 0x00000100 }
+    },
+
+    [CPRMAN_PLLC] = {
+        .cm = 0x00000228,
+        .a2w_ctrl = 0x0002103e,
+        .a2w_frac = 0x00080000,
+        .a2w_ana = { 0x00000000, 0x00144000, 0x00000000, 0x00000100 }
+    },
+
+    [CPRMAN_PLLD] = {
+        .cm = 0x0000020a,
+        .a2w_ctrl = 0x00021034,
+        .a2w_frac = 0x00015556,
+        .a2w_ana = { 0x00000000, 0x00144000, 0x00000000, 0x00000100 }
+    },
+
+    [CPRMAN_PLLH] = {
+        .cm = 0x00000000,
+        .a2w_ctrl = 0x0002102d,
+        .a2w_frac = 0x00000000,
+        .a2w_ana = { 0x00900000, 0x0000000c, 0x00000000, 0x00000000 }
+    },
+
+    [CPRMAN_PLLB] = {
+        /* unknown */
+        .cm = 0x00000000,
+        .a2w_ctrl = 0x00000000,
+        .a2w_frac = 0x00000000,
+        .a2w_ana = { 0x00000000, 0x00000000, 0x00000000, 0x00000000 }
+    }
+};
+
+typedef struct PLLChannelResetInfo {
+    /*
+     * Even though a PLL channel has a CM register, it shares it with its
+     * parent PLL. The parent already takes care of the reset value.
+     */
+    uint32_t a2w_ctrl;
+} PLLChannelResetInfo;
+
+static const PLLChannelResetInfo PLL_CHANNEL_RESET_INFO[] = {
+    [CPRMAN_PLLA_CHANNEL_DSI0] = { .a2w_ctrl = 0x00000100 },
+    [CPRMAN_PLLA_CHANNEL_CORE] = { .a2w_ctrl = 0x00000003 },
+    [CPRMAN_PLLA_CHANNEL_PER] = { .a2w_ctrl = 0x00000000 }, /* unknown */
+    [CPRMAN_PLLA_CHANNEL_CCP2] = { .a2w_ctrl = 0x00000100 },
+
+    [CPRMAN_PLLC_CHANNEL_CORE2] = { .a2w_ctrl = 0x00000100 },
+    [CPRMAN_PLLC_CHANNEL_CORE1] = { .a2w_ctrl = 0x00000100 },
+    [CPRMAN_PLLC_CHANNEL_PER] = { .a2w_ctrl = 0x00000002 },
+    [CPRMAN_PLLC_CHANNEL_CORE0] = { .a2w_ctrl = 0x00000002 },
+
+    [CPRMAN_PLLD_CHANNEL_DSI0] = { .a2w_ctrl = 0x00000100 },
+    [CPRMAN_PLLD_CHANNEL_CORE] = { .a2w_ctrl = 0x00000004 },
+    [CPRMAN_PLLD_CHANNEL_PER] = { .a2w_ctrl = 0x00000004 },
+    [CPRMAN_PLLD_CHANNEL_DSI1] = { .a2w_ctrl = 0x00000100 },
+
+    [CPRMAN_PLLH_CHANNEL_AUX] = { .a2w_ctrl = 0x00000004 },
+    [CPRMAN_PLLH_CHANNEL_RCAL] = { .a2w_ctrl = 0x00000000 },
+    [CPRMAN_PLLH_CHANNEL_PIX] = { .a2w_ctrl = 0x00000000 },
+
+    [CPRMAN_PLLB_CHANNEL_ARM] = { .a2w_ctrl = 0x00000000 }, /* unknown */
+};
+
+typedef struct ClockMuxResetInfo {
+    uint32_t cm_ctl;
+    uint32_t cm_div;
+} ClockMuxResetInfo;
+
+static const ClockMuxResetInfo CLOCK_MUX_RESET_INFO[] = {
+    [CPRMAN_CLOCK_GNRIC] = {
+        .cm_ctl = 0, /* unknown */
+        .cm_div = 0
+    },
+
+    [CPRMAN_CLOCK_VPU] = {
+        .cm_ctl = 0x00000245,
+        .cm_div = 0x00003000,
+    },
+
+    [CPRMAN_CLOCK_SYS] = {
+        .cm_ctl = 0, /* unknown */
+        .cm_div = 0
+    },
+
+    [CPRMAN_CLOCK_PERIA] = {
+        .cm_ctl = 0, /* unknown */
+        .cm_div = 0
+    },
+
+    [CPRMAN_CLOCK_PERII] = {
+        .cm_ctl = 0, /* unknown */
+        .cm_div = 0
+    },
+
+    [CPRMAN_CLOCK_H264] = {
+        .cm_ctl = 0x00000244,
+        .cm_div = 0x00003000,
+    },
+
+    [CPRMAN_CLOCK_ISP] = {
+        .cm_ctl = 0x00000244,
+        .cm_div = 0x00003000,
+    },
+
+    [CPRMAN_CLOCK_V3D] = {
+        .cm_ctl = 0, /* unknown */
+        .cm_div = 0
+    },
+
+    [CPRMAN_CLOCK_CAM0] = {
+        .cm_ctl = 0x00000000,
+        .cm_div = 0x00000000,
+    },
+
+    [CPRMAN_CLOCK_CAM1] = {
+        .cm_ctl = 0x00000000,
+        .cm_div = 0x00000000,
+    },
+
+    [CPRMAN_CLOCK_CCP2] = {
+        .cm_ctl = 0, /* unknown */
+        .cm_div = 0
+    },
+
+    [CPRMAN_CLOCK_DSI0E] = {
+        .cm_ctl = 0x00000000,
+        .cm_div = 0x00000000,
+    },
+
+    [CPRMAN_CLOCK_DSI0P] = {
+        .cm_ctl = 0x00000000,
+        .cm_div = 0x00000000,
+    },
+
+    [CPRMAN_CLOCK_DPI] = {
+        .cm_ctl = 0x00000000,
+        .cm_div = 0x00000000,
+    },
+
+    [CPRMAN_CLOCK_GP0] = {
+        .cm_ctl = 0x00000200,
+        .cm_div = 0x00000000,
+    },
+
+    [CPRMAN_CLOCK_GP1] = {
+        .cm_ctl = 0x00000096,
+        .cm_div = 0x00014000,
+    },
+
+    [CPRMAN_CLOCK_GP2] = {
+        .cm_ctl = 0x00000291,
+        .cm_div = 0x00249f00,
+    },
+
+    [CPRMAN_CLOCK_HSM] = {
+        .cm_ctl = 0x00000000,
+        .cm_div = 0x00000000,
+    },
+
+    [CPRMAN_CLOCK_OTP] = {
+        .cm_ctl = 0x00000091,
+        .cm_div = 0x00004000,
+    },
+
+    [CPRMAN_CLOCK_PCM] = {
+        .cm_ctl = 0x00000200,
+        .cm_div = 0x00000000,
+    },
+
+    [CPRMAN_CLOCK_PWM] = {
+        .cm_ctl = 0x00000200,
+        .cm_div = 0x00000000,
+    },
+
+    [CPRMAN_CLOCK_SLIM] = {
+        .cm_ctl = 0x00000200,
+        .cm_div = 0x00000000,
+    },
+
+    [CPRMAN_CLOCK_SMI] = {
+        .cm_ctl = 0x00000000,
+        .cm_div = 0x00000000,
+    },
+
+    [CPRMAN_CLOCK_TEC] = {
+        .cm_ctl = 0x00000000,
+        .cm_div = 0x00000000,
+    },
+
+    [CPRMAN_CLOCK_TD0] = {
+        .cm_ctl = 0, /* unknown */
+        .cm_div = 0
+    },
+
+    [CPRMAN_CLOCK_TD1] = {
+        .cm_ctl = 0, /* unknown */
+        .cm_div = 0
+    },
+
+    [CPRMAN_CLOCK_TSENS] = {
+        .cm_ctl = 0x00000091,
+        .cm_div = 0x0000a000,
+    },
+
+    [CPRMAN_CLOCK_TIMER] = {
+        .cm_ctl = 0x00000291,
+        .cm_div = 0x00013333,
+    },
+
+    [CPRMAN_CLOCK_UART] = {
+        .cm_ctl = 0x00000296,
+        .cm_div = 0x0000a6ab,
+    },
+
+    [CPRMAN_CLOCK_VEC] = {
+        .cm_ctl = 0x00000097,
+        .cm_div = 0x00002000,
+    },
+
+    [CPRMAN_CLOCK_PULSE] = {
+        .cm_ctl = 0, /* unknown */
+        .cm_div = 0
+    },
+
+    [CPRMAN_CLOCK_SDC] = {
+        .cm_ctl = 0x00004006,
+        .cm_div = 0x00003000,
+    },
+
+    [CPRMAN_CLOCK_ARM] = {
+        .cm_ctl = 0, /* unknown */
+        .cm_div = 0
+    },
+
+    [CPRMAN_CLOCK_AVEO] = {
+        .cm_ctl = 0x00000000,
+        .cm_div = 0x00000000,
+    },
+
+    [CPRMAN_CLOCK_EMMC] = {
+        .cm_ctl = 0x00000295,
+        .cm_div = 0x00006000,
+    },
+
+    [CPRMAN_CLOCK_EMMC2] = {
+        .cm_ctl = 0, /* unknown */
+        .cm_div = 0
+    },
+};
+
 #endif
diff --git a/hw/misc/bcm2835_cprman.c b/hw/misc/bcm2835_cprman.c
index 7a7401963d5..7e415a017c9 100644
--- a/hw/misc/bcm2835_cprman.c
+++ b/hw/misc/bcm2835_cprman.c
@@ -53,6 +53,17 @@
 
 /* PLL */
 
+static void pll_reset(DeviceState *dev)
+{
+    CprmanPllState *s = CPRMAN_PLL(dev);
+    const PLLResetInfo *info = &PLL_RESET_INFO[s->id];
+
+    *s->reg_cm = info->cm;
+    *s->reg_a2w_ctrl = info->a2w_ctrl;
+    memcpy(s->reg_a2w_ana, info->a2w_ana, sizeof(info->a2w_ana));
+    *s->reg_a2w_frac = info->a2w_frac;
+}
+
 static bool pll_is_locked(const CprmanPllState *pll)
 {
     return !FIELD_EX32(*pll->reg_a2w_ctrl, A2W_PLLx_CTRL, PWRDN)
@@ -123,6 +134,7 @@ static void pll_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
+    dc->reset = pll_reset;
     dc->vmsd = &pll_vmstate;
 }
 
@@ -137,6 +149,14 @@ static const TypeInfo cprman_pll_info = {
 
 /* PLL channel */
 
+static void pll_channel_reset(DeviceState *dev)
+{
+    CprmanPllChannelState *s = CPRMAN_PLL_CHANNEL(dev);
+    const PLLChannelResetInfo *info = &PLL_CHANNEL_RESET_INFO[s->id];
+
+    *s->reg_a2w_ctrl = info->a2w_ctrl;
+}
+
 static bool pll_channel_is_enabled(CprmanPllChannelState *channel)
 {
     /*
@@ -217,6 +237,7 @@ static void pll_channel_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
+    dc->reset = pll_channel_reset;
     dc->vmsd = &pll_channel_vmstate;
 }
 
@@ -295,6 +316,15 @@ static void clock_mux_src_update(void *opaque)
     clock_mux_update(s);
 }
 
+static void clock_mux_reset(DeviceState *dev)
+{
+    CprmanClockMuxState *clock = CPRMAN_CLOCK_MUX(dev);
+    const ClockMuxResetInfo *info = &CLOCK_MUX_RESET_INFO[clock->id];
+
+    *clock->reg_ctl = info->cm_ctl;
+    *clock->reg_div = info->cm_div;
+}
+
 static void clock_mux_init(Object *obj)
 {
     CprmanClockMuxState *s = CPRMAN_CLOCK_MUX(obj);
@@ -327,6 +357,7 @@ static void clock_mux_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
+    dc->reset = clock_mux_reset;
     dc->vmsd = &clock_mux_vmstate;
 }
 
-- 
2.20.1



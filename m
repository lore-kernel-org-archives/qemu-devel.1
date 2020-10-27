Return-Path: <SRS0=gwGE=EC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1819C55178
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 12:40:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E56FA21655
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 12:40:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MbTRmNEe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E56FA21655
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55170 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXOHK-0004KD-Jj
	for qemu-devel@archiver.kernel.org; Tue, 27 Oct 2020 08:40:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52412)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kXNPw-0001yC-Mf
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 07:45:32 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c]:33538)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kXNPq-0004iC-8c
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 07:45:32 -0400
Received: by mail-wr1-x42c.google.com with SMTP id b8so1570874wrn.0
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2020 04:45:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=1qC1epjqetWxlWjqrR7TC7h6aKaEki7fVKQA2CoEE2c=;
 b=MbTRmNEeizUBM9XZ/725EHfnmjRgViAvBrjOPv5EwZj1rAtYnpp6B7V3x5xkfEwbmt
 amxf/23g1R5DguMbj4wgc7HbCbgB9Oj69u/ZN8Zo9Enojx/t4cTXzQHRp9US0jXITg6k
 BLSgDd6Xp2owPqZv1mwKCG1eH5ybxQEm4CKMdOsdS9RB0/64hCsBHx4f9Dv9CEB/AaUv
 6a9vT9sq/Pqv6pqwo3gWFFJudQiwjwab85RRYQbDQIUck/sN6xqMTGQ+mvGSQAV2WwUV
 DDh5L53FtbBklmrlQ7rTIrx4YpqlzCQUCkIZuVP7+I4TqqbIdUiMEbBNQs8X+DGgxzLb
 1BMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=1qC1epjqetWxlWjqrR7TC7h6aKaEki7fVKQA2CoEE2c=;
 b=kGyOcQnCgoOXNVWZ/KeUbYuh+ubl9iLlGv2Uq+fW01kIVFr57o1xuG/fkNTvPZb5Rl
 +9rohr2C11t6CGcF3AesVmY2+YeunaA5C39xc6BLefL33gCO1AGbI/fkxDbn4MOBAyy1
 /d4B+GWkin9FqEqIqGzGQhpOKHAA7QIli4r58ynmoACsWdSX8DvvPXEgGGnbXsgkSAQt
 IW4FzXOKU1I75MdbDF9S7587JeY1T9VbB2f2x4rUHP8cBeC4odGQ5KbDABFiZIOkrFTP
 ccs02TdE4cGQhHehVoHRZyZCot3MikDKUcu3r3EvcksOrCsqCsGC+Etg0pXrziYjCmWo
 2T+Q==
X-Gm-Message-State: AOAM533t2LMA+lGAxok8LEQNy2dpTRYDhWEqTZf38uqmjFp7eFCLW/Fu
 dehAAtyUpMV9VVlF0N5tG5+YYPU5EjRaxA==
X-Google-Smtp-Source: ABdhPJy7FdntI5f2EZ+nklHRpTAWQ76OP92tqEETHjLSO2hJ6C0HLeQODFxUN6j0NuPfJ7X/YMykzA==
X-Received: by 2002:adf:fe4b:: with SMTP id m11mr2260382wrs.98.1603799124388; 
 Tue, 27 Oct 2020 04:45:24 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id 32sm1712203wro.31.2020.10.27.04.45.23
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Oct 2020 04:45:23 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 35/48] hw/misc/bcm2835_cprman: add a PLL skeleton implementation
Date: Tue, 27 Oct 2020 11:44:25 +0000
Message-Id: <20201027114438.17662-36-peter.maydell@linaro.org>
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

There are 5 PLLs in the CPRMAN, namely PLL A, C, D, H and B. All of them
take the xosc clock as input and produce a new clock.

This commit adds a skeleton implementation for the PLLs as sub-devices
of the CPRMAN. The PLLs are instantiated and connected internally to the
main oscillator.

Each PLL has 6 registers : CM, A2W_CTRL, A2W_ANA[0,1,2,3], A2W_FRAC. A
write to any of them triggers a call to the (not yet implemented)
pll_update function.

If the main oscillator changes frequency, an update is also triggered.

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Tested-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Signed-off-by: Luc Michel <luc@lmichel.fr>
Tested-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/misc/bcm2835_cprman.h           |  29 +++++
 include/hw/misc/bcm2835_cprman_internals.h | 144 +++++++++++++++++++++
 hw/misc/bcm2835_cprman.c                   | 108 ++++++++++++++++
 3 files changed, 281 insertions(+)

diff --git a/include/hw/misc/bcm2835_cprman.h b/include/hw/misc/bcm2835_cprman.h
index 8ae2d4d17c9..5c442e6ff93 100644
--- a/include/hw/misc/bcm2835_cprman.h
+++ b/include/hw/misc/bcm2835_cprman.h
@@ -21,6 +21,33 @@ DECLARE_INSTANCE_CHECKER(BCM2835CprmanState, CPRMAN,
 
 #define CPRMAN_NUM_REGS (0x2000 / sizeof(uint32_t))
 
+typedef enum CprmanPll {
+    CPRMAN_PLLA = 0,
+    CPRMAN_PLLC,
+    CPRMAN_PLLD,
+    CPRMAN_PLLH,
+    CPRMAN_PLLB,
+
+    CPRMAN_NUM_PLL
+} CprmanPll;
+
+typedef struct CprmanPllState {
+    /*< private >*/
+    DeviceState parent_obj;
+
+    /*< public >*/
+    CprmanPll id;
+
+    uint32_t *reg_cm;
+    uint32_t *reg_a2w_ctrl;
+    uint32_t *reg_a2w_ana; /* ANA[0] .. ANA[3] */
+    uint32_t prediv_mask; /* prediv bit in ana[1] */
+    uint32_t *reg_a2w_frac;
+
+    Clock *xosc_in;
+    Clock *out;
+} CprmanPllState;
+
 struct BCM2835CprmanState {
     /*< private >*/
     SysBusDevice parent_obj;
@@ -28,6 +55,8 @@ struct BCM2835CprmanState {
     /*< public >*/
     MemoryRegion iomem;
 
+    CprmanPllState plls[CPRMAN_NUM_PLL];
+
     uint32_t regs[CPRMAN_NUM_REGS];
     uint32_t xosc_freq;
 
diff --git a/include/hw/misc/bcm2835_cprman_internals.h b/include/hw/misc/bcm2835_cprman_internals.h
index 8fcc6d1d091..340ad623bb1 100644
--- a/include/hw/misc/bcm2835_cprman_internals.h
+++ b/include/hw/misc/bcm2835_cprman_internals.h
@@ -12,8 +12,94 @@
 #include "hw/registerfields.h"
 #include "hw/misc/bcm2835_cprman.h"
 
+#define TYPE_CPRMAN_PLL "bcm2835-cprman-pll"
+
+DECLARE_INSTANCE_CHECKER(CprmanPllState, CPRMAN_PLL,
+                         TYPE_CPRMAN_PLL)
+
 /* Register map */
 
+/* PLLs */
+REG32(CM_PLLA, 0x104)
+    FIELD(CM_PLLA, LOADDSI0, 0, 1)
+    FIELD(CM_PLLA, HOLDDSI0, 1, 1)
+    FIELD(CM_PLLA, LOADCCP2, 2, 1)
+    FIELD(CM_PLLA, HOLDCCP2, 3, 1)
+    FIELD(CM_PLLA, LOADCORE, 4, 1)
+    FIELD(CM_PLLA, HOLDCORE, 5, 1)
+    FIELD(CM_PLLA, LOADPER, 6, 1)
+    FIELD(CM_PLLA, HOLDPER, 7, 1)
+    FIELD(CM_PLLx, ANARST, 8, 1)
+REG32(CM_PLLC, 0x108)
+    FIELD(CM_PLLC, LOADCORE0, 0, 1)
+    FIELD(CM_PLLC, HOLDCORE0, 1, 1)
+    FIELD(CM_PLLC, LOADCORE1, 2, 1)
+    FIELD(CM_PLLC, HOLDCORE1, 3, 1)
+    FIELD(CM_PLLC, LOADCORE2, 4, 1)
+    FIELD(CM_PLLC, HOLDCORE2, 5, 1)
+    FIELD(CM_PLLC, LOADPER, 6, 1)
+    FIELD(CM_PLLC, HOLDPER, 7, 1)
+REG32(CM_PLLD, 0x10c)
+    FIELD(CM_PLLD, LOADDSI0, 0, 1)
+    FIELD(CM_PLLD, HOLDDSI0, 1, 1)
+    FIELD(CM_PLLD, LOADDSI1, 2, 1)
+    FIELD(CM_PLLD, HOLDDSI1, 3, 1)
+    FIELD(CM_PLLD, LOADCORE, 4, 1)
+    FIELD(CM_PLLD, HOLDCORE, 5, 1)
+    FIELD(CM_PLLD, LOADPER, 6, 1)
+    FIELD(CM_PLLD, HOLDPER, 7, 1)
+REG32(CM_PLLH, 0x110)
+    FIELD(CM_PLLH, LOADPIX, 0, 1)
+    FIELD(CM_PLLH, LOADAUX, 1, 1)
+    FIELD(CM_PLLH, LOADRCAL, 2, 1)
+REG32(CM_PLLB, 0x170)
+    FIELD(CM_PLLB, LOADARM, 0, 1)
+    FIELD(CM_PLLB, HOLDARM, 1, 1)
+
+REG32(A2W_PLLA_CTRL, 0x1100)
+    FIELD(A2W_PLLx_CTRL, NDIV, 0, 10)
+    FIELD(A2W_PLLx_CTRL, PDIV, 12, 3)
+    FIELD(A2W_PLLx_CTRL, PWRDN, 16, 1)
+    FIELD(A2W_PLLx_CTRL, PRST_DISABLE, 17, 1)
+REG32(A2W_PLLC_CTRL, 0x1120)
+REG32(A2W_PLLD_CTRL, 0x1140)
+REG32(A2W_PLLH_CTRL, 0x1160)
+REG32(A2W_PLLB_CTRL, 0x11e0)
+
+REG32(A2W_PLLA_ANA0, 0x1010)
+REG32(A2W_PLLA_ANA1, 0x1014)
+    FIELD(A2W_PLLx_ANA1, FB_PREDIV, 14, 1)
+REG32(A2W_PLLA_ANA2, 0x1018)
+REG32(A2W_PLLA_ANA3, 0x101c)
+
+REG32(A2W_PLLC_ANA0, 0x1030)
+REG32(A2W_PLLC_ANA1, 0x1034)
+REG32(A2W_PLLC_ANA2, 0x1038)
+REG32(A2W_PLLC_ANA3, 0x103c)
+
+REG32(A2W_PLLD_ANA0, 0x1050)
+REG32(A2W_PLLD_ANA1, 0x1054)
+REG32(A2W_PLLD_ANA2, 0x1058)
+REG32(A2W_PLLD_ANA3, 0x105c)
+
+REG32(A2W_PLLH_ANA0, 0x1070)
+REG32(A2W_PLLH_ANA1, 0x1074)
+    FIELD(A2W_PLLH_ANA1, FB_PREDIV, 11, 1)
+REG32(A2W_PLLH_ANA2, 0x1078)
+REG32(A2W_PLLH_ANA3, 0x107c)
+
+REG32(A2W_PLLB_ANA0, 0x10f0)
+REG32(A2W_PLLB_ANA1, 0x10f4)
+REG32(A2W_PLLB_ANA2, 0x10f8)
+REG32(A2W_PLLB_ANA3, 0x10fc)
+
+REG32(A2W_PLLA_FRAC, 0x1200)
+    FIELD(A2W_PLLx_FRAC, FRAC, 0, 20)
+REG32(A2W_PLLC_FRAC, 0x1220)
+REG32(A2W_PLLD_FRAC, 0x1240)
+REG32(A2W_PLLH_FRAC, 0x1260)
+REG32(A2W_PLLB_FRAC, 0x12e0)
+
 /*
  * This field is common to all registers. Each register write value must match
  * the CPRMAN_PASSWORD magic value in its 8 MSB.
@@ -21,4 +107,62 @@
 FIELD(CPRMAN, PASSWORD, 24, 8)
 #define CPRMAN_PASSWORD 0x5a
 
+/* PLL init info */
+typedef struct PLLInitInfo {
+    const char *name;
+    size_t cm_offset;
+    size_t a2w_ctrl_offset;
+    size_t a2w_ana_offset;
+    uint32_t prediv_mask; /* Prediv bit in ana[1] */
+    size_t a2w_frac_offset;
+} PLLInitInfo;
+
+#define FILL_PLL_INIT_INFO(pll_)                \
+    .cm_offset = R_CM_ ## pll_,                 \
+    .a2w_ctrl_offset = R_A2W_ ## pll_ ## _CTRL, \
+    .a2w_ana_offset = R_A2W_ ## pll_ ## _ANA0,  \
+    .a2w_frac_offset = R_A2W_ ## pll_ ## _FRAC
+
+static const PLLInitInfo PLL_INIT_INFO[] = {
+    [CPRMAN_PLLA] = {
+        .name = "plla",
+        .prediv_mask = R_A2W_PLLx_ANA1_FB_PREDIV_MASK,
+        FILL_PLL_INIT_INFO(PLLA),
+    },
+    [CPRMAN_PLLC] = {
+        .name = "pllc",
+        .prediv_mask = R_A2W_PLLx_ANA1_FB_PREDIV_MASK,
+        FILL_PLL_INIT_INFO(PLLC),
+    },
+    [CPRMAN_PLLD] = {
+        .name = "plld",
+        .prediv_mask = R_A2W_PLLx_ANA1_FB_PREDIV_MASK,
+        FILL_PLL_INIT_INFO(PLLD),
+    },
+    [CPRMAN_PLLH] = {
+        .name = "pllh",
+        .prediv_mask = R_A2W_PLLH_ANA1_FB_PREDIV_MASK,
+        FILL_PLL_INIT_INFO(PLLH),
+    },
+    [CPRMAN_PLLB] = {
+        .name = "pllb",
+        .prediv_mask = R_A2W_PLLx_ANA1_FB_PREDIV_MASK,
+        FILL_PLL_INIT_INFO(PLLB),
+    },
+};
+
+#undef FILL_PLL_CHANNEL_INIT_INFO
+
+static inline void set_pll_init_info(BCM2835CprmanState *s,
+                                     CprmanPllState *pll,
+                                     CprmanPll id)
+{
+    pll->id = id;
+    pll->reg_cm = &s->regs[PLL_INIT_INFO[id].cm_offset];
+    pll->reg_a2w_ctrl = &s->regs[PLL_INIT_INFO[id].a2w_ctrl_offset];
+    pll->reg_a2w_ana = &s->regs[PLL_INIT_INFO[id].a2w_ana_offset];
+    pll->prediv_mask = PLL_INIT_INFO[id].prediv_mask;
+    pll->reg_a2w_frac = &s->regs[PLL_INIT_INFO[id].a2w_frac_offset];
+}
+
 #endif
diff --git a/hw/misc/bcm2835_cprman.c b/hw/misc/bcm2835_cprman.c
index 57ab9910b52..b86f5901b88 100644
--- a/hw/misc/bcm2835_cprman.c
+++ b/hw/misc/bcm2835_cprman.c
@@ -48,6 +48,52 @@
 #include "hw/misc/bcm2835_cprman_internals.h"
 #include "trace.h"
 
+/* PLL */
+
+static void pll_update(CprmanPllState *pll)
+{
+    clock_update(pll->out, 0);
+}
+
+static void pll_xosc_update(void *opaque)
+{
+    pll_update(CPRMAN_PLL(opaque));
+}
+
+static void pll_init(Object *obj)
+{
+    CprmanPllState *s = CPRMAN_PLL(obj);
+
+    s->xosc_in = qdev_init_clock_in(DEVICE(s), "xosc-in", pll_xosc_update, s);
+    s->out = qdev_init_clock_out(DEVICE(s), "out");
+}
+
+static const VMStateDescription pll_vmstate = {
+    .name = TYPE_CPRMAN_PLL,
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .fields = (VMStateField[]) {
+        VMSTATE_CLOCK(xosc_in, CprmanPllState),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+static void pll_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    dc->vmsd = &pll_vmstate;
+}
+
+static const TypeInfo cprman_pll_info = {
+    .name = TYPE_CPRMAN_PLL,
+    .parent = TYPE_DEVICE,
+    .instance_size = sizeof(CprmanPllState),
+    .class_init = pll_class_init,
+    .instance_init = pll_init,
+};
+
+
 /* CPRMAN "top level" model */
 
 static uint64_t cprman_read(void *opaque, hwaddr offset,
@@ -66,6 +112,15 @@ static uint64_t cprman_read(void *opaque, hwaddr offset,
     return r;
 }
 
+#define CASE_PLL_REGS(pll_)       \
+    case R_CM_ ## pll_:           \
+    case R_A2W_ ## pll_ ## _CTRL: \
+    case R_A2W_ ## pll_ ## _ANA0: \
+    case R_A2W_ ## pll_ ## _ANA1: \
+    case R_A2W_ ## pll_ ## _ANA2: \
+    case R_A2W_ ## pll_ ## _ANA3: \
+    case R_A2W_ ## pll_ ## _FRAC
+
 static void cprman_write(void *opaque, hwaddr offset,
                          uint64_t value, unsigned size)
 {
@@ -82,8 +137,31 @@ static void cprman_write(void *opaque, hwaddr offset,
     trace_bcm2835_cprman_write(offset, value);
     s->regs[idx] = value;
 
+    switch (idx) {
+    CASE_PLL_REGS(PLLA) :
+        pll_update(&s->plls[CPRMAN_PLLA]);
+        break;
+
+    CASE_PLL_REGS(PLLC) :
+        pll_update(&s->plls[CPRMAN_PLLC]);
+        break;
+
+    CASE_PLL_REGS(PLLD) :
+        pll_update(&s->plls[CPRMAN_PLLD]);
+        break;
+
+    CASE_PLL_REGS(PLLH) :
+        pll_update(&s->plls[CPRMAN_PLLH]);
+        break;
+
+    CASE_PLL_REGS(PLLB) :
+        pll_update(&s->plls[CPRMAN_PLLB]);
+        break;
+    }
 }
 
+#undef CASE_PLL_REGS
+
 static const MemoryRegionOps cprman_ops = {
     .read = cprman_read,
     .write = cprman_write,
@@ -106,15 +184,27 @@ static const MemoryRegionOps cprman_ops = {
 static void cprman_reset(DeviceState *dev)
 {
     BCM2835CprmanState *s = CPRMAN(dev);
+    size_t i;
 
     memset(s->regs, 0, sizeof(s->regs));
 
+    for (i = 0; i < CPRMAN_NUM_PLL; i++) {
+        device_cold_reset(DEVICE(&s->plls[i]));
+    }
+
     clock_update_hz(s->xosc, s->xosc_freq);
 }
 
 static void cprman_init(Object *obj)
 {
     BCM2835CprmanState *s = CPRMAN(obj);
+    size_t i;
+
+    for (i = 0; i < CPRMAN_NUM_PLL; i++) {
+        object_initialize_child(obj, PLL_INIT_INFO[i].name,
+                                &s->plls[i], TYPE_CPRMAN_PLL);
+        set_pll_init_info(s, &s->plls[i], i);
+    }
 
     s->xosc = clock_new(obj, "xosc");
 
@@ -123,6 +213,22 @@ static void cprman_init(Object *obj)
     sysbus_init_mmio(SYS_BUS_DEVICE(obj), &s->iomem);
 }
 
+static void cprman_realize(DeviceState *dev, Error **errp)
+{
+    BCM2835CprmanState *s = CPRMAN(dev);
+    size_t i;
+
+    for (i = 0; i < CPRMAN_NUM_PLL; i++) {
+        CprmanPllState *pll = &s->plls[i];
+
+        clock_set_source(pll->xosc_in, s->xosc);
+
+        if (!qdev_realize(DEVICE(pll), NULL, errp)) {
+            return;
+        }
+    }
+}
+
 static const VMStateDescription cprman_vmstate = {
     .name = TYPE_BCM2835_CPRMAN,
     .version_id = 1,
@@ -142,6 +248,7 @@ static void cprman_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
+    dc->realize = cprman_realize;
     dc->reset = cprman_reset;
     dc->vmsd = &cprman_vmstate;
     device_class_set_props(dc, cprman_properties);
@@ -158,6 +265,7 @@ static const TypeInfo cprman_info = {
 static void cprman_register_types(void)
 {
     type_register_static(&cprman_info);
+    type_register_static(&cprman_pll_info);
 }
 
 type_init(cprman_register_types);
-- 
2.20.1



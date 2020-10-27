Return-Path: <SRS0=gwGE=EC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 868B9C388F9
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 13:15:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E18F020754
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 13:15:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JoOlG5vD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E18F020754
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51358 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXOob-00065L-Pt
	for qemu-devel@archiver.kernel.org; Tue, 27 Oct 2020 09:15:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52642)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kXNQ7-00028X-Tm
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 07:45:43 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d]:39777)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kXNPy-0004nw-6g
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 07:45:43 -0400
Received: by mail-wm1-x32d.google.com with SMTP id d3so1103349wma.4
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2020 04:45:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=s26sY2t7Cm07LjYh/TvjY9F1W4BWnK79s2pdBeBpsHc=;
 b=JoOlG5vDpxsMQUSbApAbPUfszNtEQcW2TFWzEl81QQ4c2u4+R4WzzW+nFmFiZM3UC5
 MYzOhiQcrdH6KC1zgYGZ9rmYOPOcllLzkFmvYme6AYS2k5/QWnFn8S5+rcm/FuJODQvA
 uTxvYBWod76qEly+2bOzK+o6h0xFTNE0kVeBZdEvU+L7nYhAQg/6dXuEvrA0c3m4sm+9
 gUiyXRvIPyTFLV/u1bzQZbP0uHBVEJrRkgxFJlhKOgnq3l6ehX8/2uUoR+wzF4xQ2U5a
 ufsVCL2U4Z7XgLw8wLvZfnKoDWcNgAJJATYPy3rkYqSfn1+8o/5FQ4Wrj4Q0NvtHQiEx
 FdvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=s26sY2t7Cm07LjYh/TvjY9F1W4BWnK79s2pdBeBpsHc=;
 b=a+VnmQWdz6SxPGxM3OXyavIfz2CDGN+UyALP9/gcC1+ota1XFqUREWDQfD/q+e/zZm
 sX52/XOiolXDHKYCG8OXYebSX3oRkaINE3oMwCwefWEJvl3T1dTMe/1M8m/v+2LyWJ9L
 fr6siL08+rIp2vmQlUZKeBrNy3ZxoKixF3fHX1jpcBgp6GXtjbsWFuqkbWKtIVKXqWzs
 eYbAzO6jdLp/siJecMkBhXs9d9RBeD726HTp3ES3WbfTYuXRkAYAbDluKrhjmmwB9Fmi
 X39ec78ij5j8yWF5O895gL2vkdNy5+bpMjlHGCsBALQ8rN58RKVk2x/GG5PLU77RIPGC
 p3rg==
X-Gm-Message-State: AOAM532U8aiP6H0WdPgw5dA/59VviJDr0b45tCx1zHXKP1x2tY/ePAPA
 AJc9n4kEgV1170BBr1ybdPBUqSVkIKixiw==
X-Google-Smtp-Source: ABdhPJwcAMsMIFmqLPz/gLZZ2W0EeDWE6ONx7aud89MbX7ZYuEBsXK4AVxFX7dndNMJ8umgTkdP2Ig==
X-Received: by 2002:a05:600c:230a:: with SMTP id
 10mr2342963wmo.151.1603799132439; 
 Tue, 27 Oct 2020 04:45:32 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id 32sm1712203wro.31.2020.10.27.04.45.31
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Oct 2020 04:45:31 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 41/48] hw/misc/bcm2835_cprman: add the DSI0HSCK multiplexer
Date: Tue, 27 Oct 2020 11:44:31 +0000
Message-Id: <20201027114438.17662-42-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201027114438.17662-1-peter.maydell@linaro.org>
References: <20201027114438.17662-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32d.google.com
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

This simple mux sits between the PLL channels and the DSI0E and DSI0P
clock muxes. This mux selects between PLLA-DSI0 and PLLD-DSI0 channel
and outputs the selected signal to source number 4 of DSI0E/P clock
muxes. It is controlled by the cm_dsi0hsck register.

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Tested-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Signed-off-by: Luc Michel <luc@lmichel.fr>
Tested-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/misc/bcm2835_cprman.h           | 15 +++++
 include/hw/misc/bcm2835_cprman_internals.h |  6 ++
 hw/misc/bcm2835_cprman.c                   | 74 +++++++++++++++++++++-
 3 files changed, 94 insertions(+), 1 deletion(-)

diff --git a/include/hw/misc/bcm2835_cprman.h b/include/hw/misc/bcm2835_cprman.h
index 0fc8f688457..3df4ceedd2e 100644
--- a/include/hw/misc/bcm2835_cprman.h
+++ b/include/hw/misc/bcm2835_cprman.h
@@ -174,6 +174,20 @@ typedef struct CprmanClockMuxState {
     struct CprmanClockMuxState *backref[CPRMAN_NUM_CLOCK_MUX_SRC];
 } CprmanClockMuxState;
 
+typedef struct CprmanDsi0HsckMuxState {
+    /*< private >*/
+    DeviceState parent_obj;
+
+    /*< public >*/
+    CprmanClockMux id;
+
+    uint32_t *reg_cm;
+
+    Clock *plla_in;
+    Clock *plld_in;
+    Clock *out;
+} CprmanDsi0HsckMuxState;
+
 struct BCM2835CprmanState {
     /*< private >*/
     SysBusDevice parent_obj;
@@ -184,6 +198,7 @@ struct BCM2835CprmanState {
     CprmanPllState plls[CPRMAN_NUM_PLL];
     CprmanPllChannelState channels[CPRMAN_NUM_PLL_CHANNEL];
     CprmanClockMuxState clock_muxes[CPRMAN_NUM_CLOCK_MUX];
+    CprmanDsi0HsckMuxState dsi0hsck_mux;
 
     uint32_t regs[CPRMAN_NUM_REGS];
     uint32_t xosc_freq;
diff --git a/include/hw/misc/bcm2835_cprman_internals.h b/include/hw/misc/bcm2835_cprman_internals.h
index 0305448bbc7..a6e799075f7 100644
--- a/include/hw/misc/bcm2835_cprman_internals.h
+++ b/include/hw/misc/bcm2835_cprman_internals.h
@@ -15,6 +15,7 @@
 #define TYPE_CPRMAN_PLL "bcm2835-cprman-pll"
 #define TYPE_CPRMAN_PLL_CHANNEL "bcm2835-cprman-pll-channel"
 #define TYPE_CPRMAN_CLOCK_MUX "bcm2835-cprman-clock-mux"
+#define TYPE_CPRMAN_DSI0HSCK_MUX "bcm2835-cprman-dsi0hsck-mux"
 
 DECLARE_INSTANCE_CHECKER(CprmanPllState, CPRMAN_PLL,
                          TYPE_CPRMAN_PLL)
@@ -22,6 +23,8 @@ DECLARE_INSTANCE_CHECKER(CprmanPllChannelState, CPRMAN_PLL_CHANNEL,
                          TYPE_CPRMAN_PLL_CHANNEL)
 DECLARE_INSTANCE_CHECKER(CprmanClockMuxState, CPRMAN_CLOCK_MUX,
                          TYPE_CPRMAN_CLOCK_MUX)
+DECLARE_INSTANCE_CHECKER(CprmanDsi0HsckMuxState, CPRMAN_DSI0HSCK_MUX,
+                         TYPE_CPRMAN_DSI0HSCK_MUX)
 
 /* Register map */
 
@@ -223,6 +226,9 @@ REG32(CM_LOCK, 0x114)
     FIELD(CM_LOCK, FLOCKB, 9, 1)
     FIELD(CM_LOCK, FLOCKA, 8, 1)
 
+REG32(CM_DSI0HSCK, 0x120)
+    FIELD(CM_DSI0HSCK, SELPLLD, 0, 1)
+
 /*
  * This field is common to all registers. Each register write value must match
  * the CPRMAN_PASSWORD magic value in its 8 MSB.
diff --git a/hw/misc/bcm2835_cprman.c b/hw/misc/bcm2835_cprman.c
index 919a55aa23f..7a7401963d5 100644
--- a/hw/misc/bcm2835_cprman.c
+++ b/hw/misc/bcm2835_cprman.c
@@ -339,6 +339,58 @@ static const TypeInfo cprman_clock_mux_info = {
 };
 
 
+/* DSI0HSCK mux */
+
+static void dsi0hsck_mux_update(CprmanDsi0HsckMuxState *s)
+{
+    bool src_is_plld = FIELD_EX32(*s->reg_cm, CM_DSI0HSCK, SELPLLD);
+    Clock *src = src_is_plld ? s->plld_in : s->plla_in;
+
+    clock_update(s->out, clock_get(src));
+}
+
+static void dsi0hsck_mux_in_update(void *opaque)
+{
+    dsi0hsck_mux_update(CPRMAN_DSI0HSCK_MUX(opaque));
+}
+
+static void dsi0hsck_mux_init(Object *obj)
+{
+    CprmanDsi0HsckMuxState *s = CPRMAN_DSI0HSCK_MUX(obj);
+    DeviceState *dev = DEVICE(obj);
+
+    s->plla_in = qdev_init_clock_in(dev, "plla-in", dsi0hsck_mux_in_update, s);
+    s->plld_in = qdev_init_clock_in(dev, "plld-in", dsi0hsck_mux_in_update, s);
+    s->out = qdev_init_clock_out(DEVICE(s), "out");
+}
+
+static const VMStateDescription dsi0hsck_mux_vmstate = {
+    .name = TYPE_CPRMAN_DSI0HSCK_MUX,
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .fields = (VMStateField[]) {
+        VMSTATE_CLOCK(plla_in, CprmanDsi0HsckMuxState),
+        VMSTATE_CLOCK(plld_in, CprmanDsi0HsckMuxState),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+static void dsi0hsck_mux_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    dc->vmsd = &dsi0hsck_mux_vmstate;
+}
+
+static const TypeInfo cprman_dsi0hsck_mux_info = {
+    .name = TYPE_CPRMAN_DSI0HSCK_MUX,
+    .parent = TYPE_DEVICE,
+    .instance_size = sizeof(CprmanDsi0HsckMuxState),
+    .class_init = dsi0hsck_mux_class_init,
+    .instance_init = dsi0hsck_mux_init,
+};
+
+
 /* CPRMAN "top level" model */
 
 static uint32_t get_cm_lock(const BCM2835CprmanState *s)
@@ -501,6 +553,10 @@ static void cprman_write(void *opaque, hwaddr offset,
     case R_CM_EMMC2CTL ... R_CM_EMMC2DIV:
         update_mux_from_cm(s, idx);
         break;
+
+    case R_CM_DSI0HSCK:
+        dsi0hsck_mux_update(&s->dsi0hsck_mux);
+        break;
     }
 }
 
@@ -540,6 +596,8 @@ static void cprman_reset(DeviceState *dev)
         device_cold_reset(DEVICE(&s->channels[i]));
     }
 
+    device_cold_reset(DEVICE(&s->dsi0hsck_mux));
+
     for (i = 0; i < CPRMAN_NUM_CLOCK_MUX; i++) {
         device_cold_reset(DEVICE(&s->clock_muxes[i]));
     }
@@ -565,6 +623,10 @@ static void cprman_init(Object *obj)
         set_pll_channel_init_info(s, &s->channels[i], i);
     }
 
+    object_initialize_child(obj, "dsi0hsck-mux",
+                            &s->dsi0hsck_mux, TYPE_CPRMAN_DSI0HSCK_MUX);
+    s->dsi0hsck_mux.reg_cm = &s->regs[R_CM_DSI0HSCK];
+
     for (i = 0; i < CPRMAN_NUM_CLOCK_MUX; i++) {
         char *alias;
 
@@ -612,7 +674,7 @@ static void connect_mux_sources(BCM2835CprmanState *s,
         if (mapping == CPRMAN_CLOCK_SRC_FORCE_GROUND) {
             src = s->gnd;
         } else if (mapping == CPRMAN_CLOCK_SRC_DSI0HSCK) {
-            src = s->gnd; /* TODO */
+            src = s->dsi0hsck_mux.out;
         } else if (i < CPRMAN_CLOCK_SRC_PLLA) {
             src = CLK_SRC_MAPPING[i];
         } else {
@@ -650,6 +712,15 @@ static void cprman_realize(DeviceState *dev, Error **errp)
         }
     }
 
+    clock_set_source(s->dsi0hsck_mux.plla_in,
+                     s->channels[CPRMAN_PLLA_CHANNEL_DSI0].out);
+    clock_set_source(s->dsi0hsck_mux.plld_in,
+                     s->channels[CPRMAN_PLLD_CHANNEL_DSI0].out);
+
+    if (!qdev_realize(DEVICE(&s->dsi0hsck_mux), NULL, errp)) {
+        return;
+    }
+
     for (i = 0; i < CPRMAN_NUM_CLOCK_MUX; i++) {
         CprmanClockMuxState *clock_mux = &s->clock_muxes[i];
 
@@ -700,6 +771,7 @@ static void cprman_register_types(void)
     type_register_static(&cprman_pll_info);
     type_register_static(&cprman_pll_channel_info);
     type_register_static(&cprman_clock_mux_info);
+    type_register_static(&cprman_dsi0hsck_mux_info);
 }
 
 type_init(cprman_register_types);
-- 
2.20.1



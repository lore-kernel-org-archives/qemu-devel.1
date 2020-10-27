Return-Path: <SRS0=gwGE=EC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1415DC388F9
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 13:12:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 84CA620709
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 13:12:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fSiQaMMA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 84CA620709
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46786 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXOmJ-00045B-Jv
	for qemu-devel@archiver.kernel.org; Tue, 27 Oct 2020 09:12:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52500)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kXNQ0-00023Z-FM
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 07:45:36 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329]:56030)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kXNPu-0004lr-M0
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 07:45:36 -0400
Received: by mail-wm1-x329.google.com with SMTP id a72so1055401wme.5
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2020 04:45:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=04ZiDCtkLCgfzieeRxOwIUVKHsPUc/VFMmrqtzjq3w0=;
 b=fSiQaMMAJ/LYHSOXNy9jiwP9y+erAJqgIEw38N9ObR38YqHMAsO3OC+PrBpOCRrF+O
 sQtjg+9xIuaYR6GbF0b7g8T/wQtqMhtxwq9RrEINoED+u54sAdr1ae8NbnUQw8J80Tzj
 g0I2bYHMudISuovWAotEm74iQQ/j8CoRxqAfUznlDqmLo/D8BbC+Yi7POg4dA80+HeBw
 YpL5PZWP5je+MGiIyN1C17+AH7UD+ooJdXabW/JRbEhrJRLncLdtYmXQYitJlvm4/U+I
 mynKS5YVdiYfdwHiaSu8hdaoLlAy0ldNNzOgE8ZVoBg5VISd0xZvDFH6GL74I0XGaMvl
 29vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=04ZiDCtkLCgfzieeRxOwIUVKHsPUc/VFMmrqtzjq3w0=;
 b=bOonEGSNxhsPdUvwiyymg2cspdq9/TcJDGn08htQM6RNPeSUjqKKutvkmETjEo/vQf
 kSFnL5oiHRaANF6BNdi+9b0WNVBK16Z85kynLtPd1p4TWpbLLq9NiKMgJuGAzMjgtzQC
 zVLe6onzThAdA24l87cYOYdNstlPoHQo2RSW7Onotrnpw6c6SdIXYGkT3imt2JEbrG8y
 wbqE/pirSYXtwQETxwmBFx6vMfPzQKTXIXusWhn4sTcY5J2rF5/GAKCX1zA4YZ0J+rSn
 asKgNTYJ5R8a9KnBtdYhZKQLGkiSCK59om1jD/wNEZKzvUj/Z9387u6xLNPRA1/kFeTm
 HoFQ==
X-Gm-Message-State: AOAM5316Hc+xAagDRUF0aECvT58l+urGWb24nyXM/R4zZkH7Wr5T5UrN
 3wH4/5enoZmYwDBSiniMnmpBfTBwYuxRNA==
X-Google-Smtp-Source: ABdhPJyNjisFmzlDCZiQzQZ/XIYu/ciUDvV+f/D7nhMJAeRbt8fJezcY/Gjy0XBq2egvkVabzO5zcA==
X-Received: by 2002:a1c:980a:: with SMTP id a10mr363152wme.103.1603799128944; 
 Tue, 27 Oct 2020 04:45:28 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id 32sm1712203wro.31.2020.10.27.04.45.27
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Oct 2020 04:45:27 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 38/48] hw/misc/bcm2835_cprman: implement PLL channels behaviour
Date: Tue, 27 Oct 2020 11:44:28 +0000
Message-Id: <20201027114438.17662-39-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201027114438.17662-1-peter.maydell@linaro.org>
References: <20201027114438.17662-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x329.google.com
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

A PLL channel is able to further divide the generated PLL frequency.
The divider is given in the CTRL_A2W register. Some channels have an
additional fixed divider which is always applied to the signal.

Tested-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Signed-off-by: Luc Michel <luc@lmichel.fr>
Tested-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/misc/bcm2835_cprman.c | 33 ++++++++++++++++++++++++++++++++-
 1 file changed, 32 insertions(+), 1 deletion(-)

diff --git a/hw/misc/bcm2835_cprman.c b/hw/misc/bcm2835_cprman.c
index 12fa78181b5..71c1d7b9e7b 100644
--- a/hw/misc/bcm2835_cprman.c
+++ b/hw/misc/bcm2835_cprman.c
@@ -134,9 +134,40 @@ static const TypeInfo cprman_pll_info = {
 
 /* PLL channel */
 
+static bool pll_channel_is_enabled(CprmanPllChannelState *channel)
+{
+    /*
+     * XXX I'm not sure of the purpose of the LOAD field. The Linux driver does
+     * not set it when enabling the channel, but does clear it when disabling
+     * it.
+     */
+    return !FIELD_EX32(*channel->reg_a2w_ctrl, A2W_PLLx_CHANNELy, DISABLE)
+        && !(*channel->reg_cm & channel->hold_mask);
+}
+
 static void pll_channel_update(CprmanPllChannelState *channel)
 {
-    clock_update(channel->out, 0);
+    uint64_t freq, div;
+
+    if (!pll_channel_is_enabled(channel)) {
+        clock_update(channel->out, 0);
+        return;
+    }
+
+    div = FIELD_EX32(*channel->reg_a2w_ctrl, A2W_PLLx_CHANNELy, DIV);
+
+    if (!div) {
+        /*
+         * It seems that when the divider value is 0, it is considered as
+         * being maximum by the hardware (see the Linux driver).
+         */
+        div = R_A2W_PLLx_CHANNELy_DIV_MASK;
+    }
+
+    /* Some channels have an additional fixed divider */
+    freq = clock_get_hz(channel->pll_in) / (div * channel->fixed_divider);
+
+    clock_update_hz(channel->out, freq);
 }
 
 /* Update a PLL and all its channels */
-- 
2.20.1



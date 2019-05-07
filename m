Return-Path: <SRS0=60fc=TH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BF8BC004C9
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2019 12:13:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 63AC8205ED
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2019 12:13:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UxldnRDP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 63AC8205ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:45801 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hNyyS-0001Gv-NA
	for qemu-devel@archiver.kernel.org; Tue, 07 May 2019 08:13:32 -0400
Received: from eggs.gnu.org ([209.51.188.92]:44980)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hNylx-0007iW-FM
	for qemu-devel@nongnu.org; Tue, 07 May 2019 08:00:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hNyls-0003xZ-F0
	for qemu-devel@nongnu.org; Tue, 07 May 2019 08:00:37 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334]:35279)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hNyls-0003uX-74
	for qemu-devel@nongnu.org; Tue, 07 May 2019 08:00:32 -0400
Received: by mail-wm1-x334.google.com with SMTP id y197so19641470wmd.0
	for <qemu-devel@nongnu.org>; Tue, 07 May 2019 05:00:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:subject:date:message-id:in-reply-to:references:mime-version
	:content-transfer-encoding;
	bh=z9A+d6NR/272WHXylxaqVz5VB4YHQmOPLGtdfveFKqg=;
	b=UxldnRDPuwOfg7GN6XbtDRF3treUI0QrxrCSxGUbG4TTTEe26P0Evnkeaat9QMR12Q
	V5xXBt0eSI1IISHa35Fiz4X+x0iEyXCKfL1CAcM2nhtz+rIjfv7rlo8zMbgEwjfZtdq9
	eDW55KPp7BSRaZqCpUuvSNuKaytiGsbFTbmAtbRVhoUEHAe2mKALUQWr0kYlj5neWFiz
	EoNEudugkuqr2SVxUcLQcDg2dw6bfgpZN6IwdEWReJdAM9dKFHJVH0p2mJzdmaSiRXiT
	usEeiS7yxtz4E8yqotdNxzU6UheeXYOPU5T41xn+oY7tNPIN/tZZtfSJReUD+0JUGVp+
	BbWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=z9A+d6NR/272WHXylxaqVz5VB4YHQmOPLGtdfveFKqg=;
	b=rAFLtFIpWlVX+lwaAVlnAT6b1U1wzhwtDXwCihoW8zaSq9CJd/3NdPdo5VwprzOcxp
	a8xuaYHsayUrpvr/jQlAQWmQVU/29cyVesNIo81fwxWrHCWNflNPSpbFeLXH74rIMKaI
	MWI7dHRO8qO7lSVfcR9uyGdQO0L1XbGXVziqYcum08Zs2/ij7ZTr3bz0tVgn1N00S4S+
	+UstncPIo4CmAa0os1x4XjfeIHrmtihsEbhgjF6MHQ5Lmg2Hr/hnLCgQOiW5AcvjQOyY
	xydPlx25aqLIZWX44HH2gZx7nbPSCz9cMkQuptZAN4CYcQDBjFjAX6z0PcrSW5MYhlMo
	ih6A==
X-Gm-Message-State: APjAAAV5+n/Lw9bnFI6InfvPF9708/SHYpPhrPSEqcy2oZsKT5LBxML8
	f1PgJRehmmJpmZZb/eMYFwZSrS8R/OU=
X-Google-Smtp-Source: APXvYqx1N9e4z76Wk6NRPazoBLCM3gYtc4+9pkxohxX8d8Vr1k2kW5WwFiElkcjswxc8+0nexnFMrA==
X-Received: by 2002:a1c:f50a:: with SMTP id t10mr19881056wmh.86.1557230431051; 
	Tue, 07 May 2019 05:00:31 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
	by smtp.gmail.com with ESMTPSA id g3sm12348596wmf.9.2019.05.07.05.00.29
	for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 07 May 2019 05:00:30 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Date: Tue,  7 May 2019 13:00:08 +0100
Message-Id: <20190507120011.18100-13-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190507120011.18100-1-peter.maydell@linaro.org>
References: <20190507120011.18100-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::334
Subject: [Qemu-devel] [PULL 12/15] hw/intc/armv7m_nvic: NS BFAR and BFSR are
 RAZ/WI if BFHFNMINS == 0
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The non-secure versions of the BFAR and BFSR registers are
supposed to be RAZ/WI if AICR.BFHFNMINS == 0; we were
incorrectly allowing NS code to access the real values.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20190430131439.25251-3-peter.maydell@linaro.org
---
 hw/intc/armv7m_nvic.c | 27 ++++++++++++++++++++++++---
 1 file changed, 24 insertions(+), 3 deletions(-)

diff --git a/hw/intc/armv7m_nvic.c b/hw/intc/armv7m_nvic.c
index 131b5938b9a..15cba63c964 100644
--- a/hw/intc/armv7m_nvic.c
+++ b/hw/intc/armv7m_nvic.c
@@ -1167,6 +1167,10 @@ static uint32_t nvic_readl(NVICState *s, uint32_t offset, MemTxAttrs attrs)
         if (!arm_feature(&cpu->env, ARM_FEATURE_M_MAIN)) {
             goto bad_offset;
         }
+        if (!attrs.secure &&
+            !(s->cpu->env.v7m.aircr & R_V7M_AIRCR_BFHFNMINS_MASK)) {
+            return 0;
+        }
         return cpu->env.v7m.bfar;
     case 0xd3c: /* Aux Fault Status.  */
         /* TODO: Implement fault status registers.  */
@@ -1646,6 +1650,10 @@ static void nvic_writel(NVICState *s, uint32_t offset, uint32_t value,
         if (!arm_feature(&cpu->env, ARM_FEATURE_M_MAIN)) {
             goto bad_offset;
         }
+        if (!attrs.secure &&
+            !(s->cpu->env.v7m.aircr & R_V7M_AIRCR_BFHFNMINS_MASK)) {
+            return;
+        }
         cpu->env.v7m.bfar = value;
         return;
     case 0xd3c: /* Aux Fault Status.  */
@@ -2130,11 +2138,18 @@ static MemTxResult nvic_sysreg_read(void *opaque, hwaddr addr,
             val = 0;
             break;
         };
-        /* The BFSR bits [15:8] are shared between security states
-         * and we store them in the NS copy
+        /*
+         * The BFSR bits [15:8] are shared between security states
+         * and we store them in the NS copy. They are RAZ/WI for
+         * NS code if AIRCR.BFHFNMINS is 0.
          */
         val = s->cpu->env.v7m.cfsr[attrs.secure];
-        val |= s->cpu->env.v7m.cfsr[M_REG_NS] & R_V7M_CFSR_BFSR_MASK;
+        if (!attrs.secure &&
+            !(s->cpu->env.v7m.aircr & R_V7M_AIRCR_BFHFNMINS_MASK)) {
+            val &= ~R_V7M_CFSR_BFSR_MASK;
+        } else {
+            val |= s->cpu->env.v7m.cfsr[M_REG_NS] & R_V7M_CFSR_BFSR_MASK;
+        }
         val = extract32(val, (offset - 0xd28) * 8, size * 8);
         break;
     case 0xfe0 ... 0xfff: /* ID.  */
@@ -2249,6 +2264,12 @@ static MemTxResult nvic_sysreg_write(void *opaque, hwaddr addr,
          */
         value <<= ((offset - 0xd28) * 8);
 
+        if (!attrs.secure &&
+            !(s->cpu->env.v7m.aircr & R_V7M_AIRCR_BFHFNMINS_MASK)) {
+            /* BFSR bits are RAZ/WI for NS if BFHFNMINS is set */
+            value &= ~R_V7M_CFSR_BFSR_MASK;
+        }
+
         s->cpu->env.v7m.cfsr[attrs.secure] &= ~value;
         if (attrs.secure) {
             /* The BFSR bits [15:8] are shared between security states
-- 
2.20.1



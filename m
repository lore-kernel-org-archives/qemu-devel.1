Return-Path: <SRS0=tSBD=YP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B6EACA9EA0
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2019 14:05:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CE82B21783
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2019 14:05:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lEJtwjdc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE82B21783
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58056 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iMunF-000875-E0
	for qemu-devel@archiver.kernel.org; Tue, 22 Oct 2019 10:05:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37141)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iMuHM-0003PV-Oo
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 09:32:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iMuHL-0001XF-Iu
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 09:32:52 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:41531)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iMuHK-0001Vs-Bb
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 09:32:51 -0400
Received: by mail-wr1-x444.google.com with SMTP id p4so18100345wrm.8
 for <qemu-devel@nongnu.org>; Tue, 22 Oct 2019 06:32:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=piAMQwhcAMpAuk7COCrPy9dKwgZFmvyHF81YOlRi688=;
 b=lEJtwjdc53lnShArXMUHC3jKJXou3EzRy/h3gMT3RpOFci2czGRkEUCAfp9K1Qvr4Z
 NDNIDCBn16GUoCpXpzfja5Y6ENsjnuAXmj82cr3jXI89ZICsnMqJ44LcAvpq6P4ccdFN
 0MdizRoJV214kApx+cbx9CwV/uLmeMvwXItuzG0m3mWunRU1RMUInID4fUZ76S5kpAaR
 Drg9lAa98FC7P9N9cf9CcoKgAKW7PrscbG21Ra0O5xlISvoox7qiz5BEOJrspsSmrETf
 +d3nbV1q4LA9sZu0KU9uR5EqfKtOe2owJTRKXvFbecqyTdWjMWiNdBz2FCbXf2x65MMB
 YTvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=piAMQwhcAMpAuk7COCrPy9dKwgZFmvyHF81YOlRi688=;
 b=DEE/EfndJOtJ+a9W6eo9y0J0Lfc0ENiYQzDs2qC/5zqJxeYeJDr9P5xcp/WDchSThR
 aLRZja3cLNylYLv8IlTg7edZnLUFWVKCE05AChN7IAU/crAitkKy2joc1tVz375SESu6
 oERnQzH8vimuuMIogltDzXEI37PVunzdJFD6OcMfCgjeZKcHQ6dMM831MwZBFh9BL0+L
 /if4lMviVabyxOWWGTb4StWZP5hv9WRFT+FVM1ne7TxJTpyKbsxXgrNd+xvCdO4ROabm
 +6NbsyEcdXxMIIVxm2j97bLaiU4p9OveO176brF871kIjfP5XZTeCr+CzSec27kuZW3z
 LWwA==
X-Gm-Message-State: APjAAAV4+cnM78K4ytB5ccQkMLCaB5RNHOGmoX7uhzr2GABD2ojj5BM/
 8j5DCCHmI4L59dJKmNF6AEcRi7HmSe0=
X-Google-Smtp-Source: APXvYqxVu4h6S4wa3DcEwQpSLUvbm/XSPfpJTCHnpDUOMz3IXRnQVTRx2IC08y4wcxxEHfKM2PGh+w==
X-Received: by 2002:a5d:4885:: with SMTP id g5mr3902834wrq.219.1571751168737; 
 Tue, 22 Oct 2019 06:32:48 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id r2sm20263856wma.1.2019.10.22.06.32.47
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Oct 2019 06:32:47 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 31/41] target/arm: Rebuild hflags for M-profile NVIC
Date: Tue, 22 Oct 2019 14:31:24 +0100
Message-Id: <20191022133134.14487-32-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191022133134.14487-1-peter.maydell@linaro.org>
References: <20191022133134.14487-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::444
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

From: Richard Henderson <richard.henderson@linaro.org>

Continue setting, but not relying upon, env->hflags.

Suggested-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20191018174431.1784-22-richard.henderson@linaro.org
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/intc/armv7m_nvic.c | 22 +++++++++++++---------
 1 file changed, 13 insertions(+), 9 deletions(-)

diff --git a/hw/intc/armv7m_nvic.c b/hw/intc/armv7m_nvic.c
index 8e93e51e815..e8c74f9ebaf 100644
--- a/hw/intc/armv7m_nvic.c
+++ b/hw/intc/armv7m_nvic.c
@@ -2251,7 +2251,7 @@ static MemTxResult nvic_sysreg_write(void *opaque, hwaddr addr,
             }
         }
         nvic_irq_update(s);
-        return MEMTX_OK;
+        goto exit_ok;
     case 0x200 ... 0x23f: /* NVIC Set pend */
         /* the special logic in armv7m_nvic_set_pending()
          * is not needed since IRQs are never escalated
@@ -2269,9 +2269,9 @@ static MemTxResult nvic_sysreg_write(void *opaque, hwaddr addr,
             }
         }
         nvic_irq_update(s);
-        return MEMTX_OK;
+        goto exit_ok;
     case 0x300 ... 0x33f: /* NVIC Active */
-        return MEMTX_OK; /* R/O */
+        goto exit_ok; /* R/O */
     case 0x400 ... 0x5ef: /* NVIC Priority */
         startvec = (offset - 0x400) + NVIC_FIRST_IRQ; /* vector # */
 
@@ -2281,10 +2281,10 @@ static MemTxResult nvic_sysreg_write(void *opaque, hwaddr addr,
             }
         }
         nvic_irq_update(s);
-        return MEMTX_OK;
+        goto exit_ok;
     case 0xd18 ... 0xd1b: /* System Handler Priority (SHPR1) */
         if (!arm_feature(&s->cpu->env, ARM_FEATURE_M_MAIN)) {
-            return MEMTX_OK;
+            goto exit_ok;
         }
         /* fall through */
     case 0xd1c ... 0xd23: /* System Handler Priority (SHPR2, SHPR3) */
@@ -2299,10 +2299,10 @@ static MemTxResult nvic_sysreg_write(void *opaque, hwaddr addr,
             set_prio(s, hdlidx, sbank, newprio);
         }
         nvic_irq_update(s);
-        return MEMTX_OK;
+        goto exit_ok;
     case 0xd28 ... 0xd2b: /* Configurable Fault Status (CFSR) */
         if (!arm_feature(&s->cpu->env, ARM_FEATURE_M_MAIN)) {
-            return MEMTX_OK;
+            goto exit_ok;
         }
         /* All bits are W1C, so construct 32 bit value with 0s in
          * the parts not written by the access size
@@ -2322,15 +2322,19 @@ static MemTxResult nvic_sysreg_write(void *opaque, hwaddr addr,
              */
             s->cpu->env.v7m.cfsr[M_REG_NS] &= ~(value & R_V7M_CFSR_BFSR_MASK);
         }
-        return MEMTX_OK;
+        goto exit_ok;
     }
     if (size == 4) {
         nvic_writel(s, offset, value, attrs);
-        return MEMTX_OK;
+        goto exit_ok;
     }
     qemu_log_mask(LOG_GUEST_ERROR,
                   "NVIC: Bad write of size %d at offset 0x%x\n", size, offset);
     /* This is UNPREDICTABLE; treat as RAZ/WI */
+
+ exit_ok:
+    /* Ensure any changes made are reflected in the cached hflags.  */
+    arm_rebuild_hflags(&s->cpu->env);
     return MEMTX_OK;
 }
 
-- 
2.20.1



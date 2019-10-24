Return-Path: <SRS0=Jnn8=YR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4680FCA9EAF
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 17:06:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0D8A620650
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 17:06:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YGAt38FM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D8A620650
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48272 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNgYk-0008ED-R6
	for qemu-devel@archiver.kernel.org; Thu, 24 Oct 2019 13:06:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58041)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iNfxz-0007io-0y
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 12:28:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iNfxx-0000tL-PU
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 12:28:02 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335]:53657)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iNfxx-0000so-JP
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 12:28:01 -0400
Received: by mail-wm1-x335.google.com with SMTP id n7so2717854wmc.3
 for <qemu-devel@nongnu.org>; Thu, 24 Oct 2019 09:28:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=uYiMMG2g4SkvD83lkxSsHqqS6mTu3zs23wVOsym/Wvk=;
 b=YGAt38FM7o8oUVR59UnnmmzkbFzAmnaIZxnUBJH6VKo1MzNxRxOTdY67M90w5P81cx
 JEa5pRgnv+YsIWkf6q4kRzDZrEhvetjMaYgwtVleJS6g3dSq6NUNJ8PbqKowh45oFBDZ
 Y8Ss6n4xbbwRiWm7cuMnX1L5gewDcVtdp1kVfg9hohP2+fgmm/AbDF/980hN/GkVQIPb
 xK6mk9JS+nZNeIhbq727+wgIgP7Ghl3M630OrlwsS/8g13Fj1uhpIyNSVB1J5Ki/IMpf
 VInc2J/nXEuHwagAht0th5U0jIFQmv64NnAPgO4xrsR74rZStfyznJzy55/AUq3QED8T
 SXPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=uYiMMG2g4SkvD83lkxSsHqqS6mTu3zs23wVOsym/Wvk=;
 b=qUJ7qBQo5eZZcMELbO/yZcH//ik+zBPtFIKtvlHZmz3psSLQLpXXgD5wRplD9VC/gB
 SRU2S7myNFl3PSoibWMYNSnKl8kjkjyxJzdt3yhEZfjk5J+n52eziTZSOV0gCDziOVfx
 RnuMjHaZFeJeA9OXRrBKwCgXplXOONGJzV1tFC+a61K1GDBCt60JuhS/RUWiBuNTtLfJ
 qA5R1o+tudn0DbKoEHB6daH1Sn1GeI1tb/SAcgCO509PW6nyOzRYh8qMnaiwrcUgwRLe
 3Lt1pWKsIi/2RDBmUkP/2D+Avuaru1ud8RYCTXUZWDHrTOQOOWKAjGwm9KCbt52UCYMh
 gmJw==
X-Gm-Message-State: APjAAAV5eO8R7c0zW0EhQzF4L6ycEecNFSyLEM6Z+N0FEmohLd5nFoPl
 S5zWhX0em8R3lNOUGPqa7oTvQti2s7A=
X-Google-Smtp-Source: APXvYqwOuOVyn7fGOM9kiTDjzA30LaLrk2WOvQP0ieRp0MbiRWoQ8MqE+mjgDiTTvqEwDYJxRFGHrQ==
X-Received: by 2002:a05:600c:2056:: with SMTP id
 p22mr5677498wmg.44.1571934480301; 
 Thu, 24 Oct 2019 09:28:00 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id r27sm42606124wrc.55.2019.10.24.09.27.59
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Oct 2019 09:27:59 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 27/51] hw/net/fsl_etsec/etsec.c: Switch to transaction-based
 ptimer API
Date: Thu, 24 Oct 2019 17:27:00 +0100
Message-Id: <20191024162724.31675-28-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191024162724.31675-1-peter.maydell@linaro.org>
References: <20191024162724.31675-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::335
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

Switch the fsl_etsec code away from bottom-half based ptimers to
the new transaction-based ptimer API.  This just requires adding
begin/commit calls around the various places that modify the ptimer
state, and using the new ptimer_init() function to create the timer.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-id: 20191017132122.4402-2-peter.maydell@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/net/fsl_etsec/etsec.h | 1 -
 hw/net/fsl_etsec/etsec.c | 9 +++++----
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/hw/net/fsl_etsec/etsec.h b/hw/net/fsl_etsec/etsec.h
index 09d05c21338..7951c3ad65f 100644
--- a/hw/net/fsl_etsec/etsec.h
+++ b/hw/net/fsl_etsec/etsec.h
@@ -141,7 +141,6 @@ typedef struct eTSEC {
     uint16_t phy_control;
 
     /* Polling */
-    QEMUBH *bh;
     struct ptimer_state *ptimer;
 
     /* Whether we should flush the rx queue when buffer becomes available. */
diff --git a/hw/net/fsl_etsec/etsec.c b/hw/net/fsl_etsec/etsec.c
index d9b3e8c691e..717de76569a 100644
--- a/hw/net/fsl_etsec/etsec.c
+++ b/hw/net/fsl_etsec/etsec.c
@@ -34,7 +34,6 @@
 #include "etsec.h"
 #include "registers.h"
 #include "qemu/log.h"
-#include "qemu/main-loop.h"
 #include "qemu/module.h"
 
 /* #define HEX_DUMP */
@@ -195,9 +194,11 @@ static void write_dmactrl(eTSEC          *etsec,
 
     if (!(value & DMACTRL_WOP)) {
         /* Start polling */
+        ptimer_transaction_begin(etsec->ptimer);
         ptimer_stop(etsec->ptimer);
         ptimer_set_count(etsec->ptimer, 1);
         ptimer_run(etsec->ptimer, 1);
+        ptimer_transaction_commit(etsec->ptimer);
     }
 }
 
@@ -391,10 +392,10 @@ static void etsec_realize(DeviceState *dev, Error **errp)
                               object_get_typename(OBJECT(dev)), dev->id, etsec);
     qemu_format_nic_info_str(qemu_get_queue(etsec->nic), etsec->conf.macaddr.a);
 
-
-    etsec->bh     = qemu_bh_new(etsec_timer_hit, etsec);
-    etsec->ptimer = ptimer_init_with_bh(etsec->bh, PTIMER_POLICY_DEFAULT);
+    etsec->ptimer = ptimer_init(etsec_timer_hit, etsec, PTIMER_POLICY_DEFAULT);
+    ptimer_transaction_begin(etsec->ptimer);
     ptimer_set_freq(etsec->ptimer, 100);
+    ptimer_transaction_commit(etsec->ptimer);
 }
 
 static void etsec_instance_init(Object *obj)
-- 
2.20.1



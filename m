Return-Path: <SRS0=Jnn8=YR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8B69CA9EAF
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 17:18:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B088A21655
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 17:18:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tmCbLpdv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B088A21655
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48522 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNgko-0001ic-2l
	for qemu-devel@archiver.kernel.org; Thu, 24 Oct 2019 13:18:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58057)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iNfy0-0007ky-0u
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 12:28:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iNfxy-0000tp-RO
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 12:28:03 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:39155)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iNfxy-0000tU-Kx
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 12:28:02 -0400
Received: by mail-wm1-x342.google.com with SMTP id r141so3206741wme.4
 for <qemu-devel@nongnu.org>; Thu, 24 Oct 2019 09:28:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=bZdsncuNDnJQ9EFbxxKEYZAYg/nM+O7WLjtwwmpCRgA=;
 b=tmCbLpdvCUOf21XT0hPElWB8zybl3kwItTk95krsoe+VzpYBuZInMRw4kEIeI5EpOD
 pBhU1TlZdrVIjtDnRwPMkgrmdgwznTeUqFrW/8Gq/sQNIfvzr0eR67X7mM59+sMG2mzW
 p0TuQOSu/iU/BGNFZuLVCFlj6IXntbuATuN/RuqoZsztPRdoCqYIH9vWpP4x0KDrQRQK
 SpQVHWcr/WH+Vg5Fl4/xpNzbiJ51rJORwm1Hilhzr9vXzin3R/MnCqJ2V0A2Udn+28GA
 5muLIlurWpSH+dFTH3H5lNoNLcAbjsecsx91EOR4otnDCHdnZZzqfzFLMsgVngW1WRZ8
 4DGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=bZdsncuNDnJQ9EFbxxKEYZAYg/nM+O7WLjtwwmpCRgA=;
 b=YMoZowtzXRlnUTEZo7sIHaMAhYMxI/ttRgnSUIzxUyouFbHB77vW3fNI3fIbS2wPve
 q9NJDarBGmTkvFDOkeMSHMXfbVoZDeXq9I8Ld+Pk3BVKx3HQZrcvbNAcva3KkNU9yKIj
 7vR2LBhLSw9tytNjqxspY5O4/U5lfpcyYGydu6pdAx+MZFTzE0O9bT0Cs8ckxoL0ZTxG
 jav29LqPvPaD53qfWrDgIJxC+TrWLqRiNn8OGnloA3MOJlf5YbTCCE+vXfdlE9z9mK3p
 lHBXNN+F4iMTEW2aw/oYzWV9GDU8awdxY7I5J0o3M6Iq6dfmMjloXWwSdSBnl//B9jIc
 jn+g==
X-Gm-Message-State: APjAAAXdKpiULbzFBdfMxkA0H8gam5GTy/OJUBkYVpMf3J5iOqxykZF+
 MtEyKXcmSqsUqXi6Yrx0G6wSEr4/yt0=
X-Google-Smtp-Source: APXvYqxS5C72jo72kh980pRa6BteDh0onaFTPPPIvbNMValLtpYcAdGSl6aWtdK4e1RYnVBH8W/l3A==
X-Received: by 2002:a1c:9d07:: with SMTP id g7mr5739692wme.53.1571934481299;
 Thu, 24 Oct 2019 09:28:01 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id r27sm42606124wrc.55.2019.10.24.09.28.00
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Oct 2019 09:28:00 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 28/51] hw/timer/xilinx_timer.c: Switch to transaction-based
 ptimer API
Date: Thu, 24 Oct 2019 17:27:01 +0100
Message-Id: <20191024162724.31675-29-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191024162724.31675-1-peter.maydell@linaro.org>
References: <20191024162724.31675-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::342
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

Switch the xilinx_timer code away from bottom-half based ptimers to
the new transaction-based ptimer API.  This just requires adding
begin/commit calls around the various places that modify the ptimer
state, and using the new ptimer_init() function to create the timer.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-id: 20191017132122.4402-3-peter.maydell@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/timer/xilinx_timer.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/hw/timer/xilinx_timer.c b/hw/timer/xilinx_timer.c
index 92dbff304d9..7191ea54f58 100644
--- a/hw/timer/xilinx_timer.c
+++ b/hw/timer/xilinx_timer.c
@@ -28,7 +28,6 @@
 #include "hw/ptimer.h"
 #include "hw/qdev-properties.h"
 #include "qemu/log.h"
-#include "qemu/main-loop.h"
 #include "qemu/module.h"
 
 #define D(x)
@@ -52,7 +51,6 @@
 
 struct xlx_timer
 {
-    QEMUBH *bh;
     ptimer_state *ptimer;
     void *parent;
     int nr; /* for debug.  */
@@ -134,6 +132,7 @@ timer_read(void *opaque, hwaddr addr, unsigned int size)
     return r;
 }
 
+/* Must be called inside ptimer transaction block */
 static void timer_enable(struct xlx_timer *xt)
 {
     uint64_t count;
@@ -174,8 +173,11 @@ timer_write(void *opaque, hwaddr addr,
                 value &= ~TCSR_TINT;
 
             xt->regs[addr] = value & 0x7ff;
-            if (value & TCSR_ENT)
+            if (value & TCSR_ENT) {
+                ptimer_transaction_begin(xt->ptimer);
                 timer_enable(xt);
+                ptimer_transaction_commit(xt->ptimer);
+            }
             break;
  
         default:
@@ -220,9 +222,10 @@ static void xilinx_timer_realize(DeviceState *dev, Error **errp)
 
         xt->parent = t;
         xt->nr = i;
-        xt->bh = qemu_bh_new(timer_hit, xt);
-        xt->ptimer = ptimer_init_with_bh(xt->bh, PTIMER_POLICY_DEFAULT);
+        xt->ptimer = ptimer_init(timer_hit, xt, PTIMER_POLICY_DEFAULT);
+        ptimer_transaction_begin(xt->ptimer);
         ptimer_set_freq(xt->ptimer, t->freq_hz);
+        ptimer_transaction_commit(xt->ptimer);
     }
 
     memory_region_init_io(&t->mmio, OBJECT(t), &timer_ops, t, "xlnx.xps-timer",
-- 
2.20.1



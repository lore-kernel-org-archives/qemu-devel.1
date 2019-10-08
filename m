Return-Path: <SRS0=wvJ7=YB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88A6FC4360C
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2019 17:29:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 595BC217D7
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2019 17:29:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Bzpfq2Bz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 595BC217D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59162 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iHtIu-0001LZ-2l
	for qemu-devel@archiver.kernel.org; Tue, 08 Oct 2019 13:29:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48965)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iHt7a-0006ke-Vo
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 13:18:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iHt7Y-0002LT-Sw
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 13:18:02 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:42932)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iHt7W-0002IB-Pw
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 13:18:00 -0400
Received: by mail-wr1-x443.google.com with SMTP id n14so20285749wrw.9
 for <qemu-devel@nongnu.org>; Tue, 08 Oct 2019 10:17:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=WdDJaaZ/rRs7yx03rtQr/OXY2zE5aVv2WsD7FCB9XiQ=;
 b=Bzpfq2BzeT6i8Poc+l2rSXhqmOGm8dTTj76XumrT9oGnPLL1M+zL++D9E3KgpycklD
 HU8f218i7bjlUbeuBlBq8ykAvW0UdgMbe+K00Q1f1yU3mc6xQDdinP9897UyPqVRj5J6
 SZDOuz6xnlIB3H4mC6ZblzRfvY0CrzFoMA2ykkgFFyjwbnrVObElxdhoP801JFxFIAb1
 CIkv4xoKuCVlAjjYdTcqIVB3/jyr7bvFBK/XENEW4U4o0LtHz7itbyEcJRJ6sx33ZyFH
 J6WfAHyh11e24CbXxsiux1+myW+UURUcGYN08mvq9bSLFCe8SeuqWpeWII8VoYKYxgil
 uX3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=WdDJaaZ/rRs7yx03rtQr/OXY2zE5aVv2WsD7FCB9XiQ=;
 b=iBTVfU07T+9AgvvLOSxgInZn9diSnwVzE21MdCTCCbX2oLglsx6ajYmhVn7mAF13xo
 y2gkkErbsmmcj3iZDtgYo0OWOHdc7JYAIJ7MTcMx0Q7D6DBVPqwVgP1wpsjRNkc1inFG
 CIuD7TQ6IdkTrZ+3QXN4oK3UvditNhUX6DbUT/kOVfBrn2ehZETrFGK2zdw+1aK8tEBJ
 54jBBUPBh/Cta7tA4C9iI7oJLKBjVt+EWxXHoDA929j49plNkAPAI8ZWBRixGLEZfGov
 9U02ZeAkovjdYUMXQGA1dc5ILqCZHOnS2dPVP9ecBxyc+oaEmAyuwzIMMGI4Yb/JehU8
 f0tQ==
X-Gm-Message-State: APjAAAXpH3LKaI8bfM9PwaxesUqEvBPTUgPUOkE5MKxMVrym/pxIf/Ct
 YZm2f7RsEyPvdEiiEfwngOFntQ==
X-Google-Smtp-Source: APXvYqzjXXcioyxMpM30PY+4g79HHKyWdeYWISJTF8s0k6k0HqhthLD0PDGSZGVwjBtC9tvceoV5PA==
X-Received: by 2002:adf:c58b:: with SMTP id m11mr26761343wrg.252.1570555076363; 
 Tue, 08 Oct 2019 10:17:56 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id z9sm19135541wrl.35.2019.10.08.10.17.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Oct 2019 10:17:55 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH v2 10/21] hw/timer/digic-timer.c: Switch to transaction-based
 ptimer API
Date: Tue,  8 Oct 2019 18:17:29 +0100
Message-Id: <20191008171740.9679-11-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191008171740.9679-1-peter.maydell@linaro.org>
References: <20191008171740.9679-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::443
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
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Switch the digic-timer.c code away from bottom-half based ptimers to
the new transaction-based ptimer API.  This just requires adding
begin/commit calls around the various places that modify the ptimer
state, and using the new ptimer_init() function to create the timer.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/timer/digic-timer.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/hw/timer/digic-timer.c b/hw/timer/digic-timer.c
index b111e1fe643..32612228daf 100644
--- a/hw/timer/digic-timer.c
+++ b/hw/timer/digic-timer.c
@@ -29,7 +29,6 @@
 #include "qemu/osdep.h"
 #include "hw/sysbus.h"
 #include "hw/ptimer.h"
-#include "qemu/main-loop.h"
 #include "qemu/module.h"
 #include "qemu/log.h"
 
@@ -52,7 +51,9 @@ static void digic_timer_reset(DeviceState *dev)
 {
     DigicTimerState *s = DIGIC_TIMER(dev);
 
+    ptimer_transaction_begin(s->ptimer);
     ptimer_stop(s->ptimer);
+    ptimer_transaction_commit(s->ptimer);
     s->control = 0;
     s->relvalue = 0;
 }
@@ -93,16 +94,20 @@ static void digic_timer_write(void *opaque, hwaddr offset,
             break;
         }
 
+        ptimer_transaction_begin(s->ptimer);
         if (value & DIGIC_TIMER_CONTROL_EN) {
             ptimer_run(s->ptimer, 0);
         }
 
         s->control = (uint32_t)value;
+        ptimer_transaction_commit(s->ptimer);
         break;
 
     case DIGIC_TIMER_RELVALUE:
         s->relvalue = extract32(value, 0, 16);
+        ptimer_transaction_begin(s->ptimer);
         ptimer_set_limit(s->ptimer, s->relvalue, 1);
+        ptimer_transaction_commit(s->ptimer);
         break;
 
     case DIGIC_TIMER_VALUE:
@@ -125,17 +130,24 @@ static const MemoryRegionOps digic_timer_ops = {
     .endianness = DEVICE_NATIVE_ENDIAN,
 };
 
+static void digic_timer_tick(void *opaque)
+{
+    /* Nothing to do on timer rollover */
+}
+
 static void digic_timer_init(Object *obj)
 {
     DigicTimerState *s = DIGIC_TIMER(obj);
 
-    s->ptimer = ptimer_init_with_bh(NULL, PTIMER_POLICY_DEFAULT);
+    s->ptimer = ptimer_init(digic_timer_tick, NULL, PTIMER_POLICY_DEFAULT);
 
     /*
      * FIXME: there is no documentation on Digic timer
      * frequency setup so let it always run at 1 MHz
      */
+    ptimer_transaction_begin(s->ptimer);
     ptimer_set_freq(s->ptimer, 1 * 1000 * 1000);
+    ptimer_transaction_commit(s->ptimer);
 
     memory_region_init_io(&s->iomem, OBJECT(s), &digic_timer_ops, s,
                           TYPE_DIGIC_TIMER, 0x100);
-- 
2.20.1



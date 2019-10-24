Return-Path: <SRS0=Jnn8=YR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EB36CA9EAF
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 17:12:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 370BC20650
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 17:12:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="c1UvOL+Z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 370BC20650
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48390 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNgec-00041e-Tu
	for qemu-devel@archiver.kernel.org; Thu, 24 Oct 2019 13:12:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58148)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iNfy7-0007z8-KI
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 12:28:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iNfy6-0000xi-FA
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 12:28:11 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:39015)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iNfy6-0000xE-9N
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 12:28:10 -0400
Received: by mail-wr1-x442.google.com with SMTP id a11so10714966wra.6
 for <qemu-devel@nongnu.org>; Thu, 24 Oct 2019 09:28:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=J21kyHeYFa+RY7GcWXJAZvmmTTUgznnvXHxn75vs05A=;
 b=c1UvOL+ZcoyfHigvuNr9oOa5gz0YKfEj0cmPw1DuUWoh8Vs8g4zcGqK/GoizhB01UP
 8xAwfC+vkMGHnUyb/m1jmCr291Rf+v8Ope1LltBpzSPj4WIJPVDRq/QNaZreT5XIm/+Q
 AVuYYP3aA0tMqDIqo25vzdFAhWGJj/1NHXBxPd6LgoPGIn5fTIb8PIomw6egGo/L7EE0
 oxDnVPLalMSAbL1R4VQpCcf2FJX+rSFgT4PzbH/aAdmN6L8s/5PvdcUfdOSntg4p7B3i
 RoM7zlKrpqtkvEs1/I9gGZIrqNGecTdjCfjQVxtTWKLXrDK/SpZhtdWgAxg+EB1gbcK/
 dowg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=J21kyHeYFa+RY7GcWXJAZvmmTTUgznnvXHxn75vs05A=;
 b=nTVFQvhvE/xcTeGfFk4MWdicMrLU2lylXFGzEi2cN4o4xNn3VodQyl7ZTAwzx9sTkU
 ThBEYhvGDjWeUkw0ZaNeRRfNZurAf7SZ6Xtb3KMVbw1VzE0l7KeiXgVpqkBytdjfQu/d
 uUtsx+B8ka1b6TTOBfICT+oUijY5OJ3ZCdalAKbZr6VfGFRJ+4wuB2QMDppj3dhysz4R
 iQ/tg0ySH0vHdBWzIFK9C+TLRL6JtcEfgVuQBMolmgYVbVKaCzzj/vDA6zPajTb1+4Xi
 1dfYp+IuCN4QaKccMTL/ez3hmA/hLKABqulCXxdAAiINi+0G1JjKwT8JijyL/j8r5v9Y
 wsrw==
X-Gm-Message-State: APjAAAUHaFmKAUy5EcBwBt3CyUzA7fzVF96zmjzjSByZjRSYVekd/PT9
 bJHXhBhPFCv2IJwx31/Grri8+zNVl8E=
X-Google-Smtp-Source: APXvYqyU26pU3Oi9FioIDWaPoR2V09qVT2df71ZItWcrVijFyRQkeq7EbhYgIQ6QIeW9TMouPIOzpQ==
X-Received: by 2002:adf:f04e:: with SMTP id t14mr4448645wro.106.1571934488067; 
 Thu, 24 Oct 2019 09:28:08 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id r27sm42606124wrc.55.2019.10.24.09.28.06
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Oct 2019 09:28:07 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 33/51] hw/m68k/mcf5206.c: Switch to transaction-based ptimer API
Date: Thu, 24 Oct 2019 17:27:06 +0100
Message-Id: <20191024162724.31675-34-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191024162724.31675-1-peter.maydell@linaro.org>
References: <20191024162724.31675-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::442
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

Switch the mcf5206 code away from bottom-half based ptimers to
the new transaction-based ptimer API.  This just requires adding
begin/commit calls around the various places that modify the ptimer
state, and using the new ptimer_init() function to create the timer.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-id: 20191021140600.10725-1-peter.maydell@linaro.org
---
 hw/m68k/mcf5206.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/hw/m68k/mcf5206.c b/hw/m68k/mcf5206.c
index a49096367cb..b155dd81705 100644
--- a/hw/m68k/mcf5206.c
+++ b/hw/m68k/mcf5206.c
@@ -8,7 +8,6 @@
 
 #include "qemu/osdep.h"
 #include "qemu/error-report.h"
-#include "qemu/main-loop.h"
 #include "cpu.h"
 #include "hw/hw.h"
 #include "hw/irq.h"
@@ -57,10 +56,12 @@ static void m5206_timer_recalibrate(m5206_timer_state *s)
     int prescale;
     int mode;
 
+    ptimer_transaction_begin(s->timer);
     ptimer_stop(s->timer);
 
-    if ((s->tmr & TMR_RST) == 0)
-        return;
+    if ((s->tmr & TMR_RST) == 0) {
+        goto exit;
+    }
 
     prescale = (s->tmr >> 8) + 1;
     mode = (s->tmr >> 1) & 3;
@@ -78,6 +79,8 @@ static void m5206_timer_recalibrate(m5206_timer_state *s)
     ptimer_set_limit(s->timer, s->trr, 0);
 
     ptimer_run(s->timer, 0);
+exit:
+    ptimer_transaction_commit(s->timer);
 }
 
 static void m5206_timer_trigger(void *opaque)
@@ -123,7 +126,9 @@ static void m5206_timer_write(m5206_timer_state *s, uint32_t addr, uint32_t val)
         s->tcr = val;
         break;
     case 0xc:
+        ptimer_transaction_begin(s->timer);
         ptimer_set_count(s->timer, val);
+        ptimer_transaction_commit(s->timer);
         break;
     case 0x11:
         s->ter &= ~val;
@@ -137,11 +142,9 @@ static void m5206_timer_write(m5206_timer_state *s, uint32_t addr, uint32_t val)
 static m5206_timer_state *m5206_timer_init(qemu_irq irq)
 {
     m5206_timer_state *s;
-    QEMUBH *bh;
 
     s = g_new0(m5206_timer_state, 1);
-    bh = qemu_bh_new(m5206_timer_trigger, s);
-    s->timer = ptimer_init_with_bh(bh, PTIMER_POLICY_DEFAULT);
+    s->timer = ptimer_init(m5206_timer_trigger, s, PTIMER_POLICY_DEFAULT);
     s->irq = irq;
     m5206_timer_reset(s);
     return s;
-- 
2.20.1



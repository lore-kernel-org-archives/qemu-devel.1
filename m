Return-Path: <SRS0=yZS3=YK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 707C3ECE58E
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 14:23:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E9A622089C
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 14:23:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="r8Oo1LfX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E9A622089C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49170 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iL6gH-0003k9-Fc
	for qemu-devel@archiver.kernel.org; Thu, 17 Oct 2019 10:23:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36232)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iL5qD-00070a-5v
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 09:29:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iL5qB-0002by-W4
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 09:29:21 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:54156)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iL5qB-0002bo-Q2
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 09:29:19 -0400
Received: by mail-wm1-x344.google.com with SMTP id i16so2578348wmd.3
 for <qemu-devel@nongnu.org>; Thu, 17 Oct 2019 06:29:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Ir767WHuQR1ReCBFZWeg1KIR738tHBrpLcvCZkSJv5k=;
 b=r8Oo1LfXq/0y3GYC8eRuhsBXo+wJ1JrhKgjChbhyO5lMKQv0KRBDZX+FL9QpKSF4xz
 Vb5HFkfFryZyDfqH9uT+5ty+UvfimN8FykQcHB7sZH1otNwc28Vef22IzVdUuxctfURl
 htbVj8j9BST5mcquQ9T+eCWl37P3KGn36HcZcjBb/6D828z3j90k4s1Wz72xFsfpPKlo
 yiNLKWofh0iGCaAlBK1bZ85cgBkiAE5Ki7S5hYGfJIOsYLnIPKtqJU2pfcyFk4wV03mB
 nSqxY+rHN7qkDCdTY1k5vJ07JM19SzzAyBMdtKvkQiW2zXMkOIN02qKMGFP9f8rH80np
 1xmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Ir767WHuQR1ReCBFZWeg1KIR738tHBrpLcvCZkSJv5k=;
 b=RgPfDDBOXi1Bbnrj6o6W8uG4xLqptod2tqMKm7x0Yha8l/M+700JdNMKymP/4Zvnm3
 ImGMeOjtWiR5x5Sp5gYoVDWYE6r77bp2Ve0rsX4C3PLNP0ZGcvhIq1EBQevrXLH7NATf
 jmHwsuXkl/74hcRJl5E6xfA31N2s2ud0cZRs1x7WmBISL7pNsgYQQP/jqa8DDtt6pSpx
 iiPpwaEhoRtFq9pZyAr5Vp7Ajbq+0PiB18MWjRLmvh4DrV+kEbbHL9Mp9d9rh7q+TJWa
 LWPuSaDcel+XTC4t3AvYvolaaVNcIMTDDLBe1JzV5cbuUxw45AV7K0ZFvh6BKOkLO10S
 bEeA==
X-Gm-Message-State: APjAAAXAr9HXOkGO8Kkb0kLJzYC07O5bjQpIOMQo1Un2OO9ZxGBv6Q3L
 8GJTcfQKckqOPyQ+5TgPfufTPONfw1F/Uw==
X-Google-Smtp-Source: APXvYqzyGbtwqEkRpcsZiSORAJhG/kUputhe5NsyPzTsIWqB2tY2QgG1Z43LxqnuStDLghPRHKC82g==
X-Received: by 2002:a1c:f212:: with SMTP id s18mr2808075wmc.72.1571318958591; 
 Thu, 17 Oct 2019 06:29:18 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id n15sm2703392wrw.47.2019.10.17.06.29.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Oct 2019 06:29:18 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 8/8] hw/m68k/mcf5208.c: Switch to transaction-based ptimer API
Date: Thu, 17 Oct 2019 14:29:05 +0100
Message-Id: <20191017132905.5604-9-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191017132905.5604-1-peter.maydell@linaro.org>
References: <20191017132905.5604-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::344
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
Cc: Thomas Huth <huth@tuxfamily.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Michael Walle <michael@walle.cc>, Guan Xuetao <gxt@mprc.pku.edu.cn>,
 Magnus Damm <magnus.damm@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Switch the mcf5208 code away from bottom-half based ptimers to
the new transaction-based ptimer API.  This just requires adding
begin/commit calls around the various places that modify the ptimer
state, and using the new ptimer_init() function to create the timer.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/m68k/mcf5208.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/hw/m68k/mcf5208.c b/hw/m68k/mcf5208.c
index 34d34eba17c..158c5e4be75 100644
--- a/hw/m68k/mcf5208.c
+++ b/hw/m68k/mcf5208.c
@@ -9,7 +9,6 @@
 #include "qemu/osdep.h"
 #include "qemu/units.h"
 #include "qemu/error-report.h"
-#include "qemu/main-loop.h"
 #include "qapi/error.h"
 #include "qemu-common.h"
 #include "cpu.h"
@@ -79,6 +78,7 @@ static void m5208_timer_write(void *opaque, hwaddr offset,
             return;
         }
 
+        ptimer_transaction_begin(s->timer);
         if (s->pcsr & PCSR_EN)
             ptimer_stop(s->timer);
 
@@ -94,8 +94,10 @@ static void m5208_timer_write(void *opaque, hwaddr offset,
 
         if (s->pcsr & PCSR_EN)
             ptimer_run(s->timer, 0);
+        ptimer_transaction_commit(s->timer);
         break;
     case 2:
+        ptimer_transaction_begin(s->timer);
         s->pmr = value;
         s->pcsr &= ~PCSR_PIF;
         if ((s->pcsr & PCSR_RLD) == 0) {
@@ -104,6 +106,7 @@ static void m5208_timer_write(void *opaque, hwaddr offset,
         } else {
             ptimer_set_limit(s->timer, value, s->pcsr & PCSR_OVW);
         }
+        ptimer_transaction_commit(s->timer);
         break;
     case 4:
         break;
@@ -182,7 +185,6 @@ static void mcf5208_sys_init(MemoryRegion *address_space, qemu_irq *pic)
 {
     MemoryRegion *iomem = g_new(MemoryRegion, 1);
     m5208_timer_state *s;
-    QEMUBH *bh;
     int i;
 
     /* SDRAMC.  */
@@ -191,8 +193,7 @@ static void mcf5208_sys_init(MemoryRegion *address_space, qemu_irq *pic)
     /* Timers.  */
     for (i = 0; i < 2; i++) {
         s = g_new0(m5208_timer_state, 1);
-        bh = qemu_bh_new(m5208_timer_trigger, s);
-        s->timer = ptimer_init_with_bh(bh, PTIMER_POLICY_DEFAULT);
+        s->timer = ptimer_init(m5208_timer_trigger, s, PTIMER_POLICY_DEFAULT);
         memory_region_init_io(&s->iomem, NULL, &m5208_timer_ops, s,
                               "m5208-timer", 0x00004000);
         memory_region_add_subregion(address_space, 0xfc080000 + 0x4000 * i,
-- 
2.20.1



Return-Path: <SRS0=tSBD=YP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC557CA9EA0
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2019 13:39:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B5C082064B
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2019 13:39:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pU9FpmRx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B5C082064B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57500 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iMuNx-0003qj-DF
	for qemu-devel@archiver.kernel.org; Tue, 22 Oct 2019 09:39:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36652)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iMuGV-0002Lt-Kv
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 09:32:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iMuGU-0001DC-2Q
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 09:31:59 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:36452)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iMuGT-0001Cu-SV
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 09:31:58 -0400
Received: by mail-wm1-x341.google.com with SMTP id c22so7078221wmd.1
 for <qemu-devel@nongnu.org>; Tue, 22 Oct 2019 06:31:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=uDrLBjDpGth9A9xH8MMq1NWvBIh2l7Tya6vjM+QNwc0=;
 b=pU9FpmRxUxoFFgEwr4Xpg/xm+CvLjordbgobZjQa3w8ZZ1x0pxtjgzFz3jHdeOD1TF
 4zpJAhQVtcXNoYYVDeNVsF5L+jaLpHT3QvpvtKQlLmCAd1AhwGhKLIx96+cx6ta5kkHc
 md3ahfAGrvVV5ycfA9ZXC4/iP0wpj3yWxsGF/f1nvr/SSTB3MndSOUWksbPsAbnmI5wS
 SZse5P+CBD8ut5G4jBPfRnu6XwqkIUi1lDAx452KrLzdUz5n5VVmLh9wEOud9+qZxUaM
 1Kc5XdEWmzj4DbRtLySDFA3yzsCbQ8bk/4ZHcJdCBhPJgaotfAfRpjKJdnehpphpvaKS
 Gcjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=uDrLBjDpGth9A9xH8MMq1NWvBIh2l7Tya6vjM+QNwc0=;
 b=RZeH/B+W1H/ZCuvJAmvsEvX2u+4U2RMEqeij4hxg6R8Ld/pd1ezteQniqBI3EJQNFI
 P+chvHFhGvISyEYVuGBgF+0CiOcIvh8a+7ain0TcUN6MtGtpUUoSMspldiK8PHXNefOC
 le5+orUJsl9f/QCgquHAFINOTi2LVeognSatfMTHI83rrvDg3MC2Q5mhhsb8eCVK2Ngl
 fE+b01admt4Ofs82GfDOt7JEaancu93lBS7ASggDSJf3AWzEU3DuxwcKuhOtIae3OlvE
 +ZApZVcP4E9z8zcSgcXr7pBwK+kFL9FhUo/b9sMKQozKzlKweoy6Uae6oHhfBsuZVbx+
 ZXVQ==
X-Gm-Message-State: APjAAAUuPdhm7ITTc9KUPzoNZ0zKuDbVAp3HOx+Xs/BQAEjLIQs3EzT5
 /f5ZP1vd1g6mDHdCbS6TKX0Vy5YjCE0=
X-Google-Smtp-Source: APXvYqwI2MuyNn+8ONOXpoI8Eppq2M67TxSBWZQ+Bu4xUH8lAUA1w3akIWbJeueXpt6/NqiPLLrcyA==
X-Received: by 2002:a1c:c912:: with SMTP id f18mr3291383wmb.168.1571751115490; 
 Tue, 22 Oct 2019 06:31:55 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id r2sm20263856wma.1.2019.10.22.06.31.53
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Oct 2019 06:31:53 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 06/41] hw/timer/sh_timer: Switch to transaction-based ptimer API
Date: Tue, 22 Oct 2019 14:30:59 +0100
Message-Id: <20191022133134.14487-7-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191022133134.14487-1-peter.maydell@linaro.org>
References: <20191022133134.14487-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::341
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

Switch the sh_timer code away from bottom-half based ptimers to the
new transaction-based ptimer API.  This just requires adding
begin/commit calls around the various places that modify the ptimer
state, and using the new ptimer_init() function to create the timer.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-id: 20191017132905.5604-3-peter.maydell@linaro.org
---
 hw/timer/sh_timer.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/hw/timer/sh_timer.c b/hw/timer/sh_timer.c
index 48a81b4dc79..13c4051808f 100644
--- a/hw/timer/sh_timer.c
+++ b/hw/timer/sh_timer.c
@@ -13,7 +13,6 @@
 #include "hw/irq.h"
 #include "hw/sh4/sh.h"
 #include "qemu/timer.h"
-#include "qemu/main-loop.h"
 #include "hw/ptimer.h"
 
 //#define DEBUG_TIMER
@@ -91,13 +90,18 @@ static void sh_timer_write(void *opaque, hwaddr offset,
     switch (offset >> 2) {
     case OFFSET_TCOR:
         s->tcor = value;
+        ptimer_transaction_begin(s->timer);
         ptimer_set_limit(s->timer, s->tcor, 0);
+        ptimer_transaction_commit(s->timer);
         break;
     case OFFSET_TCNT:
         s->tcnt = value;
+        ptimer_transaction_begin(s->timer);
         ptimer_set_count(s->timer, s->tcnt);
+        ptimer_transaction_commit(s->timer);
         break;
     case OFFSET_TCR:
+        ptimer_transaction_begin(s->timer);
         if (s->enabled) {
             /* Pause the timer if it is running.  This may cause some
                inaccuracy dure to rounding, but avoids a whole lot of other
@@ -148,6 +152,7 @@ static void sh_timer_write(void *opaque, hwaddr offset,
             /* Restart the timer if still enabled.  */
             ptimer_run(s->timer, 0);
         }
+        ptimer_transaction_commit(s->timer);
         break;
     case OFFSET_TCPR:
         if (s->feat & TIMER_FEAT_CAPT) {
@@ -168,12 +173,14 @@ static void sh_timer_start_stop(void *opaque, int enable)
     printf("sh_timer_start_stop %d (%d)\n", enable, s->enabled);
 #endif
 
+    ptimer_transaction_begin(s->timer);
     if (s->enabled && !enable) {
         ptimer_stop(s->timer);
     }
     if (!s->enabled && enable) {
         ptimer_run(s->timer, 0);
     }
+    ptimer_transaction_commit(s->timer);
     s->enabled = !!enable;
 
 #ifdef DEBUG_TIMER
@@ -191,7 +198,6 @@ static void sh_timer_tick(void *opaque)
 static void *sh_timer_init(uint32_t freq, int feat, qemu_irq irq)
 {
     sh_timer_state *s;
-    QEMUBH *bh;
 
     s = (sh_timer_state *)g_malloc0(sizeof(sh_timer_state));
     s->freq = freq;
@@ -203,8 +209,7 @@ static void *sh_timer_init(uint32_t freq, int feat, qemu_irq irq)
     s->enabled = 0;
     s->irq = irq;
 
-    bh = qemu_bh_new(sh_timer_tick, s);
-    s->timer = ptimer_init_with_bh(bh, PTIMER_POLICY_DEFAULT);
+    s->timer = ptimer_init(sh_timer_tick, s, PTIMER_POLICY_DEFAULT);
 
     sh_timer_write(s, OFFSET_TCOR >> 2, s->tcor);
     sh_timer_write(s, OFFSET_TCNT >> 2, s->tcnt);
-- 
2.20.1



Return-Path: <SRS0=Jnn8=YR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66AF5CA9EAF
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 17:11:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2BDCD20650
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 17:11:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bh0tUVgC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2BDCD20650
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48374 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNgdW-0001e8-SZ
	for qemu-devel@archiver.kernel.org; Thu, 24 Oct 2019 13:10:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58150)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iNfy7-0007zY-Q0
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 12:28:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iNfy6-0000xp-He
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 12:28:11 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:44573)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iNfy6-0000xQ-BM
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 12:28:10 -0400
Received: by mail-wr1-x442.google.com with SMTP id z11so3425828wro.11
 for <qemu-devel@nongnu.org>; Thu, 24 Oct 2019 09:28:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=8gomn01XLvBOBw7vPQuO9R/LxnmjSiX180WMSIb6GFs=;
 b=bh0tUVgC/1ZbJ36SIsl+8vE6Dh0rK+GQ7ttrbMOIz7zDP5jvg4yq9wto8Bi/0N+fNb
 RbZCRzahCVbNs6fCGqXsaL33FyS80pIzSg1ugDWhRHk7wzGhOiplVgm8JZo3hPaOqPT3
 5AlB/ZD9zHH3f78/jdzVGTexLwjICSXqNVpBNCRdTJRGp2kK3GWCKNLXKINzjd/5uF+i
 3Puh6JkPji3sSli1UsgUjPK8cbkW8f77K96uOSkaCEKdjoyf9ZLD4qHPsxJiIHcZzeZ5
 BtlXraBReXp+3V+uJ7ne9+8WYUqtxse2JsrsTfL0wfKpFY8KQttxDu+YmNaACBJXkwmE
 zvQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=8gomn01XLvBOBw7vPQuO9R/LxnmjSiX180WMSIb6GFs=;
 b=UbI0eIbwFZKsRIZgbXLU1whf7wPZT5b4wCmOaxKUE/sIh/qLUe0FJhXWpikZTCMWd/
 4DciBq873y8i6m+zJSRR+ihZ0hGYgdoI6I9QUkYKIwN5ARZrYZsy9tDq1dGLVmnqskDC
 fS/+8vF2CgicO00k6mlcTSLis5sNu3SpKqhPuqL9uIdiHm+PduXDb5bLX1GMpl0vJY0X
 sJd9u5KMzxPfXwfSlyijyM225d7uqcrnBUDNl6RhvuPPPxlTN7MvjLECH83W7eRstS0n
 THZpMOML6W+alKJEagA0d7qbAcvVOFWI/N9zHgmJy8ZEmC7Sy49kNLyGDwjfjiyLG5D3
 SiKw==
X-Gm-Message-State: APjAAAWIh1XJO4gtrZ+qKVk5QCPVM4cPpwz/kZVxZyIRT4v+XJdy5NAo
 JbNUOPb2GZWu1q4I9YFtfz3J6RFMW3M=
X-Google-Smtp-Source: APXvYqzkM5AqjDl5AK8uaa7Y8UMD0pA7fmI+yofFFxSDNM+FnQ4rnqqTOhBh+07y3ZS2V+HnYy62pw==
X-Received: by 2002:a05:6000:4f:: with SMTP id
 k15mr4416110wrx.137.1571934489134; 
 Thu, 24 Oct 2019 09:28:09 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id r27sm42606124wrc.55.2019.10.24.09.28.08
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Oct 2019 09:28:08 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 34/51] hw/watchdog/milkymist-sysctl.c: Switch to
 transaction-based ptimer API
Date: Thu, 24 Oct 2019 17:27:07 +0100
Message-Id: <20191024162724.31675-35-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191024162724.31675-1-peter.maydell@linaro.org>
References: <20191024162724.31675-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Switch the milkymist-sysctl code away from bottom-half based
ptimers to the new transaction-based ptimer API.  This just requires
adding begin/commit calls around the various places that modify the
ptimer state, and using the new ptimer_init() function to create the
timer.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-id: 20191021141040.11007-1-peter.maydell@linaro.org
---
 hw/timer/milkymist-sysctl.c | 25 ++++++++++++++++++-------
 1 file changed, 18 insertions(+), 7 deletions(-)

diff --git a/hw/timer/milkymist-sysctl.c b/hw/timer/milkymist-sysctl.c
index 5193c038501..7a62e212c35 100644
--- a/hw/timer/milkymist-sysctl.c
+++ b/hw/timer/milkymist-sysctl.c
@@ -31,7 +31,6 @@
 #include "hw/ptimer.h"
 #include "hw/qdev-properties.h"
 #include "qemu/error-report.h"
-#include "qemu/main-loop.h"
 #include "qemu/module.h"
 
 enum {
@@ -71,8 +70,6 @@ struct MilkymistSysctlState {
 
     MemoryRegion regs_region;
 
-    QEMUBH *bh0;
-    QEMUBH *bh1;
     ptimer_state *ptimer0;
     ptimer_state *ptimer1;
 
@@ -161,14 +158,19 @@ static void sysctl_write(void *opaque, hwaddr addr, uint64_t value,
         s->regs[addr] = value;
         break;
     case R_TIMER0_COMPARE:
+        ptimer_transaction_begin(s->ptimer0);
         ptimer_set_limit(s->ptimer0, value, 0);
         s->regs[addr] = value;
+        ptimer_transaction_commit(s->ptimer0);
         break;
     case R_TIMER1_COMPARE:
+        ptimer_transaction_begin(s->ptimer1);
         ptimer_set_limit(s->ptimer1, value, 0);
         s->regs[addr] = value;
+        ptimer_transaction_commit(s->ptimer1);
         break;
     case R_TIMER0_CONTROL:
+        ptimer_transaction_begin(s->ptimer0);
         s->regs[addr] = value;
         if (s->regs[R_TIMER0_CONTROL] & CTRL_ENABLE) {
             trace_milkymist_sysctl_start_timer0();
@@ -179,8 +181,10 @@ static void sysctl_write(void *opaque, hwaddr addr, uint64_t value,
             trace_milkymist_sysctl_stop_timer0();
             ptimer_stop(s->ptimer0);
         }
+        ptimer_transaction_commit(s->ptimer0);
         break;
     case R_TIMER1_CONTROL:
+        ptimer_transaction_begin(s->ptimer1);
         s->regs[addr] = value;
         if (s->regs[R_TIMER1_CONTROL] & CTRL_ENABLE) {
             trace_milkymist_sysctl_start_timer1();
@@ -191,6 +195,7 @@ static void sysctl_write(void *opaque, hwaddr addr, uint64_t value,
             trace_milkymist_sysctl_stop_timer1();
             ptimer_stop(s->ptimer1);
         }
+        ptimer_transaction_commit(s->ptimer1);
         break;
     case R_ICAP:
         sysctl_icap_write(s, value);
@@ -263,8 +268,12 @@ static void milkymist_sysctl_reset(DeviceState *d)
         s->regs[i] = 0;
     }
 
+    ptimer_transaction_begin(s->ptimer0);
     ptimer_stop(s->ptimer0);
+    ptimer_transaction_commit(s->ptimer0);
+    ptimer_transaction_begin(s->ptimer1);
     ptimer_stop(s->ptimer1);
+    ptimer_transaction_commit(s->ptimer1);
 
     /* defaults */
     s->regs[R_ICAP] = ICAP_READY;
@@ -292,13 +301,15 @@ static void milkymist_sysctl_realize(DeviceState *dev, Error **errp)
 {
     MilkymistSysctlState *s = MILKYMIST_SYSCTL(dev);
 
-    s->bh0 = qemu_bh_new(timer0_hit, s);
-    s->bh1 = qemu_bh_new(timer1_hit, s);
-    s->ptimer0 = ptimer_init_with_bh(s->bh0, PTIMER_POLICY_DEFAULT);
-    s->ptimer1 = ptimer_init_with_bh(s->bh1, PTIMER_POLICY_DEFAULT);
+    s->ptimer0 = ptimer_init(timer0_hit, s, PTIMER_POLICY_DEFAULT);
+    s->ptimer1 = ptimer_init(timer1_hit, s, PTIMER_POLICY_DEFAULT);
 
+    ptimer_transaction_begin(s->ptimer0);
     ptimer_set_freq(s->ptimer0, s->freq_hz);
+    ptimer_transaction_commit(s->ptimer0);
+    ptimer_transaction_begin(s->ptimer1);
     ptimer_set_freq(s->ptimer1, s->freq_hz);
+    ptimer_transaction_commit(s->ptimer1);
 }
 
 static const VMStateDescription vmstate_milkymist_sysctl = {
-- 
2.20.1



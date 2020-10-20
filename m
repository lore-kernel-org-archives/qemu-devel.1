Return-Path: <SRS0=1sPN=D3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30282C4363A
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 18:22:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 56E1E2098B
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 18:22:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RhJLTZej"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 56E1E2098B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58204 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUwH5-0002xr-9D
	for qemu-devel@archiver.kernel.org; Tue, 20 Oct 2020 14:22:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49962)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kUwFH-0001FM-S5
 for qemu-devel@nongnu.org; Tue, 20 Oct 2020 14:20:30 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:55767)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kUwFC-00070a-17
 for qemu-devel@nongnu.org; Tue, 20 Oct 2020 14:20:24 -0400
Received: by mail-wm1-x342.google.com with SMTP id a72so2824123wme.5
 for <qemu-devel@nongnu.org>; Tue, 20 Oct 2020 11:20:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=BzyypNaASWej9ZmqdqMi6vPl5wcM+vKdt8ggZ4Ao8SM=;
 b=RhJLTZejm2gWA9eGOUcqIM2r/w8aepvah0h9G0w3fJNQYUvFupuSiHZJ4tu8sByrGI
 CqegSXD5jZ3tjSzXLRnIuc+rIKpldSw1FhweAWbVggoYaUmWpJeSFhEjRfgrBqquZozI
 Ev1QQe5awJJTEkWIZ3GV0jksGmolBwJnZul17cownl+HDM+K0hKTxWCbdzYwqPnn3d4a
 7t5oZeRQwEoOLyyVnGUbH7H9KWzKLeF9cKzSbdAPzhLewYSRuybsSnKOfcIv6P8xCYcC
 rYta/IvP/nIs+9OB5iBPtmFCUd7dJ5j+mf7JhhO9unvVc3pGDDcNKY+aw4Z5qNAFTgk9
 8tmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=BzyypNaASWej9ZmqdqMi6vPl5wcM+vKdt8ggZ4Ao8SM=;
 b=NFt9QAcJj2ubw3Wodykqq75Q/GFL4WKiWlGdyc5QzXxzTF23rToGRkKJtew+qZye4N
 J+S5JYoLB7qOpaQDC3UNupJrY6eEzGgqBkgg86qlfSSnHMVe1L5CqEFLzz++BK6mt4d8
 +eIQxryLfhMdeet4Aqr7qrp7sdcwczanpSjwvWI0HpircmDQL54+jYkwq9BALAgsqc21
 WtwRQg7XF1DVU7Dbqi5FeX3DbPDAEPVy+q/Dgf1frf721xIL/jrBdGrQK3GtpBGqAuGF
 J+aplA0LksjQ80vQikTI7NVwyp5W9EW1WYLSK+FViy5K8hPptBa/0BZdimSFW3tX/k4T
 qBiQ==
X-Gm-Message-State: AOAM532zJmJNAVE6xLjLVlmdd6vHCIV8UuN2i/W+01GzSD/HMdFt6qPN
 2be6JpTe1ZA/gZxVXuTCGDcDp/SapVo=
X-Google-Smtp-Source: ABdhPJyXxKnhC3yc7AHjoNry4FEVDcg/tefmGklGRGk32fXmUDSPwAGNKv4APV2vDLL6mfUaQ4GhmA==
X-Received: by 2002:a7b:c350:: with SMTP id l16mr4392111wmj.135.1603218020008; 
 Tue, 20 Oct 2020 11:20:20 -0700 (PDT)
Received: from x1w.redhat.com (237.red-88-18-140.staticip.rima-tde.net.
 [88.18.140.237])
 by smtp.gmail.com with ESMTPSA id r1sm4334870wro.18.2020.10.20.11.20.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Oct 2020 11:20:19 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 2/4] hw/core/clock: trace clock values in Hz instead of ns
Date: Tue, 20 Oct 2020 20:20:06 +0200
Message-Id: <20201020182008.2240590-3-f4bug@amsat.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201020182008.2240590-1-f4bug@amsat.org>
References: <20201020182008.2240590-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::342;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x342.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.249,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: Damien Hedde <damien.hedde@greensocs.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Luc Michel <luc@lmichel.fr>, Paolo Bonzini <pbonzini@redhat.com>,
 Luc Michel <luc.michel@greensocs.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Luc Michel <luc@lmichel.fr>

The nanosecond unit greatly limits the dynamic range we can display in
clock value traces, for values in the order of 1GHz and more. The
internal representation can go way beyond this value and it is quite
common for today's clocks to be within those ranges.

For example, a frequency between 500MHz+ and 1GHz will be displayed as
1ns. Beyond 1GHz, it will show up as 0ns.

Replace nanosecond periods traces with frequencies in the Hz unit
to have more dynamic range in the trace output.

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Damien Hedde <damien.hedde@greensocs.com>
Signed-off-by: Luc Michel <luc@lmichel.fr>
Tested-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Message-Id: <20201010135759.437903-3-luc@lmichel.fr>
[PMD: Replace CLOCK_PERIOD_TO_HZ() by clock_get_hz()]
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/core/clock.c      | 8 +++++---
 hw/core/trace-events | 4 ++--
 2 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/hw/core/clock.c b/hw/core/clock.c
index f866717a835..5cc9599ba3a 100644
--- a/hw/core/clock.c
+++ b/hw/core/clock.c
@@ -51,12 +51,14 @@ void clock_clear_callback(Clock *clk)
 
 bool clock_set(Clock *clk, uint64_t period)
 {
+    uint64_t old_hz;
+
     if (clk->period == period) {
         return false;
     }
-    trace_clock_set(CLOCK_PATH(clk), CLOCK_PERIOD_TO_NS(clk->period),
-                    CLOCK_PERIOD_TO_NS(period));
+    old_hz = clock_get_hz(clk);
     clk->period = period;
+    trace_clock_set(CLOCK_PATH(clk), old_hz, clock_get_hz(clk));
 
     return true;
 }
@@ -69,7 +71,7 @@ static void clock_propagate_period(Clock *clk, bool call_callbacks)
         if (child->period != clk->period) {
             child->period = clk->period;
             trace_clock_update(CLOCK_PATH(child), CLOCK_PATH(clk),
-                               CLOCK_PERIOD_TO_NS(clk->period),
+                               clock_get_hz(clk),
                                call_callbacks);
             if (call_callbacks && child->callback) {
                 child->callback(child->callback_opaque);
diff --git a/hw/core/trace-events b/hw/core/trace-events
index 1ac60ede6b7..7b2869cbaab 100644
--- a/hw/core/trace-events
+++ b/hw/core/trace-events
@@ -31,6 +31,6 @@ resettable_transitional_function(void *obj, const char *objtype) "obj=%p(%s)"
 # clock.c
 clock_set_source(const char *clk, const char *src) "'%s', src='%s'"
 clock_disconnect(const char *clk) "'%s'"
-clock_set(const char *clk, uint64_t old, uint64_t new) "'%s', ns=%"PRIu64"->%"PRIu64
+clock_set(const char *clk, uint64_t old, uint64_t new) "'%s', %"PRIu64" Hz-> %"PRIu64" Hz"
 clock_propagate(const char *clk) "'%s'"
-clock_update(const char *clk, const char *src, uint64_t val, int cb) "'%s', src='%s', ns=%"PRIu64", cb=%d"
+clock_update(const char *clk, const char *src, uint64_t hz, int cb) "'%s', src='%s', val=%"PRIu64" Hz cb=%d"
-- 
2.26.2



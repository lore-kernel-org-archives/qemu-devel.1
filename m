Return-Path: <SRS0=gwGE=EC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DE52C388F9
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 13:05:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 85ED520780
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 13:05:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="O5qZs9Jo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 85ED520780
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57196 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXOer-0004i4-Fn
	for qemu-devel@archiver.kernel.org; Tue, 27 Oct 2020 09:05:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52308)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kXNPs-0001pm-Fj
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 07:45:28 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b]:44420)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kXNPp-0004gY-AX
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 07:45:27 -0400
Received: by mail-wr1-x42b.google.com with SMTP id t9so1499825wrq.11
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2020 04:45:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=31oB8adlz3FHMBAML1Jxi6tZhh8Z+m5TwWywAmM/pII=;
 b=O5qZs9Jon0x+5AL/5i2pTHgEiaQdyjo4cO2m/S5AzL3bMFR3wlxr4/62bDj1UgK1g8
 NJNA0zweuazvEVucJxrFLm8nuo2+3y2IPb9pA+z0pfRSlH57McyPx5/RvYOOvYLqaHbF
 j1Tz+d5CNYx96eah8RtuSK7sT2sGWlKtyT6tI7G246LhbvtVktKV9+0rV0UUl9MlZoei
 +niuoem4LtPMC7z9gntuvOD3oLL4pqq+U5wYzaOmEOJgyoYxbpJQrwiismMRNyS4BK3v
 C6uOO1Glbz1hjGmk4/+PTl91axveFYlsoz5d0duy4+Brcx891OqaTXjMOeEUj2NucGEO
 KEFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=31oB8adlz3FHMBAML1Jxi6tZhh8Z+m5TwWywAmM/pII=;
 b=teCg8dMdAUEhHTXQzKf/r0Wune1m8xJgre+hSt9pSwzyjGgCHKdfq7DqpmQ0q3djZJ
 JQ58G2KXTxIqNwyscd8WPq6Y5FfW367EbuoKBHi3b0VUoh8vVxd9QHrnjET/QmCxPGK5
 Nc/m+zVTWItYyEhJ3+U5DO1LumiMzfNOjUo3/X7Kd0CPVY5EkjeL5jfal3QZEFEKDhBL
 oeSj/tQtkNfqXapVxEBOmjHbmwH+2ZZd3KQMJ/54S6+2I9pFEu0qtNs6BcdOgd0Ldkmm
 8hLkbqh9cQd5Ccjrwr1PmKr51Dq3x4o107+ZtCV2Wv8who8aN41+et877BR89L6CxIUP
 hNUQ==
X-Gm-Message-State: AOAM530TJIepYDFPpPEkGGjUnGDs6hHqwIeaIguJgrlC1NEEtVyerrCJ
 uP1fHGNN4lV4Ls4j/h50MnFmU4+5whO+eg==
X-Google-Smtp-Source: ABdhPJwM8O3i6VDD+69crFqAziMFR++dwgevBZgvQqD0hjNtU6wv/918KT0QL03Rxd4o6p+gnKFdEw==
X-Received: by 2002:a05:6000:1051:: with SMTP id
 c17mr2278494wrx.290.1603799120368; 
 Tue, 27 Oct 2020 04:45:20 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id 32sm1712203wro.31.2020.10.27.04.45.19
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Oct 2020 04:45:19 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 32/48] hw/core/clock: trace clock values in Hz instead of ns
Date: Tue, 27 Oct 2020 11:44:22 +0000
Message-Id: <20201027114438.17662-33-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201027114438.17662-1-peter.maydell@linaro.org>
References: <20201027114438.17662-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42b.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Tested-by: Guenter Roeck <linux@roeck-us.net>
Tested-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/core/clock.c      | 6 +++---
 hw/core/trace-events | 4 ++--
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/hw/core/clock.c b/hw/core/clock.c
index f866717a835..8c6af223e7c 100644
--- a/hw/core/clock.c
+++ b/hw/core/clock.c
@@ -54,8 +54,8 @@ bool clock_set(Clock *clk, uint64_t period)
     if (clk->period == period) {
         return false;
     }
-    trace_clock_set(CLOCK_PATH(clk), CLOCK_PERIOD_TO_NS(clk->period),
-                    CLOCK_PERIOD_TO_NS(period));
+    trace_clock_set(CLOCK_PATH(clk), CLOCK_PERIOD_TO_HZ(clk->period),
+                    CLOCK_PERIOD_TO_HZ(period));
     clk->period = period;
 
     return true;
@@ -69,7 +69,7 @@ static void clock_propagate_period(Clock *clk, bool call_callbacks)
         if (child->period != clk->period) {
             child->period = clk->period;
             trace_clock_update(CLOCK_PATH(child), CLOCK_PATH(clk),
-                               CLOCK_PERIOD_TO_NS(clk->period),
+                               CLOCK_PERIOD_TO_HZ(clk->period),
                                call_callbacks);
             if (call_callbacks && child->callback) {
                 child->callback(child->callback_opaque);
diff --git a/hw/core/trace-events b/hw/core/trace-events
index 1ac60ede6b7..360ddeb2c87 100644
--- a/hw/core/trace-events
+++ b/hw/core/trace-events
@@ -31,6 +31,6 @@ resettable_transitional_function(void *obj, const char *objtype) "obj=%p(%s)"
 # clock.c
 clock_set_source(const char *clk, const char *src) "'%s', src='%s'"
 clock_disconnect(const char *clk) "'%s'"
-clock_set(const char *clk, uint64_t old, uint64_t new) "'%s', ns=%"PRIu64"->%"PRIu64
+clock_set(const char *clk, uint64_t old, uint64_t new) "'%s', %"PRIu64"Hz->%"PRIu64"Hz"
 clock_propagate(const char *clk) "'%s'"
-clock_update(const char *clk, const char *src, uint64_t val, int cb) "'%s', src='%s', ns=%"PRIu64", cb=%d"
+clock_update(const char *clk, const char *src, uint64_t hz, int cb) "'%s', src='%s', val=%"PRIu64"Hz cb=%d"
-- 
2.20.1



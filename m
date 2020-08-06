Return-Path: <SRS0=Z/nf=BQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E37CC433DF
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 12:40:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 185CE23103
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 12:40:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="t4dT7HUL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 185CE23103
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47078 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k3fBu-0000N3-6x
	for qemu-devel@archiver.kernel.org; Thu, 06 Aug 2020 08:40:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38600)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1k3fAo-0007Vm-O0
 for qemu-devel@nongnu.org; Thu, 06 Aug 2020 08:39:06 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:44830)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1k3fAn-0004Jk-2S
 for qemu-devel@nongnu.org; Thu, 06 Aug 2020 08:39:06 -0400
Received: by mail-wr1-x443.google.com with SMTP id c15so7627991wrs.11
 for <qemu-devel@nongnu.org>; Thu, 06 Aug 2020 05:39:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=rRIMjMRCJ85r9XPfKeWQ6ALRZZNTPRI0iIj98UEuY4s=;
 b=t4dT7HUL6NlYdA9cKe1oGPxMwV9QWExBsG4QF8WgOiC7Nc7JiIuV8unCsqsCTQ/uyq
 J/arIQLfCUV4NQI88svCopGqM/uq92pYYW0D7vx1ekovZ7Q9mCXgB90sd2+FSL6SgpCG
 +wzc4SLrEc1hZa6ETmv2IC4gfBTZhdz+Ta1yaIgFwmF51r6NJtS2UpdU0VjhkS7IkOXR
 MgHiG+cvOuLbQz9WDBrW5esHh/Y1vj3P/D8wXKTU2W7/3liry+eH//yMGOHAtVUkUgUY
 akw1ACSDeedNOQBPgUnQ3ZFKIMjtWur3/KSP5C00kDjGYMLn651pdgaVKt7XBPzBfgIv
 kvXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=rRIMjMRCJ85r9XPfKeWQ6ALRZZNTPRI0iIj98UEuY4s=;
 b=B3FV/sLop80Pp3nGjh7E6CLZq5T8txjpnaCnTNlKlGKS4eH+hYpRehIPzSjcoyFefy
 H5Js0gzjPQ8UTisRAWBKaph/S2g9WJUu38WTrf+hZzXlcnRPA9QjzkbOWGgGzlZnpf6L
 TPoTDW0jPI6OWKwG8gkZ+N9YJXzTa1timf+N7NpOBRZnammvmfoVwN5NBTsRM0Njray+
 7yEMkHpDLbHwNwkW6CPBqORP+VNfZDxHieVpH9SrqZi1nBcjQpdVDTSSgP+h1e1gPu+F
 hq4LnWKunHRPRrXeFMPOZl/DsJzKXoqb64e8TpB+SVa1jPbr/7UzfstFp+N+3qpCqP3U
 K4vA==
X-Gm-Message-State: AOAM531heAf1Hb40tnqwTRhmdN/rUZqYAvrSnwqvQoDeOFenuDrkll3I
 gZTuJCxafIDPmmEcN1F1b5GOubMt
X-Google-Smtp-Source: ABdhPJzKxiK1QNwsxDLfMB9vgEWq/TqwmqaTdpY+sXQKECIEIZvKXSDjEuQsG4hFalGi6mVFx9p7IA==
X-Received: by 2002:adf:b602:: with SMTP id f2mr6942460wre.186.1596717543131; 
 Thu, 06 Aug 2020 05:39:03 -0700 (PDT)
Received: from localhost.localdomain (121.red-81-40-121.staticip.rima-tde.net.
 [81.40.121.121])
 by smtp.gmail.com with ESMTPSA id j5sm6615395wmb.15.2020.08.06.05.39.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Aug 2020 05:39:02 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH-for-5.2 2/3] hw/clock: Let clock_set() return boolean value
Date: Thu,  6 Aug 2020 14:38:57 +0200
Message-Id: <20200806123858.30058-3-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200806123858.30058-1-f4bug@amsat.org>
References: <20200806123858.30058-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::443;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x443.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Let clock_set() return a boolean value whether the clock
has been updated or not.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 include/hw/clock.h | 12 +++++++-----
 hw/core/clock.c    |  7 ++++++-
 2 files changed, 13 insertions(+), 6 deletions(-)

diff --git a/include/hw/clock.h b/include/hw/clock.h
index 468fed0996..d85af45c96 100644
--- a/include/hw/clock.h
+++ b/include/hw/clock.h
@@ -127,17 +127,19 @@ void clock_set_source(Clock *clk, Clock *src);
  * @value: the clock's value, 0 means unclocked
  *
  * Set the local cached period value of @clk to @value.
+ *
+ * @return: true if the clock is changed.
  */
-void clock_set(Clock *clk, uint64_t value);
+bool clock_set(Clock *clk, uint64_t value);
 
-static inline void clock_set_hz(Clock *clk, unsigned hz)
+static inline bool clock_set_hz(Clock *clk, unsigned hz)
 {
-    clock_set(clk, CLOCK_PERIOD_FROM_HZ(hz));
+    return clock_set(clk, CLOCK_PERIOD_FROM_HZ(hz));
 }
 
-static inline void clock_set_ns(Clock *clk, unsigned ns)
+static inline bool clock_set_ns(Clock *clk, unsigned ns)
 {
-    clock_set(clk, CLOCK_PERIOD_FROM_NS(ns));
+    return clock_set(clk, CLOCK_PERIOD_FROM_NS(ns));
 }
 
 /**
diff --git a/hw/core/clock.c b/hw/core/clock.c
index 3c0daf7d4c..7066282f7b 100644
--- a/hw/core/clock.c
+++ b/hw/core/clock.c
@@ -34,11 +34,16 @@ void clock_clear_callback(Clock *clk)
     clock_set_callback(clk, NULL, NULL);
 }
 
-void clock_set(Clock *clk, uint64_t period)
+bool clock_set(Clock *clk, uint64_t period)
 {
+    if (clk->period == period) {
+        return false;
+    }
     trace_clock_set(CLOCK_PATH(clk), CLOCK_PERIOD_TO_NS(clk->period),
                     CLOCK_PERIOD_TO_NS(period));
     clk->period = period;
+
+    return true;
 }
 
 static void clock_propagate_period(Clock *clk, bool call_callbacks)
-- 
2.21.3



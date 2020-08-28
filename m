Return-Path: <SRS0=7Ydp=CG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1FB4C433E6
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 09:25:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9073E208CA
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 09:25:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gF/768no"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9073E208CA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55070 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBadD-0005YY-S8
	for qemu-devel@archiver.kernel.org; Fri, 28 Aug 2020 05:25:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45736)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kBacP-0003l0-QE
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 05:24:21 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e]:52469)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kBacN-0004Cr-Oe
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 05:24:21 -0400
Received: by mail-wm1-x32e.google.com with SMTP id q9so297347wmj.2
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2020 02:24:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=R2PEPuAs2ra4FxxOtbGD90viaMawv8eHlaEZXjv1afk=;
 b=gF/768nos8WdFKSSydXB1ZVVskVzQcZfHIXtuKn0LsNH1ri4TsKPPsEOZxaY4ObAJi
 rZk2t7C/RrjoCl5INWcT8dfFYGtw9+AfrMFcRKk7x2yMHJP6ANLZ8DhzTHQaZ9IOO8IU
 dxIHegUZpoUFoNbFqTmjOs0C5iDThMyBZgy/xuBlJiXgPkhRjGxvC36dldheeABOuINs
 T08E2BrkBqr+plMT3v5pMMt9QhsPe4SXK2LgdNEQqsfKLXeqFNA9yT3U+xyuvSg6Gpaq
 QOJYbbUrILSl3VCCtA3D79NH8IJQfOPCj5Lv4HsQW9NVPCKmCxG8S2VxhrInDg+fKe/v
 cztg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=R2PEPuAs2ra4FxxOtbGD90viaMawv8eHlaEZXjv1afk=;
 b=fnfvcE5mrSi3Yzf5YrRdBJxevQyBUl9PAueIzx4Qk5itH87kclensRSTSfMxM/I1XK
 XxLZA2PyABGdy705MoTkfbAIHZQ1iLUO2+oMCxjdn/eIne+MN0I5eV8Bk7DYK1DKKy5Y
 AUM1eGbv1dI29YkTiPqXzB388Ydttg60RVI3vQXsSUFMNBt2fIcXrZCj85fnogDjxpas
 asuLaRQMoPRK1jgd9g+EzCcX97AJkBhoSrw6963EIK4E7HVMfL/rllpWcRva9lsn4z0F
 IFf1o6SJ4vHx+iVoErQ+9qddN1Z/lNXT7p1CtvhXWFrryzUZwCMdDpvybGz0QH/nQdDf
 ePfA==
X-Gm-Message-State: AOAM532muer3eFJ9vg3yERO8Jnr/W3XdJ0T22FrZ6K8/8fp5RUguhNhE
 zCHspqS+9He23bXww3yuJ5W7aZBXB6bLdJgi
X-Google-Smtp-Source: ABdhPJwm26m5RKgW3FpazTz3ljhnXWqs+I4Vh5FYqa2+wwRlc4l/vAVCXZAduiQJqYI6vv+Tk8hLgA==
X-Received: by 2002:a05:600c:214e:: with SMTP id
 v14mr758775wml.118.1598606658132; 
 Fri, 28 Aug 2020 02:24:18 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id t13sm912304wru.65.2020.08.28.02.24.17
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Aug 2020 02:24:17 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 03/35] hw/clock: Let clock_set() return boolean value
Date: Fri, 28 Aug 2020 10:23:41 +0100
Message-Id: <20200828092413.22206-4-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200828092413.22206-1-peter.maydell@linaro.org>
References: <20200828092413.22206-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32e.google.com
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

From: Philippe Mathieu-Daudé <f4bug@amsat.org>

Let clock_set() return a boolean value whether the clock
has been updated or not.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20200806123858.30058-3-f4bug@amsat.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/clock.h | 12 +++++++-----
 hw/core/clock.c    |  7 ++++++-
 2 files changed, 13 insertions(+), 6 deletions(-)

diff --git a/include/hw/clock.h b/include/hw/clock.h
index 468fed0996d..d85af45c967 100644
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
index 3c0daf7d4cf..7066282f7b9 100644
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
2.20.1



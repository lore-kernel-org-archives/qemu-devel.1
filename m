Return-Path: <SRS0=1sPN=D3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9754FC4363A
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 18:25:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E667A20BED
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 18:25:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VY2LTrHR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E667A20BED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35728 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUwKM-0005Oe-1S
	for qemu-devel@archiver.kernel.org; Tue, 20 Oct 2020 14:25:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50044)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kUwFZ-0001LS-I5
 for qemu-devel@nongnu.org; Tue, 20 Oct 2020 14:20:47 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:35296)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kUwFU-00071D-83
 for qemu-devel@nongnu.org; Tue, 20 Oct 2020 14:20:43 -0400
Received: by mail-wm1-x344.google.com with SMTP id q5so3062698wmq.0
 for <qemu-devel@nongnu.org>; Tue, 20 Oct 2020 11:20:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=LlhPHIkLgnc2X3iIuYASqYyROrzSjxY4qWSO0bD5GDk=;
 b=VY2LTrHRsp+FHTTI6eNiyB9FbHAEvWmbwiG0O+xcNTVL/tK1Xm0925ondCwNBYhKAF
 0BBgnnObtpyRicB4W+fRAF7K+GPsN6DEKzatL88y5AYR91Aveacl09lHvuLpmigXd0Lk
 mMfKBWC+kPa+GZ+rNObWO8jaoI0rGyXNbzvLQyVDs24cNGnXZsS+Fb65MLxykXWwFAvh
 2ZAXuAN282Qmi5FVmODzTooqXCVqeDG21gsT1oVa+foMFKseJNzrqFeIZAoM+IyMI8CD
 asGjNVUpTy91C8R2SG3JQSgpD5mUZqBE6l8OK5LaiHEWlyUzkwNHKwsf+aPbdFXN1R97
 5kPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=LlhPHIkLgnc2X3iIuYASqYyROrzSjxY4qWSO0bD5GDk=;
 b=URzgu0ckMVvbNC+YSS4T+EhIjrKeh5UQfn+HXd6/k3EZezjqCQ1Lz2/S+KIkzvB1uH
 9l4JFo0HMB8P3n8pQM8m0zYsyZ8aZ/66B5BfazDoqnKTC8Kly6KVZgpkeo9FVPd80/z0
 nrsQBNDh1gP9cnzhrqXD3Nh7d8Zb+YYsf+OfgGyoMlaa+fAtKq2x7hvJQhryL4w72f2Z
 x7PznsTjaif8bVPkMWyw2uKB56UokaLCHw1R/x5imNIIvq6/d9bYlWDY9jyzLG2LGSXP
 3LViQOunGby9MCjU9DOm6JE913DLdXAX36qKFGddhGizfpIUysRoRuOC8LfRZFQCgsWk
 W/9w==
X-Gm-Message-State: AOAM5326evh7At1CMAOt5Cdh9SOb/mCHdXjlb61/zEk+/ycC/rhEy//F
 yqfjRKJe6U6r8lx6zSa+vbTSs1fEmMk=
X-Google-Smtp-Source: ABdhPJxHR+y9WC8u/4TV6Y+y9C6UNcW/vUdA1yMPG6t/VvJZD3YCFgIyrp7ylTJz5cpFUcuXMDjJpw==
X-Received: by 2002:a1c:f414:: with SMTP id z20mr4272674wma.110.1603218024717; 
 Tue, 20 Oct 2020 11:20:24 -0700 (PDT)
Received: from x1w.redhat.com (237.red-88-18-140.staticip.rima-tde.net.
 [88.18.140.237])
 by smtp.gmail.com with ESMTPSA id n83sm2998389wma.39.2020.10.20.11.20.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Oct 2020 11:20:24 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 3/4] hw/clock: Inline and remove CLOCK_PERIOD_TO_HZ()
Date: Tue, 20 Oct 2020 20:20:07 +0200
Message-Id: <20201020182008.2240590-4-f4bug@amsat.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201020182008.2240590-1-f4bug@amsat.org>
References: <20201020182008.2240590-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::344;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x344.google.com
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
 Paolo Bonzini <pbonzini@redhat.com>, Luc Michel <luc.michel@greensocs.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This macro is only used once. Inline and remove it.

Suggested-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 include/hw/clock.h | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/include/hw/clock.h b/include/hw/clock.h
index cbc5e6ced1e..b58038f1e7d 100644
--- a/include/hw/clock.h
+++ b/include/hw/clock.h
@@ -40,7 +40,6 @@ typedef void ClockCallback(void *opaque);
 #define CLOCK_PERIOD_FROM_NS(ns) ((ns) * (CLOCK_PERIOD_1SEC / 1000000000llu))
 #define CLOCK_PERIOD_TO_NS(per) ((per) / (CLOCK_PERIOD_1SEC / 1000000000llu))
 #define CLOCK_PERIOD_FROM_HZ(hz) (((hz) != 0) ? CLOCK_PERIOD_1SEC / (hz) : 0u)
-#define CLOCK_PERIOD_TO_HZ(per) (((per) != 0) ? CLOCK_PERIOD_1SEC / (per) : 0u)
 
 /**
  * Clock:
@@ -203,9 +202,12 @@ static inline uint64_t clock_get(const Clock *clk)
     return clk->period;
 }
 
-static inline unsigned clock_get_hz(Clock *clk)
+static inline uint64_t clock_get_hz(Clock *clk)
 {
-    return CLOCK_PERIOD_TO_HZ(clock_get(clk));
+    if (!clk->period) {
+        return 0u;
+    }
+    return CLOCK_PERIOD_1SEC / clk->period;
 }
 
 static inline unsigned clock_get_ns(Clock *clk)
-- 
2.26.2



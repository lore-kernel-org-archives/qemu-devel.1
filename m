Return-Path: <SRS0=H6GY=TQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DABCEC04AAF
	for <qemu-devel@archiver.kernel.org>; Thu, 16 May 2019 16:41:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A685420645
	for <qemu-devel@archiver.kernel.org>; Thu, 16 May 2019 16:41:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="o6jd/+Gs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A685420645
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:60927 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hRJRZ-0005jg-VN
	for qemu-devel@archiver.kernel.org; Thu, 16 May 2019 12:41:22 -0400
Received: from eggs.gnu.org ([209.51.188.92]:51807)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hRJPP-0004NR-3o
	for qemu-devel@nongnu.org; Thu, 16 May 2019 12:39:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hRJPN-0002lR-Gc
	for qemu-devel@nongnu.org; Thu, 16 May 2019 12:39:06 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:35475)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hRJPM-0002kH-Gp
	for qemu-devel@nongnu.org; Thu, 16 May 2019 12:39:04 -0400
Received: by mail-wm1-x342.google.com with SMTP id q15so4165681wmj.0
	for <qemu-devel@nongnu.org>; Thu, 16 May 2019 09:39:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:subject:date:message-id:in-reply-to:references:mime-version
	:content-transfer-encoding;
	bh=E+qwMGfCSf91iO1z7UbAq1hPniFkDTxXyjWu6BBesrM=;
	b=o6jd/+Gs9y7gWf13CEZM2I1rtlAnUdRfDeIApuFBZfH208KiYixdXQXbnV0qksdLF1
	OpyCFjX6CiN8sT6sUlrqtFdpkIGrEmwR3Gxj9praVLupRqxtTUyhV1rOiJlSuEUsGgU9
	gyMTRcpzbADkFBqJElCrr2jxgS08VLejeS6orLPvjUIvJ2btZbB0ykrYLMeHlihVhv0w
	e9KNbZhlfBeEAHlmriiNNjw38ceCwJzSWlyYc/UffnCErPw/1mzcJ1XSa59jb+F/EwX2
	OSwr2RDDWaGhMT8JVOJqNJ1OinPspweKIFSSrW1tIWR7pRzD2hyrC4kNGwd+ZnyPzTuF
	uS4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=E+qwMGfCSf91iO1z7UbAq1hPniFkDTxXyjWu6BBesrM=;
	b=nsaikutGW/ZJtoqfWbooAr6mOuY9x4CTZLSMoLKIipuFqz0v+ir0QpL80g98f6eC10
	FN57SGPkZ6QNyr4NRzfnJuukLYsR5ZNnFGFcaB9ymjtn/qFEn7mwFqpCJwNJHCFswxr0
	ugDqLhyyBYzTaDUZK+LyUd57yDyFHXcmhEtq+LJm7iucNQQQ1Atm74TAL/g9oLBol6GK
	xgesgNCMq9wdyXS0KFtl4ZarxKPj+Jze+VgaH2oHqjVO5lGHccDJhVoY3vs9VA/Qp6aO
	Yqha6aXNfgYNFGoPRCbKiAx6VjtNxs9FhAD8f0xha51ukMHNuBxx7F2H/a9bi7ySKfKb
	8q9w==
X-Gm-Message-State: APjAAAWBR8o/2W2sAl6enb5fG6GHkybr2oYeBhvTjUW56gxl7tMxLI4W
	pPjr+jcsvKVYeYou0MpItbumfDhTM/o=
X-Google-Smtp-Source: APXvYqw3bUXQztGHJRTWhjTUW8/3mbRC16WNl3HC7ztYoKzmHI4zYBO/Eaq2Ja4ZlRJIYwC5iOnvhQ==
X-Received: by 2002:a1c:e386:: with SMTP id a128mr22153654wmh.69.1558024742219;
	Thu, 16 May 2019 09:39:02 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
	by smtp.gmail.com with ESMTPSA id
	y130sm6702844wmc.44.2019.05.16.09.39.01
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 16 May 2019 09:39:01 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Date: Thu, 16 May 2019 17:38:55 +0100
Message-Id: <20190516163857.6430-2-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190516163857.6430-1-peter.maydell@linaro.org>
References: <20190516163857.6430-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::342
Subject: [Qemu-devel] [PATCH 1/3] arm: Move system_clock_scale to
 armv7m_systick.h
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The system_clock_scale global is used only by the armv7m systick
device; move the extern declaration to the armv7m_systick.h header,
and expand the comment to explain what it is and that it should
ideally be replaced with a different approach.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/arm/arm.h              |  4 ----
 include/hw/timer/armv7m_systick.h | 22 ++++++++++++++++++++++
 2 files changed, 22 insertions(+), 4 deletions(-)

diff --git a/include/hw/arm/arm.h b/include/hw/arm/arm.h
index ffed39252d8..ba3a9b41422 100644
--- a/include/hw/arm/arm.h
+++ b/include/hw/arm/arm.h
@@ -167,8 +167,4 @@ void arm_write_secure_board_setup_dummy_smc(ARMCPU *cpu,
                                             const struct arm_boot_info *info,
                                             hwaddr mvbar_addr);
 
-/* Multiplication factor to convert from system clock ticks to qemu timer
-   ticks.  */
-extern int system_clock_scale;
-
 #endif /* HW_ARM_H */
diff --git a/include/hw/timer/armv7m_systick.h b/include/hw/timer/armv7m_systick.h
index cca04defd8e..25e5ceacc85 100644
--- a/include/hw/timer/armv7m_systick.h
+++ b/include/hw/timer/armv7m_systick.h
@@ -31,4 +31,26 @@ typedef struct SysTickState {
     qemu_irq irq;
 } SysTickState;
 
+/*
+ * Multiplication factor to convert from system clock ticks to qemu timer
+ * ticks. This should be set (by board code, usually) to a value
+ * equal to NANOSECONDS_PER_SECOND / frq, where frq is the clock frequency
+ * in Hz of the CPU.
+ *
+ * This value is used by the systick device when it is running in
+ * its "use the CPU clock" mode (ie when SYST_CSR.CLKSOURCE == 1) to
+ * set how fast the timer should tick.
+ *
+ * TODO: we should refactor this so that rather than using a global
+ * we use a device property or something similar. This is complicated
+ * because (a) the property would need to be plumbed through from the
+ * board code down through various layers to the systick device
+ * and (b) the property needs to be modifiable after realize, because
+ * the stellaris board uses this to implement the behaviour where the
+ * guest can reprogram the PLL registers to downclock the CPU, and the
+ * systick device needs to react accordingly. Possibly this should
+ * be deferred until we have a good API for modelling clock trees.
+ */
+extern int system_clock_scale;
+
 #endif
-- 
2.20.1



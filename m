Return-Path: <SRS0=bvyN=TX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2661C282DD
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2019 14:33:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7936C21019
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2019 14:33:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="q6JOjqqi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7936C21019
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:37651 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hTomx-0002mE-Jq
	for qemu-devel@archiver.kernel.org; Thu, 23 May 2019 10:33:47 -0400
Received: from eggs.gnu.org ([209.51.188.92]:53756)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hTodf-0002he-1F
	for qemu-devel@nongnu.org; Thu, 23 May 2019 10:24:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hTodZ-0006tA-VM
	for qemu-devel@nongnu.org; Thu, 23 May 2019 10:24:07 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:51391)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hTodZ-0006sW-Lb
	for qemu-devel@nongnu.org; Thu, 23 May 2019 10:24:05 -0400
Received: by mail-wm1-x341.google.com with SMTP id c77so6072241wmd.1
	for <qemu-devel@nongnu.org>; Thu, 23 May 2019 07:24:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:subject:date:message-id:in-reply-to:references:mime-version
	:content-transfer-encoding;
	bh=k8+as5vxyhPXtpSjQtu+M6OtKD81u0dXi3n3hnTR2ug=;
	b=q6JOjqqipRvatIlDJ2V6zuV2Cqr/+32RKHHIP8ipRgECo3lSw5J0jS2IiyGlS/YTgC
	h2TfNp0WwH/tn5svnJ201ZJp6hhndJDfG40Cx63Uv1vi5p1AJ0q+KwB+9d9GyFy6lCt7
	eTiccSajubPXH9ucCtQWv775rEbUP1l6mwNDkT1g9pj5Fkuw/UyGM2WmSraH/D2ZM0w6
	sEsd3yP/FnFkv6poRaWCdCIX+Z59JfYrGqEFxgeuP2mdoJMRV/2o3Tt+ZBR6i14uf6iA
	VessOcPo/rPdrhMGgBDf4IBh8lzKGZVd7r2Vc1kx/FU4ZTaG0K7vuiEzqgfIc0ou7EZR
	vm+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=k8+as5vxyhPXtpSjQtu+M6OtKD81u0dXi3n3hnTR2ug=;
	b=lBtNOZnXwJMLRq7YQHDKCrNuRUBZGpYoBtJxIrEQiD/MqZ06r2glLp09K98fyM1QXG
	GNc/FQH8mCfKwlK8zTwVKb5jwbKvEYFrrMgKwqYE8lMfzzYJwdx8OF9L3BXSfXhF5i33
	OruuzhJEDO7qrLVbO8xgEkpWYu0qZZipAan8z4+jSBxkEAvMtIobA7vFtqOza/ousKUA
	MJvi38GqZiKw7fU1EZXns4RTJ+ywoho8N/0n5OnuGXEkrgfTFjJIt/MRIST+tGbrjL7T
	lhn05BohIiDZl/GvSo0VIj1bp5vFZ4FEXAPdkVZ3c3nhDzWlPT1t30tQgr+eveln50Nx
	ZzrA==
X-Gm-Message-State: APjAAAWq32n6DuAdSeFa3B+kmAWDq13nojCMsgU+dBsiDWKH5MaNtpl/
	qCs+VabNTbZeaVn3T+42LlhvNnzcaXuhQQ==
X-Google-Smtp-Source: APXvYqxZ6LLO/Fa46bkg3+34JwP82nM4y2dAXkHqnpK67syyYmhvfMPhKVjqEErxrvy5SHi2h/wWRw==
X-Received: by 2002:a1c:a804:: with SMTP id r4mr11960008wme.21.1558621444249; 
	Thu, 23 May 2019 07:24:04 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
	by smtp.gmail.com with ESMTPSA id z5sm9700617wmi.34.2019.05.23.07.24.02
	for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 23 May 2019 07:24:03 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Date: Thu, 23 May 2019 15:23:49 +0100
Message-Id: <20190523142357.5175-5-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190523142357.5175-1-peter.maydell@linaro.org>
References: <20190523142357.5175-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::341
Subject: [Qemu-devel] [PULL 04/12] arm: Move system_clock_scale to
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
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-id: 20190516163857.6430-2-peter.maydell@linaro.org
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



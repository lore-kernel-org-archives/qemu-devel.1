Return-Path: <SRS0=1sPN=D3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9ADB6C4363A
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 15:58:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 14CB022249
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 15:58:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aOmEgptL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 14CB022249
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33182 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUu24-0006Sr-0V
	for qemu-devel@archiver.kernel.org; Tue, 20 Oct 2020 11:58:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37300)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kUu0i-0004KI-9v
 for qemu-devel@nongnu.org; Tue, 20 Oct 2020 11:57:16 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330]:55005)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kUu0f-0003rN-Q8
 for qemu-devel@nongnu.org; Tue, 20 Oct 2020 11:57:15 -0400
Received: by mail-wm1-x330.google.com with SMTP id c77so2327929wmd.4
 for <qemu-devel@nongnu.org>; Tue, 20 Oct 2020 08:57:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=AWepJclKfiAgqPbSX9Qr68AN9+jPvNJVchxr+m/neyg=;
 b=aOmEgptLo8ivpRy4C4v9dFBWdO8AJR1ZGoQiFmcKw+lhRZP/pAdJuKBPEaYBf0v5AX
 S4l1UcwM8WlcTP6cj3KQL6iUipsz5yWGuxTICw2ZnHe4IB64jiIwfHHb/AXZEm2IJ36E
 5Yug/0mp3qm/anPDSz/5WM7weiR9AvinvCZvvET88MFqGZi+Em7l9S586MnqaMXGund8
 i8AbgeNvurYQq8vYkdjQiFwquAcJhtNcrwMKtkrKMj/sk2cSUFSRQ4z8tRSqCwS/8fva
 rJ1vMhZh5hkcAA8oA8iI6xIqp6s4DHBIY6TTGyAIDdSC1fbWCWOTRdgzrVX8k2WTAi8z
 sNZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=AWepJclKfiAgqPbSX9Qr68AN9+jPvNJVchxr+m/neyg=;
 b=Wrzr+AtToU0hUwetzwDN35i/f13Xz03Od1cmWChpYhtpgnPnxgCbDRk2OvHlBg83tU
 X/G9ictEOQDQupau3koxTOO3fVNLBojH2nbf6xoG+EfxcRLt3jH+Ilzn+L7qL37bPdpG
 z45sBuBUKBXVvfIPvlnR9Odi5zwoIAg0fpSOHtZX/eCLXH1kZr1i9vmgN7g+GjQWEC8u
 Y+BCBzmUyOBmRlIoPUmU9GEnyF24jEqhlBqvbYq0KvyI9XHiaJ9M1onoG//dvf0d1fQU
 oyDoDqOyRkvdav3OUCbQQfWpY6JV6aOC5O+9nMWBn3J0rmE+SINgoHyWM+Yq/89XdDTb
 gnzQ==
X-Gm-Message-State: AOAM532/OuyueP1QWRaPkHdrbL58KiL0jWzPiLrqfWer6NZvYejsIGS+
 aeLse/lkJMTOe3ZVwoSNUNf6LermQ0damw==
X-Google-Smtp-Source: ABdhPJzo/0yJme5lZisgA92dZ8ogifTeu6MabP+aXJMVSR0tfRARevb8sUkEDoudvAQNnYH2UnE0dQ==
X-Received: by 2002:a1c:e403:: with SMTP id b3mr2883073wmh.79.1603209429793;
 Tue, 20 Oct 2020 08:57:09 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id v6sm3780205wrp.69.2020.10.20.08.57.08
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Oct 2020 08:57:08 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 05/41] hw/timer/bcm2835: Introduce BCM2835_SYSTIMER_COUNT
 definition
Date: Tue, 20 Oct 2020 16:56:20 +0100
Message-Id: <20201020155656.8045-6-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201020155656.8045-1-peter.maydell@linaro.org>
References: <20201020155656.8045-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x330.google.com
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

Use the BCM2835_SYSTIMER_COUNT definition instead of the
magic '4' value.

Reviewed-by: Luc Michel <luc.michel@greensocs.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Message-id: 20201010203709.3116542-2-f4bug@amsat.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/timer/bcm2835_systmr.h | 4 +++-
 hw/timer/bcm2835_systmr.c         | 3 ++-
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/include/hw/timer/bcm2835_systmr.h b/include/hw/timer/bcm2835_systmr.h
index 7ce8f6ef4d8..43df7ee488c 100644
--- a/include/hw/timer/bcm2835_systmr.h
+++ b/include/hw/timer/bcm2835_systmr.h
@@ -16,6 +16,8 @@
 #define TYPE_BCM2835_SYSTIMER "bcm2835-sys-timer"
 OBJECT_DECLARE_SIMPLE_TYPE(BCM2835SystemTimerState, BCM2835_SYSTIMER)
 
+#define BCM2835_SYSTIMER_COUNT 4
+
 struct BCM2835SystemTimerState {
     /*< private >*/
     SysBusDevice parent_obj;
@@ -26,7 +28,7 @@ struct BCM2835SystemTimerState {
 
     struct {
         uint32_t status;
-        uint32_t compare[4];
+        uint32_t compare[BCM2835_SYSTIMER_COUNT];
     } reg;
 };
 
diff --git a/hw/timer/bcm2835_systmr.c b/hw/timer/bcm2835_systmr.c
index 3387a6214a2..ff8c5536610 100644
--- a/hw/timer/bcm2835_systmr.c
+++ b/hw/timer/bcm2835_systmr.c
@@ -134,7 +134,8 @@ static const VMStateDescription bcm2835_systmr_vmstate = {
     .minimum_version_id = 1,
     .fields = (VMStateField[]) {
         VMSTATE_UINT32(reg.status, BCM2835SystemTimerState),
-        VMSTATE_UINT32_ARRAY(reg.compare, BCM2835SystemTimerState, 4),
+        VMSTATE_UINT32_ARRAY(reg.compare, BCM2835SystemTimerState,
+                             BCM2835_SYSTIMER_COUNT),
         VMSTATE_END_OF_LIST()
     }
 };
-- 
2.20.1



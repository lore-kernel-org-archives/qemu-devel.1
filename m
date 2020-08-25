Return-Path: <SRS0=2GMi=CD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A637EC433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 16:09:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6503820782
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 16:09:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xJZuXVRL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6503820782
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54886 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAbW7-0002Ev-HK
	for qemu-devel@archiver.kernel.org; Tue, 25 Aug 2020 12:09:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46132)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kAbVF-0001Z3-AI
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 12:08:53 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:39838)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kAbVD-0005TZ-8r
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 12:08:52 -0400
Received: by mail-wr1-x443.google.com with SMTP id a5so13308553wrm.6
 for <qemu-devel@nongnu.org>; Tue, 25 Aug 2020 09:08:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=+rL5y+LPIlyoU3TM7H1gns6WWZrHXRx5K1wFTm/QiuM=;
 b=xJZuXVRL1iwjKNnf33xvxu/cxUSn5DVXtEewSZkRHgU0staU6fGAjc2cBi6kYEl4zS
 JrKEQDgqJBN9lUozSLjigFTYFZfrFEDkWrNaTRFTgUx1yzPjXjEZ6x0RSzmKoNq4lpDB
 1enJxz5UE+yZOv/0O1qXXLeJgVRhg92BenyDtkWi5qMYx3SGShPwT/3Rxrajby/r5H9n
 vXlZcvuSDn1S/cI/n4gQEwr0/49vwG5PtRTZp24DyKXOoE4sVFqmhndKtpt6E249k4wy
 qDOrQ3PuzD2JGphhRdPxYU9MNLCILv6xHukp68gAkbhaUf7M1MjUpWMcs9idvFUmgG6t
 EOKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=+rL5y+LPIlyoU3TM7H1gns6WWZrHXRx5K1wFTm/QiuM=;
 b=doOJ3Vz00gbB5zpPLCEzVs+eK4gXi+oQHMf9P4cJmthkaqRrOvkSgtxy43afRvCTaF
 dytEiD0pc/SgbmAY43H7VMzXsOAv5KFF57PAH5YyGwgPZbFFdQyZm2oTC14CMSQexPmu
 vaE91ztQ2yCn4uqVikNmCCTtKn1rwBLXvBuieGeXbu3wW1A7ixGXwUSWQBzXnAW95j6Y
 mKxy0NLwhnJAmX/IQtMOYHf4zccDxkXow7ftuIl4NuU0AxULezxGlxxLzUZ+s5lJKHgr
 uNY+0afpqFJEkhwighsS8XqoZLdxZA06EPfcaRNcbCTaarl/DboBNr1Fn36tmFxeoEfj
 GG+g==
X-Gm-Message-State: AOAM531ch9OfOD6ZjlhJt2T8EJmtpBAR2J8T6vAQbH1E41+4I8unR7s8
 7MsjIyzhu53L5NR1EXp9iuaAGg==
X-Google-Smtp-Source: ABdhPJy2QTqLyT9oND6vSaVf8Qnmi/C2jf4i1iBCGvO/nFHI/Fs+Gp12cySADrREWtQLsCd2WE7H9w==
X-Received: by 2002:a5d:4e03:: with SMTP id p3mr7901325wrt.354.1598371729571; 
 Tue, 25 Aug 2020 09:08:49 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id g70sm7407388wmg.24.2020.08.25.09.08.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Aug 2020 09:08:48 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH] hw/timer/armv7m_systick: assert that board code set
 system_clock_scale
Date: Tue, 25 Aug 2020 17:08:47 +0100
Message-Id: <20200825160847.18091-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::443;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x443.google.com
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
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

It is the responsibility of board code for an armv7m system to set
system_clock_scale appropriately for the CPU speed of the core.
If it forgets to do this, then QEMU will hang if the guest tries
to use the systick timer in the "tick at the CPU clock frequency" mode.

We forgot that in a couple of our boards (see commits ce4f70e81ed23c93f,
e7e5a9595ab1136). Add an assertion in the systick reset method so
we don't let any new boards in with the same bug.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
In the longer term we should make this a clocktree input and
plumb it through the armv7m container and so on, but for the
moment this assert() improves the current situation.
---
 hw/timer/armv7m_systick.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/hw/timer/armv7m_systick.c b/hw/timer/armv7m_systick.c
index 74c58bcf245..a8cec7eb56b 100644
--- a/hw/timer/armv7m_systick.c
+++ b/hw/timer/armv7m_systick.c
@@ -202,6 +202,14 @@ static void systick_reset(DeviceState *dev)
 {
     SysTickState *s = SYSTICK(dev);
 
+    /*
+     * Forgetting to set system_clock_scale is always a board code
+     * bug. We can't check this earlier because for some boards
+     * (like stellaris) it is not yet configured at the point where
+     * the systick device is realized.
+     */
+    assert(system_clock_scale != 0);
+
     s->control = 0;
     s->reload = 0;
     s->tick = 0;
-- 
2.20.1



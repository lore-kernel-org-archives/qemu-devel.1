Return-Path: <SRS0=wjGh=DT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2744C43457
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2020 15:56:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 89ACC20735
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2020 15:56:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LgeVVKXg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 89ACC20735
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42072 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kS0BU-0002TZ-Hi
	for qemu-devel@archiver.kernel.org; Mon, 12 Oct 2020 11:56:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56964)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kRzqQ-00073c-4R
 for qemu-devel@nongnu.org; Mon, 12 Oct 2020 11:34:39 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:36596)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kRzqL-0007KX-Q0
 for qemu-devel@nongnu.org; Mon, 12 Oct 2020 11:34:35 -0400
Received: by mail-wm1-x342.google.com with SMTP id e2so17969383wme.1
 for <qemu-devel@nongnu.org>; Mon, 12 Oct 2020 08:34:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=gRnzhB6CdonM/19XlgBuso003ocyxIuCfMZY1cNIpB4=;
 b=LgeVVKXg78hozwZTdWLu2fJHYlQq4U5ka0HhWgb9QLbK1ggAKfrS5MbacohIPpQafY
 oxv1cbQVxVtyDmjGKXprveYYnsIsvdYslP4cQ5IMQ7iWiPgv/CjrnItqWKF0sMpxKh1K
 lcGxAeod9NA9P1TFrA2mysw/ozKIz+z6CllgVNBfFnkA1z0NrezP/747E8QmLZ+gYMIL
 du1aRq1HOPL1JQqV4jjXd/+Z8GgYtVmcExi4Pa4pU21BYXV/YS9npUdCobe7YGBTxt46
 PcW7a3ooGuE5o81xv5/E80lYkQOgenXN6cC3qLpmqvxWKu10zJSra9tCXw/aKnobzHIO
 X8ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=gRnzhB6CdonM/19XlgBuso003ocyxIuCfMZY1cNIpB4=;
 b=Na6fyIjrkD8r5fuEqyNM7sMlkN4/xp/8zlDn0DF7oJ8Wm5gSkjhM8BjzUyL3lLHpBp
 hoKBz9ufn2x6aEMbuJjteh2nkWzQ8yUoYIMfg7E5fy5fcOZ6rTBMntBSIofDC/AHRn47
 OPf5b+k7jy0tB1WCBnIti5dgy7kD6Q7iSDOPIZXuL7m9WHFQT7abg72+aLZrpQmaBE0i
 oaG72HQvlYQ6v5XRuLSHKVniT5NJ+453RHTL+nPVvWHwDFAs3jI8bwGH1ZYJF92FpKaE
 +kKQVnLJTuTy3xAlCVybthvkyeKrOTawMRlb/6WHudRsERyqF/1Fjg4FhM+4YnZO75B3
 MkZw==
X-Gm-Message-State: AOAM530/60pTL8dnH5XcDSa3y9qX7jx0tAJ14kG+BtcHxVEDONobM72T
 BcaKR1MXRl+ABV8txmR0Qg/Q1A==
X-Google-Smtp-Source: ABdhPJyGIly3cHa6mtDgpNOYPQ5o4bEJrDg7BTBDob4JuQm2Jyc8y+4MEBC1drxRf0R808xljbZjtw==
X-Received: by 2002:a1c:59c3:: with SMTP id n186mr11469861wmb.32.1602516872259; 
 Mon, 12 Oct 2020 08:34:32 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id y10sm19675284wrq.73.2020.10.12.08.34.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Oct 2020 08:34:31 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH for-5.1] hw/timer/imx_epit: Avoid assertion when CR.SWR is
 written
Date: Mon, 12 Oct 2020 16:33:42 +0100
Message-Id: <20201012153408.9747-20-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201012153408.9747-1-peter.maydell@linaro.org>
References: <20201012153408.9747-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::342;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x342.google.com
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
Cc: Richard Henderson <richard.henderson@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The imx_epit device has a software-controllable reset triggered by
setting the SWR bit in the CR register. An error in commit cc2722ec83ad9
means that we will end up assert()ing if the guest does this, because
the code in imx_epit_write() starts ptimer transactions, and then
imx_epit_reset() also starts ptimre transactions, triggering
"ptimer_transaction_begin: Assertion `!s->in_transaction' failed".

The cleanest way to avoid this double-transaction is to move the
start-transaction for the CR write handling down below the check of
the SWR bit.

Fixes: https://bugs.launchpad.net/qemu/+bug/1880424
Fixes: cc2722ec83ad944505fe
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
I don't have a test image for KZM so this is the minimal
obviously-safe change. I'm pretty sure that actually we could
add a "break" after the imx_epit_reset() call because all of
the work done by the following code is duplicating the ptimer
setup done by the reset function. But I'm not really happy making
that change without a test image...
---
 hw/timer/imx_epit.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/hw/timer/imx_epit.c b/hw/timer/imx_epit.c
index baf6338e1a6..4f51e6e12da 100644
--- a/hw/timer/imx_epit.c
+++ b/hw/timer/imx_epit.c
@@ -199,15 +199,18 @@ static void imx_epit_write(void *opaque, hwaddr offset, uint64_t value,
 
     switch (offset >> 2) {
     case 0: /* CR */
-        ptimer_transaction_begin(s->timer_cmp);
-        ptimer_transaction_begin(s->timer_reload);
 
         oldcr = s->cr;
         s->cr = value & 0x03ffffff;
         if (s->cr & CR_SWR) {
             /* handle the reset */
             imx_epit_reset(DEVICE(s));
-        } else {
+        }
+
+        ptimer_transaction_begin(s->timer_cmp);
+        ptimer_transaction_begin(s->timer_reload);
+
+        if (!(s->cr & CR_SWR)) {
             imx_epit_set_freq(s);
         }
 
-- 
2.20.1



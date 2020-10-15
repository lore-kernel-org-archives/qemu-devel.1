Return-Path: <SRS0=muvY=DW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7102DC43457
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2020 15:20:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B172C2225A
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2020 15:20:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BT6loDg8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B172C2225A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33372 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kT53Q-00058V-JR
	for qemu-devel@archiver.kernel.org; Thu, 15 Oct 2020 11:20:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49224)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kT51X-0003fS-NY
 for qemu-devel@nongnu.org; Thu, 15 Oct 2020 11:18:35 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:52944)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kT51V-0005ar-Uz
 for qemu-devel@nongnu.org; Thu, 15 Oct 2020 11:18:35 -0400
Received: by mail-wm1-x341.google.com with SMTP id e23so3575331wme.2
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2020 08:18:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=FR7Wjpqj5kmgPjv/umwo7PltWhBgeKSR7fRK4Hm0S9U=;
 b=BT6loDg8Kda+NBz2j6LCpStQspp7cEKxn0IID108HCFrJxtEWCG93dd7K9BCnwBOtu
 /gFTiVMkYUsxiXzHFTwTrgDjMB0ncOdsYT/kFLutPxqTi6D1NFiQRzXugHEkfiAUK18/
 L6txIQew8AnuO7aixD39UWxFRgdNMnUgy7OLPmzHOXPbiiFHyXYq3I+Sst3sLwe/gVFK
 f/Hca7ZcaYdvlGPBPkO6px+MIsiN4yPQClhSKhNqr/ATsZHVCZaDnxfDWzdZv9vaggvF
 vCJD0KRWk0bLxz/ROzN7Npg/Kw9zjqavZRsvaURURa1upaCQfGqcFZMpTgj2X5lrJVWn
 Oa7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=FR7Wjpqj5kmgPjv/umwo7PltWhBgeKSR7fRK4Hm0S9U=;
 b=i/ozY92P2HKCzHmOPtUKq8vn9ypk2gNeiEilLYqjovbNgU1CmnrKdd6ogMjz4mDT+e
 IgRvbAf9lKWuT8mtFPq+Ix/8eThadZQC34Gp1Qln7xhQS7sABrsN2b43DFLO1v0g38LI
 kYPZaZ7VcLXElcIW66XHonS2yKkWuFUHrDPeAjAzjr43dQgnGV0RWvrC967FKDiM8Enc
 jSfWB/S8pJY9/r334XLwexG9li/3JAGzmGK1Gsa5CL9SK89xLnkHkMKmVxJiMUr0rWxJ
 /Kkcgtftib7Mi68T516QK1aiC401KoRwv7dDC96qGm71lxozrwvEByNmXe8eho0y4h4z
 fEOQ==
X-Gm-Message-State: AOAM530Ksti2sFuZ2DVUGOWP0X0Mbql2qsi+HBLymuDQs6cySqb8Oge0
 hb+xoMXDAk8waINqHm7GwbBEYDVLxV7u/mUJ
X-Google-Smtp-Source: ABdhPJysuXcx0AYHklxvyPbuhViySWqmcoRKE7dIRlXUthuIsaPx8XzDMGrKiAhICLvzwQXPf8S5Og==
X-Received: by 2002:a1c:b7c6:: with SMTP id h189mr4891224wmf.154.1602775112597; 
 Thu, 15 Oct 2020 08:18:32 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id j13sm5193286wru.86.2020.10.15.08.18.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Oct 2020 08:18:31 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 1/2] hw/core/ptimer: Support ptimer being disabled by timer
 callback
Date: Thu, 15 Oct 2020 16:18:28 +0100
Message-Id: <20201015151829.14656-2-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201015151829.14656-1-peter.maydell@linaro.org>
References: <20201015151829.14656-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::341;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x341.google.com
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

In ptimer_reload(), we call the callback function provided by the
timer device that is using the ptimer.  This callback might disable
the ptimer.  The code mostly handles this correctly, except that
we'll still print the warning about "Timer with delta zero,
disabling" if the now-disabled timer happened to be set such that it
would fire again immediately if it were enabled (eg because the
limit/reload value is zero).

Suppress the spurious warning message and the unnecessary
repeat-deletion of the underlying timer in this case.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/core/ptimer.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/hw/core/ptimer.c b/hw/core/ptimer.c
index c6d2beb1dac..2aa97cb665c 100644
--- a/hw/core/ptimer.c
+++ b/hw/core/ptimer.c
@@ -117,6 +117,10 @@ static void ptimer_reload(ptimer_state *s, int delta_adjust)
     }
 
     if (delta == 0) {
+        if (s->enabled == 0) {
+            /* trigger callback disabled the timer already */
+            return;
+        }
         if (!qtest_enabled()) {
             fprintf(stderr, "Timer with delta zero, disabling\n");
         }
-- 
2.20.1



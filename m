Return-Path: <SRS0=uEni=2K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAE3EC2D0D3
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2019 14:39:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B85C321D7E
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2019 14:39:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cwk9Xk5W"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B85C321D7E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57354 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iiJQw-0006TD-W4
	for qemu-devel@archiver.kernel.org; Fri, 20 Dec 2019 09:39:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39886)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iiJEx-0004ft-Tx
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 09:26:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iiJEw-0006pi-7a
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 09:26:51 -0500
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432]:40620)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iiJEv-0006o8-TB
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 09:26:50 -0500
Received: by mail-wr1-x432.google.com with SMTP id c14so9584923wrn.7
 for <qemu-devel@nongnu.org>; Fri, 20 Dec 2019 06:26:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=c8ReWNRJBR+WCHzBQj303nzzfEBRBdnQT57kHe9PFT0=;
 b=cwk9Xk5WU9GkbYSOc8QGDLSUZ5uIyWM+w2S/d5ed+yIwnmWUMeEF7KNaisXniPDy+2
 yS8SjkEnABeMcBZPEPOxp347+YcqBT9S8/pmMoK4uRz8XgaFzZaW+to6GlEy809duxPv
 w2jRuGGLTLn35erjt6UdzowZRgyvT3YdtIki1ArBih3mbaM4axJJPVTIj+kcGgvZFC4w
 kK6RYIZx4lUjvf3tR42jt95OjlIzEIVLKO7z7qnxs7f7wMNefwUrl3f1gtjTgDHjhwXJ
 Gg2mp9i3ynqShurhNEPS4GPBwVWGPtyT/0jj68KcG39+c5sB1/3cmNJznqOMarkOx1Mc
 Rotw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=c8ReWNRJBR+WCHzBQj303nzzfEBRBdnQT57kHe9PFT0=;
 b=T4yeQjFJBTrG6IG/GGtPbxASWQEveZRGtDoazMgrMRezG10/B2yGpFGy8Y6Qd3FVvo
 ADL+ol/i/vqLb+EsEfvYS4WUcCCaK6+lsdvXPpj0fLapbLEpq4bZQBV187lGAE+kGVjC
 1GhD/nZ8LgY0xaMX9wn9sMF0EgE8ubVrfMhbgGqhijYaDuhGsTSjMfQbV564e3tVQRZj
 eCZOxFUjjwTZvvF9VmL2hW9MnRhCZmFjvEz2kvgukEdDE35Cdb7eEiciqQCPTHH39T9B
 HSoF0EOYDEAAlBlEX5/jbUa5hbS2d7wRGC2lajXAhvOPRgayESMFP1O3MIFaB91Vj3ig
 6+Yg==
X-Gm-Message-State: APjAAAWq829UpUpO7g/c1GsEP8pkM0klY2aHo3ol0UKCClFWF/uPTA7b
 5H5R9bmb3awCxWRdWRMXhJ5JHskBc0SP8A==
X-Google-Smtp-Source: APXvYqwoYcIfkJKcPkD1QQdWqQ2XccG5Yjri4AFxvoMKtgCLiv60Kz8sJFSuThpEk2QHcjlbeYJseA==
X-Received: by 2002:a05:6000:11c6:: with SMTP id
 i6mr15970969wrx.178.1576852008706; 
 Fri, 20 Dec 2019 06:26:48 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id t5sm9741814wrr.35.2019.12.20.06.26.47
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Dec 2019 06:26:47 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 01/12] target/arm: Remove redundant scaling of nexttick
Date: Fri, 20 Dec 2019 14:26:33 +0000
Message-Id: <20191220142644.31076-2-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191220142644.31076-1-peter.maydell@linaro.org>
References: <20191220142644.31076-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::432
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

From: Andrew Jeffery <andrew@aj.id.au>

The corner-case codepath was adjusting nexttick such that overflow
wouldn't occur when timer_mod() scaled the value back up. Remove a use
of GTIMER_SCALE and avoid unnecessary operations by calling
timer_mod_ns() directly.

Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Cédric Le Goater <clg@kaod.org>
Message-id: f8c680720e3abe55476e6d9cb604ad27fdbeb2e0.1576215453.git-series.andrew@aj.id.au
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/helper.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 5074b5f69ca..31fab098c55 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -2486,9 +2486,10 @@ static void gt_recalc_timer(ARMCPU *cpu, int timeridx)
          * timer expires we will reset the timer for any remaining period.
          */
         if (nexttick > INT64_MAX / GTIMER_SCALE) {
-            nexttick = INT64_MAX / GTIMER_SCALE;
+            timer_mod_ns(cpu->gt_timer[timeridx], INT64_MAX);
+        } else {
+            timer_mod(cpu->gt_timer[timeridx], nexttick);
         }
-        timer_mod(cpu->gt_timer[timeridx], nexttick);
         trace_arm_gt_recalc(timeridx, irqstate, nexttick);
     } else {
         /* Timer disabled: ISTATUS and timer output always clear */
-- 
2.20.1



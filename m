Return-Path: <SRS0=muh1=7E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4802CC433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2020 16:26:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0994C20723
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2020 16:26:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CT+0Y3Lb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0994C20723
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39162 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jcAVU-000156-6q
	for qemu-devel@archiver.kernel.org; Fri, 22 May 2020 12:26:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40502)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1jcAKg-0003Xh-K3
 for qemu-devel@nongnu.org; Fri, 22 May 2020 12:15:38 -0400
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641]:38071)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1jcAKf-0006IS-KC
 for qemu-devel@nongnu.org; Fri, 22 May 2020 12:15:38 -0400
Received: by mail-pl1-x641.google.com with SMTP id m7so4577354plt.5
 for <qemu-devel@nongnu.org>; Fri, 22 May 2020 09:15:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=HfLXLJX8xYWjaZkhWytSgY03XSw6juhoh6RiJzn7u1c=;
 b=CT+0Y3LbfxdDeDDkrK9LzvOCb5kJTQVIScmmf8UAVpnilrJkIAI/qy+DWy03GLp1BR
 kV4cwcmj1hF3BPf9DB3nl1r0zEjT0hTDm8HiBQWtPptLJOfR4C9g5Koc+OtWxF5soFTH
 Qpz1chJuI7ONIltDBzLBqEp8+0gIz0EiZcqMAzixEP4Ay2N/gYsByQiDqmNKhke3bPiF
 niGvg/+q0aWcVX5knDifbiatYaXYa2BIVv8TTvSu6MU6osYMNT6bF4nFWPlmumOCw5nQ
 xqMXTAaklCAgQKCVkX6EGSb2FDHeVmt/7D7XKi+DyeLf4wPBvaOBvY/1wK2JXWLUzcop
 xerQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=HfLXLJX8xYWjaZkhWytSgY03XSw6juhoh6RiJzn7u1c=;
 b=uWhvzgA94I2KsWZIid6n+dAME073+bAGb5vO5kdJXzaC5o2ozLtvOpIDdVvIrP+FiF
 mwIpLelJzen43CTiDHJoXMGIz+IOAZa4UmZXuT8pQUzkdNLivDJtQ1+dkd8xtEEpn+Ca
 6nMB1ts7JqZHGimLBxqF2i3GDxd5dtFOMgXPt5qJlzzUUyw1uo5/S7/dh0QjZFFagQBR
 c6I2U1rOE9eP6JyVv7LeFzkfRaUYNJ3M4bzgHqAV+DVGfTsnpyZYes9R7ZzLJq+uk2Rz
 0uGROOb/ItgaRTw6VQdx5SRznb26mIK9BUSIcg0TR+M28qNcuo+9NEazItaAb5WRfthX
 op9w==
X-Gm-Message-State: AOAM530FrPNhB9fP3bzngQ165GgS8FDC4zYm00bCKiUhcWy59sS7A2pr
 IsY03v8er9tPaKzTaGrDW7aTPunHktp9BA==
X-Google-Smtp-Source: ABdhPJyVSSNMgunpT7lv7Ih6PqROoXJwH72krGad2+09dtgPx+0B1zE5GpW7yZXm/kemZ7Uen5utWA==
X-Received: by 2002:a17:902:694b:: with SMTP id
 k11mr14190443plt.77.1590164135801; 
 Fri, 22 May 2020 09:15:35 -0700 (PDT)
Received: from Rfoley-MA01.hsd1.ma.comcast.net
 ([2601:199:4480:60c0:f1d9:5fce:c451:d2e2])
 by smtp.gmail.com with ESMTPSA id y75sm7255428pfb.212.2020.05.22.09.15.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 May 2020 09:15:35 -0700 (PDT)
From: Robert Foley <robert.foley@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 18/19] target/arm: Fix tsan warning in cpu.c
Date: Fri, 22 May 2020 12:07:54 -0400
Message-Id: <20200522160755.886-19-robert.foley@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200522160755.886-1-robert.foley@linaro.org>
References: <20200522160755.886-1-robert.foley@linaro.org>
Received-SPF: pass client-ip=2607:f8b0:4864:20::641;
 envelope-from=robert.foley@linaro.org; helo=mail-pl1-x641.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Peter Maydell <peter.maydell@linaro.org>, robert.foley@linaro.org,
 Richard Henderson <richard.henderson@linaro.org>, cota@braap.org,
 peter.puhov@linaro.org, alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

For example:
WARNING: ThreadSanitizer: data race (pid=11134)
  Atomic write of size 4 at 0x7bbc0000e0ac by main thread (mutexes: write M875):
    #0 __tsan_atomic32_store <null> (qemu-system-aarch64+0x394d84)
    #1 cpu_reset_interrupt hw/core/cpu.c:107:5 (qemu-system-aarch64+0x842f90)
    #2 arm_cpu_set_irq target/arm/cpu.c (qemu-system-aarch64+0x615a55)

  Previous read of size 4 at 0x7bbc0000e0ac by thread T7:
    #0 arm_cpu_has_work target/arm/cpu.c:78:16 (qemu-system-aarch64+0x6178ba)
    #1 cpu_has_work include/hw/core/cpu.h:700:12 (qemu-system-aarch64+0x68be2e)

Cc: Peter Maydell <peter.maydell@linaro.org>
Cc: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Robert Foley <robert.foley@linaro.org>
---
 target/arm/cpu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 32bec156f2..cdb90582ee 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -75,7 +75,7 @@ static bool arm_cpu_has_work(CPUState *cs)
     ARMCPU *cpu = ARM_CPU(cs);
 
     return (cpu->power_state != PSCI_OFF)
-        && cs->interrupt_request &
+        && atomic_read(&cs->interrupt_request) &
         (CPU_INTERRUPT_FIQ | CPU_INTERRUPT_HARD
          | CPU_INTERRUPT_VFIQ | CPU_INTERRUPT_VIRQ
          | CPU_INTERRUPT_EXITTB);
-- 
2.17.1



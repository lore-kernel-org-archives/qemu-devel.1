Return-Path: <SRS0=JiPe=DG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A87A6C4346E
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 09:44:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EFA5420848
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 09:44:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nuviainc-com.20150623.gappssmtp.com header.i=@nuviainc-com.20150623.gappssmtp.com header.b="GqWPJvrL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EFA5420848
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=nuviainc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56156 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNCBk-0000TV-0x
	for qemu-devel@archiver.kernel.org; Tue, 29 Sep 2020 05:44:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34908)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <graeme@nuviainc.com>)
 id 1kNCAC-0006lu-Jp
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 05:43:12 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:46514)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <graeme@nuviainc.com>)
 id 1kNCA9-0006pn-Tw
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 05:43:12 -0400
Received: by mail-wr1-x443.google.com with SMTP id o5so4556334wrn.13
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2020 02:43:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=nuviainc-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=QDUv3dcjFWN3ygber7QxqtPNAs8gzuomgpWrmGLr5Rs=;
 b=GqWPJvrLgfArS+dwd2kylKzls0AMYrGW519QAwUsZ/SLN1hIUV01Z6sZwcdw+Yh3wP
 Tp0yPH6p3Q9+y89r4kF7O7XVeeZ0GBjo8id25sqx947B90bhM0SgOOd2z2e4pxBZMO08
 bR9TCnb45hGg5c3OyOEqUtL03AA1zNMvym/0ey1qEQ8GTHh4y+xKvZcNSJ9m2MoKnz9S
 7bqHLEFAXsGEROILAW2nGlf2iEzEPq7fre0kW1/EnfQVXZCJYkexXiMv00IHdgtvS0n8
 HLI3iVbxeq79xVEIeC3siyudzA/zVAvPgObCabxyPTmxLVbyxXs6Zwuibt8tSyIRrrVq
 soxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=QDUv3dcjFWN3ygber7QxqtPNAs8gzuomgpWrmGLr5Rs=;
 b=sklrIYiNp6OJsmq1oQi94/oAmpL8tGWS6k3Lq0hTriWMGOXweano8FFBXP8OUZo/7x
 aw92tU/qZDDdeC8lLGFFkfGdeYU8/xy6JaqT8CQ5352vtLk37QczKrz+JfhxbxfmB+OF
 G4ki8sui2VqKn7zX6N0ecl2kPERqrVluMY6b5oZkZmZ5OXclEWG1BEp0xDnZhWfUEXEP
 KVZs37NsVyFNAXWHk+BLYsu8zdGx8mn8Vkj4IwvvmdGjxzJM96fcHQ8dPsWp1+i6inrY
 ykMv6m6NHYoBt0w5vy44lDfuL6poGBpc9MoH2eYnihHErZhlekLSWXP7ZBVRaGSViHwd
 pWaw==
X-Gm-Message-State: AOAM531A7hjk8COZBmtQVDFLFzX5H8h2fbmIRYZsYSVdHqrzYCeNKLjC
 yYgMEot/+bqMcWM8Up8s0H08gg==
X-Google-Smtp-Source: ABdhPJykEz8acd39FrdYVsWfN8tSqnI53ZpQARo435SCZHKpc2gZzJ6OWovEWdCwUZdjJxaZytahAg==
X-Received: by 2002:adf:9124:: with SMTP id j33mr3255862wrj.272.1601372588589; 
 Tue, 29 Sep 2020 02:43:08 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8010:64d6::1d89])
 by smtp.gmail.com with ESMTPSA id t6sm5887797wre.30.2020.09.29.02.43.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2020 02:43:07 -0700 (PDT)
From: Graeme Gregory <graeme@nuviainc.com>
To: qemu-arm@nongnu.org
Subject: [PATCH 2/2] hw/arm/sbsa-ref : allocate IRQs for SMMUv3
Date: Tue, 29 Sep 2020 10:42:51 +0100
Message-Id: <20200929094251.151722-3-graeme@nuviainc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200929094251.151722-1-graeme@nuviainc.com>
References: <20200929094251.151722-1-graeme@nuviainc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::443;
 envelope-from=graeme@nuviainc.com; helo=mail-wr1-x443.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Cc: Graeme Gregory <graeme@nuviainc.com>, peter.maydell@linaro.org,
 jamie@nuviainc.com, rad@semihalf.com, qemu-stable@nongnu.org,
 qemu-devel@nongnu.org, leif@nuviainc.com, f4bug@amsat.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Original commit did not allocate IRQs for the SMMUv3 in the irqmap
effectively using irq 0->3 (shared with other devices). Assuming
original intent was to allocate unique IRQs then add an allocation
to the irqmap.

Fixes: e9fdf453240 ("hw/arm: Add arm SBSA reference machine, devices part")
Signed-off-by: Graeme Gregory <graeme@nuviainc.com>
---
 hw/arm/sbsa-ref.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/arm/sbsa-ref.c b/hw/arm/sbsa-ref.c
index 47e83252c1..9109fb58be 100644
--- a/hw/arm/sbsa-ref.c
+++ b/hw/arm/sbsa-ref.c
@@ -138,6 +138,7 @@ static const int sbsa_ref_irqmap[] = {
     [SBSA_SECURE_UART_MM] = 9,
     [SBSA_AHCI] = 10,
     [SBSA_EHCI] = 11,
+    [SBSA_SMMU] = 12, /* ... to 15 */
 };
 
 static uint64_t sbsa_ref_cpu_mp_affinity(SBSAMachineState *sms, int idx)
-- 
2.25.1



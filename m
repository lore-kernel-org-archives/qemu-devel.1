Return-Path: <SRS0=EIn8=4Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A1DCC3F2D2
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2020 16:42:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6572C2468D
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2020 16:42:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FLhh6Nc1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6572C2468D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50244 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j7iiw-0007AC-G5
	for qemu-devel@archiver.kernel.org; Fri, 28 Feb 2020 11:42:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56404)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j7if4-0007F8-Ry
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 11:38:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j7if3-0001nu-TU
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 11:38:50 -0500
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329]:39579)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j7if3-0001nW-JE
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 11:38:49 -0500
Received: by mail-wm1-x329.google.com with SMTP id c84so3870038wme.4
 for <qemu-devel@nongnu.org>; Fri, 28 Feb 2020 08:38:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=DrxWiG6jWEHbV7tbIEKAcwRWenD5JqrAAvIabuixUV4=;
 b=FLhh6Nc1M8OwUxXdRxn7WVIr76Wq+ZLJdnHwRId/lhEzFeSu8oYgmwH67ytHAsCuEj
 lzBRc2DQHdG5AuAIjHXXLWIEWe27cMfY592s9NRmMWicnwh1cl+9TJ3tSiF2ep9rzugc
 Jxmh8OYuV+up/esxLgoDRZhWSrNin5b4rebLlpi21a41cDsHfObwQCu2oVowzVQ/NHBW
 Xn36E4Xb6hz9QGY9C3Q4k5AcFyA3+4j9lSpXVCOsfhJs1SMjZ8dqNxJegCyvE2yzGiaj
 CP1sw50h58mRt0+vnbnw0vcksvoppOzBcOfAscnmhrtixfdQw5cLTITdb55dYclvA1Tv
 ePdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=DrxWiG6jWEHbV7tbIEKAcwRWenD5JqrAAvIabuixUV4=;
 b=bEXH1ej5+jY6joIhFD6ys0ff9FNx8RTR5bpsPjmB+vvPW2TuBm23hlXbyAeyRyd5mp
 IQn3mKOkB2OSZ25exm7WgXY/FJ+3DVpXbNk8KUQibLB/5dhUcXxBi+CBTusUIGNd7uHC
 OXvLlgqG+ePDJjuudVkH2KCS5aB1avD7qqeTvk1Q35Jl5aATFSyZsYXvtXJuuyTNpa6R
 tOL8EVb9zcqTsKK4HExGOU65JYUDawOmd4zWoh+VD+tRJfetuUD1RZDB3v4ubcb/dAsb
 OY4UKS32nphNUNjc2e5wfGsQA3odKUcQ+UhG9J6ACgmqvqwwWHWhBwWVIzxTfWQv4AxN
 DZcg==
X-Gm-Message-State: APjAAAWUadUdKwq3OhcHIpJDmio+O0FdmdsVOYSEdkPfvZBVpWUDvqIQ
 O1U3kkj2R/TlevmUYWFsk2NqBZyWjX7kqQ==
X-Google-Smtp-Source: APXvYqySDumxWxAKkOcEUnjrG8pJ5z03AVFrXsqnooDRJNvnScd2VPV3TBtFPnvWJA0HWxA3vizPkg==
X-Received: by 2002:a05:600c:4151:: with SMTP id
 h17mr5955408wmm.189.1582907928407; 
 Fri, 28 Feb 2020 08:38:48 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id c9sm13335214wrq.44.2020.02.28.08.38.47
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Feb 2020 08:38:47 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 05/33] cpu/a9mpcore: Set number of GIC priority bits to 5
Date: Fri, 28 Feb 2020 16:38:12 +0000
Message-Id: <20200228163840.23585-6-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200228163840.23585-1-peter.maydell@linaro.org>
References: <20200228163840.23585-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::329
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

From: Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>

All A9 CPUs have a GIC with 5 bits of priority.

Signed-off-by: Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 1582537164-764-3-git-send-email-sai.pavan.boddu@xilinx.com
Suggested-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/cpu/a9mpcore.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/hw/cpu/a9mpcore.c b/hw/cpu/a9mpcore.c
index 1f8bc8a196f..b4f6a7e8a54 100644
--- a/hw/cpu/a9mpcore.c
+++ b/hw/cpu/a9mpcore.c
@@ -16,6 +16,8 @@
 #include "hw/qdev-properties.h"
 #include "hw/core/cpu.h"
 
+#define A9_GIC_NUM_PRIORITY_BITS    5
+
 static void a9mp_priv_set_irq(void *opaque, int irq, int level)
 {
     A9MPPrivState *s = (A9MPPrivState *)opaque;
@@ -68,6 +70,8 @@ static void a9mp_priv_realize(DeviceState *dev, Error **errp)
     gicdev = DEVICE(&s->gic);
     qdev_prop_set_uint32(gicdev, "num-cpu", s->num_cpu);
     qdev_prop_set_uint32(gicdev, "num-irq", s->num_irq);
+    qdev_prop_set_uint32(gicdev, "num-priority-bits",
+                         A9_GIC_NUM_PRIORITY_BITS);
 
     /* Make the GIC's TZ support match the CPUs. We assume that
      * either all the CPUs have TZ, or none do.
-- 
2.20.1



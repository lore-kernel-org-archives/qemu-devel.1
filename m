Return-Path: <SRS0=afRr=CX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E97DC43461
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 14:33:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 09C56206C9
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 14:33:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ixhKOUin"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 09C56206C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42392 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kHpY7-0000xA-VE
	for qemu-devel@archiver.kernel.org; Mon, 14 Sep 2020 10:33:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46410)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kHp8h-0003cy-Ey
 for qemu-devel@nongnu.org; Mon, 14 Sep 2020 10:07:27 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a]:37131)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kHp8f-0007gG-Rf
 for qemu-devel@nongnu.org; Mon, 14 Sep 2020 10:07:27 -0400
Received: by mail-wr1-x42a.google.com with SMTP id z4so18925667wrr.4
 for <qemu-devel@nongnu.org>; Mon, 14 Sep 2020 07:07:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=l4WF1cLevfcGcFBwjaUwq0TP82SnPQoQFK5fdQ/QPMo=;
 b=ixhKOUinXtsPGXl1W6VEkAGxl6Hj2tD4uVXLHNyX7H4HW/d+/SH46hjL+xC9Ow36LU
 ayOsHKIs0z3SwfStHgJ8tpcLsx+s+fOJJ4WOGzwDs/6ZjPPO2iHtn5iFnvkUynj3oDA9
 dZ2UnQCTnWfJpva85ib5oyPLeKkOvr6nIhO4hSK7Fhcxk+6FCCkPJ+JpO2JcV6ToIkEE
 JUkguI5IsmJCQc4lcVHfJTnMXqygslJMC0cIxr4tfAB6nRNvOnVabetcA6CSOk69Z3m6
 GEPKPgNT8pzXE+YFU2ZDRq8CZRxSLF14liZeuKFPk5vnZ3Qsw6n1nSLwAP32quAJ1a/E
 Aggg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=l4WF1cLevfcGcFBwjaUwq0TP82SnPQoQFK5fdQ/QPMo=;
 b=SRI4dnKOF3WH2Na9OPeiS1WZJIRu4LBNGGLenPZHeE1vnS+v4/YD7r4cEcRNOPBFKR
 l+uTNo2Dk8snOf4ZHQhdQkmeqqJzMivqgjHRv3lNGjn8DjjZm/lV2L1tw9qGxL6acE1E
 v2x63CAGOuOX9q32GCFCEy+kwOahvmDp4L7qMRTwerpUut0rgHGuXa1HIW6H11TqDnzp
 d+eRhJU5IaVMu+KTjNOlSmFlSQwuoLPQnnFKPVibKqYal4ITeeGgSXA2cWQeUKfYB2Fk
 3CMhgFIyxwgGUEmSTLK8B97RIm+7CyCMv3iIth5cKl+eCruEoICKw2lK1Xqg049h+/3P
 e3tA==
X-Gm-Message-State: AOAM532v3dJN6AhklYPo6/QPTu74YXgy9p29TPxldrH02yf+29q8zXMe
 yhHuHxOjV+mwMcwR9KN2g+JusViL0gX/MdqX
X-Google-Smtp-Source: ABdhPJxDdDPLz6pnN2EdPnJZtOCGGKx5D2CqVKczAGyudOXMv7cDKrcwn/2erW/AKZLLkjwZZ7AcmA==
X-Received: by 2002:adf:9027:: with SMTP id h36mr15906849wrh.259.1600092444382; 
 Mon, 14 Sep 2020 07:07:24 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id x16sm20834041wrq.62.2020.09.14.07.07.23
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Sep 2020 07:07:23 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 36/36] MAINTAINERS: Add maintainer entry for Xilinx ZynqMP CAN
 controller
Date: Mon, 14 Sep 2020 15:06:41 +0100
Message-Id: <20200914140641.21369-37-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200914140641.21369-1-peter.maydell@linaro.org>
References: <20200914140641.21369-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42a.google.com
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

From: Vikram Garhwal <fnu.vikram@xilinx.com>

Reviewed-by: Francisco Iglesias <francisco.iglesias@xilinx.com>
Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
Signed-off-by: Vikram Garhwal <fnu.vikram@xilinx.com>
Message-id: 1597278668-339715-5-git-send-email-fnu.vikram@xilinx.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 MAINTAINERS | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 3d17cad19aa..3ed61d9354d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1557,6 +1557,14 @@ F: hw/net/opencores_eth.c
 
 Devices
 -------
+Xilinx CAN
+M: Vikram Garhwal <fnu.vikram@xilinx.com>
+M: Francisco Iglesias <francisco.iglesias@xilinx.com>
+S: Maintained
+F: hw/net/can/xlnx-*
+F: include/hw/net/xlnx-*
+F: tests/qtest/xlnx-can-test*
+
 EDU
 M: Jiri Slaby <jslaby@suse.cz>
 S: Maintained
-- 
2.20.1



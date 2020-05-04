Return-Path: <SRS0=Vgkn=6S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C91E9C47257
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 12:36:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 954FF206B9
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 12:36:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bBVV5K/e"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 954FF206B9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44728 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVaKR-0005DP-KP
	for qemu-devel@archiver.kernel.org; Mon, 04 May 2020 08:36:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56434)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jVaHl-0008Qa-A3
 for qemu-devel@nongnu.org; Mon, 04 May 2020 08:33:25 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333]:39699)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jVaHj-0000q0-PX
 for qemu-devel@nongnu.org; Mon, 04 May 2020 08:33:24 -0400
Received: by mail-wm1-x333.google.com with SMTP id y24so8844640wma.4
 for <qemu-devel@nongnu.org>; Mon, 04 May 2020 05:33:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=vtjkPyhN5yeFIjnyBTjjTJF6AHtmNmTLOfT5l6GiTkY=;
 b=bBVV5K/em7BHYx02L3js/CXFO1B2Fi/1g1iPyGRqyKhnuaCUVuf7+Glxdx61Pqhl5a
 ztsf14x4AvH1E8fvr4LkLWy5GGNseZ80Mrhn22yfj+ShNEk3sV5XIJ58EPllooToo+LC
 E+uijbRwoi5eK/xk3VkabGu4iixQ2xGE3lDS+VJ+YPVGdQ+OgzI3Mk01xVpr1n0Pprio
 /JHz3Gj3aZBD6fW7lh6Uh9tYbBs0Fx4uBIQPTxWcGMGDZSdJcZsb8RKGlAifn9bbn5/W
 pKtFyPvCueeQoAgK0RNpBn6S9Iorxznkil4kBOOjmGgOsYAaIf+JlnoeOEhbjIc83aSN
 6FdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=vtjkPyhN5yeFIjnyBTjjTJF6AHtmNmTLOfT5l6GiTkY=;
 b=NmkD1mL+4kKV3rKJQlS8bzVxAsZpewaxkBa0HzS7DBXB46mrY+WJ0CU7y87DT486cI
 ufIe5mU5tlT3Xd08mLcK2Qa8fElPhHDKttlL4zHHvywpvdCHGmmPEbzcEqnPCfdnvI5H
 GIcNqhyOJWnZm3dhlhdARNA5eXAhCgWxnyekyRUYR4J6YMHdcCTClhCX6Teo9yRd+kOf
 yI5Hw0f8bQ0Ht7asy5pHN3Z4nspUotdm4GmWn/jfNT0ryf1UKkV5Ltnlv3kJ2JGx0NnN
 OqXZYB4GLeDNtNGssxYlOGmWMwCB9Ghuzxwjjuv60Nivz7bK7Wm2evuleWFg/sf9iwMk
 S5YA==
X-Gm-Message-State: AGi0PuZAMrhpIsCidBSCI0XG8PB3kXE3u4IqW5aKyQrhpo80EJ/cy3L9
 oTxFKMJQfECUuU7brEe06th1kydFfRLLJQ==
X-Google-Smtp-Source: APiQypLxXaERK8ZstkZz2OcNGy1QtbAwcYaBpQGEqqlB3cSYTJkDrbMnRonAYRKZXX0e9cv1XgPzTw==
X-Received: by 2002:a1c:a58b:: with SMTP id o133mr14107234wme.5.1588595602137; 
 Mon, 04 May 2020 05:33:22 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id q4sm12253608wrx.9.2020.05.04.05.33.21
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 May 2020 05:33:21 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 09/39] hw/arm: versal: Remove inclusion of arm_gicv3_common.h
Date: Mon,  4 May 2020 13:32:39 +0100
Message-Id: <20200504123309.3808-10-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200504123309.3808-1-peter.maydell@linaro.org>
References: <20200504123309.3808-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x333.google.com
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>

Remove inclusion of arm_gicv3_common.h, this already gets
included via xlnx-versal.h.

Signed-off-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Luc Michel <luc.michel@greensocs.com>
Message-id: 20200427181649.26851-2-edgar.iglesias@gmail.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/xlnx-versal.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/hw/arm/xlnx-versal.c b/hw/arm/xlnx-versal.c
index 94460f2343b..c73b2fe7555 100644
--- a/hw/arm/xlnx-versal.c
+++ b/hw/arm/xlnx-versal.c
@@ -20,7 +20,6 @@
 #include "hw/arm/boot.h"
 #include "kvm_arm.h"
 #include "hw/misc/unimp.h"
-#include "hw/intc/arm_gicv3_common.h"
 #include "hw/arm/xlnx-versal.h"
 #include "hw/char/pl011.h"
 
-- 
2.20.1



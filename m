Return-Path: <SRS0=QiA4=7D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C6D4C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 19:29:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DD46A207D3
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 19:29:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ylVxpwfB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD46A207D3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34488 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbqsN-0003cb-2B
	for qemu-devel@archiver.kernel.org; Thu, 21 May 2020 15:29:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38122)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jbqgL-0002oh-Od
 for qemu-devel@nongnu.org; Thu, 21 May 2020 15:16:41 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430]:40796)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jbqgK-0000Sg-J7
 for qemu-devel@nongnu.org; Thu, 21 May 2020 15:16:41 -0400
Received: by mail-wr1-x430.google.com with SMTP id e16so7748309wra.7
 for <qemu-devel@nongnu.org>; Thu, 21 May 2020 12:16:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=HzaGK+GNMjQeyxh3y1RKSO5ioG6l1/+Q0BYaSnO5M+E=;
 b=ylVxpwfB5PcRRi1xYgO+VpFN1Xh9WOVw6z7LXPoJTgXgyX1bOcMx7lg8XmICpoAPrn
 i2trhR9NesHFM58V6uB+DC5Thrhx0Hcfy2c8ERKChAkI+1sLvdHmYqzGDLppAwUiufGH
 RpDa5KQNAA1SmuDwkxa4FiecWnzhIn9JmQOPLo54669GLGZ9az1F9CqoFBsOBtZ4iL7T
 ZmQuLvZzRk/S1gZupH7C0qyAwgX93pQ7CL79uZLLios2+Nn2KnKmiK3V5Y9sCd1UJWf7
 fMIc5Gvb3P9bqF4pujPLrQDuhpBx7+725CK7q6cItzVtITT18qeNTxDJUymvXQq0Nt0n
 e3rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=HzaGK+GNMjQeyxh3y1RKSO5ioG6l1/+Q0BYaSnO5M+E=;
 b=K5EK/p+zSsFlzDZG55VG8VfLup2mwVVlcvST6Bs7b1wVPFZqAXtSJcaEjRJ0XYReMV
 fDUxToNLBkWj5vQSXp5BnsB5YYa8r77LzbAk0iOlNJmn2aYauwCiM007BrinC/rQXSM+
 hrLDGgXQ74oJUshtAcB0o/mPpzjav+mTBIXD23k8eXES+Q+KsuQSo6+iRCTLs0heTcNX
 jXghH+obgMlJHrOinSqXGusBU6XMiqIlvxVUAUFakq+GXuRBcJhsQoDdiEsxk8hggcwa
 2huDnHssxPzDV+GWW6d1E4IxjmlBQyXQtYR5r3wj2USeKedcHWQ/uxwtEIMEGxqeYyNq
 E2Cg==
X-Gm-Message-State: AOAM530ByTvKtTtTuuwF/Cho/gdv01jFKNsUWXPFgmrjrm8MYD9zeF0v
 UHtyZHPymrq51RCvIPkzo3XXOpCz6YLiNw==
X-Google-Smtp-Source: ABdhPJzdETqamoNm9fUfJBrryWtqMHpokaNNhZRlFr92ysFtTcY7Pj82O7vHOSohmIeQdmxYwJ1bvg==
X-Received: by 2002:a5d:52c6:: with SMTP id r6mr79510wrv.269.1590088598848;
 Thu, 21 May 2020 12:16:38 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id z124sm7335100wmg.20.2020.05.21.12.16.37
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 May 2020 12:16:38 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 22/29] hw/char/xilinx_uartlite: Replace hw_error() by
 qemu_log_mask()
Date: Thu, 21 May 2020 20:16:03 +0100
Message-Id: <20200521191610.10941-23-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200521191610.10941-1-peter.maydell@linaro.org>
References: <20200521191610.10941-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x430.google.com
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

From: Philippe Mathieu-Daudé <f4bug@amsat.org>

hw_error() calls exit(). This a bit overkill when we can log
the accesses as unimplemented or guest error.

When fuzzing the devices, we don't want the whole process to
exit. Replace some hw_error() calls by qemu_log_mask().

Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-id: 20200518140309.5220-4-f4bug@amsat.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/char/xilinx_uartlite.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/hw/char/xilinx_uartlite.c b/hw/char/xilinx_uartlite.c
index c6512285d73..ae4ccd00c70 100644
--- a/hw/char/xilinx_uartlite.c
+++ b/hw/char/xilinx_uartlite.c
@@ -23,7 +23,7 @@
  */
 
 #include "qemu/osdep.h"
-#include "hw/hw.h"
+#include "qemu/log.h"
 #include "hw/irq.h"
 #include "hw/qdev-properties.h"
 #include "hw/sysbus.h"
@@ -135,7 +135,8 @@ uart_write(void *opaque, hwaddr addr,
     switch (addr)
     {
         case R_STATUS:
-            hw_error("write to UART STATUS?\n");
+            qemu_log_mask(LOG_GUEST_ERROR, "%s: write to UART STATUS\n",
+                          __func__);
             break;
 
         case R_CTRL:
-- 
2.20.1



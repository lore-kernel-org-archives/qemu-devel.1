Return-Path: <SRS0=/zFi=CU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94C80C433E2
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2020 19:35:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 33C202220D
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2020 19:35:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 33C202220D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48118 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kGop8-0004Vc-9x
	for qemu-devel@archiver.kernel.org; Fri, 11 Sep 2020 15:35:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44760)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1kGono-0002dA-Oc; Fri, 11 Sep 2020 15:33:44 -0400
Received: from mout.kundenserver.de ([212.227.126.130]:42009)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1kGonm-0000o0-UV; Fri, 11 Sep 2020 15:33:44 -0400
Received: from localhost.localdomain ([82.252.129.222]) by
 mrelayeu.kundenserver.de (mreue012 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1Mpkwn-1ksvug00JZ-00qD2F; Fri, 11 Sep 2020 21:33:39 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL 05/18] hw/gpio/max7310: Replace disabled printf() by
 qemu_log_mask(UNIMP)
Date: Fri, 11 Sep 2020 21:33:17 +0200
Message-Id: <20200911193330.1148942-6-laurent@vivier.eu>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200911193330.1148942-1-laurent@vivier.eu>
References: <20200911193330.1148942-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:6HHjcsMsC1UMVlJ9ehessa7IF8hgB8UCqK7rXrhkuKOysz/RmEt
 ndeSnj1EeH9C/m138K8ixt6mQzMQ5LNOE7grltRNgqF2cKvoRT31iWoSEhgRZk1+CBUhUr0
 NBkgcj+P7D9ygLIjaQUygMRDYMjxLPs5qcFDSlE2U7nPAVq7TJBZ+9f2W16P1kJ6mttKluR
 mUQv/yFW/weDU7VWT+7xw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:fkaGS7uf30Q=:piGLu2HK1rJYlZMDXKZj2L
 WR/ulubabyADErZVn2UR0uUgXMcPK1XdNnseIivoYVgFlZ1nyyGgmISOCtUKOhxWE26Ik+uyW
 RsUSDy7pb3Fqi/QK/+eraHP+MWLaXxOp5ED2klwEzgvNv5BLpkzus/xt09Y4TfVL1ryOFJqly
 3pJGDc+mD8JZmgFHTJnCu3ADiedl45bVtrskZkuspoXGZxdJ83fPrxnlORaog5YCCEoNVyDsZ
 DIBnarJWjxHNjzjzwAu7DCAzH93BezHe8QhsybdJsV/Qj4vF2252ieJeIl39XBpC/kFDZOort
 4zhvGwviW3Un/uFZUuqpt+HQ/nPrgG8GUqvx+WpFuupR+Qi8wqWvEyELYJfJ27SepWnODbO9h
 IMqpwokCm/cVQYUGrfEeH7mAjHEwfcm0gqL+LgrGd8nIHdzz9zEQDtB5jBx/v3U9giwzb6XX1
 2PYTL0xgjzaMK3sjRmYzPvtnLqRTLVIkDzR+Vm7ZdvygBzMoqillG3CW2ompvlzkZVSJa35+8
 luM+liCyyt9XXMTZ/L9U8mW85yzlEuG523cCzDmamkrE3LIxD4opOnSpeun7BalENj301+OEC
 gJusMwZKmr0WnBP3YmZpz9/xYF/ab819GEM7Hs7KKmIWp69hxgRKp19r/fwV1Iqh9ngkrr8qm
 5hITzj3K3DMhbxfJXzHzgOXqOk6zKe/mbi3y0mcLF7RRYvJ/Ko3wnr+fX6m8H5OagG3IssEzK
 nhTaQ++7xIVmak1fuoZD9JAbVl16HG2mRIlHFXaLMdXDUmUcy6LlJ7jXQPPnY58j1B8kc1THg
 xleFj3Qyjz68RajPqGiFepIBeyX0Qy7G07Fvs6rmDLVIgytNba1PtrOBqO+oNwU9EGcpdLk
Received-SPF: none client-ip=212.227.126.130; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/11 15:33:39
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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
Cc: qemu-trivial@nongnu.org, Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <f4bug@amsat.org>

Replace disabled printf() by qemu_log_mask(UNIMP).

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Message-Id: <20200901104234.92159-3-f4bug@amsat.org>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 hw/gpio/max7310.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/hw/gpio/max7310.c b/hw/gpio/max7310.c
index 4f78774dc8f2..3e298c2d349c 100644
--- a/hw/gpio/max7310.c
+++ b/hw/gpio/max7310.c
@@ -13,6 +13,7 @@
 #include "hw/hw.h"
 #include "hw/irq.h"
 #include "migration/vmstate.h"
+#include "qemu/log.h"
 #include "qemu/module.h"
 
 #define TYPE_MAX7310 "max7310"
@@ -68,9 +69,8 @@ static uint8_t max7310_rx(I2CSlave *i2c)
         return 0xff;
 
     default:
-#ifdef VERBOSE
-        printf("%s: unknown register %02x\n", __func__, s->command);
-#endif
+        qemu_log_mask(LOG_UNIMP, "%s: Unsupported register 0x02%" PRIx8 "\n",
+                      __func__, s->command);
         break;
     }
     return 0xff;
@@ -122,9 +122,8 @@ static int max7310_tx(I2CSlave *i2c, uint8_t data)
     case 0x00:	/* Input port - ignore writes */
         break;
     default:
-#ifdef VERBOSE
-        printf("%s: unknown register %02x\n", __func__, s->command);
-#endif
+        qemu_log_mask(LOG_UNIMP, "%s: Unsupported register 0x02%" PRIx8 "\n",
+                      __func__, s->command);
         return 1;
     }
 
-- 
2.26.2



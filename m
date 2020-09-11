Return-Path: <SRS0=/zFi=CU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB1B9C433E2
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2020 19:37:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 70FD122227
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2020 19:37:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 70FD122227
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57188 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kGorQ-0008Fx-GJ
	for qemu-devel@archiver.kernel.org; Fri, 11 Sep 2020 15:37:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44700)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1kGonn-0002Zk-1h; Fri, 11 Sep 2020 15:33:43 -0400
Received: from mout.kundenserver.de ([212.227.126.134]:33945)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1kGonj-0000ne-Sh; Fri, 11 Sep 2020 15:33:42 -0400
Received: from localhost.localdomain ([82.252.129.222]) by
 mrelayeu.kundenserver.de (mreue012 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MyNoa-1kShwq1D2q-00yhVm; Fri, 11 Sep 2020 21:33:36 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL 02/18] hw/isa/isa-bus: Replace hw_error() by assert()
Date: Fri, 11 Sep 2020 21:33:14 +0200
Message-Id: <20200911193330.1148942-3-laurent@vivier.eu>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200911193330.1148942-1-laurent@vivier.eu>
References: <20200911193330.1148942-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:T5tDDC6sn8sfomspzaRG6piVUoCJq/6+OY5a/NPxdgYZBZQMAQp
 4elPTyTwbRZw55Gpo1Ub6lkDCTWmxhQvWaveUsCC6z7Nd+XXS+2iCZHTQq+YFgjD5UP4bS2
 WgvrN9GJr/kDObO+EDeY4AtpRDTMZwJEVcUZP2wcC6YAEUfAZ/W+zmxLXPjVsO/ip4nSBFp
 SF4P5VOkc+2pB6TVc7caw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:7QDBlccRhQM=:lo18sON3JHGEEOcvvUxGa0
 87rpIorodcFlGL4dePZQMIR8vGmWF8oC2vEzwbEk+T+wVcnqHXm07aQrMCamlx4dONwuZaTqf
 Hoqds7Ztrjl3NOXG/YtiW2EO0AFOo9RuqRNwn1yzzOLcFhyw17kz4TWcx/OFl7yhn4Vq+Ju4t
 lxQGUSX/C58CY13IM5ATeSe8vR7YFLjY0IWnEEvZueX6/n27cHNqjNUtadW0C2AthGXMcGlTB
 U/vb22suJoAfflKGdSFXhBGZ1jKSNNts7hlgEQRZUHA9IudSYKIG76o5wa1e9qIXfknV5Dzqj
 kJ3dlkbf7U20YMTHozp7NoxiLiMGwMUJ7cyMcuO4DNmeVpCU3UvaGj//HzoefRT5Ap2wJBmXM
 2v/7m7EG4wsUFSX5NguULUXfYzhSPqwGxs3sYdOK+ESl2xnIMXthoaM10eb8yiwX2hEhZQMCU
 25Pod5+mnbkTRqrA9UKLhnNJAaEVkZKpo7gzMA0ITBYgF9WAYA+VmgRGt1K8NSX9wmW1TE6LK
 GJW/hCXFotSB5sMpTr4dKNyBUBXygyNRjAdd4Civ10VfbQ7WHEzuot/oPgJDkRD+A/qQ2yUFn
 4zZ19rjY5FEryEljZOxyo1IrR23HJAQrJSg1qdrUP1Xbnt0OcVq3WgBs1oqVKP/d1BTs3jLpc
 0Ov92a/aE6YfVjNtUXH1YK3deR71RadX1MFVslBBPscKtQtmuGZpAImyIz2h6B7z16/DFoey8
 xQrB1N/MtqCn7KvqRTcejE23dB1vlYxR5/XP5fo8upgd8zEE7ktC4dnn/mggtdyAqR9VHgJ7h
 jNLgaSHZyokKmQbL6V63Itd5OX6yXgTvMTbwtUvklxXbx2rewgp2vSDpRNMMB+VH8ROxU2R
Received-SPF: none client-ip=212.227.126.134; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/11 15:33:38
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
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
Cc: qemu-trivial@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <f4bug@amsat.org>

As we can never have more than ISA_NUM_IRQS (16) ISA IRQs,
replace the not very interesting hw_error() call by an
assert() which is more useful to debug condition that can
not happen.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20200901104043.91383-6-f4bug@amsat.org>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 hw/isa/isa-bus.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/hw/isa/isa-bus.c b/hw/isa/isa-bus.c
index 58fde178f92a..10bb7ffa43ae 100644
--- a/hw/isa/isa-bus.c
+++ b/hw/isa/isa-bus.c
@@ -21,7 +21,6 @@
 #include "qemu/error-report.h"
 #include "qemu/module.h"
 #include "qapi/error.h"
-#include "hw/hw.h"
 #include "monitor/monitor.h"
 #include "hw/sysbus.h"
 #include "sysemu/sysemu.h"
@@ -85,18 +84,14 @@ void isa_bus_irqs(ISABus *bus, qemu_irq *irqs)
 qemu_irq isa_get_irq(ISADevice *dev, unsigned isairq)
 {
     assert(!dev || ISA_BUS(qdev_get_parent_bus(DEVICE(dev))) == isabus);
-    if (isairq >= ISA_NUM_IRQS) {
-        hw_error("isa irq %d invalid", isairq);
-    }
+    assert(isairq < ISA_NUM_IRQS);
     return isabus->irqs[isairq];
 }
 
 void isa_init_irq(ISADevice *dev, qemu_irq *p, unsigned isairq)
 {
     assert(dev->nirqs < ARRAY_SIZE(dev->isairq));
-    if (isairq >= ISA_NUM_IRQS) {
-        hw_error("isa irq %d invalid", isairq);
-    }
+    assert(isairq < ISA_NUM_IRQS);
     dev->isairq[dev->nirqs] = isairq;
     *p = isa_get_irq(dev, isairq);
     dev->nirqs++;
-- 
2.26.2



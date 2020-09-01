Return-Path: <SRS0=/2J2=CK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C654C433E7
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 14:16:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D3D44206CD
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 14:16:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D3D44206CD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58876 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kD74r-0000sp-TI
	for qemu-devel@archiver.kernel.org; Tue, 01 Sep 2020 10:16:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55166)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1kD6zI-0005LE-Ih; Tue, 01 Sep 2020 10:10:16 -0400
Received: from mout.kundenserver.de ([212.227.126.130]:45563)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1kD6zD-0003l8-Nd; Tue, 01 Sep 2020 10:10:16 -0400
Received: from localhost.localdomain ([82.252.135.186]) by
 mrelayeu.kundenserver.de (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1Mbj3e-1kibFR45Es-00dFHH; Tue, 01 Sep 2020 16:10:08 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL 16/44] hw/core/sysbus: Assert memory region index is in range
Date: Tue,  1 Sep 2020 16:09:26 +0200
Message-Id: <20200901140954.889743-17-laurent@vivier.eu>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200901140954.889743-1-laurent@vivier.eu>
References: <20200901140954.889743-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:149LN1V/RMSGZ8p3pJ/g9b9ZhYU537JP7fHyZGEDMZOFqj9ZGZ/
 NctFfN+D2CtKOCvqfsb6x+/jGSsSsf15zaFQMH8Z0NY+clSRG0h2Q6+c/3hwpeTBMf6LjB3
 +6VWnccFR5Han2e3XSF7Id6ODDD51ax+YPSa/pdHysfXLKqq+dKOX7D9LVv9RPMPuf3p9vz
 afSR0JEFsYxlENbZwx9UA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:duVrdT9jwb4=:rbpIf78QnKAO72HMFuhKyw
 ELHTYNbCZRDaj+GOgZXTvf2WM68/E8Ji6ZfOb9CkeiTIXTacOROXFnCbS1lM8J7W20m+T2X9e
 FLIrBqy5o7Sb7duxutPZ5eeL6NCQQG4HII+zifxLwK6iJSHyneMF+1CfKtcBTMyNNik9rDnGo
 sabj52V0Eg4QXf7c5RFVw1u8g5q77bThUWn93lRtX8wxDq6o+iAutV1lw/9l9o6F5foVD0ZDn
 45N30B3mV3p8f219MbHXww4o+T9n7xtiDq0s/qi55ssMweCJSe2ebgVN6bAEb7SxKLEssZF0J
 6f5PG6x9oTJZcPxmGuE4Lz6eS8VcSsMqFFfgGKdScV42RkqLA7tUqPeCoYbfYyfYUQtRWEA68
 hfNmaLOse7bpmWE9jXt/puQZXf1PPxJIS4PdLb52lFS5uuTLFV9L8Nw7KEyxDAGArPPPxqbEQ
 ak4bPLlLITQoWpHTZykM5yQN6zrTyiLHpDwCGEOqNLH2AQjw8bQWSp1fc29xWPUcIyZeqoygv
 gHWNsgBaeXh/Wr3QQp0diR8Snc56fhLv9iS6u95XgjXTTH9z7QgusyA2FB3NUQmoofPJxrdXJ
 j2EKPcrJT5u1l+p5G8ZUsdo39IGvXgXtwQblonuXpvuIZUaDFBB3Ia/IvKlYLbcOLrId0nc9V
 kgU8gCoKP3YHifc0yMuDrtJMdMvcl5u47R3UdlyTlr44SphMA9jEiCx8w/X3vO8dXJMnEYkxE
 xZeoKPKCi3KNw1xGxxujUwW5eb2lATxHLH87dRxye3YuzEGH/KdY49qMQ9aO4J5Q6EOxGC4dW
 jktD3AfNHtRx9CTX2Pj2vclUYDHElx/i3Z91rhVt4uAeqBdWs9YncUoNjUygXOJSfPtEPHO
Received-SPF: none client-ip=212.227.126.130; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/01 10:10:08
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
Cc: qemu-trivial@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <f4bug@amsat.org>

Devices incorrectly modelled might use invalid index while
calling sysbus_mmio_get_region(), leading to OOB access.
Help developers by asserting the index is in range.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20200806130945.21629-3-f4bug@amsat.org>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 hw/core/sysbus.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/core/sysbus.c b/hw/core/sysbus.c
index 77ab351ce1a8..294f90b7deef 100644
--- a/hw/core/sysbus.c
+++ b/hw/core/sysbus.c
@@ -199,6 +199,7 @@ void sysbus_init_mmio(SysBusDevice *dev, MemoryRegion *memory)
 
 MemoryRegion *sysbus_mmio_get_region(SysBusDevice *dev, int n)
 {
+    assert(n >= 0 && n < QDEV_MAX_MMIO);
     return dev->mmio[n].memory;
 }
 
-- 
2.26.2



Return-Path: <SRS0=MBD3=C4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 635D4C43464
	for <qemu-devel@archiver.kernel.org>; Sat, 19 Sep 2020 18:47:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C77B020874
	for <qemu-devel@archiver.kernel.org>; Sat, 19 Sep 2020 18:47:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C77B020874
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39654 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kJhtP-0007zs-Ls
	for qemu-devel@archiver.kernel.org; Sat, 19 Sep 2020 14:47:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51760)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1kJhrC-0005vw-A7; Sat, 19 Sep 2020 14:45:10 -0400
Received: from mout.kundenserver.de ([212.227.126.131]:58745)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1kJhr9-0001Ix-4J; Sat, 19 Sep 2020 14:45:09 -0400
Received: from localhost.localdomain ([82.252.129.222]) by
 mrelayeu.kundenserver.de (mreue012 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MHmuE-1kDgEq0RaI-00EwR4; Sat, 19 Sep 2020 20:45:02 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL 01/17] hw/gpio/max7310: Remove impossible check
Date: Sat, 19 Sep 2020 20:44:35 +0200
Message-Id: <20200919184451.2129349-2-laurent@vivier.eu>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200919184451.2129349-1-laurent@vivier.eu>
References: <20200919184451.2129349-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:EyxM392So1fu6050ScU6cNHvupY9nlc9jRJzbI/5EHVPbpIOlLJ
 ufI/9ZDlvuX+WMPq7eIRanHxvi8ab+CTsPMW8vIMMJjh0kGoSLSiG0zO34YzptGOz80r14S
 3O38CgSqnOH8HQSmEfhvAFouEBU5DSAq4F0bg/2VuqYMZ0T+JfXiym9C88JAQdPIGj2tH5T
 cnYje+1oWZRpf5vDcchOA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:kE7iPQC3Dqk=:Gp12VuHmF8Zu7T0sms0h1g
 P5vdVg2fOGdaqotczCDLksLKURbcYI492MBEzKBwV06uRdXF72lxs+EWuYN6xNm9Tri4jopDT
 zuURX/KzExMAD+PXWDrACW4cF62Wpzi0tnGl9ztX6R0kSwlp+PSEkAM9EwVUe51LYC1vLtqJw
 H1y1tUoV2bM5yvbSbDo4W1Q84TNFPzYXjRthYW7knQaNnLjh3mPvwkOMF5z3te1Xc04Lyng+Q
 PArxde7rBSdFVdy+PLfqiwWMx3b3F/SywOYcwmaKZzFUiSRjYGyR5CiGfrQXQplQfvhSP6EJw
 vKZf1i0ekgCLYRbzdk2M15mRuCCiQZrYFgF/1Hg/kFYJjeTt85fIDF0WKvOgbJB4dIIZAJvGM
 OFeqORn1gzY3KiU0bQe4e2rRwLXRMLBaOznA7YprQXlB+W65SvHfQovRZfT4cabgcI1qGiFiQ
 wJdH47wqMnGl3HaHTDNVykJTtTDYkZduB6cn4t5ZAhMhHwjbK9NJiAEEFheV5M1J445rGisYg
 +gMB6FI45s9hWlpOWxwUt9wQlDh0yPDtNCDmudGMqGzsF5fr+8SPWIyKsDlZxQoxbLzjH4SS1
 vwMwCNQ2UGndZSfiJxiUiPwd1sSubhebYWIyJI2th+9wb9bseOUjjjlduAeZakwNZPr5y/JDn
 a04fDCHet7l239XrpVhoyE1O4kcFRy2K3+A9ORz0fVgruecssxvKqBLKd/E9fYAlJ8oLXXE4s
 CihVuM/4L579AFAyWWlSJ7vWAZ1vPASWe2PxOwed+J9GvGrBlna2FZXOcw03FyJUqz8RTZfvB
 ozd48+ZSx4SXUFppxjOpeCtVMm88c27qlj1n6ht4IzNc3GESNVTZlRFPO4lZHF3I6e96E8Y
Received-SPF: none client-ip=212.227.126.131; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/19 14:45:05
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-trivial@nongnu.org,
 Michael Tokarev <mjt@tls.msk.ru>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <f4bug@amsat.org>

The max7310_gpio_set() handler is static and only used by
qdev_init_gpio_in, initialized with 8 IRQs. The 'line'
argument can not be out of the [0-8[ range.
Replace the dead code by an assertion.

Suggested-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20200910072325.439344-2-f4bug@amsat.org>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 hw/gpio/max7310.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/hw/gpio/max7310.c b/hw/gpio/max7310.c
index 2888d071ac6b..de375892ef11 100644
--- a/hw/gpio/max7310.c
+++ b/hw/gpio/max7310.c
@@ -8,9 +8,7 @@
  */
 
 #include "qemu/osdep.h"
-#include "hw/hw.h"
 #include "hw/i2c/i2c.h"
-#include "hw/hw.h"
 #include "hw/irq.h"
 #include "migration/vmstate.h"
 #include "qemu/log.h"
@@ -175,8 +173,7 @@ static const VMStateDescription vmstate_max7310 = {
 static void max7310_gpio_set(void *opaque, int line, int level)
 {
     MAX7310State *s = (MAX7310State *) opaque;
-    if (line >= ARRAY_SIZE(s->handler) || line  < 0)
-        hw_error("bad GPIO line");
+    assert(line >= 0 && line < ARRAY_SIZE(s->handler));
 
     if (level)
         s->level |= s->direction & (1 << line);
-- 
2.26.2



Return-Path: <SRS0=wemX=7X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3343C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 13:21:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C716D2072E
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 13:21:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C716D2072E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35502 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jj0f7-0005Sc-V4
	for qemu-devel@archiver.kernel.org; Wed, 10 Jun 2020 09:21:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45180)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1jj0Ut-0007ox-5u; Wed, 10 Jun 2020 09:10:27 -0400
Received: from mout.kundenserver.de ([212.227.126.131]:60575)
 by eggs.gnu.org with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1jj0Ur-0003gG-W3; Wed, 10 Jun 2020 09:10:26 -0400
Received: from localhost.localdomain ([82.252.135.106]) by
 mrelayeu.kundenserver.de (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MZkxj-1jOsnZ13xf-00WoKz; Wed, 10 Jun 2020 15:10:22 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL v2 13/16] target/unicore32: Replace DPRINTF() by
 qemu_log_mask(GUEST_ERROR)
Date: Wed, 10 Jun 2020 15:10:08 +0200
Message-Id: <20200610131011.1941209-14-laurent@vivier.eu>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200610131011.1941209-1-laurent@vivier.eu>
References: <20200610131011.1941209-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:9HfJrvfO+i3nrbxBCmnsBWWUGVvBPEiDsT6jc51M9j0dYoRioSV
 wbheNYm6h88m2fHXRE5tcAeFNXJglFSKVcqc47mJeuXM2x6p9G5ZIY03kTbOE+XbN3SsR0Q
 +8aTi7oc0qnVaX9TJ4bzJi5Tdo4eJXITW50UwiTkKp9kdQr6DXPbttl8mwZ8RsKVPgg1dSG
 gMltdRkAEkJm7WDn3ybiQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:R3QjNgjxlbI=:XPfO0DPGtJSmkOpd0xfsXf
 1nmYZOqXdEzjXuIHf6X7AOl52UM3GEMgHLmqeuIsJ1aMghV7CgIuKCXR7UBDZ9rh/C8fYzkTn
 Kd1dRBV/OjUuQUXC6zSlHWMAjvKFnfn1aB/iDU8v8ivG5cI9ugubGn/k5iI8S7CJbspR+OuFM
 oGjg/fOTsHVqVzAJpNjo6F6k5NVYGsrMIIJI5bDHujU33ePLleYbkgqQDlHNn557qkPcxR5mS
 3wTUHLhkFAC6UrfSotgBj5MeX/OJM7081ncRwkedj9dNbcpwctwQyBaeoMPDnYy6wpOzUVEN4
 hvZPmLEmoC5GjNSPyxe28uVgfl+hbye6BupYJlEWe+4PGoGCY/d5KN+hWYqySSdewLklhdrVi
 IFYuP64gZTKxe2NRFLq3gLQRa/iTFoiO7qHMwgvgv9l5p7JV5dMx93vGm/szxqN+4P907KH9O
 vM5pCk6+AwgB2dE9AchuRhNWWFJZQqDa80DDugnZjGV+VGn7qiqDUJ+s8S4t2IrgOZ7L/Gz/2
 0JXuMq6wlajWp89EhyFUcleGqYKS9WrEdsCmYlV08nJKD2E2RVt3bodpqni/so4NyFs8ZjRhx
 EQ7ZpuXxcPc13R2fhsTREQSCbAxdZO+S0ReXfq3pV1LmMXm1smXFFkDc2MlREpxQGVPXW6nnd
 kfS/ruErvXURnXg7yQ3E/Rb84I/EzkUqUjN+0+KwKoLp62DvIv/hxQJPwplq+wRRKp/bUpgfW
 OKtQqNcZTQz3J0RnAH8ovueeTRoYl8/JUCk6VokU47IzErkAUSOglgJ4UJ5ZRqDNwpb1Isa7g
 9ZHSP7yTrGsxySz4LMgRfbZGYA18lkvEEPgcb/049Zpqet9wJpDa5RQ6x8C/o+pIVR0JyNy
Received-SPF: none client-ip=212.227.126.131; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/10 09:10:24
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=_AUTOLEARN
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
 Michael Tokarev <mjt@tls.msk.ru>, Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <f4bug@amsat.org>

Replace disabled DPRINTF() by qemu_log_mask(GUEST_ERROR).

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20200603123754.19059-3-f4bug@amsat.org>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 target/unicore32/helper.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/target/unicore32/helper.c b/target/unicore32/helper.c
index 53292ae311c1..00371a7da660 100644
--- a/target/unicore32/helper.c
+++ b/target/unicore32/helper.c
@@ -10,6 +10,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/log.h"
 #include "cpu.h"
 #include "exec/exec-all.h"
 #include "exec/helper-proto.h"
@@ -106,8 +107,9 @@ void helper_cp0_set(CPUUniCore32State *env, uint32_t val, uint32_t creg,
     }
     return;
 unrecognized:
-    DPRINTF("Wrong register (%d) or wrong operation (%d) in cp0_set!\n",
-            creg, cop);
+    qemu_log_mask(LOG_GUEST_ERROR,
+                  "Wrong register (%d) or wrong operation (%d) in cp0_set!\n",
+                  creg, cop);
 }
 
 uint32_t helper_cp0_get(CPUUniCore32State *env, uint32_t creg, uint32_t cop)
@@ -153,8 +155,9 @@ uint32_t helper_cp0_get(CPUUniCore32State *env, uint32_t creg, uint32_t cop)
         }
         break;
     }
-    DPRINTF("Wrong register (%d) or wrong operation (%d) in cp0_set!\n",
-            creg, cop);
+    qemu_log_mask(LOG_GUEST_ERROR,
+                  "Wrong register (%d) or wrong operation (%d) in cp0_set!\n",
+                  creg, cop);
     return 0;
 }
 
-- 
2.26.2



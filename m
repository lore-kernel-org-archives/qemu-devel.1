Return-Path: <SRS0=wemX=7X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81ED9C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 13:21:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 588D02072E
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 13:21:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 588D02072E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37154 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jj0fS-00068t-HK
	for qemu-devel@archiver.kernel.org; Wed, 10 Jun 2020 09:21:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45218)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1jj0Uw-0007vx-Oj; Wed, 10 Jun 2020 09:10:30 -0400
Received: from mout.kundenserver.de ([212.227.126.187]:42261)
 by eggs.gnu.org with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1jj0Ur-0003gU-W3; Wed, 10 Jun 2020 09:10:30 -0400
Received: from localhost.localdomain ([82.252.135.106]) by
 mrelayeu.kundenserver.de (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1M7JvQ-1jqgWe1TJM-007lDC; Wed, 10 Jun 2020 15:10:20 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL v2 10/16] hw/i386/xen/xen-hvm: Use the IEC binary prefix
 definitions
Date: Wed, 10 Jun 2020 15:10:05 +0200
Message-Id: <20200610131011.1941209-11-laurent@vivier.eu>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200610131011.1941209-1-laurent@vivier.eu>
References: <20200610131011.1941209-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:IEDhWYW0eQduXnGN0tnW7BZO0Q+G0Yju7m2j6zdh416rKnGbwdZ
 ukI6dP2lbLLC8C2M/C8QSJvFq7tWCGMgZyIjPXy1kj7qQ7gfaO1MzjmttTeU9kEv7jvWL4C
 XC26sCiRAGHTdviQMkyxcMliHP1rfLcjH35q2L6EahyBFSyt5wk65t2Zb1ut1t5ZlUyM2M/
 z3YJzhlcnHBfpT8MWWbxw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:pKpmjdCHzV4=:EJ8YnXEuVca/8RsOmqNtG1
 UY/3dZwXsZZA7QBiBcbGAkbhsIYpJrl8U0MtZv5c1+Llnp8zFH40ZLSxIr+IfRKBgNgdhGYau
 1RUudGneSMkiLchGB4mOPHOJX8O0agjS1T8X2OqfXKctqGM9BgNFHY6E+nT/uqDuxKwLdVoUx
 nwJ1WYqGrfLvjRl3BYADsIg9y8YWR5YjPjQ7Fa8V1AzbZHAm1EqL77VZZ1Fg9vs1qL7F9TwYb
 fiVVZBG90V/qm8TukXrvrNDnZ60TeJMcteOIUW35wV/6lUdkteDHbhgf3H03W/Ie7yES26oGV
 7HCmjaFwyWSZ189c3A0HnXFzmDOmAzyVRJb5zCeeMiwtsQVhJgphpisZFkb3MoDHLndvDeEw4
 S68HrKzOtPRYUg2QrH9/VVa+T3VfPCKRilsez+OWWtOOuetH6Aq5zNUWGFcFl8G+TiGP3iIp6
 K+QkrRKTTYcNIL5KN20Jx3REdne1wrjaWdhUhY8ihT35g1NxRZoDrLLfKacGofp2ReUctSv97
 733SQe3a0SY2V/OFYi3gDnlEjkYz1mfsXjZenFplwbIAm1iNyyJgt/1y0LxRO3ne7HQAb1oYD
 W6w8ry7xeQdwaP62WPilt1TN088yTVwWorukIhaqI3mgUHCOZ+ciS1NhxS/dVL9vZXwOZ8qi2
 1XmAlTOsLgJXIP77l2ZpezjNt+eKMyn8m2Q+BB37pCtZ5TItq6pd5dcVnOeSCz18ym8V6TYi0
 +aBrQveygEV13avz1/olHgoS3cTl0+z4cFpz9D9K8fWegRj3IH3wcAgAT/bKohpx7doaG9HzP
 J9o1AIHO/3dI6OzJL1m1B9+GyGVOUrgh+PcGh3JPoLEgqOKtyhQ2XSJvQiKF/4hCfXOwUew
Received-SPF: none client-ip=212.227.126.187; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/10 09:10:15
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Paul Durrant <paul@xen.org>,
 qemu-trivial@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>, Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <f4bug@amsat.org>

IEC binary prefixes ease code review: the unit is explicit.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Paul Durrant <paul@xen.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20200601142930.29408-8-f4bug@amsat.org>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 hw/i386/xen/xen-hvm.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/i386/xen/xen-hvm.c b/hw/i386/xen/xen-hvm.c
index 82ece6b9e739..94fe5d65e9fd 100644
--- a/hw/i386/xen/xen-hvm.c
+++ b/hw/i386/xen/xen-hvm.c
@@ -9,6 +9,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/units.h"
 
 #include "cpu.h"
 #include "hw/pci/pci.h"
@@ -230,7 +231,7 @@ static void xen_ram_init(PCMachineState *pcms,
          * Xen does not allocate the memory continuously, it keeps a
          * hole of the size computed above or passed in.
          */
-        block_len = (1ULL << 32) + x86ms->above_4g_mem_size;
+        block_len = (4 * GiB) + x86ms->above_4g_mem_size;
     }
     memory_region_init_ram(&ram_memory, NULL, "xen.ram", block_len,
                            &error_fatal);
-- 
2.26.2



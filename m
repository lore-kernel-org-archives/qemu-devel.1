Return-Path: <SRS0=k4hX=CF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B8DBC433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2020 12:40:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D79A122B40
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2020 12:39:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D79A122B40
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=users.sourceforge.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38804 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBHCB-0001Bd-2f
	for qemu-devel@archiver.kernel.org; Thu, 27 Aug 2020 08:39:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58920)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ysato@users.sourceforge.jp>)
 id 1kBHBQ-0007xM-Q9
 for qemu-devel@nongnu.org; Thu, 27 Aug 2020 08:39:12 -0400
Received: from mail03.asahi-net.or.jp ([202.224.55.15]:39213)
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <ysato@users.sourceforge.jp>) id 1kBHBN-0005uW-Ut
 for qemu-devel@nongnu.org; Thu, 27 Aug 2020 08:39:12 -0400
Received: from sakura.ysato.name (ik1-413-38519.vs.sakura.ne.jp
 [153.127.30.23]) (Authenticated sender: PQ4Y-STU)
 by mail03.asahi-net.or.jp (Postfix) with ESMTPA id C66D52703C;
 Thu, 27 Aug 2020 21:39:06 +0900 (JST)
Received: from yo-satoh-debian.localdomain (ZM005235.ppp.dion.ne.jp
 [222.8.5.235])
 by sakura.ysato.name (Postfix) with ESMTPSA id 7DB941C0792;
 Thu, 27 Aug 2020 21:39:06 +0900 (JST)
From: Yoshinori Sato <ysato@users.sourceforge.jp>
To: qemu-devel@nongnu.org
Subject: [PATCH 07/20] hw/rx: RX62N convert new 8bit timer.
Date: Thu, 27 Aug 2020 21:38:46 +0900
Message-Id: <20200827123859.81793-8-ysato@users.sourceforge.jp>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200827123859.81793-1-ysato@users.sourceforge.jp>
References: <20200827123859.81793-1-ysato@users.sourceforge.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: softfail client-ip=202.224.55.15;
 envelope-from=ysato@users.sourceforge.jp; helo=mail03.asahi-net.or.jp
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/27 08:39:06
X-ACL-Warn: Detected OS   = ???
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_LOW=-0.7,
 SPF_HELO_NONE=0.001, SPF_SOFTFAIL=0.665 autolearn=no autolearn_force=no
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
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>
---
 include/hw/rx/rx62n.h | 4 ++--
 hw/rx/rx62n.c         | 2 +-
 hw/rx/Kconfig         | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/hw/rx/rx62n.h b/include/hw/rx/rx62n.h
index e0ca1cfc33..75945bae50 100644
--- a/include/hw/rx/rx62n.h
+++ b/include/hw/rx/rx62n.h
@@ -26,7 +26,7 @@
 
 #include "target/rx/cpu.h"
 #include "hw/intc/rx_icu.h"
-#include "hw/timer/renesas_tmr.h"
+#include "hw/timer/renesas_tmr8.h"
 #include "hw/timer/renesas_cmt.h"
 #include "hw/char/renesas_sci.h"
 #include "hw/rx/rx62n-cpg.h"
@@ -68,7 +68,7 @@ typedef struct RX62NState {
 
     RXCPU cpu;
     RXICUState icu;
-    RTMRState tmr[RX62N_NR_TMR];
+    RenesasTMR8State tmr[RX62N_NR_TMR];
     RCMTState cmt[RX62N_NR_CMT];
     RSCIState sci[RX62N_NR_SCI];
     RX62NCPGState cpg;
diff --git a/hw/rx/rx62n.c b/hw/rx/rx62n.c
index ec63fa5db1..0223396110 100644
--- a/hw/rx/rx62n.c
+++ b/hw/rx/rx62n.c
@@ -149,7 +149,7 @@ static void register_tmr(RX62NState *s, int unit)
     char ckname[16];
 
     object_initialize_child(OBJECT(s), "tmr[*]",
-                            &s->tmr[unit], TYPE_RENESAS_TMR);
+                            &s->tmr[unit], TYPE_RENESAS_TMR8);
     tmr = SYS_BUS_DEVICE(&s->tmr[unit]);
 
     irqbase = RX62N_TMR_IRQ + TMR_NR_IRQ * unit;
diff --git a/hw/rx/Kconfig b/hw/rx/Kconfig
index a63e4a5520..0406f27bee 100644
--- a/hw/rx/Kconfig
+++ b/hw/rx/Kconfig
@@ -1,7 +1,7 @@
 config RX62N_MCU
     bool
     select RX_ICU
-    select RENESAS_TMR
+    select RENESAS_TMR8
     select RENESAS_CMT
     select RENESAS_SCI
 
-- 
2.20.1



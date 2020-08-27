Return-Path: <SRS0=k4hX=CF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77E18C433E1
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2020 12:44:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 499AC2177B
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2020 12:44:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 499AC2177B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=users.sourceforge.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58590 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBHGB-0000mr-F0
	for qemu-devel@archiver.kernel.org; Thu, 27 Aug 2020 08:44:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59068)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ysato@users.sourceforge.jp>)
 id 1kBHBV-00087P-D0
 for qemu-devel@nongnu.org; Thu, 27 Aug 2020 08:39:17 -0400
Received: from mail01.asahi-net.or.jp ([202.224.55.13]:47908)
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <ysato@users.sourceforge.jp>) id 1kBHBR-0005xg-F8
 for qemu-devel@nongnu.org; Thu, 27 Aug 2020 08:39:16 -0400
Received: from sakura.ysato.name (ik1-413-38519.vs.sakura.ne.jp
 [153.127.30.23]) (Authenticated sender: PQ4Y-STU)
 by mail01.asahi-net.or.jp (Postfix) with ESMTPA id F28311086DC;
 Thu, 27 Aug 2020 21:39:07 +0900 (JST)
Received: from yo-satoh-debian.localdomain (ZM005235.ppp.dion.ne.jp
 [222.8.5.235])
 by sakura.ysato.name (Postfix) with ESMTPSA id B20451C0696;
 Thu, 27 Aug 2020 21:39:07 +0900 (JST)
From: Yoshinori Sato <ysato@users.sourceforge.jp>
To: qemu-devel@nongnu.org
Subject: [PATCH 12/20] hw/rx/rx62n: Use New SCI module.
Date: Thu, 27 Aug 2020 21:38:51 +0900
Message-Id: <20200827123859.81793-13-ysato@users.sourceforge.jp>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200827123859.81793-1-ysato@users.sourceforge.jp>
References: <20200827123859.81793-1-ysato@users.sourceforge.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: softfail client-ip=202.224.55.13;
 envelope-from=ysato@users.sourceforge.jp; helo=mail01.asahi-net.or.jp
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
 include/hw/rx/rx62n.h | 2 +-
 hw/rx/rx62n.c         | 7 ++++++-
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/include/hw/rx/rx62n.h b/include/hw/rx/rx62n.h
index 1182ca24de..f463148799 100644
--- a/include/hw/rx/rx62n.h
+++ b/include/hw/rx/rx62n.h
@@ -70,7 +70,7 @@ typedef struct RX62NState {
     RXICUState icu;
     RenesasTMR8State tmr[RX62N_NR_TMR];
     RenesasCMTState cmt[RX62N_NR_CMT];
-    RSCIState sci[RX62N_NR_SCI];
+    RSCIAState sci[RX62N_NR_SCI];
     RX62NCPGState cpg;
 
     MemoryRegion *sysmem;
diff --git a/hw/rx/rx62n.c b/hw/rx/rx62n.c
index 0223396110..f61383a4c2 100644
--- a/hw/rx/rx62n.c
+++ b/hw/rx/rx62n.c
@@ -191,11 +191,13 @@ static void register_sci(RX62NState *s, int unit)
 {
     SysBusDevice *sci;
     int i, irqbase;
+    char ckname[16];
 
     object_initialize_child(OBJECT(s), "sci[*]",
-                            &s->sci[unit], TYPE_RENESAS_SCI);
+                            &s->sci[unit], TYPE_RENESAS_SCIA);
     sci = SYS_BUS_DEVICE(&s->sci[unit]);
     qdev_prop_set_chr(DEVICE(sci), "chardev", serial_hd(unit));
+    qdev_prop_set_uint32(DEVICE(sci), "unit", unit);
     sysbus_realize(sci, &error_abort);
 
     irqbase = RX62N_SCI_IRQ + SCI_NR_IRQ * unit;
@@ -203,6 +205,9 @@ static void register_sci(RX62NState *s, int unit)
         sysbus_connect_irq(sci, i, s->irq[irqbase + i]);
     }
     sysbus_mmio_map(sci, 0, RX62N_SCI_BASE + unit * 0x08);
+    snprintf(ckname, sizeof(ckname), "pck_sci-%d", unit);
+    qdev_connect_clock_in(DEVICE(sci), "pck",
+                          qdev_get_clock_out(DEVICE(&s->cpg), ckname));
 }
 
 static void register_cpg(RX62NState *s)
-- 
2.20.1



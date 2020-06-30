Return-Path: <SRS0=gXk/=AL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2BB3C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 20:22:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 997F1206B6
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 20:22:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="ePhuPiMw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 997F1206B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36388 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqMm5-0006q0-TM
	for qemu-devel@archiver.kernel.org; Tue, 30 Jun 2020 16:22:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58996)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=44328bdba=alistair.francis@wdc.com>)
 id 1jqMl5-0005Tx-Ey; Tue, 30 Jun 2020 16:21:35 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:36486)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=44328bdba=alistair.francis@wdc.com>)
 id 1jqMl1-0007ik-2Z; Tue, 30 Jun 2020 16:21:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1593548491; x=1625084491;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=ojAhTAodAG171f5PlmTZAafllSlW13AZrgcMFIZqJxY=;
 b=ePhuPiMwnWZXVQlajEUnNzdYzpMh0ezG0fo8u7VudGHZ5M0dorBNHlkL
 rcmLZTEr2ZFjH20deWdbYloAX6omDxmwjlhOQ27r0h3DQEt29oissmJ4J
 Glw7skxJ7gRr06r6dXVEcuASHs2ZDb5EWPpXzQe6WEQQ3B3ZvVILs05gs
 r4ag0EDW7YOhStQ9ucCu2r1KDCQyUP062+tdMIYvS4QYVKK5FNMS239mg
 Jf3FQSN/T71aT6hwsHU0erdFnfu0Rxb8kvUGZFQWTdu+S633wm884SZPm
 T9oI1E+aRcfh4ixo0HWpFgPPtXTDrD9+zxzLRk4TwsNOhyS/9inwK6r/a Q==;
IronPort-SDR: hQ837rPzfPZg46bTPco8TElKJ8tGkGTdJh8q0tO0BnTsvR4kPG+JgepiSpEcfl7i4ql6wos8O0
 bqJs49MDiZJI0/88QdQPJi6NLoXBk6iT4TXKT/pf6JzvlGTr7bI/cMpa/oWntdObHrB7TaJrQM
 HfPwpiVzwL6cq/GGvZYAcnMmKfhk/DYJX/zXHoDG1v2oAsBzlo/iHEwrB92rr4KBS4Q2+lEUuc
 96oRilcnNmtwAae36lIVCE3AesFVztNomdIPiseYaMXBr9CWEXhlKKyCHlngnsnKZW6DCeiWrD
 NQs=
X-IronPort-AV: E=Sophos;i="5.75,298,1589212800"; d="scan'208";a="142665038"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 01 Jul 2020 04:21:26 +0800
IronPort-SDR: 5T7PBfVB+rQFPXV2CwE4Xnz1rwKXvVoSFpugjpSfL+nKHKz9tK3YYJoevbloc0FLyu6MbePTdW
 xISKMoGKGKDbliAJLp1dku6HsRQNcJjc0=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Jun 2020 13:10:17 -0700
IronPort-SDR: mXd4yNBGp1KnYr7ioxBmhoI/Ef6AEME2Z0bhcOfrURAPcJut4Ze/u1k3yIjOuDo6v9KnTKds6C
 0hXd6A1cWvYA==
WDCIronportException: Internal
Received: from us6fgspc2.ad.shared (HELO risc6-mainframe.hgst.com)
 ([10.86.58.109])
 by uls-op-cesaip01.wdc.com with ESMTP; 30 Jun 2020 13:21:27 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [PATCH v1 1/3] hw/char: Convert the Ibex UART to use the qdev Clock
 model
Date: Tue, 30 Jun 2020 13:12:08 -0700
Message-Id: <bd1e09bc3c721bf92e3f0e3e260d0f548acbce8f.1593547870.git.alistair.francis@wdc.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1593547870.git.alistair.francis@wdc.com>
References: <cover.1593547870.git.alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.71.154.45;
 envelope-from=prvs=44328bdba=alistair.francis@wdc.com;
 helo=esa6.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/30 16:21:24
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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
Cc: alistair.francis@wdc.com, palmer@dabbelt.com, alistair23@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Conver the Ibex UART to use the recently added qdev-clock functions.

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 include/hw/char/ibex_uart.h |  2 ++
 hw/char/ibex_uart.c         | 19 ++++++++++++++++++-
 2 files changed, 20 insertions(+), 1 deletion(-)

diff --git a/include/hw/char/ibex_uart.h b/include/hw/char/ibex_uart.h
index 2bec772615..322bfffd8b 100644
--- a/include/hw/char/ibex_uart.h
+++ b/include/hw/char/ibex_uart.h
@@ -101,6 +101,8 @@ typedef struct {
     uint32_t uart_val;
     uint32_t uart_timeout_ctrl;
 
+    Clock *f_clk;
+
     CharBackend chr;
     qemu_irq tx_watermark;
     qemu_irq rx_watermark;
diff --git a/hw/char/ibex_uart.c b/hw/char/ibex_uart.c
index 45cd724998..f967e6919a 100644
--- a/hw/char/ibex_uart.c
+++ b/hw/char/ibex_uart.c
@@ -28,6 +28,7 @@
 #include "qemu/osdep.h"
 #include "hw/char/ibex_uart.h"
 #include "hw/irq.h"
+#include "hw/qdev-clock.h"
 #include "hw/qdev-properties.h"
 #include "migration/vmstate.h"
 #include "qemu/log.h"
@@ -330,7 +331,7 @@ static void ibex_uart_write(void *opaque, hwaddr addr,
         }
         if (value & UART_CTRL_NCO) {
             uint64_t baud = ((value & UART_CTRL_NCO) >> 16);
-            baud *= 1000;
+            baud *= clock_get_hz(s->f_clk);
             baud >>= 20;
 
             s->char_tx_time = (NANOSECONDS_PER_SECOND / baud) * 10;
@@ -385,6 +386,18 @@ static void ibex_uart_write(void *opaque, hwaddr addr,
     }
 }
 
+static void ibex_uart_clk_update(void *opaque)
+{
+    IbexUartState *s = opaque;
+
+    /* recompute uart's speed on clock change */
+    uint64_t baud = ((s->uart_ctrl & UART_CTRL_NCO) >> 16);
+    baud *= clock_get_hz(s->f_clk);
+    baud >>= 20;
+
+    s->char_tx_time = (NANOSECONDS_PER_SECOND / baud) * 10;
+}
+
 static void fifo_trigger_update(void *opaque)
 {
     IbexUartState *s = opaque;
@@ -444,6 +457,10 @@ static void ibex_uart_init(Object *obj)
 {
     IbexUartState *s = IBEX_UART(obj);
 
+    s->f_clk = qdev_init_clock_in(DEVICE(obj), "f_clock",
+                                  ibex_uart_clk_update, s);
+    clock_set_hz(s->f_clk, 50000000);
+
     sysbus_init_irq(SYS_BUS_DEVICE(obj), &s->tx_watermark);
     sysbus_init_irq(SYS_BUS_DEVICE(obj), &s->rx_watermark);
     sysbus_init_irq(SYS_BUS_DEVICE(obj), &s->tx_empty);
-- 
2.27.0



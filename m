Return-Path: <SRS0=MTtZ=AN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9AF1C433DF
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 16:36:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7B65A20720
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 16:36:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="jWAEHprz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B65A20720
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57656 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jr2CH-0001Sh-NP
	for qemu-devel@archiver.kernel.org; Thu, 02 Jul 2020 12:36:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33524)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=4451fe355=alistair.francis@wdc.com>)
 id 1jr29c-0003d3-1S
 for qemu-devel@nongnu.org; Thu, 02 Jul 2020 12:33:40 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:44879)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=4451fe355=alistair.francis@wdc.com>)
 id 1jr29a-0000Ah-03
 for qemu-devel@nongnu.org; Thu, 02 Jul 2020 12:33:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1593707618; x=1625243618;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=2NR0rdsh0Rrl8qfDlkfVbeEumPy6kNma3icdpRuXaL4=;
 b=jWAEHprzSSW74Qguhg3YYbfoAj9Fyrsf3hZo/Zz/jKvtTcHFSNVy9dzK
 LSZ8AY5vJ+VwUmjnFu4EhP/TABCHTQu2lZiPviifdtUIVsBU5IicbbAlB
 5fI3qPhXOqI5RgPQxZPlDsK0pZbWCB+e4SgtWXHDPzm/rGS1BwcxMOiu/
 NszczmukSPwb8sYF/s3bdqbBVcjRXcOgLAv1NIfJJIPX69YPB9GJibtED
 2HlheljVfQf/HJ2YqSBK71/pKWDj7jyQuBfe9o4dUh8vdMli9FXm7vCXE
 qBdjvBcFBokIrz+EM0Sr66WosIqhy5VVVsoqccbk5SWh3HESr4Oq2AFNy Q==;
IronPort-SDR: IykxTGloAh3JygVHMr+lSNpJ2otPV9RSQvANX1Vy2AH05YdjBSYvs8iHEVrAYYoHvSpXMzdcTp
 5myJPBREeB9z4lWZoN9kiQYMCszm8yPnC28FF/iPxCOvIuQYQ5K50Wc1fakSwNVE95kjQKZOqB
 NaOHjs2rFdvqxZZnjIed+fQ0IILngII4cUQQTL5nDJT6YIyl4iCQ9gDXcWMTLx1OlWesFHTanv
 DMYromeeHepk1LbR+LDizrKWeNKQxoyVf19NIGdA9rB4e7vO1ZjGgo+syMYY+4+xV8Qiy+9+yU
 R50=
X-IronPort-AV: E=Sophos;i="5.75,304,1589212800"; d="scan'208";a="141498469"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 03 Jul 2020 00:33:21 +0800
IronPort-SDR: iNRZVkS5VmMPuFzUyaeJ/jzuy2mTRxQfY7PONCVWX3FoN7JM/dThZrhzMMe/MeEfxhm+RyMdda
 MaNK8w+p3mM7TUtIeYe8maBYcFvlEHnwM=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Jul 2020 09:21:36 -0700
IronPort-SDR: y0QGL4S9cfC8d+BDCEp/J2vnqONWjP6bD0Fs3y22iK0n1e2Dxd+vchSlyRSQOsOQcRQeiJ3ySc
 1PVCPNHBfucg==
WDCIronportException: Internal
Received: from 6hj08h2.ad.shared (HELO risc6-mainframe.hgst.com)
 ([10.86.58.118])
 by uls-op-cesaip01.wdc.com with ESMTP; 02 Jul 2020 09:33:21 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: peter.maydell@linaro.org,
	qemu-devel@nongnu.org
Subject: [PULL v2 08/64] target/riscv: add an internals.h header
Date: Thu,  2 Jul 2020 09:22:58 -0700
Message-Id: <20200702162354.928528-9-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200702162354.928528-1-alistair.francis@wdc.com>
References: <20200702162354.928528-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.71.154.42;
 envelope-from=prvs=4451fe355=alistair.francis@wdc.com;
 helo=esa4.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/02 12:33:30
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
Cc: alistair23@gmail.com, Richard Henderson <richard.henderson@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>, LIU Zhiwei <zhiwei_liu@c-sky.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: LIU Zhiwei <zhiwei_liu@c-sky.com>

The internals.h keeps things that are not relevant to the actual architecture,
only to the implementation, separate.

Signed-off-by: LIU Zhiwei <zhiwei_liu@c-sky.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20200701152549.1218-6-zhiwei_liu@c-sky.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/internals.h | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)
 create mode 100644 target/riscv/internals.h

diff --git a/target/riscv/internals.h b/target/riscv/internals.h
new file mode 100644
index 0000000000..22a49af413
--- /dev/null
+++ b/target/riscv/internals.h
@@ -0,0 +1,24 @@
+/*
+ * QEMU RISC-V CPU -- internal functions and types
+ *
+ * Copyright (c) 2020 T-Head Semiconductor Co., Ltd. All rights reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms and conditions of the GNU General Public License,
+ * version 2 or later, as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
+ * more details.
+ *
+ * You should have received a copy of the GNU General Public License along with
+ * this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+
+#ifndef RISCV_CPU_INTERNALS_H
+#define RISCV_CPU_INTERNALS_H
+
+#include "hw/registerfields.h"
+
+#endif
-- 
2.27.0



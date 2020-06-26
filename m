Return-Path: <SRS0=ZkAM=AH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2D6FC433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 21:57:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 725902089D
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 21:57:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="BLrIFcma"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 725902089D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42062 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jowM7-00018I-Mx
	for qemu-devel@archiver.kernel.org; Fri, 26 Jun 2020 17:57:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52918)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=439617756=alistair.francis@wdc.com>)
 id 1jowIB-00034l-S3
 for qemu-devel@nongnu.org; Fri, 26 Jun 2020 17:53:51 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:52691)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=439617756=alistair.francis@wdc.com>)
 id 1jowI8-0002yi-BN
 for qemu-devel@nongnu.org; Fri, 26 Jun 2020 17:53:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1593208429; x=1624744429;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=775hJ2qN+nzkC2PMcXcoEiQBeZJ1Tc8+bipoCg7Uo+I=;
 b=BLrIFcmaS15pvWlTxf9dt0h40s5lStr0MNehmQdj4y59gwSSvNmstCx5
 7kC7xfbEoCzmrjkPoJn77Vh1Vi6VpawpoZyAs8uRLLfAetEy9hrBcv52I
 qrDTi8hQL7EA+844JlJ4Hw0mGek77hfe2bwXTJsVIPdAj2oEkFyo30m3A
 UbCk5y/r/MY7s9Tw1+84BoRPQDPxCCH4njdgMZitMt/2XUdU9BBf+y0cs
 9qLN5PeeGVNlxcmhuLgqUAFOq7aChj9Ma9d8Q7lmtOdErXP56FMAjgTiF
 UWFXGzXDIApoO3YBm+pU8Gz7xcryufU9jDuhSk2QXvHiaxe4DibfVpeF+ w==;
IronPort-SDR: 7cmxd1F1AnCP+kPxrbeVZK2MmKoVlc5JIakBRBJMDQc+QvpTLG5e18JKD9srqVAx/j38wcHy7s
 +a6VHhuvZf3+ELJ9cNzfI/+wxOr8gockJd60dg2EvAPq0TErZ0yukyAeiegeMKWY5Gfw71W76w
 H+3NRssVqrvbt2UFMnW5SfBVdvaLtnLwu4I+/tqNFurfaS6H4yxdhoiLeWoXLclDN9XoWNTAhF
 ENuUepvgcnXdOICAcdS4bb141AP4JIH94XUzRfAWuhe+hzZJ6lAFI2g+RJL/h3GSp2A/ltDFtF
 SzM=
X-IronPort-AV: E=Sophos;i="5.75,285,1589212800"; d="scan'208";a="145360026"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 27 Jun 2020 05:53:37 +0800
IronPort-SDR: 9QUk9J+kEeUHmy+jJr1FvaOH+h6isNfQ+uF/Yx9FC7mnHINdswdjZfawj4jAsygTHThHhgll7u
 RHskC1wFyMw2TuAoTCMhD8kwssE0dTJMs=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Jun 2020 14:42:34 -0700
IronPort-SDR: oa+/cNjfBJpNqK+RCAKjGsdC/rpma+EOwI49mUvEgLQneKNRrWsNbiBzbHvAPe8kMunl6X5d+x
 B9U6soAzk7RA==
WDCIronportException: Internal
Received: from 2hc7cg2.ad.shared (HELO risc6-mainframe.hgst.com)
 ([10.86.58.206])
 by uls-op-cesaip01.wdc.com with ESMTP; 26 Jun 2020 14:53:36 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: peter.maydell@linaro.org,
	qemu-devel@nongnu.org
Subject: [PULL 07/63] target/riscv: add an internals.h header
Date: Fri, 26 Jun 2020 14:43:14 -0700
Message-Id: <20200626214410.3613258-8-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200626214410.3613258-1-alistair.francis@wdc.com>
References: <20200626214410.3613258-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.71.153.141;
 envelope-from=prvs=439617756=alistair.francis@wdc.com;
 helo=esa3.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/26 17:53:34
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
Message-id: 20200623215920.2594-6-zhiwei_liu@c-sky.com
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



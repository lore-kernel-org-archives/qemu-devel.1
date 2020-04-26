Return-Path: <SRS0=j/lF=6K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D68FC54FCB
	for <qemu-devel@archiver.kernel.org>; Sun, 26 Apr 2020 16:32:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 33B802080C
	for <qemu-devel@archiver.kernel.org>; Sun, 26 Apr 2020 16:32:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="SCc6Hdej"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 33B802080C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35488 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jSkCZ-0004jm-5c
	for qemu-devel@archiver.kernel.org; Sun, 26 Apr 2020 12:32:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44548)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <prvs=378a396a1=alistair.francis@wdc.com>)
 id 1jSk8T-0005lP-4a
 for qemu-devel@nongnu.org; Sun, 26 Apr 2020 12:28:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <prvs=378a396a1=alistair.francis@wdc.com>)
 id 1jSk8R-00056F-F0
 for qemu-devel@nongnu.org; Sun, 26 Apr 2020 12:28:03 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:30903)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=378a396a1=alistair.francis@wdc.com>)
 id 1jSk8Q-0004rb-Sf; Sun, 26 Apr 2020 12:28:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1587918482; x=1619454482;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=DR4pbdEl2I6apEpDDvJPJ6ayCnFWiVFUUlsbgdB7IIo=;
 b=SCc6HdejltBxvETBMhNSH/xUSKX5YykfBIojArrifmm+0M9z2Tl+adg+
 GAb3BHPrN0O/Z1++BoG1KTEt4xTkJ2UwEUqUOR43GBL1HTroKDMUgSjXv
 O9yLkBRagj6fIRNeooHzUyK0OIKVg+nv4+04U09V/te0gO8qH9l9dxcHJ
 awULY3L2NlKivU5SVk5jh0roOfJ+gCxUpFUUBu6hPkcwBAkLYdya2Wv5x
 FVrxiL5SQf+t5uBzPXiycFp/IKf+WVXuEdy6mcpVSEZcM/zfpC4NsmG7T
 aOHIPNYKSO9CZqDlioxS17v99gafkY5uXd2AqlfGS1Powc56a6obz+JTO w==;
IronPort-SDR: oFu8XAqIrA+XYiBojdekTblIeiSVx3jVL6dYN1BeF18JRLHz97AIc3sTjLmfthzu4Iaxxyilq9
 n0CCh90piZxht5/E8dEcTzPFFPESZ790PueUqJQ6+XlkliIYNVW5BIiQJp/0o54f/5tzL5e2oN
 ldLkf3GaZL/n4Z0xgAlg7dZj1xCzTca45zfiPkAwsSzsWoelCetPtxIP8NKbIY4VPJ/IkNYMsx
 GmayivDtYOYHqcRkPM6WOW7JZgTMP1EVSSZ9xivYFSV7D2CtnKjeOG+8Nwsh7uUK/1UjrxTPMT
 qy4=
X-IronPort-AV: E=Sophos;i="5.73,320,1583164800"; d="scan'208";a="136193262"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 27 Apr 2020 00:28:01 +0800
IronPort-SDR: iKWuPKqilS8S5b+fBXI5lwnzshntvthh2J7I1lwqbj2xxA5PCdj4zWX0t7whdSXxy7R/A1idXP
 S3PmBIg1tAe3QE1iY4oNDwrrLkohhTWxM=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Apr 2020 09:18:11 -0700
IronPort-SDR: MOuZamxbp/QOib8VHHUwrksXZrtQlMy2mZvwsPDAXu5qk3mwvQjpHDt+DnSBfZhDewryVIkP6U
 Ue4iojcz5d+w==
WDCIronportException: Internal
Received: from wdthnc17-0189.ad.shared (HELO risc6-mainframe.hgst.com)
 ([10.86.56.50])
 by uls-op-cesaip02.wdc.com with ESMTP; 26 Apr 2020 09:28:01 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [PATCH v1 14/15] target/riscv: Only support little endian guests
Date: Sun, 26 Apr 2020 09:19:51 -0700
Message-Id: <a239e3404fa5c4f2121af7ee4411076af00ece61.1587917657.git.alistair.francis@wdc.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1587917657.git.alistair.francis@wdc.com>
References: <cover.1587917657.git.alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.71.154.42;
 envelope-from=prvs=378a396a1=alistair.francis@wdc.com;
 helo=esa4.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/26 12:27:21
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Received-From: 216.71.154.42
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

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/csr.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index 438d0a61ee..04f3471f2e 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -858,6 +858,8 @@ static int read_hstatus(CPURISCVState *env, int csrno, target_ulong *val)
     /* We only support 64-bit VSXL */
     *val = set_field(*val, HSTATUS_VSXL, 2);
 #endif
+    /* We only support little endian */
+    *val = set_field(*val, HSTATUS_VSBE, 0);
     return 0;
 }
 
@@ -869,6 +871,9 @@ static int write_hstatus(CPURISCVState *env, int csrno, target_ulong val)
         qemu_log_mask(LOG_UNIMP, "QEMU does not support mixed HSXLEN options.");
     }
 #endif
+    if (get_field(val, HSTATUS_VSBE) != 0) {
+        qemu_log_mask(LOG_UNIMP, "QEMU does not support big endian guests.");
+    }
     return 0;
 }
 
-- 
2.26.2



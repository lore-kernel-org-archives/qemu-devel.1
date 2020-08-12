Return-Path: <SRS0=vd3Y=BW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 733C4C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2020 22:48:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3AFDE20781
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2020 22:48:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="gJIhqfV3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3AFDE20781
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60310 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k5zXW-0005Sk-Fw
	for qemu-devel@archiver.kernel.org; Wed, 12 Aug 2020 18:48:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39576)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=486123ee4=alistair.francis@wdc.com>)
 id 1k5zQW-0002K2-OZ
 for qemu-devel@nongnu.org; Wed, 12 Aug 2020 18:40:56 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:29819)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=486123ee4=alistair.francis@wdc.com>)
 id 1k5zQU-0005m7-GO
 for qemu-devel@nongnu.org; Wed, 12 Aug 2020 18:40:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1597272054; x=1628808054;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=VWIRA4MvJfHg3q+KNZoxT6diO+bgU4E92KEQUmjiKA8=;
 b=gJIhqfV3ANbQeTzKYRSnXYVEiG6XJDwI4iC10xEoKmIyzxZBKazKAjdK
 Z3x+eXniE1dUqRHR1IL4prQMvyxjBDp9LXaw4qtTxM+K4QYJR2EBKxlLv
 /P76jFcfrsRFJUH592ocZqmyEUG477Rpnw7OvkUrDzeY7kdnvXsQLqRr4
 uM6xl8mDylxvsF5wYU05GyVWNS2GC6wVVK3YSNqRcNetd7vOstqH72iCD
 p6A+hrF/CSVa6hNo0tsZlborShSrUDTOt2h+NeXd8fub/KuIeERxCZ633
 eFURC17Eup1AbffDt/LRhKXmGnlcOITKv9SHkuQ2f9yj1qIQ1MyoXLW9w w==;
IronPort-SDR: bmz7toj7N0KWvHMVmE9NZDQgRnozprObzDm1cwz9VFDHyxHpan/LsJhOH6L3l/L/GrP2Rp+g+W
 9cStY+wMaJEVfYj8D0HCrYzyVI69Cg4nrVV8Ck+Tg0OOeQt4hrWH7Yklq5wQmu/b0PVa5vSHOs
 fXe2AVyJZvXEUkgNPuGxXGBwTUdrxVMOhTleIyYQN8lHKa5DTsaJ0jhnApinVVyraDkfD48j8I
 oygtwxexRbnBMdWXLOQ2toWoZ7raWhAEl1dU0S5IC/wUKNMT6oHVuz6itOs1SSaklGfBMPyWHL
 j3k=
X-IronPort-AV: E=Sophos;i="5.76,305,1592841600"; d="scan'208";a="254208931"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 13 Aug 2020 06:40:49 +0800
IronPort-SDR: WA1mP93I0Jw6oip6CcELkjW5mMr+yxWbNns0UBk/qvFC7qwIgP/lSt5fSVhjRweaqGrvUnD1qy
 Php6tvWFshzQ==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Aug 2020 15:27:57 -0700
IronPort-SDR: Wrn0z1g9+AbNO6pilbNAQvd7ZN8calFwyiDNw7pnqOvZjGPRi1uhsmCD879UvJZLKzrvPHpgB5
 O2yI+kUE4yMg==
WDCIronportException: Internal
Received: from jbfyk72.ad.shared (HELO risc6-mainframe.hgst.com)
 ([10.86.59.14])
 by uls-op-cesaip01.wdc.com with ESMTP; 12 Aug 2020 15:40:46 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Subject: [PULL 09/20] riscv: Fix bug in setting pmpcfg CSR for RISCV64
Date: Wed, 12 Aug 2020 15:30:34 -0700
Message-Id: <20200812223045.96803-10-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200812223045.96803-1-alistair.francis@wdc.com>
References: <20200812223045.96803-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=68.232.141.245;
 envelope-from=prvs=486123ee4=alistair.francis@wdc.com;
 helo=esa1.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/12 18:40:48
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: Hou Weiying <weiying_hou@outlook.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Myriad-Dreamin <camiyoru@gmail.com>, Hongzheng-Li <Ethan.Lee.QNL@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Hou Weiying <weiying_hou@outlook.com>

First, sizeof(target_ulong) equals to 4 on riscv32, so this change
does not change the function on riscv32. Second, sizeof(target_ulong)
equals to 8 on riscv64, and 'reg_index * 8 + i' is not a legal
pmp_index (we will explain later), which should be 'reg_index * 4 + i'.

If the parameter reg_index equals to 2 (means that we will change the
value of pmpcfg2, or the second pmpcfg on riscv64), then
pmpcfg_csr_write(env, 2, val) will map write tasks to
pmp_write_cfg(env, 2 * 8 + [0...7], val). However, no cfg csr is indexed
by value 16 or 23 on riscv64, so we consider it as a bug.

We are looking for constant (e.g., define a new constant named
RISCV_WORD_SIZE) in QEMU to help others understand code better,
but none was found. A possible good explanation of this literal is it is
the minimum word length on riscv is 4 bytes (32 bit).

Signed-off-by: Hongzheng-Li <Ethan.Lee.QNL@gmail.com>
Signed-off-by: Hou Weiying <weiying_hou@outlook.com>
Signed-off-by: Myriad-Dreamin <camiyoru@gmail.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-Id: <SG2PR02MB263420036254AC8841F66CE393460@SG2PR02MB2634.apcprd02.prod.outlook.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/pmp.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/target/riscv/pmp.c b/target/riscv/pmp.c
index 2a2b9f5363..b14feeb7da 100644
--- a/target/riscv/pmp.c
+++ b/target/riscv/pmp.c
@@ -320,8 +320,7 @@ void pmpcfg_csr_write(CPURISCVState *env, uint32_t reg_index,
 
     for (i = 0; i < sizeof(target_ulong); i++) {
         cfg_val = (val >> 8 * i)  & 0xff;
-        pmp_write_cfg(env, (reg_index * sizeof(target_ulong)) + i,
-            cfg_val);
+        pmp_write_cfg(env, (reg_index * 4) + i, cfg_val);
     }
 }
 
@@ -336,7 +335,7 @@ target_ulong pmpcfg_csr_read(CPURISCVState *env, uint32_t reg_index)
     target_ulong val = 0;
 
     for (i = 0; i < sizeof(target_ulong); i++) {
-        val = pmp_read_cfg(env, (reg_index * sizeof(target_ulong)) + i);
+        val = pmp_read_cfg(env, (reg_index * 4) + i);
         cfg_val |= (val << (i * 8));
     }
     trace_pmpcfg_csr_read(env->mhartid, reg_index, cfg_val);
-- 
2.27.0



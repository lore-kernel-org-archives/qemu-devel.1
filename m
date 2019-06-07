Return-Path: <SRS0=3yEa=UG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A813C468BD
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 22:07:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2838C208C3
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 22:07:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="X7BlLYUf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2838C208C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53630 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hZN11-0002uF-DW
	for qemu-devel@archiver.kernel.org; Fri, 07 Jun 2019 18:07:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47639)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <prvs=0547f94d1=alistair.francis@wdc.com>)
 id 1hZMrt-000421-HH
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 17:57:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <prvs=0547f94d1=alistair.francis@wdc.com>)
 id 1hZMrr-0001g2-UK
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 17:57:49 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:8436)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <prvs=0547f94d1=alistair.francis@wdc.com>)
 id 1hZMrr-0001Ty-GS; Fri, 07 Jun 2019 17:57:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1559944668; x=1591480668;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=BXuqW+Vie67kKzLkoEIoBCOJ2a3oHbLhsnez7FroSYM=;
 b=X7BlLYUfjWW2xFq72GHAexdy7/YqL62ovrZTdgtVOJyCVnQA7Ol2cOLu
 O0WA2Shn5pH3owUJ1of36O9qgSG8jCU/kJ6Tu9FHMIpMvxUbwBbjWJarU
 8YzLqVs4rnSV2MVaS/4HrbZn7csQCT7FhVrt281nWZdGFeq5HovWFlcWs
 gbST+3VhtAfPMwfYSlmv6tFjctIdV55zvJ3Aw2zjZKyIOgiUwYvXBDiHX
 3zFqIcpZda5459A1uSMLs+zrFhHjPdjKkCk1JhyyzEsj4FwVKcD4yvBSd
 g7qer/GtgRe0JTVoZWD9btHNuljyfTdy3Fdu8Jh5j1HGZ0Di8mblqfLg4 A==;
X-IronPort-AV: E=Sophos;i="5.63,564,1557158400"; d="scan'208";a="115014082"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 08 Jun 2019 05:57:43 +0800
IronPort-SDR: y2eHVMNQ45bNeKp6JIyZrsqxEGPSsxEXwbpfyt3Z0lbq59g/L8Lk+0XzxpqKrDiDiYR235gww7
 xk2WXnq4vumvn8LiQuK6HiCJkHqZ5I9P4CRqxLb1Tn6O8M/o1bGiUeEF7RowM8sMYgXzhfoJ0c
 dNadsdYnrzulCXD6fQhKv/ipgtyGFHPcpkaLpksB3YJl7zF5S7ly332yrVjGmNXu3l0/OykA18
 6ZfQZDScpY/yEoDM0dysWDtlyooXeW02VrBj1nBiQvKsIjQK51W0T9bZ73sfZafyGluXBFJmzy
 dCyBauB9RTnAXhVMoSLhmr2K
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep02.wdc.com with ESMTP; 07 Jun 2019 14:34:59 -0700
IronPort-SDR: xXRww24/bqrtdvN6V4iq5RMtoGQ4qLy3YnDkoQIvDp5uoC+JG6o7tYlk7YqgvUCdArK3DDckxe
 gMuW1L2MznRnEqZxoFfLaQWVKESYYTObFGqt3fnkyhtAPtd8oYnx1SVVhBcE1xcfyqU2l1CBTH
 O11ZNLwMyNT30XhwDI/bRZOJVdBaakm2sUViC/BaQslRiVsvTzL1SV8b/himIzCffup6YpXQoK
 x5QaIhuzm/ZuRrZ+xG2Pm0LT/cqG0QK5lf/xM11YAHVcWRY9p19zb4U+mzAHtggc2t2TWa0TX+
 XG4=
Received: from risc6-mainframe.sdcorp.global.sandisk.com (HELO
 risc6-mainframe.int.fusionio.com) ([10.196.157.140])
 by uls-op-cesaip02.wdc.com with ESMTP; 07 Jun 2019 14:57:42 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Date: Fri,  7 Jun 2019 14:55:33 -0700
Message-Id: <609116061bb03388a782b79fc345f02dc69e0d34.1559944445.git.alistair.francis@wdc.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1559944445.git.alistair.francis@wdc.com>
References: <cover.1559944445.git.alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 216.71.153.141
Subject: [Qemu-devel] [PATCH v1 05/27] target/riscv: Add the Hypervisor CSRs
 to CPUState
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
Cc: alistair23@gmail.com, palmer@sifive.com, alistair.francis@wdc.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.h | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index eeb3756c91..b99d2b7af2 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -169,12 +169,29 @@ struct CPURISCVState {
     target_ulong mcause;
     target_ulong mtval;  /* since: priv-1.10.0 */
 
+    /* Hypervisor CSRs */
+    target_ulong hstatus;
+    target_ulong hedeleg;
+    target_ulong hideleg;
+    target_ulong hgatp;
+
     target_ulong scounteren;
     target_ulong mcounteren;
 
     target_ulong sscratch;
     target_ulong mscratch;
 
+    /* Background CSRs */
+    target_ulong bsstatus;
+    target_ulong bsip;
+    target_ulong bsie;
+    target_ulong bstvec;
+    target_ulong bsscratch;
+    target_ulong bsepc;
+    target_ulong bscause;
+    target_ulong bstval;
+    target_ulong bsatp;
+
     /* temporary htif regs */
     uint64_t mfromhost;
     uint64_t mtohost;
-- 
2.21.0



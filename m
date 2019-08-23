Return-Path: <SRS0=wZWj=WT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63718C3A5A2
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2019 23:48:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2EF7E21848
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2019 23:48:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="pG1gt+ny"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2EF7E21848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34990 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i1JIB-0006f6-NP
	for qemu-devel@archiver.kernel.org; Fri, 23 Aug 2019 19:48:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49385)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <prvs=1314b2cac=alistair.francis@wdc.com>)
 id 1i1JBj-0000c8-UW
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 19:41:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <prvs=1314b2cac=alistair.francis@wdc.com>)
 id 1i1JBi-0008Vc-OZ
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 19:41:47 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:50260)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <prvs=1314b2cac=alistair.francis@wdc.com>)
 id 1i1JBg-0008Ui-Qi; Fri, 23 Aug 2019 19:41:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1566603733; x=1598139733;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=fWPOcwK1QLVia/IV12AzFAZG+JyzmslPbfnxXbr+OYo=;
 b=pG1gt+nyk+eCq0jnR/Buu6SPIeSYtfqVtl5iqceuFuS3AyVQWdvmvtnm
 l8suSN3s2igAe3oDw5/s2G8vKKuIxrcsA5hblwrrzZOm7P9IZYBIXmR3j
 rTNYG1px1W73nT5YsViA8tVTu3lBz6gqYbk7VPZxrCwJ33SeAeDMeWGiV
 CtC6o/XC6d6RGEQVfMQtqsWKEE7JWW5q290VB8DH/YHhjfjZ6MNrXz6v/
 Ak2WwG65QcDjkzRr8xSNYnNzavpD+tOJ2yp/9Gs48VkDCE3I+OkS7nLm8
 H1pChqTR+jKAw+5yUE4wRxk+X4R5SaphzIEemBwNQImRfoJyvMFnCWP1T g==;
IronPort-SDR: cZocukTPCiZfxPmUXLhnLueZ2Fe9r4iqtYAqM/r/2INeWGFN+YSlAjKVwGveVgLx1gtI7k6nPq
 nxSDM+++WwFUaHdoriz3YxiN59nE0IGLS8qCC74hVApWvTi7zDhH44AxvFcNjMaEyLMraHymHD
 sa2fMvK/5+3BEhizO/ZEwekLK+s1RkhUwyY5hzahx/OwXtB3dBLBsosizwAQoJd6A8S35Gn4my
 ZIj/cx70TIGLP/LFJN5LCHy7/HrMIWv9jWNQ77DFwUSLLuGUwtvP2dmCffDEJfPCvws3bVyVKB
 E/A=
X-IronPort-AV: E=Sophos;i="5.64,422,1559491200"; d="scan'208";a="217013885"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 24 Aug 2019 07:42:10 +0800
IronPort-SDR: pIo/DncM8PUyFDl7sFXj3Fpm6gbs9dcpucWnfpthFTwutY+12ip6BgWz1COmYpCrqcrOpgleDn
 ZBTxyp3ciJiQHwpDzQKeZUZXCpZHJeZhQzeiyEBizKgKYSqaZQVBDUSGuy4PXnFHK5A+Qu++Ki
 kHGyWdoHPVoULdeVwa1AtjLLsAfhxXOh4i9pISyA+XqNS+RPVD2LJlrJaUx8zXCFjmzLur7AvS
 1BuvJuyIjBBxb87O2bcNUERcNJbZGr3uXCwTrFVtP5OyyEpLrNCg4Jj62Vz158SPlSw3EiOUAs
 bUnyDtYWZoEBbg5Rxw8CX6lz
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Aug 2019 16:39:00 -0700
IronPort-SDR: sPwGntx8ShKaZHw/GwJ/7ZeJ0qNbruMogp6800CKahDohsPgdiJ6SBJBOVzrh+cfVgdjpquIeS
 BjVMN/fQuebJ/feJWWZCvPNbjR6OBmQOOxFN1uilvOuKF20teVKqyjf3equKgSGppdpPrFl8CR
 1mT8IhpP/Jro9K3Ohzs8MLcYGY2V6eB6qQ1Km1jbuMypUDpx9x4n90eV9+24+gEQgcwehca6Vi
 8HRXZnHuHhhtDB6vpqPgbsh7xIugwDHWfTWzb8wegbjiwJcwUwO3tqAkn+p4GV6p2SI0d3chq7
 p1c=
WDCIronportException: Internal
Received: from risc6-mainframe.sdcorp.global.sandisk.com (HELO
 risc6-mainframe.int.fusionio.com) ([10.196.157.58])
 by uls-op-cesaip02.wdc.com with ESMTP; 23 Aug 2019 16:41:42 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Date: Fri, 23 Aug 2019 16:38:02 -0700
Message-Id: <e959ee81e5121c74678d2383a28665e44db9e31d.1566603412.git.alistair.francis@wdc.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <cover.1566603412.git.alistair.francis@wdc.com>
References: <cover.1566603412.git.alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x
X-Received-From: 68.232.143.124
Subject: [Qemu-devel] [PATCH v1 05/28] target/riscv: Add the Hypervisor CSRs
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
Cc: alistair23@gmail.com, Anup.Patel@wdc.com, palmer@sifive.com,
 alistair.francis@wdc.com, Atish.Patra@wdc.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

As the MIP CSR is 32-bits to allow atomic_read on 32-bit hosts the vsip
is 32-bit as well.

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.h | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 3a95c41428..4c342e7a79 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -154,6 +154,23 @@ struct CPURISCVState {
     target_ulong mcause;
     target_ulong mtval;  /* since: priv-1.10.0 */
 
+    /* Hypervisor CSRs */
+    target_ulong hstatus;
+    target_ulong hedeleg;
+    target_ulong hideleg;
+    target_ulong hgatp;
+
+    /* Virtual CSRs */
+    target_ulong vsstatus;
+    uint32_t vsip;
+    target_ulong vsie;
+    target_ulong vstvec;
+    target_ulong vsscratch;
+    target_ulong vsepc;
+    target_ulong vscause;
+    target_ulong vstval;
+    target_ulong vsatp;
+
     target_ulong scounteren;
     target_ulong mcounteren;
 
-- 
2.22.0



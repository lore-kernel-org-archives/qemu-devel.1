Return-Path: <SRS0=l02z=YT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5B64CA9EA0
	for <qemu-devel@archiver.kernel.org>; Sat, 26 Oct 2019 00:48:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8C32721872
	for <qemu-devel@archiver.kernel.org>; Sat, 26 Oct 2019 00:48:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="MpwxmYWz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C32721872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37630 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iOAG6-0006sF-9P
	for qemu-devel@archiver.kernel.org; Fri, 25 Oct 2019 20:48:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50205)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <prvs=194c68654=alistair.francis@wdc.com>)
 id 1iO91Z-0005vT-6k
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 19:29:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <prvs=194c68654=alistair.francis@wdc.com>)
 id 1iO91Y-0004lz-30
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 19:29:41 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:10430)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <prvs=194c68654=alistair.francis@wdc.com>)
 id 1iO91X-0004CY-PS; Fri, 25 Oct 2019 19:29:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1572046179; x=1603582179;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=5xy/BQ5Ff17/zZ+q9QgWqRSx+0OeU4f0Sj1sSKNFPcQ=;
 b=MpwxmYWz0QgxTJC6NMwOVmWn2Ajsvt7OqJ4uwl0rqEFW3yx1zlQ7dRGT
 2L9QgGHOm894xSliHYPRgBsnIz9GTEbeS7m3sTwXLACBqaxJ7N4mGrEoD
 4ZkeaT0iCSirN7x+htgDDUh4be8IOkMsTUrPve+jP2JofpJBbp47THYde
 35bFGuBlnmChfGUmpHwale7fkCPIdw0qe7/WL/sq/RI5NY9HB9Mf4Snh5
 hgdxK+AV/VtOHHgc5J7ZZ1XwYszpn7HXTPDlcjeR+SgpxgnxLo3sm9Fym
 MHMiijYhkcIMOVPhQp42NI8aSTD2RhpS2OBdqTDEz3T+ujnzreAtbgEvT g==;
IronPort-SDR: zXixdOhZo36mF5ZtcXEykzhagF8ytU1ZmbRHmR5Tf9YeK8kKK1iLJQaY2g1krspIkGxZk9tInU
 1wIuAHfKrVYztGvAsn8zugql3le+tSHEoK1FF7P/kpqrsZdhKTc+SDwLu850claGwQM8h2IhvR
 JJxv8pfx1lZMIjPxOxEik1jR3djg8kRXsytdvuHqhr5NkEFdMfkUFyxDuX0sBlSMUuhIHB3Sw5
 l0+z7FzG8ow5tkTTnrQ/dDXxHQwbOH+grFP/tFLH672O5NCbGm9NvmMsyT+z/NrOim6j2MLbjM
 oaI=
X-IronPort-AV: E=Sophos;i="5.68,230,1569254400"; d="scan'208";a="228520418"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 26 Oct 2019 07:28:58 +0800
IronPort-SDR: Z3zY7b09YvyvAmtvtOCVnoEib+vFoXr1EWCR2REVigTV2CTNV5GIRvQ5qrJz6SySlAStVyU58e
 REOQ25SQk3owxNMRnmZ1NP5iQA88YiNONru8BPG3T/2EnslPlD4fRg5MbXum/r1L9axLQuDNZy
 PbyGn3lmBI6mTrDPbN1l18dbTqZQpcKTXwgbm0Y/8zUcmv86pJ+om3ZtE6Lycr0BJH3jxKDz68
 1xhSmAVKyKSre1BNxr0TWzKv+PZGCplTGixXbybh8Edj3vHbl9INGfQnE6uA+qA+KZ470wWqNY
 mCDREEQC95s+NmiJrn7Doh9d
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Oct 2019 16:24:24 -0700
IronPort-SDR: 8IkYaeWsa1WKFPlrikMUhWMIukbvr5buFfiArifeb7W8OK9r4PXJRq04IBg0viPveRbWQ3xW98
 2iCxdDyNN2b/OAphz6kO15giWF1D6qPDx6pVfMr18SgI0qxt09IAGZuEBpdYV9wu0qvUoRrRHG
 A2F+2fyJKSZ54KN04EjuTUUBQSSBfUk22fxSrqPofi8nrqCWPztnYE4dyRcXMEugHBJ/AFLwY9
 D9iUpDfObSyh/7mtoYJM7NiNjcx0kjJpFFWhzFTW2adguOhLWE/Kz/khQg8Wr8UPh1RnL55i6v
 HaA=
WDCIronportException: Internal
Received: from risc6-mainframe.sdcorp.global.sandisk.com (HELO
 risc6-mainframe.int.fusionio.com) ([10.196.157.58])
 by uls-op-cesaip02.wdc.com with ESMTP; 25 Oct 2019 16:28:59 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [PATCH v2 16/27] riscv: plic: Always set sip.SEIP bit for HS
Date: Fri, 25 Oct 2019 16:24:03 -0700
Message-Id: <ed72f249afccde44453efef12935e7804e24b55f.1572045716.git.alistair.francis@wdc.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <cover.1572045716.git.alistair.francis@wdc.com>
References: <cover.1572045716.git.alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x [fuzzy]
X-Received-From: 68.232.141.245
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

When the PLIC generates an interrupt ensure we always set it for the SIP
CSR that corresponds to the HS (V=0) register.

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 hw/riscv/sifive_plic.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/hw/riscv/sifive_plic.c b/hw/riscv/sifive_plic.c
index 98e4304b66..8309e96f64 100644
--- a/hw/riscv/sifive_plic.c
+++ b/hw/riscv/sifive_plic.c
@@ -150,7 +150,17 @@ static void sifive_plic_update(SiFivePLICState *plic)
             riscv_cpu_update_mip(RISCV_CPU(cpu), MIP_MEIP, BOOL_TO_MASK(level));
             break;
         case PLICMode_S:
-            riscv_cpu_update_mip(RISCV_CPU(cpu), MIP_SEIP, BOOL_TO_MASK(level));
+            if (riscv_cpu_virt_enabled(env)) {
+                if (level) {
+                    atomic_or(&env->mip_novirt, MIP_SEIP);
+                    g_assert(riscv_cpu_virt_enabled(env));
+                } else {
+                    atomic_and(&env->mip_novirt, ~MIP_SEIP);
+                    g_assert(riscv_cpu_virt_enabled(env));
+                }
+            } else {
+                riscv_cpu_update_mip(RISCV_CPU(cpu), MIP_SEIP, BOOL_TO_MASK(level));
+            }
             break;
         default:
             break;
-- 
2.23.0



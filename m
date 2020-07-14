Return-Path: <SRS0=DUFB=AZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBC88C433E1
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2020 00:47:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A80A621835
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2020 00:47:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="owTSk5m8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A80A621835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60016 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jv96p-00077K-Tu
	for qemu-devel@archiver.kernel.org; Mon, 13 Jul 2020 20:47:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52000)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=457b4eeb6=alistair.francis@wdc.com>)
 id 1jv91s-0005u8-Cu
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 20:42:40 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:30774)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=457b4eeb6=alistair.francis@wdc.com>)
 id 1jv91q-0008OU-Ft
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 20:42:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1594687358; x=1626223358;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=97ZqdomTpIrBJ3DOxVUUUeZfsCeX2/C5sT4cAbz7mdQ=;
 b=owTSk5m83qgYRFmlLYcevA/WRBodnHfKmJ/X1CqJcUzGWYWEN+bve6Ms
 /5HkgKkdmpdlnJTtmfmmBTiZEircVdS8JzKlOHsHtopOd3YooH0UMBHWz
 rD3NyCkSbTYMowkIkvKQfUjSDjdxMn7oOm5Vtlr8JXDviqTJk/NcHrfQ+
 SFIPm8vqyvYmuQz8+KkSOuxmm/M3Q0M///bm+gIaakadpzaFQ0W+SMVAt
 KxAOtO5bpRLBnFbK2pz47AyrZlmeENWMtLsJ2j/hf7sDBWnsSMvoAQSP3
 QNdVQeGCh7oysRrBxINC/zKbZhOVE+eqBS8OltGZQ9ULC+MUccFjs8+t6 A==;
IronPort-SDR: FUEDUYQAXT1u01y3jZ6YORHiqpuWFzqX4tQ1NyfL184qNL767D4ZDcKg1BX3xdvEEDPS1EiPSb
 0bXaZQBo4J5dgGK0HAd+bvL+Sh7vsrsUBPb0+PUMndnwP0LLJsqeVDaXZO7tZKG1CJ4PiqQZ8T
 kHxTJnLx1TsJQiFiz165NN89smq1uiOyuWTxFc9YLUThutWNoA5SCNWRLCM5LDckLzzZ5ceWo0
 Jah9O05pkUm0F+FDDeB98oRA2BTuI0WvozEjJGEDv75Ft2LqpMQjdykDxYgHFOFb63o52bO5GW
 qrM=
X-IronPort-AV: E=Sophos;i="5.75,349,1589212800"; d="scan'208";a="142511924"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 14 Jul 2020 08:42:29 +0800
IronPort-SDR: ysNhwJ9T4BJsIkNHgHlp7pZQmqe12+nZQGp/DkowRIVhKsfSMhkAf99JY7xgm9VO11NRGX6dAW
 z3G4Fs+21bYnzZOf1tgqstnw1GBn6uz1A=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Jul 2020 17:30:57 -0700
IronPort-SDR: tRebR0dNJn9+FLVLmQI6ZIqGxr+eKnaBf7JJqZqJ3EIC/xDvDYf9VXfqj7pqM7X76bmNJnp1bn
 mjdcv+m/e04g==
WDCIronportException: Internal
Received: from usa002626.ad.shared (HELO risc6-mainframe.hgst.com)
 ([10.86.57.178])
 by uls-op-cesaip02.wdc.com with ESMTP; 13 Jul 2020 17:42:29 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Subject: [PULL 07/15] hw/riscv: Modify MROM size to end at 0x10000
Date: Mon, 13 Jul 2020 17:32:46 -0700
Message-Id: <20200714003254.4044149-8-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200714003254.4044149-1-alistair.francis@wdc.com>
References: <20200714003254.4044149-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.71.153.144;
 envelope-from=prvs=457b4eeb6=alistair.francis@wdc.com;
 helo=esa5.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/13 20:42:28
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
Cc: Bin Meng <bin.meng@windriver.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Bin Meng <bin.meng@windriver.com>

At present the size of Mask ROM for sifive_u / spike / virt machines
is set to 0x11000, which ends at an unusual address. This changes the
size to 0xf000 so that it ends at 0x10000.

Signed-off-by: Bin Meng <bin.meng@windriver.com>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Message-Id: <1594289144-24723-1-git-send-email-bmeng.cn@gmail.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 hw/riscv/sifive_u.c | 2 +-
 hw/riscv/spike.c    | 2 +-
 hw/riscv/virt.c     | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
index 6595ab3f87..19a976c9a6 100644
--- a/hw/riscv/sifive_u.c
+++ b/hw/riscv/sifive_u.c
@@ -70,7 +70,7 @@ static const struct MemmapEntry {
     hwaddr size;
 } sifive_u_memmap[] = {
     [SIFIVE_U_DEBUG] =    {        0x0,      0x100 },
-    [SIFIVE_U_MROM] =     {     0x1000,    0x11000 },
+    [SIFIVE_U_MROM] =     {     0x1000,     0xf000 },
     [SIFIVE_U_CLINT] =    {  0x2000000,    0x10000 },
     [SIFIVE_U_L2LIM] =    {  0x8000000,  0x2000000 },
     [SIFIVE_U_PLIC] =     {  0xc000000,  0x4000000 },
diff --git a/hw/riscv/spike.c b/hw/riscv/spike.c
index b17d96aec7..7b23a297fc 100644
--- a/hw/riscv/spike.c
+++ b/hw/riscv/spike.c
@@ -52,7 +52,7 @@ static const struct MemmapEntry {
     hwaddr base;
     hwaddr size;
 } spike_memmap[] = {
-    [SPIKE_MROM] =     {     0x1000,    0x11000 },
+    [SPIKE_MROM] =     {     0x1000,     0xf000 },
     [SPIKE_CLINT] =    {  0x2000000,    0x10000 },
     [SPIKE_DRAM] =     { 0x80000000,        0x0 },
 };
diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index bc25ec69f7..55a907bb35 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -53,7 +53,7 @@ static const struct MemmapEntry {
     hwaddr size;
 } virt_memmap[] = {
     [VIRT_DEBUG] =       {        0x0,         0x100 },
-    [VIRT_MROM] =        {     0x1000,       0x11000 },
+    [VIRT_MROM] =        {     0x1000,        0xf000 },
     [VIRT_TEST] =        {   0x100000,        0x1000 },
     [VIRT_RTC] =         {   0x101000,        0x1000 },
     [VIRT_CLINT] =       {  0x2000000,       0x10000 },
-- 
2.27.0



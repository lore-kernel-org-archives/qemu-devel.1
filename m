Return-Path: <SRS0=EA86=VT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 048B1C7618F
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2019 20:25:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C0D72218BE
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2019 20:25:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="XtP318s6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C0D72218BE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37512 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hperl-0004ZI-IP
	for qemu-devel@archiver.kernel.org; Mon, 22 Jul 2019 16:25:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44079)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <prvs=0991791bd=alistair.francis@wdc.com>)
 id 1hperV-0003ly-Dp
 for qemu-devel@nongnu.org; Mon, 22 Jul 2019 16:24:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <prvs=0991791bd=alistair.francis@wdc.com>)
 id 1hperU-0007yR-Ck
 for qemu-devel@nongnu.org; Mon, 22 Jul 2019 16:24:45 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:21513)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <prvs=0991791bd=alistair.francis@wdc.com>)
 id 1hperT-0007Q6-P1; Mon, 22 Jul 2019 16:24:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1563827168; x=1595363168;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=O8wO7BTwgiGvX0uxfedGyffUbyt916GBNHsKv/cGmU0=;
 b=XtP318s6XTa1nL2U74Tj1U5FK33ZHvkJdxXmwwaN9SGxADk2VnxMJDdA
 evtQoqularmG+ZUzC7ACmQP/FbW8nqNufeAsjB5g6Y+GJ0s2KK0lalP+n
 6nOsFlQTLIR4M/DylpAfPUrlUgIYpCYAsOHGMvciTyKKo6OtQXTZI0k2L
 We//vbCESxURU15tRQzfu0Qk5mij7QeHM5fq93vS4HArj7TWTV+d0SsMZ
 BVlglK7C1OYdjGSeRFM6Luzb6tEkFqbzj8vr1okO+r5g91ArvzlW+FcbG
 IV9JYE3HAGUhovxFkBWaX2R8l3BCCL6+omTgjImt3Y9hdbekpnPjhSEwL w==;
IronPort-SDR: p7m/ZcnGr+ods5LIy8RumYqZFF+joVkl6/ysiwHRsbqf0VJtzGwg5BI20UwlZK5LdL69xl95bF
 MvrizXuA67VmJvPtYKXr6A7XqTtLAohvD0oFKPMgwDsKpXPg2iFfjZ6oUKkhXAyX9G7BZa1qxH
 +e9VuqOkAa9sUwlgDi/wXkzzzonA2MwR2vN7N97+PG6tOaqASl7iHYHlQj0E5vciCd8swrIDTh
 WbSp6ThSmo8b9JR2x1Tw98iG7YUYgRxpN2RIIHISpkFwEo2RtFvyn64MhuMvzukCrcmGlGFv+L
 ELc=
X-IronPort-AV: E=Sophos;i="5.64,296,1559491200"; d="scan'208";a="213778901"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 23 Jul 2019 04:24:33 +0800
IronPort-SDR: 7snGsbc043wwRa3YS0L8r18b5PpY1z6o284shZl7V9PxOrXIOmIjv+BS7x8v7X5zmAAsIxbe40
 WDrvPcJ5/K/JQaXLgM260CTMgOpb33ORfOgjpMVt9yi+npM8O04N9B9GZNNy0Pl6gZc8XVXV33
 D+PBAr3fWS6sGQcFc5OLUfFfLqvktP/F5TbCS0jFWbeQJPFw+kGB2i3t6PFZkKTXwa45mG2odS
 ZOD/Nx1NUo+BsaiBgK9nmcnmMhSbyRyMaH8ouvWkL1Idn5i5RPdPCQdT9B9YOm2XKypfvZpJGc
 kKkfmhAv3xgkzuR3KNLg5YMM
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep02.wdc.com with ESMTP; 22 Jul 2019 13:21:56 -0700
IronPort-SDR: 47/R1DIroVHv5UJbIw/9TdCX3bXCfg4Zjc4oOb9oEUswuF9xXXS0MCJs2YvWoiBHzRqLWnHUkK
 GlWA2dKMxf+uml2q7WJytbBI//ZDXLjUh31pSrLwTmlhwCl6//9AHZTgc4lfy/y6hOjuI3a+FE
 QNPJwAetO8w7TiKz4f/811YYXrg+PRlYzKHxcxLjDfCkNB3cDIzVakTTYiE849+PLTcT3jDEjT
 W+nDZqXyKMLSo+CE1vrC1o2lh7IaUG+bmRA+vCVARcLSzRSogiGgF/UPfKd3YzCzZ9HsQQ4q/U
 A4Y=
Received: from risc6-mainframe.sdcorp.global.sandisk.com (HELO
 risc6-mainframe.int.fusionio.com) ([10.196.157.140])
 by uls-op-cesaip01.wdc.com with ESMTP; 22 Jul 2019 13:23:40 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Date: Mon, 22 Jul 2019 13:20:40 -0700
Message-Id: <d24741cf9cafe8a7c708ae282c1cc6cbef2faf2a.1563826823.git.alistair.francis@wdc.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x
X-Received-From: 68.232.143.124
Subject: [Qemu-devel] [PATCH v2 1/1] riscv/boot: Fixup the RISC-V firmware
 warning
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

Fix a typo in the warning message displayed to users, don't print the
message when running inside qtest and don't mention a specific QEMU
version for the deprecation.

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 hw/riscv/boot.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/hw/riscv/boot.c b/hw/riscv/boot.c
index 5dee63011b..6b7d322e85 100644
--- a/hw/riscv/boot.c
+++ b/hw/riscv/boot.c
@@ -26,6 +26,7 @@
 #include "hw/riscv/boot.h"
 #include "hw/boards.h"
 #include "elf.h"
+#include "sysemu/qtest.h"
 
 #if defined(TARGET_RISCV32)
 # define KERNEL_BOOT_ADDRESS 0x80400000
@@ -46,10 +47,13 @@ void riscv_find_and_load_firmware(MachineState *machine,
          * In the future this defaul will change to loading the prebuilt
          * OpenSBI firmware. Let's warn the user and then continue.
         */
-        warn_report("No -bios option specified. Not loading a firmware.");
-        warn_report("This default will change in QEMU 4.3. Please use the " \
-                    "-bios option to aviod breakages when this happens.");
-        warn_report("See QEMU's deprecation documentation for details");
+        if (!qtest_enabled()) {
+            warn_report("No -bios option specified. Not loading a firmware.");
+            warn_report("This default will change in a future QEMU release. " \
+                        "Please use the -bios option to avoid breakages when "\
+                        "this happens.");
+            warn_report("See QEMU's deprecation documentation for details.");
+        }
         return;
     }
 
-- 
2.22.0



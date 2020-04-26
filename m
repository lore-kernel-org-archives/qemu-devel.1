Return-Path: <SRS0=j/lF=6K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52AA0C55194
	for <qemu-devel@archiver.kernel.org>; Sun, 26 Apr 2020 16:28:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1DF2A206DD
	for <qemu-devel@archiver.kernel.org>; Sun, 26 Apr 2020 16:28:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="DNrXkdz6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1DF2A206DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35170 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jSk98-0006Ze-2N
	for qemu-devel@archiver.kernel.org; Sun, 26 Apr 2020 12:28:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44322)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <prvs=378a396a1=alistair.francis@wdc.com>)
 id 1jSk7t-0004MI-Mt
 for qemu-devel@nongnu.org; Sun, 26 Apr 2020 12:27:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <prvs=378a396a1=alistair.francis@wdc.com>)
 id 1jSk7t-0004Hi-BH
 for qemu-devel@nongnu.org; Sun, 26 Apr 2020 12:27:29 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:30871)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=378a396a1=alistair.francis@wdc.com>)
 id 1jSk7s-00044e-Pe; Sun, 26 Apr 2020 12:27:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1587918448; x=1619454448;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=DWjMKGibQ+1ekQOajyn1eeYpIJID8nQEgbnZxxYs37U=;
 b=DNrXkdz65Ft8L+fiETNbIr+HW03i+jcSHIm49bvxZ4b4yQP+Ct5uRnSN
 lxGsLEeC+GUOC6G7VPAQDYfn4KggBcxXLn7K8RWifa/PiU3f9oyN5CWRZ
 5UPW+2QekMtLGhNOoyyL/9LLNJ0w8q/pRvx0sp2k46YMckJBUgEn/SIT3
 hbeNvHjCrd4u8JGgwQCvvt26CTIvgXR6HljIQIiykCZPCZO8cLm4tty1u
 AxT2vH+8yUp3OtsjBEWxcxQuGG8bVAXRjvCXxr5AlRRWR7RIlKqcL5NBo
 AJStrlISoILPJdM+ljPvCRQ7kqmYnPqbA1HqwLSIz5VU060Eevr0H0JXN A==;
IronPort-SDR: r0MnJ+FE9Li89q0JU4wwNLeLqX0fUF1SYBEtFvXGXqjZunqga5nZdKI6LNKQa2CyvyPWprPOZT
 vzS3flOnCZtHhIvh5BYEnAdSMLzsQffYiD3reqvASYlEFLFUfNQ4jkAIqe01sMrZvW+HKrrmDX
 QB6//WuJn0SyUfnmZC06u4lV+jTo6zlbVsPKMcTnqhjvfS3v2FFAV9zaTZVuq84ovxuGFioVXP
 67YX+zA6GFitvKjTWX9UwjzGlsTiIzTwkfCK4KzCLbYVquapXgRkFXv6GHYyAE+0R9wDID1CNF
 NWo=
X-IronPort-AV: E=Sophos;i="5.73,320,1583164800"; d="scan'208";a="136193236"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 27 Apr 2020 00:27:27 +0800
IronPort-SDR: 9FyCwXhaLW6G8MGHEz7oRwmapjp8NBD3tQj/zNG9mz/cIxADrrIls95NQJFPxKZen/ch6sTb/G
 xmVxCbb13S4LOUNNTGS1f9sAmrtnjRaH8=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Apr 2020 09:17:37 -0700
IronPort-SDR: LstrtwSbw/bLUwrSBVx8Bz9cGT1zB2IRGhvmuvouBicWkjKBo1XzL4Y2SBxAT/Fdv8uuPazBGw
 AKikpW51UrQw==
WDCIronportException: Internal
Received: from wdthnc17-0189.ad.shared (HELO risc6-mainframe.hgst.com)
 ([10.86.56.50])
 by uls-op-cesaip02.wdc.com with ESMTP; 26 Apr 2020 09:27:27 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [PATCH v1 02/15] target/riscv: Report errors validating 2nd-stage PTEs
Date: Sun, 26 Apr 2020 09:19:16 -0700
Message-Id: <416aa978887e9f86307616189207a5b015f8e82e.1587917657.git.alistair.francis@wdc.com>
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
 target/riscv/cpu_helper.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index ed64190386..0d4a7b752d 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -456,8 +456,13 @@ restart:
             hwaddr vbase;
 
             /* Do the second stage translation on the base PTE address. */
-            get_physical_address(env, &vbase, &vbase_prot, base, MMU_DATA_LOAD,
-                                 mmu_idx, false, true);
+            int vbase_ret = get_physical_address(env, &vbase, &vbase_prot,
+                                                 base, MMU_DATA_LOAD,
+                                                 mmu_idx, false, true);
+
+            if (vbase_ret != TRANSLATE_SUCCESS) {
+                return vbase_ret;
+            }
 
             pte_addr = vbase + idx * ptesize;
         } else {
-- 
2.26.2



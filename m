Return-Path: <SRS0=wZWj=WT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47C25C3A5A2
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2019 23:44:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1497421655
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2019 23:44:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="AmnRcncS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1497421655
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34924 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i1JE5-0002gI-Kt
	for qemu-devel@archiver.kernel.org; Fri, 23 Aug 2019 19:44:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49326)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <prvs=1314b2cac=alistair.francis@wdc.com>)
 id 1i1JBe-0000Z3-7P
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 19:41:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <prvs=1314b2cac=alistair.francis@wdc.com>)
 id 1i1JBd-0008Ty-7y
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 19:41:42 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:59171)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <prvs=1314b2cac=alistair.francis@wdc.com>)
 id 1i1JBc-0008T1-SX; Fri, 23 Aug 2019 19:41:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1566603701; x=1598139701;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=EolHft63t6uTu8IMAST3aFoydFsm2RQTevCGlKxXc4o=;
 b=AmnRcncSJe3LQSLrUruGrUmGmAGpug8i/vjSPazSl3OIgv7r0sP/qdCK
 NBzmUMbVHAF/R+FDtXLx9wPSDjXyt2MyGxnCzy2vedNQnYt6cVpx7Q7gu
 GHiQzmSOwRY31Wmnp0wsE3nQpajTjOyi3vz+1EOdXrQwgdeMjM4hr61U8
 sXqpZmefh2/iwxnSZoX8PX+36CjroDYVUBnv+bUnJNC8dRwXjGnZF2uQD
 c/FTQyQUb2PCSXOFvI8F3V8k1y9gulk8K92gW8PpkdlDsuBPWUXo5EUZm
 PiNK6LpPVW+7XW3MRjH9J5VhN/pCrNTCH23tRuwkAxvrmX/XxPyi6zuaU g==;
IronPort-SDR: wSqaaUYnsmuzyRQoMkt9sTlaCxxPpXDFbQa+Wru1cFgiFTX8lWZe2Tb5Penxs0ALZr35Igj0N6
 xO4M4qD13qWoovzvZe9s+Ggy/sh+CSJJYVkx9EklAGmO5Vhh+TUP+AH38NJ2oQUViMz244B64S
 oHvU3ytBR/r+e0sFLp4eVb43mXxjDvJKnHioLJ9p/KVxq7LdQ3HUFD4G/6mBjnUvioNhnQC9DZ
 rFEJebzYgFw9AMggqK8PZJcL3uiZvDJ3HQ1q/qHEbECnih4XAmQviFbLNutvEGWiWIYcd1Bc1v
 f58=
X-IronPort-AV: E=Sophos;i="5.64,422,1559491200"; d="scan'208";a="121144254"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 24 Aug 2019 07:41:41 +0800
IronPort-SDR: Vk2Gy+no9X2ql3ylETSWYf4iDvmPQKq9OMCWz4FozCg8d8eipzr0iFkcVitE6WfxJ5h/I2a273
 gq/VJkpDXr5QsqU6tEQjAP48G6HDpzjDaEncjPll3wNx4ZdNjpgfUdt/PymkSEJxsDB8igQrS0
 06p2ChV1PdrUnzKBve+SqXh60CkRX+8dlV8i4NT4OeLxDiUxmaqR8m1TCYamWX1GazrY2ZY8W1
 WnoGn+jN31FVYCawPe9UWVoBGvThxd3BRUocs5KrjYx++N5sLyT6dFFn8mK4ao33fdeT0/schO
 S87flR1JdVzRT/Rl/8vUmwS0
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Aug 2019 16:38:58 -0700
IronPort-SDR: DXb9Yc1dpkfa9w3M3uTRh38YoGv3G0EkJ3HIymrv1FXO9eziYv/Xz+c7YIFkirnNtY8GZzyILZ
 CNwjoZFBAWEooUXRZ3uvnG6VPfVXEiebCr7jrtUHszYSTVk5J6hgWh+4tvZdiLm1drLYSe+s1X
 ZE35U0mnqch/bHv6TANnom0hCl4hra+VaZvVj0q84JPBj7xVgd5XHRxbfU7p++mXcRAzcfqVXu
 jvKUE2NiH/6RABVIJzgbYjNa7aqgVmeUbdwP3TCIyv2tGKHHz7wI8IplY91waj3zQeWkGBC9TC
 jOI=
WDCIronportException: Internal
Received: from risc6-mainframe.sdcorp.global.sandisk.com (HELO
 risc6-mainframe.int.fusionio.com) ([10.196.157.58])
 by uls-op-cesaip01.wdc.com with ESMTP; 23 Aug 2019 16:41:41 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Date: Fri, 23 Aug 2019 16:38:00 -0700
Message-Id: <a090bc437bf412c279b1254d05eae5c2d67225db.1566603412.git.alistair.francis@wdc.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <cover.1566603412.git.alistair.francis@wdc.com>
References: <cover.1566603412.git.alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x
X-Received-From: 216.71.153.141
Subject: [Qemu-devel] [PATCH v1 04/28] target/riscv: Fix CSR perm checking
 for HS mode
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

Update the CSR permission checking to work correctly when we are in
HS-mode.

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/csr.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index f767ad24be..471f23a1d0 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -799,9 +799,15 @@ int riscv_csrrw(CPURISCVState *env, int csrno, target_ulong *ret_value,
 
     /* check privileges and return -1 if check fails */
 #if !defined(CONFIG_USER_ONLY)
-    int csr_priv = get_field(csrno, 0x300);
+    int csr_priv = env->priv;
     int read_only = get_field(csrno, 0xC00) == 3;
-    if ((write_mask && read_only) || (env->priv < csr_priv)) {
+
+    if (riscv_has_ext(env, RVH) && !riscv_cpu_virt_enabled(env)) {
+        /* Plus 1 as we are in HS mode */
+        csr_priv++;
+    }
+
+    if ((write_mask && read_only) || (csr_priv < get_field(csrno, 0x300))) {
         return -1;
     }
 #endif
-- 
2.22.0



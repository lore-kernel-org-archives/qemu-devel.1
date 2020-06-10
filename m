Return-Path: <SRS0=wemX=7X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E694DC433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 22:24:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AD865206F4
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 22:24:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="oFQ/ZviN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD865206F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43662 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jj98v-0000d0-VA
	for qemu-devel@archiver.kernel.org; Wed, 10 Jun 2020 18:24:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42598)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=4234ccaf3=alistair.francis@wdc.com>)
 id 1jj964-0004aq-5f; Wed, 10 Jun 2020 18:21:24 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:59148)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=4234ccaf3=alistair.francis@wdc.com>)
 id 1jj963-00024C-6O; Wed, 10 Jun 2020 18:21:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1591827683; x=1623363683;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=6FATJBjY3MEsYgFLnJ2w8QG6m7aF0O7YWGLLllI2F4A=;
 b=oFQ/ZviNFRjYX9JYfXkHpz9pqk46dCpVNeUc1O21RrWUwM2LT5O2ZHNr
 VuJMfXoZEFhyKTWUCGJXFGKmOmmzo3nC4IgAbfjWkgOAMDZbZWezQ6j5D
 EcgBxGspIAHNJlzbNLKjwo9fYvo3j6To+z5n47yhbMUnnPYFJ/JE9hhdu
 4qmNChfxQAnHId/oiEIs4rXj9faRm3V7iJ2pxrzMx1unAStqBqzwDahJW
 0fVb3/cUkogr/Gxw2+zX8Qd/lPlavSz/yokaRpon+40FWj1QqhQlU14ES
 XIAGm84MF+Y478ymSR137JIE2RXIpFYbQ8m076iE56rHrnBYUgN3lKA6d w==;
IronPort-SDR: Dx/UHrjUbuwzP/P9ftiP8mv7iRg48fhVC7Ma+PNh0fiUcvXXGSzPI2djQJE77X3aSS2QfglYdz
 SC1X+y01kAP+1vvx7WAIEKJMoAIDgr6qvaWwqv4qu1/pj5wNKRz8+JJrGThgVKIvgZLXMqIWo1
 yVd8iGRVxGxPMnCvDTrgpvMKfnLz/nmCinX5SYl/GQcfFBqmxMjJ57ZssGY/4w9iiPSxdTdB5G
 ho3Nf5B1RwpSbcalAz0MehmaV8CqQ0NjuQf6n+pRIsSjRfAUVNmzoEe9OyWebA+ULMbdj4bXiF
 NyU=
X-IronPort-AV: E=Sophos;i="5.73,497,1583164800"; d="scan'208";a="248819324"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 11 Jun 2020 06:21:21 +0800
IronPort-SDR: AnBQIcO39xAKUJDqokY6DScpXWgo/3XeA8wyZxIcEtvysyERBiSAT/NluIWzSVUOsLG81uf27y
 4LTVZ60Z/o8FNE1DJrVJMtkuNnvzxgp6U=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Jun 2020 15:10:48 -0700
IronPort-SDR: yHkgDLrwQGKDM/lc3pqkFTZ7oQStdCzRA00Flc6E8aYPIYWGooBbhE4K+bxA99Tz47hY1V2ejC
 aFKlHypwbylA==
WDCIronportException: Internal
Received: from us4qd5p12.ad.shared (HELO risc6-mainframe.hgst.com)
 ([10.86.58.34])
 by uls-op-cesaip02.wdc.com with ESMTP; 10 Jun 2020 15:21:21 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [PATCH v6 6/6] target/riscv: Use a smaller guess size for no-MMU PMP
Date: Wed, 10 Jun 2020 15:12:25 -0700
Message-Id: <563998aa064518eea5ae5495a6639f16d881844f.1591827110.git.alistair.francis@wdc.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1591827110.git.alistair.francis@wdc.com>
References: <cover.1591827110.git.alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=68.232.141.245;
 envelope-from=prvs=4234ccaf3=alistair.francis@wdc.com;
 helo=esa1.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/10 18:21:06
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
Cc: alistair.francis@wdc.com, palmer@dabbelt.com, alistair23@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Bin Meng <bin.meng@windriver.com>
---
 target/riscv/pmp.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/target/riscv/pmp.c b/target/riscv/pmp.c
index 0e6b640fbd..9418660f1b 100644
--- a/target/riscv/pmp.c
+++ b/target/riscv/pmp.c
@@ -233,12 +233,16 @@ bool pmp_hart_has_privs(CPURISCVState *env, target_ulong addr,
         return true;
     }
 
-    /*
-     * if size is unknown (0), assume that all bytes
-     * from addr to the end of the page will be accessed.
-     */
     if (size == 0) {
-        pmp_size = -(addr | TARGET_PAGE_MASK);
+        if (riscv_feature(env, RISCV_FEATURE_MMU)) {
+            /*
+             * If size is unknown (0), assume that all bytes
+             * from addr to the end of the page will be accessed.
+             */
+            pmp_size = -(addr | TARGET_PAGE_MASK);
+        } else {
+            pmp_size = sizeof(target_ulong);
+        }
     } else {
         pmp_size = size;
     }
-- 
2.26.2



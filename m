Return-Path: <SRS0=GK8b=7B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BE5EC433E1
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2020 21:48:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 25AC6205CB
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2020 21:48:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Dp9PX7cC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 25AC6205CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46156 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbA5s-00088b-Cf
	for qemu-devel@archiver.kernel.org; Tue, 19 May 2020 17:48:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39154)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=401675184=alistair.francis@wdc.com>)
 id 1jb9yR-0004xn-Qj; Tue, 19 May 2020 17:40:31 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:10366)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=401675184=alistair.francis@wdc.com>)
 id 1jb9yN-0008RL-5Y; Tue, 19 May 2020 17:40:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1589924453; x=1621460453;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=Yh6HDSpcIAYYoDrW0RtvHeW2Y2DC83cZu3PMMp8py4o=;
 b=Dp9PX7cCwJtR20FxnSSebpeSikszOPYVYBUjxfuth56cn6fZcjHNsHur
 SWvdqB9z+AnANL9iEzJ0mu6OjeD2VUSQqUc9f1wHnR7dQeVgD37ljZ2mB
 sNaNcrSD7kTPspVgIaBycyL/NmYCj0fZChgtzz3Oke46IfNCHU70IWIKK
 2vus4hzv4cJXjSWX3nwu0P5gq9xOygB7afLGH+YlXPjLXT5HnmM9I4PlC
 HArqou+K2d8Kz+Po6A90u1PyaxD3W5GZSpiH5uWt95S3HoFo9/l/mXPyj
 K7c91+VZlYzUN4tqr/w+ajjfnfDv7GMlNTar8V8+NTvX+RtUReTW4jSaU w==;
IronPort-SDR: wUTirav6ksxlH12u0k4VYHKg679oeD6HgZWeyxVepi+PpMLxPraU12tyuQupsUw0W6PASNA8x7
 gHjqT68ZSbVp4rcn6KSf879AIf+ZwtWAK+4IAxjJ0eScPGl4T+VYEUT8AjS/jeH05KlAFr9363
 AFAE1inHQe+1ADHA6jiG36HogqxIeO5YZhTbJ4uquwcTOfTV5ojsi8iNV3NOu7jEkrTV0RVwDf
 ixHll/hDFHkyoPj9ycS0uVgHnWPaYgjQYBVKgfjL56joQGsb2zJdCDIbW3s9Gt5Lw0Xs6WEhUh
 OL4=
X-IronPort-AV: E=Sophos;i="5.73,411,1583164800"; d="scan'208";a="240814214"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 20 May 2020 05:40:38 +0800
IronPort-SDR: Ll6DDovsWTd0voglFK0fDuWLPQyMVucCcuvqA4xe7J1MLZHUjXLiIksFt/56uB/n9n3ESgVAse
 UvEgdz/X6lA94hXctWM34S0jtOhMYOR8Y=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 May 2020 14:29:48 -0700
IronPort-SDR: QiaGgoXzUZE/LdS08KnsAsYxMXdXF3CzJkls5tLdqxEbSgo9mB/Z6/RyYv2aIio4D1/GoPZ5JY
 +++JjwQ4fcHw==
WDCIronportException: Internal
Received: from usa005149.ad.shared (HELO risc6-mainframe.hgst.com)
 ([10.86.57.14])
 by uls-op-cesaip01.wdc.com with ESMTP; 19 May 2020 14:40:17 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [PATCH v3 9/9] target/riscv: Use a smaller guess size for no-MMU PMP
Date: Tue, 19 May 2020 14:31:50 -0700
Message-Id: <c8b00dc5d38574f05be4c8c15549deb431aeba02.1589923785.git.alistair.francis@wdc.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1589923785.git.alistair.francis@wdc.com>
References: <cover.1589923785.git.alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=68.232.143.124;
 envelope-from=prvs=401675184=alistair.francis@wdc.com;
 helo=esa2.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/19 17:39:51
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_PASS=-0.001,
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
Cc: alistair.francis@wdc.com, philmd@redhat.com, bmeng.cn@gmail.com,
 palmer@dabbelt.com, alistair23@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/pmp.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/target/riscv/pmp.c b/target/riscv/pmp.c
index 0e6b640fbd..607a991260 100644
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
+        if (!riscv_feature(env, RISCV_FEATURE_MMU)) {
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



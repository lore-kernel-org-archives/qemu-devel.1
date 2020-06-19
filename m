Return-Path: <SRS0=Yszf=AA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 165CBC433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2020 06:41:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D44EF207DD
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2020 06:41:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="AIWnozUi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D44EF207DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59066 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jmAiP-0007OU-TS
	for qemu-devel@archiver.kernel.org; Fri, 19 Jun 2020 02:41:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56756)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=4324eb4de=alistair.francis@wdc.com>)
 id 1jmAbk-0005XJ-R4
 for qemu-devel@nongnu.org; Fri, 19 Jun 2020 02:34:36 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:13005)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=4324eb4de=alistair.francis@wdc.com>)
 id 1jmAbj-00028f-20
 for qemu-devel@nongnu.org; Fri, 19 Jun 2020 02:34:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1592548475; x=1624084475;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=81HMh1gHLXQkIcSglIbxP90s73UN4Lp7ZsuwWeLGYlk=;
 b=AIWnozUifxHyphXIPw36HMQDmu0I8qx15V+/jcI4bR0aBqNGcmXBZ2zS
 Ma6ncXSU7Rh26PYAyoWIMTTVjG5M7lu9NvoQpjhzWTHpzGHqM7urPQ7os
 2sBc3Lun1PDm09BRKqpy9wldeV2fpNUXUfmJACXNicoGJy3FzdV3hfztt
 PcXnnCkLxJuJuA5yU9Bwd+8Mt2tRVzfgVrwZgfX8JfOY+5v/qRxRCRyQj
 RkkwzoFP47mIM81aNX/pmZB6XNbfbr8cjbfHIPikNGPUgveQxwjetO6ZW
 magMKFz6Rl/xXnrOC4RJuorwTVbDjZyN9pj2N1yqD9IVOIyziR6KyqZTL g==;
IronPort-SDR: 6YU/xc7pB7HBxSGyrZ/oXG4aSSDqu9kWKbjWMT3pAEdUwwGqHbTqt5O2C1Zi0yTcmr+jsnHqne
 32bUHXofdaq+Shdm1DwuayKeUYwyBGO8/fdgFk/KP2szxEVUhdn9+iGO9fSxoH+/PSuJJbkqDR
 yJ3OWlmwYe9NYtIwqcotPUEg+b8frcr/LBKIQcMIpe1SRcZ4TycZ6nafuSHsbmMaEWG3006qom
 455ZFMa4L0eyBFlPnxo3YWnT/VlvuuyW7rjppCvNdMmW+4R5Cntj3oqrVNHvAKyDB5STDfipPt
 KBo=
X-IronPort-AV: E=Sophos;i="5.75,253,1589212800"; d="scan'208";a="141781921"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 19 Jun 2020 14:34:30 +0800
IronPort-SDR: sV0i2k15rjEQxay+ane3BjlfzHC7j3/nQm+D8/MffmnneQhpep7QiWtUA3g8kiBOzY7/aosnsn
 D9rKobpukEv9y5PHzELbCj8UCBL/BKDK0=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Jun 2020 23:23:41 -0700
IronPort-SDR: gQ4e8hMrQWV1EPk/fMwc84GL7zT9K2XPLcT/hx0mElAlkpKmuhDTNnw9zqHuRdS2rQjJKikqiX
 Gt3mzh2pccrg==
WDCIronportException: Internal
Received: from unknown (HELO risc6-mainframe.hgst.com) ([10.86.58.142])
 by uls-op-cesaip02.wdc.com with ESMTP; 18 Jun 2020 23:34:29 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: peter.maydell@linaro.org,
	qemu-devel@nongnu.org
Subject: [PULL 16/32] target/riscv: Use a smaller guess size for no-MMU PMP
Date: Thu, 18 Jun 2020 23:25:02 -0700
Message-Id: <20200619062518.1718523-17-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200619062518.1718523-1-alistair.francis@wdc.com>
References: <20200619062518.1718523-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.71.154.45;
 envelope-from=prvs=4324eb4de=alistair.francis@wdc.com;
 helo=esa6.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/19 02:34:29
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
Cc: alistair23@gmail.com, Bin Meng <bin.meng@windriver.com>,
 Alistair Francis <alistair.francis@wdc.com>
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
2.27.0



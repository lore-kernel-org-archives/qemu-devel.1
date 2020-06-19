Return-Path: <SRS0=Yszf=AA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C5C7C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2020 17:14:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 628D720DD4
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2020 17:14:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="dGxSDty1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 628D720DD4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58002 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jmKaw-0001A8-K6
	for qemu-devel@archiver.kernel.org; Fri, 19 Jun 2020 13:14:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58110)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=4324eb4de=alistair.francis@wdc.com>)
 id 1jmKUD-0000g4-MA
 for qemu-devel@nongnu.org; Fri, 19 Jun 2020 13:07:29 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:24436)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=4324eb4de=alistair.francis@wdc.com>)
 id 1jmKUC-0004Q3-0k
 for qemu-devel@nongnu.org; Fri, 19 Jun 2020 13:07:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1592586450; x=1624122450;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=81HMh1gHLXQkIcSglIbxP90s73UN4Lp7ZsuwWeLGYlk=;
 b=dGxSDty1cWip2XsHIOLvERz/K0SzG6yeArbvur7gh0qHkYLxrTzHnSfw
 qBCX3qhyKZZtytzueh0Q23icS6VdA1TBuZa1Lex80kvhrwWhAozkA6C0d
 SC7HDDiTUIpRTg2meZ91trJRXctEJgE0Ui4XukkWGXr1jWIaAUAJXj9rP
 GA/e4BwlslAsqwc7n6VH+S41tVMIE/8I8InXdm3Fdmp461zWKapdwhRNc
 AbfTEE+lS6zz3/WF74G+i3x4THTaygWzFLupH9gE3WSJQ0rS86ow/dVHD
 vJlUaU40MmdpZwstPw8nlBpDwVhD5flw26EBTLAvTH4TodYemUNFhe35j w==;
IronPort-SDR: WU8S5MvgT+xIXU0JjsnyhyJHRmgdKspnkYfBb2n/E5qeRqUdiZXOTCui7z2JCEbpNef2N84CYb
 1dBoi3ei+A3kjrvWQURamtbPZ/B9gmvjSbvbsCRrqfMdtcZ66tbVUicjQ+upFAfhJZuBXYgZ7K
 fq6/nsqzJnvciT75xD3Co7LPxVLCmAXBJbpnPQiq7Zf7Oc4iVSzGBT/sNv1WnVlwBJmodVkWUs
 LlQ2BN/p0+f/1kN4i8rj0mmKeeFyFt/cpLEhpzTLKLNEiD5DRHyART1OfcdEu2Z72DKOQeFKkO
 d6k=
X-IronPort-AV: E=Sophos;i="5.75,256,1589212800"; d="scan'208";a="243416995"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 20 Jun 2020 01:07:26 +0800
IronPort-SDR: r6eGJskz6iMRkve7RjR6KA56/QSe789VlGmmfjSmhnZ0KKUV++EfRlyFstzzoMC/9FY0/DqFWc
 SArityFtDh00uQLUN/jFP8oypnag/MQZA=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Jun 2020 09:56:02 -0700
IronPort-SDR: kP8VdEr8/OSTHb8AWKYhVJYtLsb0y0ihSBhb3HE2gUDINx4RB+MDjge6evsI5i6v3OdHv0uTau
 /e3KJycCuIGg==
WDCIronportException: Internal
Received: from unknown (HELO risc6-mainframe.hgst.com) ([10.86.58.142])
 by uls-op-cesaip02.wdc.com with ESMTP; 19 Jun 2020 10:07:25 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: peter.maydell@linaro.org,
	qemu-devel@nongnu.org
Subject: [PULL v2 16/32] target/riscv: Use a smaller guess size for no-MMU PMP
Date: Fri, 19 Jun 2020 09:58:01 -0700
Message-Id: <20200619165817.4144200-17-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200619165817.4144200-1-alistair.francis@wdc.com>
References: <20200619165817.4144200-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=68.232.143.124;
 envelope-from=prvs=4324eb4de=alistair.francis@wdc.com;
 helo=esa2.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/19 13:07:24
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



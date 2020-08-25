Return-Path: <SRS0=2GMi=CD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 303F6C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 19:08:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 063D52074D
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 19:08:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Vl+IvyGF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 063D52074D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52584 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAeIa-0001dt-Af
	for qemu-devel@archiver.kernel.org; Tue, 25 Aug 2020 15:08:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33616)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=49978a6e9=alistair.francis@wdc.com>)
 id 1kAeAR-0004Nl-4u
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 14:59:36 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:58813)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=49978a6e9=alistair.francis@wdc.com>)
 id 1kAeAM-0002w2-L1
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 14:59:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1598381971; x=1629917971;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=JaJgYijSy03N5csPGH2OpxKfJYtfl+mklbnHCVhdze8=;
 b=Vl+IvyGFpQxefkdykrzuNa41pCmRXf0RKXxcScoAC350oToWl7EddgbI
 oxsk23iiuGxnny5TbIXdAOrFCQmSaYk8a5SfPyvbC+8kdFy5r4Z6dJk8c
 Y7jr3n/GBsRgEjttw3uWXiW8jQnQGh++vStBaDlrh9m2y8gC5Kj7kCn5G
 eCD2P4uOpPIJDtzvPvB8Z9QcOjX4Mo7LLjin4OOSTvGy19qP3EjYjuIHX
 fT7DblL9M5L76Lw2vW000mT1PNtUyP1jvwBG/J+kb3ejZZLuXUcTsNQ8d
 TOdiUWqid/EhIYlVC43OrnFwbbu2OR34YHVmGwQ5KpcUFEpzFvVpZT3jc g==;
IronPort-SDR: ApM165vkjISWVrH4yemg+3/PjfgrkvaYKgbOSRqePIu9a3HWakWtGSLDZwvKKytRgLwl/E331Z
 4RL/IwPMMLePUrkNgVT+PEw2yB6ncR1WdhqmNB3714855jdXF2zL/IA4TDyz4rBFhAdXnoDgBi
 PM2xcDz57Vwjt/+vxeN9N9lcTr3KU7xJDbIAx3JLryreUQ5L+ZhAg/Y15l1sYuhJbXBezE6dIC
 tH0FU0fdw3yp9J/rThPzfWvvAtzZlFKI+mUxhOhYbgWJ7vCpVV97HTe5mgeR5aPEgQPCoSocE/
 R6U=
X-IronPort-AV: E=Sophos;i="5.76,353,1592841600"; d="scan'208";a="150145298"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 26 Aug 2020 02:58:58 +0800
IronPort-SDR: FJxIg1ToPckyujRr3XB2jn0aEhoZgFt99OtJdjiulj/wH9HhTRsgrdFdF7woNJH1Yp9Lv/mYsU
 ukpuaxiAN3Eg==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Aug 2020 11:46:33 -0700
IronPort-SDR: FWXWQxX9JR6c53mSDHMFPpwds9AJa1YnkpbBoNscVNDTRh0oZlTWFuCgcJHt/C82SdJo3TEVwh
 2yONIte4Czpg==
WDCIronportException: Internal
Received: from ind003389.ad.shared (HELO risc6-mainframe.hgst.com)
 ([10.86.59.125])
 by uls-op-cesaip02.wdc.com with ESMTP; 25 Aug 2020 11:58:56 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Subject: [PULL 15/18] target/riscv: Only support little endian guests
Date: Tue, 25 Aug 2020 11:48:33 -0700
Message-Id: <20200825184836.1282371-16-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200825184836.1282371-1-alistair.francis@wdc.com>
References: <20200825184836.1282371-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.71.153.141;
 envelope-from=prvs=49978a6e9=alistair.francis@wdc.com;
 helo=esa3.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/25 14:58:53
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: alistair23@gmail.com, alistair.francis@wdc.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
Message-id: 93e5d4f13eca0d2a588e407187f33c6437aeaaf9.1597259519.git.alistair.francis@wdc.com
Message-Id: <93e5d4f13eca0d2a588e407187f33c6437aeaaf9.1597259519.git.alistair.francis@wdc.com>
---
 target/riscv/csr.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index 390ef781e4..5e50683c58 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -840,6 +840,8 @@ static int read_hstatus(CPURISCVState *env, int csrno, target_ulong *val)
     /* We only support 64-bit VSXL */
     *val = set_field(*val, HSTATUS_VSXL, 2);
 #endif
+    /* We only support little endian */
+    *val = set_field(*val, HSTATUS_VSBE, 0);
     return 0;
 }
 
@@ -851,6 +853,9 @@ static int write_hstatus(CPURISCVState *env, int csrno, target_ulong val)
         qemu_log_mask(LOG_UNIMP, "QEMU does not support mixed HSXLEN options.");
     }
 #endif
+    if (get_field(val, HSTATUS_VSBE) != 0) {
+        qemu_log_mask(LOG_UNIMP, "QEMU does not support big endian guests.");
+    }
     return 0;
 }
 
-- 
2.28.0



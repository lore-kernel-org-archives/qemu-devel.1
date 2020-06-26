Return-Path: <SRS0=ZkAM=AH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 722FEC433E2
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 22:01:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3B93E2089D
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 22:01:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="BctFFJs5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B93E2089D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55724 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jowPo-0006mg-DA
	for qemu-devel@archiver.kernel.org; Fri, 26 Jun 2020 18:01:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52852)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=439617756=alistair.francis@wdc.com>)
 id 1jowI9-0002yh-C6
 for qemu-devel@nongnu.org; Fri, 26 Jun 2020 17:53:49 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:52699)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=439617756=alistair.francis@wdc.com>)
 id 1jowI2-0002zs-8X
 for qemu-devel@nongnu.org; Fri, 26 Jun 2020 17:53:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1593208423; x=1624744423;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=dYv8bqAD0WGQ3WUI/kMiuSlCd/PrVqejt8DCeLQyEfU=;
 b=BctFFJs5hTZT35TqHQBd/P/4Z62LDd1efUr13MxYstQh3swFDzrTS61T
 EAh84jAdpCzZS8msydENB37M9KHF8Xicx81TyixvYMSyILZ/0vhO/CN5/
 kk4LSF18ddWnQZP13bvj/kuSz/z0f18WYhxlv/F204OylhQdM67F5h80C
 6d+rGvLUyzDQrGgRyTSb8m/pyEaAsK6rT9ChmOhi+qKMXniJXGTjZU2on
 o+EDYts8JkxdWFwdLknwu22ab+0obz7qGqHk/10SCudvKkoNWSlWzdhNG
 ieKbsTaLtfzR/1kIiTpW+K7ErXyR3dWhjmI7U6vIt6iqOrQKVxH6sAmcH g==;
IronPort-SDR: 6FfnwU4piG76Zwjmc86bIJgVsBVNKVhIhcp2SOavx5w65YDlr2Y1Yb27OAreJJSBP6sdL8rmqr
 HfK0RgenS3JDJInVm9jmAs62y0YDPyh9PJMUMdvZ9NlN/lQg506idBdFu0qhMy7gMK1kVEdjUA
 cA3iaTy7kAoSGlXF8pUekkA48uqBH8k0h2ENoZ+gnaf8LK25sFKUpMJViozdE++bC67Hs9RV+X
 7WZa/CqCDT0AJYDF4fcY8aU0hK6BDQn7wcHjYWvFn8tyxy8bUydXPdV1oK/qNzqt0j0f+a0Nwo
 F+g=
X-IronPort-AV: E=Sophos;i="5.75,285,1589212800"; d="scan'208";a="145360019"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 27 Jun 2020 05:53:36 +0800
IronPort-SDR: N2TN43McSVXv/lD+u3IOLVrNrrvmKN1SFKnmjnLqMmsHJGOycgD2uKZmVQ0gp8YqIMk5/F66Sm
 edQOh4lPTH2iikya7eMM/+SolrzRTSJOI=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Jun 2020 14:42:33 -0700
IronPort-SDR: +9ztdh4418I/ynQ0Vo7s5Xk4a9OjEI3o65w64IgwFZxlM8Iecxu5JP8BHYUpOWZw+PLd2ZliMK
 xyBs6kscll2w==
WDCIronportException: Internal
Received: from 2hc7cg2.ad.shared (HELO risc6-mainframe.hgst.com)
 ([10.86.58.206])
 by uls-op-cesaip01.wdc.com with ESMTP; 26 Jun 2020 14:53:35 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: peter.maydell@linaro.org,
	qemu-devel@nongnu.org
Subject: [PULL 03/63] target/riscv: add vector extension field in CPURISCVState
Date: Fri, 26 Jun 2020 14:43:10 -0700
Message-Id: <20200626214410.3613258-4-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200626214410.3613258-1-alistair.francis@wdc.com>
References: <20200626214410.3613258-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.71.153.141;
 envelope-from=prvs=439617756=alistair.francis@wdc.com;
 helo=esa3.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/26 17:53:34
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
Cc: alistair23@gmail.com, Richard Henderson <richard.henderson@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>, LIU Zhiwei <zhiwei_liu@c-sky.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: LIU Zhiwei <zhiwei_liu@c-sky.com>

The 32 vector registers will be viewed as a continuous memory block.
It avoids the convension between element index and (regno, offset).
Thus elements can be directly accessed by offset from the first vector
base address.

Signed-off-by: LIU Zhiwei <zhiwei_liu@c-sky.com>
Acked-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20200623215920.2594-2-zhiwei_liu@c-sky.com
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.h       | 12 ++++++++++++
 target/riscv/translate.c |  3 ++-
 2 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 80569f0d44..0018a79fa3 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -59,6 +59,7 @@
 #define RVA RV('A')
 #define RVF RV('F')
 #define RVD RV('D')
+#define RVV RV('V')
 #define RVC RV('C')
 #define RVS RV('S')
 #define RVU RV('U')
@@ -88,9 +89,20 @@ typedef struct CPURISCVState CPURISCVState;
 
 #include "pmp.h"
 
+#define RV_VLEN_MAX 512
+
 struct CPURISCVState {
     target_ulong gpr[32];
     uint64_t fpr[32]; /* assume both F and D extensions */
+
+    /* vector coprocessor state. */
+    uint64_t vreg[32 * RV_VLEN_MAX / 64] QEMU_ALIGNED(16);
+    target_ulong vxrm;
+    target_ulong vxsat;
+    target_ulong vl;
+    target_ulong vstart;
+    target_ulong vtype;
+
     target_ulong pc;
     target_ulong load_res;
     target_ulong load_val;
diff --git a/target/riscv/translate.c b/target/riscv/translate.c
index ce71ca7a92..b269f15920 100644
--- a/target/riscv/translate.c
+++ b/target/riscv/translate.c
@@ -32,7 +32,7 @@
 #include "instmap.h"
 
 /* global register indices */
-static TCGv cpu_gpr[32], cpu_pc;
+static TCGv cpu_gpr[32], cpu_pc, cpu_vl;
 static TCGv_i64 cpu_fpr[32]; /* assume F and D extensions */
 static TCGv load_res;
 static TCGv load_val;
@@ -887,6 +887,7 @@ void riscv_translate_init(void)
     }
 
     cpu_pc = tcg_global_mem_new(cpu_env, offsetof(CPURISCVState, pc), "pc");
+    cpu_vl = tcg_global_mem_new(cpu_env, offsetof(CPURISCVState, vl), "vl");
     load_res = tcg_global_mem_new(cpu_env, offsetof(CPURISCVState, load_res),
                              "load_res");
     load_val = tcg_global_mem_new(cpu_env, offsetof(CPURISCVState, load_val),
-- 
2.27.0



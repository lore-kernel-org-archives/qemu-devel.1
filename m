Return-Path: <SRS0=MTtZ=AN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 305C0C433DF
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 16:38:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EA09420720
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 16:38:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="ivIAu3BY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA09420720
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41618 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jr2Ek-0007av-7L
	for qemu-devel@archiver.kernel.org; Thu, 02 Jul 2020 12:38:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33636)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=4451fe355=alistair.francis@wdc.com>)
 id 1jr29o-00048f-CR
 for qemu-devel@nongnu.org; Thu, 02 Jul 2020 12:33:52 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:44864)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=4451fe355=alistair.francis@wdc.com>)
 id 1jr29l-00008e-KM
 for qemu-devel@nongnu.org; Thu, 02 Jul 2020 12:33:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1593707629; x=1625243629;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=VqCLOdpWLjW3UVkT28adIjoxd87YQskxgxcfATZZN/c=;
 b=ivIAu3BYO84kulbASSiIy0d4xqIrnUtazEwCptKTwyICqGE4ttzrdEoB
 a+SotRugA5/2e2U0qWNYvUEF3LA3FnkW9VLSLKZBs857Sfen9AcAkO2Qr
 3Z2kUd2LkfBqsIE1sPoOIO9pMaKZBXThZsVA5J6fkTWxcomujckOFePbx
 TEXfDyE7VA4z7z//vWXO0sermKm8hKI4yJc7CKaKE70dptMv08kr8l/K/
 xR/5f/EvaHa9p0CDXiJ/jnsCp9Dz7C7ydgvHEQp7k6slH+8dUMNrX2rtS
 viUb6RY/eT3EqHWsz5iNBQpklDJ6YS0b7HkEKYGIqVh9Wd/ADsEaB0xso w==;
IronPort-SDR: FKMIPQ+2eC1ab0ekGzx1fW/5PdduN8uzDCi68x5USv8gHXJiSkuAZ7tQxygJH6t7GYUK6eDYxE
 8KEAq0rx0WTSnyYWZ4BPE8Wc3somm5V71V//Gm2eaL4mUEtds/L/3Ukf0BIz/wpRZIpWcOuWHd
 Csy9RIWvoPvZ5MgBart5Yn1KCsleRsh/zv91Dgyf5ZGhxabeShXnb/w9gGjL05fZ0pONh4n/9i
 iQPAzrHrQ0Eqq5zhAUQvwxkClgwhwVtUAPGX0/40P7fYcsD2UQc4/9e86gye1IO0jdlw2GfqMP
 wLk=
X-IronPort-AV: E=Sophos;i="5.75,304,1589212800"; d="scan'208";a="141498465"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 03 Jul 2020 00:33:20 +0800
IronPort-SDR: MbhZj/X6S3zst7hC7Qmm3EPuKBNflQXMUVj2u8p0oc5LYdHsdif9zk/zGGxftwl+v61Hh7AMbZ
 0Qp7J5V24aBRsvK0hjqIYhwnLZL8nkQKw=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Jul 2020 09:21:35 -0700
IronPort-SDR: wg6V2wA7dSJBh5/lV4a3BN/HsI0/SJeDeJWwBTtpP/DdCJwzRXip4TyPvIle/9OyAuCU5L8OFU
 ZR0MYPYOkYjw==
WDCIronportException: Internal
Received: from 6hj08h2.ad.shared (HELO risc6-mainframe.hgst.com)
 ([10.86.58.118])
 by uls-op-cesaip01.wdc.com with ESMTP; 02 Jul 2020 09:33:20 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: peter.maydell@linaro.org,
	qemu-devel@nongnu.org
Subject: [PULL v2 04/64] target/riscv: add vector extension field in
 CPURISCVState
Date: Thu,  2 Jul 2020 09:22:54 -0700
Message-Id: <20200702162354.928528-5-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200702162354.928528-1-alistair.francis@wdc.com>
References: <20200702162354.928528-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.71.154.42;
 envelope-from=prvs=4451fe355=alistair.francis@wdc.com;
 helo=esa4.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/02 12:33:30
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
Message-Id: <20200701152549.1218-2-zhiwei_liu@c-sky.com>
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



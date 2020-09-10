Return-Path: <SRS0=7f1Q=CT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7B54C43461
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 18:24:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 299272076C
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 18:24:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="NtIq+q+4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 299272076C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34546 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kGRF8-0000rI-3m
	for qemu-devel@archiver.kernel.org; Thu, 10 Sep 2020 14:24:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56960)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=515d47f05=alistair.francis@wdc.com>)
 id 1kGRBJ-0003bR-Ia
 for qemu-devel@nongnu.org; Thu, 10 Sep 2020 14:20:25 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:28248)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=515d47f05=alistair.francis@wdc.com>)
 id 1kGRBF-0002j9-8a
 for qemu-devel@nongnu.org; Thu, 10 Sep 2020 14:20:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1599762021; x=1631298021;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=jsyBOr6d4kpx/wa6iWDrWapk7zk9J6ee0j6qg7YbxLg=;
 b=NtIq+q+4ma68UzSxLAKY+X4rkNbIwdUZVT4NkMxjqQphcaG3e9e+rSYB
 3uu43fjGih6tExFSjYWcV0k9dDy2Qrv/iVzBiC1BGy2Mcdh/byeRjdGR8
 fV42/Jmc3ENhj4+Cwf6JRLYUaSRfACK4OuqKM6/yMnJKbovnWauI50wl6
 djUV9gOtVdC7LA9aHM5ja8eTJRvVTuG7CJUtzKOu+3u8W2G9x1qAJ0mFY
 DQlzkPrIhfTohd1vX/8yEmQDY9jnGS8CxT/K33lhGlgDJAE7ylV1pb9rN
 hdGWQTsfcWt333AwL4IuiHeGwwPrY2vU5iByydFq4gbAQ15S30G2yf3XJ w==;
IronPort-SDR: zKPryPBEB+HRIrJoP289x7h4IjoRlJxfAT0hjOrfmim/e0/g2jfRI3qMKDzTIyRWvPWbHf8cF+
 mx79VVvsHNqBtGBJf4qR+xfAdSA2gbK6i0X/NjFkQoLj7lUvWfqxgYkhIEvDNeTvoGV1JE6c7g
 uTDN4x5BBdQ8/9zyWxb5jOgNKo/zBuH8feQ3JARtzUkX+RJxDj37b9vsTkI8sdHvl4dHDl7f5I
 D/idpdK+R1Nem/2oCqlA0IhlS3MLY3Bs93cdDYEPFGZziwHFc9nv//IRnHKvQUPz+AX1hw0+uB
 9aQ=
X-IronPort-AV: E=Sophos;i="5.76,413,1592841600"; d="scan'208";a="146979202"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 11 Sep 2020 02:20:14 +0800
IronPort-SDR: QEY3Rza+coTol7Gv4FRLd5cqRiHsA4/hRCMVs5bow6UAN3t2u+c1gxtvA8A4ujgBFKYmlRsV9t
 o5zpUFn07kRA==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Sep 2020 11:07:31 -0700
IronPort-SDR: kKL8miW+kbcuMjIGPFf+MbhuXlvVrwz9CIxxlTlV7HN3CtllX5BKp1Hr40qmjglpPbQsy6Mj77
 mcr+KsiUFowA==
WDCIronportException: Internal
Received: from fwvkpc2.ad.shared (HELO risc6-mainframe.hgst.com)
 ([10.86.59.152])
 by uls-op-cesaip01.wdc.com with ESMTP; 10 Sep 2020 11:20:14 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: peter.maydell@linaro.org,
	qemu-devel@nongnu.org
Subject: [PULL 01/30] target/riscv: Fix bug in getting trap cause name for
 trace_riscv_trap
Date: Thu, 10 Sep 2020 11:09:09 -0700
Message-Id: <20200910180938.584205-2-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200910180938.584205-1-alistair.francis@wdc.com>
References: <20200910180938.584205-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.71.154.42;
 envelope-from=prvs=515d47f05=alistair.francis@wdc.com;
 helo=esa4.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/10 14:20:04
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
Cc: alistair23@gmail.com, Alistair Francis <alistair.francis@wdc.com>,
 Yifei Jiang <jiangyifei@huawei.com>, Yipeng Yin <yinyipeng1@huawei.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Yifei Jiang <jiangyifei@huawei.com>

When the cause number is equal to or greater than 23, print "(unknown)" in
trace_riscv_trap. The max valid number of riscv_excp_names is 23, so the last
excpetion "guest_store_page_fault" can not be printed.

In addition, the current check of cause is invalid for riscv_intr_names. So
introduce riscv_cpu_get_trap_name to get the trap cause name.

Signed-off-by: Yifei Jiang <jiangyifei@huawei.com>
Signed-off-by: Yipeng Yin <yinyipeng1@huawei.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-Id: <20200814035819.1214-1-jiangyifei@huawei.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.h        |  1 +
 target/riscv/cpu.c        | 11 +++++++++++
 target/riscv/cpu_helper.c |  4 ++--
 3 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 383808bf88..d3589ae6ea 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -312,6 +312,7 @@ extern const char * const riscv_fpr_regnames[];
 extern const char * const riscv_excp_names[];
 extern const char * const riscv_intr_names[];
 
+const char *riscv_cpu_get_trap_name(target_ulong cause, bool async);
 void riscv_cpu_do_interrupt(CPUState *cpu);
 int riscv_cpu_gdb_read_register(CPUState *cpu, GByteArray *buf, int reg);
 int riscv_cpu_gdb_write_register(CPUState *cpu, uint8_t *buf, int reg);
diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 228b9bdb5d..bcdce85c5e 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -96,6 +96,17 @@ const char * const riscv_intr_names[] = {
     "reserved"
 };
 
+const char *riscv_cpu_get_trap_name(target_ulong cause, bool async)
+{
+    if (async) {
+        return (cause < ARRAY_SIZE(riscv_intr_names)) ?
+               riscv_intr_names[cause] : "(unknown)";
+    } else {
+        return (cause < ARRAY_SIZE(riscv_excp_names)) ?
+               riscv_excp_names[cause] : "(unknown)";
+    }
+}
+
 static void set_misa(CPURISCVState *env, target_ulong misa)
 {
     env->misa_mask = env->misa = misa;
diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index dc7ae3e7b1..005880627e 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -892,8 +892,8 @@ void riscv_cpu_do_interrupt(CPUState *cs)
         }
     }
 
-    trace_riscv_trap(env->mhartid, async, cause, env->pc, tval, cause < 23 ?
-        (async ? riscv_intr_names : riscv_excp_names)[cause] : "(unknown)");
+    trace_riscv_trap(env->mhartid, async, cause, env->pc, tval,
+        riscv_cpu_get_trap_name(cause, async));
 
     if (env->priv <= PRV_S &&
             cause < TARGET_LONG_BITS && ((deleg >> cause) & 1)) {
-- 
2.28.0



Return-Path: <SRS0=IkQf=EJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AE61C388F9
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 20:03:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 89992206DC
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 20:03:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Ws/NMsB0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 89992206DC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42100 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ka2X0-0006RJ-Fx
	for qemu-devel@archiver.kernel.org; Tue, 03 Nov 2020 15:03:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36144)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=569a91e0c=alistair.francis@wdc.com>)
 id 1ka2Vj-0004or-O3; Tue, 03 Nov 2020 15:02:31 -0500
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:10075)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=569a91e0c=alistair.francis@wdc.com>)
 id 1ka2Vh-0002m9-O3; Tue, 03 Nov 2020 15:02:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1604433749; x=1635969749;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=1m/uJoL+53mnBQz9EVIpdmTHpWP0VnXUqGjtcq/apck=;
 b=Ws/NMsB0sbSFIpXuJYCf74pJzkAzrUC0lI43B/AzOIde8d/D/spwbtQS
 ssAu8a9FvuVejfAbmZGTDUSsSLX24AuhdvshrtuLC3Y/iaBEHgU07uS8b
 bccI/eRFbqXRvSX67+xH+b0CSiDEAm1MJYI7rEgZNb7i2ici6/DVK18i+
 rRxdRQD3ANDfoPi3695/rswX6sIGbCZ6vAWpEoiLyMOX3dp4AIfZOm6wy
 erJWmisI2m7twAIWf6JJhqvjWcHfq8zJCzEQWEFR3x0JYcXXuhpl6aTpO
 rH7jw39nyGsTojOjaIzBA1NYQQRNi1Dg8tGHr289Jym+Ygscr48daHge1 g==;
IronPort-SDR: +fcQwV4ixs8Woa8hL7XvnEPgWa0NO9FSw7MQPFuByMKfUmlJNmtNqn0ae5X3iF1w7a/FJ0Fz12
 djYnvtK1kvhU3yv7oLFZnkI0p62rTNem4S3QLMUGgvUU1XBfLWCYA6iMBc1PUZdyW+JQqvLzk/
 15JQsZp09rZEMZcu8hLlnZKRVu+4kqDvnQ587Nd5nntWh0C7FiBD5AhSjnY9VVFMTqk3q5r8aA
 9xHqeQO2Wf1fE5e+NNAKAOE3T8JNwUvtp6lVU6r5XEKcnyecTOu/lY5wW2KCmlA98jDzL3h1yk
 rnA=
X-IronPort-AV: E=Sophos;i="5.77,448,1596470400"; d="scan'208";a="151608900"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 04 Nov 2020 04:02:28 +0800
IronPort-SDR: htPWXxlF9NS1aA43zbo/AslSROmQ70a4V35Gz+xYoYoPTaUqb11KdGQECpnUH5R7kus1kjXcBl
 BD+F62mbAV0mJ6Nw44ZB6tz6biUG2O5t0SZgkDlCYgFQ2oeO8QYsF5MJD7IOGuLjX6qNrz7xA3
 +mP/jEn3Kci7xYiCYZHK8BZlX25ChablHncv0Iif/xdFwhG+Ppe8CwcUGihEpts7f6sgfJt5YB
 VXSWy54wTASN1g8sfLrMJ5yV6f92ffVcTDN9nSRWv/Cixv7sIZPxdhyJ7HBxtCiCsHV7W92Ltf
 twMgq6mdvhhsFnnsBgdnZtMa
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Nov 2020 11:47:26 -0800
IronPort-SDR: pGTrIinajoq48Szy+RuKHsaZ3XOT4VC3PE5lHt8WfHnjv15jsF0BUsw43ZrYUzo+5jjuKEg9yI
 KDxdxRgdd3pnGLbY6a524T5D3TUdI7LpjQ+ZMiRsa9gkvwY9I/4xObid/Icko9KOxGYKgFUedr
 bXxTUwVweV0i6CYyzPMSbbNFyEu71AsrIMBsEMw5Smu1CmRzj03dE+8Ayt7IGZWfMQLWyRCmL8
 5YvVzHuNK4JCRXsd8JHBDwyroyPr7hCUjOhqrX2r8og7+bTuSl+z+qQIYZFD49DZ25EjJLFshV
 ktA=
WDCIronportException: Internal
Received: from usa003000.ad.shared (HELO risc6-mainframe.hgst.com)
 ([10.86.60.113])
 by uls-op-cesaip01.wdc.com with ESMTP; 03 Nov 2020 12:02:28 -0800
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [PATCH v3 2/7] target/riscv: Add a virtualised MMU Mode
Date: Tue,  3 Nov 2020 11:50:58 -0800
Message-Id: <5f25069661040bb96f945358bd7fa047f5b462ce.1604432950.git.alistair.francis@wdc.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <cover.1604432950.git.alistair.francis@wdc.com>
References: <cover.1604432950.git.alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.71.154.42;
 envelope-from=prvs=569a91e0c=alistair.francis@wdc.com;
 helo=esa4.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/03 15:02:23
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
Cc: richard.henderson@linaro.org, alistair.francis@wdc.com, bmeng.cn@gmail.com,
 palmer@dabbelt.com, alistair23@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Add a new MMU mode that includes the current virt mode.

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu-param.h  | 10 +++++++++-
 target/riscv/cpu.h        |  4 +++-
 target/riscv/cpu_helper.c |  6 +++++-
 3 files changed, 17 insertions(+), 3 deletions(-)

diff --git a/target/riscv/cpu-param.h b/target/riscv/cpu-param.h
index 664fc1d371..0db6e23140 100644
--- a/target/riscv/cpu-param.h
+++ b/target/riscv/cpu-param.h
@@ -18,6 +18,14 @@
 # define TARGET_VIRT_ADDR_SPACE_BITS 32 /* sv32 */
 #endif
 #define TARGET_PAGE_BITS 12 /* 4 KiB Pages */
-#define NB_MMU_MODES 4
+/*
+ * The current MMU Modes are:
+ *  - U  mode 0b000
+ *  - S  mode 0b001
+ *  - M  mode 0b011
+ *  - HU mode 0b100
+ *  - HS mode 0b101
+ */
+#define NB_MMU_MODES 6
 
 #endif
diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 87b68affa8..5d8e54c426 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -363,7 +363,9 @@ void QEMU_NORETURN riscv_raise_exception(CPURISCVState *env,
 target_ulong riscv_cpu_get_fflags(CPURISCVState *env);
 void riscv_cpu_set_fflags(CPURISCVState *env, target_ulong);
 
-#define TB_FLAGS_MMU_MASK   3
+#define TB_FLAGS_MMU_MASK   7
+#define TB_FLAGS_PRIV_MMU_MASK                3
+#define TB_FLAGS_PRIV_HYP_ACCESS_MASK   (1 << 2)
 #define TB_FLAGS_MSTATUS_FS MSTATUS_FS
 
 typedef CPURISCVState CPUArchState;
diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index 3eb3a034db..453e4c6d8a 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -30,6 +30,10 @@ int riscv_cpu_mmu_index(CPURISCVState *env, bool ifetch)
 #ifdef CONFIG_USER_ONLY
     return 0;
 #else
+    if (riscv_cpu_virt_enabled(env)) {
+        return env->priv | TB_FLAGS_PRIV_HYP_ACCESS_MASK;
+    }
+
     return env->priv;
 #endif
 }
@@ -323,7 +327,7 @@ static int get_physical_address(CPURISCVState *env, hwaddr *physical,
      * (riscv_cpu_do_interrupt) is correct */
     MemTxResult res;
     MemTxAttrs attrs = MEMTXATTRS_UNSPECIFIED;
-    int mode = mmu_idx;
+    int mode = mmu_idx & TB_FLAGS_PRIV_MMU_MASK;
     bool use_background = false;
 
     /*
-- 
2.28.0



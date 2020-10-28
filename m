Return-Path: <SRS0=Un+l=ED=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA9CEC388F7
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2020 14:55:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CF1C2247A8
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2020 14:55:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="n80A/y59"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF1C2247A8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35586 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXmrK-0003Sz-Eq
	for qemu-devel@archiver.kernel.org; Wed, 28 Oct 2020 10:55:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38492)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=563b96974=alistair.francis@wdc.com>)
 id 1kXmpi-0001mO-5d; Wed, 28 Oct 2020 10:53:50 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:10513)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=563b96974=alistair.francis@wdc.com>)
 id 1kXmpf-00035l-Mq; Wed, 28 Oct 2020 10:53:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1603896827; x=1635432827;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=1m/uJoL+53mnBQz9EVIpdmTHpWP0VnXUqGjtcq/apck=;
 b=n80A/y59H/ARwEkKP1qXs4KWJB1o5heKNUzJkXf8EIWZM8J4pfum5yK0
 Zc3Of5EB5CtaSPlye0R6wv3QqXYLH3J0NRqaB1oxZGGFKAdHF6zv6d0g+
 8QCZKErO30hT5B139Mag283zPrkoz0P30rkS5yvvF55Nbu1nAXJkC80LA
 1rIwuvUZFkcKzCvIrPsWi06OcDKpiDcr0ftv93QSOb/s3h9GcnyczUEwt
 OLi/HslRrp11jCz1hUd3wy2LVRuw7558TUYr9cQTGfhMU1z2Rb/vAW4RN
 mIEH8druF7sqeyOWoycnH/N2I+XPB/h0951brUJeaAb7LQrXC3YKUwKp7 A==;
IronPort-SDR: 8udSw06UGFWoPsjxlHJpJ0uJhPCC2syDuTCnvdWB2r4+wKKcTl41WjW9gbhLiw4J7TDbyu21CK
 1EFRRGmsb61cAWHo0195TWjduK8LbNCZSFA4yzq39QoLuljSJsoqSnBojMBTR/5AVtxsL9mHfx
 TkQbn7c1frlOs7MWdZL3caLCVsvAhNU7MUl8mqSI7tgBadZIm+Ob5qOhhRzQrTDkkiAOa5zvW3
 pblBHizttmFithiLcSraQAt4OELq+8igg/o8tXCEhH/QdtoM9V8jETFj9YASPqkG49VmciEJG5
 dok=
X-IronPort-AV: E=Sophos;i="5.77,426,1596470400"; d="scan'208";a="151200363"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 28 Oct 2020 22:53:45 +0800
IronPort-SDR: fh8lP5nth2vCp8GKJNJXxuH7Xz4BtD0v6QUZnssKtR8dEoxXE2vVLXdZCfsVbpFl2h43TiUiKi
 xtB14UaLEA9AHDB7tPh2fqASGxRlUsX/pNmm4CoeSu1un3+zKuqzMEPTuUvVONBUWmtc1VRgeZ
 /+KcAdwlCwVHLTr7E0E6nx7eKX/crxppJ+ad67zqyoJequg1JX72klNsYky7sMYWrgezmhkjfN
 m7tE7iw39JbL1W85+JjFHRuwaNgN6KTmTZhZNhrvpsfRa2hQ4bphOovV2mIpFs7htCUfQ/bDYb
 xkeeuAYffucymrfIcOWAWmG/
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Oct 2020 07:38:55 -0700
IronPort-SDR: iwf4uBidU2hz+jSOULmo4t82ScoJIbYFCa4BXbcO3CCsiVfBQqqAyGqDv8hPfzM+ek7aaoclpZ
 c4g4E57Xb/nDmI5tmHtdjKDdgTd3QxTeXVOMZuyvBrjXtpfG6qwQO8SYzPGQqYS4nLqdyHjfKC
 xTAnfEKqTAtsnLIlYEQbZffyNPLqv3ZUZW1ipFAGI3vuuJtJm7zM+Ru8xPRwOT25f00rNN6AXc
 cOEz4IZ+UYfccvHokVNYFAF4VAoB0fCOcxfI9hJVpe4uYpC0tosz+l6fZH18HOrgz40uAYv1HY
 vWk=
WDCIronportException: Internal
Received: from usa003000.ad.shared (HELO risc6-mainframe.hgst.com)
 ([10.86.60.131])
 by uls-op-cesaip01.wdc.com with ESMTP; 28 Oct 2020 07:53:45 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [PATCH v2 1/5] target/riscv: Add a virtualised MMU Mode
Date: Wed, 28 Oct 2020 07:42:20 -0700
Message-Id: <d0eeb9ea64462044a67f5b803d6cb62dd10e017a.1603896075.git.alistair.francis@wdc.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <cover.1603896075.git.alistair.francis@wdc.com>
References: <cover.1603896075.git.alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.71.153.144;
 envelope-from=prvs=563b96974=alistair.francis@wdc.com;
 helo=esa5.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/28 10:53:43
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
Cc: alistair.francis@wdc.com, richard.henderson@linaro.org, bmeng.cn@gmail.com,
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



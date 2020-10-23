Return-Path: <SRS0=OdKR=D6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE664C388F9
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 15:56:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2B86320878
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 15:56:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="ak5WI1nu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B86320878
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47190 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVzQJ-0000nF-4F
	for qemu-devel@archiver.kernel.org; Fri, 23 Oct 2020 11:56:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35130)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=558518344=alistair.francis@wdc.com>)
 id 1kVz8B-0000BK-9z; Fri, 23 Oct 2020 11:37:28 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:38922)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=558518344=alistair.francis@wdc.com>)
 id 1kVz88-0002ph-FX; Fri, 23 Oct 2020 11:37:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1603467444; x=1635003444;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=Gv/v2qUHT3RQ9WsyYe/7AJZc4P3ax+SAKTeS6rhbV1o=;
 b=ak5WI1nuLHEzpToJIJl8k0Pe66wqqnxRoE5C/RdYQNOgt+dRJri1nDnq
 wve4McADs+kU3NmcUuiGB68R4IecQfoR1V5F6wc+blEuCbWv3DoB4pNAI
 MdeUaItcMfx84H7qnxq/V2D4TOQJKuGGehvsd5czAKr+Ou5XRdn89DCTD
 vRo/GPfUNAPJspqwlXBBsbKs8zXdNB6FtaLdxw0kiGzVsFzW/iCEVN0XK
 1Yg7YkV9pPtCdfalvFwJ8TMsBJnaqtPKPnaK+ZxVMtnQ+Y1QPFHIZgvUm
 I6YHI7c1qYZ4tb1S3/EcXOqVHqPl8TJoPE6JeUik2rysjP9Tunp7y7Osr w==;
IronPort-SDR: en04BjEpHnlWO/LXhI6/EBG9psYbR5u7TdgglpiyLAoh4NUxD3hdvX/KdPTUEtwnWr+IzDKrMs
 1G8oyPj3hhdf9paDaCTiR/ZPlRHoBCNrKWhxDd9C5lwbMs1j9CjJ+Jf5Kk5fCuwzEcSD563Eox
 mE5WfKeo2/XRhHp12hOHLs8oJz5+i1PSQSPsU7ugiYlrkH1KjxpDbjVwE0lgSdF9A10RcBeby9
 xbgIZm6H8BBF8Q4G/IPQuPKRMZSJsBp4IUbauWK410P60T3yznm/IQVmgY6oxV/EiVUtfSv0WE
 9p8=
X-IronPort-AV: E=Sophos;i="5.77,408,1596470400"; d="scan'208";a="260636261"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 23 Oct 2020 23:37:22 +0800
IronPort-SDR: dvbxy3ehYfy3ufIoWFw5+3IwkBw7BE5wbTzmW2QcYhITo4B4L5iCBe21J/uoUuMSkxdxnEyKUi
 iOhnwNJ7nXGXayPoS2fWgQLNgbRrsITcbrutuOx2XcGJ6D6RhxPqDHBumNZtyDFvxSgsyxaP21
 2I3wn01BlM3sL2crA/XTEANU0P8o58JQKcOBJ0bffn4/r2O2MaI9yInooXGmhxb0YbNmjz+2Yt
 FZlqP2YqPkC3LkxSyWQnqfRFHxt4AkFL7j7B5IhtohTxGqLvniFnSNGodefupYVCVwcl32yoXw
 CKF8mhQ76/NtEBiDsbhFKJdY
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Oct 2020 08:23:44 -0700
IronPort-SDR: 3yLSBvu5kFcoJ8weIUHVZK6cPHs+r5vdDpgjqlIgjvtwkC7gJ6cJVYCC/FvXtNu9qnlfpgZe+7
 t/iwgMBhw8A2d6anSGPC+nlN7QX8YjBTDL6Hi28WNuwvye++zco0BWWF8rE0ZmwOnmtgAzfn6H
 Mr/Tem2ETZLu0z6NIOL50txh9dLIdbjUhZMVnpp6i40mxDd1DG+kcAEmeLJPSfeLFrDKoQP3tx
 X1LXm9KcQAMV2l1HcsbUo7XtIamaXOD+9QtW5k/X5M9XvmlaRF8C9xn3DvZp1yWmns4eGGyYAS
 1zc=
WDCIronportException: Internal
Received: from cnf006900.ad.shared (HELO risc6-mainframe.hgst.com)
 ([10.86.60.46])
 by uls-op-cesaip02.wdc.com with ESMTP; 23 Oct 2020 08:37:22 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [PATCH v1 1/5] target/riscv: Add a virtualised MMU Mode
Date: Fri, 23 Oct 2020 08:26:01 -0700
Message-Id: <16213739a6232aa4824c5a008e2f669e6e58fbcf.1603466725.git.alistair.francis@wdc.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <cover.1603466725.git.alistair.francis@wdc.com>
References: <cover.1603466725.git.alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=68.232.141.245;
 envelope-from=prvs=558518344=alistair.francis@wdc.com;
 helo=esa1.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/23 11:37:20
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
 target/riscv/cpu-param.h  | 2 +-
 target/riscv/cpu.h        | 4 +++-
 target/riscv/cpu_helper.c | 6 +++++-
 3 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/target/riscv/cpu-param.h b/target/riscv/cpu-param.h
index 664fc1d371..502ed6489e 100644
--- a/target/riscv/cpu-param.h
+++ b/target/riscv/cpu-param.h
@@ -18,6 +18,6 @@
 # define TARGET_VIRT_ADDR_SPACE_BITS 32 /* sv32 */
 #endif
 #define TARGET_PAGE_BITS 12 /* 4 KiB Pages */
-#define NB_MMU_MODES 4
+#define NB_MMU_MODES 8
 
 #endif
diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index de4705bb57..8ac01f3a64 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -365,7 +365,9 @@ void QEMU_NORETURN riscv_raise_exception(CPURISCVState *env,
 target_ulong riscv_cpu_get_fflags(CPURISCVState *env);
 void riscv_cpu_set_fflags(CPURISCVState *env, target_ulong);
 
-#define TB_FLAGS_MMU_MASK   3
+#define TB_FLAGS_MMU_MASK   7
+#define TB_FLAGS_PRIV_MMU_MASK                3
+#define TB_FLAGS_PRIV_HYP_ACCESS_MASK   (1 << 2)
 #define TB_FLAGS_MSTATUS_FS MSTATUS_FS
 
 typedef CPURISCVState CPUArchState;
diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index 4652082df1..46b62a0f37 100644
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
@@ -336,7 +340,7 @@ static int get_physical_address(CPURISCVState *env, hwaddr *physical,
      * (riscv_cpu_do_interrupt) is correct */
     MemTxResult res;
     MemTxAttrs attrs = MEMTXATTRS_UNSPECIFIED;
-    int mode = mmu_idx;
+    int mode = mmu_idx & 0x3;
     bool use_background = false;
 
     /*
-- 
2.28.0



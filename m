Return-Path: <SRS0=hH57=EK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39FC1C2D0A3
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 05:12:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 91CB720BED
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 05:12:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="XWI60Lc1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91CB720BED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51030 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kaB5f-0002pW-FO
	for qemu-devel@archiver.kernel.org; Wed, 04 Nov 2020 00:12:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60130)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=57073d1dd=alistair.francis@wdc.com>)
 id 1kaAp3-000430-0D; Tue, 03 Nov 2020 23:55:01 -0500
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:17614)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=57073d1dd=alistair.francis@wdc.com>)
 id 1kaAoy-0005iz-2B; Tue, 03 Nov 2020 23:55:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1604465695; x=1636001695;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=RisuKMhLqPB7mhA2jscmhvu/EDaATgNa1/SbhqIyQWg=;
 b=XWI60Lc15rHzeVQAYnZyiBIyHBRCYo/xYJ6RE84fARXHg1ya4SP20uXD
 WHc9BbJwaGdLQYsbGwq3cyxgmcr+T3bEZ+yqayrShlhtuWF94TQOGeCh7
 iwng3CxCpDX0YmE/dUSkFNbOCyGSBvFJo2IUQvQd4iO1NYe6+4j6jp2dL
 uZI6GldkwGpGX7vqTuFiWJ3qjeJZ38bzM1KVxrUy0iZo5xnXEP8p/1UoP
 lePsDznYCARHPh9wc2YxctCU8vuWtrMkCnuUixIYT8/TtXI6pAnqZTcxN
 69z0Ar2lWPYKaci8HdNv3bw38VmUn/Y+TrWbobZCHiqsUY6GZccx9yUz/ g==;
IronPort-SDR: VUyVQOYT2vuzoZFqM1BNbFS0XMyhSgxsArTvgvKc/hCtHGAjVA9KkSXRrXVt1ERXe6N92oVoUn
 k+cxl5l7Xk+KY88yp0TMQ1ob+bKxvaiYQmP0HNumg8LRYwsMAuQP4Qd+JCXojNWwCxbULSUd9s
 ONDUBrLp2ej83tvZ7E6foWjeoCm8mQranPAK5XuTf56z8bRA4LY3sY1n2OiYFBJ42JNKnbEobM
 HZQm+nYLn+qZEBdbWxt/hQWQOKv7y9jq2l97StNtgc64/6hPuKPj9+2Mc7V198pEolg7yU2bD7
 4b0=
X-IronPort-AV: E=Sophos;i="5.77,449,1596470400"; d="scan'208";a="151656927"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 04 Nov 2020 12:54:54 +0800
IronPort-SDR: B5wgJZncStMPBuEBii5s7GQAfWYs0Fh0/7Dc6DRLsiVJJsTINYOqo19bVQLaPHBNr5y4C9OVR8
 q3mblVnrb7iFl4asxajkopUwnt5ow4+xUsZWqJSgxfDdA0+/Ic2fMFbkt+mD5ozLsD5DHZPGKW
 h44MajNmYsUDViI+B48Twn5BsjCVT9nDBVzc5ZtbFYSGKp1YuJaQAFib4LYI0YQ2eSb8KgN8GM
 BmVADkLcmHb5Sd5eaorHmVbe0cHGh4t1VFRy/9fXE6xPWsqc31slXSLCA/Z5Rf0/RwfpIGpaeA
 i0OK48xEmaFmPnUbGLK8Z56c
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Nov 2020 20:41:02 -0800
IronPort-SDR: EeS4b9xAsleFAb0WXJvbYMLmdz2mrxHL6Q24JNLWdo4SJBzAmy1TMCX9bfeUMjez2PEhIx7we0
 JbIzxZQ2ApA42YFh7hByllIyK1cVg5LEz5LFlygI8Qe+CCpldwEAR9QhHCQkGx350ftBHlQUvI
 rVeuT90ZCorWyHejp9B2a3QLBVslAzdzIRcdCtBESeZMHKgEXGuuJaZZbsXsyqX4JP/PGCrVgZ
 wZdmeiGsBiKTrg4KM9muKmL/9X3EPX9fq4L3fh9S8410qTx2q8LiksXwpEiD2fwssWfInoH5dl
 BZE=
WDCIronportException: Internal
Received: from usa003000.ad.shared (HELO risc6-mainframe.hgst.com)
 ([10.86.60.113])
 by uls-op-cesaip01.wdc.com with ESMTP; 03 Nov 2020 20:54:54 -0800
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [PATCH v4 1/5] target/riscv: Add a virtualised MMU Mode
Date: Tue,  3 Nov 2020 20:43:23 -0800
Message-Id: <4b301bc0ea36da962fc1605371b65019ac3073df.1604464950.git.alistair.francis@wdc.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <cover.1604464950.git.alistair.francis@wdc.com>
References: <cover.1604464950.git.alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.71.154.42;
 envelope-from=prvs=57073d1dd=alistair.francis@wdc.com;
 helo=esa4.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/03 23:54:51
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
 target/riscv/cpu-param.h  | 11 ++++++++++-
 target/riscv/cpu.h        |  4 +++-
 target/riscv/cpu_helper.c |  2 +-
 3 files changed, 14 insertions(+), 3 deletions(-)

diff --git a/target/riscv/cpu-param.h b/target/riscv/cpu-param.h
index 664fc1d371..e4cf3c01eb 100644
--- a/target/riscv/cpu-param.h
+++ b/target/riscv/cpu-param.h
@@ -18,6 +18,15 @@
 # define TARGET_VIRT_ADDR_SPACE_BITS 32 /* sv32 */
 #endif
 #define TARGET_PAGE_BITS 12 /* 4 KiB Pages */
-#define NB_MMU_MODES 4
+/*
+ * The current MMU Modes are:
+ *  - U mode 0b000
+ *  - S mode 0b001
+ *  - M mode 0b011
+ *  - U mode HLV/HLVX/HSV 0b100
+ *  - S mode HLV/HLVX/HSV 0b101
+ *  - M mode HLV/HLVX/HSV 0b111
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
index 3eb3a034db..9dfa7af401 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -323,7 +323,7 @@ static int get_physical_address(CPURISCVState *env, hwaddr *physical,
      * (riscv_cpu_do_interrupt) is correct */
     MemTxResult res;
     MemTxAttrs attrs = MEMTXATTRS_UNSPECIFIED;
-    int mode = mmu_idx;
+    int mode = mmu_idx & TB_FLAGS_PRIV_MMU_MASK;
     bool use_background = false;
 
     /*
-- 
2.28.0



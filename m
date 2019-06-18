Return-Path: <SRS0=M8fn=UR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3C66C31E5B
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2019 01:42:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B7A1B2082C
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2019 01:42:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="ECp8H+q9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B7A1B2082C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53000 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hd38x-0006Vx-Tn
	for qemu-devel@archiver.kernel.org; Mon, 17 Jun 2019 21:42:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41054)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <prvs=0651fb9a1=alistair.francis@wdc.com>)
 id 1hd30U-0006yL-Bu
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 21:33:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <prvs=0651fb9a1=alistair.francis@wdc.com>)
 id 1hd30K-0000He-5u
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 21:33:48 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:24430)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <prvs=0651fb9a1=alistair.francis@wdc.com>)
 id 1hd30J-0000A1-HE; Mon, 17 Jun 2019 21:33:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1560821624; x=1592357624;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=Ve7Ap2V5Mkzuo0d+Wcq3sQxhlCvQxeKzZZrn5vyIJDU=;
 b=ECp8H+q9NOjnPlJvWupXQmAadkLWhNBcEJ2h6cv3bATQBGLld+CPkxLh
 eoIwk/vmq7JOwkTFggWLDCdkcYQAxVOQc8MfvzIXs2+5T47PVRG43mujy
 R9RhcXrH58ha+OAcfdVwqWmVFsdMuaE5TAnOFLEXlDp51/c0LCe5T3YmZ
 Ak/o1SHBawA00xJ+TLQZ1j5kJs3ZV05nugmdKPyEDrKK7bBMF82/uSonc
 hO/qlqw5VOvuD3JP/LUmh1zdPJliPGtmZC0aOsYlJMzXAyMy9eH/E60kk
 tzzpQdKCGxyq2a15+J+ycQrXZnSTJcIOjhQ0D2HA8HQ416gMYXJdBct2s w==;
X-IronPort-AV: E=Sophos;i="5.63,386,1557158400"; d="scan'208";a="112055106"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 18 Jun 2019 09:33:43 +0800
IronPort-SDR: ZhQj4XHgkWXVSjUqRGOx0ABHujaYrrIWVqhsZdSar8fQMqxA792Hwrd9eJE/GScz6tb461x5rA
 VvQpkM0/0Wg0lLFXi+UQsfr/7Y2RFJOx8zvzFYqqtwXrt4Iiycl23neI5yafRduoepsoyywgTI
 0c3AQmWDgWWpJokNzfzTspy2IJWmVkdbHJcVm3UPeZXgQ2SToKAz51bLzEY4wRcbC86MVKYZH5
 xXGele0dZCtm4kPQ/fG1i6Aw9Cx2Agr+4lNOGTLe+yotAMCEfV5npNcmeAvzdecpB7bHyZxqMh
 7+bLqEiKt9EDfx4fRH24qGDD
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep02.wdc.com with ESMTP; 17 Jun 2019 18:33:13 -0700
IronPort-SDR: h2r49Tu76lOiElmHZIxKCo4Ci+Vm4kHWtUvtBTOi+ET5XNLkwZySy8+uOF+QQO51i5p/hBltGU
 3e5ER8uFdAHtlsRWqBX4cimCldQZJ3iv3/6opkROw3mK6XbpeMoODmAz3JQHKUCFeMSqN0PoK4
 p5HovBl88flZMEZKVqehgxBPK/RDRXFlxHUnQiC1SsYuFu8SoMs3gs8nVNWbSJ14ZOVokDgQ0x
 91oWU9NlA8h22Hfnm9AoimYFJdCDVRXMAlmQIhtnFaIFiXU9ZLTxLCPuMx6pCwVvWgnXnHy2Uk
 bxg=
Received: from risc6-mainframe.sdcorp.global.sandisk.com (HELO
 risc6-mainframe.int.fusionio.com) ([10.196.157.140])
 by uls-op-cesaip02.wdc.com with ESMTP; 17 Jun 2019 18:33:43 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Date: Mon, 17 Jun 2019 18:31:22 -0700
Message-Id: <4ae1c7156ed0e8b0d2441c9e5954dfe623792d13.1560821342.git.alistair.francis@wdc.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <cover.1560821342.git.alistair.francis@wdc.com>
References: <cover.1560821342.git.alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 216.71.153.144
Subject: [Qemu-devel] [PATCH v1 8/9] target/riscv: Add support for
 disabling/enabling Counters
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
Cc: alistair23@gmail.com, palmer@sifive.com, alistair.francis@wdc.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Add support for disabling/enabling the "Counters" extension.

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.c | 1 +
 target/riscv/cpu.h | 1 +
 target/riscv/csr.c | 7 +++++++
 3 files changed, 9 insertions(+)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index ddbe922958..5af1c9b38c 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -440,6 +440,7 @@ static Property riscv_cpu_properties[] = {
     DEFINE_PROP_BOOL("c", RISCVCPU, cfg.ext_c, true),
     DEFINE_PROP_BOOL("s", RISCVCPU, cfg.ext_s, true),
     DEFINE_PROP_BOOL("u", RISCVCPU, cfg.ext_u, true),
+    DEFINE_PROP_BOOL("Counters", RISCVCPU, cfg.ext_counters, true),
     DEFINE_PROP_STRING("priv_spec", RISCVCPU, cfg.priv_spec),
     DEFINE_PROP_BOOL("mmu", RISCVCPU, cfg.mmu, true),
     DEFINE_PROP_BOOL("pmp", RISCVCPU, cfg.pmp, true),
diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index a558c353f0..786f620564 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -221,6 +221,7 @@ typedef struct RISCVCPU {
         bool ext_c;
         bool ext_s;
         bool ext_u;
+        bool ext_counters;
 
         char *priv_spec;
         char *user_spec;
diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index 437387fd28..a9aa8ab1b5 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -56,8 +56,15 @@ static int fs(CPURISCVState *env, int csrno)
 static int ctr(CPURISCVState *env, int csrno)
 {
 #if !defined(CONFIG_USER_ONLY)
+    CPUState *cs = env_cpu(env);
+    RISCVCPU *cpu = RISCV_CPU(cs);
     uint32_t ctr_en = ~0u;
 
+    if (!cpu->cfg.ext_counters) {
+        /* The Counters extensions is not enabled */
+        return -1;
+    }
+
     if (env->priv < PRV_M) {
         ctr_en &= env->mcounteren;
     }
-- 
2.22.0



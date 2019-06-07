Return-Path: <SRS0=3yEa=UG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD92FC2BCA1
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 22:15:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A631C207E0
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 22:15:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="nb4DIUph"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A631C207E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53716 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hZN9J-0004lY-VT
	for qemu-devel@archiver.kernel.org; Fri, 07 Jun 2019 18:15:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48060)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <prvs=0547f94d1=alistair.francis@wdc.com>)
 id 1hZMsb-0004q3-2W
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 17:58:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <prvs=0547f94d1=alistair.francis@wdc.com>)
 id 1hZMsX-0002EQ-4e
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 17:58:31 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:8476)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <prvs=0547f94d1=alistair.francis@wdc.com>)
 id 1hZMsV-00028L-4O; Fri, 07 Jun 2019 17:58:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1559944708; x=1591480708;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=70z9CEqnzyThz9b62lMvpwwNzNURYyoV2TTIj2LnYig=;
 b=nb4DIUphEZsAlxEybtlcCavyAu5KYUy+safmDGuayOMaJmH0HxpH/8tN
 RGfL/TIzfSAF6Id/8GPSvjcjYffODajWH+QcFSoarJ2qSZZ8CcS2ItgN8
 7o8WhlJLlYlp9ISgiomv45gvnJXdMDysugRtgLuyYFmQdbWlrLP3cCrkY
 sXegOqdYLUkmunthdI9rRNoUB6JAFfdHlKrM8B9dykQPQyMxNl8+OBjgB
 kJAhx0cOY3eb9mIyJD+VhnvlhvLvAdIc71Yv/1uXRUIdVr7zb8nKG2wwF
 JJhcsNWze0YKm6z3XL0Dw1hBGlz2Gttqi8oy7W89s1cNbDu8aSNxlQs6x A==;
X-IronPort-AV: E=Sophos;i="5.63,564,1557158400"; d="scan'208";a="115014101"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 08 Jun 2019 05:58:04 +0800
IronPort-SDR: o6R/Xw40NMSAv9AQh/BEyKNPqb73NB7c1iOZuRnWFCGFACvNuqBy6Bo14jYeisN1a+DLN2QJxf
 zQqab4mrELHdBCwyJVNjtuQX/NJ8iFOQ8EERaBigKEGUlJJzHR+x21d5ke0yfz1D96tr0tSP8e
 NbsIHD7Zz7BYQBS7F/Gddsob/SAT2w9kwFiTjB+d0Nln92ZC25iBIFHnL98uASPICgnGWEIqPt
 bBC7od+AG73Pa2H3lB5ygcMLUpomgzb8vtjtWlnwx3PFonBWNi+qAkBSmVIyJ32EMXxIzHv4/y
 r9Ff/ZAVCQ/S3M99IEVMlgQp
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep02.wdc.com with ESMTP; 07 Jun 2019 14:35:20 -0700
IronPort-SDR: w0CNxIUzaCe4uGXFDfTXa8UuDbx4uTXK+qaSBwoLmC98Dt659TeRSxieheSBoBSQjPuFJHxMdO
 Q3bzspXKlKJNpEDbW064kMXbIqC9KcYwQb9xxKH7FkPF67DMzRaXH4Z6E5e+1PxRhblWE4JcUC
 AVW06UfmyrcRCFMzHxqArYagWC1Cb6PVzTenL/2cMOFd6XP6c2i1rn7tgMdVdrVekRxELMrQFA
 vca0dASbgiLLQG//zvyXjIo3PgGe7l4XKaLIWqCVzAPQvmSwziwmllMSjrNvyqq/Hu0YXeL/4r
 8C4=
Received: from risc6-mainframe.sdcorp.global.sandisk.com (HELO
 risc6-mainframe.int.fusionio.com) ([10.196.157.140])
 by uls-op-cesaip02.wdc.com with ESMTP; 07 Jun 2019 14:58:03 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Date: Fri,  7 Jun 2019 14:55:53 -0700
Message-Id: <abb51ed3647c0ad762968509959d122c3623d74a.1559944445.git.alistair.francis@wdc.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1559944445.git.alistair.francis@wdc.com>
References: <cover.1559944445.git.alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 216.71.153.141
Subject: [Qemu-devel] [PATCH v1 11/27] target/riscv: Add background CSRs
 accesses
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

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu_bits.h |  11 ++++
 target/riscv/csr.c      | 119 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 130 insertions(+)

diff --git a/target/riscv/cpu_bits.h b/target/riscv/cpu_bits.h
index c898bb1102..9c27727e6f 100644
--- a/target/riscv/cpu_bits.h
+++ b/target/riscv/cpu_bits.h
@@ -169,6 +169,17 @@
 #define CSR_SPTBR           0x180
 #define CSR_SATP            0x180
 
+/* Background CSRs */
+#define CSR_BSSTATUS        0x200
+#define CSR_BSIE            0x204
+#define CSR_BSTVEC          0x205
+#define CSR_BSSCRATCH       0x240
+#define CSR_BSEPC           0x241
+#define CSR_BSCAUSE         0x242
+#define CSR_BSTVAL          0x243
+#define CSR_BSIP            0x244
+#define CSR_BSATP           0x280
+
 /* Physical Memory Protection */
 #define CSR_PMPCFG0         0x3a0
 #define CSR_PMPCFG1         0x3a1
diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index 911f83ef51..c55eea44ec 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -799,6 +799,115 @@ static int write_hgatp(CPURISCVState *env, int csrno, target_ulong val)
     return 0;
 }
 
+/* Background CSR Registers */
+static int read_bsstatus(CPURISCVState *env, int csrno, target_ulong *val)
+{
+    *val = env->bsstatus;
+    return 0;
+}
+
+static int write_bsstatus(CPURISCVState *env, int csrno, target_ulong val)
+{
+    env->bsstatus = val;
+    return 0;
+}
+
+static int read_bsie(CPURISCVState *env, int csrno, target_ulong *val)
+{
+    *val = env->bsie;
+    return 0;
+}
+
+static int write_bsie(CPURISCVState *env, int csrno, target_ulong val)
+{
+    env->bsie = val;
+    return 0;
+}
+
+static int read_bstvec(CPURISCVState *env, int csrno, target_ulong *val)
+{
+    *val = env->bstvec;
+    return 0;
+}
+
+static int write_bstvec(CPURISCVState *env, int csrno, target_ulong val)
+{
+    env->bstvec = val;
+    return 0;
+}
+
+static int read_bsscratch(CPURISCVState *env, int csrno, target_ulong *val)
+{
+    *val = env->bsscratch;
+    return 0;
+}
+
+static int write_bsscratch(CPURISCVState *env, int csrno, target_ulong val)
+{
+    env->bsscratch = val;
+    return 0;
+}
+
+static int read_bsepc(CPURISCVState *env, int csrno, target_ulong *val)
+{
+    *val = env->bsepc;
+    return 0;
+}
+
+static int write_bsepc(CPURISCVState *env, int csrno, target_ulong val)
+{
+    env->bsepc = val;
+    return 0;
+}
+
+static int read_bscause(CPURISCVState *env, int csrno, target_ulong *val)
+{
+    *val = env->bscause;
+    return 0;
+}
+
+static int write_bscause(CPURISCVState *env, int csrno, target_ulong val)
+{
+    env->bscause = val;
+    return 0;
+}
+
+static int read_bstval(CPURISCVState *env, int csrno, target_ulong *val)
+{
+    *val = env->bstval;
+    return 0;
+}
+
+static int write_bstval(CPURISCVState *env, int csrno, target_ulong val)
+{
+    env->bstval = val;
+    return 0;
+}
+
+static int read_bsip(CPURISCVState *env, int csrno, target_ulong *val)
+{
+    *val = (target_ulong)atomic_read(&env->bsip);
+    return 0;
+}
+
+static int write_bsip(CPURISCVState *env, int csrno, target_ulong val)
+{
+    atomic_set(&env->bsip, val);
+    return 0;
+}
+
+static int read_bsatp(CPURISCVState *env, int csrno, target_ulong *val)
+{
+    *val = env->bsatp;
+    return 0;
+}
+
+static int write_bsatp(CPURISCVState *env, int csrno, target_ulong val)
+{
+    env->bsatp = val;
+    return 0;
+}
+
 /* Physical Memory Protection */
 static int read_pmpcfg(CPURISCVState *env, int csrno, target_ulong *val)
 {
@@ -987,6 +1096,16 @@ static riscv_csr_operations csr_ops[CSR_TABLE_SIZE] = {
     [CSR_HIDELEG] =             { hmode,   read_hideleg,     write_hideleg    },
     [CSR_HGATP] =               { hmode,   read_hgatp,       write_hgatp      },
 
+    [CSR_BSSTATUS] =            { hmode,   read_bsstatus,    write_bsstatus   },
+    [CSR_BSIE] =                { hmode,   read_bsie,        write_bsie       },
+    [CSR_BSTVEC] =              { hmode,   read_bstvec,      write_bstvec     },
+    [CSR_BSSCRATCH] =           { hmode,   read_bsscratch,   write_bsscratch  },
+    [CSR_BSEPC] =               { hmode,   read_bsepc,       write_bsepc      },
+    [CSR_BSCAUSE] =             { hmode,   read_bscause,     write_bscause    },
+    [CSR_BSTVAL] =              { hmode,   read_bstval,      write_bstval     },
+    [CSR_BSIP] =                { hmode,   read_bsip,        write_bsip       },
+    [CSR_BSATP] =               { hmode,   read_bsatp,       write_bsatp      },
+
     /* Physical Memory Protection */
     [CSR_PMPCFG0  ... CSR_PMPADDR9] =  { pmp,   read_pmpcfg,  write_pmpcfg   },
     [CSR_PMPADDR0 ... CSR_PMPADDR15] = { pmp,   read_pmpaddr, write_pmpaddr  },
-- 
2.21.0



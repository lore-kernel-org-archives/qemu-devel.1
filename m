Return-Path: <SRS0=E2zY=TZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B0BFC282E1
	for <qemu-devel@archiver.kernel.org>; Sat, 25 May 2019 00:02:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 340B82075E
	for <qemu-devel@archiver.kernel.org>; Sat, 25 May 2019 00:02:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="SzpT+bCc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 340B82075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:33442 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hUK8o-0001cE-AE
	for qemu-devel@archiver.kernel.org; Fri, 24 May 2019 20:02:26 -0400
Received: from eggs.gnu.org ([209.51.188.92]:60254)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=040baf4f1=alistair.francis@wdc.com>)
	id 1hUK43-0005Kz-Lx
	for qemu-devel@nongnu.org; Fri, 24 May 2019 19:57:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=040baf4f1=alistair.francis@wdc.com>)
	id 1hUJun-0004Mj-2P
	for qemu-devel@nongnu.org; Fri, 24 May 2019 19:48:00 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:51627)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <prvs=040baf4f1=alistair.francis@wdc.com>)
	id 1hUJum-00046f-K6; Fri, 24 May 2019 19:47:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
	d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
	t=1558741677; x=1590277677;
	h=from:to:cc:subject:date:message-id:in-reply-to:
	references:mime-version:content-transfer-encoding;
	bh=6UOMESq+sGSeNp31YuaAf4E6LnUDjRVfecs88kpoRRw=;
	b=SzpT+bCc9eQhK+Ohv7ilck76v3Cz+p4warf/FvvvWsRPJls5vCI91XDZ
	MIpFdUsNyVMC3DW+rFvgO0V5KSxeIQ6B3YIuCl+jNCf4B8+VTfC3PmQ+c
	PS0IYT40Ax1ItxR8sjii4332o+FPCL0rACLX73jZFVjE/3+5oBFx154yq
	7TREDxWoW7pHwhZpf8OkkO3tS3TT0ZpwzlyeWJ83cIrUWmw0LAcD/lkzJ
	iGMEybeqz01fONT9BQ5uTM1YJMh8Eeadvs3OaFh7mBi8D/eQEGOyP5M3P
	y/5CaXsSu5jBla6ijQ5W03V77FCXCSpQp8rVnnqgZKpRV8T9sU5eFCWH6 Q==;
X-IronPort-AV: E=Sophos;i="5.60,508,1549900800"; d="scan'208";a="110307767"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com)
	([199.255.45.15])
	by ob1.hgst.iphmx.com with ESMTP; 25 May 2019 07:47:57 +0800
IronPort-SDR: b9YU08yZ1e/cDm7n2RYhU3DfylGXyfyKWZLMwaaihyLDR7HkXTqEC550pACmOJmwJUJ9PI1FWl
	BITucjTTXaHpRrLaunUf3A6TKw6+8i61erufGrrPxKE4gfbKoQVSQjMK5yCugsOeEVA2LrDduE
	W27H89zjvY/tkGmdKFKairn2cAprgsqSDn5oWsZX3prAy/hVnbU5Dpyvs+H1yPqh4tfJ0rs2rs
	zzq4pmTqpSQqgtWolkT5aU65K6V1f/RZPZYIkOdVWZcWKa3wfcoBEeiYIdQXou87T5SeWP9WBF
	2sBpa46QizNzwsaTH4dHfxhN
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
	by uls-op-cesaep02.wdc.com with ESMTP; 24 May 2019 16:25:35 -0700
IronPort-SDR: 4GHc4TPyVjiu0qyZGLftRQE4HpABb+v1Yx4ocqa7NDLrD/Yjj6NAAkhhuaAeScwuHZWsU6gkuT
	4fGELERE/hP9JFJJ5E+3vuIRFYitpJZSM5ED/UCbtnUBM9klak/GwAM6JwUxyBy1Gc9HBZHzEU
	4x34nLJuWORDZfV6nCnaeclHmg8Wl6LHgmE1ZL5SCnWW3XoF9MKeSWdN8WjVwyDFIwJxgxDS/a
	V3e/GgDPbd1WZ/yJS03Nsm0c1LRkq0qXOIPTzR+1Lp7FXk2oW8Bp2SmzmHIDf4Jaau36Q2UD9Z
	kqk=
Received: from risc6-mainframe.sdcorp.global.sandisk.com (HELO
	risc6-mainframe.int.fusionio.com) ([10.196.157.140])
	by uls-op-cesaip01.wdc.com with ESMTP; 24 May 2019 16:47:56 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Date: Fri, 24 May 2019 16:46:01 -0700
Message-Id: <fa8024eec75788eb25c124a4604ad7459a1663f7.1558741334.git.alistair.francis@wdc.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1558741334.git.alistair.francis@wdc.com>
References: <cover.1558741334.git.alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 216.71.153.144
Subject: [Qemu-devel] [RFC v1 10/23] target/riscv: Add background CSRs
 accesses
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
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
index c52fde6e7f..908e166426 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -790,6 +790,115 @@ static int write_hgatp(CPURISCVState *env, int csrno, target_ulong val)
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
@@ -978,6 +1087,16 @@ static riscv_csr_operations csr_ops[CSR_TABLE_SIZE] = {
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



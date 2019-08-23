Return-Path: <SRS0=wZWj=WT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3949C3A5A2
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2019 23:59:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7A5DD206BA
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2019 23:59:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="AJjyQLeH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A5DD206BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35170 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i1JSc-0001es-ND
	for qemu-devel@archiver.kernel.org; Fri, 23 Aug 2019 19:59:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49498)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <prvs=1314b2cac=alistair.francis@wdc.com>)
 id 1i1JBy-0000qy-5Z
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 19:42:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <prvs=1314b2cac=alistair.francis@wdc.com>)
 id 1i1JBw-0000A0-D2
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 19:42:01 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:13670)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <prvs=1314b2cac=alistair.francis@wdc.com>)
 id 1i1JBw-00007y-5c; Fri, 23 Aug 2019 19:42:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1566603720; x=1598139720;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=Azz2ITTRRdvTER3eGckb2PBXCZpqdradly3KVxTJb48=;
 b=AJjyQLeH/3I+i8VNsvlq7pDUcvQaOx8hrqqFBlfJfMMEnMqgNOaltv5Z
 oJv/Mo614qke8qCZGOVI/1CbuqbmBjXW6R9Tm1pv3MNxd3lrdOd0vj3Zk
 k/A5JSPu8RmkVuQfBSrNED8XeI7Ou/h2qa3rJGT35xlNB5MXTdBYP8sLq
 8s1TgESpweAVpZtcLuphWZrPtCfpeDR1VF2V208e82FXnXsQ3Zna/mmNH
 35s/Vy9Jim36hi7cGcAY5cqpoZhfA5E7H+imT2bxCQ2/fxfPF7ji0mRV3
 EySljgxaqOnvCqFtGoJB2ua2/H0Sp3jYnK0bi9g/5FAysvgD2ijnO5kTS A==;
IronPort-SDR: nJQsAu62NK4ayGMVEF7EeGcwnF01sD7NlOwusdnQum+hOX4T+niamqEPyi7UoTHxXYLdnrt0/D
 EIUC55eHwE/44riqoJBa+lCv3BWn+yzSx3zrcYBWlNBPyPN8rtYWJhff2czjvmEKb82PiMCYkJ
 n1R0Zt0F2wa+4HGIsMDMsF6eHD2q859TOFS6MsxDoKZ+xyO4J96mPKrcXsNh+70PlyDKOg4Et5
 F1Ft/fIV770hoYD+e7/DMxgQrPO+KqzlALEad/EV1mCRWlye4TRFrDkULDJFK8xtSv+KOYw/il
 dmk=
X-IronPort-AV: E=Sophos;i="5.64,422,1559491200"; d="scan'208";a="118154417"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 24 Aug 2019 07:41:54 +0800
IronPort-SDR: Hp2Gcp4tmEcprc082WnhnyKxmXbKV1z1bslUTDHPjKCH9sZKOQxhmO9J3qqyAUtBZN1o7x6RQq
 BKVHANgIhNGrGeNMph84FiIxFQA/U5Sj/YsTdn3NAB76y5Z84nKdPeTVP4PSe+rV7Yem0mPykX
 Xuu6YSRj/2THSBBv96T+EW/4+qpX5VZ6yCBTtHXJjzW+3j4F9dAHc3xsz2okaIPhDuFwz4sExi
 tPZMn7T+P9S57vshsaU/Wl7QCo/vW9EVv3YR/XzINhaAdcGd6+HD1TeSnU7Dm52RSLqVzccxzn
 LyNzL5CUhLRdIm+jRKaIT9OJ
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Aug 2019 16:39:11 -0700
IronPort-SDR: E/8jZ10WxetFn8PF8qk42Lqc0ExPV8jDlhj6BBl6ovv/g2zszPuspv7y5Ijp615WJpRwAhZSQ4
 P6xiKBcIL8UxWoTLvJs3mtTxx/wRqQpXR0U39wUWc/lQIP9sMUdU6MNKyJiXUk0lUw1vtgafh9
 t9MxIkfFeTNIP+hidyk7O6zhUHhFtHEpMWx/bTKYvKzhmuVYZhX+PL9sLMJtjw52f+BCy0rH0H
 4QtAcPxipb2ves/n+jiV3yY98oEDhe+FhSlzSPr8EGFxELqPtm9T4hDmRB4l5vPCwhqNBtAl9/
 XNk=
WDCIronportException: Internal
Received: from risc6-mainframe.sdcorp.global.sandisk.com (HELO
 risc6-mainframe.int.fusionio.com) ([10.196.157.58])
 by uls-op-cesaip02.wdc.com with ESMTP; 23 Aug 2019 16:41:53 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Date: Fri, 23 Aug 2019 16:38:13 -0700
Message-Id: <01efc597b0d12ec51e6bb829b4bfe0f6c4dca2a4.1566603412.git.alistair.francis@wdc.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <cover.1566603412.git.alistair.francis@wdc.com>
References: <cover.1566603412.git.alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x
X-Received-From: 216.71.154.45
Subject: [Qemu-devel] [PATCH v1 09/28] target/riscv: Add Hypervisor virtual
 CSRs accesses
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
Cc: alistair23@gmail.com, Anup.Patel@wdc.com, palmer@sifive.com,
 alistair.francis@wdc.com, Atish.Patra@wdc.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu_bits.h |  11 ++++
 target/riscv/csr.c      | 119 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 130 insertions(+)

diff --git a/target/riscv/cpu_bits.h b/target/riscv/cpu_bits.h
index 204d9d9a79..78067901a2 100644
--- a/target/riscv/cpu_bits.h
+++ b/target/riscv/cpu_bits.h
@@ -191,6 +191,17 @@
 #define HGATP_PPN            SATP64_PPN
 #endif
 
+/* Virtual CSRs */
+#define CSR_VSSTATUS        0x200
+#define CSR_VSIE            0x204
+#define CSR_VSTVEC          0x205
+#define CSR_VSSCRATCH       0x240
+#define CSR_VSEPC           0x241
+#define CSR_VSCAUSE         0x242
+#define CSR_VSTVAL          0x243
+#define CSR_VSIP            0x244
+#define CSR_VSATP           0x280
+
 /* Physical Memory Protection */
 #define CSR_PMPCFG0         0x3a0
 #define CSR_PMPCFG1         0x3a1
diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index 388775d45a..e2e908fbc0 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -817,6 +817,115 @@ static int write_hgatp(CPURISCVState *env, int csrno, target_ulong val)
     return 0;
 }
 
+/* Virtual CSR Registers */
+static int read_vsstatus(CPURISCVState *env, int csrno, target_ulong *val)
+{
+    *val = env->vsstatus;
+    return 0;
+}
+
+static int write_vsstatus(CPURISCVState *env, int csrno, target_ulong val)
+{
+    env->vsstatus = val;
+    return 0;
+}
+
+static int read_vsie(CPURISCVState *env, int csrno, target_ulong *val)
+{
+    *val = env->vsie;
+    return 0;
+}
+
+static int write_vsie(CPURISCVState *env, int csrno, target_ulong val)
+{
+    env->vsie = val;
+    return 0;
+}
+
+static int read_vstvec(CPURISCVState *env, int csrno, target_ulong *val)
+{
+    *val = env->vstvec;
+    return 0;
+}
+
+static int write_vstvec(CPURISCVState *env, int csrno, target_ulong val)
+{
+    env->vstvec = val;
+    return 0;
+}
+
+static int read_vsscratch(CPURISCVState *env, int csrno, target_ulong *val)
+{
+    *val = env->vsscratch;
+    return 0;
+}
+
+static int write_vsscratch(CPURISCVState *env, int csrno, target_ulong val)
+{
+    env->vsscratch = val;
+    return 0;
+}
+
+static int read_vsepc(CPURISCVState *env, int csrno, target_ulong *val)
+{
+    *val = env->vsepc;
+    return 0;
+}
+
+static int write_vsepc(CPURISCVState *env, int csrno, target_ulong val)
+{
+    env->vsepc = val;
+    return 0;
+}
+
+static int read_vscause(CPURISCVState *env, int csrno, target_ulong *val)
+{
+    *val = env->vscause;
+    return 0;
+}
+
+static int write_vscause(CPURISCVState *env, int csrno, target_ulong val)
+{
+    env->vscause = val;
+    return 0;
+}
+
+static int read_vstval(CPURISCVState *env, int csrno, target_ulong *val)
+{
+    *val = env->vstval;
+    return 0;
+}
+
+static int write_vstval(CPURISCVState *env, int csrno, target_ulong val)
+{
+    env->vstval = val;
+    return 0;
+}
+
+static int read_vsip(CPURISCVState *env, int csrno, target_ulong *val)
+{
+    *val = (target_ulong)atomic_read(&env->vsip);
+    return 0;
+}
+
+static int write_vsip(CPURISCVState *env, int csrno, target_ulong val)
+{
+    atomic_set(&env->vsip, val);
+    return 0;
+}
+
+static int read_vsatp(CPURISCVState *env, int csrno, target_ulong *val)
+{
+    *val = env->vsatp;
+    return 0;
+}
+
+static int write_vsatp(CPURISCVState *env, int csrno, target_ulong val)
+{
+    env->vsatp = val;
+    return 0;
+}
+
 /* Physical Memory Protection */
 static int read_pmpcfg(CPURISCVState *env, int csrno, target_ulong *val)
 {
@@ -1018,6 +1127,16 @@ static riscv_csr_operations csr_ops[CSR_TABLE_SIZE] = {
     [CSR_HIDELEG] =             { hmode,   read_hideleg,     write_hideleg    },
     [CSR_HGATP] =               { hmode,   read_hgatp,       write_hgatp      },
 
+    [CSR_VSSTATUS] =            { hmode,   read_vsstatus,    write_vsstatus   },
+    [CSR_VSIE] =                { hmode,   read_vsie,        write_vsie       },
+    [CSR_VSTVEC] =              { hmode,   read_vstvec,      write_vstvec     },
+    [CSR_VSSCRATCH] =           { hmode,   read_vsscratch,   write_vsscratch  },
+    [CSR_VSEPC] =               { hmode,   read_vsepc,       write_vsepc      },
+    [CSR_VSCAUSE] =             { hmode,   read_vscause,     write_vscause    },
+    [CSR_VSTVAL] =              { hmode,   read_vstval,      write_vstval     },
+    [CSR_VSIP] =                { hmode,   read_vsip,        write_vsip       },
+    [CSR_VSATP] =               { hmode,   read_vsatp,       write_vsatp      },
+
     /* Physical Memory Protection */
     [CSR_PMPCFG0  ... CSR_PMPADDR9] =  { pmp,   read_pmpcfg,  write_pmpcfg   },
     [CSR_PMPADDR0 ... CSR_PMPADDR15] = { pmp,   read_pmpaddr, write_pmpaddr  },
-- 
2.22.0



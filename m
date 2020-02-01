Return-Path: <SRS0=CCzH=3V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6E2AC33CB7
	for <qemu-devel@archiver.kernel.org>; Sat,  1 Feb 2020 01:18:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 77EBF206F0
	for <qemu-devel@archiver.kernel.org>; Sat,  1 Feb 2020 01:18:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="c1zt23Wu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 77EBF206F0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34432 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ixhQp-0008GJ-Kz
	for qemu-devel@archiver.kernel.org; Fri, 31 Jan 2020 20:18:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56703)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <prvs=2939926b3=alistair.francis@wdc.com>)
 id 1ixhH9-0001NP-Nv
 for qemu-devel@nongnu.org; Fri, 31 Jan 2020 20:08:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <prvs=2939926b3=alistair.francis@wdc.com>)
 id 1ixhH8-0006G4-Ao
 for qemu-devel@nongnu.org; Fri, 31 Jan 2020 20:08:43 -0500
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:17129)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <prvs=2939926b3=alistair.francis@wdc.com>)
 id 1ixhH7-00069K-Vu; Fri, 31 Jan 2020 20:08:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1580519321; x=1612055321;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=B9CW2D87kxG8sTRffNO4m7KGLxFdZPFGIXCinNvhpZM=;
 b=c1zt23Wu8qr3PJDON2ZTc3XOg9OsJAeB0jypBO2KbL1/8pZtWA1frdnL
 Pz6VfJdCmjiRqS5zfvB/aBp2v5OatU8gC2KvxGTp7NEHBlyqKfxokOBl2
 2OBHMiudcNtUFg5TVTvAhhr2QHj2jdxjTWRQK2VWFlWJawATliQ4ISwc/
 ZFr5oj9pUB+aV0Lcp5YR94pZVAhO6+0TwMpsuc5ZPQQDX2u59gbDEKnfT
 0GfBWYH3XWtvSNAjXf1yuCQ5BoDaPSTcZaewfpUWEiC6ItNdzcp/uOPeS
 qgNXWEr2jkIOOo3d+Nsz5EdGeyjPM3joTXGwYRVQG/UzJLs++/dEhcDoV Q==;
IronPort-SDR: ttbJaCw+5e2VNZu+j8l9fzVhhZ7mlp6p0U8tV55lOL059rfuImugnZLbxcdUse7yHtOG4mHnRs
 Cy477MHUpXqZrvlBoJss1n+ktQJAZDW/Mb4UBal15Mw40IexdhgDOOZ0LeO8T5lVRaqMRi+pwf
 +gxbY9T/FPRmHyvxt7WvA3BQM+ognQqS0XjH50FrlbiwkNiH/zr70aFrCSH1aG0KmnwqMORhUG
 q6Wq1ef4HhtjprwJmfoCJe92rfOW1IVOCY2A5PCrHhtIyDvP+C9gZAFLCM8QoJU7TjzsNfd8wS
 jfE=
X-IronPort-AV: E=Sophos;i="5.70,388,1574092800"; d="scan'208";a="128872433"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 01 Feb 2020 09:08:41 +0800
IronPort-SDR: kx1ov1bH/yZRqiS+W3UN+8GGpaXTEK9BYucecjr7fNMMXU1yo6rorfV/IntvptAjazhDiMoVCX
 mOMQ9ORk1XL0N23FJP/yTk/6EGpSYYtm/09ZTRaeaCnBcAbo4HpUE9vFcS4+aQAuBzx/qdUoxQ
 6UMRxx2kim2p286WVuFrm5zTdWUrSoRN1mdhdS3Y7mwe3ioxtDQUDg94zodB7fxaeW9b/hsyFy
 C7OdjnlISZh76aZbcM6cGpZaH/UshohzT+UEUR6MInR2Pe27RnfXLHoFiXPzxZHwem5bwB3cSL
 xhcTFYip3LFqDAkAVRQ8W6lI
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Jan 2020 17:01:49 -0800
IronPort-SDR: TsEmG+Cy0SOkRuTOxTg7S5JpAPEgG+vG0QBL7Ix2DnkflX0Im7TqIsVEw8crGMxQZwl6uR7Rwe
 u/pQyUHq6zgVRIphbjdl5tIigv70glTYvqTjSepKw9V8PxLDCec32p1Ywoe6iZnse4NVhDBvoU
 O5npzyvXLvV/qbxiTDmB7i8LssxkkZrvOWg9JuZgsvnyEf32iB7tWMMrGvQjBK3WnsNlfK8n9j
 J+qoaPYevU0lTdJcJTOSv2kBT0xmViC2Rqas9dhQl8XefTZG+fbpfshhjVGkiGA5ie2qdaQL9R
 zeY=
WDCIronportException: Internal
Received: from risc6-mainframe.sdcorp.global.sandisk.com (HELO
 risc6-mainframe.int.fusionio.com) ([10.196.158.235])
 by uls-op-cesaip02.wdc.com with ESMTP; 31 Jan 2020 17:08:41 -0800
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [PATCH v2 11/35] target/riscv: Add Hypervisor CSR access functions
Date: Fri, 31 Jan 2020 17:02:04 -0800
Message-Id: <5407d42e2e32b76f6f2fe7731f48c28f80cbd026.1580518859.git.alistair.francis@wdc.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <cover.1580518859.git.alistair.francis@wdc.com>
References: <cover.1580518859.git.alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x [fuzzy]
X-Received-From: 216.71.154.42
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
Cc: alistair.francis@wdc.com, palmer@dabbelt.com, alistair23@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Palmer Dabbelt <palmerdabbelt@google.com>
---
 target/riscv/csr.c | 136 ++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 134 insertions(+), 2 deletions(-)

diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index c63b2f980c..bee639e92e 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -98,6 +98,20 @@ static int smode(CPURISCVState *env, int csrno)
     return -!riscv_has_ext(env, RVS);
 }
 
+static int hmode(CPURISCVState *env, int csrno)
+{
+    if (riscv_has_ext(env, RVS) &&
+        riscv_has_ext(env, RVH)) {
+        /* Hypervisor extension is supported */
+        if ((env->priv == PRV_S && !riscv_cpu_virt_enabled(env)) ||
+            env->priv == PRV_M) {
+            return 0;
+        }
+    }
+
+    return -1;
+}
+
 static int pmp(CPURISCVState *env, int csrno)
 {
     return -!riscv_feature(env, RISCV_FEATURE_PMP);
@@ -226,8 +240,9 @@ static int read_timeh(CPURISCVState *env, int csrno, target_ulong *val)
 
 /* Machine constants */
 
-#define M_MODE_INTERRUPTS (MIP_MSIP | MIP_MTIP | MIP_MEIP)
-#define S_MODE_INTERRUPTS (MIP_SSIP | MIP_STIP | MIP_SEIP)
+#define M_MODE_INTERRUPTS  (MIP_MSIP | MIP_MTIP | MIP_MEIP)
+#define S_MODE_INTERRUPTS  (MIP_SSIP | MIP_STIP | MIP_SEIP)
+#define VS_MODE_INTERRUPTS (MIP_VSSIP | MIP_VSTIP | MIP_VSEIP)
 
 static const target_ulong delegable_ints = S_MODE_INTERRUPTS;
 static const target_ulong all_ints = M_MODE_INTERRUPTS | S_MODE_INTERRUPTS;
@@ -257,6 +272,7 @@ static const target_ulong sstatus_v1_10_mask = SSTATUS_SIE | SSTATUS_SPIE |
     SSTATUS_UIE | SSTATUS_UPIE | SSTATUS_SPP | SSTATUS_FS | SSTATUS_XS |
     SSTATUS_SUM | SSTATUS_MXR | SSTATUS_SD;
 static const target_ulong sip_writable_mask = SIP_SSIP | MIP_USIP | MIP_UEIP;
+static const target_ulong hip_writable_mask = MIP_VSSIP | MIP_VSTIP | MIP_VSEIP;
 
 #if defined(TARGET_RISCV32)
 static const char valid_vm_1_09[16] = {
@@ -756,6 +772,112 @@ static int write_satp(CPURISCVState *env, int csrno, target_ulong val)
     return 0;
 }
 
+/* Hypervisor Extensions */
+static int read_hstatus(CPURISCVState *env, int csrno, target_ulong *val)
+{
+    *val = env->hstatus;
+    return 0;
+}
+
+static int write_hstatus(CPURISCVState *env, int csrno, target_ulong val)
+{
+    env->hstatus = val;
+    return 0;
+}
+
+static int read_hedeleg(CPURISCVState *env, int csrno, target_ulong *val)
+{
+    *val = env->hedeleg;
+    return 0;
+}
+
+static int write_hedeleg(CPURISCVState *env, int csrno, target_ulong val)
+{
+    env->hedeleg = val;
+    return 0;
+}
+
+static int read_hideleg(CPURISCVState *env, int csrno, target_ulong *val)
+{
+    *val = env->hideleg;
+    return 0;
+}
+
+static int write_hideleg(CPURISCVState *env, int csrno, target_ulong val)
+{
+    env->hideleg = val;
+    return 0;
+}
+
+static int rmw_hip(CPURISCVState *env, int csrno, target_ulong *ret_value,
+                   target_ulong new_value, target_ulong write_mask)
+{
+    int ret = rmw_mip(env, 0, ret_value, new_value,
+                      write_mask & hip_writable_mask);
+
+    return ret;
+}
+
+static int read_hie(CPURISCVState *env, int csrno, target_ulong *val)
+{
+    *val = env->mie & VS_MODE_INTERRUPTS;
+    return 0;
+}
+
+static int write_hie(CPURISCVState *env, int csrno, target_ulong val)
+{
+    target_ulong newval = (env->mie & ~VS_MODE_INTERRUPTS) | (val & VS_MODE_INTERRUPTS);
+    return write_mie(env, CSR_MIE, newval);
+}
+
+static int read_hcounteren(CPURISCVState *env, int csrno, target_ulong *val)
+{
+    *val = env->hcounteren;
+    return 0;
+}
+
+static int write_hcounteren(CPURISCVState *env, int csrno, target_ulong val)
+{
+    env->hcounteren = val;
+    return 0;
+}
+
+static int read_htval(CPURISCVState *env, int csrno, target_ulong *val)
+{
+    *val = env->htval;
+    return 0;
+}
+
+static int write_htval(CPURISCVState *env, int csrno, target_ulong val)
+{
+    env->htval = val;
+    return 0;
+}
+
+static int read_htinst(CPURISCVState *env, int csrno, target_ulong *val)
+{
+    *val = env->htinst;
+    return 0;
+}
+
+static int write_htinst(CPURISCVState *env, int csrno, target_ulong val)
+{
+    env->htinst = val;
+    return 0;
+}
+
+static int read_hgatp(CPURISCVState *env, int csrno, target_ulong *val)
+{
+    *val = env->hgatp;
+    return 0;
+}
+
+static int write_hgatp(CPURISCVState *env, int csrno, target_ulong val)
+{
+    env->hgatp = val;
+    return 0;
+}
+
 /* Physical Memory Protection */
 static int read_pmpcfg(CPURISCVState *env, int csrno, target_ulong *val)
 {
@@ -959,6 +1081,16 @@ static riscv_csr_operations csr_ops[CSR_TABLE_SIZE] = {
     /* Supervisor Protection and Translation */
     [CSR_SATP] =                { smode, read_satp,        write_satp        },
 
+    [CSR_HSTATUS] =             { hmode,   read_hstatus,     write_hstatus    },
+    [CSR_HEDELEG] =             { hmode,   read_hedeleg,     write_hedeleg    },
+    [CSR_HIDELEG] =             { hmode,   read_hideleg,     write_hideleg    },
+    [CSR_HIP] =                 { hmode,   NULL,     NULL,     rmw_hip        },
+    [CSR_HIE] =                 { hmode,   read_hie,         write_hie        },
+    [CSR_HCOUNTEREN] =          { hmode,   read_hcounteren,  write_hcounteren },
+    [CSR_HTVAL] =               { hmode,   read_htval,       write_htval      },
+    [CSR_HTINST] =              { hmode,   read_htinst,      write_htinst     },
+    [CSR_HGATP] =               { hmode,   read_hgatp,       write_hgatp      },
+
     /* Physical Memory Protection */
     [CSR_PMPCFG0  ... CSR_PMPADDR9] =  { pmp,   read_pmpcfg,  write_pmpcfg   },
     [CSR_PMPADDR0 ... CSR_PMPADDR15] = { pmp,   read_pmpaddr, write_pmpaddr  },
-- 
2.25.0



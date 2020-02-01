Return-Path: <SRS0=CCzH=3V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8C08C33CB7
	for <qemu-devel@archiver.kernel.org>; Sat,  1 Feb 2020 01:16:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A568E206F0
	for <qemu-devel@archiver.kernel.org>; Sat,  1 Feb 2020 01:16:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="ePMoXUop"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A568E206F0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34380 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ixhOL-00055e-QV
	for qemu-devel@archiver.kernel.org; Fri, 31 Jan 2020 20:16:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56730)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <prvs=2939926b3=alistair.francis@wdc.com>)
 id 1ixhHC-0001UG-A3
 for qemu-devel@nongnu.org; Fri, 31 Jan 2020 20:08:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <prvs=2939926b3=alistair.francis@wdc.com>)
 id 1ixhHB-0006HP-0H
 for qemu-devel@nongnu.org; Fri, 31 Jan 2020 20:08:46 -0500
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:17129)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <prvs=2939926b3=alistair.francis@wdc.com>)
 id 1ixhHA-00069K-Jk; Fri, 31 Jan 2020 20:08:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1580519324; x=1612055324;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=xXeiZpCbNQQ4KJaLYLoSQn/LmEOAnQ1DDhfk4qpe3N8=;
 b=ePMoXUoppfcbtqqd5Ttb5qWbLO96t9KHDwfI+CvRkkq7puhI5B6rvlbp
 nEDLwH5/8VnSB10/1bqSnBt+pg+iKa/CVUsA7MZltQqQI7VmEgMOrZa+i
 Tge58EjoOvJwy4HRw75Y3JKtxCfk6a7uNeJLkCgsRZHBO3XlFpbn4K1va
 uwylZ9FIBK2VWqt36Jhmu79CKKGmGiPnIvxAMP+sdFma9VNHyzC2ulYam
 GUMJesq+Ar1h27Wx9MsOurgoFfEseZYgsTr/MzhrjyflNBdexKGY/rbsb
 zkPaHxOCJ4KzPAC/Hle2f1DqsuZBAAbRx5MiD+K+TlLYZXsbl8AmfAmuL w==;
IronPort-SDR: qdlRjnyRyWc84V9iDEQq493d9IeXuBcon7tF85smpfMKVrnxfhMmnaesVBHSkBlZ7Hbx7DN2b0
 unIHQNfdDMp4E/61rm90hKTl07DwJd2OgQZvaMmwqm5guE/v6KL6AFBhjnozuey76Q2uFFbf4F
 WiImrQNylwA1rFPWvvtF6TrovlHfHlRSIWzMeZG88PKMPzFGItyJZlz9yHr5JxHVLHRYIXazZ1
 xD1U0tnvlTn0WHNs+O4xfcCoDWe+tkvNtnD85qQhJXaRNM6KtHOlync0HuTPhsB70NsjwF7NZa
 gNg=
X-IronPort-AV: E=Sophos;i="5.70,388,1574092800"; d="scan'208";a="128872436"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 01 Feb 2020 09:08:43 +0800
IronPort-SDR: rQzaGlk1ldvIQ44TaR/K/bGuKOtwfwVO1XtrMMJvY5ooXg4jF+4Bx/ucVgCmwQxLk6dFZT0NFx
 nGkcK7EIH6Y9f5MaVqA1tzvCpDaVVqEyaupWKMwA6zmL5nBdGAg08r9aRmR8fOacvnUZd9C3xs
 z8SDt8XDLPez8myLoLnS0U/EAWSpx1fKVnWr0PrXzFJ0QKEAEI7ZthKg3gkAjwi7fju7T7y54a
 s3F55DgJVMh9HtkedMeou2FV6cBPmeBDlNcMuObO7V1F4X1Tc44IHKcEyEa6mRQhtczRHA/Ji8
 32azonjaGgfT6L0IIRuWvMj+
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Jan 2020 17:01:52 -0800
IronPort-SDR: Ehv55QcgAWQzHbUeEFh/JIC7mJHsrfq13yk6bL/LLYDV7Ye4fq2215L4v1aZ/IgBoZIJgO7q9V
 Tht8Qx88+vIcGpAn6uyLLMrVV09FIt9I3WcH1vHHARUELnUij13qnh7ApzVrc7JqYwH4tDmICU
 ZHx6ypGnHX77KMOIj9Lc/utTmXukqB/jxdCzsvMxjYMEUMft7D7746VBwai41i3PiC8xE4/M3N
 xgHaULCElFFc+rFV7hSVjRMkYR9fpbws70G54s1JT/ld+wPMhOTt6/BfNUad5QXKOO9k2Xlyqn
 KcI=
WDCIronportException: Internal
Received: from risc6-mainframe.sdcorp.global.sandisk.com (HELO
 risc6-mainframe.int.fusionio.com) ([10.196.158.235])
 by uls-op-cesaip02.wdc.com with ESMTP; 31 Jan 2020 17:08:44 -0800
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [PATCH v2 12/35] target/riscv: Add Hypervisor virtual CSRs accesses
Date: Fri, 31 Jan 2020 17:02:07 -0800
Message-Id: <95bdf97032a5e0b6fc82644007e5d16778050d13.1580518859.git.alistair.francis@wdc.com>
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
Reviewed-by: Palmer Dabbelt <palmer@sifive.com>
---
 target/riscv/csr.c | 116 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 116 insertions(+)

diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index bee639e92e..3fa8d2cfda 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -273,6 +273,7 @@ static const target_ulong sstatus_v1_10_mask = SSTATUS_SIE | SSTATUS_SPIE |
     SSTATUS_SUM | SSTATUS_MXR | SSTATUS_SD;
 static const target_ulong sip_writable_mask = SIP_SSIP | MIP_USIP | MIP_UEIP;
 static const target_ulong hip_writable_mask = MIP_VSSIP | MIP_VSTIP | MIP_VSEIP;
+static const target_ulong vsip_writable_mask = MIP_VSSIP;
 
 #if defined(TARGET_RISCV32)
 static const char valid_vm_1_09[16] = {
@@ -878,6 +879,111 @@ static int write_hgatp(CPURISCVState *env, int csrno, target_ulong val)
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
+static int rmw_vsip(CPURISCVState *env, int csrno, target_ulong *ret_value,
+                    target_ulong new_value, target_ulong write_mask)
+{
+    int ret = rmw_mip(env, 0, ret_value, new_value,
+                      write_mask & env->mideleg & vsip_writable_mask);
+    return ret;
+}
+
+static int read_vsie(CPURISCVState *env, int csrno, target_ulong *val)
+{
+    *val = env->mie & env->mideleg & VS_MODE_INTERRUPTS;
+    return 0;
+}
+
+static int write_vsie(CPURISCVState *env, int csrno, target_ulong val)
+{
+    target_ulong newval = (env->mie & ~env->mideleg) | (val & env->mideleg & MIP_VSSIP);
+    return write_mie(env, CSR_MIE, newval);
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
@@ -1091,6 +1197,16 @@ static riscv_csr_operations csr_ops[CSR_TABLE_SIZE] = {
     [CSR_HTINST] =              { hmode,   read_htinst,      write_htinst     },
     [CSR_HGATP] =               { hmode,   read_hgatp,       write_hgatp      },
 
+    [CSR_VSSTATUS] =            { hmode,   read_vsstatus,    write_vsstatus   },
+    [CSR_VSIP] =                { hmode,   NULL,     NULL,     rmw_vsip       },
+    [CSR_VSIE] =                { hmode,   read_vsie,        write_vsie       },
+    [CSR_VSTVEC] =              { hmode,   read_vstvec,      write_vstvec     },
+    [CSR_VSSCRATCH] =           { hmode,   read_vsscratch,   write_vsscratch  },
+    [CSR_VSEPC] =               { hmode,   read_vsepc,       write_vsepc      },
+    [CSR_VSCAUSE] =             { hmode,   read_vscause,     write_vscause    },
+    [CSR_VSTVAL] =              { hmode,   read_vstval,      write_vstval     },
+    [CSR_VSATP] =               { hmode,   read_vsatp,       write_vsatp      },
+
     /* Physical Memory Protection */
     [CSR_PMPCFG0  ... CSR_PMPADDR9] =  { pmp,   read_pmpcfg,  write_pmpcfg   },
     [CSR_PMPADDR0 ... CSR_PMPADDR15] = { pmp,   read_pmpaddr, write_pmpaddr  },
-- 
2.25.0



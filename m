Return-Path: <SRS0=fi8h=Z7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 056DEC04E30
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2019 18:30:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C6E8D2077B
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2019 18:30:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Ckp6HhVK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C6E8D2077B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44564 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ieNnm-0001AW-9W
	for qemu-devel@archiver.kernel.org; Mon, 09 Dec 2019 13:30:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34691)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <prvs=23948302b=alistair.francis@wdc.com>)
 id 1ieNac-00077f-DI
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 13:16:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <prvs=23948302b=alistair.francis@wdc.com>)
 id 1ieNaa-0007L0-UC
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 13:16:58 -0500
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:57667)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <prvs=23948302b=alistair.francis@wdc.com>)
 id 1ieNaa-0007Jf-M3; Mon, 09 Dec 2019 13:16:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1575915416; x=1607451416;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=4H0su8MGdCo0qAyvbF2q3YIaN3niPJWSOwi/vIFwuzE=;
 b=Ckp6HhVKeuEts+Cjk4yVKo2pu6H0bByIFUziYPzrQh3VzrLlespHWwUg
 Cw8V6632NPNrQflCZQ8/zFek6IwjQDmGcP+B+TMjCFpiU4H/CYyRGAuwE
 TDDGI4woeCWh9LW5HTuY/9ddGQ2pdBFq+drt0abgGIGXX+T9YhNYJmNm6
 YTRFMBlhPfiqtRP451zosTnFlA+2BgtX6MWEoTdY6LpFJ8BdyjfJtUaXq
 6LiPGWeE0sFvWxbx42YNy/Y6MxQcVN6G6VfXV3yhbqIWaIicSlRWDTE8R
 SqDZdVWK5Eupe1ANY0sY2+UfuPRJAcsqwDTEJHOfDBzs3bg3iLRV+9tJ0 w==;
IronPort-SDR: O+fwkJ3aI0udIk0VkGksnU94SvJMIWUsv3yPYzq71aKgyVx64zYgWLWYqNrvo8nZhQ+1yd7J83
 KbqXprLqml8cb9gwju1BJr9HEhVOUPBvgh0ClfHCsiduKTUDMZPT7EDPqA8qQZteq8o5Zq6Ydg
 t/hSNqDe3KZ00g6Rix4tsV9ECRpiPANc75jgEYhQYqhtaE8E0tgdZlvxeSydtcXmFZQ29mEpXF
 z37ud7RR5FpuvSrJ17Aov1EYkurC4E2Ck5Bwyr3xlxPTPNYymHMDiaIMtjiL9GDq0mAvtcN0F7
 QDQ=
X-IronPort-AV: E=Sophos;i="5.69,296,1571673600"; d="scan'208";a="129370432"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 10 Dec 2019 02:16:56 +0800
IronPort-SDR: 27ap37Q8ddo8sNrdavUwHQE/RP/CPTig/Sv9cJQxvJpzciaZ1L6wwNblsNn2mAkYdPCcbnEJl5
 mprzpDrfPvaHNWrFSagaXnnfKK3e1eZL3759TymNxz6GTCEomInumYsd1u+RgdKYBy2T8E+Lr4
 709uB6u0vMyaNFQoU1QF4Xbw0y9Dim0A0E/JtYjJC5S20adk+1L5GnwXDUhvZsXNopOyzcs5jw
 y4zyb18YP0x0ZdHpf1v0QHtGLBAlxlR23gGswcGWpdKjuPzToju8vn0SxGbzkITQUm6jC3c9+e
 wquSxCiVEfmVXxf9zLIged5s
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Dec 2019 10:11:34 -0800
IronPort-SDR: ZfvlB9mWHb6DAy1yE912QfMVFeB431CHmmHclf8rSMH7LIji0eJte0JoBMxgWvtpw0MlSauGzd
 EMtl6U+i+CWQs4E1ACDjn50JOCEExUh6I57cbZgOJlWnxeQrCIhqu4GrxuNBS8Zix2kISZZ2PF
 uWG+3c4o6lTAaVVmMtruOaCqBKq4ENfn+U3gAzLEOig8xDa2Ku7jzGiaQb5lTm4SrmYTpFvJKS
 /fIwZPkPYlCalJJaQtkICGSzRUVviXnbd95Vf9l0rPo4xhe3aeuCfwdR2OhtHWMPhvFx3TfRX7
 I8k=
WDCIronportException: Internal
Received: from risc6-mainframe.sdcorp.global.sandisk.com (HELO
 risc6-mainframe.int.fusionio.com) ([10.196.158.235])
 by uls-op-cesaip01.wdc.com with ESMTP; 09 Dec 2019 10:16:56 -0800
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [PATCH v1 13/36] target/riscv: Add Hypervisor virtual CSRs accesses
Date: Mon,  9 Dec 2019 10:11:14 -0800
Message-Id: <ddc8b8fcd0a3f9257c1f5be15daef38a456f51e9.1575914822.git.alistair.francis@wdc.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <cover.1575914822.git.alistair.francis@wdc.com>
References: <cover.1575914822.git.alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x [fuzzy]
X-Received-From: 216.71.153.141
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
index b582d78529..aaca1a6a0f 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -273,6 +273,7 @@ static const target_ulong sstatus_v1_10_mask = SSTATUS_SIE | SSTATUS_SPIE |
     SSTATUS_SUM | SSTATUS_MXR | SSTATUS_SD;
 static const target_ulong sip_writable_mask = SIP_SSIP | MIP_USIP | MIP_UEIP;
 static const target_ulong hip_writable_mask = MIP_VSSIP | MIP_VSTIP | MIP_VSEIP;
+static const target_ulong vsip_writable_mask = MIP_VSSIP;
 
 #if defined(TARGET_RISCV32)
 static const char valid_vm_1_09[16] = {
@@ -879,6 +880,111 @@ static int write_hgatp(CPURISCVState *env, int csrno, target_ulong val)
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
@@ -1092,6 +1198,16 @@ static riscv_csr_operations csr_ops[CSR_TABLE_SIZE] = {
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
2.24.0



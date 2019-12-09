Return-Path: <SRS0=fi8h=Z7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA98DC43603
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2019 18:28:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A603C2077B
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2019 18:28:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="lILCU8pt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A603C2077B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44510 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ieNlZ-0006Tw-Am
	for qemu-devel@archiver.kernel.org; Mon, 09 Dec 2019 13:28:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34715)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <prvs=23948302b=alistair.francis@wdc.com>)
 id 1ieNae-0007AS-GV
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 13:17:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <prvs=23948302b=alistair.francis@wdc.com>)
 id 1ieNad-0007M1-Bv
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 13:17:00 -0500
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:57667)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <prvs=23948302b=alistair.francis@wdc.com>)
 id 1ieNad-0007Jf-47; Mon, 09 Dec 2019 13:16:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1575915419; x=1607451419;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=aFV6a5TMmH00v0HSF5cJZxQVKLnBil0VvuNFCY825ZY=;
 b=lILCU8pt7p7kJQGaEZ6oexhuIdNTzbgD4HVxqa47KTQz0sE1faJwubp5
 6CdWzhGS19cgezUBlBePmjacp/sd0/pt3N+/Dv6D3uh/rYOJZkMu5zX4z
 FsseZYKUuqdsH18l1WEoE8ZtygFW71JahGc90t3xBLc9JvUSC1fsfa/qv
 tjT9HIcn3iFVLLCtlXCM9gBSPVD6sCAOH1HiCDPHCCMFzSD5lW8YuZaDD
 LBVEAiIJxBEghSJqvGWC+WN/k18EqxQIRxd1+TbtSy7t4X3m+3f5zBKb6
 gtH/leghpUdEnu8zeniXM4Zllz+bLTGaiXwePVM3vS8Rc8iLzxrkrQEDP Q==;
IronPort-SDR: dKzFAppBmc91BQuWegL81pcku1FitrB59RyAGHlcp+27PWiyMbzluX70ylLF4kPPQM91IDps1f
 NpQbc+Qi7cOEn8tA5SxICUOKItLwMwsX8g/MQRTpH3qH20hCgMzBCkMTc9vwt2HWmbzlc9F7uh
 Hw/QheJgVZn/aESGKkPHv6EQDIWQFPFwv6HAZfFhCW77bviGXCpXPhO9QOnYVt99xPmav7uqng
 +fnqkA0auX6dixHORggqC/oLNm/zsQKamMX3FfpdmUiZn2xQESDqtCaMZERMv1LwyJxEBAHzvc
 7Z8=
X-IronPort-AV: E=Sophos;i="5.69,296,1571673600"; d="scan'208";a="129370435"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 10 Dec 2019 02:16:58 +0800
IronPort-SDR: jJs2BsolrYXPK2VAkKHGRqmNt5MSNM12sXyJEtcbenFwdqovWDjMKk6Cc9qu4CKc7zCI06CQpZ
 UqMUmvr8iGKPKC7ncf4R51uhY/j/wv5tR2OXLMoPT3c4Aut6cSos353vH8ZsKAMbVIqgd9NBu0
 lmirdbWx5u9z3uW9auNQjgo5K7RNPvbVOc2wPyfUwNPP+YW9N6njpvvgBj1wBt++3iyRIrC7ZV
 z0udVzvdkcAbRRSWxsGkjoIP6bTOMzj3ghL6Frs67xsLbeA+cjC5uVIpW68fNcU0hc9bwTEslQ
 ltGPo6zvuCt92b/MktpHLbUx
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Dec 2019 10:11:36 -0800
IronPort-SDR: tf36dRlQIPSn4AMu5ggMTF8pi6MvNwiGAmbfVmEM8N/dbKlxpWvQY3QD0WM1i/+mG0I6XB7ZJ1
 SWZQfJHKlbOfZYPAlkVVBqsRJp+Hnpu5p79RmoD9Kwr6BxdL2xw/WXa8uGea3/99fN1/xT+kNQ
 Ws3vDLFCrK8G39WyPcDBSAZIpvKaa/z7qgXXPABcczdYWrx99k+yjI0yjtKnr9lJmZQxRa6rz8
 pGR+xDbyelTo2Ddmnv3rwrcHDo+YJpPabGFJ2hGMm+1PWtsrNd700lRfOsPIkLQyP274xC5UtN
 jbc=
WDCIronportException: Internal
Received: from risc6-mainframe.sdcorp.global.sandisk.com (HELO
 risc6-mainframe.int.fusionio.com) ([10.196.158.235])
 by uls-op-cesaip01.wdc.com with ESMTP; 09 Dec 2019 10:16:59 -0800
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [PATCH v1 14/36] target/riscv: Add Hypervisor virtual CSRs accesses
Date: Mon,  9 Dec 2019 10:11:17 -0800
Message-Id: <6245a7d85ae108253970aecd57b47a3f6ddeec2c.1575914822.git.alistair.francis@wdc.com>
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
---
 target/riscv/csr.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index aaca1a6a0f..74e911af08 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -985,6 +985,30 @@ static int write_vsatp(CPURISCVState *env, int csrno, target_ulong val)
     return 0;
 }
 
+static int read_mtval2(CPURISCVState *env, int csrno, target_ulong *val)
+{
+    *val = env->mtval2;
+    return 0;
+}
+
+static int write_mtval2(CPURISCVState *env, int csrno, target_ulong val)
+{
+    env->mtval2 = val;
+    return 0;
+}
+
+static int read_mtinst(CPURISCVState *env, int csrno, target_ulong *val)
+{
+    *val = env->mtinst;
+    return 0;
+}
+
+static int write_mtinst(CPURISCVState *env, int csrno, target_ulong val)
+{
+    env->mtinst = val;
+    return 0;
+}
+
 /* Physical Memory Protection */
 static int read_pmpcfg(CPURISCVState *env, int csrno, target_ulong *val)
 {
@@ -1208,6 +1232,9 @@ static riscv_csr_operations csr_ops[CSR_TABLE_SIZE] = {
     [CSR_VSTVAL] =              { hmode,   read_vstval,      write_vstval     },
     [CSR_VSATP] =               { hmode,   read_vsatp,       write_vsatp      },
 
+    [CSR_MTVAL2] =              { hmode,   read_mtval2,      write_mtval2     },
+    [CSR_MTINST] =              { hmode,   read_mtinst,      write_mtinst     },
+
     /* Physical Memory Protection */
     [CSR_PMPCFG0  ... CSR_PMPADDR9] =  { pmp,   read_pmpcfg,  write_pmpcfg   },
     [CSR_PMPADDR0 ... CSR_PMPADDR15] = { pmp,   read_pmpaddr, write_pmpaddr  },
-- 
2.24.0



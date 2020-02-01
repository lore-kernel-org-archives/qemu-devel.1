Return-Path: <SRS0=CCzH=3V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8019DC33CB7
	for <qemu-devel@archiver.kernel.org>; Sat,  1 Feb 2020 01:18:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4BF7B206F0
	for <qemu-devel@archiver.kernel.org>; Sat,  1 Feb 2020 01:18:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Ora3d/iq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4BF7B206F0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34436 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ixhR1-00005U-Gw
	for qemu-devel@archiver.kernel.org; Fri, 31 Jan 2020 20:18:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56754)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <prvs=2939926b3=alistair.francis@wdc.com>)
 id 1ixhHE-0001b7-NT
 for qemu-devel@nongnu.org; Fri, 31 Jan 2020 20:08:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <prvs=2939926b3=alistair.francis@wdc.com>)
 id 1ixhHD-0006IJ-OK
 for qemu-devel@nongnu.org; Fri, 31 Jan 2020 20:08:48 -0500
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:17129)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <prvs=2939926b3=alistair.francis@wdc.com>)
 id 1ixhHD-00069K-GB; Fri, 31 Jan 2020 20:08:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1580519327; x=1612055327;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=Kphn0jkVfgG8knJMnPW0CMVlXCQNQw727QC8fZenLwQ=;
 b=Ora3d/iq/NZsdfdzTOntUh/vtEtJSVWDVVltb/mCMk/vq3y3+U1hBw23
 psI9kOi+5+0tYx3qABJ1Rlo0Zaa6vuj+GLmHkJmRwtNWbWuYDlUt3ZBN0
 MS0V3TEh0MWAlhvouffV+jItDyoK0IDHXsF1JpFUa899a0pz+XwMhLUwZ
 c/bxNvF37yE519o1sbvsNr3IcKiF+u+uOF2bG/x8ZIKyf5hcDs+fgjJWV
 06FXgcA5ltBu0q8FFsH1Iy0DsouUY0FUQW4o2IKgUB2j9e43qSVnGmiho
 eFBLS3vU9Xy09pObPjAjlBop4Oz158cThIwvKP5NjtvDgqeGh0EqQXrJx A==;
IronPort-SDR: ktRFwKmVeS0J3aeZsuyxZGvhO2J1NtuczYEYgw3yKRSRdNavVqyePmSObbTNvJ00OSSCrquOeB
 8cS39y4Nok4RcdYd69qyhsmV7E7PjxeTMAZsfzjbIlbufZsR0nsTQs0u4vKp3pNdPejoBhvzs1
 CWFUO8kZirweZZ9ezIEitp2NxVQbqfXoAoJA2lDGy8xcutjh5T+9hJtKFRSS8tLenHeOnF3t0f
 Y1WY03HwNBvcMCyd6bq0GfdXKRtubkDqT49Jf1A7P+lI7uK6Fyxg1qbKeI+I/uczZsH55DsmuF
 2u4=
X-IronPort-AV: E=Sophos;i="5.70,388,1574092800"; d="scan'208";a="128872441"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 01 Feb 2020 09:08:46 +0800
IronPort-SDR: mSVc8Vfdn0MVMo9FI8AHkEoDQfkY6it3myp89gQMwcAKKH48J7Uz5yZhpt9Tb/ck9vFhXPYyxq
 OFu/05BP7aA/la9KBxIb0rpp+oVR7qgEwxIsa1HBxCNbzkeXFnTZ0xG+Qd4qimE0AHM1XO/NzK
 qttp67j1h3FurkFdT6rJG7E8MQMtDxUPBjZ+Rn9UzzJqLe7KGVG/IOn67NaCQrJVJOKAvP5S9h
 s5GKn9GyWb2suGPAE+VP9KcSZTG2OZJMoI7j/Hp2WdNnWkvSqozhMYMgtHDvrRYWm/AC5EOrQn
 yFzCeXkeALxiApSlzv3sVJhl
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Jan 2020 17:01:55 -0800
IronPort-SDR: WczzS5s+lIhWy1hegcTEP6IOwN4cOMhqMfPSJwTr6SS4ygz/aQTXpp1AEcrgR3DZqqDEgepFYS
 9OaRmSb9heEfRZqzXfXCMu44wYwQVLAEpuVSQ8xO/PKCNXN/gQ5KZoZhYSNfVvsxqKplyjXxeY
 9CDGFBShk8YXWFh+ARWKFvSKfETBCEwKZuYFgq/b+GEFxHSlEYVRQUUe2j8xWVcMm544rFut7A
 u1bBrb5bQSmT7GzRr2q/0FG1ESmSWrNdqtGaP33p0p29dmzEFjZIisVL34JJBfgQthkprPECF7
 r3o=
WDCIronportException: Internal
Received: from risc6-mainframe.sdcorp.global.sandisk.com (HELO
 risc6-mainframe.int.fusionio.com) ([10.196.158.235])
 by uls-op-cesaip01.wdc.com with ESMTP; 31 Jan 2020 17:08:47 -0800
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [PATCH v2 13/35] target/riscv: Add Hypervisor machine CSRs accesses
Date: Fri, 31 Jan 2020 17:02:10 -0800
Message-Id: <d3b528614b944b4f4c6694ecdeabd90e0466b1b1.1580518859.git.alistair.francis@wdc.com>
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
 target/riscv/csr.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index 3fa8d2cfda..f7333286bd 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -984,6 +984,30 @@ static int write_vsatp(CPURISCVState *env, int csrno, target_ulong val)
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
@@ -1207,6 +1231,9 @@ static riscv_csr_operations csr_ops[CSR_TABLE_SIZE] = {
     [CSR_VSTVAL] =              { hmode,   read_vstval,      write_vstval     },
     [CSR_VSATP] =               { hmode,   read_vsatp,       write_vsatp      },
 
+    [CSR_MTVAL2] =              { hmode,   read_mtval2,      write_mtval2     },
+    [CSR_MTINST] =              { hmode,   read_mtinst,      write_mtinst     },
+
     /* Physical Memory Protection */
     [CSR_PMPCFG0  ... CSR_PMPADDR9] =  { pmp,   read_pmpcfg,  write_pmpcfg   },
     [CSR_PMPADDR0 ... CSR_PMPADDR15] = { pmp,   read_pmpaddr, write_pmpaddr  },
-- 
2.25.0



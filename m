Return-Path: <SRS0=ZVNi=XW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A6A6C4360C
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2019 00:54:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D86BC2146E
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2019 00:54:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="VIpAhLZc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D86BC2146E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45762 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iDeWf-0004Ey-Mm
	for qemu-devel@archiver.kernel.org; Thu, 26 Sep 2019 20:54:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50135)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <prvs=1662a5b7b=alistair.francis@wdc.com>)
 id 1iDeSH-0007w7-C2
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 20:49:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <prvs=1662a5b7b=alistair.francis@wdc.com>)
 id 1iDeSF-0000z6-DW
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 20:49:53 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:3754)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <prvs=1662a5b7b=alistair.francis@wdc.com>)
 id 1iDeSF-0000we-4E; Thu, 26 Sep 2019 20:49:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1569545391; x=1601081391;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=egc9hiyTimfV6T3zfWJDhM5fG6JVMG71fDf7W0KqdI8=;
 b=VIpAhLZcXNr3YVjnq3DBY9STh/pwfUSdcC5m8kpA4hPvOApc7QKJq2n0
 AxoHqxWuCrg1tBHwHXs1jZRGql20KWNwqdQXo23khyGKXZCPsc857ySfr
 M/bN8EkX4+94DigvSPrqeQz+WuoocLz3zw5C282IMxkRi+Na7wMlvyrW4
 9LsvUJ5XHUD7v1sY4s3lWwEqeHhzA+BRdrG0wn51sBE2mp0IoIn+AtiQQ
 ySf1G4ydoeqJ0i9K3c5ICE4tndjGdCNGh4nyWA4/2MhZhHC7dDij9ztgX
 KQbYVyqr09OgnstOiepqBdwG2YB7urvTVNEKNic6p4V2Njw8307mZbu1U Q==;
IronPort-SDR: b9Lx+9Q83IAl0w/67fzr2ocKvaul+erk/xRVp3qzn8u5Sp6+ySO9clk9ODY+qg54ejT7DlkHHE
 53PqkDpNlAnxT0TSg8DPUll7HDqBXHoIvd0vhp6ja2Lvpe7REOAaBe3pfwabuz+eR0/Hw/cVM6
 CkJSVmpFVqr1dwRIYXWg8NehHr2RRhql8k8IwD7L3jJMJgmZxMVwvDzfgTsW63GD5hmEAkRFnk
 sH9WMEyo1Al79K0R6+RN4rXeiW/ZR0FphC8IRVoL0zReEF6Ry8rkFxNHSp4KfjM3VFKWrnOm89
 CpI=
X-IronPort-AV: E=Sophos;i="5.64,553,1559491200"; d="scan'208";a="226106297"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 27 Sep 2019 08:49:49 +0800
IronPort-SDR: 3EkUM4yjjy7kHLp1EV8myz8nCSczkP1nTNEO9KuJlUwB3+gfCX5JwSMnctHRB/CKCPJRGo7Fgk
 20PKVvws/3q3R7rHqKJu1k4ryoCUnoVyrE0wtW7DiPiy+jBz13j6+FSHht+4YVoENbp1z0/Iwn
 K8UFO9sKyCUfxBCZp8nD4mj6IJWzTPIPEu5Rm/2LyDMHVHvJ2uknKYFYxHxq9nveekreNKUhKR
 tbWkNZP1cNhAr36HKQMU0MPizEpEDHkQojTrX+NAQe/IqTf/xPJMIj0D9O/lKqFiwoHcihh2+Z
 6KskR83l1dAKakhHvFiVCgkX
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Sep 2019 17:46:03 -0700
IronPort-SDR: cVOAJ1+OaMBj6oKXajogVkZI7Fjc9f+IxT/OcS2NdKGq+qOLRCKuAqGhQiHKU3loIgsh03zq1X
 VffixM+8rs2A/SwqY8bM2x+6YzsQbrtVnRMC+bYiqdeldMT9G6Pv2prYPSRavtifpuT2CIzh5b
 EByil3cevoMVmMgBIDofz9ozFktK2aW6tToFCPbMh8ibhdma2aG6LkXgzn4LOOTvAi7uoJhK0K
 jB61O6lZQDykpMdB/46W9uEF4EGUGE6XDKUSd70VjrgBSX5/uJGxOIXPjK9xiSNHFPNpJd9rmT
 asQ=
WDCIronportException: Internal
Received: from risc6-mainframe.sdcorp.global.sandisk.com (HELO
 risc6-mainframe.int.fusionio.com) ([10.196.157.58])
 by uls-op-cesaip02.wdc.com with ESMTP; 26 Sep 2019 17:49:49 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [PATCH v1 1/1] target/riscv: Print CPU and privledge in disas
Date: Thu, 26 Sep 2019 17:45:30 -0700
Message-Id: <ab8f108eceb973aaee565bb1fe347fcf8c788f5b.1569545120.git.alistair.francis@wdc.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x [fuzzy]
X-Received-From: 68.232.141.245
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
 target/riscv/translate.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/target/riscv/translate.c b/target/riscv/translate.c
index adeddb85f6..537af0003e 100644
--- a/target/riscv/translate.c
+++ b/target/riscv/translate.c
@@ -810,7 +810,14 @@ static void riscv_tr_tb_stop(DisasContextBase *dcbase, CPUState *cpu)
 
 static void riscv_tr_disas_log(const DisasContextBase *dcbase, CPUState *cpu)
 {
+#ifndef CONFIG_USER_ONLY
+    RISCVCPU *rvcpu = RISCV_CPU(cpu);
+    CPURISCVState *env = &rvcpu->env;
+#endif
     qemu_log("IN: %s\n", lookup_symbol(dcbase->pc_first));
+#ifndef CONFIG_USER_ONLY
+    qemu_log("CPU: %d; priv: "TARGET_FMT_ld"\n", cpu->cpu_index, env->priv);
+#endif
     log_target_disas(cpu, dcbase->pc_first, dcbase->tb->size);
 }
 
-- 
2.23.0



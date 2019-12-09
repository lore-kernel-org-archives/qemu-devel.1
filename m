Return-Path: <SRS0=fi8h=Z7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA376C43603
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2019 18:20:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B3FB4206D3
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2019 18:20:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="W5u6z9Kj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B3FB4206D3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44284 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ieNdi-0002dQ-8W
	for qemu-devel@archiver.kernel.org; Mon, 09 Dec 2019 13:20:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34339)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <prvs=23948302b=alistair.francis@wdc.com>)
 id 1ieNa8-0006Rm-25
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 13:16:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <prvs=23948302b=alistair.francis@wdc.com>)
 id 1ieNa6-000737-PP
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 13:16:27 -0500
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:57627)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <prvs=23948302b=alistair.francis@wdc.com>)
 id 1ieNa6-00072D-3T; Mon, 09 Dec 2019 13:16:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1575915386; x=1607451386;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=vQ0Qc2m9OoP+JuOdf45hxQEXAivSiOJH4JVyasN8uls=;
 b=W5u6z9Kj8dQnA4bbHD2XW0Vio/qyZx/eu9VadHrgur5YZEuQtVW3na03
 60Q6BHNsm78YUfegbUBE1jYlUfpLJktWGW4ZbZNs7RP+E6Hqa1dWL+Bn9
 qtx1ZEV3c4TJPAGsLkiX73Tn7ITr4DkzeeE35gx+aSNdEIajsborB45tn
 QBAvlcOGJ4cPd4xUi0ZGAVNID0k2j/7eKx7JqrCFO7KcT5IY9E4KffdV8
 bMTj8YqnYxCbUW+rWtNtvNZohDStmip+EcCZGzDCRBles6CSiteqadTIb
 fjcH7yijvDhQtxrYewVNMw3Ugyc/w/xaMF/xiirWglvq3/rBWE4ms3lZS Q==;
IronPort-SDR: GvkjpfjA42fzO/IMzrXJKCIKj/AuDU2gYaZpcthUPMR0Om7bQeC/hc9K9swnhdntwSbgBKHBB0
 yoFquwtOLXkuWaNgselpNonG0ShUlzXdtfMDu3H2YK6k4gTsjOEij/9pwxwTc5wJkX4+28LLly
 gdtmWymcuTbzdajHlo3m9A5C9WKR/ZMXfg+WDumiQ19iQ9D/sGzyEQR3wkMo9bg2/YWctLymg9
 B2oW/Dxp7rphA8Fl8h0B2djsuDOwASExRMWkxgDzDjPLMY95dwPNxkTDj5xAeEAu3ajIfDaV+c
 DqI=
X-IronPort-AV: E=Sophos;i="5.69,296,1571673600"; d="scan'208";a="129370397"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 10 Dec 2019 02:16:24 +0800
IronPort-SDR: /ksCScIUzaOpEdCPJX1Z2rvp20Pt09Uc5NrAyYABMRQw3LrNRLn1cAX32cZSpqNPOhNcLD+U0A
 Udh3zWMYvhGPFE9M3WDk5ydGoeY3AJ5Ntxq9RZpVu4t7ivXVQzxC5onfDZQ6T0byH1assP86Qe
 c17ZxFlspVWFhf/0J6e7eofvA8gAvGkBlFxTCeudYRPzaYlMZw5O0O/Q5rZH15HJZ+labK8hEu
 dFWFkcHpBAbKDVTHLObpDcYbwsd+80P+rK3hK/n/fcxi/BurZ3bIneL0Pd1iPgAJ6Ajb97NTqJ
 AA2w8/EphSalj7vBqnfEclDR
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Dec 2019 10:10:41 -0800
IronPort-SDR: 4nq7+TJHNO/s9ZdE38Gi2P//me/LcmH91d3R5Yo96/UNQHvM7J5W5b+MOfCTaEA/9ZXYxA5bhD
 xStIox1Ocps/pX2kp9DduGtwOC/UcQsiWux0jP+E4ks4EbX0JtOnPuFE+5MiaXsAiXxZBYTnSZ
 ZDvB0D/zdtdBceJ1CnMkrQhGKToPzrK3N8CRUrf++yIn9reiGAAE0Phcf4duHM7UUQZIERuFP6
 i9PZGJ88N8l3QVLmbBCTLObRJFgpAxzlABIr+TB52hMrnonPmk1Ri4xdVt3Z8rhR0Oeinm8hEG
 2u8=
WDCIronportException: Internal
Received: from risc6-mainframe.sdcorp.global.sandisk.com (HELO
 risc6-mainframe.int.fusionio.com) ([10.196.158.235])
 by uls-op-cesaip01.wdc.com with ESMTP; 09 Dec 2019 10:16:25 -0800
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [PATCH v1 01/36] target/riscv: Convert MIP CSR to target_ulong
Date: Mon,  9 Dec 2019 10:10:43 -0800
Message-Id: <aa8557d53c1f6d3265e2b2c9bc4e127eddb995ea.1575914822.git.alistair.francis@wdc.com>
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

The MIP CSR is a xlen CSR, it was only 32-bits to allow atomic access.
Now that we don't use atomics for MIP we can change this back to a xlen
CSR.

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.c | 2 +-
 target/riscv/cpu.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index d37861a430..e521ebe2e1 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -224,7 +224,7 @@ static void riscv_cpu_dump_state(CPUState *cs, FILE *f, int flags)
 #ifndef CONFIG_USER_ONLY
     qemu_fprintf(f, " %s " TARGET_FMT_lx "\n", "mhartid ", env->mhartid);
     qemu_fprintf(f, " %s " TARGET_FMT_lx "\n", "mstatus ", env->mstatus);
-    qemu_fprintf(f, " %s 0x%x\n", "mip     ", env->mip);
+    qemu_fprintf(f, " %s " TARGET_FMT_lx "\n", "mip     ", env->mip);
     qemu_fprintf(f, " %s " TARGET_FMT_lx "\n", "mie     ", env->mie);
     qemu_fprintf(f, " %s " TARGET_FMT_lx "\n", "mideleg ", env->mideleg);
     qemu_fprintf(f, " %s " TARGET_FMT_lx "\n", "medeleg ", env->medeleg);
diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index e59343e13c..f889427869 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -121,7 +121,7 @@ struct CPURISCVState {
     target_ulong mhartid;
     target_ulong mstatus;
 
-    uint32_t mip;
+    target_ulong mip;
     uint32_t miclaim;
 
     target_ulong mie;
-- 
2.24.0



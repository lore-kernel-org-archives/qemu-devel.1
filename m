Return-Path: <SRS0=fi8h=Z7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4249C43603
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2019 18:28:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B1EE72077B
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2019 18:28:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="ZVRo6eyT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B1EE72077B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44502 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ieNlU-0006Jp-FI
	for qemu-devel@archiver.kernel.org; Mon, 09 Dec 2019 13:28:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34639)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <prvs=23948302b=alistair.francis@wdc.com>)
 id 1ieNaW-000700-LY
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 13:16:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <prvs=23948302b=alistair.francis@wdc.com>)
 id 1ieNaV-0007IB-HT
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 13:16:52 -0500
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:7351)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <prvs=23948302b=alistair.francis@wdc.com>)
 id 1ieNaV-000793-9B; Mon, 09 Dec 2019 13:16:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1575915433; x=1607451433;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=qIu3Nk8mbEMxsAdhrzMMD2Op69hgflF0fJf4VyfzH2o=;
 b=ZVRo6eyTgFnZY4+1m7y2ilWqpsa9518FT6ewCzDAg5xfafAFzg3jPDsA
 vrFa18dADgIsCq0aEkC9MHs8aN0TllrhNKXF0CHoL8aCHLQKGVgBkS1bc
 U+esnO3W8aXMA6hswZo6LWsuQlcstu6FH9Bj0uSXYCDKYYQkrLMjsdvxO
 A3bgxrhz8KB0d0V3l13nY4ndN4FnNINHLfykKP7xUAYzWLftp4AUdZbEF
 uYjDK3FbZLIf29hw+QXi0Mtn029P3YJxD7GupPpRRQQmy5/frRKtS9au6
 gVcwMIPmXqGqq3NKv0z0G+ydlme3cqHp0H6QGT4Hsp3b12beJzQaxnBLk Q==;
IronPort-SDR: J/YTBMz/dqIi6tB68sHL7/fTBi4K6fnhbI8dPrRBs4vCAU36vPh2kVGIU3bjUa+k/J2kZ4ZDmG
 nABAnv3lTOz1zDmJd0aWMJnvvToRaosy0h8igdurnVTECto8lmsNARoU50eppDdEGjeHysGo57
 RuFjpw6YA3W7LAvMQeAojy22UIsCDAwFDiZcKkQdNwPuU3ltcUIyI9Ml3+nBjUIkKGQwiSMd4U
 vtv07xazGco4RGEkIhin6Yp7q7sEGUyn1zSnVhpom4VLI5KcKifA8DyDrwFzoIpyO9E12wrnfZ
 YJo=
X-IronPort-AV: E=Sophos;i="5.69,296,1571673600"; d="scan'208";a="226411954"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 10 Dec 2019 02:17:12 +0800
IronPort-SDR: 4FG+UUMVOyRn675vy8sqZNR19Dr/VaHduosk5I/Ro5GmMCxM/cQavA+6YhDxAUkzf+bATZSnFM
 lZfwS83gVFmAajS5pt4YgaaCWdMm/ibt0cKMO5E5LPdY8RtJvOY8nTm+R3skxFs/mSC7tHZB6Q
 rSHGEhTtmWABfD+vnI8DDLXseYQ350uFTBjfducbQ5/6tCfHadN9AC8jFDReC4bCenENX7rdRV
 oAiJJ+Kx+6HbZgWN0y3YON52MaOOxYEsqTDs6mOG6klduHE9rmBxJWOrvYqs5flVKYirE9rcDm
 R23kfzMh1O6v+ZvIInmdU8eX
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Dec 2019 10:11:07 -0800
IronPort-SDR: 6oOBhbJfEAkMG+gYg1BNnJni37J/vQPDjIbFOz2oh+d9Qc86DqvYIr2Y/DHPBQxcUbVMlwqu8V
 k2gRBF0lx+nU2OODOphIwK023bnVAWGnbHPeTmPrUMelk47xwYViqKLkX6mb7j5j6IjT6ebxN6
 uHwHof3DMoT6Y7ZGc3TmwtRU8xV56rpw5VhD2PGSKYXitDSA0Z0w16VzYAWNaUnv4FJRU7LxNX
 EoeQ9KVo00XkkCQkVikW+MbQ72zqVESTq2SQee8QAbDGPOd0GYrqT8BtkLcomq4zonS1ayOrBU
 xrE=
WDCIronportException: Internal
Received: from risc6-mainframe.sdcorp.global.sandisk.com (HELO
 risc6-mainframe.int.fusionio.com) ([10.196.158.235])
 by uls-op-cesaip02.wdc.com with ESMTP; 09 Dec 2019 10:16:50 -0800
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [PATCH v1 11/36] target/riscv: Dump Hypervisor registers if enabled
Date: Mon,  9 Dec 2019 10:11:09 -0800
Message-Id: <d5e479f72330dc802f0faa691eb651dbeb459611.1575914822.git.alistair.francis@wdc.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <cover.1575914822.git.alistair.francis@wdc.com>
References: <cover.1575914822.git.alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x [fuzzy]
X-Received-From: 68.232.143.124
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

Dump the Hypervisor registers and the current Hypervisor state.

While we are editing this code let's also dump stvec and scause.

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Atish Patra <atish.patra@wdc.com>
Reviewed-by: Palmer Dabbelt <palmer@sifive.com>
---
 target/riscv/cpu.c | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index e8ae07107e..a07c5689b3 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -228,17 +228,50 @@ static void riscv_cpu_dump_state(CPUState *cs, FILE *f, int flags)
     CPURISCVState *env = &cpu->env;
     int i;
 
+#if !defined(CONFIG_USER_ONLY)
+    if (riscv_has_ext(env, RVH)) {
+        qemu_fprintf(f, " %s %d\n", "V      =  ", riscv_cpu_virt_enabled(env));
+    }
+#endif
     qemu_fprintf(f, " %s " TARGET_FMT_lx "\n", "pc      ", env->pc);
 #ifndef CONFIG_USER_ONLY
     qemu_fprintf(f, " %s " TARGET_FMT_lx "\n", "mhartid ", env->mhartid);
     qemu_fprintf(f, " %s " TARGET_FMT_lx "\n", "mstatus ", env->mstatus);
+    if (riscv_has_ext(env, RVH)) {
+        qemu_fprintf(f, " %s " TARGET_FMT_lx "\n", "hstatus ", env->hstatus);
+        qemu_fprintf(f, " %s " TARGET_FMT_lx "\n", "vsstatus ", env->vsstatus);
+    }
     qemu_fprintf(f, " %s " TARGET_FMT_lx "\n", "mip     ", env->mip);
     qemu_fprintf(f, " %s " TARGET_FMT_lx "\n", "mie     ", env->mie);
     qemu_fprintf(f, " %s " TARGET_FMT_lx "\n", "mideleg ", env->mideleg);
+    if (riscv_has_ext(env, RVH)) {
+        qemu_fprintf(f, " %s " TARGET_FMT_lx "\n", "hideleg ", env->hideleg);
+    }
     qemu_fprintf(f, " %s " TARGET_FMT_lx "\n", "medeleg ", env->medeleg);
+    if (riscv_has_ext(env, RVH)) {
+        qemu_fprintf(f, " %s " TARGET_FMT_lx "\n", "hedeleg ", env->hedeleg);
+    }
     qemu_fprintf(f, " %s " TARGET_FMT_lx "\n", "mtvec   ", env->mtvec);
+    qemu_fprintf(f, " %s " TARGET_FMT_lx "\n", "stvec   ", env->stvec);
+    if (riscv_has_ext(env, RVH)) {
+        qemu_fprintf(f, " %s " TARGET_FMT_lx "\n", "vstvec  ", env->vstvec);
+    }
     qemu_fprintf(f, " %s " TARGET_FMT_lx "\n", "mepc    ", env->mepc);
+    qemu_fprintf(f, " %s " TARGET_FMT_lx "\n", "sepc    ", env->sepc);
+    if (riscv_has_ext(env, RVH)) {
+        qemu_fprintf(f, " %s " TARGET_FMT_lx "\n", "vsepc   ", env->vsepc);
+    }
     qemu_fprintf(f, " %s " TARGET_FMT_lx "\n", "mcause  ", env->mcause);
+    qemu_fprintf(f, " %s " TARGET_FMT_lx "\n", "scause  ", env->scause);
+    if (riscv_has_ext(env, RVH)) {
+        qemu_fprintf(f, " %s " TARGET_FMT_lx "\n", "vscause ", env->vscause);
+    }
+    qemu_fprintf(f, " %s " TARGET_FMT_lx "\n", "mtval ", env->mtval);
+    qemu_fprintf(f, " %s " TARGET_FMT_lx "\n", "stval ", env->sbadaddr);
+    if (riscv_has_ext(env, RVH)) {
+        qemu_fprintf(f, " %s " TARGET_FMT_lx "\n", "htval ", env->htval);
+        qemu_fprintf(f, " %s " TARGET_FMT_lx "\n", "mtval2 ", env->mtval2);
+    }
 #endif
 
     for (i = 0; i < 32; i++) {
-- 
2.24.0



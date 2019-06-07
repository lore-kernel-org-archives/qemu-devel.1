Return-Path: <SRS0=3yEa=UG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B22B4C2BCA1
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 22:07:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8086C212F5
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 22:07:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="mh6GunA3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8086C212F5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53632 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hZN12-0002wW-QE
	for qemu-devel@archiver.kernel.org; Fri, 07 Jun 2019 18:07:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47656)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <prvs=0547f94d1=alistair.francis@wdc.com>)
 id 1hZMru-000428-5t
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 17:57:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <prvs=0547f94d1=alistair.francis@wdc.com>)
 id 1hZMrs-0001gp-Gq
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 17:57:50 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:8430)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <prvs=0547f94d1=alistair.francis@wdc.com>)
 id 1hZMrs-0001Pu-3s; Fri, 07 Jun 2019 17:57:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1559944669; x=1591480669;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=iK1B0xFFuvDRSs41lCEh5dJV34eHPcrwoqWAsrCAnko=;
 b=mh6GunA3aKwe8dWMMqWBoIR/lk4hukjVPu6Nh/zdtJSKQdEaKvttxL/Y
 ZmGK3BnHNR1Ma5ryFPVwqWGFoqFK0xdKKurK/g3f30FM78vrDOI35a7FV
 MFwWqONQ5ucyrbPwW8UVls9IqwJ47Zebnj+tL/xUs9pMuqWL9K+H5l4zA
 /9Z+exU34fyWHXxJLqsVyK8wMYsFR5pFCJ9hRrXGhxRvvnufz/6a1tOJG
 Nf7I5Plj+Khx5c/nU5QPF07KuDmmzkKV/FM0dQQpQE4n3mUocdw7KJLs3
 noKAjxhowzD+dQS2UkN6fJOPTcCIV+/meieEi8Yh8gqmE48frGl7PouBc Q==;
X-IronPort-AV: E=Sophos;i="5.63,564,1557158400"; d="scan'208";a="115014085"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 08 Jun 2019 05:57:46 +0800
IronPort-SDR: kPNdoT9iweQCevpb7hFO4ZZGTVew0hJHKgrxjbQZk/N4ZvC6hhf4exRmI5JMIl8/AD+glJGITC
 YZHGDL2uO38Rr2eCztCjwZxbkaJ+L0h7QpggVVKW1vhCvphjXCb8zu3Fg9IseUVGFyNvfp54H+
 zyLCnDWbFy6dMylx4EGf+Bvyyu7lCvi6tc4wUJLhaJVmjFgfvPqz65SWWJC46HzqtBl7cbHFze
 9ZIxPxw+cuO2MadeijDoUzd7XFEsG50Ea1d0mEBSLFBAO5Na6GYAvdmYCUM/wT68T3l6rZCJ8p
 xiNIuI7vXp4HJ5s0xAVJuE1s
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep02.wdc.com with ESMTP; 07 Jun 2019 14:35:02 -0700
IronPort-SDR: HAUAhZB9MM2NDH+0APPzI3Ck74jHHFzcUvqZTp6V33UtSig6r+LOgMf0Cnmbjn8EmDVmN8khh6
 X7XFyJUbZNaLBHMV9WEmM5jzVCr8VOQuYTZSP78s+pkFVl6Y/htRxAI9/XDIyqA8vPKG9/nl93
 gA3goZE1IFLBaJqtZIa4Qa/1nvZhN9/x8j9vjKeHr9VdtrEjIItOhidGDK5KWd0gAHa9yLR8nb
 RvcmLoQvxhUqnJUmTYdXySTEkMOF6R7AVYlpdIeHCYXlYUlV+ZCrCvmosqs4aH7PVXQQJqC4UY
 kck=
Received: from risc6-mainframe.sdcorp.global.sandisk.com (HELO
 risc6-mainframe.int.fusionio.com) ([10.196.157.140])
 by uls-op-cesaip02.wdc.com with ESMTP; 07 Jun 2019 14:57:45 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Date: Fri,  7 Jun 2019 14:55:35 -0700
Message-Id: <f1434987f349ecf9438f8b4992ef9ed3d055fbf0.1559944445.git.alistair.francis@wdc.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1559944445.git.alistair.francis@wdc.com>
References: <cover.1559944445.git.alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 216.71.153.141
Subject: [Qemu-devel] [PATCH v1 06/27] target/riscv: Dump Hypervisor
 registers if enabled
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
 target/riscv/cpu.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 1d1378bb7f..6111f0f0bc 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -220,14 +220,41 @@ static void riscv_cpu_dump_state(CPUState *cs, FILE *f, int flags)
 #ifndef CONFIG_USER_ONLY
     qemu_fprintf(f, " %s " TARGET_FMT_lx "\n", "mhartid ", env->mhartid);
     qemu_fprintf(f, " %s " TARGET_FMT_lx "\n", "mstatus ", env->mstatus);
+    if (riscv_has_ext(env, RVH)) {
+        qemu_fprintf(f, " %s " TARGET_FMT_lx "\n", "hstatus ", env->hstatus);
+        qemu_fprintf(f, " %s " TARGET_FMT_lx "\n", "bstatus ", env->bsstatus);
+    }
     qemu_fprintf(f, " %s " TARGET_FMT_lx "\n", "mip     ",
                  (target_ulong)atomic_read(&env->mip));
+    if (riscv_has_ext(env, RVH)) {
+        qemu_fprintf(f, " %s " TARGET_FMT_lx "\n", "bsip    ",
+                     (target_ulong)atomic_read(&env->bsip));
+    }
     qemu_fprintf(f, " %s " TARGET_FMT_lx "\n", "mie     ", env->mie);
+    if (riscv_has_ext(env, RVH)) {
+        qemu_fprintf(f, " %s " TARGET_FMT_lx "\n", "bsie    ", env->bsie);
+    }
     qemu_fprintf(f, " %s " TARGET_FMT_lx "\n", "mideleg ", env->mideleg);
+    if (riscv_has_ext(env, RVH)) {
+        qemu_fprintf(f, " %s " TARGET_FMT_lx "\n", "hideleg ", env->hideleg);
+    }
     qemu_fprintf(f, " %s " TARGET_FMT_lx "\n", "medeleg ", env->medeleg);
+    if (riscv_has_ext(env, RVH)) {
+        qemu_fprintf(f, " %s " TARGET_FMT_lx "\n", "hedeleg ", env->hedeleg);
+    }
     qemu_fprintf(f, " %s " TARGET_FMT_lx "\n", "mtvec   ", env->mtvec);
+    if (riscv_has_ext(env, RVH)) {
+        qemu_fprintf(f, " %s " TARGET_FMT_lx "\n", "bstvec  ", env->bstvec);
+    }
     qemu_fprintf(f, " %s " TARGET_FMT_lx "\n", "mepc    ", env->mepc);
+    qemu_fprintf(f, " %s " TARGET_FMT_lx "\n", "sepc    ", env->sepc);
+    if (riscv_has_ext(env, RVH)) {
+        qemu_fprintf(f, " %s " TARGET_FMT_lx "\n", "bsepc   ", env->bsepc);
+    }
     qemu_fprintf(f, " %s " TARGET_FMT_lx "\n", "mcause  ", env->mcause);
+    if (riscv_has_ext(env, RVH)) {
+        qemu_fprintf(f, " %s " TARGET_FMT_lx "\n", "bscause ", env->bscause);
+    }
 #endif
 
     for (i = 0; i < 32; i++) {
-- 
2.21.0



Return-Path: <SRS0=l02z=YT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F074FCA9EA0
	for <qemu-devel@archiver.kernel.org>; Sat, 26 Oct 2019 00:41:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B0D81205ED
	for <qemu-devel@archiver.kernel.org>; Sat, 26 Oct 2019 00:41:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="lrTZEk7p"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B0D81205ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37548 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iOA9R-0002JC-Tw
	for qemu-devel@archiver.kernel.org; Fri, 25 Oct 2019 20:41:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49632)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <prvs=194c68654=alistair.francis@wdc.com>)
 id 1iO90s-00052p-3s
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 19:28:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <prvs=194c68654=alistair.francis@wdc.com>)
 id 1iO90q-0004Fu-G4
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 19:28:57 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:10433)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <prvs=194c68654=alistair.francis@wdc.com>)
 id 1iO90q-0004DA-5g; Fri, 25 Oct 2019 19:28:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1572046136; x=1603582136;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=tfjEdhd/vyLlGTnc8lObBWvW/ASfYoq9Ezu7PsP0s6o=;
 b=lrTZEk7pTkQoiFyDnxk6IjeGYNnG/DLrGfz4Xf9AIsi4i9g5BFsKJuiH
 5XOjs+vWEOkMwyFFspZ8z0ONgJy6zaP6yvOho4I7PYGbH5vt9m1p33qXa
 oB4B/43VphxEEVY4DX/Vi56G7+anHbv+r0sQCajCeBGnO5H4618EgkEXV
 Og5HzteWNth9M+UV1/3NYXGW1TgmDqDarUrDDNFwJz+hpm3xlK0UpOEVc
 bw4cKNl6UzUzSdeyYPJ9quG7eXEPfFZh/VpAa2TLfefY2JwnF0EfA0/Ey
 G4u7Fgsag2PbjkzXpXWFxJkQHl1ZEA6kPXIkY2osPBGAtGsF5tTIdmycZ g==;
IronPort-SDR: XiP25r5Do/WGMAmWNxU+6ONMzGmyYanfDGNFuQCB9VDTnR86MjkcId44d5gtNZkQ8O0KFkn9nv
 qHVoZiX8UriixLbsFTmYRy4TnqWhGi6hWYVVsLV8LpbxyECeo0C0uioAg2j+j2IRopqyQVKiZe
 2XsbangeWnpfNnhcl+x/h3119Tje4uPd2yqHNprniOzzQO94BXgsgaQFXrnu6Xn82sUlL5WL9b
 AuYNBb9tgbRWlkUiCG3dSyGpYz2qd+9BnRtyK2xqRhP84yVVK9VWmYNjiqnuPnSHi2aZxlOFNY
 6AM=
X-IronPort-AV: E=Sophos;i="5.68,230,1569254400"; d="scan'208";a="228520398"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 26 Oct 2019 07:28:30 +0800
IronPort-SDR: Lf46Pp6kPPx84iYieyzMY9KSDnpXu0nhDaJn4wj9lp7b0kyM9uzjb9F/rUTqQrwGcavP6PsWTm
 hGeEzw8EblOGtir7/PI1hkbzIHWw0c6ew/jVZiIw8YjSBBwie4vObcsqphnymaizlKNm7JSYtg
 vSVrUBkfvvP7Qk94liJs/3cu5Q+sV8BhagYp4qzPYinbKma7y0TDFCqpvLwaPR1dvh6ivs3u6x
 mxNZ2HD1V7bSYlVX26DopXx/lKrlxw+HunegiYWJjZAwXl64HT+mC6GWwgrmf4KgauLzEbFHhP
 yVCpVm9uLzLzF7Cjk2Uvxh5N
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Oct 2019 16:23:56 -0700
IronPort-SDR: pipr8bY0KpY5Ar6WCN+I+uchLW+CmiAKACbsOMEHzdbFlb9r6A5N5VeNd/oV4ZvZtFokKC92fU
 G0LJJRz3w+FFuvV16GVeasLUr8nwCC+n1DoRA/+a+ESDP8hHQe70tyMzzgx2d6KHvCsvekZN4Q
 w2fFWryv0yXtAmIw2KHq9nHOjwr8kK4jpsafz3YLjS+nR4pUPnNW7s0VZI/bXy9g7gYDOu9+Wa
 0bHLtVPXa2QJTyZfKLw8loxkFhqzUlxRvCZ2XE3GOvaLXySYzFV9ovOg2kohq/4hR71othu2pH
 4Ao=
WDCIronportException: Internal
Received: from risc6-mainframe.sdcorp.global.sandisk.com (HELO
 risc6-mainframe.int.fusionio.com) ([10.196.157.58])
 by uls-op-cesaip01.wdc.com with ESMTP; 25 Oct 2019 16:28:31 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [PATCH v2 08/27] target/riscv: Dump Hypervisor registers if enabled
Date: Fri, 25 Oct 2019 16:23:35 -0700
Message-Id: <f401f134526dd811801e808f6d0bfedf2d42d5eb.1572045716.git.alistair.francis@wdc.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <cover.1572045716.git.alistair.francis@wdc.com>
References: <cover.1572045716.git.alistair.francis@wdc.com>
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

Dump the Hypervisor registers and the current Hypervisor state.

While we are editing this code let's also dump stvec and scause.

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Atish Patra <atish.patra@wdc.com>
Reviewed-by: Palmer Dabbelt <palmer@sifive.com>
---
 target/riscv/cpu.c | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index e521ebe2e1..e66fd300fd 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -220,17 +220,51 @@ static void riscv_cpu_dump_state(CPUState *cs, FILE *f, int flags)
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
+        qemu_fprintf(f, " %s " TARGET_FMT_lx "\n", "bstatus ", env->vsstatus);
+    }
     qemu_fprintf(f, " %s " TARGET_FMT_lx "\n", "mip     ", env->mip);
+    if (riscv_has_ext(env, RVH)) {
+        qemu_fprintf(f, " %s " TARGET_FMT_lx "\n", "vsip    ",
+                     (target_ulong)atomic_read(&env->vsip));
+    }
     qemu_fprintf(f, " %s " TARGET_FMT_lx "\n", "mie     ", env->mie);
+    if (riscv_has_ext(env, RVH)) {
+        qemu_fprintf(f, " %s " TARGET_FMT_lx "\n", "vsie    ", env->vsie);
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
 #endif
 
     for (i = 0; i < 32; i++) {
-- 
2.23.0



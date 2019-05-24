Return-Path: <SRS0=E2zY=TZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11D8BC282E1
	for <qemu-devel@archiver.kernel.org>; Sat, 25 May 2019 00:08:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CA70B20862
	for <qemu-devel@archiver.kernel.org>; Sat, 25 May 2019 00:08:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="aT7lVOOF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA70B20862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:33532 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hUKET-00062d-11
	for qemu-devel@archiver.kernel.org; Fri, 24 May 2019 20:08:17 -0400
Received: from eggs.gnu.org ([209.51.188.92]:60227)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=040baf4f1=alistair.francis@wdc.com>)
	id 1hUK45-0005Im-4O
	for qemu-devel@nongnu.org; Fri, 24 May 2019 19:57:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=040baf4f1=alistair.francis@wdc.com>)
	id 1hUJui-0004JI-Ue
	for qemu-devel@nongnu.org; Fri, 24 May 2019 19:47:53 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:21008)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <prvs=040baf4f1=alistair.francis@wdc.com>)
	id 1hUJui-0004I3-Jz; Fri, 24 May 2019 19:47:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
	d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
	t=1558741673; x=1590277673;
	h=from:to:cc:subject:date:message-id:in-reply-to:
	references:mime-version:content-transfer-encoding;
	bh=MovSZKAQqGsxV10nTM27s96VEzw0BeItClqWarQW+A4=;
	b=aT7lVOOFwkWPjgkc0wezxs6uLfuAV18kcmJlX8yQt1sS/Ul3ar3a5D9I
	naD0uD47QG1pipTF8vaDk0BQ/fiiPoU08DQWnVID1OghTO7P/73hecNzx
	x9quaXdonRiITy47N+Z2/XoX3176EbjmxlmKmtMHiCU6QQjzSYvE0jtM3
	vlbIhdCgLKWxuuVidrTiP48y3NN6QFddNbIBYKUpGBoj2t66UUriHVroW
	bs02R50ew2B/jj+2BBVc4JVDzblulpsELknz1jxSnJocIB+U1/sXu9euV
	HUu7SsJ661RJPM2aeqCTPEgyHNY3Dsv/NwbeP2BGO8b/eHWHOX0p54ojz A==;
X-IronPort-AV: E=Sophos;i="5.60,508,1549900800"; d="scan'208";a="114006655"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com)
	([199.255.45.14])
	by ob1.hgst.iphmx.com with ESMTP; 25 May 2019 07:47:51 +0800
IronPort-SDR: pe2zoCSscteZLGgs/USY4gTe+2/44gRKT/ZVsX7SibQppofx11lu1SmsCwvC34g0PuMCos1Lv/
	Lbrz1PxdXQWLs0zxXUNeTm6AL+VdeCCHiw8TIQJZxIXUmGXzaY9l4b5BgrfTEsAbDHPC0W3GU7
	qtOCP8AHXeNgMr6smaPlkK+QKdfKdv0E2e+Gm0RDloigs7FY52ub6pWsnl8hDhfk7p2eaZKcny
	itciyhT2beskVI7LhAVnk+W+MLjO1c3BUyI2jJYRfSmAaStXaugvM55ygf8kqYsJ/y39yxOvva
	cd7dCMbShb91nWq49pJHYMRS
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
	by uls-op-cesaep01.wdc.com with ESMTP; 24 May 2019 16:23:09 -0700
IronPort-SDR: DCJ7gsGlmvO3/I7y2Ks9mQ0BG01lMa2a+cFNUemklqyyAGDf7Qo5u9NPB9CPOxky2GvqXHfAqu
	DdMJOaqNthKjT7LKM/q+6C5/FrMWRVXOYK+oAQfiMAvtzAixdITNmrgDv5TLpgHm4toGGxslEF
	0ypAW6JIqVIb0L12QctNKxo0ACkUIpmZA1daBq4OpyTSv8MXBS/eGBue7JTLLd/16mBpa22b02
	dApwlOwbHSFvM8lHHxTsju2WGmgxggCFuSJpEkXhsVSBKr/GIRWlyRXTOfEKgD8Dv8ltKcEMFv
	Rwo=
Received: from risc6-mainframe.sdcorp.global.sandisk.com (HELO
	risc6-mainframe.int.fusionio.com) ([10.196.157.140])
	by uls-op-cesaip02.wdc.com with ESMTP; 24 May 2019 16:47:50 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Date: Fri, 24 May 2019 16:45:56 -0700
Message-Id: <b139dcfad9d8a22db6223e5a1db72862fa401796.1558741334.git.alistair.francis@wdc.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1558741334.git.alistair.francis@wdc.com>
References: <cover.1558741334.git.alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 216.71.153.141
Subject: [Qemu-devel] [RFC v1 08/23] target/riscv: Add support for
 background interrupt setting
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
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
 target/riscv/cpu_helper.c | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index 0fdc81f71f..1f466effcf 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -38,12 +38,27 @@ static int riscv_cpu_local_irq_pending(CPURISCVState *env)
 {
     target_ulong mstatus_mie = get_field(env->mstatus, MSTATUS_MIE);
     target_ulong mstatus_sie = get_field(env->mstatus, MSTATUS_SIE);
+    target_ulong bsstatus_sie = get_field(env->bsstatus, MSTATUS_SIE);
+
     target_ulong pending = atomic_read(&env->mip) & env->mie;
-    target_ulong mie = env->priv < PRV_M || (env->priv == PRV_M && mstatus_mie);
-    target_ulong sie = env->priv < PRV_S || (env->priv == PRV_S && mstatus_sie);
+    target_ulong hspending = atomic_read(&env->bsip) & env->bsie;
+
+    target_ulong mie  = env->priv < PRV_M || (env->priv == PRV_M && mstatus_mie);
+    target_ulong sie  = env->priv < PRV_S || (env->priv == PRV_S && mstatus_sie);
+    target_ulong bsie = env->priv < PRV_S || (env->priv == PRV_S && bsstatus_sie);
+
     target_ulong irqs = (pending & ~env->mideleg & -mie) |
                         (pending &  env->mideleg & -sie);
 
+    if (riscv_cpu_virt_enabled(env)) {
+        target_ulong pending_hs_irq = hspending & -bsie;
+
+        if (pending_hs_irq) {
+            riscv_cpu_set_force_hs_excep(env, FORCE_HS_EXCEP);
+            return ctz64(pending_hs_irq);
+        }
+    }
+
     if (irqs) {
         return ctz64(irqs); /* since non-zero */
     } else {
-- 
2.21.0



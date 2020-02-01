Return-Path: <SRS0=CCzH=3V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D8B6C33CB7
	for <qemu-devel@archiver.kernel.org>; Sat,  1 Feb 2020 01:09:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0D87C2063A
	for <qemu-devel@archiver.kernel.org>; Sat,  1 Feb 2020 01:09:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="HZWLYbPS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D87C2063A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33970 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ixhHr-0002Fr-5N
	for qemu-devel@archiver.kernel.org; Fri, 31 Jan 2020 20:09:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56443)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <prvs=2939926b3=alistair.francis@wdc.com>)
 id 1ixhGk-0000X5-UP
 for qemu-devel@nongnu.org; Fri, 31 Jan 2020 20:08:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <prvs=2939926b3=alistair.francis@wdc.com>)
 id 1ixhGj-00066T-M4
 for qemu-devel@nongnu.org; Fri, 31 Jan 2020 20:08:18 -0500
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:17114)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <prvs=2939926b3=alistair.francis@wdc.com>)
 id 1ixhGj-00065s-E6; Fri, 31 Jan 2020 20:08:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1580519297; x=1612055297;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=bMmHPvXTwmFm3v6KSxU5UHxjO/nB6/a5heNzTy1ycD8=;
 b=HZWLYbPSB8VXi5H1JHgFEX94W0EQNC2g+2CDwo1QSdViROUZedec+s41
 USCtFRsZNnVDVJRsq28ZMHJ7y4vs+EjAtN+n4wvrhBX4Fk5hS42ClNeiT
 z8KShcsyaMYNhQgQmBCoUCS4TRzMVqPb8KEYMwafIY2VJ3lkLdfROZseB
 BjPz53lhSdn//OX1okxU9JaD650yr7aRX16ffKVthWWYcq/qLWyfrZDl+
 4osKjZHko+yec+E2lvkDaZ3qbssrp/VKguIKYrpkwwxiSWiEh7/JX6at8
 q6QmZCwNkJ+pxJwkC9ei0rTqIxezaSWq4wm3u8gcGdZQ1d5L9puJi2dDG w==;
IronPort-SDR: zmOYbKfOkGSq5wB0jsA8CyuTSAusU0GY8yQkWQh8JGsPMaafoumctnILxaBY5BSlJYWoAiMZYq
 +gfSC6MyptR+x8s4Axa7Ru8d/AHKh3DGQ/1In4Uce08DdKV944vsnrMWCtvgE5R+tsQXL+BhS3
 L5HC5OZzcz+fM2Lif1PUYGrPXxgvOl8X93bx5Y54czkqWpqmYQ35gZaX9hTA8rdu2G6fqKOsko
 e/mMeWSAiBKMb3FcgkX2ztQZOnBhcy06YTCni7/qPeQoFV5DnmonVpVgW74tUmRXCZViPYxmcS
 KyM=
X-IronPort-AV: E=Sophos;i="5.70,388,1574092800"; d="scan'208";a="128872396"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 01 Feb 2020 09:08:15 +0800
IronPort-SDR: LJxGCQK6coOrKVoF8KwUIxXKtqRBxO3CeGQDEx/0KE01tAGeAuHx59ddtST2U1KO5iF1rg06c+
 SqgkstALUV653wrGOvE05JBzrbZJlzmKDDuZPdvQ1392xeFcfU/2QGSBeerW4fLdkw5q7n6UkN
 yTpPSGbURJUNU6lPSPw47RKSMcElkzQjBHwvqGnwR1BazoaFbei21uiMC26U5cj2Y46DeFsxIR
 8ifD0lwgWopvk3mSh0BJbyTfDDVOP4pTE1/ZA63Ohn5raT2WXgETJjfKoOPenhDhtX4rFH9a+O
 mH8Bbb6MkZG3w09yPXce6pJK
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Jan 2020 17:01:23 -0800
IronPort-SDR: xeevb+TbJDddkr4ig+lDYwU8e0OdvHxppF1aXrKM5nxXyRB4ko+yn3/pLHvtD8gxJ3D4HzqZne
 aNO9YMe8lTnpOso+qru8ennybY/0Mhzoz1dhwumaIHvUAZuqcRWHh2Uzw7ZxeojjvuhLe/MqU9
 Oufon/xYqDE4wzl9tXVLXWQd1jfURZEKGSmDdxsi+RHq8CXfNHwPo185+OOl1yVsFWm3HVdb5S
 oEjMjM29CSstrGExQ+dr5EM4uDfdDzw/0iS5a3KqWwfaJLsUOxLZlyrmlxiFMwcg3YaVZL805S
 4pI=
WDCIronportException: Internal
Received: from risc6-mainframe.sdcorp.global.sandisk.com (HELO
 risc6-mainframe.int.fusionio.com) ([10.196.158.235])
 by uls-op-cesaip02.wdc.com with ESMTP; 31 Jan 2020 17:08:15 -0800
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [PATCH v2 01/35] target/riscv: Convert MIP CSR to target_ulong
Date: Fri, 31 Jan 2020 17:01:38 -0800
Message-Id: <e2af5c1cfdeeed7c91a7a426c5290aa09cbac79a.1580518859.git.alistair.francis@wdc.com>
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

The MIP CSR is a xlen CSR, it was only 32-bits to allow atomic access.
Now that we don't use atomics for MIP we can change this back to a xlen
CSR.

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Palmer Dabbelt <palmerdabbelt@google.com>
---
 target/riscv/cpu.c | 2 +-
 target/riscv/cpu.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 8c86ebc109..efbd676edb 100644
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
index de0a8d893a..95de9e58a2 100644
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
2.25.0



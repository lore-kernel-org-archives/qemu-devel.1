Return-Path: <SRS0=M8fn=UR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BDE5C31E5B
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2019 01:41:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 296D92082C
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2019 01:41:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="pd1UHrMv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 296D92082C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52976 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hd37M-0004iY-Ed
	for qemu-devel@archiver.kernel.org; Mon, 17 Jun 2019 21:41:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41073)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <prvs=0651fb9a1=alistair.francis@wdc.com>)
 id 1hd30Z-0006zC-Pt
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 21:34:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <prvs=0651fb9a1=alistair.francis@wdc.com>)
 id 1hd30W-0000Ri-2A
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 21:33:58 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:24430)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <prvs=0651fb9a1=alistair.francis@wdc.com>)
 id 1hd30P-0000A1-B2; Mon, 17 Jun 2019 21:33:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1560821630; x=1592357630;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=uH8d/1+DYmxt/Xfe8gKKkT1GvkSK1xuKXxkSixU4Pc0=;
 b=pd1UHrMvpKCOIzmVrfA9KMzYBSNEkVMHt0xraEKC50MMN0RzFEYRNiJQ
 G13fhd/AduBmBeugmEs7oiKU/GejMbukju/hc6TT38HTI4bau7z5gip9s
 klNvq2MCPlyfr/F0L9Z/Z3L6s6BWWpwTonW3OdjZfFQQ+H2WRAoeRhYQx
 erUYKMlCjSdvTInHuVDIiyXJ8U4z2HuS5gY1Xs6S0wB2SZV5zkdP9N3Ld
 pA7v+7NAj2GhjJF91sdZXLB818pvE1i3jZLyG9rWWHgT7/DMRFqHjCmNd
 pAHdNFF32OtDYeRYniIMWj2whqXk+Y4wKMSVniLp4qyLtyVpUUE+o0Bje g==;
X-IronPort-AV: E=Sophos;i="5.63,386,1557158400"; d="scan'208";a="112055111"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 18 Jun 2019 09:33:46 +0800
IronPort-SDR: mH6/vsWpBn+SZNGPzspR0dN5sgjpMWvW2sDL7iT5jD3h4qtw0+mglclnlka63oncxYDcDO0AAz
 xb0K+c+4/wZOMEZIGSx80fgYQLUiAdgi+oW0OxTPgggiA4AVbIjL+vpnLyOxphg4waXL4WGQMT
 HAIDfKherUyiVKFq6h8t8OHT/5DfahFHUyf7uNtjDc7K7KS6nqnMJyCFk5vAJDw6IFWyzpmB9D
 eKz1pXoXBv4iyCnL9sFWN8Hypta6ZduGQRUXtXB19eE8H/Ze6o1sLm6ukmIfHKryhqsdfiBEne
 Azxwde8w9zZgsap6sSkcNrf4
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep02.wdc.com with ESMTP; 17 Jun 2019 18:33:15 -0700
IronPort-SDR: lNFw6ircjrCK71GcwOT2l+NmTHmvbYfifZJ4pmli0yXcGnYb9INWjrbEYNG5hWu32wMpi+Xx1J
 UaNWvvWQiRWcgczt3t3yT5idls7zSuG4gy9reLHxkZ1YNtEBK/s4w2+lhI9XKGbwuEiwlLywlJ
 33pC2dZG6LV+1r4oLb2/NICe4kVJc0+KPzg45wPUsfHZk2PIqbigx2hT2o9C28PaDznY4wib8M
 lUKv/EolHNC0k6QGIl3r1H/pyOAdYUnSOmo3YJZOOpUZzcVPFw8G4TKGWOYpt/RYSJy7TMZtvl
 37k=
Received: from risc6-mainframe.sdcorp.global.sandisk.com (HELO
 risc6-mainframe.int.fusionio.com) ([10.196.157.140])
 by uls-op-cesaip02.wdc.com with ESMTP; 17 Jun 2019 18:33:46 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Date: Mon, 17 Jun 2019 18:31:25 -0700
Message-Id: <b1a3188a4d5538d4d0ed0a77114926a2fdae1258.1560821342.git.alistair.francis@wdc.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <cover.1560821342.git.alistair.francis@wdc.com>
References: <cover.1560821342.git.alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 216.71.153.144
Subject: [Qemu-devel] [PATCH v1 9/9] target/riscv: Add Zifencei and Zicsr as
 command line options
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

For completeness let's add Zifencei and Zicsr as command line options,
even though they can't be disabled at the moment.

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.c | 9 +++++++++
 target/riscv/cpu.h | 2 ++
 2 files changed, 11 insertions(+)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 5af1c9b38c..53cf8607f7 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -409,6 +409,13 @@ static void riscv_cpu_realize(DeviceState *dev, Error **errp)
         set_misa(env, RVXLEN | target_misa);
     }
 
+    if (!cpu->cfg.ext_ifencei) {
+        warn_report("QEMU does not support disabling Zifencei");
+    }
+    if (!cpu->cfg.ext_icsr) {
+        warn_report("QEMU does not support disabling Zicsr");
+    }
+
     riscv_cpu_register_gdb_regs_for_features(cs);
 
     qemu_init_vcpu(cs);
@@ -441,6 +448,8 @@ static Property riscv_cpu_properties[] = {
     DEFINE_PROP_BOOL("s", RISCVCPU, cfg.ext_s, true),
     DEFINE_PROP_BOOL("u", RISCVCPU, cfg.ext_u, true),
     DEFINE_PROP_BOOL("Counters", RISCVCPU, cfg.ext_counters, true),
+    DEFINE_PROP_BOOL("Zifencei", RISCVCPU, cfg.ext_ifencei, true),
+    DEFINE_PROP_BOOL("Zicsr", RISCVCPU, cfg.ext_icsr, true),
     DEFINE_PROP_STRING("priv_spec", RISCVCPU, cfg.priv_spec),
     DEFINE_PROP_BOOL("mmu", RISCVCPU, cfg.mmu, true),
     DEFINE_PROP_BOOL("pmp", RISCVCPU, cfg.pmp, true),
diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 786f620564..b4c212dfcf 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -222,6 +222,8 @@ typedef struct RISCVCPU {
         bool ext_s;
         bool ext_u;
         bool ext_counters;
+        bool ext_ifencei;
+        bool ext_icsr;
 
         char *priv_spec;
         char *user_spec;
-- 
2.22.0



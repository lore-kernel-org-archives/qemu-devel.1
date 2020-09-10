Return-Path: <SRS0=7f1Q=CT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68717C433E2
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 18:27:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DF9E52087C
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 18:27:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="TokG6u4i"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF9E52087C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45790 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kGRHr-0005Vv-RT
	for qemu-devel@archiver.kernel.org; Thu, 10 Sep 2020 14:27:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57074)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=515d47f05=alistair.francis@wdc.com>)
 id 1kGRBM-0003kC-Dk
 for qemu-devel@nongnu.org; Thu, 10 Sep 2020 14:20:28 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:28245)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=515d47f05=alistair.francis@wdc.com>)
 id 1kGRBK-0002iJ-9W
 for qemu-devel@nongnu.org; Thu, 10 Sep 2020 14:20:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1599762026; x=1631298026;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=yEenwpRSDjt+DZK8AH3l3bbgGA7TljyyQ73PcK2esB8=;
 b=TokG6u4iFk0g1SlQds/vz4+c27JSw1aPr8ylC3Xg/ORe3uAZ9xl0EeMI
 u+bO8sZbwSf7QB6cN6gvq6qUtZ0zyvdVcL9TsE6W34qGaJQzDenZjnx1G
 gzZMeKrulpqygZ8U31M3R0UI4/dgdmEY468Z0qy2m/OE5c/HIg0UqoBXV
 fsiNA/JF83mcAFB6iARql1nZFCem78Bpg2QwfD4XyB8B7derwmRDwkTEF
 ZI/W3iswEKPzSzZrmZ17CrsWoadvz5Wbyy+3c/EWCavhe1b6wyfOsKxWF
 XzaB1OdoPsC6BlvX+VnB6/iYra2Dyj4y6RM1fLHDCc/7CbEfFHiKxevvV w==;
IronPort-SDR: rKCiMWo2+i0iFv4r7YMEx8lGguDsMQKpgj8X5URSMY5yg5TG8c33UvfoRD8MLhIJNlEKQ4G9Va
 a3jVK4OLoYK8+FpNHPQZuRyZR9j9lscB26SGFMEnXX4Zl6AJy26BZgjquucrwR/qvRZ0CEUdx+
 1CRBq5vwVhZQY3G6pCfchY1ofYcnK6Z1Tax5Xl17Z/hf6RGnl8BILeI+vCaddtSKj1+IFc87Mq
 OmONGK55GiAheJk7Pe8F57QChDwUUZBMbIOe9YYLXEm1Ni51SQTWP/Os+/TavErGBCDBZzFbEk
 /mg=
X-IronPort-AV: E=Sophos;i="5.76,413,1592841600"; d="scan'208";a="146979215"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 11 Sep 2020 02:20:15 +0800
IronPort-SDR: rZdpdayAzKyNDv/BYlbN+B7kouMN0S1efkLHFNbgbBrYzXFXt69XN89aRvO69hda19ymvZR2cZ
 8rxNCCEHJqaQ==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Sep 2020 11:07:32 -0700
IronPort-SDR: ZXwa8l2eXrIWAEORCX6BXVtN7nuxjAhkJFs+G996iy3JGvKrVnOTuv2Am/wmKWQnB3E0qBloKz
 x/84eJreeivQ==
WDCIronportException: Internal
Received: from fwvkpc2.ad.shared (HELO risc6-mainframe.hgst.com)
 ([10.86.59.152])
 by uls-op-cesaip01.wdc.com with ESMTP; 10 Sep 2020 11:20:15 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: peter.maydell@linaro.org,
	qemu-devel@nongnu.org
Subject: [PULL 05/30] target/riscv: cpu: Set reset vector based on the
 configured property value
Date: Thu, 10 Sep 2020 11:09:13 -0700
Message-Id: <20200910180938.584205-6-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200910180938.584205-1-alistair.francis@wdc.com>
References: <20200910180938.584205-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.71.154.42;
 envelope-from=prvs=515d47f05=alistair.francis@wdc.com;
 helo=esa4.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/10 14:20:04
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: alistair23@gmail.com, Bin Meng <bin.meng@windriver.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Bin Meng <bin.meng@windriver.com>

Now that we have the newly introduced 'resetvec' property in the
RISC-V CPU and HART, instead of hard-coding the reset vector addr
in the CPU's instance_init(), move that to riscv_cpu_realize()
based on the configured property value from the RISC-V machines.

Signed-off-by: Bin Meng <bin.meng@windriver.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Message-Id: <1598924352-89526-4-git-send-email-bmeng.cn@gmail.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 hw/riscv/opentitan.c | 1 +
 hw/riscv/sifive_e.c  | 1 +
 hw/riscv/sifive_u.c  | 2 ++
 target/riscv/cpu.c   | 7 ++-----
 4 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/hw/riscv/opentitan.c b/hw/riscv/opentitan.c
index 23ba3b4bfc..0531bd879b 100644
--- a/hw/riscv/opentitan.c
+++ b/hw/riscv/opentitan.c
@@ -111,6 +111,7 @@ static void lowrisc_ibex_soc_realize(DeviceState *dev_soc, Error **errp)
                             &error_abort);
     object_property_set_int(OBJECT(&s->cpus), "num-harts", ms->smp.cpus,
                             &error_abort);
+    object_property_set_int(OBJECT(&s->cpus), "resetvec", 0x8090, &error_abort);
     sysbus_realize(SYS_BUS_DEVICE(&s->cpus), &error_abort);
 
     /* Boot ROM */
diff --git a/hw/riscv/sifive_e.c b/hw/riscv/sifive_e.c
index ca55cc438a..cd7560d8ec 100644
--- a/hw/riscv/sifive_e.c
+++ b/hw/riscv/sifive_e.c
@@ -177,6 +177,7 @@ static void sifive_e_soc_init(Object *obj)
     object_initialize_child(obj, "cpus", &s->cpus, TYPE_RISCV_HART_ARRAY);
     object_property_set_int(OBJECT(&s->cpus), "num-harts", ms->smp.cpus,
                             &error_abort);
+    object_property_set_int(OBJECT(&s->cpus), "resetvec", 0x1004, &error_abort);
     object_initialize_child(obj, "riscv.sifive.e.gpio0", &s->gpio,
                             TYPE_SIFIVE_GPIO);
 }
diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
index a48046c6a0..404d5e6918 100644
--- a/hw/riscv/sifive_u.c
+++ b/hw/riscv/sifive_u.c
@@ -611,6 +611,7 @@ static void sifive_u_soc_instance_init(Object *obj)
     qdev_prop_set_uint32(DEVICE(&s->e_cpus), "num-harts", 1);
     qdev_prop_set_uint32(DEVICE(&s->e_cpus), "hartid-base", 0);
     qdev_prop_set_string(DEVICE(&s->e_cpus), "cpu-type", SIFIVE_E_CPU);
+    qdev_prop_set_uint64(DEVICE(&s->e_cpus), "resetvec", 0x1004);
 
     object_initialize_child(obj, "u-cluster", &s->u_cluster, TYPE_CPU_CLUSTER);
     qdev_prop_set_uint32(DEVICE(&s->u_cluster), "cluster-id", 1);
@@ -620,6 +621,7 @@ static void sifive_u_soc_instance_init(Object *obj)
     qdev_prop_set_uint32(DEVICE(&s->u_cpus), "num-harts", ms->smp.cpus - 1);
     qdev_prop_set_uint32(DEVICE(&s->u_cpus), "hartid-base", 1);
     qdev_prop_set_string(DEVICE(&s->u_cpus), "cpu-type", SIFIVE_U_CPU);
+    qdev_prop_set_uint64(DEVICE(&s->u_cpus), "resetvec", 0x1004);
 
     object_initialize_child(obj, "prci", &s->prci, TYPE_SIFIVE_U_PRCI);
     object_initialize_child(obj, "otp", &s->otp, TYPE_SIFIVE_U_OTP);
diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index f6aeecac15..57c006df5d 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -139,7 +139,6 @@ static void riscv_any_cpu_init(Object *obj)
     CPURISCVState *env = &RISCV_CPU(obj)->env;
     set_misa(env, RVXLEN | RVI | RVM | RVA | RVF | RVD | RVC | RVU);
     set_priv_version(env, PRIV_VERSION_1_11_0);
-    set_resetvec(env, DEFAULT_RSTVEC);
 }
 
 static void riscv_base_cpu_init(Object *obj)
@@ -147,7 +146,6 @@ static void riscv_base_cpu_init(Object *obj)
     CPURISCVState *env = &RISCV_CPU(obj)->env;
     /* We set this in the realise function */
     set_misa(env, 0);
-    set_resetvec(env, DEFAULT_RSTVEC);
 }
 
 static void rvxx_sifive_u_cpu_init(Object *obj)
@@ -155,7 +153,6 @@ static void rvxx_sifive_u_cpu_init(Object *obj)
     CPURISCVState *env = &RISCV_CPU(obj)->env;
     set_misa(env, RVXLEN | RVI | RVM | RVA | RVF | RVD | RVC | RVS | RVU);
     set_priv_version(env, PRIV_VERSION_1_10_0);
-    set_resetvec(env, 0x1004);
 }
 
 static void rvxx_sifive_e_cpu_init(Object *obj)
@@ -163,7 +160,6 @@ static void rvxx_sifive_e_cpu_init(Object *obj)
     CPURISCVState *env = &RISCV_CPU(obj)->env;
     set_misa(env, RVXLEN | RVI | RVM | RVA | RVC | RVU);
     set_priv_version(env, PRIV_VERSION_1_10_0);
-    set_resetvec(env, 0x1004);
     qdev_prop_set_bit(DEVICE(obj), "mmu", false);
 }
 
@@ -174,7 +170,6 @@ static void rv32_ibex_cpu_init(Object *obj)
     CPURISCVState *env = &RISCV_CPU(obj)->env;
     set_misa(env, RV32 | RVI | RVM | RVC | RVU);
     set_priv_version(env, PRIV_VERSION_1_10_0);
-    set_resetvec(env, 0x8090);
     qdev_prop_set_bit(DEVICE(obj), "mmu", false);
 }
 
@@ -384,6 +379,8 @@ static void riscv_cpu_realize(DeviceState *dev, Error **errp)
         set_feature(env, RISCV_FEATURE_PMP);
     }
 
+    set_resetvec(env, cpu->cfg.resetvec);
+
     /* If misa isn't set (rv32 and rv64 machines) set it here */
     if (!env->misa) {
         /* Do some ISA extension error checking */
-- 
2.28.0



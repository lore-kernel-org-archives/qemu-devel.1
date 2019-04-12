Return-Path: <SRS0=wsBa=SO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED574C10F0E
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Apr 2019 19:05:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9ED8520818
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Apr 2019 19:05:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TS8M61qU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9ED8520818
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:41489 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hF1UN-0005lK-Te
	for qemu-devel@archiver.kernel.org; Fri, 12 Apr 2019 15:05:27 -0400
Received: from eggs.gnu.org ([209.51.188.92]:51375)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <fintelia@gmail.com>) id 1hF1T1-0004s8-W8
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 15:04:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <fintelia@gmail.com>) id 1hF1T0-0004yT-5C
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 15:04:03 -0400
Received: from mail-lf1-x143.google.com ([2a00:1450:4864:20::143]:34098)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <fintelia@gmail.com>)
	id 1hF1Sz-0004xV-Jr; Fri, 12 Apr 2019 15:04:02 -0400
Received: by mail-lf1-x143.google.com with SMTP id h5so5357966lfm.1;
	Fri, 12 Apr 2019 12:04:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:from:date:message-id:subject:to:cc;
	bh=nQVBDQdIf7uLgvydkDvWOdcylKmcIXFTHUtAzZQVE9w=;
	b=TS8M61qU/G72Ux4pS9vLex4buvOMWupJGjEt2JKiv76ZljUAQRXpi2Wg8qEn9Qadmc
	ow84TH+4JVDGQGxaNPhM8yGUmNKx50byKrKS0YplnUFsGeF2z0vzeSSwU3rklBXQCIne
	U0w55TJ02sje2dDIxNNuYFru3luTiYRJk9f+rHJG+oPVs+AkqxfMCYG/jrNHk9C9MaNT
	W/62KmyDPdj+lpONR7Ilp6MT7g0x8C73WdF+JXq72zFHsMQos9ktvm4rDCfWgzKw1M85
	WawRKC26pPeHEXHoPZxEiWSe2CEAQoiQBHqgMhj6kQIny6F9S//ZwMyOYyRIM7Z+uiYI
	wUXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
	bh=nQVBDQdIf7uLgvydkDvWOdcylKmcIXFTHUtAzZQVE9w=;
	b=Dx7GguEmNc5M5D/bmt6eNVNa3xz3+7/KjprpOaJ3NzXVKzN9cQrW8o3vdfv6r/JO8K
	bWNvVpBftq16CvQeNXOqgaF8IFtciXL6JxlIQsk1N/4wjXrcFz4goY350XN1chQfqZcs
	ysIPNTtBvZE3mXnAK5unsMV/yJzU2pHO31O0M9GcF6UlLE+hZZpvpFgCTA6InMg3irbr
	ccMxZ2/oxZz1NjxcqMA2FGAuJPq1VpjENmyH5xH7vLBfgnpNJIZ6x1qOiIosgakKqWgR
	HDEoHu5NIYuM7oAQNsfn3oHfBmIBVfh2riPmcZE3ORLu9t5x9N/dBZ9KdrsJCswdiCB1
	9I1w==
X-Gm-Message-State: APjAAAU3dljtE9sPb2bdqjf7I6v1kcDiLtYnZia/OjhPenZomNTum4TO
	luvdKyyCY51C81VSVN2AB7tFBXSeJeAAYrm947SBCC+044Y=
X-Google-Smtp-Source: APXvYqyuvttJ1QVlVKHSlce2MhjoOZTwf2ALSp301MRLPZzh69Tt1/ovVa3JkiaHOuhTsm/Mqo+XQW8NRvUsqmkDi+8=
X-Received: by 2002:ac2:5487:: with SMTP id t7mr6926081lfk.41.1555095839433;
	Fri, 12 Apr 2019 12:03:59 -0700 (PDT)
MIME-Version: 1.0
From: Jonathan Behrens <fintelia@gmail.com>
Date: Fri, 12 Apr 2019 15:03:33 -0400
Message-ID:
 <CANnJOVEkpkBAOo566s1BJk9YQBVeNkf2kpbS_kdjkn9j=3i1VA@mail.gmail.com>
To: qemu-devel@nongnu.org
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::143
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.21
Subject: [Qemu-devel] [PATCH] target/riscv: Expose time CSRs when allowed by
 [m|s]counteren
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
Cc: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
	Palmer Dabbelt <palmer@sifive.com>,
	Alistair Francis <Alistair.Francis@wdc.com>, qemu-riscv@nongnu.org,
	Sagar Karandikar <sagark@eecs.berkeley.edu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190412190333.q9Z9r40WAi10WilzYVecxrs8eTbdXH4hq2HlMDkF_2E@z>

Currently mcounteren.TM acts as though it is hardwired to zero, even though
QEMU
allows it to be set. This change resolves the issue by allowing reads to the
time and timeh control registers when running in a privileged mode where
such
accesses are allowed.

Signed-off-by: Jonathan Behrens <fintelia@gmail.com>
---
 hw/riscv/sifive_clint.c |  1 +
 target/riscv/cpu.c      | 14 ++++++++++++++
 target/riscv/cpu.h      |  2 ++
 target/riscv/csr.c      | 17 +++++++++++------
 4 files changed, 28 insertions(+), 6 deletions(-)

diff --git a/hw/riscv/sifive_clint.c b/hw/riscv/sifive_clint.c
index d4c159e937..3ad4fe6139 100644
--- a/hw/riscv/sifive_clint.c
+++ b/hw/riscv/sifive_clint.c
@@ -237,6 +237,7 @@ DeviceState *sifive_clint_create(hwaddr addr, hwaddr
size, uint32_t num_harts,
         env->timer = timer_new_ns(QEMU_CLOCK_VIRTUAL,
                                   &sifive_clint_timer_cb, cpu);
         env->timecmp = 0;
+        env->time_freq = SIFIVE_CLINT_TIMEBASE_FREQ;
     }

     DeviceState *dev = qdev_create(NULL, TYPE_SIFIVE_CLINT);
diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index d61bce6d55..ff17d54691 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -103,12 +103,20 @@ static void set_resetvec(CPURISCVState *env, int
resetvec)
 #endif
 }

+static void set_time_freq(CPURISCVState *env, uint64_t freq)
+{
+#ifndef CONFIG_USER_ONLY
+    env->time_freq = freq;
+#endif
+}
+
 static void riscv_any_cpu_init(Object *obj)
 {
     CPURISCVState *env = &RISCV_CPU(obj)->env;
     set_misa(env, RVXLEN | RVI | RVM | RVA | RVF | RVD | RVC | RVU);
     set_versions(env, USER_VERSION_2_02_0, PRIV_VERSION_1_10_0);
     set_resetvec(env, DEFAULT_RSTVEC);
+    set_time_freq(env, NANOSECONDS_PER_SECOND);
 }

 #if defined(TARGET_RISCV32)
@@ -121,6 +129,7 @@ static void rv32gcsu_priv1_09_1_cpu_init(Object *obj)
     set_resetvec(env, DEFAULT_RSTVEC);
     set_feature(env, RISCV_FEATURE_MMU);
     set_feature(env, RISCV_FEATURE_PMP);
+    set_time_freq(env, NANOSECONDS_PER_SECOND);
 }

 static void rv32gcsu_priv1_10_0_cpu_init(Object *obj)
@@ -131,6 +140,7 @@ static void rv32gcsu_priv1_10_0_cpu_init(Object *obj)
     set_resetvec(env, DEFAULT_RSTVEC);
     set_feature(env, RISCV_FEATURE_MMU);
     set_feature(env, RISCV_FEATURE_PMP);
+    set_time_freq(env, NANOSECONDS_PER_SECOND);
 }

 static void rv32imacu_nommu_cpu_init(Object *obj)
@@ -140,6 +150,7 @@ static void rv32imacu_nommu_cpu_init(Object *obj)
     set_versions(env, USER_VERSION_2_02_0, PRIV_VERSION_1_10_0);
     set_resetvec(env, DEFAULT_RSTVEC);
     set_feature(env, RISCV_FEATURE_PMP);
+    set_time_freq(env, NANOSECONDS_PER_SECOND);
 }

 #elif defined(TARGET_RISCV64)
@@ -152,6 +163,7 @@ static void rv64gcsu_priv1_09_1_cpu_init(Object *obj)
     set_resetvec(env, DEFAULT_RSTVEC);
     set_feature(env, RISCV_FEATURE_MMU);
     set_feature(env, RISCV_FEATURE_PMP);
+    set_time_freq(env, NANOSECONDS_PER_SECOND);
 }

 static void rv64gcsu_priv1_10_0_cpu_init(Object *obj)
@@ -162,6 +174,7 @@ static void rv64gcsu_priv1_10_0_cpu_init(Object *obj)
     set_resetvec(env, DEFAULT_RSTVEC);
     set_feature(env, RISCV_FEATURE_MMU);
     set_feature(env, RISCV_FEATURE_PMP);
+    set_time_freq(env, NANOSECONDS_PER_SECOND);
 }

 static void rv64imacu_nommu_cpu_init(Object *obj)
@@ -171,6 +184,7 @@ static void rv64imacu_nommu_cpu_init(Object *obj)
     set_versions(env, USER_VERSION_2_02_0, PRIV_VERSION_1_10_0);
     set_resetvec(env, DEFAULT_RSTVEC);
     set_feature(env, RISCV_FEATURE_PMP);
+    set_time_freq(env, NANOSECONDS_PER_SECOND);
 }

 #endif
diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 20bce8742e..67b1769ad3 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -173,7 +173,9 @@ struct CPURISCVState {
     /* temporary htif regs */
     uint64_t mfromhost;
     uint64_t mtohost;
+
     uint64_t timecmp;
+    uint64_t time_freq;

     /* physical memory protection */
     pmp_table_t pmp_state;
diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index e1d91b6c60..6083c782a1 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -191,22 +191,31 @@ static int read_instreth(CPURISCVState *env, int
csrno, target_ulong *val)
 }
 #endif /* TARGET_RISCV32 */

-#if defined(CONFIG_USER_ONLY)
 static int read_time(CPURISCVState *env, int csrno, target_ulong *val)
 {
+#if !defined(CONFIG_USER_ONLY)
+    *val = muldiv64(qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL),
+                    env->time_freq, NANOSECONDS_PER_SECOND);
+#else
     *val = cpu_get_host_ticks();
+#endif
     return 0;
 }

 #if defined(TARGET_RISCV32)
 static int read_timeh(CPURISCVState *env, int csrno, target_ulong *val)
 {
+#if !defined(CONFIG_USER_ONLY)
+    *val = muldiv64(qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL),
+                    env->time_freq, NANOSECONDS_PER_SECOND) >> 32;
+#else
     *val = cpu_get_host_ticks() >> 32;
+#endif
     return 0;
 }
 #endif

-#else /* CONFIG_USER_ONLY */
+#if !defined(CONFIG_USER_ONLY)

 /* Machine constants */

@@ -854,14 +863,10 @@ static riscv_csr_operations csr_ops[CSR_TABLE_SIZE] =
{
     [CSR_INSTRETH] =            { ctr,
read_instreth                       },
 #endif

-    /* User-level time CSRs are only available in linux-user
-     * In privileged mode, the monitor emulates these CSRs */
-#if defined(CONFIG_USER_ONLY)
     [CSR_TIME] =                { ctr,
read_time                           },
 #if defined(TARGET_RISCV32)
     [CSR_TIMEH] =               { ctr,
read_timeh                          },
 #endif
-#endif

 #if !defined(CONFIG_USER_ONLY)
     /* Machine Timers and Counters */
-- 
2.20.1

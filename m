Return-Path: <SRS0=LbB6=TD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66C6DC43219
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2019 05:58:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 222EA206DF
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2019 05:58:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="t9FlaSMi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 222EA206DF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:35001 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hMRD7-0000b2-9X
	for qemu-devel@archiver.kernel.org; Fri, 03 May 2019 01:58:17 -0400
Received: from eggs.gnu.org ([209.51.188.92]:54453)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sjitindarsingh@gmail.com>) id 1hMR8q-00058x-E9
	for qemu-devel@nongnu.org; Fri, 03 May 2019 01:53:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sjitindarsingh@gmail.com>) id 1hMR8o-0002qI-NI
	for qemu-devel@nongnu.org; Fri, 03 May 2019 01:53:52 -0400
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:43660)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <sjitindarsingh@gmail.com>)
	id 1hMR8o-0002pI-G7; Fri, 03 May 2019 01:53:50 -0400
Received: by mail-pf1-x443.google.com with SMTP id e67so2337905pfe.10;
	Thu, 02 May 2019 22:53:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=+U5Xv5nRQkdeJtYZNg9oFGARkmWbZ28i9pDdO6rteRQ=;
	b=t9FlaSMipOT+6uSGxf9TYwmJELIZgFUFs0YxwrYbg1B6xhhfBnkBEpNCHWRa8reirh
	imrOU7R8cJUneks7QklLpGpBaoUoVUVKOc8RJuM/ZHcYvl9sJy+tmHvvbrYYIwz6JOXH
	rhF34px1PX/pUQvniZ8KkBqr9afP7dAoUk5BB3de4LAA3BV4dlrUKe6cR9VgxKy8zwD/
	LnY3lYxNF4xSPAZrfcITZUCjrhgE2iBqAscV31/zTmD5MdDImBmDG0GFqe/T8NT+uStq
	mrk1GmSLzLIc9CqR5zqrlmGi095FPDrkRvjzrH7F1Et2pIIsZ4ZD2T9unbjWzFh8QDHM
	topg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=+U5Xv5nRQkdeJtYZNg9oFGARkmWbZ28i9pDdO6rteRQ=;
	b=NYRCHJ9yKWLPLmCSljQcpoiOc55qy7kLVA4aSKTZZXsAydUJ8nPF/kuXf1X9tSCW6w
	rWJoshSkLyduG3fzalq/b7rvTzYwpzOYHaMCzKfFPrmuNyPklQrNQtfQoOQOmUQyR/Hx
	1lDIH45DaDU569MDix+jlTZ7wc1cRuZeiWObPqU4gc7yj+7ttgSDGxqnD27QnZYE3Y0h
	otztYWBbyeoXRRA9cLU41KTlbqqNyZqcGPIgTHTJfnEXdZSyAFeEcNoIw+HsTFkBJCwk
	amnSK70/zaHk5ppZ4XtOIn1jN4oLasa1rUbkoVa/uxn6XzNRXtmWdBImNr2D/Sch7u6h
	kIiA==
X-Gm-Message-State: APjAAAXGi0vG0jqQYfYrVz7AtsCRa6TluRpYcz1fxIQKDVlvG1ybTDFr
	JdxxKEgRJIAT5tsJ1VYeiPiMlQ1PZ+s=
X-Google-Smtp-Source: APXvYqxamtQpx4WdxqMUxDiVtqsUN/lZj0pjTk5+9oopHAFXQy9Py1ftSz0Rzve53vVAmn2OCgwAKw==
X-Received: by 2002:a63:4714:: with SMTP id u20mr8222472pga.316.1556862828574; 
	Thu, 02 May 2019 22:53:48 -0700 (PDT)
Received: from localhost.ibm.com ([1.129.142.217])
	by smtp.gmail.com with ESMTPSA id
	h187sm1292983pfc.52.2019.05.02.22.53.43
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Thu, 02 May 2019 22:53:47 -0700 (PDT)
From: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
To: qemu-devel@nongnu.org
Date: Fri,  3 May 2019 15:53:05 +1000
Message-Id: <20190503055316.6441-3-sjitindarsingh@gmail.com>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20190503055316.6441-1-sjitindarsingh@gmail.com>
References: <20190503055316.6441-1-sjitindarsingh@gmail.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::443
Subject: [Qemu-devel] [QEMU-PPC] [PATCH 02/13] target/ppc: Work [S]PURR
 implementation and add HV support
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
Cc: groug@kaod.org, qemu-ppc@nongnu.org, clg@kaod.org,
	Suraj Jitindar Singh <sjitindarsingh@gmail.com>,
	david@gibson.dropbear.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190503055305.MUnp_62Xcu3jo1JkQSPHWhflL8z5KHZ_0dFaANHRGIM@z>

The Processor Utilisation of Resources Register (PURR) and Scaled
Processor Utilisation of Resources Register (SPURR) provide an estimate
of the resources used by the thread, present on POWER7 and later
processors.

Currently the [S]PURR registers simply count at the rate of the
timebase.

Preserve this behaviour but rework the implementation to store an offset
like the timebase rather than doing the calculation manually. Also allow
hypervisor write access to the register along with the currently
available read access.

Signed-off-by: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
---
 hw/ppc/ppc.c                    | 17 +++++++----------
 include/hw/ppc/ppc.h            |  3 +--
 target/ppc/cpu.h                |  1 +
 target/ppc/helper.h             |  1 +
 target/ppc/timebase_helper.c    |  5 +++++
 target/ppc/translate_init.inc.c | 23 +++++++++++++++--------
 6 files changed, 30 insertions(+), 20 deletions(-)

diff --git a/hw/ppc/ppc.c b/hw/ppc/ppc.c
index a57ca64626..b567156f97 100644
--- a/hw/ppc/ppc.c
+++ b/hw/ppc/ppc.c
@@ -819,12 +819,9 @@ target_ulong cpu_ppc_load_hdecr (CPUPPCState *env)
 uint64_t cpu_ppc_load_purr (CPUPPCState *env)
 {
     ppc_tb_t *tb_env = env->tb_env;
-    uint64_t diff;
 
-    diff = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) - tb_env->purr_start;
-
-    return tb_env->purr_load +
-        muldiv64(diff, tb_env->tb_freq, NANOSECONDS_PER_SECOND);
+    return cpu_ppc_get_tb(tb_env, qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL),
+                          tb_env->purr_offset);
 }
 
 /* When decrementer expires,
@@ -980,12 +977,12 @@ static void cpu_ppc_hdecr_cb(void *opaque)
     cpu_ppc_hdecr_excp(cpu);
 }
 
-static void cpu_ppc_store_purr(PowerPCCPU *cpu, uint64_t value)
+void cpu_ppc_store_purr(CPUPPCState *env, uint64_t value)
 {
-    ppc_tb_t *tb_env = cpu->env.tb_env;
+    ppc_tb_t *tb_env = env->tb_env;
 
-    tb_env->purr_load = value;
-    tb_env->purr_start = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
+    cpu_ppc_store_tb(tb_env, qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL),
+                     &tb_env->purr_offset, value);
 }
 
 static void cpu_ppc_set_tb_clk (void *opaque, uint32_t freq)
@@ -1002,7 +999,7 @@ static void cpu_ppc_set_tb_clk (void *opaque, uint32_t freq)
      */
     _cpu_ppc_store_decr(cpu, 0xFFFFFFFF, 0xFFFFFFFF, 32);
     _cpu_ppc_store_hdecr(cpu, 0xFFFFFFFF, 0xFFFFFFFF, 32);
-    cpu_ppc_store_purr(cpu, 0x0000000000000000ULL);
+    cpu_ppc_store_purr(env, 0x0000000000000000ULL);
 }
 
 static void timebase_save(PPCTimebase *tb)
diff --git a/include/hw/ppc/ppc.h b/include/hw/ppc/ppc.h
index 205150e6b4..b09ffbf300 100644
--- a/include/hw/ppc/ppc.h
+++ b/include/hw/ppc/ppc.h
@@ -32,8 +32,7 @@ struct ppc_tb_t {
     /* Hypervisor decrementer management */
     uint64_t hdecr_next;    /* Tick for next hdecr interrupt  */
     QEMUTimer *hdecr_timer;
-    uint64_t purr_load;
-    uint64_t purr_start;
+    int64_t purr_offset;
     void *opaque;
     uint32_t flags;
 };
diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
index 70167bae22..19b3e1de0e 100644
--- a/target/ppc/cpu.h
+++ b/target/ppc/cpu.h
@@ -1335,6 +1335,7 @@ void cpu_ppc_store_decr (CPUPPCState *env, target_ulong value);
 target_ulong cpu_ppc_load_hdecr (CPUPPCState *env);
 void cpu_ppc_store_hdecr (CPUPPCState *env, target_ulong value);
 uint64_t cpu_ppc_load_purr (CPUPPCState *env);
+void cpu_ppc_store_purr(CPUPPCState *env, uint64_t value);
 uint32_t cpu_ppc601_load_rtcl (CPUPPCState *env);
 uint32_t cpu_ppc601_load_rtcu (CPUPPCState *env);
 #if !defined(CONFIG_USER_ONLY)
diff --git a/target/ppc/helper.h b/target/ppc/helper.h
index 3701bcbf1b..336e7802fb 100644
--- a/target/ppc/helper.h
+++ b/target/ppc/helper.h
@@ -686,6 +686,7 @@ DEF_HELPER_FLAGS_1(load_601_rtcu, TCG_CALL_NO_RWG, tl, env)
 #if !defined(CONFIG_USER_ONLY)
 #if defined(TARGET_PPC64)
 DEF_HELPER_FLAGS_1(load_purr, TCG_CALL_NO_RWG, tl, env)
+DEF_HELPER_FLAGS_2(store_purr, TCG_CALL_NO_RWG, void, env, tl)
 DEF_HELPER_2(store_ptcr, void, env, tl)
 #endif
 DEF_HELPER_2(store_sdr1, void, env, tl)
diff --git a/target/ppc/timebase_helper.c b/target/ppc/timebase_helper.c
index 8c3c2fe67c..2395295b77 100644
--- a/target/ppc/timebase_helper.c
+++ b/target/ppc/timebase_helper.c
@@ -55,6 +55,11 @@ target_ulong helper_load_purr(CPUPPCState *env)
 {
     return (target_ulong)cpu_ppc_load_purr(env);
 }
+
+void helper_store_purr(CPUPPCState *env, target_ulong val)
+{
+    cpu_ppc_store_purr(env, val);
+}
 #endif
 
 target_ulong helper_load_601_rtcl(CPUPPCState *env)
diff --git a/target/ppc/translate_init.inc.c b/target/ppc/translate_init.inc.c
index e3f941800b..9cd33e79ef 100644
--- a/target/ppc/translate_init.inc.c
+++ b/target/ppc/translate_init.inc.c
@@ -285,6 +285,11 @@ static void spr_read_purr(DisasContext *ctx, int gprn, int sprn)
     gen_helper_load_purr(cpu_gpr[gprn], cpu_env);
 }
 
+static void spr_write_purr(DisasContext *ctx, int sprn, int gprn)
+{
+    gen_helper_store_purr(cpu_env, cpu_gpr[gprn]);
+}
+
 /* HDECR */
 static void spr_read_hdecr(DisasContext *ctx, int gprn, int sprn)
 {
@@ -7972,14 +7977,16 @@ static void gen_spr_book3s_purr(CPUPPCState *env)
 {
 #if !defined(CONFIG_USER_ONLY)
     /* PURR & SPURR: Hack - treat these as aliases for the TB for now */
-    spr_register_kvm(env, SPR_PURR,   "PURR",
-                     &spr_read_purr, SPR_NOACCESS,
-                     &spr_read_purr, SPR_NOACCESS,
-                     KVM_REG_PPC_PURR, 0x00000000);
-    spr_register_kvm(env, SPR_SPURR,   "SPURR",
-                     &spr_read_purr, SPR_NOACCESS,
-                     &spr_read_purr, SPR_NOACCESS,
-                     KVM_REG_PPC_SPURR, 0x00000000);
+    spr_register_kvm_hv(env, SPR_PURR,   "PURR",
+                        &spr_read_purr, SPR_NOACCESS,
+                        &spr_read_purr, SPR_NOACCESS,
+                        &spr_read_purr, &spr_write_purr,
+                        KVM_REG_PPC_PURR, 0x00000000);
+    spr_register_kvm_hv(env, SPR_SPURR,   "SPURR",
+                        &spr_read_purr, SPR_NOACCESS,
+                        &spr_read_purr, SPR_NOACCESS,
+                        &spr_read_purr, &spr_write_purr,
+                        KVM_REG_PPC_SPURR, 0x00000000);
 #endif
 }
 
-- 
2.13.6



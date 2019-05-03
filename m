Return-Path: <SRS0=LbB6=TD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14D6FC43219
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2019 05:55:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C48BB2075C
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2019 05:55:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kCX3enej"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C48BB2075C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:34944 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hMRAT-0006CR-0W
	for qemu-devel@archiver.kernel.org; Fri, 03 May 2019 01:55:33 -0400
Received: from eggs.gnu.org ([209.51.188.92]:54388)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sjitindarsingh@gmail.com>) id 1hMR8l-00054v-9Z
	for qemu-devel@nongnu.org; Fri, 03 May 2019 01:53:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sjitindarsingh@gmail.com>) id 1hMR8j-0002nZ-VC
	for qemu-devel@nongnu.org; Fri, 03 May 2019 01:53:47 -0400
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:34528)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <sjitindarsingh@gmail.com>)
	id 1hMR8i-0002mb-LR; Fri, 03 May 2019 01:53:45 -0400
Received: by mail-pl1-x642.google.com with SMTP id ck18so2191449plb.1;
	Thu, 02 May 2019 22:53:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=XkCV3eLxqyBlikFgPtJ27XXNEcQJUOtpk+hewO4Cx4s=;
	b=kCX3enejx7PdantJYDPknyfvc7AVOwr/P6XPSajQAGbrmsGpSbIPmhe6zxv4IbQHQw
	pXbggSCaaCEgGP1qU1fOzq1fJomKtU+drMz6FiqRUqwemRPnbUg+6tq+YdaQSiT0GsXj
	KNfZJ73cOGEH3otTUz80Zk2Th7rIk1eR+DFPXCEAB18J/Oy5zbLNup3lrmJLg1mZORtB
	xXulI3yKHgAJPR8fGrskj5M20QN8wLfxXeXmqzJBYP2fbl308wl56j5rclRVdomkamLe
	alIl4ZTJsPfTY8wHdysnGQsIQMarqJGhxKE69s79UTW9DALXlUAM15OLpUJwow9SBAsm
	TOkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=XkCV3eLxqyBlikFgPtJ27XXNEcQJUOtpk+hewO4Cx4s=;
	b=f8PANXNRKYAzdQLeXSxQ0wRs1OiBJyHEU7TvLygaPeAFWGVRjz1zt0fKQGfo6pO/j9
	N2e3hXecZAWA0GqACNZIX/KajS3ct7qDI7sGOKC4vzF/g9e5TJGAIikzN03clnq4bMm3
	IuEs6FyoBNIn+skGIhmvfDPYexX6kR34EOgRijd6LFuNjg+OCk+mHh21FhgtnOCIC6+w
	hvP5PgLD5QMQa1RUxkPEQbOuVXkTZ0+Y24hTa0ztJSZdTkd4Uc2xumBTIeIZxv2wMkv5
	yg4KaCrIag1MfSXu67xMc0XlYH5GpZci+cQE45JmCYs2GFozmbCimCTInEKiKa2uAiCe
	Ta/A==
X-Gm-Message-State: APjAAAU9xkqVSadCz7imA72gho5b6SQEHQeQ7heyPoTn5ThJvndEQAka
	hysumvw7iIvgb15YYHOb+j47aSJn+78=
X-Google-Smtp-Source: APXvYqx7Fydcr5rifxG32JbrejJsjyCE3oqSWnLzqvx7pN/wcSgkr/MMheEc4GHfEUfElv7KYLC55g==
X-Received: by 2002:a17:902:704c:: with SMTP id
	h12mr8096746plt.270.1556862823206; 
	Thu, 02 May 2019 22:53:43 -0700 (PDT)
Received: from localhost.ibm.com ([1.129.142.217])
	by smtp.gmail.com with ESMTPSA id
	h187sm1292983pfc.52.2019.05.02.22.53.37
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Thu, 02 May 2019 22:53:42 -0700 (PDT)
From: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
To: qemu-devel@nongnu.org
Date: Fri,  3 May 2019 15:53:04 +1000
Message-Id: <20190503055316.6441-2-sjitindarsingh@gmail.com>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20190503055316.6441-1-sjitindarsingh@gmail.com>
References: <20190503055316.6441-1-sjitindarsingh@gmail.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::642
Subject: [Qemu-devel] [QEMU-PPC] [PATCH 01/13] target/ppc: Implement the VTB
 for HV access
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
Message-ID: <20190503055304.1py1UfBQ6G-yU6PO6sod4KQOkqJKK8tmxHg9uMsfgqQ@z>

The virtual timebase register (VTB) is a 64-bit register which
increments at the same rate as the timebase register, present on POWER8
and later processors.

The register is able to be read/written by the hypervisor and read by
the supervisor. All other accesses are illegal.

Currently the VTB is just an alias for the timebase (TB) register.

Implement the VTB so that is can be read/written independent of the TB.
Make use of the existing method for accessing timebase facilities where
by the compensation is stored and used to compute the value on reads/is
updated on writes.

Signed-off-by: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
---
 hw/ppc/ppc.c                    | 16 ++++++++++++++++
 include/hw/ppc/ppc.h            |  1 +
 linux-user/ppc/cpu_loop.c       |  5 +++++
 target/ppc/cpu.h                |  2 ++
 target/ppc/helper.h             |  2 ++
 target/ppc/timebase_helper.c    | 10 ++++++++++
 target/ppc/translate_init.inc.c | 19 +++++++++++++++----
 7 files changed, 51 insertions(+), 4 deletions(-)

diff --git a/hw/ppc/ppc.c b/hw/ppc/ppc.c
index b2ff99ec66..a57ca64626 100644
--- a/hw/ppc/ppc.c
+++ b/hw/ppc/ppc.c
@@ -694,6 +694,22 @@ void cpu_ppc_store_atbu (CPUPPCState *env, uint32_t value)
                      &tb_env->atb_offset, ((uint64_t)value << 32) | tb);
 }
 
+uint64_t cpu_ppc_load_vtb(CPUPPCState *env)
+{
+    ppc_tb_t *tb_env = env->tb_env;
+
+    return cpu_ppc_get_tb(tb_env, qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL),
+                          tb_env->vtb_offset);
+}
+
+void cpu_ppc_store_vtb(CPUPPCState *env, uint64_t value)
+{
+    ppc_tb_t *tb_env = env->tb_env;
+
+    cpu_ppc_store_tb(tb_env, qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL),
+                     &tb_env->vtb_offset, value);
+}
+
 static void cpu_ppc_tb_stop (CPUPPCState *env)
 {
     ppc_tb_t *tb_env = env->tb_env;
diff --git a/include/hw/ppc/ppc.h b/include/hw/ppc/ppc.h
index 4bdcb8bacd..205150e6b4 100644
--- a/include/hw/ppc/ppc.h
+++ b/include/hw/ppc/ppc.h
@@ -23,6 +23,7 @@ struct ppc_tb_t {
     /* Time base management */
     int64_t  tb_offset;    /* Compensation                    */
     int64_t  atb_offset;   /* Compensation                    */
+    int64_t  vtb_offset;
     uint32_t tb_freq;      /* TB frequency                    */
     /* Decrementer management */
     uint64_t decr_next;    /* Tick for next decr interrupt    */
diff --git a/linux-user/ppc/cpu_loop.c b/linux-user/ppc/cpu_loop.c
index 801f5ace29..c715861804 100644
--- a/linux-user/ppc/cpu_loop.c
+++ b/linux-user/ppc/cpu_loop.c
@@ -46,6 +46,11 @@ uint32_t cpu_ppc_load_atbu(CPUPPCState *env)
     return cpu_ppc_get_tb(env) >> 32;
 }
 
+uint64_t cpu_ppc_load_vtb(CPUPPCState *env)
+{
+    return cpu_ppc_get_tb(env);
+}
+
 uint32_t cpu_ppc601_load_rtcu(CPUPPCState *env)
 __attribute__ (( alias ("cpu_ppc_load_tbu") ));
 
diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
index fe93cf0555..70167bae22 100644
--- a/target/ppc/cpu.h
+++ b/target/ppc/cpu.h
@@ -1327,6 +1327,8 @@ uint64_t cpu_ppc_load_atbl (CPUPPCState *env);
 uint32_t cpu_ppc_load_atbu (CPUPPCState *env);
 void cpu_ppc_store_atbl (CPUPPCState *env, uint32_t value);
 void cpu_ppc_store_atbu (CPUPPCState *env, uint32_t value);
+uint64_t cpu_ppc_load_vtb(CPUPPCState *env);
+void cpu_ppc_store_vtb(CPUPPCState *env, uint64_t value);
 bool ppc_decr_clear_on_delivery(CPUPPCState *env);
 target_ulong cpu_ppc_load_decr (CPUPPCState *env);
 void cpu_ppc_store_decr (CPUPPCState *env, target_ulong value);
diff --git a/target/ppc/helper.h b/target/ppc/helper.h
index 69cbf7922f..3701bcbf1b 100644
--- a/target/ppc/helper.h
+++ b/target/ppc/helper.h
@@ -680,6 +680,7 @@ DEF_HELPER_FLAGS_1(load_tbl, TCG_CALL_NO_RWG, tl, env)
 DEF_HELPER_FLAGS_1(load_tbu, TCG_CALL_NO_RWG, tl, env)
 DEF_HELPER_FLAGS_1(load_atbl, TCG_CALL_NO_RWG, tl, env)
 DEF_HELPER_FLAGS_1(load_atbu, TCG_CALL_NO_RWG, tl, env)
+DEF_HELPER_FLAGS_1(load_vtb, TCG_CALL_NO_RWG, tl, env)
 DEF_HELPER_FLAGS_1(load_601_rtcl, TCG_CALL_NO_RWG, tl, env)
 DEF_HELPER_FLAGS_1(load_601_rtcu, TCG_CALL_NO_RWG, tl, env)
 #if !defined(CONFIG_USER_ONLY)
@@ -700,6 +701,7 @@ DEF_HELPER_FLAGS_1(load_decr, TCG_CALL_NO_RWG, tl, env)
 DEF_HELPER_FLAGS_2(store_decr, TCG_CALL_NO_RWG, void, env, tl)
 DEF_HELPER_FLAGS_1(load_hdecr, TCG_CALL_NO_RWG, tl, env)
 DEF_HELPER_FLAGS_2(store_hdecr, TCG_CALL_NO_RWG, void, env, tl)
+DEF_HELPER_FLAGS_2(store_vtb, TCG_CALL_NO_RWG, void, env, tl)
 DEF_HELPER_2(store_hid0_601, void, env, tl)
 DEF_HELPER_3(store_403_pbr, void, env, i32, tl)
 DEF_HELPER_FLAGS_1(load_40x_pit, TCG_CALL_NO_RWG, tl, env)
diff --git a/target/ppc/timebase_helper.c b/target/ppc/timebase_helper.c
index 73363e08ae..8c3c2fe67c 100644
--- a/target/ppc/timebase_helper.c
+++ b/target/ppc/timebase_helper.c
@@ -45,6 +45,11 @@ target_ulong helper_load_atbu(CPUPPCState *env)
     return cpu_ppc_load_atbu(env);
 }
 
+target_ulong helper_load_vtb(CPUPPCState *env)
+{
+    return cpu_ppc_load_vtb(env);
+}
+
 #if defined(TARGET_PPC64) && !defined(CONFIG_USER_ONLY)
 target_ulong helper_load_purr(CPUPPCState *env)
 {
@@ -113,6 +118,11 @@ void helper_store_hdecr(CPUPPCState *env, target_ulong val)
     cpu_ppc_store_hdecr(env, val);
 }
 
+void helper_store_vtb(CPUPPCState *env, target_ulong val)
+{
+    cpu_ppc_store_vtb(env, val);
+}
+
 target_ulong helper_load_40x_pit(CPUPPCState *env)
 {
     return load_40x_pit(env);
diff --git a/target/ppc/translate_init.inc.c b/target/ppc/translate_init.inc.c
index 0bd555eb19..e3f941800b 100644
--- a/target/ppc/translate_init.inc.c
+++ b/target/ppc/translate_init.inc.c
@@ -310,6 +310,16 @@ static void spr_write_hdecr(DisasContext *ctx, int sprn, int gprn)
     }
 }
 
+static void spr_read_vtb(DisasContext *ctx, int gprn, int sprn)
+{
+    gen_helper_load_vtb(cpu_gpr[gprn], cpu_env);
+}
+
+static void spr_write_vtb(DisasContext *ctx, int sprn, int gprn)
+{
+    gen_helper_store_vtb(cpu_env, cpu_gpr[gprn]);
+}
+
 #endif
 #endif
 
@@ -8133,10 +8143,11 @@ static void gen_spr_power8_ebb(CPUPPCState *env)
 /* Virtual Time Base */
 static void gen_spr_vtb(CPUPPCState *env)
 {
-    spr_register_kvm(env, SPR_VTB, "VTB",
-                 SPR_NOACCESS, SPR_NOACCESS,
-                 &spr_read_tbl, SPR_NOACCESS,
-                 KVM_REG_PPC_VTB, 0x00000000);
+    spr_register_kvm_hv(env, SPR_VTB, "VTB",
+                        SPR_NOACCESS, SPR_NOACCESS,
+                        &spr_read_vtb, SPR_NOACCESS,
+                        &spr_read_vtb, &spr_write_vtb,
+                        KVM_REG_PPC_VTB, 0x00000000);
 }
 
 static void gen_spr_power8_fscr(CPUPPCState *env)
-- 
2.13.6



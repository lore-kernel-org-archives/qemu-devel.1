Return-Path: <SRS0=LbB6=TD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A18D8C43219
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2019 05:58:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5B721206DF
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2019 05:58:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ru1FpV+s"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B721206DF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:35003 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hMRDH-0000kQ-JG
	for qemu-devel@archiver.kernel.org; Fri, 03 May 2019 01:58:27 -0400
Received: from eggs.gnu.org ([209.51.188.92]:54542)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sjitindarsingh@gmail.com>) id 1hMR8y-0005Gd-9V
	for qemu-devel@nongnu.org; Fri, 03 May 2019 01:54:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sjitindarsingh@gmail.com>) id 1hMR8w-0002tg-Mv
	for qemu-devel@nongnu.org; Fri, 03 May 2019 01:54:00 -0400
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:44376)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <sjitindarsingh@gmail.com>)
	id 1hMR8w-0002t7-GM; Fri, 03 May 2019 01:53:58 -0400
Received: by mail-pg1-x544.google.com with SMTP id z16so2183042pgv.11;
	Thu, 02 May 2019 22:53:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=tDDmbBxXcuGX6xPjl7n2FpWe9iGxr+XHYg3A3IEDeRE=;
	b=Ru1FpV+sCVwjXKccpVkwDVU5vr4I6vyAJkU+r0jkDy0fgGpvYwHbAXGUz5iel6l/51
	F2M+sK1mNW3jaRJd16BuW5cTVZHstDxAQij+Sp454QviEJsky3mg9J9zie6NTRJ3duWK
	wuMb/fuB7zdhkAAZVKI/5RWmJLXYpkiLRUZtCdSaGiZ0Hf3z4W+gwjW9TiYK3RIajJA3
	t8ZZd8bIVryexibeMNkEtuKYPia6zThp0kUSiQvyAo0op67MsbXI4XjLRylde6jaJKR6
	1hJUcGAPD7Ctv80UnSNZgP1auzOKyRdxi6ZMuCTMU7wS22ul4vmM4WRuPOTbDY03H2vr
	kTTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=tDDmbBxXcuGX6xPjl7n2FpWe9iGxr+XHYg3A3IEDeRE=;
	b=iAxb/w+eHegjLPXql/R5gZDDUXA0EsaL02075dpoiwtnt4fAwISnXm+RC9pAkUz0/F
	kFp4v/WoU5ebmNZUzT6fKiF3L3tMvEGpdQhsJXALs6dSIhbSjusX978SAjnjBeoMtbC8
	duSeJ2NiMbSXJF1+KsPLzUllHBqNk8rNraLqiJ/NN62a/LIxLTWhgCNL1V8T53ou4KAT
	fTxYTeDlr8NFkv/ZCWitZvOYAS4RZrVvQbsaYO/tM9+ltXlZpSl6FM+TF3ZrywDWfoph
	WIKXiulHLF7B0bahtNoUu9xr56rac3VFT0vqMtOUW5Vhn262tssU0VDidcukNdNbdV0R
	R5cQ==
X-Gm-Message-State: APjAAAUTKWOMlmaYE8442LRYK/LbXwA+G9kEc2Pis9xfON6+PlMpYmLT
	73TBoIPeYO0UfbfIKZ5NBwRtCGgCaLg=
X-Google-Smtp-Source: APXvYqwUV4Qrj0iDW8hsIgn58cUNKyGdKqPYol4h6dCMdKfpOhaKKqvt0Jf0Cc7NnlYiQfxO7GrXsg==
X-Received: by 2002:a62:14d6:: with SMTP id 205mr8540100pfu.4.1556862837325;
	Thu, 02 May 2019 22:53:57 -0700 (PDT)
Received: from localhost.ibm.com ([1.129.142.217])
	by smtp.gmail.com with ESMTPSA id
	h187sm1292983pfc.52.2019.05.02.22.53.53
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Thu, 02 May 2019 22:53:56 -0700 (PDT)
From: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
To: qemu-devel@nongnu.org
Date: Fri,  3 May 2019 15:53:07 +1000
Message-Id: <20190503055316.6441-5-sjitindarsingh@gmail.com>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20190503055316.6441-1-sjitindarsingh@gmail.com>
References: <20190503055316.6441-1-sjitindarsingh@gmail.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::544
Subject: [Qemu-devel] [QEMU-PPC] [PATCH 04/13] target/ppc: Add SPR TBU40
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
Message-ID: <20190503055307.LOVpEZ3DTClhZVx56SmTsS4ENkDbcCRPf5fH9WGplyg@z>

The spr TBU40 is used to set the upper 40 bits of the timebase
register, present on POWER5+ and later processors.

This register can only be written by the hypervisor, and cannot be read.

Signed-off-by: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
---
 hw/ppc/ppc.c                    | 13 +++++++++++++
 target/ppc/cpu.h                |  1 +
 target/ppc/helper.h             |  1 +
 target/ppc/timebase_helper.c    |  5 +++++
 target/ppc/translate_init.inc.c | 19 +++++++++++++++++++
 5 files changed, 39 insertions(+)

diff --git a/hw/ppc/ppc.c b/hw/ppc/ppc.c
index b567156f97..b618c6f615 100644
--- a/hw/ppc/ppc.c
+++ b/hw/ppc/ppc.c
@@ -710,6 +710,19 @@ void cpu_ppc_store_vtb(CPUPPCState *env, uint64_t value)
                      &tb_env->vtb_offset, value);
 }
 
+void cpu_ppc_store_tbu40(CPUPPCState *env, uint64_t value)
+{
+    ppc_tb_t *tb_env = env->tb_env;
+    uint64_t tb;
+
+    tb = cpu_ppc_get_tb(tb_env, qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL),
+                        tb_env->tb_offset);
+    tb &= 0xFFFFFFUL;
+    tb |= (value & ~0xFFFFFFUL);
+    cpu_ppc_store_tb(tb_env, qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL),
+                     &tb_env->tb_offset, tb);
+}
+
 static void cpu_ppc_tb_stop (CPUPPCState *env)
 {
     ppc_tb_t *tb_env = env->tb_env;
diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
index 8d66265e5a..e324064111 100644
--- a/target/ppc/cpu.h
+++ b/target/ppc/cpu.h
@@ -1334,6 +1334,7 @@ target_ulong cpu_ppc_load_decr (CPUPPCState *env);
 void cpu_ppc_store_decr (CPUPPCState *env, target_ulong value);
 target_ulong cpu_ppc_load_hdecr (CPUPPCState *env);
 void cpu_ppc_store_hdecr (CPUPPCState *env, target_ulong value);
+void cpu_ppc_store_tbu40(CPUPPCState *env, uint64_t value);
 uint64_t cpu_ppc_load_purr (CPUPPCState *env);
 void cpu_ppc_store_purr(CPUPPCState *env, uint64_t value);
 uint32_t cpu_ppc601_load_rtcl (CPUPPCState *env);
diff --git a/target/ppc/helper.h b/target/ppc/helper.h
index 336e7802fb..6aee195528 100644
--- a/target/ppc/helper.h
+++ b/target/ppc/helper.h
@@ -703,6 +703,7 @@ DEF_HELPER_FLAGS_2(store_decr, TCG_CALL_NO_RWG, void, env, tl)
 DEF_HELPER_FLAGS_1(load_hdecr, TCG_CALL_NO_RWG, tl, env)
 DEF_HELPER_FLAGS_2(store_hdecr, TCG_CALL_NO_RWG, void, env, tl)
 DEF_HELPER_FLAGS_2(store_vtb, TCG_CALL_NO_RWG, void, env, tl)
+DEF_HELPER_FLAGS_2(store_tbu40, TCG_CALL_NO_RWG, void, env, tl)
 DEF_HELPER_2(store_hid0_601, void, env, tl)
 DEF_HELPER_3(store_403_pbr, void, env, i32, tl)
 DEF_HELPER_FLAGS_1(load_40x_pit, TCG_CALL_NO_RWG, tl, env)
diff --git a/target/ppc/timebase_helper.c b/target/ppc/timebase_helper.c
index 2395295b77..703bd9ed18 100644
--- a/target/ppc/timebase_helper.c
+++ b/target/ppc/timebase_helper.c
@@ -128,6 +128,11 @@ void helper_store_vtb(CPUPPCState *env, target_ulong val)
     cpu_ppc_store_vtb(env, val);
 }
 
+void helper_store_tbu40(CPUPPCState *env, target_ulong val)
+{
+    cpu_ppc_store_tbu40(env, val);
+}
+
 target_ulong helper_load_40x_pit(CPUPPCState *env)
 {
     return load_40x_pit(env);
diff --git a/target/ppc/translate_init.inc.c b/target/ppc/translate_init.inc.c
index a0cae58e19..8e287066e5 100644
--- a/target/ppc/translate_init.inc.c
+++ b/target/ppc/translate_init.inc.c
@@ -325,6 +325,11 @@ static void spr_write_vtb(DisasContext *ctx, int sprn, int gprn)
     gen_helper_store_vtb(cpu_env, cpu_gpr[gprn]);
 }
 
+static void spr_write_tbu40(DisasContext *ctx, int sprn, int gprn)
+{
+    gen_helper_store_tbu40(cpu_env, cpu_gpr[gprn]);
+}
+
 #endif
 #endif
 
@@ -7812,6 +7817,16 @@ static void gen_spr_power5p_ear(CPUPPCState *env)
                  0x00000000);
 }
 
+static void gen_spr_power5p_tb(CPUPPCState *env)
+{
+    /* TBU40 (High 40 bits of the Timebase register */
+    spr_register_hv(env, SPR_TBU40, "TBU40",
+                    SPR_NOACCESS, SPR_NOACCESS,
+                    SPR_NOACCESS, SPR_NOACCESS,
+                    SPR_NOACCESS, &spr_write_tbu40,
+                    0x00000000);
+}
+
 #if !defined(CONFIG_USER_ONLY)
 static void spr_write_hmer(DisasContext *ctx, int sprn, int gprn)
 {
@@ -8352,6 +8367,7 @@ static void init_proc_power5plus(CPUPPCState *env)
     gen_spr_power5p_common(env);
     gen_spr_power5p_lpar(env);
     gen_spr_power5p_ear(env);
+    gen_spr_power5p_tb(env);
 
     /* env variables */
     env->dcache_line_size = 128;
@@ -8464,6 +8480,7 @@ static void init_proc_POWER7(CPUPPCState *env)
     gen_spr_power5p_common(env);
     gen_spr_power5p_lpar(env);
     gen_spr_power5p_ear(env);
+    gen_spr_power5p_tb(env);
     gen_spr_power6_common(env);
     gen_spr_power6_dbg(env);
     gen_spr_power7_book4(env);
@@ -8605,6 +8622,7 @@ static void init_proc_POWER8(CPUPPCState *env)
     gen_spr_power5p_common(env);
     gen_spr_power5p_lpar(env);
     gen_spr_power5p_ear(env);
+    gen_spr_power5p_tb(env);
     gen_spr_power6_common(env);
     gen_spr_power6_dbg(env);
     gen_spr_power8_tce_address_control(env);
@@ -8793,6 +8811,7 @@ static void init_proc_POWER9(CPUPPCState *env)
     gen_spr_power5p_common(env);
     gen_spr_power5p_lpar(env);
     gen_spr_power5p_ear(env);
+    gen_spr_power5p_tb(env);
     gen_spr_power6_common(env);
     gen_spr_power6_dbg(env);
     gen_spr_power8_tce_address_control(env);
-- 
2.13.6



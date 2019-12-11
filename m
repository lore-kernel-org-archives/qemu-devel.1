Return-Path: <SRS0=Q6KP=2B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E358C43603
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2019 20:38:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 38FF4206A5
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2019 20:38:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ks56PShp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 38FF4206A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50430 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1if8kT-0005iz-6D
	for qemu-devel@archiver.kernel.org; Wed, 11 Dec 2019 15:38:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47878)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1if8id-0003sz-Jd
 for qemu-devel@nongnu.org; Wed, 11 Dec 2019 15:36:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1if8ic-0001Zt-Ab
 for qemu-devel@nongnu.org; Wed, 11 Dec 2019 15:36:23 -0500
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:34077)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1if8ia-0001X9-Vq
 for qemu-devel@nongnu.org; Wed, 11 Dec 2019 15:36:21 -0500
Received: by mail-pf1-x441.google.com with SMTP id l127so1095144pfl.1
 for <qemu-devel@nongnu.org>; Wed, 11 Dec 2019 12:36:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=eEjzZu+b1EAOlLfnxc4p5LFc5cBn/iUEwgDu7STmKhM=;
 b=Ks56PShpgIs2pIK1PyMHU1X5QpshUBNExs8hq6x+gdgShiOCX1zY8qF5Cgr2sC9s82
 zKzOejgloeQI/RMATxHtcCNhp1LmAdaOaqIwXktsTynSOyjOQlBuj5r+hLQCepdW/ZXG
 4HscQ0f1lrcUZP1a5FEvbAgSC603rKKe9FlTXaxQgvSukB24Zc2wX3+Bk8ieUP5IEK5z
 9RiogIQyamxEz42rlU1JmbDVgsaxqt0Li39Uqa+NehFDv4GowXK9Ljczx8+s/LFseEue
 gNkNZbMeMC0xqUi1LQqwfh9e/fbrg1Kf0QvQF+qj9irA6KLLHZkvaKMK+vj9j7mlJPI9
 JhRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=eEjzZu+b1EAOlLfnxc4p5LFc5cBn/iUEwgDu7STmKhM=;
 b=lKw1lsQNgPxtr7+hWO0Zz04xccWmhKKKqwkiSJVxLf59+fMTi8wfImtJP1UOqx0Vos
 +Fkc68qjxQFygNKeCzM/NjM6Qu8zqT8l5hg2ysVj5VA5+Wq7cA2li1PJsdMtJLI2HsJZ
 KtCs9+PLfAuKbcZLlcZGzy2rKOcnLmiY68W7VxIPxjMPD6kLwX/dYz2YQkgoyKGD/uB+
 545plpIcFgJqXi4LUwb4jl3hCG5G7eDligJl9Zdnn2KMwrZbpH3ip9zHWMDf6nmpFsui
 D82TbR2gP5uXLr2xN6aZzrR7GJs2ic33kt7xLYeDVs03FjdVK6eAa0TfZGxFrYfYU2l2
 3CxA==
X-Gm-Message-State: APjAAAUB9CvpgrqCf9EcRJyV+1NlYmqrn76CRTjzm2OD50/YbVJNubG5
 V2bChQP9XCPpDB9KzJTmjdTQfMWzMfA=
X-Google-Smtp-Source: APXvYqxT401U+IJb3oP4nYUVQzq4FUmBescrZYoywfjFx8dQYE6wJ5Frkrd+trQuRUmY0mJRyJOsKA==
X-Received: by 2002:aa7:968b:: with SMTP id f11mr5924537pfk.209.1576096578548; 
 Wed, 11 Dec 2019 12:36:18 -0800 (PST)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id b21sm4280335pfp.0.2019.12.11.12.36.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Dec 2019 12:36:17 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 2/2] target/s390x: Implement LOAD/STORE TO REAL ADDRESS inline
Date: Wed, 11 Dec 2019 12:36:14 -0800
Message-Id: <20191211203614.15611-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191211203614.15611-1-richard.henderson@linaro.org>
References: <20191211203614.15611-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::441
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
Cc: qemu-s390x@nongnu.org, david@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

These are trivially done by performing a memory operation
with the correct mmu_idx.  The only tricky part is using
get_address directly in order to get the address wrapped;
we cannot use la2 because of the format.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/s390x/helper.h      |  4 ----
 target/s390x/mem_helper.c  | 22 ----------------------
 target/s390x/translate.c   | 21 ++++-----------------
 target/s390x/insn-data.def |  8 ++++----
 4 files changed, 8 insertions(+), 47 deletions(-)

diff --git a/target/s390x/helper.h b/target/s390x/helper.h
index f5b4bb6a31..b5813c2ac2 100644
--- a/target/s390x/helper.h
+++ b/target/s390x/helper.h
@@ -324,10 +324,6 @@ DEF_HELPER_FLAGS_4(ipte, TCG_CALL_NO_RWG, void, env, i64, i64, i32)
 DEF_HELPER_FLAGS_1(ptlb, TCG_CALL_NO_RWG, void, env)
 DEF_HELPER_FLAGS_1(purge, TCG_CALL_NO_RWG, void, env)
 DEF_HELPER_2(lra, i64, env, i64)
-DEF_HELPER_FLAGS_2(lura, TCG_CALL_NO_WG, i64, env, i64)
-DEF_HELPER_FLAGS_2(lurag, TCG_CALL_NO_WG, i64, env, i64)
-DEF_HELPER_FLAGS_3(stura, TCG_CALL_NO_WG, void, env, i64, i64)
-DEF_HELPER_FLAGS_3(sturg, TCG_CALL_NO_WG, void, env, i64, i64)
 DEF_HELPER_1(per_check_exception, void, env)
 DEF_HELPER_FLAGS_3(per_branch, TCG_CALL_NO_RWG, void, env, i64, i64)
 DEF_HELPER_FLAGS_2(per_ifetch, TCG_CALL_NO_RWG, void, env, i64)
diff --git a/target/s390x/mem_helper.c b/target/s390x/mem_helper.c
index b1b3f406c9..2921419c27 100644
--- a/target/s390x/mem_helper.c
+++ b/target/s390x/mem_helper.c
@@ -2329,28 +2329,6 @@ void HELPER(purge)(CPUS390XState *env)
     tlb_flush_all_cpus_synced(env_cpu(env));
 }
 
-/* load using real address */
-uint64_t HELPER(lura)(CPUS390XState *env, uint64_t addr)
-{
-    return cpu_ldl_real_ra(env, wrap_address(env, addr), GETPC());
-}
-
-uint64_t HELPER(lurag)(CPUS390XState *env, uint64_t addr)
-{
-    return cpu_ldq_real_ra(env, wrap_address(env, addr), GETPC());
-}
-
-/* store using real address */
-void HELPER(stura)(CPUS390XState *env, uint64_t addr, uint64_t v1)
-{
-    cpu_stl_real_ra(env, wrap_address(env, addr), (uint32_t)v1, GETPC());
-}
-
-void HELPER(sturg)(CPUS390XState *env, uint64_t addr, uint64_t v1)
-{
-    cpu_stq_real_ra(env, wrap_address(env, addr), v1, GETPC());
-}
-
 /* load real address */
 uint64_t HELPER(lra)(CPUS390XState *env, uint64_t addr)
 {
diff --git a/target/s390x/translate.c b/target/s390x/translate.c
index ef751fefa4..4292bb0dd0 100644
--- a/target/s390x/translate.c
+++ b/target/s390x/translate.c
@@ -3272,13 +3272,8 @@ static DisasJumpType op_lpq(DisasContext *s, DisasOps *o)
 #ifndef CONFIG_USER_ONLY
 static DisasJumpType op_lura(DisasContext *s, DisasOps *o)
 {
-    gen_helper_lura(o->out, cpu_env, o->in2);
-    return DISAS_NEXT;
-}
-
-static DisasJumpType op_lurag(DisasContext *s, DisasOps *o)
-{
-    gen_helper_lurag(o->out, cpu_env, o->in2);
+    o->addr1 = get_address(s, 0, get_field(s->fields, r2), 0);
+    tcg_gen_qemu_ld_tl(o->out, o->addr1, MMU_REAL_IDX, s->insn->data);
     return DISAS_NEXT;
 }
 #endif
@@ -4506,17 +4501,9 @@ static DisasJumpType op_stnosm(DisasContext *s, DisasOps *o)
 
 static DisasJumpType op_stura(DisasContext *s, DisasOps *o)
 {
-    gen_helper_stura(cpu_env, o->in2, o->in1);
-    if (s->base.tb->flags & FLAG_MASK_PER) {
-        update_psw_addr(s);
-        gen_helper_per_store_real(cpu_env);
-    }
-    return DISAS_NEXT;
-}
+    o->addr1 = get_address(s, 0, get_field(s->fields, r2), 0);
+    tcg_gen_qemu_st_tl(o->in1, o->addr1, MMU_REAL_IDX, s->insn->data);
 
-static DisasJumpType op_sturg(DisasContext *s, DisasOps *o)
-{
-    gen_helper_sturg(cpu_env, o->in2, o->in1);
     if (s->base.tb->flags & FLAG_MASK_PER) {
         update_psw_addr(s);
         gen_helper_per_store_real(cpu_env);
diff --git a/target/s390x/insn-data.def b/target/s390x/insn-data.def
index 449eee1662..2bc77f0871 100644
--- a/target/s390x/insn-data.def
+++ b/target/s390x/insn-data.def
@@ -1275,8 +1275,8 @@
     F(0xe313, LRAY,    RXY_a, LD,  0, a2, r1, 0, lra, 0, IF_PRIV)
     F(0xe303, LRAG,    RXY_a, Z,   0, a2, r1, 0, lra, 0, IF_PRIV)
 /* LOAD USING REAL ADDRESS */
-    F(0xb24b, LURA,    RRE,   Z,   0, r2, new, r1_32, lura, 0, IF_PRIV)
-    F(0xb905, LURAG,   RRE,   Z,   0, r2, r1, 0, lurag, 0, IF_PRIV)
+    E(0xb24b, LURA,    RRE,   Z,   0, 0, new, r1_32, lura, 0, MO_TEUL, IF_PRIV)
+    E(0xb905, LURAG,   RRE,   Z,   0, 0, r1, 0, lura, 0, MO_TEQ, IF_PRIV)
 /* MOVE TO PRIMARY */
     F(0xda00, MVCP,    SS_d,  Z,   la1, a2, 0, 0, mvcp, 0, IF_PRIV)
 /* MOVE TO SECONDARY */
@@ -1329,8 +1329,8 @@
 /* STORE THEN OR SYSTEM MASK */
     F(0xad00, STOSM,   SI,    Z,   la1, 0, 0, 0, stnosm, 0, IF_PRIV)
 /* STORE USING REAL ADDRESS */
-    F(0xb246, STURA,   RRE,   Z,   r1_o, r2_o, 0, 0, stura, 0, IF_PRIV)
-    F(0xb925, STURG,   RRE,   Z,   r1_o, r2_o, 0, 0, sturg, 0, IF_PRIV)
+    E(0xb246, STURA,   RRE,   Z,   r1_o, 0, 0, 0, stura, 0, MO_TEUL, IF_PRIV)
+    E(0xb925, STURG,   RRE,   Z,   r1_o, 0, 0, 0, stura, 0, MO_TEQ, IF_PRIV)
 /* TEST BLOCK */
     F(0xb22c, TB,      RRE,   Z,   0, r2_o, 0, 0, testblock, 0, IF_PRIV)
 /* TEST PROTECTION */
-- 
2.20.1



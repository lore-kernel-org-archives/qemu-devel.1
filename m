Return-Path: <SRS0=JiPe=DG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74193C4727C
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 19:49:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A3D0820774
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 19:49:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="MXX4gYqi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A3D0820774
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46078 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNLdC-00062U-GZ
	for qemu-devel@archiver.kernel.org; Tue, 29 Sep 2020 15:49:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44982)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1kNKz4-00071u-QR
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 15:08:19 -0400
Received: from mail-pg1-x52d.google.com ([2607:f8b0:4864:20::52d]:37858)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1kNKz2-0002Oc-V8
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 15:08:18 -0400
Received: by mail-pg1-x52d.google.com with SMTP id e18so4651603pgd.4
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2020 12:08:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sifive.com; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=wptEmzUJ9l6jAwgVsnbsM6LITrKLuUf1j9HnvFYhI9I=;
 b=MXX4gYqi2J/ZLMiQNudt87AehaGMERE3AxZ1oxsGuCM6gweCFbAYsvsyst4fUY91Ki
 wlHhtzfj6rRHe4uKFOGkY5ReyxU5pzzO1cWuCWduwsHQRlfe95J2X0sLYihq0kYX6kV9
 w/RVpJOtlrhyjdLtqzUgO0FCOx+8Zyw6/CSM2rs7aq53kN+dq2om9hdJ9bDL+68+dp/M
 lVQFkeerfk2kp3AP3XEjsE4F1W41VPBHPI3G8V3ePayASNzL/UP0W0VNBHXVl2DhMlWT
 bPVQJtYKLzZf29iiAtCADPoV4stMNTYUjIDJWnSJ7ECQaxwy2IGuyAb783l2cy9UGQOd
 dVQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=wptEmzUJ9l6jAwgVsnbsM6LITrKLuUf1j9HnvFYhI9I=;
 b=MleE9i4HGSiJW609UTd5ueetU24AJzxmUuZXs8rO3jmoKYlopt09eMZnVUL5FBLzIK
 AkbxNX4mPmvnlcVq2Xhe2pLcNPTIfKGm94c5nsNZ1xIckfYN2LqW5uEIYEA6ZQzxk+VR
 9WiDZzhGR4Vwu2uIAav+GLrFlZUR6DXYi0N9pEc7h7J3IyrBtqyP5SEm/RW4VC+QLZeI
 T10xnS7QVtbevisXC8k8kBjAQeOJlGE0tAjzghiyzGfuqT8SYcbhv30JGvENxee6yRus
 SAF/Gv6xE/mY6EejKBVUcTqwlhz/fJgmU/GdYoflNKhY+E5LfX7P0zEjSohH/E40usfx
 gakA==
X-Gm-Message-State: AOAM532dZYF2yhZwv1LbAnFLZh/Vqf5QU/J6pwWyerdmYJGG+zChtRf9
 xwgTkSknn9NBUap5iJzmYL755m5nqvY2/A==
X-Google-Smtp-Source: ABdhPJyNOZSNIrUfbMzLXXmXHvDzA2bfE5N0Ljp69tH/+QpJAFEitdC8fxT+ix4CelWdPBSYkQVozA==
X-Received: by 2002:aa7:9522:0:b029:13c:f6b9:1c17 with SMTP id
 c2-20020aa795220000b029013cf6b91c17mr5506102pfp.11.1601406494357; 
 Tue, 29 Sep 2020 12:08:14 -0700 (PDT)
Received: from localhost.localdomain (122-116-72-36.HINET-IP.hinet.net.
 [122.116.72.36])
 by smtp.gmail.com with ESMTPSA id v8sm6003950pgg.58.2020.09.29.12.08.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2020 12:08:13 -0700 (PDT)
From: frank.chang@sifive.com
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [RFC v5 50/68] target/riscv: rvv-1.0: floating-point slide
 instructions
Date: Wed, 30 Sep 2020 03:04:25 +0800
Message-Id: <20200929190448.31116-51-frank.chang@sifive.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200929190448.31116-1-frank.chang@sifive.com>
References: <20200929190448.31116-1-frank.chang@sifive.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::52d;
 envelope-from=frank.chang@sifive.com; helo=mail-pg1-x52d.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Sagar Karandikar <sagark@eecs.berkeley.edu>,
 Frank Chang <frank.chang@sifive.com>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Richard Henderson <richard.henderson@linaro.org>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, LIU Zhiwei <zhiwei_liu@c-sky.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Frank Chang <frank.chang@sifive.com>

Add the following instructions:

* vfslide1up.vf
* vfslide1down.vf

Signed-off-by: Frank Chang <frank.chang@sifive.com>
---
 target/riscv/helper.h                   |   7 ++
 target/riscv/insn32.decode              |   2 +
 target/riscv/insn_trans/trans_rvv.c.inc |  16 +++
 target/riscv/vector_helper.c            | 141 ++++++++++++++++--------
 4 files changed, 121 insertions(+), 45 deletions(-)

diff --git a/target/riscv/helper.h b/target/riscv/helper.h
index c0109a8689..d956d73b1b 100644
--- a/target/riscv/helper.h
+++ b/target/riscv/helper.h
@@ -1121,6 +1121,13 @@ DEF_HELPER_6(vslide1down_vx_h, void, ptr, ptr, tl, ptr, env, i32)
 DEF_HELPER_6(vslide1down_vx_w, void, ptr, ptr, tl, ptr, env, i32)
 DEF_HELPER_6(vslide1down_vx_d, void, ptr, ptr, tl, ptr, env, i32)
 
+DEF_HELPER_6(vfslide1up_vf_h, void, ptr, ptr, i64, ptr, env, i32)
+DEF_HELPER_6(vfslide1up_vf_w, void, ptr, ptr, i64, ptr, env, i32)
+DEF_HELPER_6(vfslide1up_vf_d, void, ptr, ptr, i64, ptr, env, i32)
+DEF_HELPER_6(vfslide1down_vf_h, void, ptr, ptr, i64, ptr, env, i32)
+DEF_HELPER_6(vfslide1down_vf_w, void, ptr, ptr, i64, ptr, env, i32)
+DEF_HELPER_6(vfslide1down_vf_d, void, ptr, ptr, i64, ptr, env, i32)
+
 DEF_HELPER_6(vrgather_vv_b, void, ptr, ptr, ptr, ptr, env, i32)
 DEF_HELPER_6(vrgather_vv_h, void, ptr, ptr, ptr, ptr, env, i32)
 DEF_HELPER_6(vrgather_vv_w, void, ptr, ptr, ptr, ptr, env, i32)
diff --git a/target/riscv/insn32.decode b/target/riscv/insn32.decode
index c75d728fc5..7e14f7f977 100644
--- a/target/riscv/insn32.decode
+++ b/target/riscv/insn32.decode
@@ -552,6 +552,8 @@ vfsgnjn_vv      001001 . ..... ..... 001 ..... 1010111 @r_vm
 vfsgnjn_vf      001001 . ..... ..... 101 ..... 1010111 @r_vm
 vfsgnjx_vv      001010 . ..... ..... 001 ..... 1010111 @r_vm
 vfsgnjx_vf      001010 . ..... ..... 101 ..... 1010111 @r_vm
+vfslide1up_vf   001110 . ..... ..... 101 ..... 1010111 @r_vm
+vfslide1down_vf 001111 . ..... ..... 101 ..... 1010111 @r_vm
 vmfeq_vv        011000 . ..... ..... 001 ..... 1010111 @r_vm
 vmfeq_vf        011000 . ..... ..... 101 ..... 1010111 @r_vm
 vmfne_vv        011100 . ..... ..... 001 ..... 1010111 @r_vm
diff --git a/target/riscv/insn_trans/trans_rvv.c.inc b/target/riscv/insn_trans/trans_rvv.c.inc
index 5726fd7133..ac29c8f36c 100644
--- a/target/riscv/insn_trans/trans_rvv.c.inc
+++ b/target/riscv/insn_trans/trans_rvv.c.inc
@@ -3369,6 +3369,22 @@ GEN_OPIVX_TRANS(vslidedown_vx, slidedown_check)
 GEN_OPIVX_TRANS(vslide1down_vx, slidedown_check)
 GEN_OPIVI_TRANS(vslidedown_vi, IMM_ZX, vslidedown_vx, slidedown_check)
 
+/* Vector Floating-Point Slide Instructions */
+static bool fslideup_check(DisasContext *s, arg_rmrr *a)
+{
+    return slideup_check(s, a) &&
+           require_rvf(s);
+}
+
+static bool fslidedown_check(DisasContext *s, arg_rmrr *a)
+{
+    return slidedown_check(s, a) &&
+           require_rvf(s);
+}
+
+GEN_OPFVF_TRANS(vfslide1up_vf, fslideup_check)
+GEN_OPFVF_TRANS(vfslide1down_vf, fslidedown_check)
+
 /* Vector Register Gather Instruction */
 static bool vrgather_vv_check(DisasContext *s, arg_rmrr *a)
 {
diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
index fac387353f..df4f0b2d6a 100644
--- a/target/riscv/vector_helper.c
+++ b/target/riscv/vector_helper.c
@@ -4664,57 +4664,108 @@ GEN_VEXT_VSLIDEDOWN_VX(vslidedown_vx_h, uint16_t, H2)
 GEN_VEXT_VSLIDEDOWN_VX(vslidedown_vx_w, uint32_t, H4)
 GEN_VEXT_VSLIDEDOWN_VX(vslidedown_vx_d, uint64_t, H8)
 
-#define GEN_VEXT_VSLIDE1UP_VX(NAME, ETYPE, H)                             \
-void HELPER(NAME)(void *vd, void *v0, target_ulong s1, void *vs2,         \
-                  CPURISCVState *env, uint32_t desc)                      \
-{                                                                         \
-    uint32_t vm = vext_vm(desc);                                          \
-    uint32_t vl = env->vl;                                                \
-    uint32_t i;                                                           \
-                                                                          \
-    for (i = 0; i < vl; i++) {                                            \
-        if (!vm && !vext_elem_mask(v0, i)) {                              \
-            continue;                                                     \
-        }                                                                 \
-        if (i == 0) {                                                     \
-            *((ETYPE *)vd + H(i)) = s1;                                   \
-        } else {                                                          \
-            *((ETYPE *)vd + H(i)) = *((ETYPE *)vs2 + H(i - 1));           \
-        }                                                                 \
-    }                                                                     \
+#define GEN_VEXT_VSLIE1UP(ESZ, H)                                           \
+static void vslide1up_##ESZ(void *vd, void *v0, target_ulong s1, void *vs2, \
+                     CPURISCVState *env, uint32_t desc)                     \
+{                                                                           \
+    typedef uint##ESZ##_t ETYPE;                                            \
+    uint32_t vm = vext_vm(desc);                                            \
+    uint32_t vl = env->vl;                                                  \
+    uint32_t i;                                                             \
+                                                                            \
+    for (i = 0; i < vl; i++) {                                              \
+        if (!vm && !vext_elem_mask(v0, i)) {                                \
+            continue;                                                       \
+        }                                                                   \
+        if (i == 0) {                                                       \
+            *((ETYPE *)vd + H(i)) = s1;                                     \
+        } else {                                                            \
+            *((ETYPE *)vd + H(i)) = *((ETYPE *)vs2 + H(i - 1));             \
+        }                                                                   \
+    }                                                                       \
+}
+
+GEN_VEXT_VSLIE1UP(8,  H1)
+GEN_VEXT_VSLIE1UP(16, H2)
+GEN_VEXT_VSLIE1UP(32, H4)
+GEN_VEXT_VSLIE1UP(64, H8)
+
+#define GEN_VEXT_VSLIDE1UP_VX(NAME, ESZ)                          \
+void HELPER(NAME)(void *vd, void *v0, target_ulong s1, void *vs2, \
+                  CPURISCVState *env, uint32_t desc)              \
+{                                                                 \
+    vslide1up_##ESZ(vd, v0, s1, vs2, env, desc);                  \
 }
 
 /* vslide1up.vx vd, vs2, rs1, vm # vd[0]=x[rs1], vd[i+1] = vs2[i] */
-GEN_VEXT_VSLIDE1UP_VX(vslide1up_vx_b, uint8_t,  H1)
-GEN_VEXT_VSLIDE1UP_VX(vslide1up_vx_h, uint16_t, H2)
-GEN_VEXT_VSLIDE1UP_VX(vslide1up_vx_w, uint32_t, H4)
-GEN_VEXT_VSLIDE1UP_VX(vslide1up_vx_d, uint64_t, H8)
-
-#define GEN_VEXT_VSLIDE1DOWN_VX(NAME, ETYPE, H)                           \
-void HELPER(NAME)(void *vd, void *v0, target_ulong s1, void *vs2,         \
-                  CPURISCVState *env, uint32_t desc)                      \
-{                                                                         \
-    uint32_t vm = vext_vm(desc);                                          \
-    uint32_t vl = env->vl;                                                \
-    uint32_t i;                                                           \
-                                                                          \
-    for (i = 0; i < vl; i++) {                                            \
-        if (!vm && !vext_elem_mask(v0, i)) {                              \
-            continue;                                                     \
-        }                                                                 \
-        if (i == vl - 1) {                                                \
-            *((ETYPE *)vd + H(i)) = s1;                                   \
-        } else {                                                          \
-            *((ETYPE *)vd + H(i)) = *((ETYPE *)vs2 + H(i + 1));           \
-        }                                                                 \
-    }                                                                     \
+GEN_VEXT_VSLIDE1UP_VX(vslide1up_vx_b, 8)
+GEN_VEXT_VSLIDE1UP_VX(vslide1up_vx_h, 16)
+GEN_VEXT_VSLIDE1UP_VX(vslide1up_vx_w, 32)
+GEN_VEXT_VSLIDE1UP_VX(vslide1up_vx_d, 64)
+
+#define GEN_VEXT_VSLIDE1DOWN(ESZ, H)                                          \
+static void vslide1down_##ESZ(void *vd, void *v0, target_ulong s1, void *vs2, \
+                       CPURISCVState *env, uint32_t desc)                     \
+{                                                                             \
+    typedef uint##ESZ##_t ETYPE;                                              \
+    uint32_t vm = vext_vm(desc);                                              \
+    uint32_t vl = env->vl;                                                    \
+    uint32_t i;                                                               \
+                                                                              \
+    for (i = 0; i < vl; i++) {                                                \
+        if (!vm && !vext_elem_mask(v0, i)) {                                  \
+            continue;                                                         \
+        }                                                                     \
+        if (i == vl - 1) {                                                    \
+            *((ETYPE *)vd + H(i)) = s1;                                       \
+        } else {                                                              \
+            *((ETYPE *)vd + H(i)) = *((ETYPE *)vs2 + H(i + 1));               \
+        }                                                                     \
+    }                                                                         \
+}
+
+GEN_VEXT_VSLIDE1DOWN(8,  H1)
+GEN_VEXT_VSLIDE1DOWN(16, H2)
+GEN_VEXT_VSLIDE1DOWN(32, H4)
+GEN_VEXT_VSLIDE1DOWN(64, H8)
+
+#define GEN_VEXT_VSLIDE1DOWN_VX(NAME, ESZ)                        \
+void HELPER(NAME)(void *vd, void *v0, target_ulong s1, void *vs2, \
+                  CPURISCVState *env, uint32_t desc)              \
+{                                                                 \
+    vslide1down_##ESZ(vd, v0, s1, vs2, env, desc);                \
 }
 
 /* vslide1down.vx vd, vs2, rs1, vm # vd[i] = vs2[i+1], vd[vl-1]=x[rs1] */
-GEN_VEXT_VSLIDE1DOWN_VX(vslide1down_vx_b, uint8_t,  H1)
-GEN_VEXT_VSLIDE1DOWN_VX(vslide1down_vx_h, uint16_t, H2)
-GEN_VEXT_VSLIDE1DOWN_VX(vslide1down_vx_w, uint32_t, H4)
-GEN_VEXT_VSLIDE1DOWN_VX(vslide1down_vx_d, uint64_t, H8)
+GEN_VEXT_VSLIDE1DOWN_VX(vslide1down_vx_b, 8)
+GEN_VEXT_VSLIDE1DOWN_VX(vslide1down_vx_h, 16)
+GEN_VEXT_VSLIDE1DOWN_VX(vslide1down_vx_w, 32)
+GEN_VEXT_VSLIDE1DOWN_VX(vslide1down_vx_d, 64)
+
+/* Vector Floating-Point Slide Instructions */
+#define GEN_VEXT_VFSLIDE1UP_VF(NAME, ESZ)                     \
+void HELPER(NAME)(void *vd, void *v0, uint64_t s1, void *vs2, \
+                  CPURISCVState *env, uint32_t desc)          \
+{                                                             \
+    vslide1up_##ESZ(vd, v0, s1, vs2, env, desc);              \
+}
+
+/* vfslide1up.vf vd, vs2, rs1, vm # vd[0]=f[rs1], vd[i+1] = vs2[i] */
+GEN_VEXT_VFSLIDE1UP_VF(vfslide1up_vf_h, 16)
+GEN_VEXT_VFSLIDE1UP_VF(vfslide1up_vf_w, 32)
+GEN_VEXT_VFSLIDE1UP_VF(vfslide1up_vf_d, 64)
+
+#define GEN_VEXT_VFSLIDE1DOWN_VF(NAME, ESZ)                   \
+void HELPER(NAME)(void *vd, void *v0, uint64_t s1, void *vs2, \
+                  CPURISCVState *env, uint32_t desc)          \
+{                                                             \
+    vslide1down_##ESZ(vd, v0, s1, vs2, env, desc);            \
+}
+
+/* vfslide1down.vf vd, vs2, rs1, vm # vd[i] = vs2[i+1], vd[vl-1]=f[rs1] */
+GEN_VEXT_VFSLIDE1DOWN_VF(vfslide1down_vf_h, 16)
+GEN_VEXT_VFSLIDE1DOWN_VF(vfslide1down_vf_w, 32)
+GEN_VEXT_VFSLIDE1DOWN_VF(vfslide1down_vf_d, 64)
 
 /* Vector Register Gather Instruction */
 #define GEN_VEXT_VRGATHER_VV(NAME, TS1, TS2, HS1, HS2)                    \
-- 
2.17.1



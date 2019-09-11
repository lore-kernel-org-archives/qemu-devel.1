Return-Path: <SRS0=l4AY=XG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56312ECDE28
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2019 06:55:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F38FD21A4C
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2019 06:55:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F38FD21A4C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-sky.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47058 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i7wXa-000491-Cx
	for qemu-devel@archiver.kernel.org; Wed, 11 Sep 2019 02:55:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38678)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <zhiwei_liu@c-sky.com>) id 1i7wE5-0007lo-61
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 02:35:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <zhiwei_liu@c-sky.com>) id 1i7wDu-00087t-Bw
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 02:35:37 -0400
Received: from smtp2200-217.mail.aliyun.com ([121.197.200.217]:47996)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <zhiwei_liu@c-sky.com>)
 id 1i7wDs-0007oG-Fk; Wed, 11 Sep 2019 02:35:26 -0400
X-Alimail-AntiSpam: AC=CONTINUE; BC=0.03883426|-1; CH=green;
 DM=CONTINUE|CONTINUE|true|0.216564-0.00369968-0.779736; FP=0|0|0|0|0|-1|-1|-1;
 HT=e02c03306; MF=zhiwei_liu@c-sky.com; NM=1; PH=DS; RN=11; RT=11; SR=0;
 TI=SMTPD_---.FSRTjs0_1568183699; 
Received: from localhost(mailfrom:zhiwei_liu@c-sky.com
 fp:SMTPD_---.FSRTjs0_1568183699)
 by smtp.aliyun-inc.com(10.147.42.253);
 Wed, 11 Sep 2019 14:34:59 +0800
From: liuzhiwei <zhiwei_liu@c-sky.com>
To: Alistair.Francis@wdc.com, palmer@sifive.com, sagark@eecs.berkeley.edu,
 kbastian@mail.uni-paderborn.de, riku.voipio@iki.fi, laurent@vivier.eu,
 wenmeng_zhang@c-sky.com
Date: Wed, 11 Sep 2019 14:25:36 +0800
Message-Id: <1568183141-67641-13-git-send-email-zhiwei_liu@c-sky.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1568183141-67641-1-git-send-email-zhiwei_liu@c-sky.com>
References: <1568183141-67641-1-git-send-email-zhiwei_liu@c-sky.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 121.197.200.217
Subject: [Qemu-devel] [PATCH v2 12/17] RISC-V: add vector extension fixed
 point instructions
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
Cc: qemu-riscv@nongnu.org, qemu-devel@nongnu.org, wxy194768@alibaba-inc.com,
 LIU Zhiwei <zhiwei_liu@c-sky.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: LIU Zhiwei <zhiwei_liu@c-sky.com>

Signed-off-by: LIU Zhiwei <zhiwei_liu@c-sky.com>
---
 target/riscv/helper.h                   |   37 +
 target/riscv/insn32.decode              |   37 +
 target/riscv/insn_trans/trans_rvv.inc.c |   37 +
 target/riscv/vector_helper.c            | 3388 +++++++++++++++++++++++++++++++
 4 files changed, 3499 insertions(+)

diff --git a/target/riscv/helper.h b/target/riscv/helper.h
index ab31ef7..ff6002e 100644
--- a/target/riscv/helper.h
+++ b/target/riscv/helper.h
@@ -270,5 +270,42 @@ DEF_HELPER_5(vector_vmerge_vvm, void, env, i32, i32, i32, i32)
 DEF_HELPER_5(vector_vmerge_vxm, void, env, i32, i32, i32, i32)
 DEF_HELPER_5(vector_vmerge_vim, void, env, i32, i32, i32, i32)
 
+DEF_HELPER_5(vector_vsaddu_vv, void, env, i32, i32, i32, i32)
+DEF_HELPER_5(vector_vsaddu_vx, void, env, i32, i32, i32, i32)
+DEF_HELPER_5(vector_vsaddu_vi, void, env, i32, i32, i32, i32)
+DEF_HELPER_5(vector_vsadd_vv, void, env, i32, i32, i32, i32)
+DEF_HELPER_5(vector_vsadd_vx, void, env, i32, i32, i32, i32)
+DEF_HELPER_5(vector_vsadd_vi, void, env, i32, i32, i32, i32)
+DEF_HELPER_5(vector_vssubu_vv, void, env, i32, i32, i32, i32)
+DEF_HELPER_5(vector_vssubu_vx, void, env, i32, i32, i32, i32)
+DEF_HELPER_5(vector_vssub_vv, void, env, i32, i32, i32, i32)
+DEF_HELPER_5(vector_vssub_vx, void, env, i32, i32, i32, i32)
+DEF_HELPER_5(vector_vaadd_vv, void, env, i32, i32, i32, i32)
+DEF_HELPER_5(vector_vaadd_vx, void, env, i32, i32, i32, i32)
+DEF_HELPER_5(vector_vaadd_vi, void, env, i32, i32, i32, i32)
+DEF_HELPER_5(vector_vasub_vv, void, env, i32, i32, i32, i32)
+DEF_HELPER_5(vector_vasub_vx, void, env, i32, i32, i32, i32)
+DEF_HELPER_5(vector_vsmul_vv, void, env, i32, i32, i32, i32)
+DEF_HELPER_5(vector_vsmul_vx, void, env, i32, i32, i32, i32)
+DEF_HELPER_5(vector_vwsmaccu_vv, void, env, i32, i32, i32, i32)
+DEF_HELPER_5(vector_vwsmaccu_vx, void, env, i32, i32, i32, i32)
+DEF_HELPER_5(vector_vwsmacc_vv, void, env, i32, i32, i32, i32)
+DEF_HELPER_5(vector_vwsmacc_vx, void, env, i32, i32, i32, i32)
+DEF_HELPER_5(vector_vwsmaccsu_vv, void, env, i32, i32, i32, i32)
+DEF_HELPER_5(vector_vwsmaccsu_vx, void, env, i32, i32, i32, i32)
+DEF_HELPER_5(vector_vwsmaccus_vx, void, env, i32, i32, i32, i32)
+DEF_HELPER_5(vector_vssrl_vv, void, env, i32, i32, i32, i32)
+DEF_HELPER_5(vector_vssrl_vx, void, env, i32, i32, i32, i32)
+DEF_HELPER_5(vector_vssrl_vi, void, env, i32, i32, i32, i32)
+DEF_HELPER_5(vector_vssra_vv, void, env, i32, i32, i32, i32)
+DEF_HELPER_5(vector_vssra_vx, void, env, i32, i32, i32, i32)
+DEF_HELPER_5(vector_vssra_vi, void, env, i32, i32, i32, i32)
+DEF_HELPER_5(vector_vnclipu_vv, void, env, i32, i32, i32, i32)
+DEF_HELPER_5(vector_vnclipu_vx, void, env, i32, i32, i32, i32)
+DEF_HELPER_5(vector_vnclipu_vi, void, env, i32, i32, i32, i32)
+DEF_HELPER_5(vector_vnclip_vv, void, env, i32, i32, i32, i32)
+DEF_HELPER_5(vector_vnclip_vx, void, env, i32, i32, i32, i32)
+DEF_HELPER_5(vector_vnclip_vi, void, env, i32, i32, i32, i32)
+
 DEF_HELPER_4(vector_vsetvli, void, env, i32, i32, i32)
 DEF_HELPER_4(vector_vsetvl, void, env, i32, i32, i32)
diff --git a/target/riscv/insn32.decode b/target/riscv/insn32.decode
index 6db18c5..a82e53e 100644
--- a/target/riscv/insn32.decode
+++ b/target/riscv/insn32.decode
@@ -410,5 +410,42 @@ vmerge_vvm      010111 . ..... ..... 000 ..... 1010111 @r_vm
 vmerge_vxm      010111 . ..... ..... 100 ..... 1010111 @r_vm
 vmerge_vim      010111 . ..... ..... 011 ..... 1010111 @r_vm
 
+vsaddu_vv       100000 . ..... ..... 000 ..... 1010111 @r_vm
+vsaddu_vx       100000 . ..... ..... 100 ..... 1010111 @r_vm
+vsaddu_vi       100000 . ..... ..... 011 ..... 1010111 @r_vm
+vsadd_vv        100001 . ..... ..... 000 ..... 1010111 @r_vm
+vsadd_vx        100001 . ..... ..... 100 ..... 1010111 @r_vm
+vsadd_vi        100001 . ..... ..... 011 ..... 1010111 @r_vm
+vssubu_vv       100010 . ..... ..... 000 ..... 1010111 @r_vm
+vssubu_vx       100010 . ..... ..... 100 ..... 1010111 @r_vm
+vssub_vv        100011 . ..... ..... 000 ..... 1010111 @r_vm
+vssub_vx        100011 . ..... ..... 100 ..... 1010111 @r_vm
+vaadd_vv        100100 . ..... ..... 000 ..... 1010111 @r_vm
+vaadd_vx        100100 . ..... ..... 100 ..... 1010111 @r_vm
+vaadd_vi        100100 . ..... ..... 011 ..... 1010111 @r_vm
+vasub_vv        100110 . ..... ..... 000 ..... 1010111 @r_vm
+vasub_vx        100110 . ..... ..... 100 ..... 1010111 @r_vm
+vsmul_vv        100111 . ..... ..... 000 ..... 1010111 @r_vm
+vsmul_vx        100111 . ..... ..... 100 ..... 1010111 @r_vm
+vwsmaccu_vv     111100 . ..... ..... 000 ..... 1010111 @r_vm
+vwsmaccu_vx     111100 . ..... ..... 100 ..... 1010111 @r_vm
+vwsmacc_vv      111101 . ..... ..... 000 ..... 1010111 @r_vm
+vwsmacc_vx      111101 . ..... ..... 100 ..... 1010111 @r_vm
+vwsmaccsu_vv    111110 . ..... ..... 000 ..... 1010111 @r_vm
+vwsmaccsu_vx    111110 . ..... ..... 100 ..... 1010111 @r_vm
+vwsmaccus_vx    111111 . ..... ..... 100 ..... 1010111 @r_vm
+vssrl_vv        101010 . ..... ..... 000 ..... 1010111 @r_vm
+vssrl_vx        101010 . ..... ..... 100 ..... 1010111 @r_vm
+vssrl_vi        101010 . ..... ..... 011 ..... 1010111 @r_vm
+vssra_vv        101011 . ..... ..... 000 ..... 1010111 @r_vm
+vssra_vx        101011 . ..... ..... 100 ..... 1010111 @r_vm
+vssra_vi        101011 . ..... ..... 011 ..... 1010111 @r_vm
+vnclipu_vv      101110 . ..... ..... 000 ..... 1010111 @r_vm
+vnclipu_vx      101110 . ..... ..... 100 ..... 1010111 @r_vm
+vnclipu_vi      101110 . ..... ..... 011 ..... 1010111 @r_vm
+vnclip_vv       101111 . ..... ..... 000 ..... 1010111 @r_vm
+vnclip_vx       101111 . ..... ..... 100 ..... 1010111 @r_vm
+vnclip_vi       101111 . ..... ..... 011 ..... 1010111 @r_vm
+
 vsetvli         0 ........... ..... 111 ..... 1010111  @r2_zimm
 vsetvl          1000000 ..... ..... 111 ..... 1010111  @r
diff --git a/target/riscv/insn_trans/trans_rvv.inc.c b/target/riscv/insn_trans/trans_rvv.inc.c
index 1ba52e7..d650e8c 100644
--- a/target/riscv/insn_trans/trans_rvv.inc.c
+++ b/target/riscv/insn_trans/trans_rvv.inc.c
@@ -299,5 +299,42 @@ GEN_VECTOR_R_VM(vmerge_vvm)
 GEN_VECTOR_R_VM(vmerge_vxm)
 GEN_VECTOR_R_VM(vmerge_vim)
 
+GEN_VECTOR_R_VM(vsaddu_vv)
+GEN_VECTOR_R_VM(vsaddu_vx)
+GEN_VECTOR_R_VM(vsaddu_vi)
+GEN_VECTOR_R_VM(vsadd_vv)
+GEN_VECTOR_R_VM(vsadd_vx)
+GEN_VECTOR_R_VM(vsadd_vi)
+GEN_VECTOR_R_VM(vssubu_vv)
+GEN_VECTOR_R_VM(vssubu_vx)
+GEN_VECTOR_R_VM(vssub_vv)
+GEN_VECTOR_R_VM(vssub_vx)
+GEN_VECTOR_R_VM(vaadd_vv)
+GEN_VECTOR_R_VM(vaadd_vx)
+GEN_VECTOR_R_VM(vaadd_vi)
+GEN_VECTOR_R_VM(vasub_vv)
+GEN_VECTOR_R_VM(vasub_vx)
+GEN_VECTOR_R_VM(vsmul_vv)
+GEN_VECTOR_R_VM(vsmul_vx)
+GEN_VECTOR_R_VM(vwsmaccu_vv)
+GEN_VECTOR_R_VM(vwsmaccu_vx)
+GEN_VECTOR_R_VM(vwsmacc_vv)
+GEN_VECTOR_R_VM(vwsmacc_vx)
+GEN_VECTOR_R_VM(vwsmaccsu_vv)
+GEN_VECTOR_R_VM(vwsmaccsu_vx)
+GEN_VECTOR_R_VM(vwsmaccus_vx)
+GEN_VECTOR_R_VM(vssrl_vv)
+GEN_VECTOR_R_VM(vssrl_vx)
+GEN_VECTOR_R_VM(vssrl_vi)
+GEN_VECTOR_R_VM(vssra_vv)
+GEN_VECTOR_R_VM(vssra_vx)
+GEN_VECTOR_R_VM(vssra_vi)
+GEN_VECTOR_R_VM(vnclipu_vv)
+GEN_VECTOR_R_VM(vnclipu_vx)
+GEN_VECTOR_R_VM(vnclipu_vi)
+GEN_VECTOR_R_VM(vnclip_vv)
+GEN_VECTOR_R_VM(vnclip_vx)
+GEN_VECTOR_R_VM(vnclip_vi)
+
 GEN_VECTOR_R2_ZIMM(vsetvli)
 GEN_VECTOR_R(vsetvl)
diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
index 49f1cb8..2292fa5 100644
--- a/target/riscv/vector_helper.c
+++ b/target/riscv/vector_helper.c
@@ -75,6 +75,844 @@ static target_ulong vector_get_index(CPURISCVState *env, int rs1, int rs2,
     return 0;
 }
 
+/* ADD/SUB/COMPARE instructions. */
+static inline uint8_t sat_add_u8(CPURISCVState *env, uint8_t a, uint8_t b)
+{
+    uint8_t res = a + b;
+    if (res < a) {
+        res = UINT8_MAX;
+        env->vfp.vxsat = 0x1;
+    }
+    return res;
+}
+
+static inline uint16_t sat_add_u16(CPURISCVState *env, uint16_t a, uint16_t b)
+{
+    uint16_t res = a + b;
+    if (res < a) {
+        res = UINT16_MAX;
+        env->vfp.vxsat = 0x1;
+    }
+    return res;
+}
+
+static inline uint32_t sat_add_u32(CPURISCVState *env, uint32_t a, uint32_t b)
+{
+    uint32_t res = a + b;
+    if (res < a) {
+        res = UINT32_MAX;
+        env->vfp.vxsat = 0x1;
+    }
+    return res;
+}
+
+static inline uint64_t sat_add_u64(CPURISCVState *env, uint64_t a, uint64_t b)
+{
+    uint64_t res = a + b;
+    if (res < a) {
+        res = UINT64_MAX;
+        env->vfp.vxsat = 0x1;
+    }
+    return res;
+}
+
+static inline uint8_t sat_add_s8(CPURISCVState *env, uint8_t a, uint8_t b)
+{
+    uint8_t res = a + b;
+    if (((res ^ a) & SIGNBIT8) && !((a ^ b) & SIGNBIT8)) {
+        res = ~(((int8_t)a >> 7) ^ SIGNBIT8);
+        env->vfp.vxsat = 0x1;
+    }
+    return res;
+}
+
+static inline uint16_t sat_add_s16(CPURISCVState *env, uint16_t a, uint16_t b)
+{
+    uint16_t res = a + b;
+    if (((res ^ a) & SIGNBIT16) && !((a ^ b) & SIGNBIT16)) {
+        res = ~(((int16_t)a >> 15) ^ SIGNBIT16);
+        env->vfp.vxsat = 0x1;
+    }
+    return res;
+}
+
+static inline uint32_t sat_add_s32(CPURISCVState *env, uint32_t a, uint32_t b)
+{
+    uint32_t res = a + b;
+    if (((res ^ a) & SIGNBIT32) && !((a ^ b) & SIGNBIT32)) {
+        res = ~(((int32_t)a >> 31) ^ SIGNBIT32);
+        env->vfp.vxsat = 0x1;
+    }
+    return res;
+}
+
+static inline uint64_t sat_add_s64(CPURISCVState *env, uint64_t a, uint64_t b)
+{
+    uint64_t res = a + b;
+    if (((res ^ a) & SIGNBIT64) && !((a ^ b) & SIGNBIT64)) {
+        res = ~(((int64_t)a >> 63) ^ SIGNBIT64);
+        env->vfp.vxsat = 0x1;
+    }
+    return res;
+}
+
+static inline uint8_t sat_sub_u8(CPURISCVState *env, uint8_t a, uint8_t b)
+{
+    uint8_t res = a - b;
+    if (res > a) {
+        res = 0;
+        env->vfp.vxsat = 0x1;
+    }
+    return res;
+}
+
+static inline uint16_t sat_sub_u16(CPURISCVState *env, uint16_t a, uint16_t b)
+{
+    uint16_t res = a - b;
+    if (res > a) {
+        res = 0;
+        env->vfp.vxsat = 0x1;
+    }
+    return res;
+}
+
+static inline uint32_t sat_sub_u32(CPURISCVState *env, uint32_t a, uint32_t b)
+{
+    uint32_t res = a - b;
+    if (res > a) {
+        res = 0;
+        env->vfp.vxsat = 0x1;
+    }
+    return res;
+}
+
+static inline uint64_t sat_sub_u64(CPURISCVState *env, uint64_t a, uint64_t b)
+{
+    uint64_t res = a - b;
+    if (res > a) {
+        res = 0;
+        env->vfp.vxsat = 0x1;
+    }
+    return res;
+}
+
+static inline uint8_t sat_sub_s8(CPURISCVState *env, uint8_t a, uint8_t b)
+{
+    uint8_t res = a - b;
+    if (((res ^ a) & SIGNBIT8) && ((a ^ b) & SIGNBIT8)) {
+        res = ~(((int8_t)a >> 7) ^ SIGNBIT8);
+        env->vfp.vxsat = 0x1;
+    }
+    return res;
+}
+
+static inline uint16_t sat_sub_s16(CPURISCVState *env, uint16_t a, uint16_t b)
+{
+    uint16_t res = a - b;
+    if (((res ^ a) & SIGNBIT16) && ((a ^ b) & SIGNBIT16)) {
+        res = ~(((int16_t)a >> 15) ^ SIGNBIT16);
+        env->vfp.vxsat = 0x1;
+    }
+    return res;
+}
+
+static inline uint32_t sat_sub_s32(CPURISCVState *env, uint32_t a, uint32_t b)
+{
+    uint32_t res = a - b;
+    if (((res ^ a) & SIGNBIT32) && ((a ^ b) & SIGNBIT32)) {
+        res = ~(((int32_t)a >> 31) ^ SIGNBIT32);
+        env->vfp.vxsat = 0x1;
+    }
+    return res;
+}
+
+static inline uint64_t sat_sub_s64(CPURISCVState *env, uint64_t a, uint64_t b)
+{
+    uint64_t res = a - b;
+    if (((res ^ a) & SIGNBIT64) && ((a ^ b) & SIGNBIT64)) {
+        res = ~(((int64_t)a >> 63) ^ SIGNBIT64);
+        env->vfp.vxsat = 0x1;
+    }
+    return res;
+}
+
+static uint64_t fix_data_round(CPURISCVState *env, uint64_t result,
+        uint8_t shift)
+{
+    uint64_t lsb_1 = (uint64_t)1 << shift;
+    int mod   = env->vfp.vxrm;
+    int mask  = ((uint64_t)1 << shift) - 1;
+
+    if (mod == 0x0) { /* rnu */
+        return lsb_1 >> 1;
+    } else if (mod == 0x1) { /* rne */
+        if ((result & mask) > (lsb_1 >> 1) ||
+                (((result & mask) == (lsb_1 >> 1)) &&
+                 (((result >> shift) & 0x1)) == 1)) {
+            return lsb_1 >> 1;
+        }
+    } else if (mod == 0x3) { /* rod */
+        if (((result & mask) >= 0x1) && (((result >> shift) & 0x1) == 0)) {
+            return lsb_1;
+        }
+    }
+    return 0;
+}
+
+static int8_t saturate_s8(CPURISCVState *env, int16_t res)
+{
+    if (res > INT8_MAX) {
+        env->vfp.vxsat = 0x1;
+        return INT8_MAX;
+    } else if (res < INT8_MIN) {
+        env->vfp.vxsat = 0x1;
+        return INT8_MIN;
+    } else {
+        return res;
+    }
+}
+
+static uint8_t saturate_u8(CPURISCVState *env, uint16_t res)
+{
+    if (res > UINT8_MAX) {
+        env->vfp.vxsat = 0x1;
+        return UINT8_MAX;
+    } else {
+        return res;
+    }
+}
+
+static uint16_t saturate_u16(CPURISCVState *env, uint32_t res)
+{
+    if (res > UINT16_MAX) {
+        env->vfp.vxsat = 0x1;
+        return UINT16_MAX;
+    } else {
+        return res;
+    }
+}
+
+static uint32_t saturate_u32(CPURISCVState *env, uint64_t res)
+{
+    if (res > UINT32_MAX) {
+        env->vfp.vxsat = 0x1;
+        return UINT32_MAX;
+    } else {
+        return res;
+    }
+}
+
+static int16_t saturate_s16(CPURISCVState *env, int32_t res)
+{
+    if (res > INT16_MAX) {
+        env->vfp.vxsat = 0x1;
+        return INT16_MAX;
+    } else if (res < INT16_MIN) {
+        env->vfp.vxsat = 0x1;
+        return INT16_MIN;
+    } else {
+        return res;
+    }
+}
+
+static int32_t saturate_s32(CPURISCVState *env, int64_t res)
+{
+    if (res > INT32_MAX) {
+        env->vfp.vxsat = 0x1;
+        return INT32_MAX;
+    } else if (res < INT32_MIN) {
+        env->vfp.vxsat = 0x1;
+        return INT32_MIN;
+    } else {
+        return res;
+    }
+}
+static uint16_t vwsmaccu_8(CPURISCVState *env, uint8_t a, uint8_t b,
+    uint16_t c)
+{
+    uint16_t round, res;
+    uint16_t product = (uint16_t)a * (uint16_t)b;
+
+    round = (uint16_t)fix_data_round(env, (uint64_t)product, 4);
+    res   = (round + product) >> 4;
+    return sat_add_u16(env, c, res);
+}
+
+static uint32_t vwsmaccu_16(CPURISCVState *env, uint16_t a, uint16_t b,
+    uint32_t c)
+{
+    uint32_t round, res;
+    uint32_t product = (uint32_t)a * (uint32_t)b;
+
+    round = (uint32_t)fix_data_round(env, (uint64_t)product, 8);
+    res   = (round + product) >> 8;
+    return sat_add_u32(env, c, res);
+}
+
+static uint64_t vwsmaccu_32(CPURISCVState *env, uint32_t a, uint32_t b,
+    uint64_t c)
+{
+    uint64_t round, res;
+    uint64_t product = (uint64_t)a * (uint64_t)b;
+
+    round = (uint64_t)fix_data_round(env, (uint64_t)product, 16);
+    res   = (round + product) >> 16;
+    return sat_add_u64(env, c, res);
+}
+
+static int16_t vwsmacc_8(CPURISCVState *env, int8_t a, int8_t b,
+    int16_t c)
+{
+    int16_t round, res;
+    int16_t product = (int16_t)a * (int16_t)b;
+
+    round = (int16_t)fix_data_round(env, (uint64_t)product, 4);
+    res   = (int16_t)(round + product) >> 4;
+    return sat_add_s16(env, c, res);
+}
+
+static int32_t vwsmacc_16(CPURISCVState *env, int16_t a, int16_t b,
+    int32_t c)
+{
+    int32_t round, res;
+    int32_t product = (int32_t)a * (int32_t)b;
+
+    round = (int32_t)fix_data_round(env, (uint64_t)product, 8);
+    res   = (int32_t)(round + product) >> 8;
+    return sat_add_s32(env, c, res);
+}
+
+static int64_t vwsmacc_32(CPURISCVState *env, int32_t a, int32_t b,
+    int64_t c)
+{
+    int64_t round, res;
+    int64_t product = (int64_t)a * (int64_t)b;
+
+    round = (int64_t)fix_data_round(env, (uint64_t)product, 16);
+    res   = (int64_t)(round + product) >> 16;
+    return sat_add_s64(env, c, res);
+}
+
+static int16_t vwsmaccsu_8(CPURISCVState *env, uint8_t a, int8_t b,
+    int16_t c)
+{
+    int16_t round, res;
+    int16_t product = (uint16_t)a * (int16_t)b;
+
+    round = (int16_t)fix_data_round(env, (uint64_t)product, 4);
+    res   =  (round + product) >> 4;
+    return sat_sub_s16(env, c, res);
+}
+
+static int32_t vwsmaccsu_16(CPURISCVState *env, uint16_t a, int16_t b,
+    uint32_t c)
+{
+    int32_t round, res;
+    int32_t product = (uint32_t)a * (int32_t)b;
+
+    round = (int32_t)fix_data_round(env, (uint64_t)product, 8);
+    res   = (round + product) >> 8;
+    return sat_sub_s32(env, c, res);
+}
+
+static int64_t vwsmaccsu_32(CPURISCVState *env, uint32_t a, int32_t b,
+    int64_t c)
+{
+    int64_t round, res;
+    int64_t product = (uint64_t)a * (int64_t)b;
+
+    round = (int64_t)fix_data_round(env, (uint64_t)product, 16);
+    res   = (round + product) >> 16;
+    return sat_sub_s64(env, c, res);
+}
+
+static int16_t vwsmaccus_8(CPURISCVState *env, int8_t a, uint8_t b,
+    int16_t c)
+{
+    int16_t round, res;
+    int16_t product = (int16_t)a * (uint16_t)b;
+
+    round = (int16_t)fix_data_round(env, (uint64_t)product, 4);
+    res   = (round + product) >> 4;
+    return sat_sub_s16(env, c, res);
+}
+
+static int32_t vwsmaccus_16(CPURISCVState *env, int16_t a, uint16_t b,
+    int32_t c)
+{
+    int32_t round, res;
+    int32_t product = (int32_t)a * (uint32_t)b;
+
+    round = (int32_t)fix_data_round(env, (uint64_t)product, 8);
+    res   = (round + product) >> 8;
+    return sat_sub_s32(env, c, res);
+}
+
+static uint64_t vwsmaccus_32(CPURISCVState *env, int32_t a, uint32_t b,
+    int64_t c)
+{
+    int64_t round, res;
+    int64_t product = (int64_t)a * (uint64_t)b;
+
+    round = (int64_t)fix_data_round(env, (uint64_t)product, 16);
+    res   = (round + product) >> 16;
+    return sat_sub_s64(env, c, res);
+}
+
+static int8_t vssra_8(CPURISCVState *env, int8_t a, uint8_t b)
+{
+    int16_t round, res;
+    uint8_t shift = b & 0x7;
+
+    round = (int16_t)fix_data_round(env, (uint64_t)a, shift);
+    res   = (a + round) >> shift;
+
+    return res;
+}
+
+static int16_t vssra_16(CPURISCVState *env, int16_t a, uint16_t b)
+{
+    int32_t round, res;
+    uint8_t shift = b & 0xf;
+
+    round = (int32_t)fix_data_round(env, (uint64_t)a, shift);
+    res   = (a + round) >> shift;
+    return res;
+}
+
+static int32_t vssra_32(CPURISCVState *env, int32_t a, uint32_t b)
+{
+    int64_t round, res;
+    uint8_t shift = b & 0x1f;
+
+    round = (int64_t)fix_data_round(env, (uint64_t)a, shift);
+    res   = (a + round) >> shift;
+    return res;
+}
+
+static int64_t vssra_64(CPURISCVState *env, int64_t a, uint64_t b)
+{
+    int64_t round, res;
+    uint8_t shift = b & 0x3f;
+
+    round = (int64_t)fix_data_round(env, (uint64_t)a, shift);
+    res   = (a >> (shift - 1))  + (round >> (shift - 1));
+    return res >> 1;
+}
+
+static int8_t vssrai_8(CPURISCVState *env, int8_t a, uint8_t b)
+{
+    int16_t round, res;
+
+    round = (int16_t)fix_data_round(env, (uint64_t)a, b);
+    res   = (a + round) >> b;
+    return res;
+}
+
+static int16_t vssrai_16(CPURISCVState *env, int16_t a, uint8_t b)
+{
+    int32_t round, res;
+
+    round = (int32_t)fix_data_round(env, (uint64_t)a, b);
+    res   = (a + round) >> b;
+    return res;
+}
+
+static int32_t vssrai_32(CPURISCVState *env, int32_t a, uint8_t b)
+{
+    int64_t round, res;
+
+    round = (int64_t)fix_data_round(env, (uint64_t)a, b);
+    res   = (a + round) >> b;
+    return res;
+}
+
+static int64_t vssrai_64(CPURISCVState *env, int64_t a, uint8_t b)
+{
+    int64_t round, res;
+
+    round = (int64_t)fix_data_round(env, (uint64_t)a, b);
+    res   = (a >> (b - 1))  + (round >> (b - 1));
+    return res >> 1;
+}
+
+static int8_t vnclip_16(CPURISCVState *env, int16_t a, uint8_t b)
+{
+    int16_t round, res;
+    uint8_t shift = b & 0xf;
+
+    round = (int16_t)fix_data_round(env, (uint64_t)a, shift);
+    res   = (a + round) >> shift;
+
+    return saturate_s8(env, res);
+}
+
+static int16_t vnclip_32(CPURISCVState *env, int32_t a, uint16_t b)
+{
+    int32_t round, res;
+    uint8_t shift = b & 0x1f;
+
+    round = (int32_t)fix_data_round(env, (uint64_t)a, shift);
+    res   = (a + round) >> shift;
+    return saturate_s16(env, res);
+}
+
+static int32_t vnclip_64(CPURISCVState *env, int64_t a, uint32_t b)
+{
+    int64_t round, res;
+    uint8_t shift = b & 0x3f;
+
+    round = (int64_t)fix_data_round(env, (uint64_t)a, shift);
+    res   = (a + round) >> shift;
+
+    return saturate_s32(env, res);
+}
+
+static int8_t vnclipi_16(CPURISCVState *env, int16_t a, uint8_t b)
+{
+    int16_t round, res;
+
+    round = (int16_t)fix_data_round(env, (uint64_t)a, b);
+    res   = (a + round) >> b;
+
+    return saturate_s8(env, res);
+}
+
+static int16_t vnclipi_32(CPURISCVState *env, int32_t a, uint8_t b)
+{
+    int32_t round, res;
+
+    round = (int32_t)fix_data_round(env, (uint64_t)a, b);
+    res   = (a + round) >> b;
+
+    return saturate_s16(env, res);
+}
+
+static int32_t vnclipi_64(CPURISCVState *env, int64_t a, uint8_t b)
+{
+    int32_t round, res;
+
+    round = (int64_t)fix_data_round(env, (uint64_t)a, b);
+    res   = (a + round) >> b;
+
+    return saturate_s32(env, res);
+}
+
+static uint8_t vnclipu_16(CPURISCVState *env, uint16_t a, uint8_t b)
+{
+    uint16_t round, res;
+    uint8_t shift = b & 0xf;
+
+    round = (uint16_t)fix_data_round(env, (uint64_t)a, shift);
+    res   = (a + round) >> shift;
+
+    return saturate_u8(env, res);
+}
+
+static uint16_t vnclipu_32(CPURISCVState *env, uint32_t a, uint16_t b)
+{
+    uint32_t round, res;
+    uint8_t shift = b & 0x1f;
+
+    round = (uint32_t)fix_data_round(env, (uint64_t)a, shift);
+    res   = (a + round) >> shift;
+
+    return saturate_u16(env, res);
+}
+
+static uint32_t vnclipu_64(CPURISCVState *env, uint64_t a, uint32_t b)
+{
+    uint64_t round, res;
+    uint8_t shift = b & 0x3f;
+
+    round = (uint64_t)fix_data_round(env, (uint64_t)a, shift);
+    res   = (a + round) >> shift;
+
+    return saturate_u32(env, res);
+}
+
+static uint8_t vnclipui_16(CPURISCVState *env, uint16_t a, uint8_t b)
+{
+    uint16_t round, res;
+
+    round = (uint16_t)fix_data_round(env, (uint64_t)a, b);
+    res   = (a + round) >> b;
+
+    return saturate_u8(env, res);
+}
+
+static uint16_t vnclipui_32(CPURISCVState *env, uint32_t a, uint8_t b)
+{
+    uint32_t round, res;
+
+    round = (uint32_t)fix_data_round(env, (uint64_t)a, b);
+    res   = (a + round) >> b;
+
+    return saturate_u16(env, res);
+}
+
+static uint32_t vnclipui_64(CPURISCVState *env, uint64_t a, uint8_t b)
+{
+    uint64_t round, res;
+
+    round = (uint64_t)fix_data_round(env, (uint64_t)a, b);
+    res   = (a + round) >> b;
+
+    return saturate_u32(env, res);
+}
+
+static uint8_t vssrl_8(CPURISCVState *env, uint8_t a, uint8_t b)
+{
+    uint16_t round, res;
+    uint8_t shift = b & 0x7;
+
+    round = (uint16_t)fix_data_round(env, (uint64_t)a, shift);
+    res   = (a + round) >> shift;
+    return res;
+}
+
+static uint16_t vssrl_16(CPURISCVState *env, uint16_t a, uint16_t b)
+{
+    uint32_t round, res;
+    uint8_t shift = b & 0xf;
+
+    round = (uint32_t)fix_data_round(env, (uint64_t)a, shift);
+    res   = (a + round) >> shift;
+    return res;
+}
+
+static uint32_t vssrl_32(CPURISCVState *env, uint32_t a, uint32_t b)
+{
+    uint64_t round, res;
+    uint8_t shift = b & 0x1f;
+
+    round = (uint64_t)fix_data_round(env, (uint64_t)a, shift);
+    res   = (a + round) >> shift;
+    return res;
+}
+
+static uint64_t vssrl_64(CPURISCVState *env, uint64_t a, uint64_t b)
+{
+    uint64_t round, res;
+    uint8_t shift = b & 0x3f;
+
+    round = (uint64_t)fix_data_round(env, (uint64_t)a, shift);
+    res   = (a >> (shift - 1))  + (round >> (shift - 1));
+    return res >> 1;
+}
+
+static uint8_t vssrli_8(CPURISCVState *env, uint8_t a, uint8_t b)
+{
+    uint16_t round, res;
+
+    round = (uint16_t)fix_data_round(env, (uint64_t)a, b);
+    res   = (a + round) >> b;
+    return res;
+}
+
+static uint16_t vssrli_16(CPURISCVState *env, uint16_t a, uint8_t b)
+{
+    uint32_t round, res;
+
+    round = (uint32_t)fix_data_round(env, (uint64_t)a, b);
+    res   = (a + round) >> b;
+    return res;
+}
+
+static uint32_t vssrli_32(CPURISCVState *env, uint32_t a, uint8_t b)
+{
+    uint64_t round, res;
+
+    round = (uint64_t)fix_data_round(env, (uint64_t)a, b);
+    res   = (a + round) >> b;
+    return res;
+}
+
+static uint64_t vssrli_64(CPURISCVState *env, uint64_t a, uint8_t b)
+{
+    uint64_t round, res;
+
+    round = (uint64_t)fix_data_round(env, (uint64_t)a, b);
+    res   = (a >> (b - 1))  + (round >> (b - 1));
+    return res >> 1;
+}
+
+static int8_t vsmul_8(CPURISCVState *env, int8_t a, int8_t b)
+{
+    int16_t round;
+    int8_t res;
+    int16_t product = (int16_t)a * (int16_t)b;
+
+    if (a == INT8_MIN && b == INT8_MIN) {
+        env->vfp.vxsat = 1;
+
+        return INT8_MAX;
+    }
+
+    round = (int16_t)fix_data_round(env, (uint64_t)product, 7);
+    res   = sat_add_s16(env, product, round) >> 7;
+    return res;
+}
+
+static int16_t vsmul_16(CPURISCVState *env, int16_t a, int16_t b)
+{
+    int32_t round;
+    int16_t res;
+    int32_t product = (int32_t)a * (int32_t)b;
+
+    if (a == INT16_MIN && b == INT16_MIN) {
+        env->vfp.vxsat = 1;
+
+        return INT16_MAX;
+    }
+
+    round = (int32_t)fix_data_round(env, (uint64_t)product, 15);
+    res   = sat_add_s32(env, product, round) >> 15;
+    return res;
+}
+
+static int32_t vsmul_32(CPURISCVState *env, int32_t a, int32_t b)
+{
+    int64_t round;
+    int32_t res;
+    int64_t product = (int64_t)a * (int64_t)b;
+
+    if (a == INT32_MIN && b == INT32_MIN) {
+        env->vfp.vxsat = 1;
+
+        return INT32_MAX;
+    }
+
+    round = (int64_t)fix_data_round(env, (uint64_t)product, 31);
+    res   = sat_add_s64(env, product, round) >> 31;
+    return res;
+}
+
+static int64_t vsmul_64(CPURISCVState *env, int64_t a, int64_t b)
+{
+    int64_t res;
+    uint64_t abs_a = a, abs_b = b;
+    uint64_t lo_64, hi_64, carry, round;
+
+    if (a == INT64_MIN && b == INT64_MIN) {
+        env->vfp.vxsat = 1;
+
+        return INT64_MAX;
+    }
+
+    if (a < 0) {
+        abs_a =  ~a + 1;
+    }
+    if (b < 0) {
+        abs_b = ~b + 1;
+    }
+
+    /* first get the whole product in {hi_64, lo_64} */
+    uint64_t a_hi = abs_a >> 32;
+    uint64_t a_lo = (uint32_t)abs_a;
+    uint64_t b_hi = abs_b >> 32;
+    uint64_t b_lo = (uint32_t)abs_b;
+
+    /*
+     * abs_a * abs_b = (a_hi << 32 + a_lo) * (b_hi << 32 + b_lo)
+     *               = (a_hi * b_hi) << 64 + (a_hi * b_lo) << 32 +
+     *                 (a_lo * b_hi) << 32 + a_lo * b_lo
+     *               = {hi_64, lo_64}
+     * hi_64 = ((a_hi * b_lo) << 32 + (a_lo * b_hi) << 32 + (a_lo * b_lo)) >> 64
+     *       = (a_hi * b_lo) >> 32 + (a_lo * b_hi) >> 32 + carry
+     * carry = ((uint64_t)(uint32_t)(a_hi * b_lo) +
+     *           (uint64_t)(uint32_t)(a_lo * b_hi) + (a_lo * b_lo) >> 32) >> 32
+     */
+
+    lo_64 = abs_a * abs_b;
+    carry =  ((uint64_t)(uint32_t)(a_hi * b_lo) +
+              (uint64_t)(uint32_t)(a_lo * b_hi) +
+              ((a_lo * b_lo) >> 32)) >> 32;
+
+    hi_64 = a_hi * b_hi +
+            ((a_hi * b_lo) >> 32) + ((a_lo * b_hi) >> 32) +
+            carry;
+
+    if ((a ^ b) & SIGNBIT64) {
+        lo_64 = ~lo_64;
+        hi_64 = ~hi_64;
+        if (lo_64 == UINT64_MAX) {
+            lo_64 = 0;
+            hi_64 += 1;
+        } else {
+            lo_64 += 1;
+        }
+    }
+
+    /* set rem and res */
+    round = fix_data_round(env, lo_64, 63);
+    if ((lo_64 + round) < lo_64) {
+        hi_64 += 1;
+        res = (hi_64 << 1);
+    } else  {
+        res = (hi_64 << 1) | ((lo_64 + round) >> 63);
+    }
+
+    return res;
+}
+static inline int8_t avg_round_s8(CPURISCVState *env, int8_t a, int8_t b)
+{
+    int16_t round;
+    int8_t res;
+    int16_t sum = a + b;
+
+    round = (int16_t)fix_data_round(env, (uint64_t)sum, 1);
+    res   = (sum + round) >> 1;
+
+    return res;
+}
+
+static inline int16_t avg_round_s16(CPURISCVState *env, int16_t a, int16_t b)
+{
+    int32_t round;
+    int16_t res;
+    int32_t sum = a + b;
+
+    round = (int32_t)fix_data_round(env, (uint64_t)sum, 1);
+    res   = (sum + round) >> 1;
+
+    return res;
+}
+
+static inline int32_t avg_round_s32(CPURISCVState *env, int32_t a, int32_t b)
+{
+    int64_t round;
+    int32_t res;
+    int64_t sum = a + b;
+
+    round = (int64_t)fix_data_round(env, (uint64_t)sum, 1);
+    res   = (sum + round) >> 1;
+
+    return res;
+}
+
+static inline int64_t avg_round_s64(CPURISCVState *env, int64_t a, int64_t b)
+{
+    int64_t rem = (a & 0x1) + (b & 0x1);
+    int64_t res = (a >> 1) + (b >> 1) + (rem >> 1);
+    int mod = env->vfp.vxrm;
+
+    if (mod == 0x0) { /* rnu */
+        if (rem == 0x1) {
+            return res + 1;
+        }
+    } else if (mod == 0x1) { /* rne */
+        if ((rem & 0x1) == 1 && ((res & 0x1) == 1)) {
+            return res + 1;
+        }
+    } else if (mod == 0x3) { /* rod */
+        if (((rem & 0x1) >= 0x1) && (res & 0x1) == 0) {
+            return res + 1;
+        }
+    }
+    return res;
+}
+
 static inline bool vector_vtype_ill(CPURISCVState *env)
 {
     if ((env->vfp.vtype >> (sizeof(target_ulong) - 1)) & 0x1) {
@@ -13726,3 +14564,2553 @@ void VECTOR_HELPER(vmerge_vim)(CPURISCVState *env, uint32_t vm, uint32_t rs1,
     env->vfp.vstart = 0;
 }
 
+/* vsaddu.vv vd, vs2, vs1, vm # Vector-vector */
+void VECTOR_HELPER(vsaddu_vv)(CPURISCVState *env, uint32_t vm, uint32_t rs1,
+    uint32_t rs2, uint32_t rd)
+{
+    int width, lmul, vl, vlmax;
+    int i, j, dest, src1, src2;
+
+    lmul = vector_get_lmul(env);
+
+    if (vector_vtype_ill(env) || vector_overlap_vm_common(lmul, vm, rd)) {
+        riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+        return;
+    }
+
+    vector_lmul_check_reg(env, lmul, rs1, false);
+    vector_lmul_check_reg(env, lmul, rs2, false);
+    vector_lmul_check_reg(env, lmul, rd, false);
+
+    vl = env->vfp.vl;
+    if (env->vfp.vstart >= vl) {
+        return;
+    }
+
+    width = vector_get_width(env);
+    vlmax = vector_get_vlmax(env);
+
+    for (i = 0; i < vlmax; i++) {
+        dest = rd + (i / (VLEN / width));
+        src2 = rs2 + (i / (VLEN / width));
+        src1 = rs1 + (i / (VLEN / width));
+        j = i % (VLEN / width);
+        if (i < env->vfp.vstart) {
+            continue;
+        } else if (i < vl) {
+            switch (width) {
+            case 8:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].u8[j] = sat_add_u8(env,
+                        env->vfp.vreg[src1].u8[j], env->vfp.vreg[src2].u8[j]);
+                }
+                break;
+            case 16:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].u16[j] = sat_add_u16(env,
+                        env->vfp.vreg[src1].u16[j], env->vfp.vreg[src2].u16[j]);
+                }
+                break;
+            case 32:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].u32[j] = sat_add_u32(env,
+                        env->vfp.vreg[src1].u32[j], env->vfp.vreg[src2].u32[j]);
+                }
+                break;
+            case 64:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].u64[j] = sat_add_u64(env,
+                        env->vfp.vreg[src1].u64[j], env->vfp.vreg[src2].u64[j]);
+                }
+                break;
+            default:
+                riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+                return;
+            }
+        } else {
+            vector_tail_common(env, dest, j, width);
+        }
+    }
+    env->vfp.vstart = 0;
+    return;
+}
+
+/* vsaddu.vx vd, vs2, rs1, vm # vector-scalar */
+void VECTOR_HELPER(vsaddu_vx)(CPURISCVState *env, uint32_t vm, uint32_t rs1,
+    uint32_t rs2, uint32_t rd)
+{
+    int width, lmul, vl, vlmax;
+    int i, j, dest, src2;
+
+    lmul = vector_get_lmul(env);
+
+    if (vector_vtype_ill(env) || vector_overlap_vm_common(lmul, vm, rd)) {
+        riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+        return;
+    }
+
+    vector_lmul_check_reg(env, lmul, rs2, false);
+    vector_lmul_check_reg(env, lmul, rd, false);
+
+    vl = env->vfp.vl;
+    if (env->vfp.vstart >= vl) {
+        return;
+    }
+
+    width = vector_get_width(env);
+    vlmax = vector_get_vlmax(env);
+
+    for (i = 0; i < vlmax; i++) {
+        dest = rd + (i / (VLEN / width));
+        src2 = rs2 + (i / (VLEN / width));
+        j = i % (VLEN / width);
+        if (i < env->vfp.vstart) {
+            continue;
+        } else if (i < vl) {
+            switch (width) {
+            case 8:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].u8[j] = sat_add_u8(env,
+                        env->vfp.vreg[src2].u8[j], env->gpr[rs1]);
+                }
+                break;
+            case 16:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].u16[j] = sat_add_u16(env,
+                        env->vfp.vreg[src2].u16[j], env->gpr[rs1]);
+                }
+                break;
+            case 32:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].u32[j] = sat_add_u32(env,
+                        env->vfp.vreg[src2].u32[j], env->gpr[rs1]);
+                }
+                break;
+            case 64:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].u64[j] = sat_add_u64(env,
+                        env->vfp.vreg[src2].u64[j], env->gpr[rs1]);
+                }
+                break;
+            default:
+                riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+                return;
+            }
+        } else {
+            vector_tail_common(env, dest, j, width);
+        }
+    }
+    env->vfp.vstart = 0;
+    return;
+}
+
+/* vsaddu.vi vd, vs2, imm, vm # vector-immediate */
+void VECTOR_HELPER(vsaddu_vi)(CPURISCVState *env, uint32_t vm, uint32_t rs1,
+    uint32_t rs2, uint32_t rd)
+{
+    int width, lmul, vl, vlmax;
+    int i, j, dest, src2;
+
+    lmul = vector_get_lmul(env);
+
+    if (vector_vtype_ill(env) || vector_overlap_vm_common(lmul, vm, rd)) {
+        riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+        return;
+    }
+
+    vector_lmul_check_reg(env, lmul, rs2, false);
+    vector_lmul_check_reg(env, lmul, rd, false);
+
+    vl = env->vfp.vl;
+    if (env->vfp.vstart >= vl) {
+        return;
+    }
+
+    width = vector_get_width(env);
+    vlmax = vector_get_vlmax(env);
+
+    for (i = 0; i < vlmax; i++) {
+        dest = rd + (i / (VLEN / width));
+        src2 = rs2 + (i / (VLEN / width));
+        j = i % (VLEN / width);
+        if (i < env->vfp.vstart) {
+            continue;
+        } else if (i < vl) {
+            switch (width) {
+            case 8:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].u8[j] = sat_add_u8(env,
+                        env->vfp.vreg[src2].u8[j], rs1);
+                }
+                break;
+            case 16:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].u16[j] = sat_add_u16(env,
+                        env->vfp.vreg[src2].u16[j], rs1);
+                }
+                break;
+            case 32:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].u32[j] = sat_add_u32(env,
+                        env->vfp.vreg[src2].u32[j], rs1);
+                }
+                break;
+            case 64:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].u64[j] = sat_add_u64(env,
+                        env->vfp.vreg[src2].u64[j], rs1);
+                }
+                break;
+            default:
+                riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+                return;
+            }
+        } else {
+            vector_tail_common(env, dest, j, width);
+        }
+    }
+    env->vfp.vstart = 0;
+    return;
+}
+
+/* vsadd.vv vd, vs2, vs1, vm # Vector-vector */
+void VECTOR_HELPER(vsadd_vv)(CPURISCVState *env, uint32_t vm, uint32_t rs1,
+    uint32_t rs2, uint32_t rd)
+{
+    int width, lmul, vl, vlmax;
+    int i, j, dest, src1, src2;
+
+    lmul = vector_get_lmul(env);
+
+    if (vector_vtype_ill(env) || vector_overlap_vm_common(lmul, vm, rd)) {
+        riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+        return;
+    }
+
+    vector_lmul_check_reg(env, lmul, rs1, false);
+    vector_lmul_check_reg(env, lmul, rs2, false);
+    vector_lmul_check_reg(env, lmul, rd, false);
+
+    vl = env->vfp.vl;
+
+    if (env->vfp.vstart >= vl) {
+        return;
+    }
+
+    width = vector_get_width(env);
+    vlmax = vector_get_vlmax(env);
+
+    for (i = 0; i < vlmax; i++) {
+        dest = rd + (i / (VLEN / width));
+        src2 = rs2 + (i / (VLEN / width));
+        src1 = rs1 + (i / (VLEN / width));
+        j = i % (VLEN / width);
+        if (i < env->vfp.vstart) {
+            continue;
+        } else if (i < vl) {
+            switch (width) {
+            case 8:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].s8[j] = sat_add_s8(env,
+                        env->vfp.vreg[src1].s8[j], env->vfp.vreg[src2].s8[j]);
+                }
+                break;
+            case 16:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].s16[j] = sat_add_s16(env,
+                        env->vfp.vreg[src1].s16[j], env->vfp.vreg[src2].s16[j]);
+                }
+                break;
+            case 32:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].s32[j] = sat_add_s32(env,
+                        env->vfp.vreg[src1].s32[j], env->vfp.vreg[src2].s32[j]);
+                }
+                break;
+            case 64:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].s64[j] = sat_add_s64(env,
+                        env->vfp.vreg[src1].s64[j], env->vfp.vreg[src2].s64[j]);
+                }
+                break;
+            default:
+                riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+                return;
+            }
+        } else {
+            vector_tail_common(env, dest, j, width);
+        }
+    }
+    env->vfp.vstart = 0;
+    return;
+}
+
+/* vsadd.vx vd, vs2, rs1, vm # vector-scalar */
+void VECTOR_HELPER(vsadd_vx)(CPURISCVState *env, uint32_t vm, uint32_t rs1,
+    uint32_t rs2, uint32_t rd)
+{
+    int width, lmul, vl, vlmax;
+    int i, j, dest, src2;
+
+    lmul = vector_get_lmul(env);
+
+    if (vector_vtype_ill(env) || vector_overlap_vm_common(lmul, vm, rd)) {
+        riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+        return;
+    }
+
+    vector_lmul_check_reg(env, lmul, rs2, false);
+    vector_lmul_check_reg(env, lmul, rd, false);
+
+    vl = env->vfp.vl;
+    if (env->vfp.vstart >= vl) {
+        return;
+    }
+
+    width = vector_get_width(env);
+    vlmax = vector_get_vlmax(env);
+
+    for (i = 0; i < vlmax; i++) {
+        dest = rd + (i / (VLEN / width));
+        src2 = rs2 + (i / (VLEN / width));
+        j = i % (VLEN / width);
+        if (i < env->vfp.vstart) {
+            continue;
+        } else if (i < vl) {
+            switch (width) {
+            case 8:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].s8[j] = sat_add_s8(env,
+                        env->vfp.vreg[src2].s8[j], env->gpr[rs1]);
+                }
+                break;
+            case 16:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].s16[j] = sat_add_s16(env,
+                        env->vfp.vreg[src2].s16[j], env->gpr[rs1]);
+                }
+                break;
+            case 32:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].s32[j] = sat_add_s32(env,
+                        env->vfp.vreg[src2].s32[j], env->gpr[rs1]);
+                }
+                break;
+            case 64:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].s64[j] = sat_add_s64(env,
+                        env->vfp.vreg[src2].s64[j], env->gpr[rs1]);
+                }
+                break;
+            default:
+                riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+                return;
+            }
+        } else {
+            vector_tail_common(env, dest, j, width);
+        }
+    }
+    env->vfp.vstart = 0;
+    return;
+}
+
+/* vsadd.vi vd, vs2, imm, vm # vector-immediate */
+void VECTOR_HELPER(vsadd_vi)(CPURISCVState *env, uint32_t vm, uint32_t rs1,
+    uint32_t rs2, uint32_t rd)
+{
+    int width, lmul, vl, vlmax;
+    int i, j, dest, src2;
+
+    lmul = vector_get_lmul(env);
+
+    if (vector_vtype_ill(env) || vector_overlap_vm_common(lmul, vm, rd)) {
+        riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+        return;
+    }
+
+    vector_lmul_check_reg(env, lmul, rs2, false);
+    vector_lmul_check_reg(env, lmul, rd, false);
+
+    vl = env->vfp.vl;
+    if (env->vfp.vstart >= vl) {
+        return;
+    }
+
+    width = vector_get_width(env);
+    vlmax = vector_get_vlmax(env);
+
+    for (i = 0; i < vlmax; i++) {
+        dest = rd + (i / (VLEN / width));
+        src2 = rs2 + (i / (VLEN / width));
+        j = i % (VLEN / width);
+        if (i < env->vfp.vstart) {
+            continue;
+        } else if (i < vl) {
+            switch (width) {
+            case 8:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].s8[j] = sat_add_s8(env,
+                        env->vfp.vreg[src2].s8[j], sign_extend(rs1, 5));
+                }
+                break;
+            case 16:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].s16[j] = sat_add_s16(env,
+                        env->vfp.vreg[src2].s16[j], sign_extend(rs1, 5));
+                }
+                break;
+            case 32:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].s32[j] = sat_add_s32(env,
+                        env->vfp.vreg[src2].s32[j], sign_extend(rs1, 5));
+                }
+                break;
+            case 64:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].s64[j] = sat_add_s64(env,
+                        env->vfp.vreg[src2].s64[j], sign_extend(rs1, 5));
+                }
+                break;
+            default:
+                riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+                return;
+            }
+        } else {
+            vector_tail_common(env, dest, j, width);
+        }
+    }
+    env->vfp.vstart = 0;
+    return;
+}
+
+/* vssubu.vv vd, vs2, vs1, vm # Vector-vector */
+void VECTOR_HELPER(vssubu_vv)(CPURISCVState *env, uint32_t vm, uint32_t rs1,
+    uint32_t rs2, uint32_t rd)
+{
+    int width, lmul, vl, vlmax;
+    int i, j, dest, src1, src2;
+
+    lmul = vector_get_lmul(env);
+
+    if (vector_vtype_ill(env) || vector_overlap_vm_common(lmul, vm, rd)) {
+        riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+        return;
+    }
+
+    vector_lmul_check_reg(env, lmul, rs1, false);
+    vector_lmul_check_reg(env, lmul, rs2, false);
+    vector_lmul_check_reg(env, lmul, rd, false);
+
+    vl = env->vfp.vl;
+    if (env->vfp.vstart >= vl) {
+        return;
+    }
+
+    width = vector_get_width(env);
+    vlmax = vector_get_vlmax(env);
+
+    for (i = 0; i < vlmax; i++) {
+        dest = rd + (i / (VLEN / width));
+        src2 = rs2 + (i / (VLEN / width));
+        src1 = rs1 + (i / (VLEN / width));
+        j = i % (VLEN / width);
+        if (i < env->vfp.vstart) {
+            continue;
+        } else if (i < vl) {
+            switch (width) {
+            case 8:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].u8[j] = sat_sub_u8(env,
+                        env->vfp.vreg[src2].u8[j], env->vfp.vreg[src1].u8[j]);
+                }
+                break;
+            case 16:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].u16[j] = sat_sub_u16(env,
+                        env->vfp.vreg[src2].u16[j], env->vfp.vreg[src1].u16[j]);
+                }
+                break;
+            case 32:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].u32[j] = sat_sub_u32(env,
+                        env->vfp.vreg[src2].u32[j], env->vfp.vreg[src1].u32[j]);
+                }
+                break;
+            case 64:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].u64[j] = sat_sub_u64(env,
+                        env->vfp.vreg[src2].u64[j], env->vfp.vreg[src1].u64[j]);
+                }
+                break;
+            default:
+                riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+                return;
+            }
+        } else {
+            vector_tail_common(env, dest, j, width);
+        }
+    }
+    env->vfp.vstart = 0;
+    return;
+}
+
+/* vssubu.vx vd, vs2, rs1, vm # vector-scalar */
+void VECTOR_HELPER(vssubu_vx)(CPURISCVState *env, uint32_t vm, uint32_t rs1,
+    uint32_t rs2, uint32_t rd)
+{
+    int width, lmul, vl, vlmax;
+    int i, j, dest, src2;
+
+    lmul = vector_get_lmul(env);
+
+    if (vector_vtype_ill(env) || vector_overlap_vm_common(lmul, vm, rd)) {
+        riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+        return;
+    }
+
+    vector_lmul_check_reg(env, lmul, rs2, false);
+    vector_lmul_check_reg(env, lmul, rd, false);
+
+    vl = env->vfp.vl;
+    if (env->vfp.vstart >= vl) {
+        return;
+    }
+
+    width = vector_get_width(env);
+    vlmax = vector_get_vlmax(env);
+
+    for (i = 0; i < vlmax; i++) {
+        dest = rd + (i / (VLEN / width));
+        src2 = rs2 + (i / (VLEN / width));
+        j = i % (VLEN / width);
+        if (i < env->vfp.vstart) {
+            continue;
+        } else if (i < vl) {
+            switch (width) {
+            case 8:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].u8[j] = sat_sub_u8(env,
+                        env->vfp.vreg[src2].u8[j], env->gpr[rs1]);
+                }
+                break;
+            case 16:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].u16[j] = sat_sub_u16(env,
+                        env->vfp.vreg[src2].u16[j], env->gpr[rs1]);
+                }
+                break;
+            case 32:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].u32[j] = sat_sub_u32(env,
+                        env->vfp.vreg[src2].u32[j], env->gpr[rs1]);
+                }
+                break;
+            case 64:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].u64[j] = sat_sub_u64(env,
+                        env->vfp.vreg[src2].u64[j], env->gpr[rs1]);
+                }
+                break;
+            default:
+                riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+                return;
+            }
+        } else {
+            vector_tail_common(env, dest, j, width);
+        }
+    }
+    env->vfp.vstart = 0;
+    return;
+}
+
+/* vssub.vv vd, vs2, vs1, vm # Vector-vector */
+void VECTOR_HELPER(vssub_vv)(CPURISCVState *env, uint32_t vm, uint32_t rs1,
+    uint32_t rs2, uint32_t rd)
+{
+    int width, lmul, vl, vlmax;
+    int i, j, dest, src1, src2;
+
+    lmul = vector_get_lmul(env);
+
+    if (vector_vtype_ill(env) || vector_overlap_vm_common(lmul, vm, rd)) {
+        riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+        return;
+    }
+
+    vector_lmul_check_reg(env, lmul, rs1, false);
+    vector_lmul_check_reg(env, lmul, rs2, false);
+    vector_lmul_check_reg(env, lmul, rd, false);
+
+    vl = env->vfp.vl;
+    if (env->vfp.vstart >= vl) {
+        return;
+    }
+
+    width = vector_get_width(env);
+    vlmax = vector_get_vlmax(env);
+
+    for (i = 0; i < vlmax; i++) {
+        dest = rd + (i / (VLEN / width));
+        src2 = rs2 + (i / (VLEN / width));
+        src1 = rs1 + (i / (VLEN / width));
+        j = i % (VLEN / width);
+        if (i < env->vfp.vstart) {
+            continue;
+        } else if (i < vl) {
+            switch (width) {
+            case 8:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].s8[j] = sat_sub_s8(env,
+                        env->vfp.vreg[src2].s8[j], env->vfp.vreg[src1].s8[j]);
+                }
+                break;
+            case 16:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].s16[j] = sat_sub_s16(env,
+                        env->vfp.vreg[src2].s16[j], env->vfp.vreg[src1].s16[j]);
+                }
+                break;
+            case 32:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].s32[j] = sat_sub_s32(env,
+                        env->vfp.vreg[src2].s32[j], env->vfp.vreg[src1].s32[j]);
+                }
+                break;
+            case 64:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].s64[j] = sat_sub_s64(env,
+                        env->vfp.vreg[src2].s64[j], env->vfp.vreg[src1].s64[j]);
+                }
+                break;
+            default:
+                riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+                return;
+            }
+        } else {
+            vector_tail_common(env, dest, j, width);
+        }
+    }
+    env->vfp.vstart = 0;
+    return;
+}
+
+/* vssub.vx vd, vs2, rs1, vm # vector-scalar */
+void VECTOR_HELPER(vssub_vx)(CPURISCVState *env, uint32_t vm, uint32_t rs1,
+    uint32_t rs2, uint32_t rd)
+{
+    int width, lmul, vl, vlmax;
+    int i, j, dest, src2;
+
+    lmul = vector_get_lmul(env);
+
+    if (vector_vtype_ill(env) || vector_overlap_vm_common(lmul, vm, rd)) {
+        riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+        return;
+    }
+
+    vector_lmul_check_reg(env, lmul, rs2, false);
+    vector_lmul_check_reg(env, lmul, rd, false);
+
+    vl = env->vfp.vl;
+    if (env->vfp.vstart >= vl) {
+        return;
+    }
+
+    width = vector_get_width(env);
+    vlmax = vector_get_vlmax(env);
+
+    for (i = 0; i < vlmax; i++) {
+        dest = rd + (i / (VLEN / width));
+        src2 = rs2 + (i / (VLEN / width));
+        j = i % (VLEN / width);
+        if (i < env->vfp.vstart) {
+            continue;
+        } else if (i < vl) {
+            switch (width) {
+            case 8:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].s8[j] = sat_sub_s8(env,
+                        env->vfp.vreg[src2].s8[j], env->gpr[rs1]);
+                }
+                break;
+            case 16:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].s16[j] = sat_sub_s16(env,
+                        env->vfp.vreg[src2].s16[j], env->gpr[rs1]);
+                }
+                break;
+            case 32:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].s32[j] = sat_sub_s32(env,
+                        env->vfp.vreg[src2].s32[j], env->gpr[rs1]);
+                }
+                break;
+            case 64:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].s64[j] = sat_sub_s64(env,
+                        env->vfp.vreg[src2].s64[j], env->gpr[rs1]);
+                }
+                break;
+            default:
+                riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+                return;
+            }
+        } else {
+            vector_tail_common(env, dest, j, width);
+        }
+    }
+    env->vfp.vstart = 0;
+    return;
+}
+
+/* vaadd.vv vd, vs2, vs1, vm # Vector-vector */
+void VECTOR_HELPER(vaadd_vv)(CPURISCVState *env, uint32_t vm, uint32_t rs1,
+    uint32_t rs2, uint32_t rd)
+{
+    int width, lmul, vl, vlmax;
+    int i, j, dest, src1, src2;
+
+    lmul = vector_get_lmul(env);
+
+    if (vector_vtype_ill(env) || vector_overlap_vm_common(lmul, vm, rd)) {
+        riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+        return;
+    }
+
+    vector_lmul_check_reg(env, lmul, rs1, false);
+    vector_lmul_check_reg(env, lmul, rs2, false);
+    vector_lmul_check_reg(env, lmul, rd, false);
+
+    vl = env->vfp.vl;
+    if (env->vfp.vstart >= vl) {
+        return;
+    }
+
+    width = vector_get_width(env);
+    vlmax = vector_get_vlmax(env);
+
+    for (i = 0; i < vlmax; i++) {
+        dest = rd + (i / (VLEN / width));
+        src2 = rs2 + (i / (VLEN / width));
+        src1 = rs1 + (i / (VLEN / width));
+        j = i % (VLEN / width);
+        if (i < env->vfp.vstart) {
+            continue;
+        } else if (i < vl) {
+            switch (width) {
+            case 8:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].s8[j] = avg_round_s8(env,
+                        env->vfp.vreg[src1].s8[j], env->vfp.vreg[src2].s8[j]);
+                }
+                break;
+            case 16:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].s16[j] = avg_round_s16(env,
+                        env->vfp.vreg[src1].s16[j], env->vfp.vreg[src2].s16[j]);
+                }
+                break;
+            case 32:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].s32[j] = avg_round_s32(env,
+                        env->vfp.vreg[src1].s32[j], env->vfp.vreg[src2].s32[j]);
+                }
+                break;
+            case 64:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].s64[j] = avg_round_s64(env,
+                        env->vfp.vreg[src1].s64[j], env->vfp.vreg[src2].s64[j]);
+                }
+                break;
+            default:
+                riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+                return;
+            }
+        } else {
+            vector_tail_common(env, dest, j, width);
+        }
+    }
+    env->vfp.vstart = 0;
+    return;
+}
+
+/* vaadd.vx vd, vs2, rs1, vm # vector-scalar */
+void VECTOR_HELPER(vaadd_vx)(CPURISCVState *env, uint32_t vm, uint32_t rs1,
+    uint32_t rs2, uint32_t rd)
+{
+    int width, lmul, vl, vlmax;
+    int i, j, dest, src2;
+
+    lmul = vector_get_lmul(env);
+
+    if (vector_vtype_ill(env) || vector_overlap_vm_common(lmul, vm, rd)) {
+        riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+        return;
+    }
+
+    vector_lmul_check_reg(env, lmul, rs2, false);
+    vector_lmul_check_reg(env, lmul, rd, false);
+
+    vl = env->vfp.vl;
+    if (env->vfp.vstart >= vl) {
+        return;
+    }
+
+    width = vector_get_width(env);
+    vlmax = vector_get_vlmax(env);
+
+    for (i = 0; i < vlmax; i++) {
+        dest = rd + (i / (VLEN / width));
+        src2 = rs2 + (i / (VLEN / width));
+        j = i % (VLEN / width);
+        if (i < env->vfp.vstart) {
+            continue;
+        } else if (i < vl) {
+            switch (width) {
+            case 8:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].s8[j] = avg_round_s8(env,
+                        env->gpr[rs1], env->vfp.vreg[src2].s8[j]);
+                }
+                break;
+            case 16:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].s16[j] = avg_round_s16(env,
+                        env->gpr[rs1], env->vfp.vreg[src2].s16[j]);
+                }
+                break;
+            case 32:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].s32[j] = avg_round_s32(env,
+                        env->gpr[rs1], env->vfp.vreg[src2].s32[j]);
+                }
+                break;
+            case 64:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].s64[j] = avg_round_s64(env,
+                        env->gpr[rs1], env->vfp.vreg[src2].s64[j]);
+                }
+                break;
+            default:
+                riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+                return;
+            }
+        } else {
+            vector_tail_common(env, dest, j, width);
+        }
+    }
+    env->vfp.vstart = 0;
+    return;
+}
+
+/* vaadd.vi vd, vs2, imm, vm # vector-immediate */
+void VECTOR_HELPER(vaadd_vi)(CPURISCVState *env, uint32_t vm, uint32_t rs1,
+    uint32_t rs2, uint32_t rd)
+{
+    int width, lmul, vl, vlmax;
+    int i, j, dest, src2;
+
+    lmul = vector_get_lmul(env);
+
+    if (vector_vtype_ill(env) || vector_overlap_vm_common(lmul, vm, rd)) {
+        riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+        return;
+    }
+
+    vector_lmul_check_reg(env, lmul, rs2, false);
+    vector_lmul_check_reg(env, lmul, rd, false);
+
+    vl = env->vfp.vl;
+
+    if (env->vfp.vstart >= vl) {
+        return;
+    }
+
+    width = vector_get_width(env);
+    vlmax = vector_get_vlmax(env);
+
+    for (i = 0; i < vlmax; i++) {
+        dest = rd + (i / (VLEN / width));
+        src2 = rs2 + (i / (VLEN / width));
+        j = i % (VLEN / width);
+        if (i < env->vfp.vstart) {
+            continue;
+        } else if (i < vl) {
+            switch (width) {
+            case 8:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].s8[j] = avg_round_s8(env,
+                        rs1, env->vfp.vreg[src2].s8[j]);
+                }
+                break;
+            case 16:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].s16[j] = avg_round_s16(env,
+                        rs1, env->vfp.vreg[src2].s16[j]);
+                }
+                break;
+            case 32:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].s32[j] = avg_round_s32(env,
+                        rs1, env->vfp.vreg[src2].s32[j]);
+                }
+                break;
+            case 64:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].s64[j] = avg_round_s64(env,
+                        rs1, env->vfp.vreg[src2].s64[j]);
+                }
+                break;
+            default:
+                riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+                return;
+            }
+        } else {
+            vector_tail_common(env, dest, j, width);
+        }
+    }
+    env->vfp.vstart = 0;
+    return;
+}
+
+/* vasub.vv vd, vs2, vs1, vm # Vector-vector */
+void VECTOR_HELPER(vasub_vv)(CPURISCVState *env, uint32_t vm, uint32_t rs1,
+    uint32_t rs2, uint32_t rd)
+{
+    int width, lmul, vl, vlmax;
+    int i, j, dest, src1, src2;
+
+    lmul = vector_get_lmul(env);
+
+    if (vector_vtype_ill(env) || vector_overlap_vm_common(lmul, vm, rd)) {
+        riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+        return;
+    }
+
+    vector_lmul_check_reg(env, lmul, rs1, false);
+    vector_lmul_check_reg(env, lmul, rs2, false);
+    vector_lmul_check_reg(env, lmul, rd, false);
+
+    vl = env->vfp.vl;
+    if (env->vfp.vstart >= vl) {
+        return;
+    }
+
+    width = vector_get_width(env);
+    vlmax = vector_get_vlmax(env);
+
+    for (i = 0; i < vlmax; i++) {
+        dest = rd + (i / (VLEN / width));
+        src2 = rs2 + (i / (VLEN / width));
+        src1 = rs1 + (i / (VLEN / width));
+        j = i % (VLEN / width);
+        if (i < env->vfp.vstart) {
+            continue;
+        } else if (i < vl) {
+            switch (width) {
+            case 8:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].s8[j] = avg_round_s8(
+                        env,
+                        ~env->vfp.vreg[src1].s8[j] + 1,
+                        env->vfp.vreg[src2].s8[j]);
+                }
+                break;
+            case 16:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].s16[j] = avg_round_s16(
+                        env,
+                        ~env->vfp.vreg[src1].s16[j] + 1,
+                        env->vfp.vreg[src2].s16[j]);
+                }
+                break;
+            case 32:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].s32[j] = avg_round_s32(
+                        env,
+                        ~env->vfp.vreg[src1].s32[j] + 1,
+                        env->vfp.vreg[src2].s32[j]);
+                }
+                break;
+            case 64:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].s64[j] = avg_round_s64(
+                        env,
+                        ~env->vfp.vreg[src1].s64[j] + 1,
+                        env->vfp.vreg[src2].s64[j]);
+                }
+                break;
+            default:
+                riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+                return;
+            }
+        } else {
+            vector_tail_common(env, dest, j, width);
+        }
+    }
+    return;
+
+    env->vfp.vstart = 0;
+}
+
+/* vasub.vx vd, vs2, rs1, vm # vector-scalar */
+void VECTOR_HELPER(vasub_vx)(CPURISCVState *env, uint32_t vm, uint32_t rs1,
+    uint32_t rs2, uint32_t rd)
+{
+    int width, lmul, vl, vlmax;
+    int i, j, dest, src2;
+
+    lmul = vector_get_lmul(env);
+
+    if (vector_vtype_ill(env) || vector_overlap_vm_common(lmul, vm, rd)) {
+        riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+        return;
+    }
+
+    vector_lmul_check_reg(env, lmul, rs2, false);
+    vector_lmul_check_reg(env, lmul, rd, false);
+
+    vl = env->vfp.vl;
+    if (env->vfp.vstart >= vl) {
+        return;
+    }
+
+    width = vector_get_width(env);
+    vlmax = vector_get_vlmax(env);
+
+    for (i = 0; i < vlmax; i++) {
+        dest = rd + (i / (VLEN / width));
+        src2 = rs2 + (i / (VLEN / width));
+        j = i % (VLEN / width);
+        if (i < env->vfp.vstart) {
+            continue;
+        } else if (i < vl) {
+            switch (width) {
+            case 8:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].s8[j] = avg_round_s8(
+                        env, ~env->gpr[rs1] + 1, env->vfp.vreg[src2].s8[j]);
+                }
+                break;
+            case 16:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].s16[j] = avg_round_s16(
+                        env, ~env->gpr[rs1] + 1, env->vfp.vreg[src2].s16[j]);
+                }
+                break;
+            case 32:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].s32[j] = avg_round_s32(
+                        env, ~env->gpr[rs1] + 1, env->vfp.vreg[src2].s32[j]);
+                }
+                break;
+            case 64:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].s64[j] = avg_round_s64(
+                        env, ~env->gpr[rs1] + 1, env->vfp.vreg[src2].s64[j]);
+                }
+                break;
+            default:
+                riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+                return;
+            }
+        } else {
+            vector_tail_common(env, dest, j, width);
+        }
+    }
+    env->vfp.vstart = 0;
+    return;
+}
+
+/* vsmul.vv vd, vs2, vs1, vm # vd[i] = clip((vs2[i]*vs1[i]+round)>>(SEW-1)) */
+void VECTOR_HELPER(vsmul_vv)(CPURISCVState *env, uint32_t vm, uint32_t rs1,
+    uint32_t rs2, uint32_t rd)
+{
+    int width, lmul, vl, vlmax;
+    int i, j, dest, src1, src2;
+    if (vector_vtype_ill(env)) {
+        riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+        return;
+    }
+
+    lmul = vector_get_lmul(env);
+    vl = env->vfp.vl;
+
+    if ((!(vm)) && rd == 0) {
+        riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+        return;
+    }
+
+    if (env->vfp.vstart >= vl) {
+        return;
+    }
+
+    width = vector_get_width(env);
+    vlmax = vector_get_vlmax(env);
+
+    for (i = 0; i < vlmax; i++) {
+        dest = rd + (i / (VLEN / width));
+        src2 = rs2 + (i / (VLEN / width));
+        src1 = rs1 + (i / (VLEN / width));
+        j = i % (VLEN / width);
+        if (i < env->vfp.vstart) {
+            continue;
+        } else if (i < vl) {
+            switch (width) {
+            case 8:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].s8[j] = vsmul_8(env,
+                        env->vfp.vreg[src1].s8[j], env->vfp.vreg[src2].s8[j]);
+                }
+                break;
+            case 16:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].s16[j] = vsmul_16(env,
+                        env->vfp.vreg[src1].s16[j], env->vfp.vreg[src2].s16[j]);
+                }
+                break;
+            case 32:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].s32[j] = vsmul_32(env,
+                        env->vfp.vreg[src1].s32[j], env->vfp.vreg[src2].s32[j]);
+                }
+                break;
+            case 64:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].s64[j] = vsmul_64(env,
+                        env->vfp.vreg[src1].s64[j], env->vfp.vreg[src2].s64[j]);
+                }
+                break;
+            default:
+                riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+                return;
+            }
+        } else {
+            vector_tail_common(env, dest, j, width);
+        }
+    }
+    env->vfp.vstart = 0;
+    return;
+}
+
+/* vsmul.vx vd, vs2, rs1, vm # vd[i] = clip((vs2[i]*x[rs1]+round)>>(SEW-1)) */
+void VECTOR_HELPER(vsmul_vx)(CPURISCVState *env, uint32_t vm, uint32_t rs1,
+    uint32_t rs2, uint32_t rd)
+{
+    int width, lmul, vl, vlmax;
+    int i, j, dest, src2;
+    if (vector_vtype_ill(env)) {
+        riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+        return;
+    }
+
+    lmul = vector_get_lmul(env);
+    vl = env->vfp.vl;
+
+    if ((!(vm)) && rd == 0) {
+        riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+        return;
+    }
+
+    if (env->vfp.vstart >= vl) {
+        return;
+    }
+
+    width = vector_get_width(env);
+    vlmax = vector_get_vlmax(env);
+
+    for (i = 0; i < vlmax; i++) {
+        dest = rd + (i / (VLEN / width));
+        src2 = rs2 + (i / (VLEN / width));
+        j = i % (VLEN / width);
+        if (i < env->vfp.vstart) {
+            continue;
+        } else if (i < vl) {
+            switch (width) {
+            case 8:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].s8[j] = vsmul_8(env,
+                        env->vfp.vreg[src2].s8[j], env->gpr[rs1]);
+                }
+                break;
+            case 16:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].s16[j] = vsmul_16(env,
+                        env->vfp.vreg[src2].s16[j], env->gpr[rs1]);
+                }
+                break;
+            case 32:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].s32[j] = vsmul_32(env,
+                        env->vfp.vreg[src2].s32[j], env->gpr[rs1]);
+                }
+                break;
+            case 64:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].s64[j] = vsmul_64(env,
+                        env->vfp.vreg[src2].s64[j], env->gpr[rs1]);
+                }
+                break;
+            default:
+                riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+                return;
+            }
+        } else {
+            vector_tail_common(env, dest, j, width);
+        }
+    }
+    env->vfp.vstart = 0;
+    return;
+}
+
+/*
+ * vwsmaccu.vv vd, vs1, vs2, vm #
+ * vd[i] = clipu((+(vs1[i]*vs2[i]+round)>>SEW/2)+vd[i])
+ */
+void VECTOR_HELPER(vwsmaccu_vv)(CPURISCVState *env, uint32_t vm, uint32_t rs1,
+    uint32_t rs2, uint32_t rd)
+{
+    int width, lmul, vl, vlmax;
+    int i, j, k, dest, src1, src2;
+
+    lmul = vector_get_lmul(env);
+
+    if (vector_vtype_ill(env)
+        || vector_overlap_vm_force(vm, rd)
+        || vector_overlap_dstgp_srcgp(rd, 2 * lmul, rs1, lmul)
+        || vector_overlap_dstgp_srcgp(rd, 2 * lmul, rs2, lmul)) {
+        riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+        return;
+    }
+
+    vector_lmul_check_reg(env, lmul, rs1, false);
+    vector_lmul_check_reg(env, lmul, rs2, false);
+    vector_lmul_check_reg(env, lmul, rd, true);
+
+    vl = env->vfp.vl;
+    if (env->vfp.vstart >= vl) {
+        return;
+    }
+
+    width = vector_get_width(env);
+    vlmax = vector_get_vlmax(env);
+
+    for (i = 0; i < vlmax; i++) {
+        dest = rd + (i / (VLEN / (2 * width)));
+        src2 = rs2 + (i / (VLEN / width));
+        src1 = rs1 + (i / (VLEN / width));
+        j = i % (VLEN / width);
+        k = i % (VLEN / (2 * width));
+        if (i < env->vfp.vstart) {
+            continue;
+        } else if (i < vl) {
+            switch (width) {
+            case 8:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].u16[k] = vwsmaccu_8(env,
+                                                    env->vfp.vreg[src2].u8[j],
+                                                    env->vfp.vreg[src1].u8[j],
+                                                    env->vfp.vreg[dest].u16[k]);
+                }
+                break;
+            case 16:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].u32[k] = vwsmaccu_16(env,
+                                                    env->vfp.vreg[src2].u16[j],
+                                                    env->vfp.vreg[src1].u16[j],
+                                                    env->vfp.vreg[dest].u32[k]);
+                }
+                break;
+            case 32:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].u64[k] = vwsmaccu_32(env,
+                                                    env->vfp.vreg[src2].u32[j],
+                                                    env->vfp.vreg[src1].u32[j],
+                                                    env->vfp.vreg[dest].u64[k]);
+                }
+                break;
+            default:
+                riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+                return;
+            }
+        } else {
+            vector_tail_widen(env, dest, k, width);
+        }
+    }
+    env->vfp.vstart = 0;
+    return;
+}
+
+/*
+ * vwsmaccu.vx vd, rs1, vs2, vm #
+ * vd[i] = clipu((+(x[rs1]*vs2[i]+round)>>SEW/2)+vd[i])
+ */
+void VECTOR_HELPER(vwsmaccu_vx)(CPURISCVState *env, uint32_t vm, uint32_t rs1,
+    uint32_t rs2, uint32_t rd)
+{
+    int width, lmul, vl, vlmax;
+    int i, j, k, dest, src2;
+
+    lmul = vector_get_lmul(env);
+
+    if (vector_vtype_ill(env)
+        || vector_overlap_vm_force(vm, rd)
+        || vector_overlap_dstgp_srcgp(rd, 2 * lmul, rs2, lmul)) {
+        riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+        return;
+    }
+
+    vector_lmul_check_reg(env, lmul, rs2, false);
+    vector_lmul_check_reg(env, lmul, rd, true);
+
+    vl = env->vfp.vl;
+    if (env->vfp.vstart >= vl) {
+        return;
+    }
+
+    width = vector_get_width(env);
+    vlmax = vector_get_vlmax(env);
+
+    for (i = 0; i < vlmax; i++) {
+        dest = rd + (i / (VLEN / (2 * width)));
+        src2 = rs2 + (i / (VLEN / width));
+        j = i % (VLEN / width);
+        k = i % (VLEN / (2 * width));
+        if (i < env->vfp.vstart) {
+            continue;
+        } else if (i < vl) {
+            switch (width) {
+            case 8:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].u16[k] = vwsmaccu_8(env,
+                                                    env->vfp.vreg[src2].u8[j],
+                                                    env->gpr[rs1],
+                                                    env->vfp.vreg[dest].u16[k]);
+                }
+                break;
+            case 16:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].u32[k] = vwsmaccu_16(env,
+                                                    env->vfp.vreg[src2].u16[j],
+                                                    env->gpr[rs1],
+                                                    env->vfp.vreg[dest].u32[k]);
+                }
+                break;
+            case 32:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].u64[k] = vwsmaccu_32(env,
+                                                    env->vfp.vreg[src2].u32[j],
+                                                    env->gpr[rs1],
+                                                    env->vfp.vreg[dest].u64[k]);
+                }
+                break;
+            default:
+                riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+                return;
+            }
+        } else {
+            vector_tail_widen(env, dest, k, width);
+        }
+    }
+    env->vfp.vstart = 0;
+    return;
+}
+
+/*
+ * vwsmacc.vv vd, vs1, vs2, vm #
+ * vd[i] = clip((+(vs1[i]*vs2[i]+round)>>SEW/2)+vd[i])
+ */
+void VECTOR_HELPER(vwsmacc_vv)(CPURISCVState *env, uint32_t vm, uint32_t rs1,
+    uint32_t rs2, uint32_t rd)
+{
+    int width, lmul, vl, vlmax;
+    int i, j, k, dest, src1, src2;
+
+    lmul = vector_get_lmul(env);
+
+    if (vector_vtype_ill(env)
+        || vector_overlap_vm_force(vm, rd)
+        || vector_overlap_dstgp_srcgp(rd, 2 * lmul, rs1, lmul)
+        || vector_overlap_dstgp_srcgp(rd, 2 * lmul, rs2, lmul)) {
+        riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+        return;
+    }
+
+    vector_lmul_check_reg(env, lmul, rs1, false);
+    vector_lmul_check_reg(env, lmul, rs2, false);
+    vector_lmul_check_reg(env, lmul, rd, true);
+
+    vl = env->vfp.vl;
+    if (env->vfp.vstart >= vl) {
+        return;
+    }
+
+    width = vector_get_width(env);
+    vlmax = vector_get_vlmax(env);
+
+    for (i = 0; i < vlmax; i++) {
+        dest = rd + (i / (VLEN / (2 * width)));
+        src2 = rs2 + (i / (VLEN / width));
+        src1 = rs1 + (i / (VLEN / width));
+        j = i % (VLEN / width);
+        k = i % (VLEN / (2 * width));
+        if (i < env->vfp.vstart) {
+            continue;
+        } else if (i < vl) {
+            switch (width) {
+            case 8:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].s16[k] = vwsmacc_8(env,
+                                                    env->vfp.vreg[src2].s8[j],
+                                                    env->vfp.vreg[src1].s8[j],
+                                                    env->vfp.vreg[dest].s16[k]);
+                }
+                break;
+            case 16:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].s32[k] = vwsmacc_16(env,
+                                                    env->vfp.vreg[src2].s16[j],
+                                                    env->vfp.vreg[src1].s16[j],
+                                                    env->vfp.vreg[dest].s32[k]);
+                }
+                break;
+            case 32:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].s64[k] = vwsmacc_32(env,
+                                                    env->vfp.vreg[src2].s32[j],
+                                                    env->vfp.vreg[src1].s32[j],
+                                                    env->vfp.vreg[dest].s64[k]);
+                }
+                break;
+            default:
+                riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+                return;
+            }
+        } else {
+            vector_tail_widen(env, dest, k, width);
+        }
+    }
+    env->vfp.vstart = 0;
+    return;
+}
+
+/*
+ * vwsmacc.vx vd, rs1, vs2, vm #
+ * vd[i] = clip((+(x[rs1]*vs2[i]+round)>>SEW/2)+vd[i])
+ */
+void VECTOR_HELPER(vwsmacc_vx)(CPURISCVState *env, uint32_t vm, uint32_t rs1,
+    uint32_t rs2, uint32_t rd)
+{
+    int width, lmul, vl, vlmax;
+    int i, j, k, dest, src2;
+
+    lmul = vector_get_lmul(env);
+
+    if (vector_vtype_ill(env)
+        || vector_overlap_vm_force(vm, rd)
+        || vector_overlap_dstgp_srcgp(rd, 2 * lmul, rs2, lmul)) {
+        riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+        return;
+    }
+
+    vector_lmul_check_reg(env, lmul, rs2, false);
+    vector_lmul_check_reg(env, lmul, rd, true);
+
+    vl = env->vfp.vl;
+    if (env->vfp.vstart >= vl) {
+        return;
+    }
+
+    width = vector_get_width(env);
+    vlmax = vector_get_vlmax(env);
+
+    for (i = 0; i < vlmax; i++) {
+        dest = rd + (i / (VLEN / (2 * width)));
+        src2 = rs2 + (i / (VLEN / width));
+        j = i % (VLEN / width);
+        k = i % (VLEN / (2 * width));
+        if (i < env->vfp.vstart) {
+            continue;
+        } else if (i < vl) {
+            switch (width) {
+            case 8:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].s16[k] = vwsmacc_8(env,
+                                                    env->vfp.vreg[src2].s8[j],
+                                                    env->gpr[rs1],
+                                                    env->vfp.vreg[dest].s16[k]);
+                }
+                break;
+            case 16:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].s32[k] = vwsmacc_16(env,
+                                                    env->vfp.vreg[src2].s16[j],
+                                                    env->gpr[rs1],
+                                                    env->vfp.vreg[dest].s32[k]);
+                }
+                break;
+            case 32:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].s64[k] = vwsmacc_32(env,
+                                                    env->vfp.vreg[src2].s32[j],
+                                                    env->gpr[rs1],
+                                                    env->vfp.vreg[dest].s64[k]);
+                }
+                break;
+            default:
+                riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+                return;
+            }
+        } else {
+            vector_tail_widen(env, dest, k, width);
+        }
+    }
+    env->vfp.vstart = 0;
+    return;
+}
+
+/*
+ * vwsmaccsu.vv vd, vs1, vs2, vm
+ * # vd[i] = clip(-((signed(vs1[i])*unsigned(vs2[i])+round)>>SEW/2)+vd[i])
+ */
+void VECTOR_HELPER(vwsmaccsu_vv)(CPURISCVState *env, uint32_t vm, uint32_t rs1,
+    uint32_t rs2, uint32_t rd)
+{
+    int width, lmul, vl, vlmax;
+    int i, j, k, dest, src1, src2;
+
+    lmul = vector_get_lmul(env);
+
+    if (vector_vtype_ill(env)
+        || vector_overlap_vm_force(vm, rd)
+        || vector_overlap_dstgp_srcgp(rd, 2 * lmul, rs1, lmul)
+        || vector_overlap_dstgp_srcgp(rd, 2 * lmul, rs2, lmul)) {
+        riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+        return;
+    }
+
+    vector_lmul_check_reg(env, lmul, rs1, false);
+    vector_lmul_check_reg(env, lmul, rs2, false);
+    vector_lmul_check_reg(env, lmul, rd, true);
+
+    vl = env->vfp.vl;
+    if (env->vfp.vstart >= vl) {
+        return;
+    }
+
+    width = vector_get_width(env);
+    vlmax = vector_get_vlmax(env);
+
+    for (i = 0; i < vlmax; i++) {
+        dest = rd + (i / (VLEN / (2 * width)));
+        src2 = rs2 + (i / (VLEN / width));
+        src1 = rs1 + (i / (VLEN / width));
+        j = i % (VLEN / width);
+        k = i % (VLEN / (2 * width));
+        if (i < env->vfp.vstart) {
+            continue;
+        } else if (i < vl) {
+            switch (width) {
+            case 8:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].s16[k] = vwsmaccsu_8(env,
+                                                    env->vfp.vreg[src2].u8[j],
+                                                    env->vfp.vreg[src1].s8[j],
+                                                    env->vfp.vreg[dest].s16[k]);
+                }
+                break;
+            case 16:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].s32[k] = vwsmaccsu_16(env,
+                                                    env->vfp.vreg[src2].u16[j],
+                                                    env->vfp.vreg[src1].s16[j],
+                                                    env->vfp.vreg[dest].s32[k]);
+                }
+                break;
+            case 32:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].s64[k] = vwsmaccsu_32(env,
+                                                    env->vfp.vreg[src2].u32[j],
+                                                    env->vfp.vreg[src1].s32[j],
+                                                    env->vfp.vreg[dest].s64[k]);
+                }
+                break;
+            default:
+                riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+                return;
+            }
+        } else {
+            vector_tail_widen(env, dest, k, width);
+        }
+    }
+    env->vfp.vstart = 0;
+    return;
+}
+
+/*
+ * vwsmaccsu.vx vd, rs1, vs2, vm
+ * # vd[i] = clip(-((signed(x[rs1])*unsigned(vs2[i])+round)>>SEW/2)+vd[i])
+ */
+void VECTOR_HELPER(vwsmaccsu_vx)(CPURISCVState *env, uint32_t vm, uint32_t rs1,
+    uint32_t rs2, uint32_t rd)
+{
+    int width, lmul, vl, vlmax;
+    int i, j, k, dest, src2;
+
+    lmul = vector_get_lmul(env);
+
+    if (vector_vtype_ill(env)
+        || vector_overlap_vm_force(vm, rd)
+        || vector_overlap_dstgp_srcgp(rd, 2 * lmul, rs2, lmul)) {
+        riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+        return;
+    }
+
+    vector_lmul_check_reg(env, lmul, rs2, false);
+    vector_lmul_check_reg(env, lmul, rd, true);
+
+    vl = env->vfp.vl;
+    if (env->vfp.vstart >= vl) {
+        return;
+    }
+
+    width = vector_get_width(env);
+    vlmax = vector_get_vlmax(env);
+
+    for (i = 0; i < vlmax; i++) {
+        dest = rd + (i / (VLEN / (2 * width)));
+        src2 = rs2 + (i / (VLEN / width));
+        j = i % (VLEN / width);
+        k = i % (VLEN / (2 * width));
+        if (i < env->vfp.vstart) {
+            continue;
+        } else if (i < vl) {
+            switch (width) {
+            case 8:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].s16[k] = vwsmaccsu_8(env,
+                                                    env->vfp.vreg[src2].u8[j],
+                                                    env->gpr[rs1],
+                                                    env->vfp.vreg[dest].s16[k]);
+                }
+                break;
+            case 16:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].s32[k] = vwsmaccsu_16(env,
+                                                    env->vfp.vreg[src2].u16[j],
+                                                    env->gpr[rs1],
+                                                    env->vfp.vreg[dest].s32[k]);
+                }
+                break;
+            case 32:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].s64[k] = vwsmaccsu_32(env,
+                                                    env->vfp.vreg[src2].u32[j],
+                                                    env->gpr[rs1],
+                                                    env->vfp.vreg[dest].s64[k]);
+                }
+                break;
+            default:
+                riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+                return;
+            }
+        } else {
+            vector_tail_widen(env, dest, k, width);
+        }
+    }
+    env->vfp.vstart = 0;
+    return;
+}
+
+/*
+ * vwsmaccus.vx vd, rs1, vs2, vm
+ * # vd[i] = clip(-((unsigned(x[rs1])*signed(vs2[i])+round)>>SEW/2)+vd[i])
+ */
+void VECTOR_HELPER(vwsmaccus_vx)(CPURISCVState *env, uint32_t vm, uint32_t rs1,
+    uint32_t rs2, uint32_t rd)
+{
+    int width, lmul, vl, vlmax;
+    int i, j, k, dest, src2;
+
+    lmul = vector_get_lmul(env);
+
+    if (vector_vtype_ill(env)
+        || vector_overlap_vm_force(vm, rd)
+        || vector_overlap_dstgp_srcgp(rd, 2 * lmul, rs2, lmul)) {
+        riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+        return;
+    }
+
+    vector_lmul_check_reg(env, lmul, rs2, false);
+    vector_lmul_check_reg(env, lmul, rd, true);
+
+    vl = env->vfp.vl;
+    if (env->vfp.vstart >= vl) {
+        return;
+    }
+
+    width = vector_get_width(env);
+    vlmax = vector_get_vlmax(env);
+
+    for (i = 0; i < vlmax; i++) {
+        dest = rd + (i / (VLEN / (2 * width)));
+        src2 = rs2 + (i / (VLEN / width));
+        j = i % (VLEN / width);
+        k = i % (VLEN / (2 * width));
+        if (i < env->vfp.vstart) {
+            continue;
+        } else if (i < vl) {
+            switch (width) {
+            case 8:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].s16[k] = vwsmaccus_8(env,
+                                                    env->vfp.vreg[src2].s8[j],
+                                                    env->gpr[rs1],
+                                                    env->vfp.vreg[dest].s16[k]);
+                }
+                break;
+            case 16:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].s32[k] = vwsmaccus_16(env,
+                                                    env->vfp.vreg[src2].s16[j],
+                                                    env->gpr[rs1],
+                                                    env->vfp.vreg[dest].s32[k]);
+                }
+                break;
+            case 32:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].s64[k] = vwsmaccus_32(env,
+                                                    env->vfp.vreg[src2].s32[j],
+                                                    env->gpr[rs1],
+                                                    env->vfp.vreg[dest].s64[k]);
+                }
+                break;
+            default:
+                riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+                return;
+            }
+        } else {
+            vector_tail_widen(env, dest, k, width);
+        }
+    }
+    env->vfp.vstart = 0;
+    return;
+}
+
+/* vssrl.vv vd, vs2, vs1, vm # vd[i] = ((vs2[i] + round)>>vs1[i] */
+void VECTOR_HELPER(vssrl_vv)(CPURISCVState *env, uint32_t vm, uint32_t rs1,
+    uint32_t rs2, uint32_t rd)
+{
+    int width, lmul, vl, vlmax;
+    int i, j, dest, src1, src2;
+
+    lmul = vector_get_lmul(env);
+
+    if (vector_vtype_ill(env) || vector_overlap_vm_common(lmul, vm, rd)) {
+        riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+        return;
+    }
+
+    vector_lmul_check_reg(env, lmul, rs1, false);
+    vector_lmul_check_reg(env, lmul, rs2, false);
+    vector_lmul_check_reg(env, lmul, rd, false);
+
+    vl = env->vfp.vl;
+    if (env->vfp.vstart >= vl) {
+        return;
+    }
+
+    width = vector_get_width(env);
+    vlmax = vector_get_vlmax(env);
+
+    for (i = 0; i < vlmax; i++) {
+        dest = rd + (i / (VLEN / width));
+        src2 = rs2 + (i / (VLEN / width));
+        src1 = rs1 + (i / (VLEN / width));
+        j = i % (VLEN / width);
+        if (i < env->vfp.vstart) {
+            continue;
+        } else if (i < vl) {
+            switch (width) {
+            case 8:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].u8[j] = vssrl_8(env,
+                        env->vfp.vreg[src2].u8[j], env->vfp.vreg[src1].u8[j]);
+                }
+                break;
+            case 16:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].u16[j] = vssrl_16(env,
+                        env->vfp.vreg[src2].u16[j], env->vfp.vreg[src1].u16[j]);
+                }
+                break;
+            case 32:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].u32[j] = vssrl_32(env,
+                        env->vfp.vreg[src2].u32[j], env->vfp.vreg[src1].u32[j]);
+                }
+                break;
+            case 64:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].u64[j] = vssrl_64(env,
+                        env->vfp.vreg[src2].u64[j], env->vfp.vreg[src1].u64[j]);
+                }
+                break;
+            default:
+                riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+                return;
+            }
+        } else {
+            vector_tail_common(env, dest, j, width);
+        }
+    }
+    env->vfp.vstart = 0;
+    return;
+}
+
+/* vssrl.vx vd, vs2, rs1, vm # vd[i] = ((vs2[i] + round)>>x[rs1]) */
+void VECTOR_HELPER(vssrl_vx)(CPURISCVState *env, uint32_t vm, uint32_t rs1,
+    uint32_t rs2, uint32_t rd)
+{
+    int width, lmul, vl, vlmax;
+    int i, j, dest, src2;
+
+    lmul = vector_get_lmul(env);
+
+    if (vector_vtype_ill(env) || vector_overlap_vm_common(lmul, vm, rd)) {
+        riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+        return;
+    }
+
+    vector_lmul_check_reg(env, lmul, rs2, false);
+    vector_lmul_check_reg(env, lmul, rd, false);
+
+    vl = env->vfp.vl;
+    if (env->vfp.vstart >= vl) {
+        return;
+    }
+
+    width = vector_get_width(env);
+    vlmax = vector_get_vlmax(env);
+
+    for (i = 0; i < vlmax; i++) {
+        dest = rd + (i / (VLEN / width));
+        src2 = rs2 + (i / (VLEN / width));
+        j = i % (VLEN / width);
+        if (i < env->vfp.vstart) {
+            continue;
+        } else if (i < vl) {
+            switch (width) {
+            case 8:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].u8[j] = vssrl_8(env,
+                        env->vfp.vreg[src2].u8[j], env->gpr[rs1]);
+                }
+                break;
+            case 16:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].u16[j] = vssrl_16(env,
+                        env->vfp.vreg[src2].u16[j], env->gpr[rs1]);
+                }
+                break;
+            case 32:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].u32[j] = vssrl_32(env,
+                        env->vfp.vreg[src2].u32[j], env->gpr[rs1]);
+                }
+                break;
+            case 64:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].u64[j] = vssrl_64(env,
+                        env->vfp.vreg[src2].u64[j], env->gpr[rs1]);
+                }
+                break;
+            default:
+                riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+                return;
+            }
+        } else {
+            vector_tail_common(env, dest, j, width);
+        }
+    }
+    env->vfp.vstart = 0;
+    return;
+}
+
+/* vssrl.vi vd, vs2, imm, vm # vd[i] = ((vs2[i] + round)>>imm) */
+void VECTOR_HELPER(vssrl_vi)(CPURISCVState *env, uint32_t vm, uint32_t rs1,
+    uint32_t rs2, uint32_t rd)
+{
+    int width, lmul, vl, vlmax;
+    int i, j, dest, src2;
+
+    lmul = vector_get_lmul(env);
+
+    if (vector_vtype_ill(env) || vector_overlap_vm_common(lmul, vm, rd)) {
+        riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+        return;
+    }
+
+    vector_lmul_check_reg(env, lmul, rs2, false);
+    vector_lmul_check_reg(env, lmul, rd, false);
+
+    vl = env->vfp.vl;
+    if (env->vfp.vstart >= vl) {
+        return;
+    }
+
+    width = vector_get_width(env);
+    vlmax = vector_get_vlmax(env);
+
+    for (i = 0; i < vlmax; i++) {
+        dest = rd + (i / (VLEN / width));
+        src2 = rs2 + (i / (VLEN / width));
+        j = i % (VLEN / width);
+        if (i < env->vfp.vstart) {
+            continue;
+        } else if (i < vl) {
+            switch (width) {
+            case 8:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].u8[j] = vssrli_8(env,
+                        env->vfp.vreg[src2].u8[j], rs1);
+                }
+                break;
+            case 16:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].u16[j] = vssrli_16(env,
+                        env->vfp.vreg[src2].u16[j], rs1);
+                }
+                break;
+            case 32:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].u32[j] = vssrli_32(env,
+                        env->vfp.vreg[src2].u32[j], rs1);
+                }
+                break;
+            case 64:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].u64[j] = vssrli_64(env,
+                        env->vfp.vreg[src2].u64[j], rs1);
+                }
+                break;
+            default:
+                riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+                return;
+            }
+        } else {
+            vector_tail_common(env, dest, j, width);
+        }
+    }
+    env->vfp.vstart = 0;
+    return;
+}
+
+/* vssra.vv vd, vs2, vs1, vm # vd[i] = ((vs2[i] + round)>>vs1[i]) */
+void VECTOR_HELPER(vssra_vv)(CPURISCVState *env, uint32_t vm, uint32_t rs1,
+    uint32_t rs2, uint32_t rd)
+{
+    int width, lmul, vl, vlmax;
+    int i, j, dest, src1, src2;
+
+    lmul = vector_get_lmul(env);
+
+    if (vector_vtype_ill(env) || vector_overlap_vm_common(lmul, vm, rd)) {
+        riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+        return;
+    }
+
+    vector_lmul_check_reg(env, lmul, rs1, false);
+    vector_lmul_check_reg(env, lmul, rs2, false);
+    vector_lmul_check_reg(env, lmul, rd, false);
+
+    vl = env->vfp.vl;
+    if (env->vfp.vstart >= vl) {
+        return;
+    }
+
+    width = vector_get_width(env);
+    vlmax = vector_get_vlmax(env);
+
+    for (i = 0; i < vlmax; i++) {
+        dest = rd + (i / (VLEN / width));
+        src2 = rs2 + (i / (VLEN / width));
+        src1 = rs1 + (i / (VLEN / width));
+        j = i % (VLEN / width);
+        if (i < env->vfp.vstart) {
+            continue;
+        } else if (i < vl) {
+            switch (width) {
+            case 8:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].s8[j] = vssra_8(env,
+                        env->vfp.vreg[src2].s8[j], env->vfp.vreg[src1].u8[j]);
+                }
+                break;
+            case 16:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].s16[j] = vssra_16(env,
+                        env->vfp.vreg[src2].s16[j], env->vfp.vreg[src1].u16[j]);
+                }
+                break;
+            case 32:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].s32[j] = vssra_32(env,
+                        env->vfp.vreg[src2].s32[j], env->vfp.vreg[src1].u32[j]);
+                }
+                break;
+            case 64:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].s64[j] = vssra_64(env,
+                        env->vfp.vreg[src2].s64[j], env->vfp.vreg[src1].u64[j]);
+                }
+                break;
+            default:
+                riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+                return;
+            }
+        } else {
+            vector_tail_common(env, dest, j, width);
+        }
+    }
+    env->vfp.vstart = 0;
+    return;
+}
+
+/* vssra.vx vd, vs2, rs1, vm # vd[i] = ((vs2[i] + round)>>x[rs1]) */
+void VECTOR_HELPER(vssra_vx)(CPURISCVState *env, uint32_t vm, uint32_t rs1,
+    uint32_t rs2, uint32_t rd)
+{
+    int width, lmul, vl, vlmax;
+    int i, j, dest, src2;
+
+    lmul = vector_get_lmul(env);
+
+    if (vector_vtype_ill(env) || vector_overlap_vm_common(lmul, vm, rd)) {
+        riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+        return;
+    }
+
+    vector_lmul_check_reg(env, lmul, rs2, false);
+    vector_lmul_check_reg(env, lmul, rd, false);
+
+    vl = env->vfp.vl;
+    if (env->vfp.vstart >= vl) {
+        return;
+    }
+
+    width = vector_get_width(env);
+    vlmax = vector_get_vlmax(env);
+
+    for (i = 0; i < vlmax; i++) {
+        dest = rd + (i / (VLEN / width));
+        src2 = rs2 + (i / (VLEN / width));
+        j = i % (VLEN / width);
+        if (i < env->vfp.vstart) {
+            continue;
+        } else if (i < vl) {
+            switch (width) {
+            case 8:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].s8[j] = vssra_8(env,
+                        env->vfp.vreg[src2].s8[j], env->gpr[rs1]);
+                }
+                break;
+            case 16:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].s16[j] = vssra_16(env,
+                        env->vfp.vreg[src2].s16[j], env->gpr[rs1]);
+                }
+                break;
+            case 32:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].s32[j] = vssra_32(env,
+                        env->vfp.vreg[src2].s32[j], env->gpr[rs1]);
+                }
+                break;
+            case 64:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].s64[j] = vssra_64(env,
+                        env->vfp.vreg[src2].s64[j], env->gpr[rs1]);
+                }
+                break;
+            default:
+                riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+                return;
+            }
+        } else {
+            vector_tail_common(env, dest, j, width);
+        }
+    }
+    env->vfp.vstart = 0;
+    return;
+}
+
+/* vssra.vi vd, vs2, imm, vm # vd[i] = ((vs2[i] + round)>>imm) */
+void VECTOR_HELPER(vssra_vi)(CPURISCVState *env, uint32_t vm, uint32_t rs1,
+    uint32_t rs2, uint32_t rd)
+{
+    int width, lmul, vl, vlmax;
+    int i, j, dest, src2;
+
+    lmul = vector_get_lmul(env);
+
+    if (vector_vtype_ill(env) || vector_overlap_vm_common(lmul, vm, rd)) {
+        riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+        return;
+    }
+
+    vector_lmul_check_reg(env, lmul, rs2, false);
+    vector_lmul_check_reg(env, lmul, rd, false);
+
+    vl = env->vfp.vl;
+    if (env->vfp.vstart >= vl) {
+        return;
+    }
+
+    width = vector_get_width(env);
+    vlmax = vector_get_vlmax(env);
+
+    for (i = 0; i < vlmax; i++) {
+        dest = rd + (i / (VLEN / width));
+        src2 = rs2 + (i / (VLEN / width));
+        j = i % (VLEN / width);
+        if (i < env->vfp.vstart) {
+            continue;
+        } else if (i < vl) {
+            switch (width) {
+            case 8:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].s8[j] = vssrai_8(env,
+                        env->vfp.vreg[src2].s8[j], rs1);
+                }
+                break;
+            case 16:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].s16[j] = vssrai_16(env,
+                        env->vfp.vreg[src2].s16[j], rs1);
+                }
+                break;
+            case 32:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].s32[j] = vssrai_32(env,
+                        env->vfp.vreg[src2].s32[j], rs1);
+                }
+                break;
+            case 64:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].s64[j] = vssrai_64(env,
+                        env->vfp.vreg[src2].s64[j], rs1);
+                }
+                break;
+            default:
+                riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+                return;
+            }
+        } else {
+            vector_tail_common(env, dest, j, width);
+        }
+    }
+    env->vfp.vstart = 0;
+    return;
+}
+
+/* vnclipu.vv vd, vs2, vs1, vm # vector-vector */
+void VECTOR_HELPER(vnclipu_vv)(CPURISCVState *env, uint32_t vm, uint32_t rs1,
+    uint32_t rs2, uint32_t rd)
+{
+    int width, lmul, vl, vlmax;
+    int i, j, dest, k, src1, src2;
+
+    lmul = vector_get_lmul(env);
+
+    if (vector_vtype_ill(env)
+            || vector_overlap_dstgp_srcgp(rd, lmul, rs2, 2 * lmul)
+            || vector_overlap_vm_common(lmul, vm, rd)) {
+        riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+        return;
+    }
+
+    vector_lmul_check_reg(env, lmul, rs1, false);
+    vector_lmul_check_reg(env, lmul, rs2, true);
+    vector_lmul_check_reg(env, lmul, rd, false);
+
+    vl = env->vfp.vl;
+    if (env->vfp.vstart >= vl) {
+        return;
+    }
+
+    width = vector_get_width(env);
+    vlmax = vector_get_vlmax(env);
+
+    for (i = 0; i < vlmax; i++) {
+        dest = rd + (i / (VLEN / width));
+        src2 = rs2 + (i / (VLEN / (2 * width)));
+        src1 = rs1 + (i / (VLEN / width));
+        j = i % (VLEN / (2 * width));
+        k = i % (VLEN / width);
+        if (i < env->vfp.vstart) {
+            continue;
+        } else if (i < vl) {
+            switch (width) {
+            case 8:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].u8[k] = vnclipu_16(env,
+                        env->vfp.vreg[src2].u16[j], env->vfp.vreg[src1].u8[k]);
+                }
+                break;
+            case 16:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].u16[k] = vnclipu_32(env,
+                        env->vfp.vreg[src2].u32[j], env->vfp.vreg[src1].u16[k]);
+                }
+                break;
+            case 32:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].u32[k] = vnclipu_64(env,
+                        env->vfp.vreg[src2].u64[j], env->vfp.vreg[src1].u32[k]);
+                }
+                break;
+            default:
+                riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+                return;
+            }
+        } else {
+            vector_tail_narrow(env, dest, k, width);
+        }
+    }
+    env->vfp.vstart = 0;
+    return;
+}
+
+/* vnclipu.vx vd, vs2, rs1, vm # vector-scalar */
+void VECTOR_HELPER(vnclipu_vx)(CPURISCVState *env, uint32_t vm, uint32_t rs1,
+    uint32_t rs2, uint32_t rd)
+{
+    int width, lmul, vl, vlmax;
+    int i, j, k, dest, src2;
+
+    lmul = vector_get_lmul(env);
+
+    if (vector_vtype_ill(env)
+            || vector_overlap_dstgp_srcgp(rd, lmul, rs2, 2 * lmul)
+            || vector_overlap_vm_common(lmul, vm, rd)) {
+        riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+        return;
+    }
+
+    vector_lmul_check_reg(env, lmul, rs2, true);
+    vector_lmul_check_reg(env, lmul, rd, false);
+
+    vl = env->vfp.vl;
+    if (env->vfp.vstart >= vl) {
+        return;
+    }
+
+    width = vector_get_width(env);
+    vlmax = vector_get_vlmax(env);
+
+    for (i = 0; i < vlmax; i++) {
+        dest = rd + (i / (VLEN / width));
+        src2 = rs2 + (i / (VLEN / (2 * width)));
+        j = i % (VLEN / (2 * width));
+        k = i % (VLEN / width);
+        if (i < env->vfp.vstart) {
+            continue;
+        } else if (i < vl) {
+            switch (width) {
+            case 8:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].u8[k] = vnclipu_16(env,
+                        env->vfp.vreg[src2].u16[j], env->gpr[rs1]);
+                }
+                break;
+            case 16:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].u16[k] = vnclipu_32(env,
+                        env->vfp.vreg[src2].u32[j], env->gpr[rs1]);
+                }
+                break;
+            case 32:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].u32[k] = vnclipu_64(env,
+                        env->vfp.vreg[src2].u64[j], env->gpr[rs1]);
+                }
+                break;
+            default:
+                riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+                return;
+            }
+        } else {
+            vector_tail_narrow(env, dest, k, width);
+        }
+    }
+    env->vfp.vstart = 0;
+    return;
+}
+
+/* vnclipu.vi vd, vs2, imm, vm # vector-immediate */
+void VECTOR_HELPER(vnclipu_vi)(CPURISCVState *env, uint32_t vm, uint32_t rs1,
+    uint32_t rs2, uint32_t rd)
+{
+    int width, lmul, vl, vlmax;
+    int i, j, k, dest, src2;
+
+    lmul = vector_get_lmul(env);
+
+    if (vector_vtype_ill(env)
+            || vector_overlap_dstgp_srcgp(rd, lmul, rs2, 2 * lmul)
+            || vector_overlap_vm_common(lmul, vm, rd)) {
+        riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+        return;
+    }
+
+    vector_lmul_check_reg(env, lmul, rs2, true);
+    vector_lmul_check_reg(env, lmul, rd, false);
+
+    vl = env->vfp.vl;
+    if (env->vfp.vstart >= vl) {
+        return;
+    }
+
+    width = vector_get_width(env);
+    vlmax = vector_get_vlmax(env);
+
+    for (i = 0; i < vlmax; i++) {
+        dest = rd + (i / (VLEN / width));
+        src2 = rs2 + (i / (VLEN / (2 * width)));
+        j = i % (VLEN / (2 * width));
+        k = i % (VLEN / width);
+        if (i < env->vfp.vstart) {
+            continue;
+        } else if (i < vl) {
+            switch (width) {
+            case 8:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].u8[k] = vnclipui_16(env,
+                        env->vfp.vreg[src2].u16[j], rs1);
+                }
+                break;
+            case 16:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].u16[k] = vnclipui_32(env,
+                        env->vfp.vreg[src2].u32[j], rs1);
+                }
+                break;
+            case 32:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].u32[k] = vnclipui_64(env,
+                        env->vfp.vreg[src2].u64[j], rs1);
+                }
+                break;
+            default:
+                riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+                return;
+            }
+        } else {
+            vector_tail_narrow(env, dest, k, width);
+        }
+    }
+    env->vfp.vstart = 0;
+    return;
+}
+
+/* vnclip.vv vd, vs2, vs1, vm # vector-vector */
+void VECTOR_HELPER(vnclip_vv)(CPURISCVState *env, uint32_t vm, uint32_t rs1,
+    uint32_t rs2, uint32_t rd)
+{
+    int width, lmul, vl, vlmax;
+    int i, j, dest, k, src1, src2;
+
+    lmul = vector_get_lmul(env);
+
+    if (vector_vtype_ill(env)
+            || vector_overlap_dstgp_srcgp(rd, lmul, rs2, 2 * lmul)
+            || vector_overlap_vm_common(lmul, vm, rd)) {
+        riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+        return;
+    }
+
+    vector_lmul_check_reg(env, lmul, rs1, false);
+    vector_lmul_check_reg(env, lmul, rs2, true);
+    vector_lmul_check_reg(env, lmul, rd, false);
+
+    vl = env->vfp.vl;
+    if (env->vfp.vstart >= vl) {
+        return;
+    }
+
+    width = vector_get_width(env);
+    vlmax = vector_get_vlmax(env);
+
+    for (i = 0; i < vlmax; i++) {
+        dest = rd + (i / (VLEN / width));
+        src2 = rs2 + (i / (VLEN / (2 * width)));
+        src1 = rs1 + (i / (VLEN / width));
+        j = i % (VLEN / (2 * width));
+        k = i % (VLEN / width);
+        if (i < env->vfp.vstart) {
+            continue;
+        } else if (i < vl) {
+            switch (width) {
+            case 8:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].s8[k] = vnclip_16(env,
+                        env->vfp.vreg[src2].s16[j], env->vfp.vreg[src1].u8[k]);
+                }
+                break;
+            case 16:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].s16[k] = vnclip_32(env,
+                        env->vfp.vreg[src2].s32[j], env->vfp.vreg[src1].u16[k]);
+                }
+                break;
+            case 32:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].s32[k] = vnclip_64(env,
+                        env->vfp.vreg[src2].s64[j], env->vfp.vreg[src1].u32[k]);
+                }
+                break;
+            default:
+                riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+                return;
+            }
+        } else {
+            vector_tail_narrow(env, dest, k, width);
+        }
+    }
+    env->vfp.vstart = 0;
+    return;
+}
+
+/* vnclip.vx vd, vs2, rs1, vm # vector-scalar */
+void VECTOR_HELPER(vnclip_vx)(CPURISCVState *env, uint32_t vm, uint32_t rs1,
+    uint32_t rs2, uint32_t rd)
+{
+    int width, lmul, vl, vlmax;
+    int i, j, dest, k, src2;
+
+    lmul = vector_get_lmul(env);
+
+    if (vector_vtype_ill(env)
+            || vector_overlap_dstgp_srcgp(rd, lmul, rs2, 2 * lmul)
+            || vector_overlap_vm_common(lmul, vm, rd)) {
+        riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+        return;
+    }
+
+    vector_lmul_check_reg(env, lmul, rs2, true);
+    vector_lmul_check_reg(env, lmul, rd, false);
+
+    vl = env->vfp.vl;
+    if (env->vfp.vstart >= vl) {
+        return;
+    }
+
+    width = vector_get_width(env);
+    vlmax = vector_get_vlmax(env);
+
+    for (i = 0; i < vlmax; i++) {
+        dest = rd + (i / (VLEN / width));
+        src2 = rs2 + (i / (VLEN / (2 * width)));
+        j = i % (VLEN / (2 * width));
+        k = i % (VLEN / width);
+        if (i < env->vfp.vstart) {
+            continue;
+        } else if (i < vl) {
+            switch (width) {
+            case 8:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].s8[k] = vnclip_16(env,
+                        env->vfp.vreg[src2].s16[j], env->gpr[rs1]);
+                }
+                break;
+            case 16:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].s16[k] = vnclip_32(env,
+                        env->vfp.vreg[src2].s32[j], env->gpr[rs1]);
+                }
+                break;
+            case 32:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].s32[k] = vnclip_64(env,
+                        env->vfp.vreg[src2].s64[j], env->gpr[rs1]);
+                }
+                break;
+            default:
+                riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+                return;
+            }
+        } else {
+            vector_tail_narrow(env, dest, k, width);
+        }
+    }
+    env->vfp.vstart = 0;
+    return;
+}
+
+/* vnclip.vi vd, vs2, imm, vm # vector-immediate */
+void VECTOR_HELPER(vnclip_vi)(CPURISCVState *env, uint32_t vm, uint32_t rs1,
+    uint32_t rs2, uint32_t rd)
+{
+    int width, lmul, vl, vlmax;
+    int i, j, dest, k, src2;
+
+    lmul = vector_get_lmul(env);
+
+    if (vector_vtype_ill(env)
+            || vector_overlap_dstgp_srcgp(rd, lmul, rs2, 2 * lmul)
+            || vector_overlap_vm_common(lmul, vm, rd)) {
+        riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+        return;
+    }
+
+    vector_lmul_check_reg(env, lmul, rs2, true);
+    vector_lmul_check_reg(env, lmul, rd, false);
+
+    vl = env->vfp.vl;
+    if (env->vfp.vstart >= vl) {
+        return;
+    }
+
+    width = vector_get_width(env);
+    vlmax = vector_get_vlmax(env);
+
+    for (i = 0; i < vlmax; i++) {
+        dest = rd + (i / (VLEN / width));
+        src2 = rs2 + (i / (VLEN / (2 * width)));
+        j = i % (VLEN / (2 * width));
+        k = i % (VLEN / width);
+        if (i < env->vfp.vstart) {
+            continue;
+        } else if (i < vl) {
+            switch (width) {
+            case 8:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].s8[k] = vnclipi_16(env,
+                        env->vfp.vreg[src2].s16[j], rs1);
+                }
+                break;
+            case 16:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].s16[k] = vnclipi_32(env,
+                        env->vfp.vreg[src2].s32[j], rs1);
+                }
+                break;
+            case 32:
+                if (vector_elem_mask(env, vm, width, lmul, i)) {
+                    env->vfp.vreg[dest].s32[k] = vnclipi_64(env,
+                        env->vfp.vreg[src2].s64[j], rs1);
+                }
+                break;
+            default:
+                riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+                return;
+            }
+        } else {
+            vector_tail_narrow(env, dest, k, width);
+        }
+    }
+    env->vfp.vstart = 0;
+    return;
+}
-- 
2.7.4



Return-Path: <SRS0=MTtZ=AN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6523C433E0
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 16:40:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 84F8C20720
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 16:40:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="SBr3VUuo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 84F8C20720
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45840 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jr2Fl-00011f-Kx
	for qemu-devel@archiver.kernel.org; Thu, 02 Jul 2020 12:40:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33514)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=4451fe355=alistair.francis@wdc.com>)
 id 1jr29b-0003bO-Cf
 for qemu-devel@nongnu.org; Thu, 02 Jul 2020 12:33:39 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:44864)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=4451fe355=alistair.francis@wdc.com>)
 id 1jr29Z-00008e-8q
 for qemu-devel@nongnu.org; Thu, 02 Jul 2020 12:33:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1593707617; x=1625243617;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=6FduJjRKLBB1ju5wKSVHJ1TuQdzggW09bNB5uiXQaGI=;
 b=SBr3VUuoBgB3TahtALSe9YsUFzUXEoz64NUvaGiSuup8LcSXjT6eGb6E
 N8f/c+ooMnTMzaSz6IZZ7535MdYWVJkw9icqq0HpqqebqhUnbniydbfwX
 O2LyNAYa2RIhGkO1rwHEsYf8JPMiM9r5NRs2hoE+RvxJEMAehwS6CgIFS
 p2mSItgX3QrQbI6DExu+gOw488EjP7D+awdxzDbAQJddHOyr8WCpaAJX2
 6IZJa/Luh534jOdbMVPhV2L9W3scqx4+2T28XnUxxPY9Jemippcbtb4KX
 V79r28dylICLiWTkfjMLi5N/vIMtqhQ1nFaWNEJ06BpKy8YFcSS7y/da1 Q==;
IronPort-SDR: UanUJOaaaVXCEsNmhbVNVRS8GunOCB3On1gZDpwpU2WSJdRETcp8wJAZHzhyczbeqODuR3pnCP
 36kdArQUvK4/9qCaJNASBd5PJC1WXSdbbTDVr0iK2AuVvsfaIYvRGC/0UuYc7XvKGGqC8u2tpG
 iRO+mmv/rB0JRypZORH6msIu0AYxgbV5mQPlNNnSbR4giQagmdOIwNhrvoJljDU4NVIKmKwYtT
 xrbIri+fQrSu/tX4qpVZO0JgjEecWqZXknuvs37ArXtRFMrrYfCetR0KuQXnyhxVunZVeGTqJO
 bjw=
X-IronPort-AV: E=Sophos;i="5.75,304,1589212800"; d="scan'208";a="141498467"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 03 Jul 2020 00:33:21 +0800
IronPort-SDR: nqxQYnzrOcEkuCy/kXAx1k5VggFESVUXCU7WwpR8xlYKGRRpvgHR3kz28QwWqNdycDpD4AesFO
 30COZsLaRCpYYQ46OzQ+NrSsydHZNyOGo=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Jul 2020 09:21:36 -0700
IronPort-SDR: Dwq7LgCx3YfB0Fdho3WYCbvtvsrDRuuQpLPz1NrUnaIvfhna8h4zqim/k9MgIGXY7T1rVYiPLM
 +YVDSUamYRMA==
WDCIronportException: Internal
Received: from 6hj08h2.ad.shared (HELO risc6-mainframe.hgst.com)
 ([10.86.58.118])
 by uls-op-cesaip01.wdc.com with ESMTP; 02 Jul 2020 09:33:20 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: peter.maydell@linaro.org,
	qemu-devel@nongnu.org
Subject: [PULL v2 06/64] target/riscv: support vector extension csr
Date: Thu,  2 Jul 2020 09:22:56 -0700
Message-Id: <20200702162354.928528-7-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200702162354.928528-1-alistair.francis@wdc.com>
References: <20200702162354.928528-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.71.154.42;
 envelope-from=prvs=4451fe355=alistair.francis@wdc.com;
 helo=esa4.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/02 12:33:30
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: alistair23@gmail.com, Richard Henderson <richard.henderson@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>, LIU Zhiwei <zhiwei_liu@c-sky.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: LIU Zhiwei <zhiwei_liu@c-sky.com>

The v0.7.1 specification does not define vector status within mstatus.
A future revision will define the privileged portion of the vector status.

Signed-off-by: LIU Zhiwei <zhiwei_liu@c-sky.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20200701152549.1218-4-zhiwei_liu@c-sky.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu_bits.h | 15 +++++++++
 target/riscv/csr.c      | 75 ++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 89 insertions(+), 1 deletion(-)

diff --git a/target/riscv/cpu_bits.h b/target/riscv/cpu_bits.h
index 7f64ee1174..8117e8b5a7 100644
--- a/target/riscv/cpu_bits.h
+++ b/target/riscv/cpu_bits.h
@@ -29,6 +29,14 @@
 #define FSR_NXA             (FPEXC_NX << FSR_AEXC_SHIFT)
 #define FSR_AEXC            (FSR_NVA | FSR_OFA | FSR_UFA | FSR_DZA | FSR_NXA)
 
+/* Vector Fixed-Point round model */
+#define FSR_VXRM_SHIFT      9
+#define FSR_VXRM            (0x3 << FSR_VXRM_SHIFT)
+
+/* Vector Fixed-Point saturation flag */
+#define FSR_VXSAT_SHIFT     8
+#define FSR_VXSAT           (0x1 << FSR_VXSAT_SHIFT)
+
 /* Control and Status Registers */
 
 /* User Trap Setup */
@@ -48,6 +56,13 @@
 #define CSR_FRM             0x002
 #define CSR_FCSR            0x003
 
+/* User Vector CSRs */
+#define CSR_VSTART          0x008
+#define CSR_VXSAT           0x009
+#define CSR_VXRM            0x00a
+#define CSR_VL              0xc20
+#define CSR_VTYPE           0xc21
+
 /* User Timers and Counters */
 #define CSR_CYCLE           0xc00
 #define CSR_TIME            0xc01
diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index 383be0a955..ac01c835e1 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -46,6 +46,10 @@ void riscv_set_csr_ops(int csrno, riscv_csr_operations *ops)
 static int fs(CPURISCVState *env, int csrno)
 {
 #if !defined(CONFIG_USER_ONLY)
+    /* loose check condition for fcsr in vector extension */
+    if ((csrno == CSR_FCSR) && (env->misa & RVV)) {
+        return 0;
+    }
     if (!env->debugger && !riscv_cpu_fp_enabled(env)) {
         return -1;
     }
@@ -53,6 +57,14 @@ static int fs(CPURISCVState *env, int csrno)
     return 0;
 }
 
+static int vs(CPURISCVState *env, int csrno)
+{
+    if (env->misa & RVV) {
+        return 0;
+    }
+    return -1;
+}
+
 static int ctr(CPURISCVState *env, int csrno)
 {
 #if !defined(CONFIG_USER_ONLY)
@@ -154,6 +166,10 @@ static int read_fcsr(CPURISCVState *env, int csrno, target_ulong *val)
 #endif
     *val = (riscv_cpu_get_fflags(env) << FSR_AEXC_SHIFT)
         | (env->frm << FSR_RD_SHIFT);
+    if (vs(env, csrno) >= 0) {
+        *val |= (env->vxrm << FSR_VXRM_SHIFT)
+                | (env->vxsat << FSR_VXSAT_SHIFT);
+    }
     return 0;
 }
 
@@ -166,10 +182,62 @@ static int write_fcsr(CPURISCVState *env, int csrno, target_ulong val)
     env->mstatus |= MSTATUS_FS;
 #endif
     env->frm = (val & FSR_RD) >> FSR_RD_SHIFT;
+    if (vs(env, csrno) >= 0) {
+        env->vxrm = (val & FSR_VXRM) >> FSR_VXRM_SHIFT;
+        env->vxsat = (val & FSR_VXSAT) >> FSR_VXSAT_SHIFT;
+    }
     riscv_cpu_set_fflags(env, (val & FSR_AEXC) >> FSR_AEXC_SHIFT);
     return 0;
 }
 
+static int read_vtype(CPURISCVState *env, int csrno, target_ulong *val)
+{
+    *val = env->vtype;
+    return 0;
+}
+
+static int read_vl(CPURISCVState *env, int csrno, target_ulong *val)
+{
+    *val = env->vl;
+    return 0;
+}
+
+static int read_vxrm(CPURISCVState *env, int csrno, target_ulong *val)
+{
+    *val = env->vxrm;
+    return 0;
+}
+
+static int write_vxrm(CPURISCVState *env, int csrno, target_ulong val)
+{
+    env->vxrm = val;
+    return 0;
+}
+
+static int read_vxsat(CPURISCVState *env, int csrno, target_ulong *val)
+{
+    *val = env->vxsat;
+    return 0;
+}
+
+static int write_vxsat(CPURISCVState *env, int csrno, target_ulong val)
+{
+    env->vxsat = val;
+    return 0;
+}
+
+static int read_vstart(CPURISCVState *env, int csrno, target_ulong *val)
+{
+    *val = env->vstart;
+    return 0;
+}
+
+static int write_vstart(CPURISCVState *env, int csrno, target_ulong val)
+{
+    env->vstart = val;
+    return 0;
+}
+
 /* User Timers and Counters */
 static int read_instret(CPURISCVState *env, int csrno, target_ulong *val)
 {
@@ -1183,7 +1251,12 @@ static riscv_csr_operations csr_ops[CSR_TABLE_SIZE] = {
     [CSR_FFLAGS] =              { fs,   read_fflags,      write_fflags      },
     [CSR_FRM] =                 { fs,   read_frm,         write_frm         },
     [CSR_FCSR] =                { fs,   read_fcsr,        write_fcsr        },
-
+    /* Vector CSRs */
+    [CSR_VSTART] =              { vs,   read_vstart,      write_vstart      },
+    [CSR_VXSAT] =               { vs,   read_vxsat,       write_vxsat       },
+    [CSR_VXRM] =                { vs,   read_vxrm,        write_vxrm        },
+    [CSR_VL] =                  { vs,   read_vl                             },
+    [CSR_VTYPE] =               { vs,   read_vtype                          },
     /* User Timers and Counters */
     [CSR_CYCLE] =               { ctr,  read_instret                        },
     [CSR_INSTRET] =             { ctr,  read_instret                        },
-- 
2.27.0



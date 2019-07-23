Return-Path: <SRS0=3Ld+=VU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3530CC7618B
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2019 12:08:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0D9AC218B8
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2019 12:08:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D9AC218B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41978 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hptbG-00026b-1p
	for qemu-devel@archiver.kernel.org; Tue, 23 Jul 2019 08:08:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36353)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hptaq-0000aq-0d
 for qemu-devel@nongnu.org; Tue, 23 Jul 2019 08:08:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hptao-0003Ar-Ah
 for qemu-devel@nongnu.org; Tue, 23 Jul 2019 08:08:31 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50588)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>)
 id 1hptao-0003AD-0n; Tue, 23 Jul 2019 08:08:30 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 2E5753082128;
 Tue, 23 Jul 2019 12:08:29 +0000 (UTC)
Received: from x1w.redhat.com (ovpn-204-56.brq.redhat.com [10.40.204.56])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 10A7D60497;
 Tue, 23 Jul 2019 12:08:26 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Date: Tue, 23 Jul 2019 14:08:16 +0200
Message-Id: <20190723120816.1361-3-philmd@redhat.com>
In-Reply-To: <20190723120816.1361-1-philmd@redhat.com>
References: <20190723120816.1361-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.42]); Tue, 23 Jul 2019 12:08:29 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH-for-4.2 2/2] target/riscv/pmp: Convert
 qemu_log_mask(LOG_TRACE) to trace events
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
Cc: qemu-riscv@nongnu.org, Sagar Karandikar <sagark@eecs.berkeley.edu>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Palmer Dabbelt <palmer@sifive.com>,
 KONRAD Frederic <frederic.konrad@adacore.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Use the always-compiled trace events, remove the now unused
RISCV_DEBUG_PMP definition.

Note pmpaddr_csr_read() could previously do out-of-bound accesses
passing addr_index >=3D MAX_RISCV_PMPS.

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 target/riscv/pmp.c        | 31 ++++++++++---------------------
 target/riscv/trace-events |  6 ++++++
 2 files changed, 16 insertions(+), 21 deletions(-)

diff --git a/target/riscv/pmp.c b/target/riscv/pmp.c
index d836288cb4..d4f1007109 100644
--- a/target/riscv/pmp.c
+++ b/target/riscv/pmp.c
@@ -27,14 +27,7 @@
 #include "qemu/log.h"
 #include "qapi/error.h"
 #include "cpu.h"
-
-#define RISCV_DEBUG_PMP 0
-#define PMP_DEBUG(fmt, ...)                                             =
       \
-    do {                                                                =
       \
-        if (RISCV_DEBUG_PMP) {                                          =
       \
-            qemu_log_mask(LOG_TRACE, "%s: " fmt "\n", __func__, ##__VA_A=
RGS__);\
-        }                                                               =
       \
-    } while (0)
+#include "trace.h"
=20
 static void pmp_write_cfg(CPURISCVState *env, uint32_t addr_index,
     uint8_t val);
@@ -302,8 +295,7 @@ void pmpcfg_csr_write(CPURISCVState *env, uint32_t re=
g_index,
     int i;
     uint8_t cfg_val;
=20
-    PMP_DEBUG("hart " TARGET_FMT_ld ": reg%d, val: 0x" TARGET_FMT_lx,
-        env->mhartid, reg_index, val);
+    trace_pmpcfg_csr_write(env->mhartid, reg_index, val);
=20
     if ((reg_index & 1) && (sizeof(target_ulong) =3D=3D 8)) {
         qemu_log_mask(LOG_GUEST_ERROR,
@@ -332,9 +324,7 @@ target_ulong pmpcfg_csr_read(CPURISCVState *env, uint=
32_t reg_index)
         val =3D pmp_read_cfg(env, (reg_index * sizeof(target_ulong)) + i=
);
         cfg_val |=3D (val << (i * 8));
     }
-
-    PMP_DEBUG("hart " TARGET_FMT_ld ": reg%d, val: 0x" TARGET_FMT_lx,
-        env->mhartid, reg_index, cfg_val);
+    trace_pmpcfg_csr_read(env->mhartid, reg_index, cfg_val);
=20
     return cfg_val;
 }
@@ -346,9 +336,7 @@ target_ulong pmpcfg_csr_read(CPURISCVState *env, uint=
32_t reg_index)
 void pmpaddr_csr_write(CPURISCVState *env, uint32_t addr_index,
     target_ulong val)
 {
-    PMP_DEBUG("hart " TARGET_FMT_ld ": addr%d, val: 0x" TARGET_FMT_lx,
-        env->mhartid, addr_index, val);
-
+    trace_pmpaddr_csr_write(env->mhartid, addr_index, val);
     if (addr_index < MAX_RISCV_PMPS) {
         if (!pmp_is_locked(env, addr_index)) {
             env->pmp_state.pmp[addr_index].addr_reg =3D val;
@@ -369,14 +357,15 @@ void pmpaddr_csr_write(CPURISCVState *env, uint32_t=
 addr_index,
  */
 target_ulong pmpaddr_csr_read(CPURISCVState *env, uint32_t addr_index)
 {
-    PMP_DEBUG("hart " TARGET_FMT_ld ": addr%d, val: 0x" TARGET_FMT_lx,
-        env->mhartid, addr_index,
-        env->pmp_state.pmp[addr_index].addr_reg);
+    target_ulong val =3D 0;
+
     if (addr_index < MAX_RISCV_PMPS) {
-        return env->pmp_state.pmp[addr_index].addr_reg;
+        val =3D env->pmp_state.pmp[addr_index].addr_reg;
+        trace_pmpaddr_csr_read(env->mhartid, addr_index, val);
     } else {
         qemu_log_mask(LOG_GUEST_ERROR,
                       "ignoring pmpaddr read - out of bounds\n");
-        return 0;
     }
+
+    return val;
 }
diff --git a/target/riscv/trace-events b/target/riscv/trace-events
index 48af0373df..4b6c652ae9 100644
--- a/target/riscv/trace-events
+++ b/target/riscv/trace-events
@@ -1,2 +1,8 @@
 # target/riscv/cpu_helper.c
 riscv_trap(uint64_t hartid, bool async, uint64_t cause, uint64_t epc, ui=
nt64_t tval, const char *desc) "hart:%"PRId64", async:%d, cause:%"PRId64"=
, epc:0x%"PRIx64", tval:0x%"PRIx64", desc=3D%s"
+
+# pmp.c
+pmpcfg_csr_read(uint64_t mhartid, uint32_t reg_index, uint64_t val) "har=
t %" PRIu64 ": read reg%" PRIu32", val: 0x%" PRIx64
+pmpcfg_csr_write(uint64_t mhartid, uint32_t reg_index, uint64_t val) "ha=
rt %" PRIu64 ": write reg%" PRIu32", val: 0x%" PRIx64
+pmpaddr_csr_read(uint64_t mhartid, uint32_t addr_index, uint64_t val) "h=
art %" PRIu64 ": read addr%" PRIu32", val: 0x%" PRIx64
+pmpaddr_csr_write(uint64_t mhartid, uint32_t addr_index, uint64_t val) "=
hart %" PRIu64 ": write addr%" PRIu32", val: 0x%" PRIx64
--=20
2.20.1



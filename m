Return-Path: <SRS0=+QfZ=VN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA2ADC76188
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2019 12:20:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B31742173B
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2019 12:20:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B31742173B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47988 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hnMRy-0002tl-N7
	for qemu-devel@archiver.kernel.org; Tue, 16 Jul 2019 08:20:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53899)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <bounces@canonical.com>) id 1hnMRn-0002Sr-12
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 08:20:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bounces@canonical.com>) id 1hnMRl-0005fa-EI
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 08:20:42 -0400
Received: from indium.canonical.com ([91.189.90.7]:37630)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bounces@canonical.com>)
 id 1hnMRl-0005ex-7I
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 08:20:41 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1hnMRk-0005A7-38
 for <qemu-devel@nongnu.org>; Tue, 16 Jul 2019 12:20:40 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 15F062E8005
 for <qemu-devel@nongnu.org>; Tue, 16 Jul 2019 12:20:40 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 16 Jul 2019 12:13:52 -0000
From: =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=Confirmed; importance=Undecided;
 assignee=None; 
X-Launchpad-Bug-Tags: linux-user ppc
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: ajbennee alex-bennee scherft
X-Launchpad-Bug-Reporter: Daan Scherft (scherft)
X-Launchpad-Bug-Modifier: =?utf-8?q?Alex_Benn=C3=A9e_=28ajbennee=29?=
References: <156318593102.28533.3075291509963886255.malonedeb@chaenomeles.canonical.com>
Message-Id: <20190716121352.302-1-alex.bennee@linaro.org>
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com); Revision="19007";
 Instance="launchpad-lazr.conf"
X-Launchpad-Hash: db70db90361cc763d148bf56aa3769b7e5bc6f90
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 91.189.90.7
Subject: [Qemu-devel] [Bug 1836558] [RFC PATCH for 4.1?] target/ppc: move
 opcode decode tables to PowerPCCPU
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-To: Bug 1836558 <1836558@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190716121352.dul_hLPx1d-GWqa0ETWfiEThnaKAOYJceeV_thq0zpw@z>

The opcode decode tables aren't really part of the CPUPPCState but an
internal implementation detail for the translator. This can cause
problems with memcpy in cpu_copy as any table created during
ppc_cpu_realize get written over causing a memory leak. To avoid this
move the tables into PowerPCCPU which is better suited to hold
internal implementation details.

Attempts to fix: https://bugs.launchpad.net/qemu/+bug/1836558
Cc: 1836558@bugs.launchpad.net
Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
---
 target/ppc/cpu.h                |  8 ++++----
 target/ppc/translate.c          |  3 ++-
 target/ppc/translate_init.inc.c | 16 +++++++---------
 3 files changed, 13 insertions(+), 14 deletions(-)

diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
index c9beba2a5c0..10e34b69b75 100644
--- a/target/ppc/cpu.h
+++ b/target/ppc/cpu.h
@@ -1104,10 +1104,6 @@ struct CPUPPCState {
     bool resume_as_sreset;
 #endif
 =

-    /* Those resources are used only during code translation */
-    /* opcode handlers */
-    opc_handler_t *opcodes[PPC_CPU_OPCODES_LEN];
-
     /* Those resources are used only in QEMU core */
     target_ulong hflags;      /* hflags is a MSR & HFLAGS_MASK         */
     target_ulong hflags_nmsr; /* specific hflags, not coming from MSR */
@@ -1191,6 +1187,10 @@ struct PowerPCCPU {
     int32_t node_id; /* NUMA node this CPU belongs to */
     PPCHash64Options *hash64_opts;
 =

+    /* Those resources are used only during code translation */
+    /* opcode handlers */
+    opc_handler_t *opcodes[PPC_CPU_OPCODES_LEN];
+
     /* Fields related to migration compatibility hacks */
     bool pre_2_8_migration;
     target_ulong mig_msr_mask;
diff --git a/target/ppc/translate.c b/target/ppc/translate.c
index 4a5de280365..c0faab8a824 100644
--- a/target/ppc/translate.c
+++ b/target/ppc/translate.c
@@ -7857,6 +7857,7 @@ static bool ppc_tr_breakpoint_check(DisasContextBase =
*dcbase, CPUState *cs,
 static void ppc_tr_translate_insn(DisasContextBase *dcbase, CPUState *cs)
 {
     DisasContext *ctx =3D container_of(dcbase, DisasContext, base);
+    PowerPCCPU *cpu =3D POWERPC_CPU(cs);
     CPUPPCState *env =3D cs->env_ptr;
     opc_handler_t **table, *handler;
 =

@@ -7874,7 +7875,7 @@ static void ppc_tr_translate_insn(DisasContextBase *d=
cbase, CPUState *cs)
               opc3(ctx->opcode), opc4(ctx->opcode),
               ctx->le_mode ? "little" : "big");
     ctx->base.pc_next +=3D 4;
-    table =3D env->opcodes;
+    table =3D cpu->opcodes;
     handler =3D table[opc1(ctx->opcode)];
     if (is_indirect_opcode(handler)) {
         table =3D ind_table(handler);
diff --git a/target/ppc/translate_init.inc.c b/target/ppc/translate_init.in=
c.c
index 86fc8f2e316..9cd2033bb92 100644
--- a/target/ppc/translate_init.inc.c
+++ b/target/ppc/translate_init.inc.c
@@ -9440,14 +9440,13 @@ static void fix_opcode_tables(opc_handler_t **ppc_o=
pcodes)
 static void create_ppc_opcodes(PowerPCCPU *cpu, Error **errp)
 {
     PowerPCCPUClass *pcc =3D POWERPC_CPU_GET_CLASS(cpu);
-    CPUPPCState *env =3D &cpu->env;
     opcode_t *opc;
 =

-    fill_new_table(env->opcodes, PPC_CPU_OPCODES_LEN);
+    fill_new_table(cpu->opcodes, PPC_CPU_OPCODES_LEN);
     for (opc =3D opcodes; opc < &opcodes[ARRAY_SIZE(opcodes)]; opc++) {
         if (((opc->handler.type & pcc->insns_flags) !=3D 0) ||
             ((opc->handler.type2 & pcc->insns_flags2) !=3D 0)) {
-            if (register_insn(env->opcodes, opc) < 0) {
+            if (register_insn(cpu->opcodes, opc) < 0) {
                 error_setg(errp, "ERROR initializing PowerPC instruction "
                            "0x%02x 0x%02x 0x%02x", opc->opc1, opc->opc2,
                            opc->opc3);
@@ -9455,7 +9454,7 @@ static void create_ppc_opcodes(PowerPCCPU *cpu, Error=
 **errp)
             }
         }
     }
-    fix_opcode_tables(env->opcodes);
+    fix_opcode_tables(cpu->opcodes);
     fflush(stdout);
     fflush(stderr);
 }
@@ -10023,7 +10022,6 @@ static void ppc_cpu_unrealize(DeviceState *dev, Err=
or **errp)
 {
     PowerPCCPU *cpu =3D POWERPC_CPU(dev);
     PowerPCCPUClass *pcc =3D POWERPC_CPU_GET_CLASS(cpu);
-    CPUPPCState *env =3D &cpu->env;
     Error *local_err =3D NULL;
     opc_handler_t **table, **table_2;
     int i, j, k;
@@ -10035,11 +10033,11 @@ static void ppc_cpu_unrealize(DeviceState *dev, E=
rror **errp)
     }
 =

     for (i =3D 0; i < PPC_CPU_OPCODES_LEN; i++) {
-        if (env->opcodes[i] =3D=3D &invalid_handler) {
+        if (cpu->opcodes[i] =3D=3D &invalid_handler) {
             continue;
         }
-        if (is_indirect_opcode(env->opcodes[i])) {
-            table =3D ind_table(env->opcodes[i]);
+        if (is_indirect_opcode(cpu->opcodes[i])) {
+            table =3D ind_table(cpu->opcodes[i]);
             for (j =3D 0; j < PPC_CPU_INDIRECT_OPCODES_LEN; j++) {
                 if (table[j] =3D=3D &invalid_handler) {
                     continue;
@@ -10057,7 +10055,7 @@ static void ppc_cpu_unrealize(DeviceState *dev, Err=
or **errp)
                                              ~PPC_INDIRECT));
                 }
             }
-            g_free((opc_handler_t *)((uintptr_t)env->opcodes[i] &
+            g_free((opc_handler_t *)((uintptr_t)cpu->opcodes[i] &
                 ~PPC_INDIRECT));
         }
     }
-- =

2.20.1

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1836558

Title:
  Qemu-ppc Memory leak creating threads

Status in QEMU:
  Confirmed

Bug description:
  When creating c++ threads (with c++ std::thread), the resulting binary
  has memory leaks when running with qemu-ppc.

  Eg the following c++ program, when compiled with gcc, consumes more
  and more memory while running at qemu-ppc. (does not have memory leaks
  when compiling for Intel, when running same binary on real powerpc CPU
  hardware also no memory leaks).

  (Note I used function getCurrentRSS to show available memory, see
  https://stackoverflow.com/questions/669438/how-to-get-memory-usage-at-
  runtime-using-c; calls commented out here)

  Compiler: powerpc-linux-gnu-g++ (Debian 8.3.0-2) 8.3.0 (but same problem =
with older g++ compilers even 4.9)
  Os: Debian 10.0 ( Buster) (but same problem seen on Debian 9/stetch)
  qemu: qemu-ppc version 3.1.50


  ---

  #include <iostream>
  #include <thread>
  #include <chrono>

  =

  using namespace std::chrono_literals;

  // Create/run and join a 100 threads.
  void Fun100()
  {
  //    auto b4 =3D getCurrentRSS();
  //    std::cout << getCurrentRSS() << std::endl;
      for(int n =3D 0; n < 100; n++)
      {
          std::thread t([]
          {
              std::this_thread::sleep_for( 10ms );
          });
  //        std::cout << n << ' ' << getCurrentRSS() << std::endl;
          t.join();
      }
      std::this_thread::sleep_for( 500ms ); // to give OS some time to wipe=
 memory...
  //    auto after =3D getCurrentRSS();
      std::cout << b4 << ' ' << after << std::endl;
  }

  =

  int main(int, char **)
  {
      Fun100();
      Fun100();  // memory used keeps increasing
  }

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1836558/+subscriptions


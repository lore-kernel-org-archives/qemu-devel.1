Return-Path: <SRS0=QtPl=S4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12AD7C43218
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Apr 2019 06:21:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C797E206BA
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Apr 2019 06:21:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="BJR24zGx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C797E206BA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:40105 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hJuEe-0003A0-T0
	for qemu-devel@archiver.kernel.org; Fri, 26 Apr 2019 02:21:25 -0400
Received: from eggs.gnu.org ([209.51.188.92]:60130)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hJu0c-0005Z8-II
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 02:07:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hJu0Y-0004UG-TA
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 02:06:54 -0400
Received: from bilbo.ozlabs.org ([2401:3900:2:1::2]:58449 helo=ozlabs.org)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
	id 1hJu0Y-0004Od-6F; Fri, 26 Apr 2019 02:06:50 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
	id 44r3Tm0bsrz9sNJ; Fri, 26 Apr 2019 16:06:34 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=gibson.dropbear.id.au; s=201602; t=1556258796;
	bh=tex7puElr/hdrgW60sKFDFTqZBlhAKgaGYVO6K52Hp0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BJR24zGxoOSAc6lMT49QrV/LZHbew3MGKiUdGH94Xwk2bkwtOhloKDtzmEGS7hjuq
	nizv3gGA+Z54oFrktt5yDDstVKCs6fEvxMbNBf/QoKEJ+m0sWtvKb5BZYruyn7s4r6
	TM78Ly+TuIK8n2KQGLMaVAjFrTfmM7IYI7PSIZAc=
From: David Gibson <david@gibson.dropbear.id.au>
To: peter.maydell@linaro.org
Date: Fri, 26 Apr 2019 16:06:01 +1000
Message-Id: <20190426060627.18153-11-david@gibson.dropbear.id.au>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190426060627.18153-1-david@gibson.dropbear.id.au>
References: <20190426060627.18153-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2401:3900:2:1::2
Subject: [Qemu-devel] [PULL 10/36] target/ppc: Style fixes for excp_helper.c
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
Cc: gkurz@kaod.org, Greg Kurz <groug@kaod.org>, qemu-devel@nongnu.org,
	qemu-ppc@nongnu.org, clg@kaod.org,
	David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190426060601.NxpWm1vn-JsJbumucGBEl0ulHRhffatVx51Hj-yh8o4@z>

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>
Reviewed-by: Greg Kurz <groug@kaod.org>
---
 target/ppc/excp_helper.c | 87 ++++++++++++++++++++++++----------------
 1 file changed, 53 insertions(+), 34 deletions(-)

diff --git a/target/ppc/excp_helper.c b/target/ppc/excp_helper.c
index beafcf1ebd..ec2c177091 100644
--- a/target/ppc/excp_helper.c
+++ b/target/ppc/excp_helper.c
@@ -25,9 +25,9 @@
 #include "internal.h"
 #include "helper_regs.h"
=20
-//#define DEBUG_OP
-//#define DEBUG_SOFTWARE_TLB
-//#define DEBUG_EXCEPTIONS
+/* #define DEBUG_OP */
+/* #define DEBUG_SOFTWARE_TLB */
+/* #define DEBUG_EXCEPTIONS */
=20
 #ifdef DEBUG_EXCEPTIONS
 #  define LOG_EXCP(...) qemu_log(__VA_ARGS__)
@@ -126,8 +126,9 @@ static uint64_t ppc_excp_vector_offset(CPUState *cs, =
int ail)
     return offset;
 }
=20
-/* Note that this function should be greatly optimized
- * when called with a constant excp, from ppc_hw_interrupt
+/*
+ * Note that this function should be greatly optimized when called
+ * with a constant excp, from ppc_hw_interrupt
  */
 static inline void powerpc_excp(PowerPCCPU *cpu, int excp_model, int exc=
p)
 {
@@ -147,7 +148,8 @@ static inline void powerpc_excp(PowerPCCPU *cpu, int =
excp_model, int excp)
         msr =3D env->msr & ~0x783f0000ULL;
     }
=20
-    /* new interrupt handler msr preserves existing HV and ME unless
+    /*
+     * new interrupt handler msr preserves existing HV and ME unless
      * explicitly overriden
      */
     new_msr =3D env->msr & (((target_ulong)1 << MSR_ME) | MSR_HVB);
@@ -166,7 +168,8 @@ static inline void powerpc_excp(PowerPCCPU *cpu, int =
excp_model, int excp)
         excp =3D powerpc_reset_wakeup(cs, env, excp, &msr);
     }
=20
-    /* Exception targetting modifiers
+    /*
+     * Exception targetting modifiers
      *
      * LPES0 is supported on POWER7/8/9
      * LPES1 is not supported (old iSeries mode)
@@ -194,7 +197,8 @@ static inline void powerpc_excp(PowerPCCPU *cpu, int =
excp_model, int excp)
         ail =3D 0;
     }
=20
-    /* Hypervisor emulation assistance interrupt only exists on server
+    /*
+     * Hypervisor emulation assistance interrupt only exists on server
      * arch 2.05 server or later. We also don't want to generate it if
      * we don't have HVB in msr_mask (PAPR mode).
      */
@@ -229,8 +233,9 @@ static inline void powerpc_excp(PowerPCCPU *cpu, int =
excp_model, int excp)
         break;
     case POWERPC_EXCP_MCHECK:    /* Machine check exception             =
     */
         if (msr_me =3D=3D 0) {
-            /* Machine check exception is not enabled.
-             * Enter checkstop state.
+            /*
+             * Machine check exception is not enabled.  Enter
+             * checkstop state.
              */
             fprintf(stderr, "Machine check while not allowed. "
                     "Entering checkstop state\n");
@@ -242,8 +247,9 @@ static inline void powerpc_excp(PowerPCCPU *cpu, int =
excp_model, int excp)
             cpu_interrupt_exittb(cs);
         }
         if (env->msr_mask & MSR_HVB) {
-            /* ISA specifies HV, but can be delivered to guest with HV c=
lear
-             * (e.g., see FWNMI in PAPR).
+            /*
+             * ISA specifies HV, but can be delivered to guest with HV
+             * clear (e.g., see FWNMI in PAPR).
              */
             new_msr |=3D (target_ulong)MSR_HVB;
         }
@@ -294,9 +300,10 @@ static inline void powerpc_excp(PowerPCCPU *cpu, int=
 excp_model, int excp)
         break;
     case POWERPC_EXCP_ALIGN:     /* Alignment exception                 =
     */
         /* Get rS/rD and rA from faulting opcode */
-        /* Note: the opcode fields will not be set properly for a direct
-         * store load/store, but nobody cares as nobody actually uses
-         * direct store segments.
+        /*
+         * Note: the opcode fields will not be set properly for a
+         * direct store load/store, but nobody cares as nobody
+         * actually uses direct store segments.
          */
         env->spr[SPR_DSISR] |=3D (env->error_code & 0x03FF0000) >> 16;
         break;
@@ -310,7 +317,8 @@ static inline void powerpc_excp(PowerPCCPU *cpu, int =
excp_model, int excp)
                 return;
             }
=20
-            /* FP exceptions always have NIP pointing to the faulting
+            /*
+             * FP exceptions always have NIP pointing to the faulting
              * instruction, so always use store_next and claim we are
              * precise in the MSR.
              */
@@ -341,7 +349,8 @@ static inline void powerpc_excp(PowerPCCPU *cpu, int =
excp_model, int excp)
         dump_syscall(env);
         lev =3D env->error_code;
=20
-        /* We need to correct the NIP which in this case is supposed
+        /*
+         * We need to correct the NIP which in this case is supposed
          * to point to the next instruction
          */
         env->nip +=3D 4;
@@ -425,8 +434,9 @@ static inline void powerpc_excp(PowerPCCPU *cpu, int =
excp_model, int excp)
             new_msr |=3D ((target_ulong)1 << MSR_ME);
         }
         if (env->msr_mask & MSR_HVB) {
-            /* ISA specifies HV, but can be delivered to guest with HV c=
lear
-             * (e.g., see FWNMI in PAPR, NMI injection in QEMU).
+            /*
+             * ISA specifies HV, but can be delivered to guest with HV
+             * clear (e.g., see FWNMI in PAPR, NMI injection in QEMU).
              */
             new_msr |=3D (target_ulong)MSR_HVB;
         } else {
@@ -675,7 +685,8 @@ static inline void powerpc_excp(PowerPCCPU *cpu, int =
excp_model, int excp)
         env->spr[asrr1] =3D env->spr[srr1];
     }
=20
-    /* Sort out endianness of interrupt, this differs depending on the
+    /*
+     * Sort out endianness of interrupt, this differs depending on the
      * CPU, the HV mode, etc...
      */
 #ifdef TARGET_PPC64
@@ -716,8 +727,9 @@ static inline void powerpc_excp(PowerPCCPU *cpu, int =
excp_model, int excp)
     }
     vector |=3D env->excp_prefix;
=20
-    /* AIL only works if there is no HV transition and we are running wi=
th
-     * translations enabled
+    /*
+     * AIL only works if there is no HV transition and we are running
+     * with translations enabled
      */
     if (!((msr >> MSR_IR) & 1) || !((msr >> MSR_DR) & 1) ||
         ((new_msr & MSR_HVB) && !(msr & MSR_HVB))) {
@@ -745,8 +757,9 @@ static inline void powerpc_excp(PowerPCCPU *cpu, int =
excp_model, int excp)
         }
     }
 #endif
-    /* We don't use hreg_store_msr here as already have treated
-     * any special case that could occur. Just store MSR and update hfla=
gs
+    /*
+     * We don't use hreg_store_msr here as already have treated any
+     * special case that could occur. Just store MSR and update hflags
      *
      * Note: We *MUST* not use hreg_store_msr() as-is anyway because it
      * will prevent setting of the HV bit which some exceptions might ne=
ed
@@ -762,8 +775,9 @@ static inline void powerpc_excp(PowerPCCPU *cpu, int =
excp_model, int excp)
     /* Reset the reservation */
     env->reserve_addr =3D -1;
=20
-    /* Any interrupt is context synchronizing, check if TCG TLB
-     * needs a delayed flush on ppc64
+    /*
+     * Any interrupt is context synchronizing, check if TCG TLB needs
+     * a delayed flush on ppc64
      */
     check_tlb_flush(env, false);
 }
@@ -1015,8 +1029,9 @@ void helper_pminsn(CPUPPCState *env, powerpc_pm_ins=
n_t insn)
     cs =3D CPU(ppc_env_get_cpu(env));
     cs->halted =3D 1;
=20
-    /* The architecture specifies that HDEC interrupts are
-     * discarded in PM states
+    /*
+     * The architecture specifies that HDEC interrupts are discarded
+     * in PM states
      */
     env->pending_interrupts &=3D ~(1 << PPC_INTERRUPT_HDECR);
=20
@@ -1047,8 +1062,9 @@ static inline void do_rfi(CPUPPCState *env, target_=
ulong nip, target_ulong msr)
 #if defined(DEBUG_OP)
     cpu_dump_rfi(env->nip, env->msr);
 #endif
-    /* No need to raise an exception here,
-     * as rfi is always the last insn of a TB
+    /*
+     * No need to raise an exception here, as rfi is always the last
+     * insn of a TB
      */
     cpu_interrupt_exittb(cs);
     /* Reset the reservation */
@@ -1067,8 +1083,9 @@ void helper_rfi(CPUPPCState *env)
 #if defined(TARGET_PPC64)
 void helper_rfid(CPUPPCState *env)
 {
-    /* The architeture defines a number of rules for which bits
-     * can change but in practice, we handle this in hreg_store_msr()
+    /*
+     * The architeture defines a number of rules for which bits can
+     * change but in practice, we handle this in hreg_store_msr()
      * which will be called by do_rfi(), so there is no need to filter
      * here
      */
@@ -1206,9 +1223,11 @@ static int book3s_dbell2irq(target_ulong rb)
 {
     int msg =3D rb & DBELL_TYPE_MASK;
=20
-    /* A Directed Hypervisor Doorbell message is sent only if the
+    /*
+     * A Directed Hypervisor Doorbell message is sent only if the
      * message type is 5. All other types are reserved and the
-     * instruction is a no-op */
+     * instruction is a no-op
+     */
     return msg =3D=3D DBELL_TYPE_DBELL_SERVER ? PPC_INTERRUPT_HDOORBELL =
: -1;
 }
=20
--=20
2.20.1



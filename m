Return-Path: <SRS0=8dir=WF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12BEBC433FF
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Aug 2019 07:02:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DEC6B206DF
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Aug 2019 07:02:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DEC6B206DF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56892 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hvyvL-0004Ss-5f
	for qemu-devel@archiver.kernel.org; Fri, 09 Aug 2019 03:02:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48594)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <armbru@redhat.com>) id 1hvygP-00011Q-Mm
 for qemu-devel@nongnu.org; Fri, 09 Aug 2019 02:47:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1hvygN-00021U-I8
 for qemu-devel@nongnu.org; Fri, 09 Aug 2019 02:47:25 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40617)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1hvygN-000217-9N
 for qemu-devel@nongnu.org; Fri, 09 Aug 2019 02:47:23 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 968763090FC1;
 Fri,  9 Aug 2019 06:47:22 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-117-142.ams2.redhat.com
 [10.36.117.142])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 7062660BF1;
 Fri,  9 Aug 2019 06:47:19 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id A1E401136426; Fri,  9 Aug 2019 08:46:45 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Date: Fri,  9 Aug 2019 08:46:30 +0200
Message-Id: <20190809064645.22656-15-armbru@redhat.com>
In-Reply-To: <20190809064645.22656-1-armbru@redhat.com>
References: <20190809064645.22656-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.43]); Fri, 09 Aug 2019 06:47:22 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v3 14/29] migration: Move the
 VMStateDescription typedef to typedefs.h
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
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We declare incomplete struct VMStateDescription in a couple of places
so we don't have to include migration/vmstate.h for the typedef.
That's fine with me.  However, the next commit will drop
migration/vmstate.h from a massive number of compiles.  Move the
typedef to qemu/typedefs.h now, so I don't have to insert struct in
front of VMStateDescription all over the place then.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 include/hw/qdev-core.h      | 6 ++----
 include/migration/vmstate.h | 1 -
 include/qemu/typedefs.h     | 1 +
 include/qom/cpu.h           | 4 ++--
 target/alpha/cpu.h          | 2 +-
 target/arm/cpu.h            | 2 +-
 target/cris/cpu.h           | 2 +-
 target/hppa/cpu.h           | 2 +-
 target/i386/cpu.h           | 2 +-
 target/lm32/cpu.h           | 2 +-
 target/mips/internal.h      | 2 +-
 target/openrisc/cpu.h       | 2 +-
 target/ppc/cpu-qom.h        | 2 +-
 target/ppc/cpu.h            | 2 +-
 target/s390x/cpu.h          | 2 +-
 target/sparc/cpu.h          | 2 +-
 16 files changed, 17 insertions(+), 19 deletions(-)

diff --git a/include/hw/qdev-core.h b/include/hw/qdev-core.h
index b870c8ceeb..e5b62dd2fc 100644
--- a/include/hw/qdev-core.h
+++ b/include/hw/qdev-core.h
@@ -35,8 +35,6 @@ typedef void (*DeviceReset)(DeviceState *dev);
 typedef void (*BusRealize)(BusState *bus, Error **errp);
 typedef void (*BusUnrealize)(BusState *bus, Error **errp);
=20
-struct VMStateDescription;
-
 /**
  * DeviceClass:
  * @props: Properties accessing state fields.
@@ -112,7 +110,7 @@ typedef struct DeviceClass {
     DeviceUnrealize unrealize;
=20
     /* device state */
-    const struct VMStateDescription *vmsd;
+    const VMStateDescription *vmsd;
=20
     /* Private to qdev / bus.  */
     const char *bus_type;
@@ -425,7 +423,7 @@ void device_class_set_parent_unrealize(DeviceClass *d=
c,
                                        DeviceUnrealize dev_unrealize,
                                        DeviceUnrealize *parent_unrealize=
);
=20
-const struct VMStateDescription *qdev_get_vmsd(DeviceState *dev);
+const VMStateDescription *qdev_get_vmsd(DeviceState *dev);
=20
 const char *qdev_fw_name(DeviceState *dev);
=20
diff --git a/include/migration/vmstate.h b/include/migration/vmstate.h
index c2bfa7a7f0..1fbfd099dd 100644
--- a/include/migration/vmstate.h
+++ b/include/migration/vmstate.h
@@ -28,7 +28,6 @@
 #define QEMU_VMSTATE_H
=20
 typedef struct VMStateInfo VMStateInfo;
-typedef struct VMStateDescription VMStateDescription;
 typedef struct VMStateField VMStateField;
=20
 /* VMStateInfo allows customized migration of objects that don't fit in
diff --git a/include/qemu/typedefs.h b/include/qemu/typedefs.h
index c32efb5b18..9e1283aacf 100644
--- a/include/qemu/typedefs.h
+++ b/include/qemu/typedefs.h
@@ -101,6 +101,7 @@ typedef struct SHPCDevice SHPCDevice;
 typedef struct SSIBus SSIBus;
 typedef struct VirtIODevice VirtIODevice;
 typedef struct Visitor Visitor;
+typedef struct VMStateDescription VMStateDescription;
=20
 /*
  * Pointer types
diff --git a/include/qom/cpu.h b/include/qom/cpu.h
index 5ee0046b62..ddb91bbaff 100644
--- a/include/qom/cpu.h
+++ b/include/qom/cpu.h
@@ -215,7 +215,7 @@ typedef struct CPUClass {
     int (*write_elf32_qemunote)(WriteCoreDumpFunction f, CPUState *cpu,
                                 void *opaque);
=20
-    const struct VMStateDescription *vmsd;
+    const VMStateDescription *vmsd;
     const char *gdb_core_xml_file;
     gchar * (*gdb_arch_name)(CPUState *cpu);
     const char * (*gdb_get_dynamic_xml)(CPUState *cpu, const char *xmlna=
me);
@@ -1108,7 +1108,7 @@ bool target_words_bigendian(void);
 #ifdef NEED_CPU_H
=20
 #ifdef CONFIG_SOFTMMU
-extern const struct VMStateDescription vmstate_cpu_common;
+extern const VMStateDescription vmstate_cpu_common;
 #else
 #define vmstate_cpu_common vmstate_dummy
 #endif
diff --git a/target/alpha/cpu.h b/target/alpha/cpu.h
index b3e8a823e1..4619530660 100644
--- a/target/alpha/cpu.h
+++ b/target/alpha/cpu.h
@@ -277,7 +277,7 @@ struct AlphaCPU {
=20
=20
 #ifndef CONFIG_USER_ONLY
-extern const struct VMStateDescription vmstate_alpha_cpu;
+extern const VMStateDescription vmstate_alpha_cpu;
 #endif
=20
 void alpha_cpu_do_interrupt(CPUState *cpu);
diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 94c990cddb..2cdde6c4bc 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -922,7 +922,7 @@ void arm_cpu_post_init(Object *obj);
 uint64_t arm_cpu_mp_affinity(int idx, uint8_t clustersz);
=20
 #ifndef CONFIG_USER_ONLY
-extern const struct VMStateDescription vmstate_arm_cpu;
+extern const VMStateDescription vmstate_arm_cpu;
 #endif
=20
 void arm_cpu_do_interrupt(CPUState *cpu);
diff --git a/target/cris/cpu.h b/target/cris/cpu.h
index fb14ad51f1..aba0a66474 100644
--- a/target/cris/cpu.h
+++ b/target/cris/cpu.h
@@ -183,7 +183,7 @@ struct CRISCPU {
=20
=20
 #ifndef CONFIG_USER_ONLY
-extern const struct VMStateDescription vmstate_cris_cpu;
+extern const VMStateDescription vmstate_cris_cpu;
 #endif
=20
 void cris_cpu_do_interrupt(CPUState *cpu);
diff --git a/target/hppa/cpu.h b/target/hppa/cpu.h
index e9fba96be9..4b816cc13a 100644
--- a/target/hppa/cpu.h
+++ b/target/hppa/cpu.h
@@ -334,7 +334,7 @@ bool hppa_cpu_tlb_fill(CPUState *cs, vaddr address, i=
nt size,
 int hppa_get_physical_address(CPUHPPAState *env, vaddr addr, int mmu_idx=
,
                               int type, hwaddr *pphys, int *pprot);
 extern const MemoryRegionOps hppa_io_eir_ops;
-extern const struct VMStateDescription vmstate_hppa_cpu;
+extern const VMStateDescription vmstate_hppa_cpu;
 void hppa_cpu_alarm_timer(void *);
 int hppa_artype_for_page(CPUHPPAState *env, target_ulong vaddr);
 #endif
diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 8b3dc5533e..ecd0ec0899 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -1516,7 +1516,7 @@ struct X86CPU {
=20
=20
 #ifndef CONFIG_USER_ONLY
-extern struct VMStateDescription vmstate_x86_cpu;
+extern VMStateDescription vmstate_x86_cpu;
 #endif
=20
 /**
diff --git a/target/lm32/cpu.h b/target/lm32/cpu.h
index c2bbfa2780..064c6b1267 100644
--- a/target/lm32/cpu.h
+++ b/target/lm32/cpu.h
@@ -195,7 +195,7 @@ struct LM32CPU {
=20
=20
 #ifndef CONFIG_USER_ONLY
-extern const struct VMStateDescription vmstate_lm32_cpu;
+extern const VMStateDescription vmstate_lm32_cpu;
 #endif
=20
 void lm32_cpu_do_interrupt(CPUState *cpu);
diff --git a/target/mips/internal.h b/target/mips/internal.h
index b2b41a51ab..d5aa5490d3 100644
--- a/target/mips/internal.h
+++ b/target/mips/internal.h
@@ -148,7 +148,7 @@ hwaddr cpu_mips_translate_address(CPUMIPSState *env, =
target_ulong address,
 #define cpu_signal_handler cpu_mips_signal_handler
=20
 #ifndef CONFIG_USER_ONLY
-extern const struct VMStateDescription vmstate_mips_cpu;
+extern const VMStateDescription vmstate_mips_cpu;
 #endif
=20
 static inline bool cpu_mips_hw_interrupts_enabled(CPUMIPSState *env)
diff --git a/target/openrisc/cpu.h b/target/openrisc/cpu.h
index f23b25262d..61ade1d4f0 100644
--- a/target/openrisc/cpu.h
+++ b/target/openrisc/cpu.h
@@ -333,7 +333,7 @@ int print_insn_or1k(bfd_vma addr, disassemble_info *i=
nfo);
 #define cpu_signal_handler cpu_openrisc_signal_handler
=20
 #ifndef CONFIG_USER_ONLY
-extern const struct VMStateDescription vmstate_openrisc_cpu;
+extern const VMStateDescription vmstate_openrisc_cpu;
=20
 /* hw/openrisc_pic.c */
 void cpu_openrisc_pic_init(OpenRISCCPU *cpu);
diff --git a/target/ppc/cpu-qom.h b/target/ppc/cpu-qom.h
index be9b4c30c3..a2f202f021 100644
--- a/target/ppc/cpu-qom.h
+++ b/target/ppc/cpu-qom.h
@@ -203,7 +203,7 @@ typedef struct PPCTimebase {
     int64_t time_of_the_day_ns;
 } PPCTimebase;
=20
-extern const struct VMStateDescription vmstate_ppc_timebase;
+extern const VMStateDescription vmstate_ppc_timebase;
=20
 #define VMSTATE_PPC_TIMEBASE_V(_field, _state, _version) {            \
     .name       =3D (stringify(_field)),                                =
\
diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
index c9beba2a5c..4ea33cf696 100644
--- a/target/ppc/cpu.h
+++ b/target/ppc/cpu.h
@@ -1255,7 +1255,7 @@ int ppc32_cpu_write_elf32_note(WriteCoreDumpFunctio=
n f, CPUState *cs,
                                int cpuid, void *opaque);
 #ifndef CONFIG_USER_ONLY
 void ppc_cpu_do_system_reset(CPUState *cs);
-extern const struct VMStateDescription vmstate_ppc_cpu;
+extern const VMStateDescription vmstate_ppc_cpu;
 #endif
=20
 /***********************************************************************=
******/
diff --git a/target/s390x/cpu.h b/target/s390x/cpu.h
index a606547b4d..3d9de25f7c 100644
--- a/target/s390x/cpu.h
+++ b/target/s390x/cpu.h
@@ -163,7 +163,7 @@ struct S390CPU {
=20
=20
 #ifndef CONFIG_USER_ONLY
-extern const struct VMStateDescription vmstate_s390_cpu;
+extern const VMStateDescription vmstate_s390_cpu;
 #endif
=20
 /* distinguish between 24 bit and 31 bit addressing */
diff --git a/target/sparc/cpu.h b/target/sparc/cpu.h
index 8ed2250cd0..0d5b01efe5 100644
--- a/target/sparc/cpu.h
+++ b/target/sparc/cpu.h
@@ -532,7 +532,7 @@ struct SPARCCPU {
=20
=20
 #ifndef CONFIG_USER_ONLY
-extern const struct VMStateDescription vmstate_sparc_cpu;
+extern const VMStateDescription vmstate_sparc_cpu;
 #endif
=20
 void sparc_cpu_do_interrupt(CPUState *cpu);
--=20
2.21.0



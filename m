Return-Path: <SRS0=s522=46=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C29DC4CECE
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2020 04:08:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CA4EA206FA
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2020 04:08:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="CLz67zEw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA4EA206FA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53550 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jCbcL-0006pj-2A
	for qemu-devel@archiver.kernel.org; Fri, 13 Mar 2020 00:08:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44178)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1jCba7-0003Pi-P1
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 00:05:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1jCba6-00076R-4g
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 00:05:55 -0400
Received: from ozlabs.org ([2401:3900:2:1::2]:45881)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1jCba5-0006rM-Cy; Fri, 13 Mar 2020 00:05:54 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 48dsYj3P9Tz9sSZ; Fri, 13 Mar 2020 15:05:45 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1584072345;
 bh=ZyGNsReuHLghgU8doLbna1YKekJoPV2uMcvG/SjAWAo=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=CLz67zEwjFhsRlWUROzzbOOezNmrIzOnAspTVRhWIjdQUyg3/ulTFuXyTmJApuLQ5
 Oahf6FTjFbc7/aDV+1M0pe8MEkiSBjVuAUULCKQzzllVrWl6Pwb2KVQHWC2BK8kV49
 kqchnSuf2cViQD/WfIA/MNaHd0jM0WWNvxeD/UWM=
From: David Gibson <david@gibson.dropbear.id.au>
To: groug@kaod.org,
	clg@kaod.org,
	philmd@redhat.com
Subject: [PATCH 3/4] spapr: Rename DT functions to newer naming convention
Date: Fri, 13 Mar 2020 15:05:38 +1100
Message-Id: <20200313040539.819138-4-david@gibson.dropbear.id.au>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200313040539.819138-1-david@gibson.dropbear.id.au>
References: <20200313040539.819138-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2401:3900:2:1::2
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
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

In the spapr code we've been gradually moving towards a convention that
functions which create pieces of the device tree are called spapr_dt_*().
This patch speeds that along by renaming most of the things that don't ye=
t
match that so that they do.

For now we leave the *_dt_populate() functions which are actual methods
used in the DRCClass::dt_populate method.

While we're there we remove a few comments that don't really say anything
useful.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/spapr.c              | 62 +++++++++++++++++--------------------
 hw/ppc/spapr_ovec.c         |  4 +--
 include/hw/ppc/spapr_ovec.h |  4 +--
 3 files changed, 33 insertions(+), 37 deletions(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index fc28d9df25..6c32ec3c0a 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -217,10 +217,9 @@ static int spapr_fixup_cpu_numa_dt(void *fdt, int of=
fset, PowerPCCPU *cpu)
                           sizeof(associativity));
 }
=20
-/* Populate the "ibm,pa-features" property */
-static void spapr_populate_pa_features(SpaprMachineState *spapr,
-                                       PowerPCCPU *cpu,
-                                       void *fdt, int offset)
+static void spapr_dt_pa_features(SpaprMachineState *spapr,
+                                 PowerPCCPU *cpu,
+                                 void *fdt, int offset)
 {
     uint8_t pa_features_206[] =3D { 6, 0,
         0xf6, 0x1f, 0xc7, 0x00, 0x80, 0xc0 };
@@ -315,8 +314,8 @@ static void add_str(GString *s, const gchar *s1)
     g_string_append_len(s, s1, strlen(s1) + 1);
 }
=20
-static int spapr_populate_memory_node(void *fdt, int nodeid, hwaddr star=
t,
-                                       hwaddr size)
+static int spapr_dt_memory_node(void *fdt, int nodeid, hwaddr start,
+                                hwaddr size)
 {
     uint32_t associativity[] =3D {
         cpu_to_be32(0x4), /* length */
@@ -391,9 +390,8 @@ spapr_get_drconf_cell(uint32_t seq_lmbs, uint64_t bas=
e_addr,
     return elem;
 }
=20
-/* ibm,dynamic-memory-v2 */
-static int spapr_populate_drmem_v2(SpaprMachineState *spapr, void *fdt,
-                                   int offset, MemoryDeviceInfoList *dim=
ms)
+static int spapr_dt_dynamic_memory_v2(SpaprMachineState *spapr, void *fd=
t,
+                                      int offset, MemoryDeviceInfoList *=
dimms)
 {
     MachineState *machine =3D MACHINE(spapr);
     uint8_t *int_buf, *cur_index;
@@ -484,8 +482,7 @@ static int spapr_populate_drmem_v2(SpaprMachineState =
*spapr, void *fdt,
     return 0;
 }
=20
-/* ibm,dynamic-memory */
-static int spapr_populate_drmem_v1(SpaprMachineState *spapr, void *fdt,
+static int spapr_dt_dynamic_memory(SpaprMachineState *spapr, void *fdt,
                                    int offset, MemoryDeviceInfoList *dim=
ms)
 {
     MachineState *machine =3D MACHINE(spapr);
@@ -554,7 +551,8 @@ static int spapr_populate_drmem_v1(SpaprMachineState =
*spapr, void *fdt,
  * Refer to docs/specs/ppc-spapr-hotplug.txt for the documentation
  * of this device tree node.
  */
-static int spapr_populate_drconf_memory(SpaprMachineState *spapr, void *=
fdt)
+static int spapr_dt_dynamic_reconfiguration_memory(SpaprMachineState *sp=
apr,
+                                                   void *fdt)
 {
     MachineState *machine =3D MACHINE(spapr);
     int nb_numa_nodes =3D machine->numa_state->num_nodes;
@@ -593,9 +591,9 @@ static int spapr_populate_drconf_memory(SpaprMachineS=
tate *spapr, void *fdt)
     /* ibm,dynamic-memory or ibm,dynamic-memory-v2 */
     dimms =3D qmp_memory_device_list();
     if (spapr_ovec_test(spapr->ov5_cas, OV5_DRMEM_V2)) {
-        ret =3D spapr_populate_drmem_v2(spapr, fdt, offset, dimms);
+        ret =3D spapr_dt_dynamic_memory_v2(spapr, fdt, offset, dimms);
     } else {
-        ret =3D spapr_populate_drmem_v1(spapr, fdt, offset, dimms);
+        ret =3D spapr_dt_dynamic_memory(spapr, fdt, offset, dimms);
     }
     qapi_free_MemoryDeviceInfoList(dimms);
=20
@@ -626,7 +624,7 @@ static int spapr_populate_drconf_memory(SpaprMachineS=
tate *spapr, void *fdt)
     return ret;
 }
=20
-static int spapr_populate_memory(SpaprMachineState *spapr, void *fdt)
+static int spapr_dt_memory(SpaprMachineState *spapr, void *fdt)
 {
     MachineState *machine =3D MACHINE(spapr);
     SpaprMachineClass *smc =3D SPAPR_MACHINE_GET_CLASS(spapr);
@@ -649,7 +647,7 @@ static int spapr_populate_memory(SpaprMachineState *s=
papr, void *fdt)
         if (!mem_start) {
             /* spapr_machine_init() checks for rma_size <=3D node0_size
              * already */
-            spapr_populate_memory_node(fdt, i, 0, spapr->rma_size);
+            spapr_dt_memory_node(fdt, i, 0, spapr->rma_size);
             mem_start +=3D spapr->rma_size;
             node_size -=3D spapr->rma_size;
         }
@@ -661,7 +659,7 @@ static int spapr_populate_memory(SpaprMachineState *s=
papr, void *fdt)
                 sizetmp =3D 1ULL << ctzl(mem_start);
             }
=20
-            spapr_populate_memory_node(fdt, i, mem_start, sizetmp);
+            spapr_dt_memory_node(fdt, i, mem_start, sizetmp);
             node_size -=3D sizetmp;
             mem_start +=3D sizetmp;
         }
@@ -672,7 +670,7 @@ static int spapr_populate_memory(SpaprMachineState *s=
papr, void *fdt)
         int ret;
=20
         g_assert(smc->dr_lmb_enabled);
-        ret =3D spapr_populate_drconf_memory(spapr, fdt);
+        ret =3D spapr_dt_dynamic_reconfiguration_memory(spapr, fdt);
         if (ret) {
             return ret;
         }
@@ -681,8 +679,8 @@ static int spapr_populate_memory(SpaprMachineState *s=
papr, void *fdt)
     return 0;
 }
=20
-static void spapr_populate_cpu_dt(CPUState *cs, void *fdt, int offset,
-                                  SpaprMachineState *spapr)
+static void spapr_dt_cpu(CPUState *cs, void *fdt, int offset,
+                         SpaprMachineState *spapr)
 {
     MachineState *ms =3D MACHINE(spapr);
     PowerPCCPU *cpu =3D POWERPC_CPU(cs);
@@ -782,7 +780,7 @@ static void spapr_populate_cpu_dt(CPUState *cs, void =
*fdt, int offset,
                           page_sizes_prop, page_sizes_prop_size)));
     }
=20
-    spapr_populate_pa_features(spapr, cpu, fdt, offset);
+    spapr_dt_pa_features(spapr, cpu, fdt, offset);
=20
     _FDT((fdt_setprop_cell(fdt, offset, "ibm,chip-id",
                            cs->cpu_index / vcpus_per_socket)));
@@ -816,7 +814,7 @@ static void spapr_populate_cpu_dt(CPUState *cs, void =
*fdt, int offset,
                               pcc->lrg_decr_bits)));
 }
=20
-static void spapr_populate_cpus_dt_node(void *fdt, SpaprMachineState *sp=
apr)
+static void spapr_dt_cpus(void *fdt, SpaprMachineState *spapr)
 {
     CPUState **rev;
     CPUState *cs;
@@ -860,13 +858,13 @@ static void spapr_populate_cpus_dt_node(void *fdt, =
SpaprMachineState *spapr)
         offset =3D fdt_add_subnode(fdt, cpus_offset, nodename);
         g_free(nodename);
         _FDT(offset);
-        spapr_populate_cpu_dt(cs, fdt, offset, spapr);
+        spapr_dt_cpu(cs, fdt, offset, spapr);
     }
=20
     g_free(rev);
 }
=20
-static int spapr_rng_populate_dt(void *fdt)
+static int spapr_dt_rng(void *fdt)
 {
     int node;
     int ret;
@@ -1099,8 +1097,7 @@ static void spapr_dt_chosen(SpaprMachineState *spap=
r, void *fdt)
=20
     spapr_dt_ov5_platform_support(spapr, fdt, chosen);
=20
-    _FDT(spapr_ovec_populate_dt(fdt, offset, spapr->ov5_cas,
-                                "ibm,architecture-vec-5"));
+    _FDT(spapr_dt_ovec(fdt, chosen, spapr->ov5_cas, "ibm,architecture-ve=
c-5"));
=20
     g_free(stdout_path);
     g_free(bootlist);
@@ -1181,7 +1178,7 @@ void *spapr_build_fdt(SpaprMachineState *spapr, boo=
l reset, size_t space)
     /* /interrupt controller */
     spapr_irq_dt(spapr, spapr_max_server_number(spapr), fdt, PHANDLE_INT=
C);
=20
-    ret =3D spapr_populate_memory(spapr, fdt);
+    ret =3D spapr_dt_memory(spapr, fdt);
     if (ret < 0) {
         error_report("couldn't setup memory nodes in fdt");
         exit(1);
@@ -1191,7 +1188,7 @@ void *spapr_build_fdt(SpaprMachineState *spapr, boo=
l reset, size_t space)
     spapr_dt_vdevice(spapr->vio_bus, fdt);
=20
     if (object_resolve_path_type("", TYPE_SPAPR_RNG, NULL)) {
-        ret =3D spapr_rng_populate_dt(fdt);
+        ret =3D spapr_dt_rng(fdt);
         if (ret < 0) {
             error_report("could not set up rng device in the fdt");
             exit(1);
@@ -1206,8 +1203,7 @@ void *spapr_build_fdt(SpaprMachineState *spapr, boo=
l reset, size_t space)
         }
     }
=20
-    /* cpus */
-    spapr_populate_cpus_dt_node(fdt, spapr);
+    spapr_dt_cpus(fdt, spapr);
=20
     if (smc->dr_lmb_enabled) {
         _FDT(spapr_dt_drc(fdt, 0, NULL, SPAPR_DR_CONNECTOR_TYPE_LMB));
@@ -3400,8 +3396,8 @@ int spapr_lmb_dt_populate(SpaprDrc *drc, SpaprMachi=
neState *spapr,
     addr =3D spapr_drc_index(drc) * SPAPR_MEMORY_BLOCK_SIZE;
     node =3D object_property_get_uint(OBJECT(drc->dev), PC_DIMM_NODE_PRO=
P,
                                     &error_abort);
-    *fdt_start_offset =3D spapr_populate_memory_node(fdt, node, addr,
-                                                   SPAPR_MEMORY_BLOCK_SI=
ZE);
+    *fdt_start_offset =3D spapr_dt_memory_node(fdt, node, addr,
+                                             SPAPR_MEMORY_BLOCK_SIZE);
     return 0;
 }
=20
@@ -3802,7 +3798,7 @@ int spapr_core_dt_populate(SpaprDrc *drc, SpaprMach=
ineState *spapr,
     offset =3D fdt_add_subnode(fdt, 0, nodename);
     g_free(nodename);
=20
-    spapr_populate_cpu_dt(cs, fdt, offset, spapr);
+    spapr_dt_cpu(cs, fdt, offset, spapr);
=20
     *fdt_start_offset =3D offset;
     return 0;
diff --git a/hw/ppc/spapr_ovec.c b/hw/ppc/spapr_ovec.c
index 0ff6d1aeae..dd003f1763 100644
--- a/hw/ppc/spapr_ovec.c
+++ b/hw/ppc/spapr_ovec.c
@@ -200,8 +200,8 @@ SpaprOptionVector *spapr_ovec_parse_vector(target_ulo=
ng table_addr, int vector)
     return ov;
 }
=20
-int spapr_ovec_populate_dt(void *fdt, int fdt_offset,
-                           SpaprOptionVector *ov, const char *name)
+int spapr_dt_ovec(void *fdt, int fdt_offset,
+                  SpaprOptionVector *ov, const char *name)
 {
     uint8_t vec[OV_MAXBYTES + 1];
     uint16_t vec_len;
diff --git a/include/hw/ppc/spapr_ovec.h b/include/hw/ppc/spapr_ovec.h
index 2bed517a2b..d4dee9e06a 100644
--- a/include/hw/ppc/spapr_ovec.h
+++ b/include/hw/ppc/spapr_ovec.h
@@ -72,8 +72,8 @@ void spapr_ovec_set(SpaprOptionVector *ov, long bitnr);
 void spapr_ovec_clear(SpaprOptionVector *ov, long bitnr);
 bool spapr_ovec_test(SpaprOptionVector *ov, long bitnr);
 SpaprOptionVector *spapr_ovec_parse_vector(target_ulong table_addr, int =
vector);
-int spapr_ovec_populate_dt(void *fdt, int fdt_offset,
-                           SpaprOptionVector *ov, const char *name);
+int spapr_dt_ovec(void *fdt, int fdt_offset,
+                  SpaprOptionVector *ov, const char *name);
=20
 /* migration */
 extern const VMStateDescription vmstate_spapr_ovec;
--=20
2.24.1



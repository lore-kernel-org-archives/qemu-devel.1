Return-Path: <SRS0=9yXi=U7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE986C06510
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 15:32:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 967F1206A3
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 15:32:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 967F1206A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54512 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hiKlH-0004wW-OL
	for qemu-devel@archiver.kernel.org; Tue, 02 Jul 2019 11:32:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58791)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mst@redhat.com>) id 1hiKOQ-0007LL-4d
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 11:08:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1hiKOO-00016z-9j
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 11:08:26 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50350)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1hiKOM-00013t-7l
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 11:08:24 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 6D9F23086211;
 Tue,  2 Jul 2019 15:08:19 +0000 (UTC)
Received: from redhat.com (ovpn-124-209.rdu2.redhat.com [10.10.124.209])
 by smtp.corp.redhat.com (Postfix) with SMTP id 1F8D079599;
 Tue,  2 Jul 2019 15:08:13 +0000 (UTC)
Date: Tue, 2 Jul 2019 11:08:12 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Message-ID: <20190628200227.1053-1-ehabkost@redhat.com>
References: <20190702150606.24851-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
In-Reply-To: <20190702150606.24851-1-mst@redhat.com>
X-Mutt-Fcc: =sent
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.42]); Tue, 02 Jul 2019 15:08:19 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 18/22] pc: Move compat_apic_id_mode variable to
 PCMachineClass
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Eduardo Habkost <ehabkost@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Philippe Mathieu-Daude <philmd@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190702150812.XQY-Jy-Fcxj4UkJW-A8cNnzwnT1RUhL3ObFgYs4k7WI@z>

From: Eduardo Habkost <ehabkost@redhat.com>

Replace the static variable with a PCMachineClass field.  This
will help us eventually get rid of the pc_compat_*() init
functions.

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
Message-Id: <20190628200227.1053-1-ehabkost@redhat.com>
Reviewed-by: Philippe Mathieu-Daude <philmd@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/hw/i386/pc.h |  3 +++
 hw/i386/pc.c         | 22 +++++++++-------------
 hw/i386/pc_piix.c    |  3 ++-
 3 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
index c54cc54a47..853502f277 100644
--- a/include/hw/i386/pc.h
+++ b/include/hw/i386/pc.h
@@ -134,6 +134,9 @@ typedef struct PCMachineClass {
 
     /* use PVH to load kernels that support this feature */
     bool pvh_enabled;
+
+    /* Enables contiguous-apic-ID mode */
+    bool compat_apic_id_mode;
 } PCMachineClass;
 
 #define TYPE_PC_MACHINE "generic-pc-machine"
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 7b99b60cd3..b380bd7d74 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -915,14 +915,6 @@ bool e820_get_entry(int idx, uint32_t type, uint64_t *address, uint64_t *length)
     return false;
 }
 
-/* Enables contiguous-apic-ID mode, for compatibility */
-static bool compat_apic_id_mode;
-
-void enable_compat_apic_id_mode(void)
-{
-    compat_apic_id_mode = true;
-}
-
 /* Calculates initial APIC ID for a specific CPU index
  *
  * Currently we need to be able to calculate the APIC ID from the CPU index
@@ -930,13 +922,15 @@ void enable_compat_apic_id_mode(void)
  * no concept of "CPU index", and the NUMA tables on fw_cfg need the APIC ID of
  * all CPUs up to max_cpus.
  */
-static uint32_t x86_cpu_apic_id_from_index(unsigned int cpu_index)
+static uint32_t x86_cpu_apic_id_from_index(PCMachineState *pcms,
+                                           unsigned int cpu_index)
 {
+    PCMachineClass *pcmc = PC_MACHINE_GET_CLASS(pcms);
     uint32_t correct_id;
     static bool warned;
 
     correct_id = x86_apicid_from_cpu_idx(smp_cores, smp_threads, cpu_index);
-    if (compat_apic_id_mode) {
+    if (pcmc->compat_apic_id_mode) {
         if (cpu_index != correct_id && !warned && !qtest_enabled()) {
             error_report("APIC IDs set in compatibility mode, "
                          "CPU topology won't match the configuration");
@@ -1535,7 +1529,8 @@ static void pc_new_cpu(const char *typename, int64_t apic_id, Error **errp)
 void pc_hot_add_cpu(const int64_t id, Error **errp)
 {
     MachineState *ms = MACHINE(qdev_get_machine());
-    int64_t apic_id = x86_cpu_apic_id_from_index(id);
+    PCMachineState *pcms = PC_MACHINE(ms);
+    int64_t apic_id = x86_cpu_apic_id_from_index(pcms, id);
     Error *local_err = NULL;
 
     if (id < 0) {
@@ -1571,7 +1566,7 @@ void pc_cpus_init(PCMachineState *pcms)
      *
      * This is used for FW_CFG_MAX_CPUS. See comments on bochs_bios_init().
      */
-    pcms->apic_id_limit = x86_cpu_apic_id_from_index(max_cpus - 1) + 1;
+    pcms->apic_id_limit = x86_cpu_apic_id_from_index(pcms, max_cpus - 1) + 1;
     possible_cpus = mc->possible_cpu_arch_ids(ms);
     for (i = 0; i < smp_cpus; i++) {
         pc_new_cpu(possible_cpus->cpus[i].type, possible_cpus->cpus[i].arch_id,
@@ -2730,6 +2725,7 @@ static int64_t pc_get_default_cpu_node_id(const MachineState *ms, int idx)
 
 static const CPUArchIdList *pc_possible_cpu_arch_ids(MachineState *ms)
 {
+    PCMachineState *pcms = PC_MACHINE(ms);
     int i;
 
     if (ms->possible_cpus) {
@@ -2749,7 +2745,7 @@ static const CPUArchIdList *pc_possible_cpu_arch_ids(MachineState *ms)
 
         ms->possible_cpus->cpus[i].type = ms->cpu_type;
         ms->possible_cpus->cpus[i].vcpus_count = 1;
-        ms->possible_cpus->cpus[i].arch_id = x86_cpu_apic_id_from_index(i);
+        ms->possible_cpus->cpus[i].arch_id = x86_cpu_apic_id_from_index(pcms, i);
         x86_topo_ids_from_apicid(ms->possible_cpus->cpus[i].arch_id,
                                  smp_cores, smp_threads, &topo);
         ms->possible_cpus->cpus[i].props.has_socket_id = true;
diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index c07c4a5b38..f29de58636 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -358,7 +358,6 @@ static void pc_compat_1_4_fn(MachineState *machine)
 static void pc_compat_1_3(MachineState *machine)
 {
     pc_compat_1_4_fn(machine);
-    enable_compat_apic_id_mode();
 }
 
 /* PC compat function for pc-0.14 to pc-1.2 */
@@ -708,6 +707,7 @@ DEFINE_I440FX_MACHINE(v1_4, "pc-i440fx-1.4", pc_compat_1_4_fn,
 
 static void pc_i440fx_1_3_machine_options(MachineClass *m)
 {
+    PCMachineClass *pcmc = PC_MACHINE_CLASS(m);
     static GlobalProperty compat[] = {
         PC_CPU_MODEL_IDS("1.3.0")
         { "usb-tablet", "usb_version", "1" },
@@ -718,6 +718,7 @@ static void pc_i440fx_1_3_machine_options(MachineClass *m)
 
     pc_i440fx_1_4_machine_options(m);
     m->hw_version = "1.3.0";
+    pcmc->compat_apic_id_mode = true;
     compat_props_add(m->compat_props, compat, G_N_ELEMENTS(compat));
 }
 
-- 
MST



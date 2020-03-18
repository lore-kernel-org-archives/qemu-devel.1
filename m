Return-Path: <SRS0=a3Gm=5D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E092C1975A
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2020 01:20:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2532720663
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2020 01:20:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="B7pZnd9z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2532720663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43990 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jENNZ-00072W-9T
	for qemu-devel@archiver.kernel.org; Tue, 17 Mar 2020 21:20:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34297)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <ehabkost@redhat.com>) id 1jENLV-00047p-PP
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 21:18:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ehabkost@redhat.com>) id 1jENLT-0001KF-QO
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 21:18:09 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:47100)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1jENLT-0001Hu-I4
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 21:18:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584494287;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RXaaXi1obSI+LFUzsUj4WibcybnyLRIumIU+jKS0tpA=;
 b=B7pZnd9zT1Oyz0cKzS1kUB3NJWT+DOpI5nJWzNCknXjvv/JPtvKXGzrznqzeii64HwJKff
 GM/FzEM7Mg/QBs37hQKZdUowDYTbmwfFYJc2SY5cSngd3HSJWTUU3EC9vrS9+jeswFZqop
 RXgb7eyYQ+jpH0akjdRE/KYoBppnWUQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-401-LXHQleIHOXmrrZSxWo21Hg-1; Tue, 17 Mar 2020 21:18:03 -0400
X-MC-Unique: LXHQleIHOXmrrZSxWo21Hg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3313818A5500;
 Wed, 18 Mar 2020 01:18:02 +0000 (UTC)
Received: from localhost (ovpn-118-148.rdu2.redhat.com [10.10.118.148])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 931AE60BF3;
 Wed, 18 Mar 2020 01:18:01 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
To: qemu-devel@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 05/13] hw/i386: Rename X86CPUTopoInfo structure to X86CPUTopoIDs
Date: Tue, 17 Mar 2020 21:17:40 -0400
Message-Id: <20200318011748.2104336-6-ehabkost@redhat.com>
In-Reply-To: <20200318011748.2104336-1-ehabkost@redhat.com>
References: <20200318011748.2104336-1-ehabkost@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 216.205.24.74
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Babu Moger <babu.moger@amd.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Babu Moger <babu.moger@amd.com>

Rename few data structures related to X86 topology.  X86CPUTopoIDs will
have individual arch ids. Next patch introduces X86CPUTopoInfo which will
have all topology information(like cores, threads etc..).

Signed-off-by: Babu Moger <babu.moger@amd.com>
Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>
Message-Id: <158326541877.40452.17535023236841538507.stgit@naples-babu.amd.=
com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 hw/i386/pc.c               | 45 ++++++++++++++++++++------------------
 hw/i386/x86.c              | 18 +++++++--------
 include/hw/i386/topology.h | 44 ++++++++++++++++++++-----------------
 3 files changed, 57 insertions(+), 50 deletions(-)

diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 362eb2a180..f52e84b2ba 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -1505,7 +1505,7 @@ static void pc_cpu_pre_plug(HotplugHandler *hotplug_d=
ev,
     int idx;
     CPUState *cs;
     CPUArchId *cpu_slot;
-    X86CPUTopoInfo topo;
+    X86CPUTopoIDs topo_ids;
     X86CPU *cpu =3D X86_CPU(dev);
     CPUX86State *env =3D &cpu->env;
     MachineState *ms =3D MACHINE(hotplug_dev);
@@ -1571,12 +1571,12 @@ static void pc_cpu_pre_plug(HotplugHandler *hotplug=
_dev,
             return;
         }
=20
-        topo.pkg_id =3D cpu->socket_id;
-        topo.die_id =3D cpu->die_id;
-        topo.core_id =3D cpu->core_id;
-        topo.smt_id =3D cpu->thread_id;
+        topo_ids.pkg_id =3D cpu->socket_id;
+        topo_ids.die_id =3D cpu->die_id;
+        topo_ids.core_id =3D cpu->core_id;
+        topo_ids.smt_id =3D cpu->thread_id;
         cpu->apic_id =3D apicid_from_topo_ids(x86ms->smp_dies, smp_cores,
-                                            smp_threads, &topo);
+                                            smp_threads, &topo_ids);
     }
=20
     cpu_slot =3D pc_find_cpu_slot(MACHINE(pcms), cpu->apic_id, &idx);
@@ -1584,11 +1584,11 @@ static void pc_cpu_pre_plug(HotplugHandler *hotplug=
_dev,
         MachineState *ms =3D MACHINE(pcms);
=20
         x86_topo_ids_from_apicid(cpu->apic_id, x86ms->smp_dies,
-                                 smp_cores, smp_threads, &topo);
+                                 smp_cores, smp_threads, &topo_ids);
         error_setg(errp,
             "Invalid CPU [socket: %u, die: %u, core: %u, thread: %u] with"
             " APIC ID %" PRIu32 ", valid index range 0:%d",
-            topo.pkg_id, topo.die_id, topo.core_id, topo.smt_id,
+            topo_ids.pkg_id, topo_ids.die_id, topo_ids.core_id, topo_ids.s=
mt_id,
             cpu->apic_id, ms->possible_cpus->len - 1);
         return;
     }
@@ -1606,34 +1606,37 @@ static void pc_cpu_pre_plug(HotplugHandler *hotplug=
_dev,
      * once -smp refactoring is complete and there will be CPU private
      * CPUState::nr_cores and CPUState::nr_threads fields instead of globa=
ls */
     x86_topo_ids_from_apicid(cpu->apic_id, x86ms->smp_dies,
-                             smp_cores, smp_threads, &topo);
-    if (cpu->socket_id !=3D -1 && cpu->socket_id !=3D topo.pkg_id) {
+                             smp_cores, smp_threads, &topo_ids);
+    if (cpu->socket_id !=3D -1 && cpu->socket_id !=3D topo_ids.pkg_id) {
         error_setg(errp, "property socket-id: %u doesn't match set apic-id=
:"
-            " 0x%x (socket-id: %u)", cpu->socket_id, cpu->apic_id, topo.pk=
g_id);
+            " 0x%x (socket-id: %u)", cpu->socket_id, cpu->apic_id,
+            topo_ids.pkg_id);
         return;
     }
-    cpu->socket_id =3D topo.pkg_id;
+    cpu->socket_id =3D topo_ids.pkg_id;
=20
-    if (cpu->die_id !=3D -1 && cpu->die_id !=3D topo.die_id) {
+    if (cpu->die_id !=3D -1 && cpu->die_id !=3D topo_ids.die_id) {
         error_setg(errp, "property die-id: %u doesn't match set apic-id:"
-            " 0x%x (die-id: %u)", cpu->die_id, cpu->apic_id, topo.die_id);
+            " 0x%x (die-id: %u)", cpu->die_id, cpu->apic_id, topo_ids.die_=
id);
         return;
     }
-    cpu->die_id =3D topo.die_id;
+    cpu->die_id =3D topo_ids.die_id;
=20
-    if (cpu->core_id !=3D -1 && cpu->core_id !=3D topo.core_id) {
+    if (cpu->core_id !=3D -1 && cpu->core_id !=3D topo_ids.core_id) {
         error_setg(errp, "property core-id: %u doesn't match set apic-id:"
-            " 0x%x (core-id: %u)", cpu->core_id, cpu->apic_id, topo.core_i=
d);
+            " 0x%x (core-id: %u)", cpu->core_id, cpu->apic_id,
+            topo_ids.core_id);
         return;
     }
-    cpu->core_id =3D topo.core_id;
+    cpu->core_id =3D topo_ids.core_id;
=20
-    if (cpu->thread_id !=3D -1 && cpu->thread_id !=3D topo.smt_id) {
+    if (cpu->thread_id !=3D -1 && cpu->thread_id !=3D topo_ids.smt_id) {
         error_setg(errp, "property thread-id: %u doesn't match set apic-id=
:"
-            " 0x%x (thread-id: %u)", cpu->thread_id, cpu->apic_id, topo.sm=
t_id);
+            " 0x%x (thread-id: %u)", cpu->thread_id, cpu->apic_id,
+            topo_ids.smt_id);
         return;
     }
-    cpu->thread_id =3D topo.smt_id;
+    cpu->thread_id =3D topo_ids.smt_id;
=20
     if (hyperv_feat_enabled(cpu, HYPERV_FEAT_VPINDEX) &&
         !kvm_hv_vpindex_settable()) {
diff --git a/hw/i386/x86.c b/hw/i386/x86.c
index 08246523f2..c6ee5aac8c 100644
--- a/hw/i386/x86.c
+++ b/hw/i386/x86.c
@@ -143,14 +143,14 @@ x86_cpu_index_to_props(MachineState *ms, unsigned cpu=
_index)
=20
 int64_t x86_get_default_cpu_node_id(const MachineState *ms, int idx)
 {
-   X86CPUTopoInfo topo;
+   X86CPUTopoIDs topo_ids;
    X86MachineState *x86ms =3D X86_MACHINE(ms);
=20
    assert(idx < ms->possible_cpus->len);
    x86_topo_ids_from_apicid(ms->possible_cpus->cpus[idx].arch_id,
                             x86ms->smp_dies, ms->smp.cores,
-                            ms->smp.threads, &topo);
-   return topo.pkg_id % ms->numa_state->num_nodes;
+                            ms->smp.threads, &topo_ids);
+   return topo_ids.pkg_id % ms->numa_state->num_nodes;
 }
=20
 const CPUArchIdList *x86_possible_cpu_arch_ids(MachineState *ms)
@@ -172,7 +172,7 @@ const CPUArchIdList *x86_possible_cpu_arch_ids(MachineS=
tate *ms)
                                   sizeof(CPUArchId) * max_cpus);
     ms->possible_cpus->len =3D max_cpus;
     for (i =3D 0; i < ms->possible_cpus->len; i++) {
-        X86CPUTopoInfo topo;
+        X86CPUTopoIDs topo_ids;
=20
         ms->possible_cpus->cpus[i].type =3D ms->cpu_type;
         ms->possible_cpus->cpus[i].vcpus_count =3D 1;
@@ -180,17 +180,17 @@ const CPUArchIdList *x86_possible_cpu_arch_ids(Machin=
eState *ms)
             x86_cpu_apic_id_from_index(x86ms, i);
         x86_topo_ids_from_apicid(ms->possible_cpus->cpus[i].arch_id,
                                  x86ms->smp_dies, ms->smp.cores,
-                                 ms->smp.threads, &topo);
+                                 ms->smp.threads, &topo_ids);
         ms->possible_cpus->cpus[i].props.has_socket_id =3D true;
-        ms->possible_cpus->cpus[i].props.socket_id =3D topo.pkg_id;
+        ms->possible_cpus->cpus[i].props.socket_id =3D topo_ids.pkg_id;
         if (x86ms->smp_dies > 1) {
             ms->possible_cpus->cpus[i].props.has_die_id =3D true;
-            ms->possible_cpus->cpus[i].props.die_id =3D topo.die_id;
+            ms->possible_cpus->cpus[i].props.die_id =3D topo_ids.die_id;
         }
         ms->possible_cpus->cpus[i].props.has_core_id =3D true;
-        ms->possible_cpus->cpus[i].props.core_id =3D topo.core_id;
+        ms->possible_cpus->cpus[i].props.core_id =3D topo_ids.core_id;
         ms->possible_cpus->cpus[i].props.has_thread_id =3D true;
-        ms->possible_cpus->cpus[i].props.thread_id =3D topo.smt_id;
+        ms->possible_cpus->cpus[i].props.thread_id =3D topo_ids.smt_id;
     }
     return ms->possible_cpus;
 }
diff --git a/include/hw/i386/topology.h b/include/hw/i386/topology.h
index 4ff5b2da6c..52def68610 100644
--- a/include/hw/i386/topology.h
+++ b/include/hw/i386/topology.h
@@ -45,12 +45,12 @@
  */
 typedef uint32_t apic_id_t;
=20
-typedef struct X86CPUTopoInfo {
+typedef struct X86CPUTopoIDs {
     unsigned pkg_id;
     unsigned die_id;
     unsigned core_id;
     unsigned smt_id;
-} X86CPUTopoInfo;
+} X86CPUTopoIDs;
=20
 /* Return the bit width needed for 'count' IDs
  */
@@ -122,12 +122,15 @@ static inline unsigned apicid_pkg_offset(unsigned nr_=
dies,
 static inline apic_id_t apicid_from_topo_ids(unsigned nr_dies,
                                              unsigned nr_cores,
                                              unsigned nr_threads,
-                                             const X86CPUTopoInfo *topo)
+                                             const X86CPUTopoIDs *topo_ids=
)
 {
-    return (topo->pkg_id  << apicid_pkg_offset(nr_dies, nr_cores, nr_threa=
ds)) |
-           (topo->die_id  << apicid_die_offset(nr_dies, nr_cores, nr_threa=
ds)) |
-          (topo->core_id << apicid_core_offset(nr_dies, nr_cores, nr_threa=
ds)) |
-           topo->smt_id;
+    return (topo_ids->pkg_id  <<
+               apicid_pkg_offset(nr_dies, nr_cores, nr_threads)) |
+           (topo_ids->die_id  <<
+               apicid_die_offset(nr_dies, nr_cores, nr_threads)) |
+           (topo_ids->core_id <<
+               apicid_core_offset(nr_dies, nr_cores, nr_threads)) |
+           topo_ids->smt_id;
 }
=20
 /* Calculate thread/core/package IDs for a specific topology,
@@ -137,12 +140,12 @@ static inline void x86_topo_ids_from_idx(unsigned nr_=
dies,
                                          unsigned nr_cores,
                                          unsigned nr_threads,
                                          unsigned cpu_index,
-                                         X86CPUTopoInfo *topo)
+                                         X86CPUTopoIDs *topo_ids)
 {
-    topo->pkg_id =3D cpu_index / (nr_dies * nr_cores * nr_threads);
-    topo->die_id =3D cpu_index / (nr_cores * nr_threads) % nr_dies;
-    topo->core_id =3D cpu_index / nr_threads % nr_cores;
-    topo->smt_id =3D cpu_index % nr_threads;
+    topo_ids->pkg_id =3D cpu_index / (nr_dies * nr_cores * nr_threads);
+    topo_ids->die_id =3D cpu_index / (nr_cores * nr_threads) % nr_dies;
+    topo_ids->core_id =3D cpu_index / nr_threads % nr_cores;
+    topo_ids->smt_id =3D cpu_index % nr_threads;
 }
=20
 /* Calculate thread/core/package IDs for a specific topology,
@@ -152,17 +155,18 @@ static inline void x86_topo_ids_from_apicid(apic_id_t=
 apicid,
                                             unsigned nr_dies,
                                             unsigned nr_cores,
                                             unsigned nr_threads,
-                                            X86CPUTopoInfo *topo)
+                                            X86CPUTopoIDs *topo_ids)
 {
-    topo->smt_id =3D apicid &
+    topo_ids->smt_id =3D apicid &
             ~(0xFFFFFFFFUL << apicid_smt_width(nr_dies, nr_cores, nr_threa=
ds));
-    topo->core_id =3D
+    topo_ids->core_id =3D
             (apicid >> apicid_core_offset(nr_dies, nr_cores, nr_threads)) =
&
             ~(0xFFFFFFFFUL << apicid_core_width(nr_dies, nr_cores, nr_thre=
ads));
-    topo->die_id =3D
+    topo_ids->die_id =3D
             (apicid >> apicid_die_offset(nr_dies, nr_cores, nr_threads)) &
             ~(0xFFFFFFFFUL << apicid_die_width(nr_dies, nr_cores, nr_threa=
ds));
-    topo->pkg_id =3D apicid >> apicid_pkg_offset(nr_dies, nr_cores, nr_thr=
eads);
+    topo_ids->pkg_id =3D
+            apicid >> apicid_pkg_offset(nr_dies, nr_cores, nr_threads);
 }
=20
 /* Make APIC ID for the CPU 'cpu_index'
@@ -174,9 +178,9 @@ static inline apic_id_t x86_apicid_from_cpu_idx(unsigne=
d nr_dies,
                                                 unsigned nr_threads,
                                                 unsigned cpu_index)
 {
-    X86CPUTopoInfo topo;
-    x86_topo_ids_from_idx(nr_dies, nr_cores, nr_threads, cpu_index, &topo)=
;
-    return apicid_from_topo_ids(nr_dies, nr_cores, nr_threads, &topo);
+    X86CPUTopoIDs topo_ids;
+    x86_topo_ids_from_idx(nr_dies, nr_cores, nr_threads, cpu_index, &topo_=
ids);
+    return apicid_from_topo_ids(nr_dies, nr_cores, nr_threads, &topo_ids);
 }
=20
 #endif /* HW_I386_TOPOLOGY_H */
--=20
2.24.1



Return-Path: <SRS0=/yOf=V4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A580C32751
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2019 08:41:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4118B206A2
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2019 08:41:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4118B206A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38832 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hskAy-0003zR-Hs
	for qemu-devel@archiver.kernel.org; Wed, 31 Jul 2019 04:41:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45234)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <daniel@linux.ibm.com>) id 1hskAO-00037C-H7
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 04:41:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <daniel@linux.ibm.com>) id 1hskAL-0002g0-Od
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 04:41:00 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:5526)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <daniel@linux.ibm.com>)
 id 1hskAL-0002fd-HC
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 04:40:57 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x6V8biYi011710
 for <qemu-devel@nongnu.org>; Wed, 31 Jul 2019 04:40:56 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2u37n5040v-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 31 Jul 2019 04:40:56 -0400
Received: from localhost
 by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <daniel@linux.ibm.com>;
 Wed, 31 Jul 2019 09:40:49 +0100
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
 by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Wed, 31 Jul 2019 09:40:44 +0100
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com
 [9.149.105.58])
 by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x6V8ehCC50790460
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 31 Jul 2019 08:40:43 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 768AC4C040;
 Wed, 31 Jul 2019 08:40:43 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8ED864C064;
 Wed, 31 Jul 2019 08:40:42 +0000 (GMT)
Received: from ozlabs.au.ibm.com (unknown [9.192.253.14])
 by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Wed, 31 Jul 2019 08:40:42 +0000 (GMT)
Received: from volution.fritz.box (unknown [9.102.40.183])
 (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.au.ibm.com (Postfix) with ESMTPSA id E55F6A0224;
 Wed, 31 Jul 2019 18:40:40 +1000 (AEST)
From: Daniel Black <daniel@linux.ibm.com>
To: qemu-devel@nongnu.org
Date: Wed, 31 Jul 2019 18:40:33 +1000
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19073108-0020-0000-0000-00000358E5D0
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19073108-0021-0000-0000-000021ACEE49
Message-Id: <20190731084034.9498-1-daniel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-07-31_04:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1907310093
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 148.163.156.1
Subject: [Qemu-devel] [PATCH] numa: numa nodeid need not be sequential
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
 Radoslaw Biernacki <radoslaw.biernacki@linaro.org>,
 Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Leif Lindholm <leif.lindholm@linaro.org>,
 Shannon Zhao <shannon.zhaosl@gmail.com>,
 "open list:ARM TCG CPUs" <qemu-arm@nongnu.org>,
 "open list:sPAPR" <qemu-ppc@nongnu.org>, Daniel Black <daniel@linux.ibm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Replace all nodeid assumptions with lookups in the numa_info array and
remove aspects that assume a sequential numbering of nodes. This enables
non-sequential NUMA node number topoligies to be created.

Default assignments of CPU->nodeid (get_default_cpu_node_id) now return
a nodeid from the numa_info array.

x86 will use the node is as the Proximity Domain (which the
linux kernel will map down to sequential node numbers). In Linux kernel
output look at the RAT: and PXM: references in the kernel early boot.

Small enhancements where made to error messages to be more explicit
about errors in node specification.

Signed-off-by: Daniel Black <daniel@linux.ibm.com>
---

Below is a TCG test script that covers ppc64le/x86_64/aarch64 architecutes:

Uncomment run* lines as needed. Manually complete steps at end to
verify:

Caution, brutal killalls contained within.

#!/bin/bash
set -x -v

QEMUHOME=${HOME}/repos/qemu/
# optional but make it easy to install/run numactl --hardware
#ALPINE_NET=""
ALPINE_NET="ip=dhcp alpine_repo=http://dl-cdn.alpinelinux.org/alpine/edge/main/"

ALPINE_HOME=${HOME}/repos/alpine/alpine-netboot-3.10.1-

# x86 / armv7 - no CONFIG_NUMA=y support in kernel
# Kernel configs: https://git.alpinelinux.org/aports/tree/main/linux-vanilla/
# s390x - no numa support in QEMU
for ARCH in x86_64 aarch64 ppc64le
do
 if [ ! -d ${ALPINE_HOME}${ARCH} ]
 then
   mkdir ${ALPINE_HOME}${ARCH}
   wget http://dl-cdn.alpinelinux.org/alpine/v3.10/releases/${ARCH}/alpine-netboot-3.10.1-${ARCH}.tar.gz -O - | tar -zxf - -C ${ALPINE_HOME}${ARCH}
 fi
done

if [ ! -x ${ALPINE_HOME}i386 ]
then
  ln -s ${ALPINE_HOME}x86 ${ALPINE_HOME}i386
fi

if [ ! -x ${ALPINE_HOME}arm ]
then
  ln -s ${ALPINE_HOME}armv7 ${ALPINE_HOME}arm
fi

if [ ! -x ${ALPINE_HOME}ppc64 ]
then
  ln -s ${ALPINE_HOME}ppc64le ${ALPINE_HOME}ppc64
fi

# Note "virtual" kernels don't have numa enabled
run()
{
  NUMA=$1
  ARCH=$2
  ARGS=$3
  CONSOLE=$4
  ${QEMUHOME}/${ARCH}-softmmu/qemu-system-${ARCH} \
    ${ARGS} \
    -kernel ${ALPINE_HOME}${ARCH}/boot/vmlinuz-vanilla  \
    -initrd ${ALPINE_HOME}${ARCH}/boot/initramfs-vanilla \
    -append "${CONSOLE} ${ALPINE_NET}" \
    -m 2G \
    ${NUMA}
  echo
}

# This ends up as odd:
# ends up with both CPUs are on same node
# as 0 and 8 % 2 (nodes) are the same
# in short - don't run legacy with gaps with
# odd numa node numbers (like 0 and 8).
run_legacy()
{
  run "-smp 2,cores=3,sockets=2,maxcpus=6 \
       -numa node,mem=1G \
       -numa node,mem=1G,nodeid=8 \
       -numa dist,src=0,dst=8,val=21" "$@"
}

run_memdev_implicit_core()
{
  run "-smp cpus=6,maxcpus=8,cores=4,sockets=2 \
       -object memory-backend-ram,id=ram0,size=1G \
       -object memory-backend-ram,id=ram1,size=1G \
       -numa node,memdev=ram0,nodeid=0 \
       -numa node,memdev=ram1,nodeid=8 \
       -numa dist,src=0,dst=8,val=21" "$@"
}

run_memdev_explicit_core()
{
  run "-smp cpus=6,maxcpus=8,cores=4,sockets=2 \
       -object memory-backend-ram,id=ram0,size=1G \
       -object memory-backend-ram,id=ram1,size=1G \
       -numa node,memdev=ram0,cpus=0-3,nodeid=0 \
       -numa node,memdev=ram1,cpus=4-7,nodeid=8 \
       -numa dist,src=0,dst=8,val=21" "$@"
}

for arch in x86_64 ppc64 aarch64 s390x; do killall qemu-system-$arch; done
killall vncviewer

# i386 Alpine kernels don't have NUMA
#run_memdev_implicit_core i386 "-machine pc -nographic" console=ttyS0
# armv7 kernel's don't have NUMA
#run_legacy arm "-machine virt -cpu cortex-a15 -nographic" console=ttyAMA0

# GOOD
run_legacy x86_64 "-machine pc -nographic" console=ttyS0
run_memdev_implicit_core x86_64 "-machine pc -nographic" console=ttyS0
run_memdev_explicit_core x86_64 "-machine pc -nographic" console=ttyS0

# GOOD
#run_legacy aarch64 "-machine virt -cpu cortex-a57 -nographic" console=ttyAMA0
#run_memdev_implicit_core  aarch64 "-machine virt -cpu cortex-a57 -nographic" console=ttyAMA0
#run_memdev_explicit_core  aarch64 "-machine virt -cpu cortex-a57 -nographic" console=ttyAMA0

# PPC not doing numa distance (not a regression)
#(sleep 1; vncviewer :0) &

# GOOD
# run_legacy ppc64 "-machine pseries -cpu POWER9 -display vnc=:0" "numa=debug"
# run_memdev_implicit_core ppc64 "-machine pseries -cpu POWER9 -display vnc=:0" "numa=debug"
# run_memdev_explicit_core ppc64 "-machine pseries -cpu POWER9 -display vnc=:0" "numa=debug"

# ON P8 ppc64le host:
# run_memdev_implicit_core ppc64 "-machine pseries -cpu host -accel kvm -display vnc=:0" "numa=debug"

# Couldn't boot Alpine ARM kernel on this machine type:
# arm sbsa ref - appears to be a BMC so not really a numa target?
# seems ok looking at the results of sbsa_ref_get_default_cpu_node_id however it display no
# output when booting

# run_legacy aarch64 "-machine sbsa-ref -nographic" console=ttyAMA0

# Then run:
# sh -c 'apk add numactl-tools && numactl --hardware'
#
# alternately examine results in:
# ls -la /sys/devices/system/node/node*/cpu*
# more /sys/devices/system/node/node*/distance
#
# x86 node numbers are renumbered by kernel. To view
# acpi mappings:
# dmesg | grep PXM:

 hw/acpi/aml-build.c      | 37 +++++++++++++++++++----
 hw/arm/boot.c            |  2 +-
 hw/arm/sbsa-ref.c        |  6 ++--
 hw/arm/virt-acpi-build.c |  4 +--
 hw/arm/virt.c            |  6 ++--
 hw/core/numa.c           | 63 +++++++++++++++++-----------------------
 hw/i386/acpi-build.c     | 10 ++++---
 hw/i386/pc.c             |  2 +-
 hw/ppc/spapr.c           |  9 +++---
 include/sysemu/numa.h    |  1 +
 10 files changed, 79 insertions(+), 61 deletions(-)

diff --git a/hw/acpi/aml-build.c b/hw/acpi/aml-build.c
index 555c24f21d..4abfac61aa 100644
--- a/hw/acpi/aml-build.c
+++ b/hw/acpi/aml-build.c
@@ -1722,22 +1722,47 @@ void build_srat_memory(AcpiSratMemoryAffinity *numamem, uint64_t base,
     numamem->range_length = cpu_to_le64(len);
 }
 
+static int find_numa_node(int node)
+{
+    int i;
+    for (i = 0; i < nb_numa_nodes && numa_info[i].nodeid != node; i++) {
+        /* empty */
+    }
+    return i;
+}
 /*
  * ACPI spec 5.2.17 System Locality Distance Information Table
  * (Revision 2.0 or later)
  */
 void build_slit(GArray *table_data, BIOSLinker *linker)
 {
-    int slit_start, i, j;
+    int slit_start, i, j, src, dst, largest;
     slit_start = table_data->len;
 
     acpi_data_push(table_data, sizeof(AcpiTableHeader));
 
-    build_append_int_noprefix(table_data, nb_numa_nodes, 8);
-    for (i = 0; i < nb_numa_nodes; i++) {
-        for (j = 0; j < nb_numa_nodes; j++) {
-            assert(numa_info[i].distance[j]);
-            build_append_int_noprefix(table_data, numa_info[i].distance[j], 1);
+    for (largest = 0, i = 0; i < nb_numa_nodes; i++)
+        if (largest < numa_info[i].nodeid) {
+            largest = numa_info[i].nodeid;
+        }
+
+    /* number of entries is largest + 1 as nodes start at 0 */
+    build_append_int_noprefix(table_data, largest + 1, 8);
+
+    for (i = 0; i <= largest; i++) {
+        src = find_numa_node(i);
+        for (j = 0; j <= largest; j++) {
+            dst = find_numa_node(j);
+
+            if (dst == nb_numa_nodes || src == nb_numa_nodes) {
+                /* 255 is unreachable. Linux expects 10 in self-maps entries */
+                build_append_int_noprefix(table_data,
+                                          i == j ? NUMA_DISTANCE_MIN : 255, 1);
+            } else {
+                assert(numa_info[src].distance[dst]);
+                build_append_int_noprefix(table_data,
+                                          numa_info[src].distance[dst], 1);
+            }
         }
     }
 
diff --git a/hw/arm/boot.c b/hw/arm/boot.c
index 1fb24fbef2..1a68fe957f 100644
--- a/hw/arm/boot.c
+++ b/hw/arm/boot.c
@@ -603,7 +603,7 @@ int arm_load_dtb(hwaddr addr, const struct arm_boot_info *binfo,
         for (i = 0; i < nb_numa_nodes; i++) {
             mem_len = numa_info[i].node_mem;
             rc = fdt_add_memory_node(fdt, acells, mem_base,
-                                     scells, mem_len, i);
+                                     scells, mem_len, numa_info[i].nodeid);
             if (rc < 0) {
                 fprintf(stderr, "couldn't add /memory@%"PRIx64" node\n",
                         mem_base);
diff --git a/hw/arm/sbsa-ref.c b/hw/arm/sbsa-ref.c
index 9c67d5c6f9..d33c42ac11 100644
--- a/hw/arm/sbsa-ref.c
+++ b/hw/arm/sbsa-ref.c
@@ -165,8 +165,8 @@ static void create_fdt(SBSAMachineState *sms)
         for (i = 0; i < nb_numa_nodes; i++) {
             for (j = 0; j < nb_numa_nodes; j++) {
                 idx = (i * nb_numa_nodes + j) * 3;
-                matrix[idx + 0] = cpu_to_be32(i);
-                matrix[idx + 1] = cpu_to_be32(j);
+                matrix[idx + 0] = cpu_to_be32(numa_info[i].nodeid);
+                matrix[idx + 1] = cpu_to_be32(numa_info[j].nodeid);
                 matrix[idx + 2] = cpu_to_be32(numa_info[i].distance[j]);
             }
         }
@@ -761,7 +761,7 @@ sbsa_ref_cpu_index_to_props(MachineState *ms, unsigned cpu_index)
 static int64_t
 sbsa_ref_get_default_cpu_node_id(const MachineState *ms, int idx)
 {
-    return idx % nb_numa_nodes;
+    return numa_info[idx % nb_numa_nodes].nodeid;
 }
 
 static void sbsa_ref_instance_init(Object *obj)
diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
index 0afb372769..3be79dc735 100644
--- a/hw/arm/virt-acpi-build.c
+++ b/hw/arm/virt-acpi-build.c
@@ -535,8 +535,8 @@ build_srat(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
     for (i = 0; i < nb_numa_nodes; ++i) {
         if (numa_info[i].node_mem > 0) {
             numamem = acpi_data_push(table_data, sizeof(*numamem));
-            build_srat_memory(numamem, mem_base, numa_info[i].node_mem, i,
-                              MEM_AFFINITY_ENABLED);
+            build_srat_memory(numamem, mem_base, numa_info[i].node_mem,
+                              numa_info[i].nodeid, MEM_AFFINITY_ENABLED);
             mem_base += numa_info[i].node_mem;
         }
     }
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index d9496c9363..c380659bd4 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -238,8 +238,8 @@ static void create_fdt(VirtMachineState *vms)
         for (i = 0; i < nb_numa_nodes; i++) {
             for (j = 0; j < nb_numa_nodes; j++) {
                 idx = (i * nb_numa_nodes + j) * 3;
-                matrix[idx + 0] = cpu_to_be32(i);
-                matrix[idx + 1] = cpu_to_be32(j);
+                matrix[idx + 0] = cpu_to_be32(numa_info[i].nodeid);
+                matrix[idx + 1] = cpu_to_be32(numa_info[j].nodeid);
                 matrix[idx + 2] = cpu_to_be32(numa_info[i].distance[j]);
             }
         }
@@ -1844,7 +1844,7 @@ virt_cpu_index_to_props(MachineState *ms, unsigned cpu_index)
 
 static int64_t virt_get_default_cpu_node_id(const MachineState *ms, int idx)
 {
-    return idx % nb_numa_nodes;
+    return numa_info[idx % nb_numa_nodes].nodeid;
 }
 
 static const CPUArchIdList *virt_possible_cpu_arch_ids(MachineState *ms)
diff --git a/hw/core/numa.c b/hw/core/numa.c
index a11431483c..b3fff6d1eb 100644
--- a/hw/core/numa.c
+++ b/hw/core/numa.c
@@ -47,13 +47,19 @@ QemuOptsList qemu_numa_opts = {
 
 static int have_memdevs;
 static int have_mem;
-static int max_numa_nodeid; /* Highest specified NUMA node ID, plus one.
-                             * For all nodes, nodeid < max_numa_nodeid
-                             */
 int nb_numa_nodes;
 bool have_numa_distance;
 NodeInfo numa_info[MAX_NODES];
 
+static int find_numa(uint16_t node)
+{
+    for (int i = 0; i < nb_numa_nodes; i++) {
+        if (numa_info[i].present && numa_info[i].nodeid == node) {
+            return i;
+        }
+    }
+    return MAX_NODES;
+}
 
 static void parse_numa_node(MachineState *ms, NumaNodeOptions *node,
                             Error **errp)
@@ -64,19 +70,15 @@ static void parse_numa_node(MachineState *ms, NumaNodeOptions *node,
     MachineClass *mc = MACHINE_GET_CLASS(ms);
     unsigned int max_cpus = ms->smp.max_cpus;
 
-    if (node->has_nodeid) {
-        nodenr = node->nodeid;
-    } else {
-        nodenr = nb_numa_nodes;
-    }
+    nodenr = nb_numa_nodes;
 
-    if (nodenr >= MAX_NODES) {
+    if (nb_numa_nodes >= MAX_NODES) {
         error_setg(errp, "Max number of NUMA nodes reached: %"
                    PRIu16 "", nodenr);
         return;
     }
 
-    if (numa_info[nodenr].present) {
+    if (node->has_nodeid && find_numa(node->nodeid) != MAX_NODES) {
         error_setg(errp, "Duplicate NUMA nodeid: %" PRIu16, nodenr);
         return;
     }
@@ -95,7 +97,7 @@ static void parse_numa_node(MachineState *ms, NumaNodeOptions *node,
             return;
         }
         props = mc->cpu_index_to_instance_props(ms, cpus->value);
-        props.node_id = nodenr;
+        props.node_id = node->has_nodeid ? node->nodeid : nodenr;
         props.has_node_id = true;
         machine_set_cpu_numa_node(ms, &props, &err);
         if (err) {
@@ -132,24 +134,24 @@ static void parse_numa_node(MachineState *ms, NumaNodeOptions *node,
         numa_info[nodenr].node_memdev = MEMORY_BACKEND(o);
     }
     numa_info[nodenr].present = true;
-    max_numa_nodeid = MAX(max_numa_nodeid, nodenr + 1);
+    numa_info[nodenr].nodeid = node->has_nodeid ? node->nodeid : nb_numa_nodes;
     nb_numa_nodes++;
 }
 
 static void parse_numa_distance(NumaDistOptions *dist, Error **errp)
 {
-    uint16_t src = dist->src;
-    uint16_t dst = dist->dst;
+    uint16_t src = find_numa(dist->src);
+    uint16_t dst = find_numa(dist->dst);
     uint8_t val = dist->val;
 
-    if (src >= MAX_NODES || dst >= MAX_NODES) {
-        error_setg(errp, "Parameter '%s' expects an integer between 0 and %d",
-                   src >= MAX_NODES ? "src" : "dst", MAX_NODES - 1);
+    if (src >= MAX_NODES || !numa_info[src].present) {
+        error_setg(errp, "Source NUMA node is missing. "
+                   "Please use '-numa node' option to declare it first.");
         return;
     }
 
-    if (!numa_info[src].present || !numa_info[dst].present) {
-        error_setg(errp, "Source/Destination NUMA node is missing. "
+    if (dst >= MAX_NODES || !numa_info[dst].present) {
+        error_setg(errp, "Destination NUMA node is missing. "
                    "Please use '-numa node' option to declare it first.");
         return;
     }
@@ -193,7 +195,7 @@ void set_numa_options(MachineState *ms, NumaOptions *object, Error **errp)
             error_setg(&err, "Missing mandatory node-id property");
             goto end;
         }
-        if (!numa_info[object->u.cpu.node_id].present) {
+        if (find_numa(object->u.cpu.node_id) == MAX_NODES) {
             error_setg(&err, "Invalid node-id=%" PRId64 ", NUMA node must be "
                 "defined with -numa node,nodeid=ID before it's used with "
                 "-numa cpu,node-id=ID", object->u.cpu.node_id);
@@ -261,7 +263,7 @@ static void validate_numa_distance(void)
                     error_report("The distance between node %d and %d is "
                                  "missing, at least one distance value "
                                  "between each nodes should be provided.",
-                                 src, dst);
+                                 numa_info[src].nodeid, numa_info[dst].nodeid);
                     exit(EXIT_FAILURE);
                 }
             }
@@ -279,9 +281,10 @@ static void validate_numa_distance(void)
         for (src = 0; src < nb_numa_nodes; src++) {
             for (dst = 0; dst < nb_numa_nodes; dst++) {
                 if (src != dst && numa_info[src].distance[dst] == 0) {
-                    error_report("At least one asymmetrical pair of "
+                    error_report("At least one asymmetrical pair (%d, %d) of "
                             "distances is given, please provide distances "
-                            "for both directions of all node pairs.");
+                            "for both directions of all node pairs.",
+                            numa_info[src].nodeid, numa_info[dst].nodeid);
                     exit(EXIT_FAILURE);
                 }
             }
@@ -371,20 +374,6 @@ void numa_complete_configuration(MachineState *ms)
             parse_numa_node(ms, &node, &error_abort);
     }
 
-    assert(max_numa_nodeid <= MAX_NODES);
-
-    /* No support for sparse NUMA node IDs yet: */
-    for (i = max_numa_nodeid - 1; i >= 0; i--) {
-        /* Report large node IDs first, to make mistakes easier to spot */
-        if (!numa_info[i].present) {
-            error_report("numa: Node ID missing: %d", i);
-            exit(1);
-        }
-    }
-
-    /* This must be always true if all nodes are present: */
-    assert(nb_numa_nodes == max_numa_nodeid);
-
     if (nb_numa_nodes > 0) {
         uint64_t numa_total;
 
diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
index d281ffa89e..7f7b31861c 100644
--- a/hw/i386/acpi-build.c
+++ b/hw/i386/acpi-build.c
@@ -2351,6 +2351,7 @@ build_srat(GArray *table_data, BIOSLinker *linker, MachineState *machine)
     numa_start = table_data->len;
 
     for (i = 1; i < pcms->numa_nodes + 1; ++i) {
+        int nodeid = numa_info[i - 1].nodeid;
         mem_base = next_base;
         mem_len = pcms->node_mem[i - 1];
         next_base = mem_base + mem_len;
@@ -2361,7 +2362,7 @@ build_srat(GArray *table_data, BIOSLinker *linker, MachineState *machine)
             mem_len -= next_base - HOLE_640K_START;
             if (mem_len > 0) {
                 numamem = acpi_data_push(table_data, sizeof *numamem);
-                build_srat_memory(numamem, mem_base, mem_len, i - 1,
+                build_srat_memory(numamem, mem_base, mem_len, nodeid,
                                   MEM_AFFINITY_ENABLED);
             }
 
@@ -2380,7 +2381,7 @@ build_srat(GArray *table_data, BIOSLinker *linker, MachineState *machine)
             mem_len -= next_base - pcms->below_4g_mem_size;
             if (mem_len > 0) {
                 numamem = acpi_data_push(table_data, sizeof *numamem);
-                build_srat_memory(numamem, mem_base, mem_len, i - 1,
+                build_srat_memory(numamem, mem_base, mem_len, nodeid,
                                   MEM_AFFINITY_ENABLED);
             }
             mem_base = 1ULL << 32;
@@ -2390,7 +2391,7 @@ build_srat(GArray *table_data, BIOSLinker *linker, MachineState *machine)
 
         if (mem_len > 0) {
             numamem = acpi_data_push(table_data, sizeof *numamem);
-            build_srat_memory(numamem, mem_base, mem_len, i - 1,
+            build_srat_memory(numamem, mem_base, mem_len, nodeid,
                               MEM_AFFINITY_ENABLED);
         }
     }
@@ -2411,7 +2412,8 @@ build_srat(GArray *table_data, BIOSLinker *linker, MachineState *machine)
     if (hotplugabble_address_space_size) {
         numamem = acpi_data_push(table_data, sizeof *numamem);
         build_srat_memory(numamem, machine->device_memory->base,
-                          hotplugabble_address_space_size, pcms->numa_nodes - 1,
+                          hotplugabble_address_space_size,
+                          numa_info[pcms->numa_nodes - 1].nodeid,
                           MEM_AFFINITY_HOTPLUGGABLE | MEM_AFFINITY_ENABLED);
     }
 
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 549c437050..9e96d8a02c 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -2847,7 +2847,7 @@ static int64_t pc_get_default_cpu_node_id(const MachineState *ms, int idx)
    x86_topo_ids_from_apicid(ms->possible_cpus->cpus[idx].arch_id,
                             pcms->smp_dies, ms->smp.cores,
                             ms->smp.threads, &topo);
-   return topo.pkg_id % nb_numa_nodes;
+   return numa_info[topo.pkg_id % nb_numa_nodes].nodeid;
 }
 
 static const CPUArchIdList *pc_possible_cpu_arch_ids(MachineState *ms)
diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 821f0d4a49..09cff62de8 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -424,7 +424,8 @@ static int spapr_populate_memory(SpaprMachineState *spapr, void *fdt)
         if (!mem_start) {
             /* spapr_machine_init() checks for rma_size <= node0_size
              * already */
-            spapr_populate_memory_node(fdt, i, 0, spapr->rma_size);
+            spapr_populate_memory_node(fdt, nodes[i].nodeid, 0,
+                                       spapr->rma_size);
             mem_start += spapr->rma_size;
             node_size -= spapr->rma_size;
         }
@@ -436,7 +437,7 @@ static int spapr_populate_memory(SpaprMachineState *spapr, void *fdt)
                 sizetmp = 1ULL << ctzl(mem_start);
             }
 
-            spapr_populate_memory_node(fdt, i, mem_start, sizetmp);
+            spapr_populate_memory_node(fdt, nodes[i].nodeid, mem_start, sizetmp);
             node_size -= sizetmp;
             mem_start += sizetmp;
         }
@@ -2542,7 +2543,7 @@ static void spapr_validate_node_memory(MachineState *machine, Error **errp)
             error_setg(errp,
                        "Node %d memory size 0x%" PRIx64
                        " is not aligned to %" PRIu64 " MiB",
-                       i, numa_info[i].node_mem,
+                       numa_info[i].nodeid, numa_info[i].node_mem,
                        SPAPR_MEMORY_BLOCK_SIZE / MiB);
             return;
         }
@@ -4139,7 +4140,7 @@ spapr_cpu_index_to_props(MachineState *machine, unsigned cpu_index)
 
 static int64_t spapr_get_default_cpu_node_id(const MachineState *ms, int idx)
 {
-    return idx / ms->smp.cores % nb_numa_nodes;
+    return numa_info[idx / ms->smp.cores % nb_numa_nodes].nodeid;
 }
 
 static const CPUArchIdList *spapr_possible_cpu_arch_ids(MachineState *machine)
diff --git a/include/sysemu/numa.h b/include/sysemu/numa.h
index 01a263eba2..6b0b49a699 100644
--- a/include/sysemu/numa.h
+++ b/include/sysemu/numa.h
@@ -13,6 +13,7 @@ struct NodeInfo {
     uint64_t node_mem;
     struct HostMemoryBackend *node_memdev;
     bool present;
+    uint16_t nodeid;
     uint8_t distance[MAX_NODES];
 };
 
-- 
2.21.0



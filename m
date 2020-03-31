Return-Path: <SRS0=xFA2=5Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAE6CC43331
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2020 15:38:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8C1C320848
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2020 15:38:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C1C320848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=de.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40456 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jJIxy-0005by-IK
	for qemu-devel@archiver.kernel.org; Tue, 31 Mar 2020 11:38:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35077)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <borntraeger@de.ibm.com>) id 1jJIvq-0001z1-09
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 11:36:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <borntraeger@de.ibm.com>) id 1jJIvn-0006Gq-Uw
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 11:36:01 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:30882)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
 id 1jJIvn-0006GW-Mq; Tue, 31 Mar 2020 11:35:59 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 02VFX9IM107353; Tue, 31 Mar 2020 11:35:58 -0400
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com with ESMTP id 303wrwbn5a-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 31 Mar 2020 11:35:58 -0400
Received: from m0098409.ppops.net (m0098409.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 02VFXEUf107746;
 Tue, 31 Mar 2020 11:35:57 -0400
Received: from ppma03dal.us.ibm.com (b.bd.3ea9.ip4.static.sl-reverse.com
 [169.62.189.11])
 by mx0a-001b2d01.pphosted.com with ESMTP id 303wrwbn4q-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 31 Mar 2020 11:35:57 -0400
Received: from pps.filterd (ppma03dal.us.ibm.com [127.0.0.1])
 by ppma03dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 02VFYSmk027159;
 Tue, 31 Mar 2020 15:35:56 GMT
Received: from b01cxnp22036.gho.pok.ibm.com (b01cxnp22036.gho.pok.ibm.com
 [9.57.198.26]) by ppma03dal.us.ibm.com with ESMTP id 301x77ge78-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 31 Mar 2020 15:35:56 +0000
Received: from b01ledav004.gho.pok.ibm.com (b01ledav004.gho.pok.ibm.com
 [9.57.199.109])
 by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 02VFZtIi8520446
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 31 Mar 2020 15:35:55 GMT
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8BAB6112066;
 Tue, 31 Mar 2020 15:35:55 +0000 (GMT)
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7379B112064;
 Tue, 31 Mar 2020 15:35:55 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.114.17.106])
 by b01ledav004.gho.pok.ibm.com (Postfix) with ESMTP;
 Tue, 31 Mar 2020 15:35:55 +0000 (GMT)
From: Christian Borntraeger <borntraeger@de.ibm.com>
To: qemu-devel <qemu-devel@nongnu.org>, Cornelia Huck <cohuck@redhat.com>
Subject: [PATCH v1] vl/s390: fixup ram sizes for compat machines
Date: Tue, 31 Mar 2020 11:35:54 -0400
Message-Id: <20200331153554.69341-1-borntraeger@de.ibm.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138, 18.0.676
 definitions=2020-03-31_05:2020-03-31,
 2020-03-31 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 lowpriorityscore=0
 mlxlogscore=999 clxscore=1015 bulkscore=0 malwarescore=0 suspectscore=0
 phishscore=0 priorityscore=1501 spamscore=0 adultscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2003310138
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by
 mx0a-001b2d01.pphosted.com id 02VFX9IM107353
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 148.163.156.1
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
Cc: =?UTF-8?q?Luk=C3=A1=C5=A1=20Doktor?= <ldoktor@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Janosch Frank <frankja@linux.ibm.com>,
 David Hildenbrand <david@redhat.com>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 qemu-s390x <qemu-s390x@nongnu.org>, Igor Mammedov <imammedo@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

compat machines did fixup the ram size to match what can be reported via
sclp. We need to mimic those for machines 4.2 and older to not fail on
inbound migration. For Machines >=3D 5.0 we can simply use an increment
size of 1M und use the full range of increment number which allows for
all possible memory sizes. The old limitation of having a maximum of
1020 increments was added for standby memory, which we no longer
support. With that we can now support even weird memory sizes like
10001234 MB.

Fixes: 3a12fc61af5c ("390x/s390-virtio-ccw: use memdev for RAM")
Reported-by: Luk=C3=A1=C5=A1 Doktor <ldoktor@redhat.com>
Cc: Igor Mammedov <imammedo@redhat.com>
Cc: Dr. David Alan Gilbert <dgilbert@redhat.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
RFC->v1:
- also fix mamram
- provide full granularity for machine 5.0

 hw/s390x/s390-skeys.c              |  2 +-
 hw/s390x/s390-stattrib-kvm.c       |  4 ++--
 hw/s390x/s390-virtio-ccw.c         | 20 ++++++++++++++++++++
 hw/s390x/sclp.c                    | 19 ++++++-------------
 include/hw/boards.h                |  1 +
 include/hw/s390x/s390-virtio-ccw.h |  4 +++-
 softmmu/vl.c                       |  3 +++
 7 files changed, 36 insertions(+), 17 deletions(-)

diff --git a/hw/s390x/s390-skeys.c b/hw/s390x/s390-skeys.c
index 5da6e5292f..a9a4ae7b39 100644
--- a/hw/s390x/s390-skeys.c
+++ b/hw/s390x/s390-skeys.c
@@ -176,7 +176,7 @@ static void qemu_s390_skeys_init(Object *obj)
     QEMUS390SKeysState *skeys =3D QEMU_S390_SKEYS(obj);
     MachineState *machine =3D MACHINE(qdev_get_machine());
=20
-    skeys->key_count =3D machine->maxram_size / TARGET_PAGE_SIZE;
+    skeys->key_count =3D machine->ram_size / TARGET_PAGE_SIZE;
     skeys->keydata =3D g_malloc0(skeys->key_count);
 }
=20
diff --git a/hw/s390x/s390-stattrib-kvm.c b/hw/s390x/s390-stattrib-kvm.c
index c7e1f35524..f89d8d9d16 100644
--- a/hw/s390x/s390-stattrib-kvm.c
+++ b/hw/s390x/s390-stattrib-kvm.c
@@ -85,7 +85,7 @@ static int kvm_s390_stattrib_set_stattr(S390StAttribSta=
te *sa,
 {
     KVMS390StAttribState *sas =3D KVM_S390_STATTRIB(sa);
     MachineState *machine =3D MACHINE(qdev_get_machine());
-    unsigned long max =3D machine->maxram_size / TARGET_PAGE_SIZE;
+    unsigned long max =3D machine->ram_size / TARGET_PAGE_SIZE;
=20
     if (start_gfn + count > max) {
         error_report("Out of memory bounds when setting storage attribut=
es");
@@ -104,7 +104,7 @@ static void kvm_s390_stattrib_synchronize(S390StAttri=
bState *sa)
 {
     KVMS390StAttribState *sas =3D KVM_S390_STATTRIB(sa);
     MachineState *machine =3D MACHINE(qdev_get_machine());
-    unsigned long max =3D machine->maxram_size / TARGET_PAGE_SIZE;
+    unsigned long max =3D machine->ram_size / TARGET_PAGE_SIZE;
     /* We do not need to reach the maximum buffer size allowed */
     unsigned long cx, len =3D KVM_S390_SKEYS_MAX / 2;
     int r;
diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
index 3cf19c99f3..bdfd10f77d 100644
--- a/hw/s390x/s390-virtio-ccw.c
+++ b/hw/s390x/s390-virtio-ccw.c
@@ -579,6 +579,16 @@ static void s390_nmi(NMIState *n, int cpu_index, Err=
or **errp)
     s390_cpu_restart(S390_CPU(cs));
 }
=20
+static ram_addr_t s390_align_ram(ram_addr_t sz)
+{
+    /* same logic as in sclp.c */
+    int increment_size =3D 20;
+    while ((sz >> increment_size) > 1020) {
+        increment_size++;
+    }
+    return sz >> increment_size << increment_size;
+}
+
 static void ccw_machine_class_init(ObjectClass *oc, void *data)
 {
     MachineClass *mc =3D MACHINE_CLASS(oc);
@@ -590,6 +600,7 @@ static void ccw_machine_class_init(ObjectClass *oc, v=
oid *data)
     s390mc->cpu_model_allowed =3D true;
     s390mc->css_migration_enabled =3D true;
     s390mc->hpage_1m_allowed =3D true;
+    s390mc->mem_inc_1020 =3D false;
     mc->init =3D ccw_init;
     mc->reset =3D s390_machine_reset;
     mc->hot_add_cpu =3D s390_hot_add_cpu;
@@ -686,6 +697,11 @@ bool hpage_1m_allowed(void)
     return get_machine_class()->hpage_1m_allowed;
 }
=20
+bool mem_inc_1020(void)
+{
+    return get_machine_class()->mem_inc_1020;
+}
+
 static char *machine_get_loadparm(Object *obj, Error **errp)
 {
     S390CcwMachineState *ms =3D S390_CCW_MACHINE(obj);
@@ -807,7 +823,11 @@ static void ccw_machine_4_2_instance_options(Machine=
State *machine)
=20
 static void ccw_machine_4_2_class_options(MachineClass *mc)
 {
+    S390CcwMachineClass *s390mc =3D S390_MACHINE_CLASS(mc);
+
     ccw_machine_5_0_class_options(mc);
+    mc->machine_align_ram =3D s390_align_ram;
+    s390mc->mem_inc_1020 =3D true;
     compat_props_add(mc->compat_props, hw_compat_4_2, hw_compat_4_2_len)=
;
 }
 DEFINE_CCW_MACHINE(4_2, "4.2", false);
diff --git a/hw/s390x/sclp.c b/hw/s390x/sclp.c
index d8ae207731..d1fff18443 100644
--- a/hw/s390x/sclp.c
+++ b/hw/s390x/sclp.c
@@ -21,6 +21,7 @@
 #include "hw/s390x/sclp.h"
 #include "hw/s390x/event-facility.h"
 #include "hw/s390x/s390-pci-bus.h"
+#include "hw/s390x/s390-virtio-ccw.h"
 #include "hw/s390x/ipl.h"
=20
 static inline SCLPDevice *get_sclp_device(void)
@@ -346,7 +347,7 @@ static void sclp_realize(DeviceState *dev, Error **er=
rp)
      */
     qdev_set_parent_bus(DEVICE(sclp->event_facility), sysbus_get_default=
());
=20
-    ret =3D s390_set_memory_limit(machine->maxram_size, &hw_limit);
+    ret =3D s390_set_memory_limit(machine->ram_size, &hw_limit);
     if (ret =3D=3D -E2BIG) {
         error_setg(&err, "host supports a maximum of %" PRIu64 " GB",
                    hw_limit / GiB);
@@ -365,23 +366,15 @@ static void sclp_memory_init(SCLPDevice *sclp)
     int increment_size =3D 20;
=20
     /* The storage increment size is a multiple of 1M and is a power of =
2.
-     * The number of storage increments must be MAX_STORAGE_INCREMENTS o=
r fewer.
+     * The number of storage increments must be MAX_STORAGE_INCREMENTS o=
r fewer
+     * for some machine types.
      * The variable 'increment_size' is an exponent of 2 that can be
      * used to calculate the size (in bytes) of an increment. */
-    while ((initial_mem >> increment_size) > MAX_STORAGE_INCREMENTS) {
+    while (mem_inc_1020() &&
+           (initial_mem >> increment_size) > MAX_STORAGE_INCREMENTS) {
         increment_size++;
     }
     sclp->increment_size =3D increment_size;
-
-    /* The core memory area needs to be aligned with the increment size.
-     * In effect, this can cause the user-specified memory size to be ro=
unded
-     * down to align with the nearest increment boundary. */
-    initial_mem =3D initial_mem >> increment_size << increment_size;
-
-    machine->ram_size =3D initial_mem;
-    machine->maxram_size =3D initial_mem;
-    /* let's propagate the changed ram size into the global variable. */
-    ram_size =3D initial_mem;
 }
=20
 static void sclp_init(Object *obj)
diff --git a/include/hw/boards.h b/include/hw/boards.h
index 236d239c19..e3574f4b5f 100644
--- a/include/hw/boards.h
+++ b/include/hw/boards.h
@@ -218,6 +218,7 @@ struct MachineClass {
                                                          unsigned cpu_in=
dex);
     const CPUArchIdList *(*possible_cpu_arch_ids)(MachineState *machine)=
;
     int64_t (*get_default_cpu_node_id)(const MachineState *ms, int idx);
+    ram_addr_t (*machine_align_ram)(ram_addr_t size);
 };
=20
 /**
diff --git a/include/hw/s390x/s390-virtio-ccw.h b/include/hw/s390x/s390-v=
irtio-ccw.h
index cd1dccc6e3..022ee6685b 100644
--- a/include/hw/s390x/s390-virtio-ccw.h
+++ b/include/hw/s390x/s390-virtio-ccw.h
@@ -41,6 +41,7 @@ typedef struct S390CcwMachineClass {
     bool cpu_model_allowed;
     bool css_migration_enabled;
     bool hpage_1m_allowed;
+    bool mem_inc_1020;
 } S390CcwMachineClass;
=20
 /* runtime-instrumentation allowed by the machine */
@@ -49,7 +50,8 @@ bool ri_allowed(void);
 bool cpu_model_allowed(void);
 /* 1M huge page mappings allowed by the machine */
 bool hpage_1m_allowed(void);
-
+/* Machine has only 1020 memory increments */
+bool mem_inc_1020(void);
 /**
  * Returns true if (vmstate based) migration of the channel subsystem
  * is enabled, false if it is disabled.
diff --git a/softmmu/vl.c b/softmmu/vl.c
index 1d33a28340..12b5758d12 100644
--- a/softmmu/vl.c
+++ b/softmmu/vl.c
@@ -2601,6 +2601,9 @@ static bool set_memory_options(uint64_t *ram_slots,=
 ram_addr_t *maxram_size,
     }
=20
     sz =3D QEMU_ALIGN_UP(sz, 8192);
+    if (mc->machine_align_ram) {
+        sz =3D mc->machine_align_ram(sz);
+    }
     ram_size =3D sz;
     if (ram_size !=3D sz) {
         error_report("ram size too large");
--=20
2.25.1



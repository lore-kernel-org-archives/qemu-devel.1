Return-Path: <SRS0=uFRu=5R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D355C43331
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Apr 2020 08:51:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4FB4820784
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Apr 2020 08:51:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4FB4820784
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=de.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49096 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jJZ5R-00075O-CH
	for qemu-devel@archiver.kernel.org; Wed, 01 Apr 2020 04:51:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43863)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <borntraeger@de.ibm.com>) id 1jJZ4q-0006eH-4t
 for qemu-devel@nongnu.org; Wed, 01 Apr 2020 04:50:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <borntraeger@de.ibm.com>) id 1jJZ4o-00084Q-9G
 for qemu-devel@nongnu.org; Wed, 01 Apr 2020 04:50:24 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:12558)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
 id 1jJZ4o-00083i-1Q; Wed, 01 Apr 2020 04:50:22 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 0318YnwJ109024; Wed, 1 Apr 2020 04:50:20 -0400
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com with ESMTP id 301yfgmh0q-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 01 Apr 2020 04:50:20 -0400
Received: from m0098393.ppops.net (m0098393.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 0318Z5Pc110976;
 Wed, 1 Apr 2020 04:50:20 -0400
Received: from ppma01wdc.us.ibm.com (fd.55.37a9.ip4.static.sl-reverse.com
 [169.55.85.253])
 by mx0a-001b2d01.pphosted.com with ESMTP id 301yfgmgyu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 01 Apr 2020 04:50:20 -0400
Received: from pps.filterd (ppma01wdc.us.ibm.com [127.0.0.1])
 by ppma01wdc.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 0318oGk3029158;
 Wed, 1 Apr 2020 08:50:18 GMT
Received: from b03cxnp08025.gho.boulder.ibm.com
 (b03cxnp08025.gho.boulder.ibm.com [9.17.130.17])
 by ppma01wdc.us.ibm.com with ESMTP id 301x767jvg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 01 Apr 2020 08:50:18 +0000
Received: from b03ledav002.gho.boulder.ibm.com
 (b03ledav002.gho.boulder.ibm.com [9.17.130.233])
 by b03cxnp08025.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 0318oHgQ59244842
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 1 Apr 2020 08:50:17 GMT
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 84259136053;
 Wed,  1 Apr 2020 08:50:17 +0000 (GMT)
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B86FA136060;
 Wed,  1 Apr 2020 08:50:16 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.114.17.106])
 by b03ledav002.gho.boulder.ibm.com (Postfix) with ESMTP;
 Wed,  1 Apr 2020 08:50:16 +0000 (GMT)
From: Christian Borntraeger <borntraeger@de.ibm.com>
To: qemu-devel <qemu-devel@nongnu.org>, Cornelia Huck <cohuck@redhat.com>
Subject: [PATCH v2] vl/s390: fixup ram sizes for compat machines
Date: Wed,  1 Apr 2020 04:50:14 -0400
Message-Id: <20200401085014.100125-1-borntraeger@de.ibm.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138, 18.0.676
 definitions=2020-03-31_07:2020-03-31,
 2020-03-31 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0
 suspectscore=0 impostorscore=0 mlxscore=0 phishscore=0 clxscore=1015
 bulkscore=0 malwarescore=0 spamscore=0 mlxlogscore=999 adultscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004010073
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by
 mx0a-001b2d01.pphosted.com id 0318YnwJ109024
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

Older QEMU versions did fixup the ram size to match what can be reported
via sclp. We need to mimic this behaviour for machine types 4.2 and
older to not fail on inbound migration for memory sizes that do not fit.
Old machines with proper aligned memory sizes are not affected.

Alignment table:
 VM size (<=3D) | Alignment
--------------------------
      1020M   |     1M
      2040M   |     2M
      4080M   |     4M
      8160M   |     8M
     16320M   |    16M
     32640M   |    32M
     65280M   |    64M
    130560M   |   128M
    261120M   |   256M
    522240M   |   512M
   1044480M   |     1G
   2088960M   |     2G
   4177920M   |     4G
   8355840M   |     8G

Suggested action is to replace unaligned -m value with a suitable
aligned one or to use a machine version >=3D 5.0 as future versions might
remove the compatibility handling.

For machine types >=3D 5.0 we can simply use an increment size of 1M and
use the full range of increment number which allows for all possible
memory sizes. The old limitation of having a maximum of 1020 increments
was added for standby memory, which we no longer support. With that we
can now support even weird memory sizes like 10001234 MB.

Fixes: 3a12fc61af5c ("390x/s390-virtio-ccw: use memdev for RAM")
Reported-by: Luk=C3=A1=C5=A1 Doktor <ldoktor@redhat.com>
Cc: Igor Mammedov <imammedo@redhat.com>
Cc: Dr. David Alan Gilbert <dgilbert@redhat.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 hw/s390x/s390-skeys.c        |  2 +-
 hw/s390x/s390-stattrib-kvm.c |  4 ++--
 hw/s390x/s390-virtio-ccw.c   | 19 +++++++++++++++++++
 hw/s390x/sclp.c              | 19 ++++++-------------
 include/hw/boards.h          |  7 +++++++
 softmmu/vl.c                 |  3 +++
 6 files changed, 38 insertions(+), 16 deletions(-)

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
index 3cf19c99f3..3e8c34a3e1 100644
--- a/hw/s390x/s390-virtio-ccw.c
+++ b/hw/s390x/s390-virtio-ccw.c
@@ -27,6 +27,7 @@
 #include "qemu/ctype.h"
 #include "qemu/error-report.h"
 #include "qemu/option.h"
+#include "qemu/qemu-print.h"
 #include "s390-pci-bus.h"
 #include "sysemu/reset.h"
 #include "hw/s390x/storage-keys.h"
@@ -579,6 +580,23 @@ static void s390_nmi(NMIState *n, int cpu_index, Err=
or **errp)
     s390_cpu_restart(S390_CPU(cs));
 }
=20
+static ram_addr_t s390_fixup_ram_size(ram_addr_t sz)
+{
+    /* same logic as in sclp.c */
+    int increment_size =3D 20;
+    while ((sz >> increment_size) > MAX_STORAGE_INCREMENTS) {
+        increment_size++;
+    }
+    if (sz !=3D sz >> increment_size << increment_size) {
+        qemu_printf("Ram size %" PRIu64 "MB was fixed up to %" PRIu64
+                    "MB to match machine restrictions. Consider updating=
 "
+                    "the guest definition.\n",
+                    sz / 1048576,
+                    (sz >> increment_size << increment_size) / 1048576);
+    }
+    return sz >> increment_size << increment_size;
+}
+
 static void ccw_machine_class_init(ObjectClass *oc, void *data)
 {
     MachineClass *mc =3D MACHINE_CLASS(oc);
@@ -808,6 +826,7 @@ static void ccw_machine_4_2_instance_options(MachineS=
tate *machine)
 static void ccw_machine_4_2_class_options(MachineClass *mc)
 {
     ccw_machine_5_0_class_options(mc);
+    mc->fixup_ram_size =3D s390_fixup_ram_size;
     compat_props_add(mc->compat_props, hw_compat_4_2, hw_compat_4_2_len)=
;
 }
 DEFINE_CCW_MACHINE(4_2, "4.2", false);
diff --git a/hw/s390x/sclp.c b/hw/s390x/sclp.c
index d8ae207731..d843c8fea2 100644
--- a/hw/s390x/sclp.c
+++ b/hw/s390x/sclp.c
@@ -346,7 +346,7 @@ static void sclp_realize(DeviceState *dev, Error **er=
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
@@ -361,27 +361,20 @@ out:
 static void sclp_memory_init(SCLPDevice *sclp)
 {
     MachineState *machine =3D MACHINE(qdev_get_machine());
+    MachineClass *machine_class =3D MACHINE_GET_CLASS(qdev_get_machine()=
);
     ram_addr_t initial_mem =3D machine->ram_size;
     int increment_size =3D 20;
=20
     /* The storage increment size is a multiple of 1M and is a power of =
2.
-     * The number of storage increments must be MAX_STORAGE_INCREMENTS o=
r fewer.
+     * For some machine types, the number of storage increments must be
+     * MAX_STORAGE_INCREMENTS or fewer.
      * The variable 'increment_size' is an exponent of 2 that can be
      * used to calculate the size (in bytes) of an increment. */
-    while ((initial_mem >> increment_size) > MAX_STORAGE_INCREMENTS) {
+    while (machine_class->fixup_ram_size !=3D NULL &&
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
index 236d239c19..0532143327 100644
--- a/include/hw/boards.h
+++ b/include/hw/boards.h
@@ -152,6 +152,12 @@ typedef struct {
  *    It also will be used as a way to optin into "-m" option support.
  *    If it's not set by board, '-m' will be ignored and generic code wi=
ll
  *    not create default RAM MemoryRegion.
+ * @fixup_ram_size:
+ *    amends user provided ram size (with -m option) using machine
+ *    specific algorithm. to be used by old machine types for compat
+ *    purposes only.
+ *    Applies only to default memory backend, i.e. explicit memory backe=
nd
+ *    wasn't used.
  */
 struct MachineClass {
     /*< private >*/
@@ -218,6 +224,7 @@ struct MachineClass {
                                                          unsigned cpu_in=
dex);
     const CPUArchIdList *(*possible_cpu_arch_ids)(MachineState *machine)=
;
     int64_t (*get_default_cpu_node_id)(const MachineState *ms, int idx);
+    ram_addr_t (*fixup_ram_size)(ram_addr_t size);
 };
=20
 /**
diff --git a/softmmu/vl.c b/softmmu/vl.c
index 1d33a28340..09f8a1b0a7 100644
--- a/softmmu/vl.c
+++ b/softmmu/vl.c
@@ -2601,6 +2601,9 @@ static bool set_memory_options(uint64_t *ram_slots,=
 ram_addr_t *maxram_size,
     }
=20
     sz =3D QEMU_ALIGN_UP(sz, 8192);
+    if (mc->fixup_ram_size) {
+        sz =3D mc->fixup_ram_size(sz);
+    }
     ram_size =3D sz;
     if (ram_size !=3D sz) {
         error_report("ram size too large");
--=20
2.25.1



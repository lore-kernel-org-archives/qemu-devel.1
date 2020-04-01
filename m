Return-Path: <SRS0=uFRu=5R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB777C43331
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Apr 2020 12:38:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A38382078B
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Apr 2020 12:38:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A38382078B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=de.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59806 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jJcdm-0004Se-RM
	for qemu-devel@archiver.kernel.org; Wed, 01 Apr 2020 08:38:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55329)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <borntraeger@de.ibm.com>) id 1jJcd8-00042E-BB
 for qemu-devel@nongnu.org; Wed, 01 Apr 2020 08:38:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <borntraeger@de.ibm.com>) id 1jJcd5-0002dw-M3
 for qemu-devel@nongnu.org; Wed, 01 Apr 2020 08:38:02 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:47028)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
 id 1jJcd5-0002da-Gh; Wed, 01 Apr 2020 08:37:59 -0400
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 031CY7U2115591; Wed, 1 Apr 2020 08:37:58 -0400
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com with ESMTP id 304mcbbpss-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 01 Apr 2020 08:37:58 -0400
Received: from m0127361.ppops.net (m0127361.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 031CYTrS116573;
 Wed, 1 Apr 2020 08:37:57 -0400
Received: from ppma04dal.us.ibm.com (7a.29.35a9.ip4.static.sl-reverse.com
 [169.53.41.122])
 by mx0a-001b2d01.pphosted.com with ESMTP id 304mcbbpsd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 01 Apr 2020 08:37:57 -0400
Received: from pps.filterd (ppma04dal.us.ibm.com [127.0.0.1])
 by ppma04dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 031CbphM009661;
 Wed, 1 Apr 2020 12:37:57 GMT
Received: from b01cxnp23034.gho.pok.ibm.com (b01cxnp23034.gho.pok.ibm.com
 [9.57.198.29]) by ppma04dal.us.ibm.com with ESMTP id 301x76s3uu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 01 Apr 2020 12:37:57 +0000
Received: from b01ledav004.gho.pok.ibm.com (b01ledav004.gho.pok.ibm.com
 [9.57.199.109])
 by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 031CbuNe39125480
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 1 Apr 2020 12:37:56 GMT
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 485BA112069;
 Wed,  1 Apr 2020 12:37:56 +0000 (GMT)
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2F95B112065;
 Wed,  1 Apr 2020 12:37:56 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.114.17.106])
 by b01ledav004.gho.pok.ibm.com (Postfix) with ESMTP;
 Wed,  1 Apr 2020 12:37:56 +0000 (GMT)
From: Christian Borntraeger <borntraeger@de.ibm.com>
To: qemu-devel <qemu-devel@nongnu.org>, Cornelia Huck <cohuck@redhat.com>
Subject: [PATCH v3 1/1] vl/s390x: fixup ram sizes for compat machines
Date: Wed,  1 Apr 2020 08:37:54 -0400
Message-Id: <20200401123754.109602-1-borntraeger@de.ibm.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138, 18.0.676
 definitions=2020-04-01_01:2020-03-31,
 2020-03-31 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0
 suspectscore=0 bulkscore=0 mlxscore=0 adultscore=0 priorityscore=1501
 clxscore=1015 lowpriorityscore=0 malwarescore=0 phishscore=0
 mlxlogscore=999 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2003020000 definitions=main-2004010109
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by
 mx0a-001b2d01.pphosted.com id 031CY7U2115591
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 148.163.158.5
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
aligned one or if a change to a newer machine type is possible, use a
machine version >=3D 5.0.

A future versions might remove the compatibility handling.

For machine types >=3D 5.0 we can simply use an increment size of 1M and
use the full range of increment number which allows for all possible
memory sizes. The old limitation of having a maximum of 1020 increments
was added for standby memory, which we no longer support. With that we
can now support even weird memory sizes like 10001234 MB.

As we no longer fixup maxram_size as well, make other users use ram_size
instead. Keep using maxram_size when setting the maximum ram size in KVM,
as that will come in handy in the future when supporting memory hotplug
(in contrast, storage keys and storage attributes for hotplugged memory
will have to be migrated per RAM block in the future).

Fixes: 3a12fc61af5c ("390x/s390-virtio-ccw: use memdev for RAM")
Reported-by: Luk=C3=A1=C5=A1 Doktor <ldoktor@redhat.com>
Cc: Igor Mammedov <imammedo@redhat.com>
Cc: Dr. David Alan Gilbert <dgilbert@redhat.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 hw/s390x/s390-skeys.c        |  2 +-
 hw/s390x/s390-stattrib-kvm.c |  4 ++--
 hw/s390x/s390-virtio-ccw.c   | 21 +++++++++++++++++++++
 hw/s390x/sclp.c              | 17 +++++------------
 include/hw/boards.h          |  7 +++++++
 softmmu/vl.c                 |  3 +++
 6 files changed, 39 insertions(+), 15 deletions(-)

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
index 3cf19c99f3..61a8a0e693 100644
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
@@ -579,6 +580,25 @@ static void s390_nmi(NMIState *n, int cpu_index, Err=
or **errp)
     s390_cpu_restart(S390_CPU(cs));
 }
=20
+static ram_addr_t s390_fixup_ram_size(ram_addr_t sz)
+{
+    /* same logic as in sclp.c */
+    int increment_size =3D 20;
+    ram_addr_t newsz;
+
+    while ((sz >> increment_size) > MAX_STORAGE_INCREMENTS) {
+        increment_size++;
+    }
+    newsz =3D sz >> increment_size << increment_size;
+
+    if (sz !=3D newsz) {
+        qemu_printf("Ram size %" PRIu64 "MB was fixed up to %" PRIu64
+                    "MB to match machine restrictions. Consider updating=
 "
+                    "the guest definition.i\n", sz / MiB, newsz / MiB);
+    }
+    return newsz;
+}
+
 static void ccw_machine_class_init(ObjectClass *oc, void *data)
 {
     MachineClass *mc =3D MACHINE_CLASS(oc);
@@ -808,6 +828,7 @@ static void ccw_machine_4_2_instance_options(MachineS=
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
index d8ae207731..ede056b3ef 100644
--- a/hw/s390x/sclp.c
+++ b/hw/s390x/sclp.c
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
index 236d239c19..fd4d62b501 100644
--- a/include/hw/boards.h
+++ b/include/hw/boards.h
@@ -152,6 +152,12 @@ typedef struct {
  *    It also will be used as a way to optin into "-m" option support.
  *    If it's not set by board, '-m' will be ignored and generic code wi=
ll
  *    not create default RAM MemoryRegion.
+ * @fixup_ram_size:
+ *    Amends user provided ram size (with -m option) using machine
+ *    specific algorithm. To be used by old machine types for compat
+ *    purposes only.
+ *    Applies only to default memory backend, i.e., explicit memory back=
end
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



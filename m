Return-Path: <SRS0=xFA2=5Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59B41C2D0EE
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2020 12:04:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 32A1F20838
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2020 12:04:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 32A1F20838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=de.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36842 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jJFdF-0003LO-8h
	for qemu-devel@archiver.kernel.org; Tue, 31 Mar 2020 08:04:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60318)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <borntraeger@de.ibm.com>) id 1jJFbR-0001oz-V0
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 08:02:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <borntraeger@de.ibm.com>) id 1jJFbQ-0003Q9-Pb
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 08:02:45 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:48634)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
 id 1jJFbQ-0003PB-IO; Tue, 31 Mar 2020 08:02:44 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 02VC2c7H108568; Tue, 31 Mar 2020 08:02:43 -0400
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com with ESMTP id 303wrw4nkh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 31 Mar 2020 08:02:42 -0400
Received: from m0098409.ppops.net (m0098409.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 02VC2gFU109036;
 Tue, 31 Mar 2020 08:02:42 -0400
Received: from ppma03dal.us.ibm.com (b.bd.3ea9.ip4.static.sl-reverse.com
 [169.62.189.11])
 by mx0a-001b2d01.pphosted.com with ESMTP id 303wrw4njq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 31 Mar 2020 08:02:42 -0400
Received: from pps.filterd (ppma03dal.us.ibm.com [127.0.0.1])
 by ppma03dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 02VC0lwP031447;
 Tue, 31 Mar 2020 12:02:40 GMT
Received: from b01cxnp23032.gho.pok.ibm.com (b01cxnp23032.gho.pok.ibm.com
 [9.57.198.27]) by ppma03dal.us.ibm.com with ESMTP id 301x77ercd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 31 Mar 2020 12:02:40 +0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com
 [9.57.199.108])
 by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 02VC2eZ555247246
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 31 Mar 2020 12:02:40 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0347FB2066;
 Tue, 31 Mar 2020 12:02:40 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E6D82B2064;
 Tue, 31 Mar 2020 12:02:39 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.114.17.106])
 by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
 Tue, 31 Mar 2020 12:02:39 +0000 (GMT)
From: Christian Borntraeger <borntraeger@de.ibm.com>
To: qemu-devel <qemu-devel@nongnu.org>, Cornelia Huck <cohuck@redhat.com>
Subject: [PATCH/RFC] vl/s390: fixup ram sizes for compat machines
Date: Tue, 31 Mar 2020 08:02:38 -0400
Message-Id: <20200331120238.15786-1-borntraeger@de.ibm.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138, 18.0.676
 definitions=2020-03-31_04:2020-03-31,
 2020-03-31 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 lowpriorityscore=0
 mlxlogscore=999 clxscore=1015 bulkscore=0 malwarescore=0 suspectscore=0
 phishscore=0 priorityscore=1501 spamscore=0 adultscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2003310106
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by
 mx0a-001b2d01.pphosted.com id 02VC2c7H108568
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
inbound migration.

Fixes: 3a12fc61af5c ("390x/s390-virtio-ccw: use memdev for RAM")
Reported-by: Luk=C3=A1=C5=A1 Doktor <ldoktor@redhat.com>
Cc: Igor Mammedov <imammedo@redhat.com>
Cc: Dr. David Alan Gilbert <dgilbert@redhat.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 hw/s390x/s390-virtio-ccw.c | 12 ++++++++++++
 hw/s390x/sclp.c            | 10 ----------
 include/hw/boards.h        |  1 +
 softmmu/vl.c               |  3 +++
 4 files changed, 16 insertions(+), 10 deletions(-)

diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
index 3cf19c99f3..748c08b157 100644
--- a/hw/s390x/s390-virtio-ccw.c
+++ b/hw/s390x/s390-virtio-ccw.c
@@ -579,6 +579,17 @@ static void s390_nmi(NMIState *n, int cpu_index, Err=
or **errp)
     s390_cpu_restart(S390_CPU(cs));
 }
=20
+#define MAX_STORAGE_INCREMENTS                  1020
+static ram_addr_t s390_align_ram(ram_addr_t sz)
+{
+    /* same logic as in sclp.c */
+    int increment_size =3D 20;
+    while ((sz >> increment_size) > MAX_STORAGE_INCREMENTS) {
+        increment_size++;
+    }
+    return sz >> increment_size << increment_size;
+}
+
 static void ccw_machine_class_init(ObjectClass *oc, void *data)
 {
     MachineClass *mc =3D MACHINE_CLASS(oc);
@@ -808,6 +819,7 @@ static void ccw_machine_4_2_instance_options(MachineS=
tate *machine)
 static void ccw_machine_4_2_class_options(MachineClass *mc)
 {
     ccw_machine_5_0_class_options(mc);
+    mc->machine_align_ram =3D s390_align_ram;
     compat_props_add(mc->compat_props, hw_compat_4_2, hw_compat_4_2_len)=
;
 }
 DEFINE_CCW_MACHINE(4_2, "4.2", false);
diff --git a/hw/s390x/sclp.c b/hw/s390x/sclp.c
index d8ae207731..0a6ff2be82 100644
--- a/hw/s390x/sclp.c
+++ b/hw/s390x/sclp.c
@@ -372,16 +372,6 @@ static void sclp_memory_init(SCLPDevice *sclp)
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



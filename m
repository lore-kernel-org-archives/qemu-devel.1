Return-Path: <SRS0=kvq2=23=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BEB3C2D0D1
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jan 2020 10:30:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 32508206DA
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jan 2020 10:30:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 32508206DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50278 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ioPen-0003GW-9d
	for qemu-devel@archiver.kernel.org; Mon, 06 Jan 2020 05:30:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41073)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groug@kaod.org>) id 1ioPdw-0002BS-O5
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 05:29:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groug@kaod.org>) id 1ioPdv-0002qS-Ad
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 05:29:52 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:50044)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <groug@kaod.org>) id 1ioPdv-0002pT-2I
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 05:29:51 -0500
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 006ASLaN076148
 for <qemu-devel@nongnu.org>; Mon, 6 Jan 2020 05:29:49 -0500
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2xb92kwbqq-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 06 Jan 2020 05:29:49 -0500
Received: from localhost
 by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <groug@kaod.org>;
 Mon, 6 Jan 2020 10:29:47 -0000
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
 by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Mon, 6 Jan 2020 10:29:44 -0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com
 (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
 by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 006AThuc49283148
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 6 Jan 2020 10:29:43 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A1580A405F;
 Mon,  6 Jan 2020 10:29:43 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6F762A405C;
 Mon,  6 Jan 2020 10:29:43 +0000 (GMT)
Received: from bahia.lan (unknown [9.145.66.144])
 by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Mon,  6 Jan 2020 10:29:43 +0000 (GMT)
Subject: [PATCH] ppc/pnv: Drop "num-chips" machine property
From: Greg Kurz <groug@kaod.org>
To: David Gibson <david@gibson.dropbear.id.au>,
 =?utf-8?q?C=C3=A9dric?= Le Goater <clg@kaod.org>
Date: Mon, 06 Jan 2020 11:29:42 +0100
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 20010610-4275-0000-0000-0000039509F0
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20010610-4276-0000-0000-000038A8F24C
Message-Id: <157830658266.533764.2214183961444213947.stgit@bahia.lan>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2020-01-06_03:2020-01-06,2020-01-06 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 adultscore=0
 lowpriorityscore=0 spamscore=0 phishscore=0 priorityscore=1501
 impostorscore=0 bulkscore=0 malwarescore=0 mlxlogscore=999 suspectscore=0
 clxscore=1034 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-2001060096
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic] [fuzzy]
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
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The number of CPU chips of the powernv machine is configurable through a
"num-chips" property. This doesn't fit well with the CPU topology, eg.
some configurations can come up with more CPUs than the maximum of CPUs
set in the toplogy. This causes assertion to be hit with mttcg:

   -machine powernv,num-chips=2 -smp cores=2 -accel tcg,thread=multi

ERROR:
tcg/tcg.c:789:tcg_register_thread: assertion failed: (n < ms->smp.max_cpus)
Aborted (core dumped)

Mttcg mandates the CPU topology to be dimensioned to the actual number
of CPUs, depending on the number of chips the user asked for. That is,
'-machine num-chips=N' should always have a '-smp' companion with a
topology that meats the resulting number of CPUs, typically
'-smp sockets=N'.

It thus seems that "num-chips" doesn't bring anything but forcing the user
to specify the requested number of chips on the command line twice. Simplify
the command line by computing the number of chips based on the CPU topology
exclusively. The powernv machine isn't a production thing ; it is mostly
used by developpers to prepare the bringup of real HW. Because of this and
for simplicity, this deliberately ignores the official deprecation process
and dumps "num-chips" right away : '-smp sockets=N' is now the only way to
control the number of CPU chips.

This is done at machine init because smp_parse() is called after instance
init.

Signed-off-by: Greg Kurz <groug@kaod.org>
---
 hw/ppc/pnv.c |   62 +++++++++++-----------------------------------------------
 1 file changed, 12 insertions(+), 50 deletions(-)

diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index f77e7ca84ede..b225ffbb2c41 100644
--- a/hw/ppc/pnv.c
+++ b/hw/ppc/pnv.c
@@ -768,6 +768,18 @@ static void pnv_init(MachineState *machine)
         exit(1);
     }
 
+    pnv->num_chips =
+        machine->smp.max_cpus / (machine->smp.cores * machine->smp.threads);
+    /*
+     * TODO: should we decide on how many chips we can create based
+     * on #cores and Venice vs. Murano vs. Naples chip type etc...,
+     */
+    if (!is_power_of_2(pnv->num_chips) || pnv->num_chips > 4) {
+        error_report("invalid number of chips: '%d'", pnv->num_chips);
+        error_printf("Try '-smp sockets=N'. Valid values are : 1, 2 or 4.\n");
+        exit(1);
+    }
+
     pnv->chips = g_new0(PnvChip *, pnv->num_chips);
     for (i = 0; i < pnv->num_chips; i++) {
         char chip_name[32];
@@ -1696,53 +1708,6 @@ PnvChip *pnv_get_chip(uint32_t chip_id)
     return NULL;
 }
 
-static void pnv_get_num_chips(Object *obj, Visitor *v, const char *name,
-                              void *opaque, Error **errp)
-{
-    visit_type_uint32(v, name, &PNV_MACHINE(obj)->num_chips, errp);
-}
-
-static void pnv_set_num_chips(Object *obj, Visitor *v, const char *name,
-                              void *opaque, Error **errp)
-{
-    PnvMachineState *pnv = PNV_MACHINE(obj);
-    uint32_t num_chips;
-    Error *local_err = NULL;
-
-    visit_type_uint32(v, name, &num_chips, &local_err);
-    if (local_err) {
-        error_propagate(errp, local_err);
-        return;
-    }
-
-    /*
-     * TODO: should we decide on how many chips we can create based
-     * on #cores and Venice vs. Murano vs. Naples chip type etc...,
-     */
-    if (!is_power_of_2(num_chips) || num_chips > 4) {
-        error_setg(errp, "invalid number of chips: '%d'", num_chips);
-        return;
-    }
-
-    pnv->num_chips = num_chips;
-}
-
-static void pnv_machine_instance_init(Object *obj)
-{
-    PnvMachineState *pnv = PNV_MACHINE(obj);
-    pnv->num_chips = 1;
-}
-
-static void pnv_machine_class_props_init(ObjectClass *oc)
-{
-    object_class_property_add(oc, "num-chips", "uint32",
-                              pnv_get_num_chips, pnv_set_num_chips,
-                              NULL, NULL, NULL);
-    object_class_property_set_description(oc, "num-chips",
-                              "Specifies the number of processor chips",
-                              NULL);
-}
-
 static void pnv_machine_power8_class_init(ObjectClass *oc, void *data)
 {
     MachineClass *mc = MACHINE_CLASS(oc);
@@ -1812,8 +1777,6 @@ static void pnv_machine_class_init(ObjectClass *oc, void *data)
      */
     mc->default_ram_size = INITRD_LOAD_ADDR + INITRD_MAX_SIZE;
     ispc->print_info = pnv_pic_print_info;
-
-    pnv_machine_class_props_init(oc);
 }
 
 #define DEFINE_PNV8_CHIP_TYPE(type, class_initfn) \
@@ -1866,7 +1829,6 @@ static const TypeInfo types[] = {
         .parent        = TYPE_MACHINE,
         .abstract       = true,
         .instance_size = sizeof(PnvMachineState),
-        .instance_init = pnv_machine_instance_init,
         .class_init    = pnv_machine_class_init,
         .class_size    = sizeof(PnvMachineClass),
         .interfaces = (InterfaceInfo[]) {



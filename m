Return-Path: <SRS0=FSHi=DM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43F0DC4363A
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2020 16:56:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E6A77204EA
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2020 16:56:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E6A77204EA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39702 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kPTmr-0007wZ-LR
	for qemu-devel@archiver.kernel.org; Mon, 05 Oct 2020 12:56:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46554)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>)
 id 1kPTie-00039e-W8; Mon, 05 Oct 2020 12:52:13 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:61154)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>)
 id 1kPTid-0001e4-5H; Mon, 05 Oct 2020 12:52:12 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 095Gjmax105076; Mon, 5 Oct 2020 12:52:06 -0400
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com
 [169.51.49.98])
 by mx0a-001b2d01.pphosted.com with ESMTP id 34079w03wa-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 05 Oct 2020 12:52:05 -0400
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
 by ppma03ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 095Gq3ts006808;
 Mon, 5 Oct 2020 16:52:03 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com
 (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
 by ppma03ams.nl.ibm.com with ESMTP id 33xgx8ack8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 05 Oct 2020 16:52:03 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com
 [9.149.105.58])
 by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 095Gq1Hh32440652
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 5 Oct 2020 16:52:01 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 18D2D4C058;
 Mon,  5 Oct 2020 16:52:01 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B90994C044;
 Mon,  5 Oct 2020 16:52:00 +0000 (GMT)
Received: from smtp.tlslab.ibm.com (unknown [9.101.4.1])
 by d06av22.portsmouth.uk.ibm.com (Postfix) with SMTP;
 Mon,  5 Oct 2020 16:52:00 +0000 (GMT)
Received: from yukon.ibmuc.com (sig-9-145-2-207.uk.ibm.com [9.145.2.207])
 by smtp.tlslab.ibm.com (Postfix) with ESMTP id F2EE2220155;
 Mon,  5 Oct 2020 18:51:59 +0200 (CEST)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: [PATCH v2 5/6] spapr/xive: Activate StoreEOI at the source level
Date: Mon,  5 Oct 2020 18:51:46 +0200
Message-Id: <20201005165147.526426-6-clg@kaod.org>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20201005165147.526426-1-clg@kaod.org>
References: <20201005165147.526426-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235, 18.0.687
 definitions=2020-10-05_11:2020-10-05,
 2020-10-05 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0
 priorityscore=1501 impostorscore=0 clxscore=1034 bulkscore=0 adultscore=0
 suspectscore=0 phishscore=0 mlxscore=0 malwarescore=0 mlxlogscore=999
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2010050117
Received-SPF: softfail client-ip=148.163.156.1; envelope-from=clg@kaod.org;
 helo=mx0a-001b2d01.pphosted.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/05 12:52:09
X-ACL-Warn: Detected OS   = Linux 3.x [generic] [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_SOFTFAIL=0.665 autolearn=no autolearn_force=no
X-Spam_action: no action
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
Cc: qemu-devel@nongnu.org, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 qemu-ppc@nongnu.org, Greg Kurz <groug@kaod.org>,
 Gustavo Romero <gromero@linux.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

When the StoreEOI capability is "on", the H_INT_GET_SOURCE_INFO will
set the StoreEOI flag for all sources. This could be an issue if
StoreEOI is not supported on a specific source, of a passthrough
device for instance. In that case, we could either introduce a new KVM
ioctl to query the characteristics of the source at the HW level or
deactivate StoreEOI on the machine.

This is theoretically unsafe on a POWER9 host but it still runs.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 hw/intc/spapr_xive.c | 1 +
 hw/ppc/spapr_irq.c   | 6 ++++++
 2 files changed, 7 insertions(+)

diff --git a/hw/intc/spapr_xive.c b/hw/intc/spapr_xive.c
index 1fa09f287ac0..41f2719ff93a 100644
--- a/hw/intc/spapr_xive.c
+++ b/hw/intc/spapr_xive.c
@@ -280,6 +280,7 @@ static void spapr_xive_instance_init(Object *obj)
     SpaprXive *xive =3D SPAPR_XIVE(obj);
=20
     object_initialize_child(obj, "source", &xive->source, TYPE_XIVE_SOUR=
CE);
+    object_property_add_alias(obj, "flags", OBJECT(&xive->source), "flag=
s");
=20
     object_initialize_child(obj, "end_source", &xive->end_source,
                             TYPE_XIVE_END_SOURCE);
diff --git a/hw/ppc/spapr_irq.c b/hw/ppc/spapr_irq.c
index f59960339ec3..cdf9f9df4173 100644
--- a/hw/ppc/spapr_irq.c
+++ b/hw/ppc/spapr_irq.c
@@ -325,9 +325,14 @@ void spapr_irq_init(SpaprMachineState *spapr, Error =
**errp)
=20
     if (spapr->irq->xive) {
         uint32_t nr_servers =3D spapr_max_server_number(spapr);
+        uint64_t flags =3D 0;
         DeviceState *dev;
         int i;
=20
+        if (spapr_get_cap(spapr, SPAPR_CAP_STOREEOI) =3D=3D SPAPR_CAP_ON=
) {
+            flags |=3D XIVE_SRC_STORE_EOI;
+        }
+
         dev =3D qdev_new(TYPE_SPAPR_XIVE);
         qdev_prop_set_uint32(dev, "nr-irqs", smc->nr_xirqs + SPAPR_XIRQ_=
BASE);
         /*
@@ -337,6 +342,7 @@ void spapr_irq_init(SpaprMachineState *spapr, Error *=
*errp)
         qdev_prop_set_uint32(dev, "nr-ends", nr_servers << 3);
         object_property_set_link(OBJECT(dev), "xive-fabric", OBJECT(spap=
r),
                                  &error_abort);
+        object_property_set_int(OBJECT(dev), "flags", flags, &error_abor=
t);
         sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
=20
         spapr->xive =3D SPAPR_XIVE(dev);
--=20
2.25.4



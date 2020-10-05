Return-Path: <SRS0=FSHi=DM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9275C4363A
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2020 16:53:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 25972207F7
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2020 16:53:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 25972207F7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59936 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kPTjy-0004bI-2z
	for qemu-devel@archiver.kernel.org; Mon, 05 Oct 2020 12:53:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46512)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>)
 id 1kPTid-00038z-Is; Mon, 05 Oct 2020 12:52:11 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:39284
 helo=mx0a-001b2d01.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>)
 id 1kPTib-0001du-OK; Mon, 05 Oct 2020 12:52:11 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 095GX9A4009575; Mon, 5 Oct 2020 12:52:07 -0400
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com
 [169.51.49.102])
 by mx0b-001b2d01.pphosted.com with ESMTP id 34061casqf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 05 Oct 2020 12:52:06 -0400
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
 by ppma06ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 095GcqOY013442;
 Mon, 5 Oct 2020 16:52:05 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com
 (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
 by ppma06ams.nl.ibm.com with ESMTP id 33xgjh2cj6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 05 Oct 2020 16:52:05 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com
 [9.149.105.62])
 by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 095Gq2oV21889418
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 5 Oct 2020 16:52:03 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B4EE1AE051;
 Mon,  5 Oct 2020 16:52:01 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 520F0AE057;
 Mon,  5 Oct 2020 16:52:01 +0000 (GMT)
Received: from smtp.tlslab.ibm.com (unknown [9.101.4.1])
 by d06av26.portsmouth.uk.ibm.com (Postfix) with SMTP;
 Mon,  5 Oct 2020 16:52:01 +0000 (GMT)
Received: from yukon.ibmuc.com (sig-9-145-2-207.uk.ibm.com [9.145.2.207])
 by smtp.tlslab.ibm.com (Postfix) with ESMTP id 9B3872201BC;
 Mon,  5 Oct 2020 18:52:00 +0200 (CEST)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: [PATCH v2 6/6] spapr/xive: Introduce a new CAS value for the StoreEOI
 capability
Date: Mon,  5 Oct 2020 18:51:47 +0200
Message-Id: <20201005165147.526426-7-clg@kaod.org>
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
 suspectscore=0 bulkscore=0
 adultscore=0 malwarescore=0 priorityscore=1501 phishscore=0
 mlxlogscore=740 impostorscore=0 lowpriorityscore=0 spamscore=0
 clxscore=1034 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2010050117
Received-SPF: softfail client-ip=148.163.158.5; envelope-from=clg@kaod.org;
 helo=mx0a-001b2d01.pphosted.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/05 12:52:05
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

When the StoreEOI capability is set to "cas", let CAS decide when
StoreEOI should be advertised. StoreEOI is safe to use with a P10
compat machine because the OS enforces load-after-store ordering but
not with P9 compat.

The question now is : should we make "cas" the default at the machine
level ?

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 include/hw/ppc/spapr.h      |  1 +
 include/hw/ppc/spapr_xive.h |  1 +
 hw/intc/spapr_xive.c        |  9 +++++++++
 hw/ppc/spapr_caps.c         | 21 +++++++++++++++++----
 hw/ppc/spapr_hcall.c        |  7 +++++++
 5 files changed, 35 insertions(+), 4 deletions(-)

diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
index b701c14b4e09..17e7d873e8dc 100644
--- a/include/hw/ppc/spapr.h
+++ b/include/hw/ppc/spapr.h
@@ -87,6 +87,7 @@ typedef enum {
 #define SPAPR_CAP_ON                    0x01
=20
 /* Custom Caps */
+#define SPAPR_CAP_CAS                   0x02
=20
 /* Generic */
 #define SPAPR_CAP_BROKEN                0x00
diff --git a/include/hw/ppc/spapr_xive.h b/include/hw/ppc/spapr_xive.h
index 26c8d90d7196..8b8aa586e44f 100644
--- a/include/hw/ppc/spapr_xive.h
+++ b/include/hw/ppc/spapr_xive.h
@@ -75,6 +75,7 @@ void spapr_xive_map_mmio(SpaprXive *xive);
=20
 int spapr_xive_end_to_target(uint8_t end_blk, uint32_t end_idx,
                              uint32_t *out_server, uint8_t *out_prio);
+void spapr_xive_enable_store_eoi(SpaprXive *xive, bool enable);
=20
 /*
  * KVM XIVE device helpers
diff --git a/hw/intc/spapr_xive.c b/hw/intc/spapr_xive.c
index 41f2719ff93a..f57a2681dd91 100644
--- a/hw/intc/spapr_xive.c
+++ b/hw/intc/spapr_xive.c
@@ -1802,3 +1802,12 @@ void spapr_xive_hcall_init(SpaprMachineState *spap=
r)
     spapr_register_hypercall(H_INT_SYNC, h_int_sync);
     spapr_register_hypercall(H_INT_RESET, h_int_reset);
 }
+
+void spapr_xive_enable_store_eoi(SpaprXive *xive, bool enable)
+{
+    if (enable) {
+        xive->source.esb_flags |=3D XIVE_SRC_STORE_EOI;
+    } else {
+        xive->source.esb_flags &=3D ~XIVE_SRC_STORE_EOI;
+    }
+}
diff --git a/hw/ppc/spapr_caps.c b/hw/ppc/spapr_caps.c
index 9251badbdc27..c55e1fccb9bc 100644
--- a/hw/ppc/spapr_caps.c
+++ b/hw/ppc/spapr_caps.c
@@ -524,6 +524,13 @@ static void cap_fwnmi_apply(SpaprMachineState *spapr=
, uint8_t val,
     }
 }
=20
+SpaprCapPossible cap_storeeoi_possible =3D {
+    .num =3D 3,
+    .vals =3D { "off", "on", "cas" },
+    .help =3D "off - no StoreEOI, on - StoreEOI, "
+            "cas - negotiated at CAS (POWER10 compat only)",
+};
+
 static void cap_storeeoi_apply(SpaprMachineState *spapr, uint8_t val,
                                Error **errp)
 {
@@ -550,6 +557,11 @@ static void cap_storeeoi_apply(SpaprMachineState *sp=
apr, uint8_t val,
             return;
         }
=20
+        /* CAS will decide to advertise StoreEOI (P10 compat kernels onl=
y) */
+        if (val =3D=3D SPAPR_CAP_CAS) {
+            return;
+        }
+
         /*
          * load-after-store ordering is not enforced on POWER9 CPUs
          * and StoreEOI can be racy.
@@ -671,11 +683,12 @@ SpaprCapabilityInfo capability_table[SPAPR_CAP_NUM]=
 =3D {
     },
     [SPAPR_CAP_STOREEOI] =3D {
         .name =3D "storeeoi",
-        .description =3D "Implements XIVE StoreEOI feature",
+        .description =3D "Implements XIVE StoreEOI feature (off, on, cas=
)",
         .index =3D SPAPR_CAP_STOREEOI,
-        .get =3D spapr_cap_get_bool,
-        .set =3D spapr_cap_set_bool,
-        .type =3D "bool",
+        .get =3D spapr_cap_get_string,
+        .set =3D spapr_cap_set_string,
+        .type =3D "string",
+        .possible =3D &cap_storeeoi_possible,
         .apply =3D cap_storeeoi_apply,
     },
 };
diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
index 607740150fa2..158b122b9192 100644
--- a/hw/ppc/spapr_hcall.c
+++ b/hw/ppc/spapr_hcall.c
@@ -1804,6 +1804,13 @@ target_ulong do_client_architecture_support(PowerP=
CCPU *cpu,
 "Guest requested unavailable interrupt mode (XIVE), try the ic-mode=3Dxi=
ve or ic-mode=3Ddual machine property");
             exit(EXIT_FAILURE);
         }
+
+        /* Advertise StoreEOI for a P10 compat guest. */
+        if (spapr_get_cap(spapr, SPAPR_CAP_STOREEOI) =3D=3D SPAPR_CAP_CA=
S) {
+            bool enable =3D ppc_check_compat(cpu, CPU_POWERPC_LOGICAL_3_=
10, 0,
+                                           cpu->compat_pvr);
+            spapr_xive_enable_store_eoi(spapr->xive, enable);
+        }
     } else {
         if (!spapr->irq->xics) {
             error_report(
--=20
2.25.4



Return-Path: <SRS0=9X/F=UF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5659C04AB5
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2019 17:10:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AEBFA20652
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2019 17:10:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AEBFA20652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:35441 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hYvtq-00078m-RX
	for qemu-devel@archiver.kernel.org; Thu, 06 Jun 2019 13:10:02 -0400
Received: from eggs.gnu.org ([209.51.188.92]:36153)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1hYvsz-0006m0-DS
	for qemu-devel@nongnu.org; Thu, 06 Jun 2019 13:09:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1hYvsx-00018F-Ga
	for qemu-devel@nongnu.org; Thu, 06 Jun 2019 13:09:09 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:50068
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1hYvsx-00014G-6w
	for qemu-devel@nongnu.org; Thu, 06 Jun 2019 13:09:07 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x56H2RkE034707
	for <qemu-devel@nongnu.org>; Thu, 6 Jun 2019 13:09:05 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2sy6q40r1t-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 06 Jun 2019 13:09:05 -0400
Received: from localhost
	by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <groug@kaod.org>;
	Thu, 6 Jun 2019 18:09:03 +0100
Received: from b06avi18878370.portsmouth.uk.ibm.com (9.149.26.194)
	by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway:
	Authorized Use Only! Violators will be prosecuted; 
	(version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
	Thu, 6 Jun 2019 18:09:00 +0100
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com
	[9.149.105.232])
	by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with
	ESMTP id x56H8xrl30146860
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256
	verify=OK); Thu, 6 Jun 2019 17:08:59 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 74DFA52052;
	Thu,  6 Jun 2019 17:08:59 +0000 (GMT)
Received: from bahia.lan (unknown [9.145.50.113])
	by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 3F43E52051;
	Thu,  6 Jun 2019 17:08:59 +0000 (GMT)
From: Greg Kurz <groug@kaod.org>
To: David Gibson <david@gibson.dropbear.id.au>
Date: Thu, 06 Jun 2019 19:08:59 +0200
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19060617-0016-0000-0000-0000028692A5
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19060617-0017-0000-0000-000032E3AFD4
Message-Id: <155984093894.2803172.8618224129384655510.stgit@bahia.lan>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
	definitions=2019-06-06_12:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
	priorityscore=1501
	malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
	clxscore=1034 lowpriorityscore=0 mlxscore=0 impostorscore=0
	mlxlogscore=810 adultscore=0 classifier=spam adjust=0 reason=mlx
	scancount=1 engine=8.0.1-1810050000 definitions=main-1906060115
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 148.163.158.5
Subject: [Qemu-devel] [PATCH] spapr: Don't use the "dual" interrupt
 controller mode with an old hypervisor
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org,
	=?utf-8?q?C=C3=A9dric?= Le Goater <clg@kaod.org>,
	Greg Kurz <groug@kaod.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

If KVM is too old to support XIVE native exploitation mode, we might end
up using the emulated XIVE after CAS. This is sub-optimal if KVM in-kernel
XICS is available, which is the case most of the time.

Also, an old KVM may not allow to destroy and re-create the KVM XICS, which
is precisely what "dual" does during machine reset. This causes QEMU to try
to switch to emulated XICS and to crash because RTAS call de-registration
isn't handled correctly. We could possibly fix that, but again we would
still end up with an emulated XICS or XIVE.

"dual" is definitely not a good choice with older KVMs. Internally force
XICS when we detect this.

Signed-off-by: Greg Kurz <groug@kaod.org>
---
 hw/ppc/spapr_irq.c |   10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/hw/ppc/spapr_irq.c b/hw/ppc/spapr_irq.c
index 3156daf09381..d788bd662a7a 100644
--- a/hw/ppc/spapr_irq.c
+++ b/hw/ppc/spapr_irq.c
@@ -18,6 +18,7 @@
 #include "hw/ppc/xics_spapr.h"
 #include "cpu-models.h"
 #include "sysemu/kvm.h"
+#include "kvm_ppc.h"
 
 #include "trace.h"
 
@@ -668,6 +669,15 @@ static void spapr_irq_check(SpaprMachineState *spapr, Error **errp)
             return;
         }
     }
+
+    /*
+     * KVM may be too old to support XIVE, in which case we'd rather try
+     * to use the in-kernel XICS instead of the emulated XIVE.
+     */
+    if (kvm_enabled() && !kvmppc_has_cap_xive() &&
+        spapr->irq == &spapr_irq_dual) {
+        spapr->irq = &spapr_irq_xics;
+    }
 }
 
 /*



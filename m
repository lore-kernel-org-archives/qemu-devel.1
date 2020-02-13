Return-Path: <SRS0=ry7b=4B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17D14C3B18C
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 15:57:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E5EF22073C
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 15:57:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E5EF22073C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55076 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2GrR-00013S-30
	for qemu-devel@archiver.kernel.org; Thu, 13 Feb 2020 10:57:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48893)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groug@kaod.org>) id 1j2Gqj-0000PB-0X
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 10:56:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groug@kaod.org>) id 1j2Gqh-00087B-Vd
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 10:56:20 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:38128)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <groug@kaod.org>) id 1j2Gqh-00084o-OJ
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 10:56:19 -0500
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 01DFnjtM036939
 for <qemu-devel@nongnu.org>; Thu, 13 Feb 2020 10:56:18 -0500
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2y57dcwqgn-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 13 Feb 2020 10:56:17 -0500
Received: from localhost
 by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <groug@kaod.org>;
 Thu, 13 Feb 2020 15:56:15 -0000
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
 by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Thu, 13 Feb 2020 15:56:13 -0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
 by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 01DFuCwN60817548
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 13 Feb 2020 15:56:13 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id DB9C442041;
 Thu, 13 Feb 2020 15:56:12 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A3BD542047;
 Thu, 13 Feb 2020 15:56:12 +0000 (GMT)
Received: from bahia.lan (unknown [9.145.71.236])
 by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Thu, 13 Feb 2020 15:56:12 +0000 (GMT)
Subject: [PATCH] spapr: Make spapr_reallocate_hpt() static
From: Greg Kurz <groug@kaod.org>
To: David Gibson <david@gibson.dropbear.id.au>
Date: Thu, 13 Feb 2020 16:56:12 +0100
In-Reply-To: <158160831807.3339719.7059822505220975954.stgit@bahia.lan>
References: <158160831807.3339719.7059822505220975954.stgit@bahia.lan>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 20021315-0020-0000-0000-000003A9D55B
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20021315-0021-0000-0000-00002201C0C8
Message-Id: <158160937188.3342532.13820767351504991288.stgit@bahia.lan>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138, 18.0.572
 definitions=2020-02-13_05:2020-02-12,
 2020-02-13 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 bulkscore=0
 suspectscore=2 phishscore=0 impostorscore=0 priorityscore=1501
 clxscore=1034 malwarescore=0 spamscore=0 mlxscore=0 lowpriorityscore=0
 mlxlogscore=742 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002130121
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
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, Laurent Vivier <lvivier@redhat.com>,
 qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Its only users are in spapr.c.

Signed-off-by: Greg Kurz <groug@kaod.org>
---

I realized just after posting that spapr_reallocate_hpt() didn't need to
be extern anymore. Maybe worth squashing this into the "spapr: Rework
hash<->radix transitions at CAS" patch ?
---
 hw/ppc/spapr.c         |    4 ++--
 include/hw/ppc/spapr.h |    2 --
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 88bc0e4e3ca1..1537866533cb 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -1519,8 +1519,8 @@ void spapr_free_hpt(SpaprMachineState *spapr)
     close_htab_fd(spapr);
 }
 
-void spapr_reallocate_hpt(SpaprMachineState *spapr, int shift,
-                          Error **errp)
+static void spapr_reallocate_hpt(SpaprMachineState *spapr, int shift,
+                                 Error **errp)
 {
     long rc;
 
diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
index 9d88b5596481..0be8abc70744 100644
--- a/include/hw/ppc/spapr.h
+++ b/include/hw/ppc/spapr.h
@@ -821,8 +821,6 @@ void spapr_hotplug_req_add_by_count_indexed(SpaprDrcType drc_type,
 void spapr_hotplug_req_remove_by_count_indexed(SpaprDrcType drc_type,
                                                uint32_t count, uint32_t index);
 int spapr_hpt_shift_for_ramsize(uint64_t ramsize);
-void spapr_reallocate_hpt(SpaprMachineState *spapr, int shift,
-                          Error **errp);
 void spapr_clear_pending_events(SpaprMachineState *spapr);
 int spapr_max_server_number(SpaprMachineState *spapr);
 void spapr_store_hpte(PowerPCCPU *cpu, hwaddr ptex,



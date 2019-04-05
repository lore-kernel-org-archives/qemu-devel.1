Return-Path: <SRS0=1I+v=SH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E5CEC282CE
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Apr 2019 16:35:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D322A21738
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Apr 2019 16:35:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D322A21738
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:44472 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hCRoE-000635-0b
	for qemu-devel@archiver.kernel.org; Fri, 05 Apr 2019 12:35:18 -0400
Received: from eggs.gnu.org ([209.51.188.92]:51267)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1hCRkV-0003zZ-HV
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 12:31:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1hCRkU-0000P3-8B
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 12:31:27 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:50190)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1hCRkN-0008Ol-Uu
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 12:31:23 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x35GTAoC115703
	for <qemu-devel@nongnu.org>; Fri, 5 Apr 2019 12:30:50 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2rpacwgkpp-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 05 Apr 2019 12:30:49 -0400
Received: from localhost
	by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <groug@kaod.org>;
	Fri, 5 Apr 2019 17:30:47 +0100
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
	by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway:
	Authorized Use Only! Violators will be prosecuted; 
	(version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
	Fri, 5 Apr 2019 17:30:44 +0100
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com
	[9.149.105.232])
	by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with
	ESMTP id x35GUhsT53674106
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256
	verify=OK); Fri, 5 Apr 2019 16:30:43 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5BDDE52054;
	Fri,  5 Apr 2019 16:30:43 +0000 (GMT)
Received: from bahia.lan (unknown [9.145.33.11])
	by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 3F11A52050;
	Fri,  5 Apr 2019 16:30:43 +0000 (GMT)
From: Greg Kurz <groug@kaod.org>
To: qemu-devel@nongnu.org
Date: Fri, 05 Apr 2019 18:30:43 +0200
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19040516-4275-0000-0000-00000324B805
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19040516-4276-0000-0000-00003833C8ED
Message-Id: <155448184292.8446.8225650773162648595.stgit@bahia.lan>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
	definitions=2019-04-05_12:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
	priorityscore=1501
	malwarescore=0 suspectscore=3 phishscore=0 bulkscore=0 spamscore=0
	clxscore=1034 lowpriorityscore=0 mlxscore=0 impostorscore=0
	mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
	scancount=1 engine=8.0.1-1810050000 definitions=main-1904050112
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 148.163.156.1
Subject: [Qemu-devel] [PATCH for-4.1 1/2] spapr_pci: Get rid of duplicate
 code for node name creation
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
Cc: qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190405163043.Lxvd1tbBdGPLbHVn5VT1PcL62LnBRFB8WaOiMz9gOTc@z>

According to the changelog of 298a971024534, SpaprPhbState::dtbusname was
introduced to "make it easier to relate the guest and qemu views of memory
to each other", hence its name.

Use it when creating the PHB node to avoid code duplication.

Signed-off-by: Greg Kurz <groug@kaod.org>
---
 hw/ppc/spapr_pci.c |    5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
index bba3a86dda6c..c70688a0dc23 100644
--- a/hw/ppc/spapr_pci.c
+++ b/hw/ppc/spapr_pci.c
@@ -2153,7 +2153,6 @@ int spapr_populate_pci_dt(SpaprPhbState *phb, uint32_t intc_phandle, void *fdt,
                           uint32_t nr_msis, int *node_offset)
 {
     int bus_off, i, j, ret;
-    gchar *nodename;
     uint32_t bus_range[] = { cpu_to_be32(0), cpu_to_be32(0xff) };
     struct {
         uint32_t hi;
@@ -2204,9 +2203,7 @@ int spapr_populate_pci_dt(SpaprPhbState *phb, uint32_t intc_phandle, void *fdt,
     Error *errp = NULL;
 
     /* Start populating the FDT */
-    nodename = g_strdup_printf("pci@%" PRIx64, phb->buid);
-    _FDT(bus_off = fdt_add_subnode(fdt, 0, nodename));
-    g_free(nodename);
+    _FDT(bus_off = fdt_add_subnode(fdt, 0, phb->dtbusname));
     if (node_offset) {
         *node_offset = bus_off;
     }



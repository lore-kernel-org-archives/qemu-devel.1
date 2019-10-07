Return-Path: <SRS0=TwS2=YA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80F0AECE58C
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Oct 2019 13:44:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5677C206BB
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Oct 2019 13:44:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5677C206BB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44976 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iHTJq-00056z-0f
	for qemu-devel@archiver.kernel.org; Mon, 07 Oct 2019 09:44:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32875)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groug@kaod.org>) id 1iHTIB-0003bD-FJ
 for qemu-devel@nongnu.org; Mon, 07 Oct 2019 09:43:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groug@kaod.org>) id 1iHTI9-00029a-EJ
 for qemu-devel@nongnu.org; Mon, 07 Oct 2019 09:43:14 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:28944
 helo=mx0a-001b2d01.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <groug@kaod.org>) id 1iHTI9-00029I-9W
 for qemu-devel@nongnu.org; Mon, 07 Oct 2019 09:43:13 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x97DcgTP008953
 for <qemu-devel@nongnu.org>; Mon, 7 Oct 2019 09:43:09 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2vg52j3h4x-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 07 Oct 2019 09:43:09 -0400
Received: from localhost
 by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <groug@kaod.org>;
 Mon, 7 Oct 2019 14:43:08 +0100
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
 by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Mon, 7 Oct 2019 14:43:05 +0100
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com
 [9.149.105.61])
 by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x97Dh4aq39518228
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 7 Oct 2019 13:43:04 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 980CD11C04A;
 Mon,  7 Oct 2019 13:43:04 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5E89111C04C;
 Mon,  7 Oct 2019 13:43:04 +0000 (GMT)
Received: from bahia.lan (unknown [9.145.67.254])
 by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Mon,  7 Oct 2019 13:43:04 +0000 (GMT)
Subject: [PATCH 1/2] xive: Add /* Reason */ comment to "->user_creatable =
 false" statements
From: Greg Kurz <groug@kaod.org>
To: David Gibson <david@gibson.dropbear.id.au>
Date: Mon, 07 Oct 2019 15:43:04 +0200
In-Reply-To: <157045577839.865784.6865959617322519030.stgit@bahia.lan>
References: <157045577839.865784.6865959617322519030.stgit@bahia.lan>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19100713-0016-0000-0000-000002B4D8A4
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19100713-0017-0000-0000-00003315F052
Message-Id: <157045578401.865784.6058183726552779559.stgit@bahia.lan>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-10-07_02:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1034 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1910070135
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic] [fuzzy]
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
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org,
 =?utf-8?q?C=C3=A9dric?= Le Goater <clg@kaod.org>,
 Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Greg Kurz <groug@kaod.org>
---
 hw/intc/xive.c |   12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/hw/intc/xive.c b/hw/intc/xive.c
index 6c54a35fd4bb..453d389848f8 100644
--- a/hw/intc/xive.c
+++ b/hw/intc/xive.c
@@ -670,6 +670,10 @@ static void xive_tctx_class_init(ObjectClass *klass, void *data)
     dc->realize = xive_tctx_realize;
     dc->unrealize = xive_tctx_unrealize;
     dc->vmsd = &vmstate_xive_tctx;
+    /*
+     * Reason: part of XIVE interrupt controller, needs to be wired up
+     * by xive_tctx_create().
+     */
     dc->user_creatable = false;
 }
 
@@ -1119,6 +1123,10 @@ static void xive_source_class_init(ObjectClass *klass, void *data)
     dc->props   = xive_source_properties;
     dc->realize = xive_source_realize;
     dc->vmsd    = &vmstate_xive_source;
+    /*
+     * Reason: part of XIVE interrupt controller, needs to be wired up,
+     * e.g. by spapr_xive_instance_init().
+     */
     dc->user_creatable = false;
 }
 
@@ -1855,6 +1863,10 @@ static void xive_end_source_class_init(ObjectClass *klass, void *data)
     dc->desc    = "XIVE END Source";
     dc->props   = xive_end_source_properties;
     dc->realize = xive_end_source_realize;
+    /*
+     * Reason: part of XIVE interrupt controller, needs to be wired up,
+     * e.g. by spapr_xive_instance_init().
+     */
     dc->user_creatable = false;
 }
 



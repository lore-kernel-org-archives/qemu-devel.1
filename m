Return-Path: <SRS0=zTTU=TP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32743C04E53
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2019 17:05:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E96B220862
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2019 17:05:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E96B220862
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:40016 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hQxLl-0001gw-2B
	for qemu-devel@archiver.kernel.org; Wed, 15 May 2019 13:05:53 -0400
Received: from eggs.gnu.org ([209.51.188.92]:38364)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1hQxKl-0001Fi-AN
	for qemu-devel@nongnu.org; Wed, 15 May 2019 13:04:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1hQxKk-0000tE-0Q
	for qemu-devel@nongnu.org; Wed, 15 May 2019 13:04:51 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:35636
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1hQxKj-0000mA-Qn
	for qemu-devel@nongnu.org; Wed, 15 May 2019 13:04:49 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x4FH3gU0036235
	for <qemu-devel@nongnu.org>; Wed, 15 May 2019 13:04:40 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2sgmm7qn0q-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 15 May 2019 13:04:35 -0400
Received: from localhost
	by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <groug@kaod.org>;
	Wed, 15 May 2019 18:04:28 +0100
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
	by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway:
	Authorized Use Only! Violators will be prosecuted; 
	(version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
	Wed, 15 May 2019 18:04:26 +0100
Received: from b06wcsmtp001.portsmouth.uk.ibm.com
	(b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
	by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with
	ESMTP id x4FH4P7k59703326
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256
	verify=OK); Wed, 15 May 2019 17:04:25 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1E35EA4054;
	Wed, 15 May 2019 17:04:25 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D5929A405C;
	Wed, 15 May 2019 17:04:24 +0000 (GMT)
Received: from bahia.lan (unknown [9.145.156.103])
	by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
	Wed, 15 May 2019 17:04:24 +0000 (GMT)
From: Greg Kurz <groug@kaod.org>
To: David Gibson <david@gibson.dropbear.id.au>,
	=?utf-8?q?C=C3=A9dric?= Le Goater <clg@kaod.org>,
	Greg Kurz <groug@kaod.org>
Date: Wed, 15 May 2019 19:04:24 +0200
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19051517-4275-0000-0000-00000335241A
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19051517-4276-0000-0000-00003844A90D
Message-Id: <155793986451.464434.12887933000007255549.stgit@bahia.lan>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
	definitions=2019-05-15_11:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
	priorityscore=1501
	malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
	clxscore=1034 lowpriorityscore=0 mlxscore=0 impostorscore=0
	mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
	scancount=1 engine=8.0.1-1810050000 definitions=main-1905150103
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 148.163.158.5
Subject: [Qemu-devel] [PATCH] spapr/xive: Sanity checks of OV5 during CAS
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
Cc: Satheesh Rajendran <sathnaga@linux.vnet.ibm.com>, qemu-ppc@nongnu.org,
	qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

If a machine is started with ic-mode=xive but the guest only knows
about XICS, eg. an RHEL 7.6 guest, the kernel panics. This is
expected but a bit unfortunate since the crash doesn't provide
much information for the end user to guess what's happening.

Detect that during CAS and exit QEMU with a proper error message
instead, like it is already done for the MMU.

Even if this is less likely to happen, the opposite case of a guest
that only knows about XIVE would certainly fail all the same if the
machine is started with ic-mode=xics.

Also, the only valid values a guest can pass in byte 23 of OV5 during
CAS are 0b00 (XIVE legacy mode) and 0b01 (XIVE exploitation mode). Any
other value is a bug, at least with the current spec. Again, it does
not seem right to let the guest go on without a precise idea of the
interrupt mode it asked for.

Handle these cases as well.

Reported-by: Satheesh Rajendran <sathnaga@linux.vnet.ibm.com>
Signed-off-by: Greg Kurz <groug@kaod.org>
---
 hw/ppc/spapr_hcall.c |   24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
index 6c16d2b12040..63a55614b83d 100644
--- a/hw/ppc/spapr_hcall.c
+++ b/hw/ppc/spapr_hcall.c
@@ -1513,6 +1513,7 @@ static target_ulong h_client_architecture_support(PowerPCCPU *cpu,
     bool guest_radix;
     Error *local_err = NULL;
     bool raw_mode_supported = false;
+    bool guest_xive;
 
     cas_pvr = cas_check_pvr(spapr, cpu, &addr, &raw_mode_supported, &local_err);
     if (local_err) {
@@ -1545,10 +1546,17 @@ static target_ulong h_client_architecture_support(PowerPCCPU *cpu,
         error_report("guest requested hash and radix MMU, which is invalid.");
         exit(EXIT_FAILURE);
     }
+    if (spapr_ovec_test(ov5_guest, OV5_XIVE_BOTH)) {
+        error_report("guest requested an invalid interrupt mode");
+        exit(EXIT_FAILURE);
+    }
+
     /* The radix/hash bit in byte 24 requires special handling: */
     guest_radix = spapr_ovec_test(ov5_guest, OV5_MMU_RADIX_300);
     spapr_ovec_clear(ov5_guest, OV5_MMU_RADIX_300);
 
+    guest_xive = spapr_ovec_test(ov5_guest, OV5_XIVE_EXPLOIT);
+
     /*
      * HPT resizing is a bit of a special case, because when enabled
      * we assume an HPT guest will support it until it says it
@@ -1632,6 +1640,22 @@ static target_ulong h_client_architecture_support(PowerPCCPU *cpu,
                                           ov5_updates) != 0);
     }
 
+    /*
+     * Ensure the guest asks for an interrupt mode we support; otherwise
+     * terminate the boot.
+     */
+    if (guest_xive) {
+        if (spapr->irq->ov5 == SPAPR_OV5_XIVE_LEGACY) {
+            error_report("Guest requested unavailable interrupt mode (XIVE)");
+            exit(EXIT_FAILURE);
+        }
+    } else {
+        if (spapr->irq->ov5 == SPAPR_OV5_XIVE_EXPLOIT) {
+            error_report("Guest requested unavailable interrupt mode (XICS)");
+            exit(EXIT_FAILURE);
+        }
+    }
+
     /*
      * Generate a machine reset when we have an update of the
      * interrupt mode. Only required when the machine supports both



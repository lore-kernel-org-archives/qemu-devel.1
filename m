Return-Path: <SRS0=mdN/=VA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A439C0650E
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2019 17:23:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0C55721882
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2019 17:23:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C55721882
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37938 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hiiyl-00030V-3t
	for qemu-devel@archiver.kernel.org; Wed, 03 Jul 2019 13:23:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47524)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <groug@kaod.org>) id 1hiixr-00026w-7C
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 13:22:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groug@kaod.org>) id 1hiixq-00034U-1w
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 13:22:39 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:45796)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <groug@kaod.org>) id 1hiixp-0002zQ-O6
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 13:22:38 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x63HMOne093699
 for <qemu-devel@nongnu.org>; Wed, 3 Jul 2019 13:22:28 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2tgyg4auta-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 03 Jul 2019 13:22:26 -0400
Received: from localhost
 by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <groug@kaod.org>;
 Wed, 3 Jul 2019 18:22:24 +0100
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
 by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Wed, 3 Jul 2019 18:22:22 +0100
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com
 [9.149.105.232])
 by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x63HML5845875388
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 3 Jul 2019 17:22:21 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 54D8B52052;
 Wed,  3 Jul 2019 17:22:21 +0000 (GMT)
Received: from bahia.lan (unknown [9.145.70.88])
 by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 266AD5204E;
 Wed,  3 Jul 2019 17:22:21 +0000 (GMT)
From: Greg Kurz <groug@kaod.org>
To: David Gibson <david@gibson.dropbear.id.au>,
 =?utf-8?q?C=C3=A9dric?= Le Goater <clg@kaod.org>
Date: Wed, 03 Jul 2019 19:22:20 +0200
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19070317-0028-0000-0000-000003800E01
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19070317-0029-0000-0000-000024404DE2
Message-Id: <156217454083.559957.7359208229523652842.stgit@bahia.lan>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-07-03_04:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1034 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1907030211
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 148.163.156.1
Subject: [Qemu-devel] [PATCH for-4.1] xics/kvm: Always set the MASKED bit if
 interrupt is masked
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

The ics_set_kvm_state_one() function is called either to restore the
state of an interrupt source during migration or to set the interrupt
source to a default state during reset.

Since always, ie. 2013, the code only sets the MASKED bit if the 'current
priority' and the 'saved priority' are different. This is likely true
when restoring an interrupt that had been previously masked with the
ibm,int-off RTAS call. However this is always false in the case of
reset since both 'current priority' and 'saved priority' are equal to
0xff, and the MASKED bit is never set.

The legacy KVM XICS device gets away with that because it ends updating
its internal structure the same way, whether the MASKED bit is set or
the priority is 0xff.

The XICS-on-XIVE device for POWER9 is different. It sticks to the KVM
documentation [1] and _really_ relies on the MASKED bit to correctly
set. If not, it will configure the interrupt source in the XIVE HW, even
though the guest hasn't configured the interrupt yet. This disturbs the
complex logic implemented in XICS-on-XIVE and may result in the loss of
subsequent queued events.

Always set the MASKED bit if interrupt is masked as expected by the KVM
XICS-on-XIVE device. This has no impact on the legacy KVM XICS.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/virtual/kvm/devices/xics.txt

Signed-off-by: Greg Kurz <groug@kaod.org>
---
 hw/intc/xics_kvm.c |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/hw/intc/xics_kvm.c b/hw/intc/xics_kvm.c
index 51433b19b076..2df1f3e92c7e 100644
--- a/hw/intc/xics_kvm.c
+++ b/hw/intc/xics_kvm.c
@@ -257,6 +257,9 @@ int ics_set_kvm_state_one(ICSState *ics, int srcno, Error **errp)
         << KVM_XICS_PRIORITY_SHIFT;
     if (irq->priority != irq->saved_priority) {
         assert(irq->priority == 0xff);
+    }
+
+    if (irq->priority == 0xff) {
         state |= KVM_XICS_MASKED;
     }
 



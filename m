Return-Path: <SRS0=A34B=UQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E85F4C31E50
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 13:53:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BFDE02080C
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 13:53:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BFDE02080C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47670 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hcs4m-0001A3-SR
	for qemu-devel@archiver.kernel.org; Mon, 17 Jun 2019 09:53:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32825)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <groug@kaod.org>) id 1hcry3-0004Ap-LP
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 09:46:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groug@kaod.org>) id 1hcry2-0000SL-FU
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 09:46:39 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:33142
 helo=mx0a-001b2d01.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <groug@kaod.org>) id 1hcry2-0000Ra-9b
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 09:46:38 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x5HDbaKL069241
 for <qemu-devel@nongnu.org>; Mon, 17 Jun 2019 09:46:37 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2t69spx8mc-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 17 Jun 2019 09:46:37 -0400
Received: from localhost
 by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <groug@kaod.org>;
 Mon, 17 Jun 2019 14:46:34 +0100
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
 by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Mon, 17 Jun 2019 14:46:31 +0100
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com
 [9.149.105.62])
 by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x5HDkU1843712748
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 17 Jun 2019 13:46:30 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 71BE5AE055;
 Mon, 17 Jun 2019 13:46:30 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 42DF1AE051;
 Mon, 17 Jun 2019 13:46:30 +0000 (GMT)
Received: from bahia.lan (unknown [9.145.14.35])
 by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Mon, 17 Jun 2019 13:46:30 +0000 (GMT)
From: Greg Kurz <groug@kaod.org>
To: David Gibson <david@gibson.dropbear.id.au>
Date: Mon, 17 Jun 2019 15:46:30 +0200
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19061713-0016-0000-0000-00000289D1D3
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19061713-0017-0000-0000-000032E71BB5
Message-Id: <156077918969.433243.1416211899441569578.stgit@bahia.lan>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-06-17_06:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1034 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=494 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1906170126
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 148.163.158.5
Subject: [Qemu-devel] [PATCH 0/6] xics/kvm: Improve error handling
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
Cc: qemu-ppc@nongnu.org, =?utf-8?q?C=C3=A9dric?= Le Goater <clg@kaod.org>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

In case XICS KVM setup fails, depending on the in-kernel irqchip being
required or not, QEMU used to exit or fall back to emulated XICS, and
never try to setup XICS KVM again for the machine lifetime.

This is no longer the case with the "dual" interrupt controller mode of
the spapr machine: QEMU will try again to setup KVM XICS each time the
VM is reset. This calls for proper rollback on the XICS KVM setup error
path.

That's what that series does. The first patches are preparatory cleanup.

--
Greg

---

Greg Kurz (6):
      xics/spapr: Drop unused function declaration
      xics/spapr: Rename xics_kvm_init()
      xics/kvm: Skip rollback when KVM XICS is absent
      xics/kvm: Always use local_err in xics_kvm_init()
      xics/kvm: Add error propagation to ic*_set_kvm_state() functions
      xics/kvm: Add proper rollback to xics_kvm_init()


 hw/intc/xics.c              |   39 ++++++++++++++++++++++---
 hw/intc/xics_kvm.c          |   68 +++++++++++++++++++++++++------------------
 hw/ppc/spapr_irq.c          |    2 +
 include/hw/ppc/xics.h       |    6 ++--
 include/hw/ppc/xics_spapr.h |    3 +-
 5 files changed, 78 insertions(+), 40 deletions(-)



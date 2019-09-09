Return-Path: <SRS0=McoT=XE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D126C00307
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Sep 2019 07:27:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1BE6521D82
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Sep 2019 07:27:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1BE6521D82
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52550 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i7E5T-0007cV-BG
	for qemu-devel@archiver.kernel.org; Mon, 09 Sep 2019 03:27:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40170)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aravinda@linux.vnet.ibm.com>) id 1i7E2N-0005lR-It
 for qemu-devel@nongnu.org; Mon, 09 Sep 2019 03:24:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aravinda@linux.vnet.ibm.com>) id 1i7E2M-0007RU-IA
 for qemu-devel@nongnu.org; Mon, 09 Sep 2019 03:24:35 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:32368
 helo=mx0a-001b2d01.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <aravinda@linux.vnet.ibm.com>)
 id 1i7E2K-0007LR-7v; Mon, 09 Sep 2019 03:24:32 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x897M8Pd155388; Mon, 9 Sep 2019 03:24:15 -0400
Received: from ppma02dal.us.ibm.com (a.bd.3ea9.ip4.static.sl-reverse.com
 [169.62.189.10])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2uwfc9xqe1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 09 Sep 2019 03:24:15 -0400
Received: from pps.filterd (ppma02dal.us.ibm.com [127.0.0.1])
 by ppma02dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id x897JdlO028418;
 Mon, 9 Sep 2019 07:24:14 GMT
Received: from b03cxnp07029.gho.boulder.ibm.com
 (b03cxnp07029.gho.boulder.ibm.com [9.17.130.16])
 by ppma02dal.us.ibm.com with ESMTP id 2uv466vhsg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 09 Sep 2019 07:24:14 +0000
Received: from b03ledav003.gho.boulder.ibm.com
 (b03ledav003.gho.boulder.ibm.com [9.17.130.234])
 by b03cxnp07029.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x897OD6140501686
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 9 Sep 2019 07:24:13 GMT
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7C6BC6A057;
 Mon,  9 Sep 2019 07:24:13 +0000 (GMT)
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4E6B66A04D;
 Mon,  9 Sep 2019 07:24:11 +0000 (GMT)
Received: from [127.0.1.1] (unknown [9.124.31.235])
 by b03ledav003.gho.boulder.ibm.com (Postfix) with ESMTP;
 Mon,  9 Sep 2019 07:24:10 +0000 (GMT)
From: Aravinda Prasad <aravinda@linux.vnet.ibm.com>
To: aik@ozlabs.ru, qemu-ppc@nongnu.org, qemu-devel@nongnu.org,
 david@gibson.dropbear.id.au
Date: Mon, 09 Sep 2019 12:54:10 +0530
Message-ID: <156801373576.24362.1904051970114447107.stgit@aravinda>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-09-09_04:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=517 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1909090081
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 148.163.158.5
Subject: [Qemu-devel] [PATCH v13 0/6] target-ppc/spapr: Add FWNMI support in
 QEMU for PowerKVM guests
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
Cc: paulus@ozlabs.org, aravinda@linux.vnet.ibm.com, groug@kaod.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This patch set adds support for FWNMI in PowerKVM guests.

System errors such as SLB multihit and memory errors
that cannot be corrected by hardware is passed on to
the kernel for handling by raising machine check
exception (an NMI). Upon such machine check exceptions,
if the address in error belongs to guest then KVM
invokes guests' 0x200 interrupt vector if the guest
is not FWNMI capable. For FWNMI capable guest
KVM passes the control to QEMU by exiting the guest.

This patch series adds functionality to QEMU to pass
on such machine check exceptions to the FWNMI capable
guest kernel by building an error log and invoking
the guest registered machine check handling routine.

The KVM changes are now part of the upstream kernel
(commit e20bbd3d). This series contain QEMU changes.

Change Log v13:
  - Minor fixes (mostly nits)
  - Moved FWNMI guest registration check from patch 4 to 3.

Change Log v12:
  - Rebased to latest ppc-for-4.2 (SHA b1e8156743)

Change Log v11:
  - Moved FWNMI SPAPR cap defaults to 4.2 class option
  - Fixed issues with handling fwnmi KVM capability

Change Log v10:
  - Reshuffled the patch sequence + minor fixes

Change Log v9:
  - Fixed kvm cap and spapr cap issues

Change Log v8:
  - Added functionality to check FWNMI capability during
    VM migration

---

Aravinda Prasad (6):
      Wrapper function to wait on condition for the main loop mutex
      ppc: spapr: Introduce FWNMI capability
      target/ppc: Handle NMI guest exit
      target/ppc: Build rtas error log upon an MCE
      ppc: spapr: Handle "ibm,nmi-register" and "ibm,nmi-interlock" RTAS calls
      migration: Include migration support for machine check handling


 cpus.c                   |    5 +
 hw/ppc/spapr.c           |   76 +++++++++++++
 hw/ppc/spapr_caps.c      |   29 +++++
 hw/ppc/spapr_events.c    |  271 ++++++++++++++++++++++++++++++++++++++++++++++
 hw/ppc/spapr_rtas.c      |   78 +++++++++++++
 include/hw/ppc/spapr.h   |   25 ++++
 include/qemu/main-loop.h |    8 +
 target/ppc/kvm.c         |   42 +++++++
 target/ppc/kvm_ppc.h     |   14 ++
 target/ppc/trace-events  |    1 
 10 files changed, 547 insertions(+), 2 deletions(-)

--
Aravinda Prasad


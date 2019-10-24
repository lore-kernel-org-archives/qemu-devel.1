Return-Path: <SRS0=Jnn8=YR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A542CA9EAF
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 07:47:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F167F2084C
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 07:47:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F167F2084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34254 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNXq0-0000fa-Jj
	for qemu-devel@archiver.kernel.org; Thu, 24 Oct 2019 03:47:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60919)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <ganeshgr@linux.ibm.com>) id 1iNXms-0006I7-Lh
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 03:44:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ganeshgr@linux.ibm.com>) id 1iNXmq-0007Wz-BL
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 03:44:02 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:58490)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ganeshgr@linux.ibm.com>)
 id 1iNXmm-0007W3-Ol
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 03:43:58 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x9O7grL6085030
 for <qemu-devel@nongnu.org>; Thu, 24 Oct 2019 03:43:53 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2vu533w9pt-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 24 Oct 2019 03:43:52 -0400
Received: from localhost
 by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <ganeshgr@linux.ibm.com>;
 Thu, 24 Oct 2019 08:43:50 +0100
Received: from b06avi18878370.portsmouth.uk.ibm.com (9.149.26.194)
 by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Thu, 24 Oct 2019 08:43:47 +0100
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
 by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP
 id x9O7hkST42336698
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 24 Oct 2019 07:43:46 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3B20142042;
 Thu, 24 Oct 2019 07:43:46 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D7C804203F;
 Thu, 24 Oct 2019 07:43:43 +0000 (GMT)
Received: from localhost.localdomain.com (unknown [9.85.73.55])
 by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Thu, 24 Oct 2019 07:43:43 +0000 (GMT)
From: Ganesh Goudar <ganeshgr@linux.ibm.com>
To: aik@ozlabs.ru, qemu-ppc@nongnu.org, qemu-devel@nongnu.org,
 david@gibson.dropbear.id.au
Subject: [PATCH v17 0/7] target-ppc/spapr: Add FWNMI support in QEMU for
 PowerKM guests
Date: Thu, 24 Oct 2019 13:13:00 +0530
X-Mailer: git-send-email 2.17.2
X-TM-AS-GCONF: 00
x-cbid: 19102407-0008-0000-0000-00000326A3ED
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19102407-0009-0000-0000-00004A45D5FB
Message-Id: <20191024074307.22821-1-ganeshgr@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-10-24_05:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=818 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1910240074
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic] [fuzzy]
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
Cc: paulus@ozlabs.org, Ganesh Goudar <ganeshgr@linux.ibm.com>,
 arawinda.p@gmail.com, groug@kaod.org
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

Change Log v17:
  - Add fwnmi cap to migration state
  - Reprhase the commit message in patch 2/7

Change Log v16:
  - Fixed coding style problems

Change Log v15:
  - Removed cap_ppc_fwnmi
  - Moved fwnmi registeration to .apply hook
  - Assume SLOF has allocated enough room for rtas error log
  - Using ARRAY_SIZE to end the loop
  - Do not set FWNMI cap in post_load, now its done in .apply hook

Change Log v14:
  - Feature activation moved to a separate patch
  - Fixed issues with migration blocker

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

Aravinda Prasad (7):
  Wrapper function to wait on condition for the main loop mutex
  ppc: spapr: Introduce FWNMI capability
  target/ppc: Handle NMI guest exit
  target/ppc: Build rtas error log upon an MCE
  ppc: spapr: Handle "ibm,nmi-register" and "ibm,nmi-interlock" RTAS
    calls
  migration: Include migration support for machine check handling
  ppc: spapr: Activate the FWNMI functionality

 cpus.c                   |   5 +
 hw/ppc/spapr.c           |  52 ++++++++
 hw/ppc/spapr_caps.c      |  34 +++++
 hw/ppc/spapr_events.c    | 269 +++++++++++++++++++++++++++++++++++++++
 hw/ppc/spapr_rtas.c      |  85 +++++++++++++
 include/hw/ppc/spapr.h   |  26 +++-
 include/qemu/main-loop.h |   8 ++
 target/ppc/kvm.c         |  24 ++++
 target/ppc/kvm_ppc.h     |   8 ++
 target/ppc/trace-events  |   1 +
 10 files changed, 510 insertions(+), 2 deletions(-)

-- 
2.17.2



Return-Path: <SRS0=+Hf+=3G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9792AC33CB7
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2020 09:41:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6E8FE2053B
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2020 09:41:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E8FE2053B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54508 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1isO7j-0008CD-97
	for qemu-devel@archiver.kernel.org; Fri, 17 Jan 2020 04:41:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49437)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <ganeshgr@linux.ibm.com>) id 1isO5z-0006mJ-Mb
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 04:39:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ganeshgr@linux.ibm.com>) id 1isO5u-0006r1-Us
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 04:39:14 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:47832
 helo=mx0a-001b2d01.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ganeshgr@linux.ibm.com>)
 id 1isO5u-0006qJ-Q6
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 04:39:10 -0500
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 00H9b8jW098044
 for <qemu-devel@nongnu.org>; Fri, 17 Jan 2020 04:39:10 -0500
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2xk0qspjkx-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 17 Jan 2020 04:39:09 -0500
Received: from localhost
 by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <ganeshgr@linux.ibm.com>;
 Fri, 17 Jan 2020 09:39:08 -0000
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
 by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Fri, 17 Jan 2020 09:39:04 -0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com
 [9.149.105.62])
 by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 00H9d3pO30801978
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 17 Jan 2020 09:39:03 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A5BB6AE045;
 Fri, 17 Jan 2020 09:39:03 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 450A9AE04D;
 Fri, 17 Jan 2020 09:39:02 +0000 (GMT)
Received: from localhost.in.ibm.com (unknown [9.124.35.97])
 by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Fri, 17 Jan 2020 09:39:02 +0000 (GMT)
From: Ganesh Goudar <ganeshgr@linux.ibm.com>
To: aik@ozlabs.ru, qemu-ppc@nongnu.org, qemu-devel@nongnu.org,
 david@gibson.dropbear.id.au
Subject: [PATCH v20 0/7]target-ppc/spapr: Add FWNMI support in QEMU for
 PowerKVM guests
Date: Fri, 17 Jan 2020 15:08:48 +0530
X-Mailer: git-send-email 2.17.2
X-TM-AS-GCONF: 00
x-cbid: 20011709-0012-0000-0000-0000037E33A2
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20011709-0013-0000-0000-000021BA69EA
Message-Id: <20200117093855.19074-1-ganeshgr@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138, 18.0.572
 definitions=2020-01-17_02:2020-01-16,
 2020-01-17 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0
 mlxlogscore=886 impostorscore=0 spamscore=0 phishscore=0 suspectscore=0
 priorityscore=1501 clxscore=1015 adultscore=0 mlxscore=0 bulkscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-2001170074
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
Cc: paulus@ozlabs.org, Ganesh Goudar <ganeshgr@linux.ibm.com>, groug@kaod.org
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

Change Log v20:
  - Remove code left over from previous version.

Change Log v19:
  - Create error object for migration blocker in machine_init().
  - Remove the check to see fwnmi calls are already registered,
    which is no longer needed.
  - Register fwnmi RTAS calls in core_rtas_register_types() where
    other RTAS calls are registered.
  - Bail out from interlock call if the cap is not set.
  - Reorder and add missing S-O-Bs.

Change Log v18:
  - Dynamically create the Error object before adding it as blocker
  - In apply hook check if the fwnmi calls are already registered and
    if kvm supports fwnmi before registering the fwnmi calls.
  - In rtas_ibm_nmi_register() test the feature flag before attempting
    to get the RTAS address
  - Introduce a bool member "fwnmi_calls_registered" to check if the
    fwnmi calls are registered and use the same in needed hook to save
    the state during migration. 

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
 hw/ppc/spapr.c           |  58 +++++++++
 hw/ppc/spapr_caps.c      |  25 ++++
 hw/ppc/spapr_events.c    | 269 +++++++++++++++++++++++++++++++++++++++
 hw/ppc/spapr_rtas.c      |  87 +++++++++++++
 include/hw/ppc/spapr.h   |  25 +++-
 include/qemu/main-loop.h |   8 ++
 target/ppc/kvm.c         |  24 ++++
 target/ppc/kvm_ppc.h     |   8 ++
 target/ppc/trace-events  |   1 +
 10 files changed, 508 insertions(+), 2 deletions(-)

-- 
2.17.2



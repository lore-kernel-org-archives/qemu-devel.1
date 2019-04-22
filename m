Return-Path: <SRS0=5Zkg=SY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE473C282E1
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Apr 2019 07:04:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BA42D20857
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Apr 2019 07:04:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA42D20857
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:33383 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hIT0A-0007H0-QV
	for qemu-devel@archiver.kernel.org; Mon, 22 Apr 2019 03:04:30 -0400
Received: from eggs.gnu.org ([209.51.188.92]:57557)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aravinda@linux.vnet.ibm.com>) id 1hISyj-0006Te-Oz
	for qemu-devel@nongnu.org; Mon, 22 Apr 2019 03:03:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aravinda@linux.vnet.ibm.com>) id 1hISyi-00051R-Iy
	for qemu-devel@nongnu.org; Mon, 22 Apr 2019 03:03:01 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:57180)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aravinda@linux.vnet.ibm.com>)
	id 1hISyi-0004zY-7W
	for qemu-devel@nongnu.org; Mon, 22 Apr 2019 03:03:00 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x3M6rnDJ084695
	for <qemu-devel@nongnu.org>; Mon, 22 Apr 2019 03:02:57 -0400
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2s14j4ffwq-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 22 Apr 2019 03:02:57 -0400
Received: from localhost
	by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <aravinda@linux.vnet.ibm.com>;
	Mon, 22 Apr 2019 08:02:56 +0100
Received: from b03cxnp08028.gho.boulder.ibm.com (9.17.130.20)
	by e34.co.us.ibm.com (192.168.1.134) with IBM ESMTP SMTP Gateway:
	Authorized Use Only! Violators will be prosecuted; 
	(version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
	Mon, 22 Apr 2019 08:02:53 +0100
Received: from b03ledav003.gho.boulder.ibm.com
	(b03ledav003.gho.boulder.ibm.com [9.17.130.234])
	by b03cxnp08028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with
	ESMTP id x3M72qQl31457464
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256
	verify=OK); Mon, 22 Apr 2019 07:02:52 GMT
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9E3416A047;
	Mon, 22 Apr 2019 07:02:52 +0000 (GMT)
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 113C86A04D;
	Mon, 22 Apr 2019 07:02:49 +0000 (GMT)
Received: from [127.0.1.1] (unknown [9.199.63.199])
	by b03ledav003.gho.boulder.ibm.com (Postfix) with ESMTP;
	Mon, 22 Apr 2019 07:02:49 +0000 (GMT)
From: Aravinda Prasad <aravinda@linux.vnet.ibm.com>
To: aik@au1.ibm.com, qemu-ppc@nongnu.org, qemu-devel@nongnu.org,
	david@gibson.dropbear.id.au
Date: Mon, 22 Apr 2019 12:32:48 +0530
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19042207-0016-0000-0000-000009A37CD4
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010972; HX=3.00000242; KW=3.00000007;
	PH=3.00000004; SC=3.00000285; SDB=6.01192628; UDB=6.00625138;
	IPR=6.00973446; 
	MB=3.00026542; MTD=3.00000008; XFM=3.00000015; UTC=2019-04-22 07:02:55
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19042207-0017-0000-0000-000042E8492A
Message-Id: <155591636364.20338.844048953355207313.stgit@aravinda>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
	definitions=2019-04-21_08:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
	priorityscore=1501
	malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
	clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
	mlxlogscore=543 adultscore=0 classifier=spam adjust=0 reason=mlx
	scancount=1 engine=8.0.1-1810050000 definitions=main-1904220052
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 148.163.156.1
Subject: [Qemu-devel] [PATCH v8 0/6] target-ppc/spapr: Add FWNMI support in
 QEMU for PowerKVM guests
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
Cc: paulus@ozlabs.org, aravinda@linux.vnet.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190422070248.0-xhggS6DnCl-Q9PB0A9VCxrt1CW9Ghi8oVP-nv71q0@z>

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

Change Log v8:
  - Added functionality to check FWNMI capability during
    VM migration

Change Log v7:
  - Rebased to 4.1

Change Log v6:
  - Fetches rtas_addr from fdt
  - Handles all error conditions (earlier it was only UEs)

Change Log v5:
  - Handled VM migrations by including rtas_addr in VMSTATE.
  - Migration is blocked while a machine check is in progress.

---

Aravinda Prasad (6):
      ppc: spapr: Handle "ibm,nmi-register" and "ibm,nmi-interlock" RTAS calls
      Wrapper function to wait on condition for the main loop mutex
      target/ppc: Handle NMI guest exit
      target/ppc: Build rtas error log upon an MCE
      ppc: spapr: Enable FWNMI capability
      migration: Block migration while handling machine check


 cpus.c                   |    5 +
 hw/ppc/spapr.c           |   26 ++++
 hw/ppc/spapr_caps.c      |   26 ++++
 hw/ppc/spapr_events.c    |  284 ++++++++++++++++++++++++++++++++++++++++++++++
 hw/ppc/spapr_rtas.c      |   84 ++++++++++++++
 include/hw/ppc/spapr.h   |   26 ++++
 include/qemu/main-loop.h |    8 +
 target/ppc/kvm.c         |   30 +++++
 target/ppc/kvm_ppc.h     |    8 +
 target/ppc/trace-events  |    2 
 10 files changed, 497 insertions(+), 2 deletions(-)

--
Aravinda



Return-Path: <SRS0=Jnn8=YR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EC3CCA9EAF
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 16:10:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 54357205F4
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 16:10:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 54357205F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46254 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNfhP-00056b-W3
	for qemu-devel@archiver.kernel.org; Thu, 24 Oct 2019 12:10:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39180)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groug@kaod.org>) id 1iNe5H-0002Xs-84
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 10:27:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groug@kaod.org>) id 1iNe5F-0004XS-Jl
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 10:27:26 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:58150)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <groug@kaod.org>) id 1iNe5F-0004Vz-CD
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 10:27:25 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x9OEOT7L133765
 for <qemu-devel@nongnu.org>; Thu, 24 Oct 2019 10:27:23 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2vuctxaptf-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 24 Oct 2019 10:27:22 -0400
Received: from localhost
 by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <groug@kaod.org>;
 Thu, 24 Oct 2019 15:27:20 +0100
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
 by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Thu, 24 Oct 2019 15:27:18 +0100
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com
 [9.149.105.60])
 by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x9OERHAj10223780
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 24 Oct 2019 14:27:17 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 159F942041;
 Thu, 24 Oct 2019 14:27:17 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D6F2442042;
 Thu, 24 Oct 2019 14:27:16 +0000 (GMT)
Received: from bahia.lan (unknown [9.145.36.67])
 by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Thu, 24 Oct 2019 14:27:16 +0000 (GMT)
Subject: [PATCH 0/3] ppc: Fix 'info pic' crash
From: Greg Kurz <groug@kaod.org>
To: David Gibson <david@gibson.dropbear.id.au>
Date: Thu, 24 Oct 2019 16:27:16 +0200
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19102414-4275-0000-0000-00000376E9F5
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19102414-4276-0000-0000-0000388A14C3
Message-Id: <157192723646.3146912.1271674896169655201.stgit@bahia.lan>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-10-24_09:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1034 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=800 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1910240135
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
Cc: qemu-ppc@nongnu.org, =?utf-8?q?C=C3=A9dric?= Le Goater <clg@kaod.org>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The interrupt presenters are currently parented to their associated
VCPU, and we rely on CPU_FOREACH() when we need to perform a specific
task with them. Like exposing their state with 'info pic', or finding
the target VCPU for an interrupt when using the XIVE controller.

We recently realized that the latter could crash QEMU because CPU_FOREACH()
can race with CPU hotplug. This got fixed by checking the presenter pointer
under the CPU was set (commit 627fa61746f7), but I'm not that sure that
this is enough since the presenter pointers also get stale at some point
during CPU unplug. And we still have other users of CPU_FOREACH(), namely
'info pic' with both XICS and XIVE, that have the very same problem:

With XIVE:

Thread 1 "qemu-system-ppc" received signal SIGSEGV, Segmentation fault.
0x00000001003d2848 in xive_tctx_pic_print_info (tctx=0x101ae5280, 
    mon=0x7fffffffe180) at /home/greg/Work/qemu/qemu-spapr/hw/intc/xive.c:526
526         int cpu_index = tctx->cs ? tctx->cs->cpu_index : -1;
(gdb) p tctx
$1 = (XiveTCTX *) 0x101ae5280
(gdb) p tctx->cs
$2 = (CPUState *) 0x2057512020203a5d <-- tctx is stale
(gdb) p tctx->cs->cpu_index
Cannot access memory at address 0x205751202020bead

With XICS:

Thread 1 "qemu-system-ppc" received signal SIGSEGV, Segmentation fault.
0x00000001003cc39c in icp_pic_print_info (icp=0x10244ccf0, mon=0x7fffffffe940)
    at /home/greg/Work/qemu/qemu-spapr/hw/intc/xics.c:47
47          int cpu_index = icp->cs ? icp->cs->cpu_index : -1;
(gdb) p icp
$1 = (ICPState *) 0x10244ccf0
(gdb) p icp->cs
$2 = (CPUState *) 0x524958203220 <-- icp is stale
(gdb) p icp->cs->cpu_index
Cannot access memory at address 0x52495820b670

It may be worth finding a way to address this globally instead of
open-coding the check of the presenter pointer everywhere because
this is fragile. I gave a try with this series:

	[0/6] ppc: Reparent the interrupt presenter

	https://patchwork.ozlabs.org/cover/1182224/

but it requires some more reflexion. Also, we're about to enter
softfreeze, and it seems better to come up with a simpler fix.

Let's forget the reparenting and check the presenter pointers
where needed instead. Patch 1 from the previous series was changed
to also NULLify presenter pointers, so that they can be used to
filter out unwanted vCPUs in patch 3. I've kept patch 2 because
it's a fix in the same area, but it isn't related to the QEMU
crashes.

--
Greg

---

Greg Kurz (3):
      ppc: Add intc_destroy() handlers to SpaprInterruptController/PnvChip
      xive, xics: Fix reference counting on CPU objects
      ppc: Skip partially initialized vCPUs in 'info pic'


 hw/intc/spapr_xive.c       |   10 ++++++++++
 hw/intc/xics.c             |   22 +++++++++++++++++++++-
 hw/intc/xics_spapr.c       |   10 ++++++++++
 hw/intc/xive.c             |   20 +++++++++++++++++++-
 hw/ppc/pnv.c               |   21 +++++++++++++++++++++
 hw/ppc/pnv_core.c          |    7 ++++---
 hw/ppc/spapr_cpu_core.c    |    7 +------
 hw/ppc/spapr_irq.c         |   14 ++++++++++++++
 include/hw/ppc/pnv.h       |    1 +
 include/hw/ppc/spapr_irq.h |    2 ++
 include/hw/ppc/xics.h      |    1 +
 include/hw/ppc/xive.h      |    1 +
 12 files changed, 105 insertions(+), 11 deletions(-)



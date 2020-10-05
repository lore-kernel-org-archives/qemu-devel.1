Return-Path: <SRS0=FSHi=DM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70131C4363A
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2020 16:55:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E5696207BC
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2020 16:55:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E5696207BC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35938 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kPTlR-0006Kn-Mj
	for qemu-devel@archiver.kernel.org; Mon, 05 Oct 2020 12:55:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46516)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>)
 id 1kPTid-000390-LN; Mon, 05 Oct 2020 12:52:11 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:26720
 helo=mx0a-001b2d01.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>)
 id 1kPTib-0001dm-N0; Mon, 05 Oct 2020 12:52:11 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 095GffKj016946; Mon, 5 Oct 2020 12:51:56 -0400
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com
 [169.51.49.98])
 by mx0b-001b2d01.pphosted.com with ESMTP id 34077wg9kb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 05 Oct 2020 12:51:56 -0400
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
 by ppma03ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 095GpsFR006793;
 Mon, 5 Oct 2020 16:51:54 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com
 (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
 by ppma03ams.nl.ibm.com with ESMTP id 33xgx8ack4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 05 Oct 2020 16:51:54 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com
 [9.149.105.58])
 by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP
 id 095Gpqnu33227186
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 5 Oct 2020 16:51:52 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5719C4C044;
 Mon,  5 Oct 2020 16:51:52 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0E66D4C046;
 Mon,  5 Oct 2020 16:51:52 +0000 (GMT)
Received: from smtp.tlslab.ibm.com (unknown [9.101.4.1])
 by d06av22.portsmouth.uk.ibm.com (Postfix) with SMTP;
 Mon,  5 Oct 2020 16:51:51 +0000 (GMT)
Received: from yukon.ibmuc.com (sig-9-145-2-207.uk.ibm.com [9.145.2.207])
 by smtp.tlslab.ibm.com (Postfix) with ESMTP id 43276220155;
 Mon,  5 Oct 2020 18:51:51 +0200 (CEST)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: [PATCH v2 0/6] spapr/xive: Activate StoreEOI in P10 compat guests
Date: Mon,  5 Oct 2020 18:51:41 +0200
Message-Id: <20201005165147.526426-1-clg@kaod.org>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235, 18.0.687
 definitions=2020-10-05_11:2020-10-05,
 2020-10-05 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0
 mlxscore=0 priorityscore=1501 lowpriorityscore=0 mlxlogscore=680
 phishscore=0 clxscore=1034 suspectscore=0 spamscore=0 bulkscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2010050117
Received-SPF: softfail client-ip=148.163.158.5; envelope-from=clg@kaod.org;
 helo=mx0a-001b2d01.pphosted.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/05 12:52:05
X-ACL-Warn: Detected OS   = Linux 3.x [generic] [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_SOFTFAIL=0.665 autolearn=no autolearn_force=no
X-Spam_action: no action
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
Cc: qemu-devel@nongnu.org, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 qemu-ppc@nongnu.org, Greg Kurz <groug@kaod.org>,
 Gustavo Romero <gromero@linux.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hello,

When an interrupt has been handled, the OS notifies the interrupt
controller with an EOI sequence. On the XIVE interrupt controller
(POWER9 and POWER10), this can be done with a load or a store
operation on the ESB interrupt management page of the interrupt. The
StoreEOI operation has less latency and improves interrupt handling
performance but it was deactivated during the POWER9 DD2.0 time-frame
because of ordering issues. POWER9 systems use the LoadEOI instead.
POWER10 has fixed the issue with a special load command which enforces
Load-after-Store ordering and StoreEOI can be safely used.

These changes add a new StoreEOI capability which activate StoreEOI
support in the flags returned by the hcall H_INT_GET_SOURCE_INFO. When
the machine is using an emulated interrupt controller, TCG or without
kernel IRQ chip, there are no limitations and activating StoreEOI is
not an issue. However, when running with a kernel IRQ chip, some
verification needs to be done on the host. This is done through the
DT, which tells us that firmware has configured the HW for StoreEOI,
but a new KVM capability would be cleaner.

The last patch introduces a new 'cas' value to the capability which
lets the hypervisor decide at CAS time if StoreEOI should be
advertised to the guest OS. P10 compat kernel are considered safe
because the OS enforces load-after-store ordering but not with P9.

The StoreEOI capability is a global setting and does not take into
account the characteristics of a single source. It could be an issue
if StoreEOI is not supported on a specific source, of a passthrough
device for instance. In that case, we could either introduce a new KVM
ioctl to query the characteristics of the source at the HW level (like
in v1) or deactivate StoreEOI on the machine.

We are using these patches today on P10 and P9 (with a custom FW
activating StoreEOI) systems to benchmark interrupt performance on
large guests but there's no hurry to take them. Let's discuss this new
approach.

Thanks,

C.

Changes in v2:

 - completely approach using a capability

C=C3=A9dric Le Goater (6):
  spapr/xive: Introduce a StoreEOI capability
  spapr/xive: Add a warning when StoreEOI is activated on POWER8 CPUs
  spapr/xive: Add a warning when StoreEOI is activated on POWER9 CPUs
  spapr/xive: Enforce load-after-store ordering
  spapr/xive: Activate StoreEOI at the source level
  spapr/xive: Introduce a new CAS value for the StoreEOI capability

 include/hw/ppc/spapr.h      |  5 +++-
 include/hw/ppc/spapr_xive.h |  1 +
 include/hw/ppc/xive.h       |  8 +++++
 target/ppc/kvm_ppc.h        |  6 ++++
 hw/intc/spapr_xive.c        | 10 +++++++
 hw/intc/spapr_xive_kvm.c    | 12 ++++++++
 hw/intc/xive.c              |  6 ++++
 hw/ppc/spapr.c              |  1 +
 hw/ppc/spapr_caps.c         | 60 +++++++++++++++++++++++++++++++++++++
 hw/ppc/spapr_hcall.c        |  7 +++++
 hw/ppc/spapr_irq.c          |  6 ++++
 target/ppc/kvm.c            | 18 +++++++++++
 12 files changed, 139 insertions(+), 1 deletion(-)

--=20
2.25.4



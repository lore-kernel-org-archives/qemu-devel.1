Return-Path: <SRS0=ht5U=YL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86B76CA9EA0
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2019 17:24:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5DC8421925
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2019 17:24:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5DC8421925
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43756 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iLVz4-0003so-Fw
	for qemu-devel@archiver.kernel.org; Fri, 18 Oct 2019 13:24:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57318)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <clg@kaod.org>) id 1iLVxa-00023h-BZ
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 13:22:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <clg@kaod.org>) id 1iLVxZ-0007j5-4v
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 13:22:42 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:60324
 helo=mx0a-001b2d01.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <clg@kaod.org>) id 1iLVxY-0007iR-VE
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 13:22:41 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x9IHKvOM028653
 for <qemu-devel@nongnu.org>; Fri, 18 Oct 2019 13:22:39 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2vqf6xe2ca-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 18 Oct 2019 13:22:38 -0400
Received: from localhost
 by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <clg@kaod.org>;
 Fri, 18 Oct 2019 18:22:37 +0100
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
 by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Fri, 18 Oct 2019 18:22:35 +0100
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com
 [9.149.105.58])
 by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x9IHMYtx55181376
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 18 Oct 2019 17:22:34 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 524F64C040;
 Fri, 18 Oct 2019 17:22:34 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3E36E4C046;
 Fri, 18 Oct 2019 17:22:34 +0000 (GMT)
Received: from smtp.tls.ibm.com (unknown [9.101.4.1])
 by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Fri, 18 Oct 2019 17:22:34 +0000 (GMT)
Received: from yukon.kaod.org.com (sig-9-145-27-7.uk.ibm.com [9.145.27.7])
 by smtp.tls.ibm.com (Postfix) with ESMTP id 635C22201BC;
 Fri, 18 Oct 2019 19:22:33 +0200 (CEST)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: [PATCH v2 0/2] spapr: interrupt presenter fixes
Date: Fri, 18 Oct 2019 19:22:17 +0200
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-TM-AS-GCONF: 00
x-cbid: 19101817-0028-0000-0000-000003AB589F
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19101817-0029-0000-0000-0000246D7A99
Message-Id: <20191018172219.10039-1-clg@kaod.org>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-10-18_04:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1034 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=599 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1910180154
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by
 mx0b-001b2d01.pphosted.com id x9IHKvOM028653
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
Cc: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org, Greg Kurz <groug@kaod.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hello,

The interrupt presenters are created by a machine handler at the core
level and are reseted independently. This is not consistent and it
raises some issues when it comes to handle hot-plugged CPUs. These are
reseted from the realize handler of the core and the presenters are
not. This is less of an issue in XICS, although a zero MFFR could be a
concern, but in XIVE, the OS CAM line is not set and this breaks the
presenting algorithm. The current code has workarounds which need a
global cleanup.

Extend the sPAPR IRQ backend with a new cpu_intc_reset() handler which
will be called by the CPU reset handler and remove the XiveTCTX reset
handler which is redundant.

Set the OS CAM line when the interrupt presenter of the sPAPR core is
reseted. This will also cover the case of hot-plugged CPUs.


These changes do not address the root problem: the reset of the core
at realize time which hides the fact that hot-plugged CPUs are not
reseted. Anyhow, they do fix the presenter reset and remove a
workaround of workaround in the case of XIVE.

Thanks,

C.

Changes inv v2:

 - removed property
 - simplified reset handlers

C=C3=A9dric Le Goater (2):
  spapr: Introduce a interrupt presenter reset handler
  spapr/xive: Set the OS CAM line at reset

 include/hw/ppc/spapr_irq.h  |  2 ++
 include/hw/ppc/spapr_xive.h |  1 -
 include/hw/ppc/xics.h       |  1 +
 include/hw/ppc/xive.h       |  1 +
 hw/intc/spapr_xive.c        | 25 ++++++++++---------------
 hw/intc/xics.c              |  8 ++------
 hw/intc/xics_spapr.c        |  7 +++++++
 hw/intc/xive.c              | 12 +-----------
 hw/ppc/spapr_cpu_core.c     | 14 ++++++++++----
 hw/ppc/spapr_irq.c          | 14 ++++++++++++++
 10 files changed, 48 insertions(+), 37 deletions(-)

--=20
2.21.0



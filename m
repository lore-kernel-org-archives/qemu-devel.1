Return-Path: <SRS0=FTQm=VX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82495C7618B
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2019 14:44:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5B486218D3
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2019 14:44:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B486218D3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40670 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hr1Sp-0003CS-4T
	for qemu-devel@archiver.kernel.org; Fri, 26 Jul 2019 10:44:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44919)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <groug@kaod.org>) id 1hr1Sb-0002gX-Ms
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 10:44:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groug@kaod.org>) id 1hr1Sa-0008GP-RF
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 10:44:41 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:49824
 helo=mx0a-001b2d01.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <groug@kaod.org>) id 1hr1Sa-0008FF-L0
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 10:44:40 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x6QEiHJm003068
 for <qemu-devel@nongnu.org>; Fri, 26 Jul 2019 10:44:38 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2u03aqgtbb-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 26 Jul 2019 10:44:38 -0400
Received: from localhost
 by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <groug@kaod.org>;
 Fri, 26 Jul 2019 15:44:37 +0100
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
 by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Fri, 26 Jul 2019 15:44:34 +0100
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com
 [9.149.105.59])
 by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x6QEiXwX25231596
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 26 Jul 2019 14:44:33 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 87771A4059;
 Fri, 26 Jul 2019 14:44:33 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 58A83A404D;
 Fri, 26 Jul 2019 14:44:33 +0000 (GMT)
Received: from bahia.lan (unknown [9.145.15.116])
 by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Fri, 26 Jul 2019 14:44:33 +0000 (GMT)
From: Greg Kurz <groug@kaod.org>
To: David Gibson <david@gibson.dropbear.id.au>
Date: Fri, 26 Jul 2019 16:44:33 +0200
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19072614-4275-0000-0000-00000350E575
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19072614-4276-0000-0000-000038614ED1
Message-Id: <156415227297.1064338.9181963275184520284.stgit@bahia.lan>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-07-26_10:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1034 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=338 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1907260181
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 148.163.158.5
Subject: [Qemu-devel] [PATCH 0/3] spapr/pci: Improve MSI tracking
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
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org,
 =?utf-8?q?C=C3=A9dric?= Le Goater <clg@kaod.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Some recent tests with AIX guests showed that we don't tear down
MSIs that were allocated with the "change-msi" RTAS call, when
the guest is rebooted. This series teach PHBs to do the cleanup
at reset time.

This bug has always been there. Not sure it is worth the pain to
have this fixed in 4.1.

--
Greg

---

Greg Kurz (3):
      spapr/pci: Consolidate de-allocation of MSIs
      spapr/pci: Free MSIs during reset
      spapr/irq: Drop spapr_irq_msi_reset()


 hw/ppc/spapr.c             |    4 ----
 hw/ppc/spapr_irq.c         |    7 ++-----
 hw/ppc/spapr_pci.c         |   26 +++++++++++++++++---------
 include/hw/ppc/spapr_irq.h |    1 -
 4 files changed, 19 insertions(+), 19 deletions(-)



Return-Path: <SRS0=aBJE=ZL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E51E4C432C0
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2019 17:52:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BA08D2231A
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2019 17:52:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA08D2231A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48664 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iX7gP-0007P9-Dy
	for qemu-devel@archiver.kernel.org; Tue, 19 Nov 2019 12:52:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53361)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bala24@linux.ibm.com>) id 1iX7ey-0005lc-3t
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 12:51:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bala24@linux.ibm.com>) id 1iX7ew-00058c-TM
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 12:51:28 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:28346
 helo=mx0a-001b2d01.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <bala24@linux.ibm.com>)
 id 1iX7ew-00057h-Oq
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 12:51:26 -0500
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 xAJHlZUr140391
 for <qemu-devel@nongnu.org>; Tue, 19 Nov 2019 12:51:24 -0500
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2wcf46aqq4-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 19 Nov 2019 12:51:24 -0500
Received: from localhost
 by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <bala24@linux.ibm.com>;
 Tue, 19 Nov 2019 17:51:22 -0000
Received: from b06avi18626390.portsmouth.uk.ibm.com (9.149.26.192)
 by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Tue, 19 Nov 2019 17:51:19 -0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com
 [9.149.105.58])
 by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP
 id xAJHof5636700594
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 19 Nov 2019 17:50:41 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A55174C04E;
 Tue, 19 Nov 2019 17:51:18 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 414114C044;
 Tue, 19 Nov 2019 17:51:17 +0000 (GMT)
Received: from localhost.localdomain.com (unknown [9.85.84.11])
 by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Tue, 19 Nov 2019 17:51:17 +0000 (GMT)
From: Balamuruhan S <bala24@linux.ibm.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 0/5] ppc/pnv: fix Homer/Occ mappings on multichip systems
Date: Tue, 19 Nov 2019 23:20:51 +0530
X-Mailer: git-send-email 2.14.5
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19111917-0012-0000-0000-000003689B9E
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19111917-0013-0000-0000-000021A426BE
Message-Id: <20191119175056.32518-1-bala24@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-11-19_06:2019-11-15,2019-11-19 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0
 lowpriorityscore=0 mlxscore=0 mlxlogscore=599 suspectscore=1 spamscore=0
 phishscore=0 priorityscore=1501 malwarescore=0 clxscore=1011
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1911190152
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
Cc: Balamuruhan S <bala24@linux.ibm.com>, david@gibson.dropbear.id.au,
 qemu-ppc@nongnu.org, clg@kaod.org, groug@kaod.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi All,

PowerNV fails to boot in multichip systems due to some misinterpretation
and mapping in Homer/Occ device models, this patchset fixes the
following,

 - Homer size is 4MB per chip and Occ common area size is 8MB
 - Bar masks are used to calculate sizes of Homer/Occ in skiboot so
   return appropriate value
 - Occ common area is in BAR 3 on Power8 but wrongly mapped to BAR 2
   currently
 - OCC common area is shared across chips and should be mapped only once
   for multichip systems

Request for your review and suggestions to make it better. I would like to
thank Cedric for his time and help to figure out the issues.

Balamuruhan S (5):
  hw/ppc/pnv: incorrect homer and occ common area size
  hw/ppc/pnv_xscom: PBA bar mask values are incorrect with homer/occ
    sizes
  hw/ppc/pnv_xscom: Power8 occ common area is in PBA BAR 3
  hw/ppc/pnv_xscom: occ common area to be mapped only once
  hw/ppc/pnv_xscom: add PBA BARs for Power8 slw image

 hw/ppc/pnv_occ.c     |  2 +-
 hw/ppc/pnv_xscom.c   | 37 +++++++++++++++++++++++++++----------
 include/hw/ppc/pnv.h | 12 ++++++++----
 3 files changed, 36 insertions(+), 15 deletions(-)

-- 
2.14.5



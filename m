Return-Path: <SRS0=PbUj=XF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22879C3A5A2
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 07:12:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EDA572084D
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 07:12:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EDA572084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34506 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i7aKH-0004My-Vz
	for qemu-devel@archiver.kernel.org; Tue, 10 Sep 2019 03:12:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45889)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bala24@linux.ibm.com>) id 1i7aJ1-00030A-3m
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 03:11:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bala24@linux.ibm.com>) id 1i7aIz-0005Jq-Ln
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 03:11:14 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:56106)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <bala24@linux.ibm.com>)
 id 1i7aIz-0005Ig-E9
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 03:11:13 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x8A78Pf8040400
 for <qemu-devel@nongnu.org>; Tue, 10 Sep 2019 03:11:10 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2ux6ck1jhv-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 10 Sep 2019 03:11:10 -0400
Received: from localhost
 by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <bala24@linux.ibm.com>;
 Tue, 10 Sep 2019 08:11:07 +0100
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
 by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Tue, 10 Sep 2019 08:11:05 +0100
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com
 [9.149.105.58])
 by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x8A7B4qO63176756
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 10 Sep 2019 07:11:04 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4971A4C052;
 Tue, 10 Sep 2019 07:11:04 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B06FD4C05A;
 Tue, 10 Sep 2019 07:11:02 +0000 (GMT)
Received: from localhost.in.ibm.com (unknown [9.124.35.221])
 by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Tue, 10 Sep 2019 07:11:02 +0000 (GMT)
From: Balamuruhan S <bala24@linux.ibm.com>
To: qemu-devel@nongnu.org, qemu-ppc@nongnu.org
Date: Tue, 10 Sep 2019 12:40:16 +0530
X-Mailer: git-send-email 2.14.5
X-TM-AS-GCONF: 00
x-cbid: 19091007-0020-0000-0000-0000036A611D
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19091007-0021-0000-0000-000021BFE580
Message-Id: <20190910071019.16689-1-bala24@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-09-10_06:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=732 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1909100071
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 148.163.156.1
Subject: [Qemu-devel] [PATCH v1 0/3] add Homer/OCC common area emulation for
 PowerNV
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
Cc: maddy@linux.vnet.ibm.com, groug@kaod.org,
 Balamuruhan S <bala24@linux.ibm.com>, anju@linux.vnet.ibm.com, clg@kaod.org,
 hari@linux.vnet.ibm.com, david@gibson.dropbear.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi All,

This is follow-up patch that implements HOMER and OCC SRAM device
models to emulate homer memory and occ common area access for pstate
table, occ sensors, runtime data and slw.

This version addresses review comments in previous patchset and
breaks it to have separate patch series for Homer and OCC emulation,

https://lists.gnu.org/archive/html/qemu-devel/2019-08/msg00979.html

currently skiboot disables the homer/occ code path with `QUIRK_NO_PBA`,
this quirk have to be removed in skiboot for it to use HOMER and OCC
SRAM device models along with few bug fixes,

https://github.com/balamuruhans/skiboot/commit/a655514d2a730e0372a2faee277d1cf01f71a524
https://github.com/balamuruhans/skiboot/commit/fd3d93d92ec66a7494346d6d24ced7b48264c9a0
https://github.com/balamuruhans/skiboot/commit/165b3829a93bc177c18133945a8cca3a2d701173

changes from v1:
    * reuse PnvOCC device model to implement SRAM device.
    * implement PnvHomer as separate device model.
    * have core max base address as part of PnvHOMERClass.
    * reuse PNV_CHIP_INDEX() instead of introducing new `chip_num`.
    * define all the memory ops access address as macros.
    * few coding style warnings given by checkpatch.pl.

I request for review, comments and suggestions for the changes.

Balamuruhan S (3):
  hw/ppc/pnv_xscom: retrieve homer/occ base address from PBA BARs
  hw/ppc/pnv_occ: add sram device model for occ common area
  hw/ppc/pnv_homer: add PowerNV homer device model

 hw/ppc/Makefile.objs       |   1 +
 hw/ppc/pnv.c               |  87 ++++++++++++---
 hw/ppc/pnv_homer.c         | 258 +++++++++++++++++++++++++++++++++++++++++++++
 hw/ppc/pnv_occ.c           |  78 ++++++++++++++
 hw/ppc/pnv_xscom.c         |  34 +++++-
 include/hw/ppc/pnv.h       |  21 ++++
 include/hw/ppc/pnv_homer.h |  52 +++++++++
 include/hw/ppc/pnv_occ.h   |   3 +
 8 files changed, 513 insertions(+), 21 deletions(-)
 create mode 100644 hw/ppc/pnv_homer.c
 create mode 100644 include/hw/ppc/pnv_homer.h

-- 
2.14.5



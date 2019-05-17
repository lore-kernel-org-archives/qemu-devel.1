Return-Path: <SRS0=PxdI=TR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3607C04AB4
	for <qemu-devel@archiver.kernel.org>; Fri, 17 May 2019 18:35:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8B5EA2173C
	for <qemu-devel@archiver.kernel.org>; Fri, 17 May 2019 18:35:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B5EA2173C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:52292 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hRhhK-0005Rr-Nu
	for qemu-devel@archiver.kernel.org; Fri, 17 May 2019 14:35:14 -0400
Received: from eggs.gnu.org ([209.51.188.92]:56297)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1hRhfE-000474-Hp
	for qemu-devel@nongnu.org; Fri, 17 May 2019 14:33:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1hRhfD-0006HV-EG
	for qemu-devel@nongnu.org; Fri, 17 May 2019 14:33:04 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:37734)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1hRhfD-0006EX-3S
	for qemu-devel@nongnu.org; Fri, 17 May 2019 14:33:03 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x4HINcus118377
	for <qemu-devel@nongnu.org>; Fri, 17 May 2019 14:32:56 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2shysbwy7w-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 17 May 2019 14:32:56 -0400
Received: from localhost
	by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <groug@kaod.org>;
	Fri, 17 May 2019 19:32:53 +0100
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
	by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway:
	Authorized Use Only! Violators will be prosecuted; 
	(version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
	Fri, 17 May 2019 19:32:51 +0100
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com
	[9.149.105.62])
	by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with
	ESMTP id x4HIWoss59899986
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256
	verify=OK); Fri, 17 May 2019 18:32:50 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 581BAAE058;
	Fri, 17 May 2019 18:32:50 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 45C9FAE057;
	Fri, 17 May 2019 18:32:50 +0000 (GMT)
Received: from smtp.lab.toulouse-stg.fr.ibm.com (unknown [9.101.4.1])
	by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
	Fri, 17 May 2019 18:32:50 +0000 (GMT)
Received: from bahia.ibmuc.com (sig-9-145-156-103.de.ibm.com [9.145.156.103])
	by smtp.lab.toulouse-stg.fr.ibm.com (Postfix) with ESMTP id
	93EC922019A; Fri, 17 May 2019 20:32:49 +0200 (CEST)
From: Greg Kurz <groug@kaod.org>
To: qemu-devel@nongnu.org
Date: Fri, 17 May 2019 20:32:34 +0200
X-Mailer: git-send-email 2.17.2
X-TM-AS-GCONF: 00
x-cbid: 19051718-4275-0000-0000-00000335EB43
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19051718-4276-0000-0000-0000384577D9
Message-Id: <20190517183240.689188-1-groug@kaod.org>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
	definitions=2019-05-17_11:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
	priorityscore=1501
	malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
	clxscore=1034 lowpriorityscore=0 mlxscore=0 impostorscore=0
	mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
	scancount=1 engine=8.0.1-1810050000 definitions=main-1905170108
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 148.163.156.1
Subject: [Qemu-devel] [PULL 0/6] 9p patches 2019-05-17
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Greg Kurz <groug@kaod.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The following changes since commit f2a930ad8c433c5583e28ec803c8ca7cb2f31ab5:

  Merge remote-tracking branch 'remotes/mcayland/tags/qemu-sparc-20190517' into staging (2019-05-17 15:46:37 +0100)

are available in the Git repository at:

  https://github.com/gkurz/qemu.git tags/for-upstream

for you to fetch changes up to b44a6b09705e9e8a3005229b58de36d176020548:

  virtfs: Fix documentation of -fsdev and -virtfs (2019-05-17 17:34:49 +0200)

----------------------------------------------------------------
This fixes the virtfs documentation (LP 1581976), deprecates the
-virtfs_synth command line option, along with some assorted cleanups.

----------------------------------------------------------------
Greg Kurz (6):
      fsdev: Drop unused extern declaration
      fsdev: Drop unused opaque field
      fsdev: Move some types definition to qemu-fsdev.c
      fsdev: Error out when unsupported option is passed
      vl: Deprecate -virtfs_synth
      virtfs: Fix documentation of -fsdev and -virtfs

 fsdev/file-op-9p.h   |  1 -
 fsdev/qemu-fsdev.c   | 97 ++++++++++++++++++++++++++++++++++++++++++++++++++--
 fsdev/qemu-fsdev.h   | 25 --------------
 qemu-deprecated.texi |  5 +++
 qemu-options.hx      | 96 ++++++++++++++++++++++++++++++++++++---------------
 vl.c                 |  4 +++
 6 files changed, 171 insertions(+), 57 deletions(-)
-- 
2.17.2



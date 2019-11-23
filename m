Return-Path: <SRS0=9vyd=ZP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C337C432C0
	for <qemu-devel@archiver.kernel.org>; Sat, 23 Nov 2019 17:04:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6997B2071C
	for <qemu-devel@archiver.kernel.org>; Sat, 23 Nov 2019 17:04:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6997B2071C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60008 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iYYpr-0003Nz-3g
	for qemu-devel@archiver.kernel.org; Sat, 23 Nov 2019 12:04:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34339)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groug@kaod.org>) id 1iYYkp-0007tO-Eo
 for qemu-devel@nongnu.org; Sat, 23 Nov 2019 11:59:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groug@kaod.org>) id 1iYYko-0001qh-4p
 for qemu-devel@nongnu.org; Sat, 23 Nov 2019 11:59:27 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:21686)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <groug@kaod.org>) id 1iYYkn-0001kv-Sw
 for qemu-devel@nongnu.org; Sat, 23 Nov 2019 11:59:26 -0500
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 xANGvYg2040825
 for <qemu-devel@nongnu.org>; Sat, 23 Nov 2019 11:59:23 -0500
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2wf2660rrb-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Sat, 23 Nov 2019 11:59:23 -0500
Received: from localhost
 by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <groug@kaod.org>;
 Sat, 23 Nov 2019 16:59:21 -0000
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
 by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Sat, 23 Nov 2019 16:59:19 -0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com
 [9.149.105.60])
 by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 xANGxIQ254853882
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sat, 23 Nov 2019 16:59:18 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7D08542045;
 Sat, 23 Nov 2019 16:59:18 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 68E7F42042;
 Sat, 23 Nov 2019 16:59:18 +0000 (GMT)
Received: from smtp.tlslab.ibm.com (unknown [9.101.4.1])
 by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Sat, 23 Nov 2019 16:59:18 +0000 (GMT)
Received: from bahia.ibmuc.com (sig-9-145-172-18.de.ibm.com [9.145.172.18])
 by smtp.tlslab.ibm.com (Postfix) with ESMTP id D64A022008F;
 Sat, 23 Nov 2019 17:59:17 +0100 (CET)
From: Greg Kurz <groug@kaod.org>
To: qemu-devel@nongnu.org
Subject: [PULL 0/1] 9p fixes for QEMU 4.2-rc3
Date: Sat, 23 Nov 2019 17:59:14 +0100
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19112316-0020-0000-0000-0000038DC8A4
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19112316-0021-0000-0000-000021E40D25
Message-Id: <20191123165915.1077842-1-groug@kaod.org>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-11-23_04:2019-11-21,2019-11-23 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0
 mlxscore=0 adultscore=0 clxscore=1034 malwarescore=0 lowpriorityscore=0
 suspectscore=0 phishscore=0 bulkscore=0 priorityscore=1501 mlxlogscore=745
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-1910280000
 definitions=main-1911230141
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Greg Kurz <groug@kaod.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The following changes since commit 2061735ff09f9d5e67c501a96227b470e7de69b1:

  Merge remote-tracking branch 'remotes/bonzini/tags/for-upstream' into staging (2019-11-21 17:18:40 +0000)

are available in the Git repository at:

  https://github.com/gkurz/qemu.git tags/9p-fix-2019-11-23

for you to fetch changes up to 68d654daee4364a0eca589a547d716084d9cb33d:

  9pfs: Fix divide by zero bug (2019-11-23 15:51:48 +0100)

----------------------------------------------------------------
9pfs fixes for QEMU 4.2

This fixes a potential QEMU crash if the underlying filesystem returns
a null block size in statfs().

----------------------------------------------------------------
Dan Schatzberg (1):
      9pfs: Fix divide by zero bug

 hw/9pfs/9p.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)
-- 
2.21.0



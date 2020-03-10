Return-Path: <SRS0=ZRpO=43=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77057C10F27
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 15:21:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4BC0C2051A
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 15:21:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4BC0C2051A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=de.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35498 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBghh-0007hO-Ek
	for qemu-devel@archiver.kernel.org; Tue, 10 Mar 2020 11:21:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54573)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <borntraeger@de.ibm.com>) id 1jBgW6-0005tx-8K
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 11:09:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <borntraeger@de.ibm.com>) id 1jBgW5-0003q8-61
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 11:09:58 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:24496)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
 id 1jBgW5-0003pX-1N
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 11:09:57 -0400
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 02AF3HgG195376
 for <qemu-devel@nongnu.org>; Tue, 10 Mar 2020 11:09:56 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2ym7ac258q-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 10 Mar 2020 11:09:56 -0400
Received: from localhost
 by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
 Tue, 10 Mar 2020 15:09:53 -0000
Received: from b06avi18626390.portsmouth.uk.ibm.com (9.149.26.192)
 by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Tue, 10 Mar 2020 15:09:50 -0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com
 [9.149.105.58])
 by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP
 id 02AF8nQe39977226
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 10 Mar 2020 15:08:49 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id AC1254C06F;
 Tue, 10 Mar 2020 15:09:48 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9A85C4C06E;
 Tue, 10 Mar 2020 15:09:48 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
 by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
 Tue, 10 Mar 2020 15:09:48 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 25651)
 id 59EC1E01C3; Tue, 10 Mar 2020 16:09:48 +0100 (CET)
From: Christian Borntraeger <borntraeger@de.ibm.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 0/4] s390x/ipl: Fixes for ipl and bios
Date: Tue, 10 Mar 2020 16:09:43 +0100
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 20031015-4275-0000-0000-000003AA4266
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20031015-4276-0000-0000-000038BF5C0E
Message-Id: <20200310150947.3510824-1-borntraeger@de.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138, 18.0.572
 definitions=2020-03-10_08:2020-03-10,
 2020-03-10 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0
 mlxlogscore=495 malwarescore=0 bulkscore=0 spamscore=0 suspectscore=0
 adultscore=0 impostorscore=0 mlxscore=0 phishscore=0 priorityscore=1501
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2003100099
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
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
Cc: Thomas Huth <thuth@redhat.com>, David Hildenbrand <david@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>, qemu-devel <qemu-devel@nongnu.org>,
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 qemu-s390x <qemu-s390x@nongnu.org>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Peter,

The following changes since commit 373c7068dd610e97f0b551b5a6d0a27cd6da4506:

  qemu.nsi: Install Sphinx documentation (2020-03-09 16:45:00 +0000)

are available in the Git repository at:

  git://github.com/borntraeger/qemu.git tags/s390x-20200310

for you to fetch changes up to 94c21436e5a89143f8b9cb4d089d1a2f3f4fd377:

  s390x: ipl: Consolidate iplb validity check into one function (2020-03-10 10:18:20 +0100)

----------------------------------------------------------------
s390x/ipl: Fixes for ipl and bios

- provide a pointer to the loadparm. This fixes crashes in zipl
- do not throw away guest changes of the IPL parameter during reset
- refactor IPLB checks

----------------------------------------------------------------
Christian Borntraeger (1):
      s390x/bios: rebuild s390-ccw.img

Halil Pasic (1):
      s390/ipl: sync back loadparm

Janosch Frank (2):
      pc-bios: s390x: Save iplb location in lowcore
      s390x: ipl: Consolidate iplb validity check into one function

 hw/s390x/ipl.c               |  25 +++++++++++++++++++++++++
 hw/s390x/ipl.h               |  18 +++++++++---------
 pc-bios/s390-ccw.img         | Bin 42608 -> 42608 bytes
 pc-bios/s390-ccw/jump2ipl.c  |   1 +
 pc-bios/s390-ccw/main.c      |   8 +++++++-
 pc-bios/s390-ccw/netmain.c   |   1 +
 pc-bios/s390-ccw/s390-arch.h |  10 ++++++++--
 pc-bios/s390-ccw/s390-ccw.h  |   1 +
 target/s390x/diag.c          |   2 +-
 9 files changed, 53 insertions(+), 13 deletions(-)



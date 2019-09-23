Return-Path: <SRS0=aFsj=XS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86FFEC4740C
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Sep 2019 07:42:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5F5FC2087C
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Sep 2019 07:42:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F5FC2087C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=de.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53096 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iCIzV-0008Vy-8H
	for qemu-devel@archiver.kernel.org; Mon, 23 Sep 2019 03:42:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38668)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <borntraeger@de.ibm.com>) id 1iCIwX-0006eJ-8w
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 03:39:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <borntraeger@de.ibm.com>) id 1iCIwV-0004zG-CT
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 03:39:33 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:20148
 helo=mx0a-001b2d01.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
 id 1iCIwV-0004wB-30
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 03:39:31 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x8N7bkr1080059
 for <qemu-devel@nongnu.org>; Mon, 23 Sep 2019 03:39:29 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2v6recb88h-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 23 Sep 2019 03:39:29 -0400
Received: from localhost
 by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
 Mon, 23 Sep 2019 08:39:27 +0100
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
 by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Mon, 23 Sep 2019 08:39:23 +0100
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com
 [9.149.105.59])
 by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x8N7dMpQ45154310
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 23 Sep 2019 07:39:22 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 16D93A4053;
 Mon, 23 Sep 2019 07:39:22 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0D683A404D;
 Mon, 23 Sep 2019 07:39:22 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
 by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
 Mon, 23 Sep 2019 07:39:22 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 25651)
 id A6601E02A0; Mon, 23 Sep 2019 09:39:21 +0200 (CEST)
From: Christian Borntraeger <borntraeger@de.ibm.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 0/5] s390x update
Date: Mon, 23 Sep 2019 09:39:16 +0200
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19092307-0020-0000-0000-000003707382
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19092307-0021-0000-0000-000021C62C8B
Message-Id: <20190923073921.13357-1-borntraeger@de.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-09-23_02:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=878 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1909230076
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
Cc: Yifan Luo <luoyifan@cmss.chinamobile.com>, Thomas Huth <thuth@redhat.com>,
 David Hildenbrand <david@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 qemu-devel <qemu-devel@nongnu.org>, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 qemu-s390x <qemu-s390x@nongnu.org>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Peter,

here is the non-tcg subset of the s390x updates.


The following changes since commit 4300b7c2cd9f3f273804e8cca325842ccb93b1ad:

  Merge remote-tracking branch 'remotes/cleber/tags/python-next-pull-request' into staging (2019-09-20 17:28:43 +0100)

are available in the Git repository at:

  git://github.com/borntraeger/qemu.git tags/s390x-20190923

for you to fetch changes up to 7505deca0bfa859136ec6419dbafc504f22fcac2:

  s390x/cpumodel: Add the z15 name to the description of gen15a (2019-09-23 09:15:28 +0200)

----------------------------------------------------------------
- bugfixes in ccw bios
- gen15a is called z15
- officially require a 3.15 kernel or later for kvm

----------------------------------------------------------------
Christian Borntraeger (2):
      Merge tag 's390-ccw-bios-2019-09-18' of https://gitlab.com/huth/qemu into s390-next
      s390x/cpumodel: Add the z15 name to the description of gen15a

Thomas Huth (3):
      pc-bios/s390-ccw: Do not pre-initialize empty array
      pc-bios/s390-ccw: Rebuild the s390-netboot.img firmware image
      s390x/kvm: Officially require at least kernel 3.15

Yifan Luo (1):
      pc-bios/s390-ccw/net: fix a possible memory leak in get_uuid()

 hw/intc/s390_flic_kvm.c    |   6 ------
 hw/intc/trace-events       |   1 -
 pc-bios/s390-ccw/main.c    |   2 +-
 pc-bios/s390-ccw/netmain.c |   1 +
 pc-bios/s390-netboot.img   | Bin 67232 -> 67232 bytes
 target/s390x/cpu_models.c  |   2 +-
 target/s390x/kvm.c         |   7 +++++++
 7 files changed, 10 insertions(+), 9 deletions(-)



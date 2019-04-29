Return-Path: <SRS0=sEuR=S7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 411B9C43219
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2019 09:23:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1509620652
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2019 09:23:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1509620652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=de.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:54596 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hL2VE-0005le-DE
	for qemu-devel@archiver.kernel.org; Mon, 29 Apr 2019 05:23:12 -0400
Received: from eggs.gnu.org ([209.51.188.92]:33382)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1hL2GX-0001YM-FU
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 05:08:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1hL2Bf-0000Lo-Lb
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 05:03:00 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:34690
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1hL2Bf-0000LA-GR
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 05:02:59 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x3T8rauS193912
	for <qemu-devel@nongnu.org>; Mon, 29 Apr 2019 05:02:56 -0400
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2s5vh6md90-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 29 Apr 2019 05:02:55 -0400
Received: from localhost
	by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Mon, 29 Apr 2019 10:02:54 +0100
Received: from b03cxnp07028.gho.boulder.ibm.com (9.17.130.15)
	by e34.co.us.ibm.com (192.168.1.134) with IBM ESMTP SMTP Gateway:
	Authorized Use Only! Violators will be prosecuted; 
	(version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
	Mon, 29 Apr 2019 10:02:52 +0100
Received: from b03ledav006.gho.boulder.ibm.com
	(b03ledav006.gho.boulder.ibm.com [9.17.130.237])
	by b03cxnp07028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with
	ESMTP id x3T92pRO61603852
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256
	verify=OK); Mon, 29 Apr 2019 09:02:51 GMT
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 726BBC605A;
	Mon, 29 Apr 2019 09:02:51 +0000 (GMT)
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AECA1C6059;
	Mon, 29 Apr 2019 09:02:50 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.114.17.106])
	by b03ledav006.gho.boulder.ibm.com (Postfix) with ESMTP;
	Mon, 29 Apr 2019 09:02:50 +0000 (GMT)
From: Christian Borntraeger <borntraeger@de.ibm.com>
To: Cornelia Huck <cohuck@redhat.com>
Date: Mon, 29 Apr 2019 05:02:41 -0400
X-Mailer: git-send-email 2.17.1
X-TM-AS-GCONF: 00
x-cbid: 19042909-0016-0000-0000-000009A833CF
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00011015; HX=3.00000242; KW=3.00000007;
	PH=3.00000004; SC=3.00000285; SDB=6.01195994; UDB=6.00627178;
	IPR=6.00976844; 
	MB=3.00026644; MTD=3.00000008; XFM=3.00000015; UTC=2019-04-29 09:02:54
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19042909-0017-0000-0000-000042FFA099
Message-Id: <20190429090250.7648-1-borntraeger@de.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
	definitions=2019-04-29_04:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
	priorityscore=1501
	malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
	clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
	mlxlogscore=755 adultscore=0 classifier=spam adjust=0 reason=mlx
	scancount=1 engine=8.0.1-1810050000 definitions=main-1904290066
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 148.163.158.5
Subject: [Qemu-devel] [PATCH v3 0/9] s390x: new guest features
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
Cc: "Jason J . Herne" <jjherne@linux.ibm.com>,
	Collin Walling <walling@linux.ibm.com>,
	David Hildenbrand <david@redhat.com>, qemu-devel <qemu-devel@nongnu.org>,
	Halil Pasic <pasic@linux.ibm.com>, qemu-s390x <qemu-s390x@nongnu.org>,
	Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190429090241.LEG5HCuBOmeUhZieZSBNk0a74RJFQzTB3DMGRxxrCwU@z>

Adding gen15.

v2->v3: - merge  deprecation patch into gen 15 patch
	- fix comments
	- use gen15a and gen15b instead of cpuid
v1->v2: - rework csske deprecation
	- white space fixes
	- also require msa4 for msa9

Christian Borntraeger (9):
  linux header sync
  s390x/cpumodel: ignore csske for expansion
  s390x/cpumodel: Miscellaneous-Instruction-Extensions Facility 3
  s390x/cpumodel: msa9 facility
  s390x/cpumodel: vector enhancements
  s390x/cpumodel: enhanced sort facility
  s390x/cpumodel: add Deflate-conversion facility
  s390x/cpumodel: add gen15 defintions
  s390x/cpumodel: wire up 8561 and 8562 as gen15 machines

 linux-headers/asm-s390/kvm.h    |   5 +-
 target/s390x/cpu_features.c     |  54 ++++++++++++++++
 target/s390x/cpu_features.h     |   3 +
 target/s390x/cpu_features_def.h |  49 +++++++++++++++
 target/s390x/cpu_models.c       |  13 ++--
 target/s390x/gen-features.c     | 105 ++++++++++++++++++++++++++++++++
 target/s390x/kvm.c              |  18 ++++++
 7 files changed, 242 insertions(+), 5 deletions(-)

-- 
2.17.1



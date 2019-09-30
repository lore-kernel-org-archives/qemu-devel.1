Return-Path: <SRS0=LaQQ=XZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FF7FC32792
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Sep 2019 13:24:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 415632075D
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Sep 2019 13:24:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 415632075D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=de.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52372 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iEvfR-00019q-Ln
	for qemu-devel@archiver.kernel.org; Mon, 30 Sep 2019 09:24:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42290)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <borntraeger@de.ibm.com>) id 1iEvbG-0004Nd-L8
 for qemu-devel@nongnu.org; Mon, 30 Sep 2019 09:20:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <borntraeger@de.ibm.com>) id 1iEvb6-00055J-LA
 for qemu-devel@nongnu.org; Mon, 30 Sep 2019 09:20:20 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:20190)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
 id 1iEvax-0004z1-Gj
 for qemu-devel@nongnu.org; Mon, 30 Sep 2019 09:20:09 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x8UDHxSa031458
 for <qemu-devel@nongnu.org>; Mon, 30 Sep 2019 09:20:04 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2vbgrtwdmx-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 30 Sep 2019 09:20:04 -0400
Received: from localhost
 by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
 Mon, 30 Sep 2019 14:20:01 +0100
Received: from b06avi18626390.portsmouth.uk.ibm.com (9.149.26.192)
 by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Mon, 30 Sep 2019 14:19:57 +0100
Received: from b06wcsmtp001.portsmouth.uk.ibm.com
 (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
 by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP
 id x8UDJRtX29819256
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 30 Sep 2019 13:19:27 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id CD078A4054;
 Mon, 30 Sep 2019 13:19:55 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B645CA4067;
 Mon, 30 Sep 2019 13:19:55 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
 by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
 Mon, 30 Sep 2019 13:19:55 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 25651)
 id 588C0E01C8; Mon, 30 Sep 2019 15:19:55 +0200 (CEST)
From: Christian Borntraeger <borntraeger@de.ibm.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 00/12] s390x qemu updates 20190930
Date: Mon, 30 Sep 2019 15:19:43 +0200
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19093013-0016-0000-0000-000002B21347
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19093013-0017-0000-0000-00003312EE86
Message-Id: <20190930131955.101131-1-borntraeger@de.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-09-30_08:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1909300138
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
Cc: Thomas Huth <thuth@redhat.com>, Janosch Frank <frankja@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>, David Hildenbrand <david@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>, qemu-devel <qemu-devel@nongnu.org>,
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 qemu-s390x <qemu-s390x@nongnu.org>, kvm@vger.kernel.org,
 Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Claudio Imbrenda <imbrenda@linux.ibm.com>,
 Collin Walling <walling@linux.ibm.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Peter,

The following changes since commit 786d36ad416c6c199b18b78cc31eddfb784fe15d:

  Merge remote-tracking branch 'remotes/pmaydell/tags/pull-target-arm-20190927' into staging (2019-09-30 11:02:22 +0100)

are available in the Git repository at:

  git://github.com/borntraeger/qemu.git tags/s390x-20190930

for you to fetch changes up to c5b9ce518c0551d0198bcddadc82e03de9ac8de9:

  s390/kvm: split kvm mem slots at 4TB (2019-09-30 13:51:50 +0200)

----------------------------------------------------------------
- do not abuse memory_region_allocate_system_memory and split the memory
  according to KVM memslots in KVM code instead (Paolo, Igor)
- change splitting to split at 4TB (Christian)
- do not claim s390 (31bit) support in configure (Thomas)
- sclp error checking (Janosch, Claudio)
- new s390 pci maintainer (Matt, Collin)
- fix s390 pci (again) (Matt)

----------------------------------------------------------------
Christian Borntraeger (1):
      s390/kvm: split kvm mem slots at 4TB

Claudio Imbrenda (1):
      s390x: sclp: Report insufficient SCCB length

Igor Mammedov (2):
      kvm: split too big memory section on several memslots
      s390: do not call memory_region_allocate_system_memory() multiple times

Janosch Frank (3):
      s390x: sclp: refactor invalid command check
      s390x: sclp: boundary check
      s390x: sclp: fix error handling for oversize control blocks

Matthew Rosato (2):
      MAINTAINERS: Update S390 PCI Maintainer
      s390: PCI: fix IOMMU region init

Paolo Bonzini (2):
      kvm: extract kvm_log_clear_one_slot
      kvm: clear dirty bitmaps from all overlapping memslots

Thomas Huth (1):
      configure: Remove s390 (31-bit mode) from the list of supported CPUs

 MAINTAINERS                |   2 +-
 accel/kvm/kvm-all.c        | 237 ++++++++++++++++++++++++++++-----------------
 configure                  |   2 +-
 hw/s390x/event-facility.c  |   3 -
 hw/s390x/s390-pci-bus.c    |   7 +-
 hw/s390x/s390-virtio-ccw.c |  30 +-----
 hw/s390x/sclp.c            |  37 ++++++-
 include/sysemu/kvm_int.h   |   1 +
 target/s390x/kvm.c         |  10 ++
 9 files changed, 202 insertions(+), 127 deletions(-)



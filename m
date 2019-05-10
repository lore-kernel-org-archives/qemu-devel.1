Return-Path: <SRS0=xKZ8=TK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A911C04AB3
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 14:40:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 40F7B21479
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 14:40:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40F7B21479
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:44468 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hP6hZ-0002gN-Ar
	for qemu-devel@archiver.kernel.org; Fri, 10 May 2019 10:40:45 -0400
Received: from eggs.gnu.org ([209.51.188.92]:47676)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pmorel@linux.ibm.com>) id 1hP6fx-0001Ck-EA
	for qemu-devel@nongnu.org; Fri, 10 May 2019 10:39:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pmorel@linux.ibm.com>) id 1hP6fw-0000dL-8p
	for qemu-devel@nongnu.org; Fri, 10 May 2019 10:39:05 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:44128
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pmorel@linux.ibm.com>)
	id 1hP6fw-0000cZ-4e
	for qemu-devel@nongnu.org; Fri, 10 May 2019 10:39:04 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x4AEa69Y040443
	for <qemu-devel@nongnu.org>; Fri, 10 May 2019 10:39:02 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2sdb5r89rw-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 10 May 2019 10:39:01 -0400
Received: from localhost
	by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pmorel@linux.ibm.com>;
	Fri, 10 May 2019 15:38:59 +0100
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
	by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway:
	Authorized Use Only! Violators will be prosecuted; 
	(version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
	Fri, 10 May 2019 15:38:56 +0100
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com
	[9.149.105.62])
	by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with
	ESMTP id x4AEcsfA46792882
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256
	verify=OK); Fri, 10 May 2019 14:38:54 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 63DA3AE053;
	Fri, 10 May 2019 14:38:54 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DCCA6AE045;
	Fri, 10 May 2019 14:38:53 +0000 (GMT)
Received: from morel-ThinkPad-W530.boeblingen.de.ibm.com (unknown
	[9.145.187.238])
	by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
	Fri, 10 May 2019 14:38:53 +0000 (GMT)
From: Pierre Morel <pmorel@linux.ibm.com>
To: cohuck@redhat.com
Date: Fri, 10 May 2019 16:38:48 +0200
X-Mailer: git-send-email 2.7.4
X-TM-AS-GCONF: 00
x-cbid: 19051014-0016-0000-0000-0000027A603C
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19051014-0017-0000-0000-000032D71C15
Message-Id: <1557499133-24169-1-git-send-email-pmorel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
	definitions=2019-05-09_02:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
	priorityscore=1501
	malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
	clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
	mlxlogscore=394 adultscore=0 classifier=spam adjust=0 reason=mlx
	scancount=1 engine=8.0.1-1810050000 definitions=main-1905100100
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 148.163.158.5
Subject: [Qemu-devel] [PATCH 0/5] Retrieving zPCI specific info from QEMU
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
Cc: pasic@linux.vnet.ibm.com, mst@redhat.com, qemu-s390x@nongnu.org,
	david@redhat.com, walling@linux.ibm.com, qemu-devel@nongnu.org,
	borntraeger@de.ibm.com, alex.williamson@redhat.com,
	pbonzini@redhat.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This patch implement the QEMU part to retrieve ZPCI specific
information from the host.
The Linux part has been posted on a separate patch on the LKML.

Subject: [PATCH 0/4] Retrieving zPCI specific info with VFIO
Message-Id: <1557476555-20256-1-git-send-email-pmorel@linux.ibm.com>


We use the PCI VFIO interface to retrieve ZPCI specific information
from the host.

The Linux patch enhance the VFIO_IOMMU_GET_INFO ioctl with
a new Z specific capability and we use it to access the
information stored in the zPCI function.

The retrieval is done only once per function and function group
during the plugging of the device.
The guest's requests are filled with shadow values we keep for
the duration of the device remains plugged.

Still there are some values we need to virtualize, like
the UID and FID of the zPCI function, and we currently
only allow the refresh bit for the zPCI group flags.

Note that we export the CLP specific definitions in a dedicated
file for clarity.


Pierre Morel (5):
  vfio: vfio_iommu_type1: linux header place holder
  s390: PCI: Creation a header dedicated to PCI CLP
  s390: vfio_pci: Use a PCI Group structure
  s390: vfio_pci: Use a PCI Function structure
  s390: vfio_pci: Get zPCI function info from host

 hw/s390x/s390-pci-bus.c    | 142 ++++++++++++++++++++++++++++--
 hw/s390x/s390-pci-bus.h    |  13 ++-
 hw/s390x/s390-pci-clp.h    | 211 +++++++++++++++++++++++++++++++++++++++++++++
 hw/s390x/s390-pci-inst.c   |  28 +++---
 hw/s390x/s390-pci-inst.h   | 196 -----------------------------------------
 linux-headers/linux/vfio.h |  16 +++-
 6 files changed, 386 insertions(+), 220 deletions(-)
 create mode 100644 hw/s390x/s390-pci-clp.h

-- 
2.7.4



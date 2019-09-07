Return-Path: <SRS0=eB96=XC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 042A5C43331
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Sep 2019 00:18:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CF2E920854
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Sep 2019 00:18:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF2E920854
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60934 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i6ORF-0008Qu-Sg
	for qemu-devel@archiver.kernel.org; Fri, 06 Sep 2019 20:18:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42486)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mjrosato@linux.ibm.com>) id 1i6OPE-0006pF-Bg
 for qemu-devel@nongnu.org; Fri, 06 Sep 2019 20:16:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mjrosato@linux.ibm.com>) id 1i6OPB-0002o7-PK
 for qemu-devel@nongnu.org; Fri, 06 Sep 2019 20:16:44 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:11284)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mjrosato@linux.ibm.com>)
 id 1i6OP8-0002mx-Gw; Fri, 06 Sep 2019 20:16:39 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x8707UMe008833; Fri, 6 Sep 2019 20:16:34 -0400
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2uuvxg11s0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 06 Sep 2019 20:16:34 -0400
Received: from m0098399.ppops.net (m0098399.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.27/8.16.0.27) with SMTP id x8707dlf009183;
 Fri, 6 Sep 2019 20:16:34 -0400
Received: from ppma01dal.us.ibm.com (83.d6.3fa9.ip4.static.sl-reverse.com
 [169.63.214.131])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2uuvxg11rq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 06 Sep 2019 20:16:34 -0400
Received: from pps.filterd (ppma01dal.us.ibm.com [127.0.0.1])
 by ppma01dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id x8709N2q011519;
 Sat, 7 Sep 2019 00:16:33 GMT
Received: from b01cxnp23032.gho.pok.ibm.com (b01cxnp23032.gho.pok.ibm.com
 [9.57.198.27]) by ppma01dal.us.ibm.com with ESMTP id 2uqgh82av0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sat, 07 Sep 2019 00:16:33 +0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com
 [9.57.199.108])
 by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x870GVAv46858644
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sat, 7 Sep 2019 00:16:31 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B7BEAB2064;
 Sat,  7 Sep 2019 00:16:31 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4A5F6B205F;
 Sat,  7 Sep 2019 00:16:31 +0000 (GMT)
Received: from oc4221205838.ibm.com (unknown [9.85.134.207])
 by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
 Sat,  7 Sep 2019 00:16:31 +0000 (GMT)
From: Matthew Rosato <mjrosato@linux.ibm.com>
To: cohuck@redhat.com
Date: Fri,  6 Sep 2019 20:16:24 -0400
Message-Id: <1567815389-18229-1-git-send-email-mjrosato@linux.ibm.com>
X-Mailer: git-send-email 1.8.3.1
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-09-06_11:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=497 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1909070000
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 148.163.156.1
Subject: [Qemu-devel] [PATCH v3 0/5] Retrieving zPCI specific info from QEMU
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
Cc: walling@linux.ibm.com, alex.williamson@redhat.com, pmorel@linux.ibm.com,
 david@redhat.com, mst@redhat.com, qemu-devel@nongnu.org, pasic@linux.ibm.com,
 borntraeger@de.ibm.com, qemu-s390x@nongnu.org, pbonzini@redhat.com,
 rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Note: These patches by Pierre got lost in the ether a few months back
as he has been unavailable to carry them forward.  I've made changes
based upon comments received on the kernel part of his last version.

This patch implement the QEMU part to retrieve ZPCI specific
information from the host.
The Linux part has been posted on a separate patch on the LKML.

Subject: [PATCH v4 0/4] Retrieving zPCI specific info with VFIO
  
We use the PCI VFIO interface to retrieve ZPCI specific information
from the host with a ZPCI specific device region.
 
The retrieval is done only once per function and function group
during the plugging of the device.
The guest's requests are filled with shadow values we keep for
the duration of the device remains plugged.

Still there are some values we need to virtualize, like
the UID and FID of the zPCI function, and we currently
only allow the refresh bit for the zPCI group flags.

Note that we export the CLP specific definitions in a dedicated
file for clarity.

Changes since v2:
- update vfio_zdev.h to match kernel + fix packing attribute
- update vfio.h to match kernel changes

Pierre Morel (5):
  vfio: vfio_iommu_type1: linux header place holder
  s390: PCI: Creation a header dedicated to PCI CLP
  s390: vfio_pci: Use a PCI Group structure
  s390: vfio_pci: Use a PCI Function structure
  s390: vfio_pci: Get zPCI function info from host

 hw/s390x/s390-pci-bus.c         | 145 +++++++++++++++++++++++++--
 hw/s390x/s390-pci-bus.h         |  15 ++-
 hw/s390x/s390-pci-clp.h         | 211 ++++++++++++++++++++++++++++++++++++++++
 hw/s390x/s390-pci-inst.c        |  28 +++---
 hw/s390x/s390-pci-inst.h        | 196 -------------------------------------
 linux-headers/linux/vfio.h      |   7 +-
 linux-headers/linux/vfio_zdev.h |  35 +++++++
 7 files changed, 417 insertions(+), 220 deletions(-)
 create mode 100644 hw/s390x/s390-pci-clp.h
 create mode 100644 linux-headers/linux/vfio_zdev.h

-- 
1.8.3.1



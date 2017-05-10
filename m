Received: from eggs.gnu.org ([2001:4830:134:3::10]:49693)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <farman@linux.vnet.ibm.com>) id 1d8Twb-0001Bp-7a
	for qemu-devel@nongnu.org; Wed, 10 May 2017 11:54:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <farman@linux.vnet.ibm.com>) id 1d8TwW-00032L-Uw
	for qemu-devel@nongnu.org; Wed, 10 May 2017 11:54:29 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:35684)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <farman@linux.vnet.ibm.com>)
	id 1d8TwW-00031s-Kv
	for qemu-devel@nongnu.org; Wed, 10 May 2017 11:54:24 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v4AFrqvX127147
	for <qemu-devel@nongnu.org>; Wed, 10 May 2017 11:54:23 -0400
Received: from e06smtp13.uk.ibm.com (e06smtp13.uk.ibm.com [195.75.94.109])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2ac1y0529e-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 10 May 2017 11:54:23 -0400
Received: from localhost
	by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <farman@linux.vnet.ibm.com>;
	Wed, 10 May 2017 16:54:20 +0100
From: Eric Farman <farman@linux.vnet.ibm.com>
Date: Wed, 10 May 2017 17:53:59 +0200
In-Reply-To: <20170510155359.32727-1-farman@linux.vnet.ibm.com>
References: <20170510155359.32727-1-farman@linux.vnet.ibm.com>
Message-Id: <20170510155359.32727-9-farman@linux.vnet.ibm.com>
Subject: [Qemu-devel] [RFC PATCH v2 8/8] pc-bios/s390-ccw.img: rebuild image
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Cornelia Huck <cornelia.huck@de.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Alexander Graf <agraf@suse.de>, Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <famz@redhat.com>, Eric Farman <farman@linux.vnet.ibm.com>

Contains the following commits:
- pc-bios/s390-ccw: Remove duplicate blk_factor adjustment
- pc-bios/s390-ccw: Move SCSI block factor to outer read
- pc-bios/s390-ccw: Break up virtio-scsi read into multiples
- pc-bios/s390-ccw: Refactor scsi_inquiry function
- pc-bios/s390-ccw: Get list of supported EVPD pages
- pc-bios/s390-ccw: Get Block Limits VPD device data
- pc-bios/s390-ccw: Build a reasonable max_sectors limit

Signed-off-by: Eric Farman <farman@linux.vnet.ibm.com>
---
 pc-bios/s390-ccw.img | Bin 26472 -> 26480 bytes
 1 file changed, 0 insertions(+), 0 deletions(-)

diff --git a/pc-bios/s390-ccw.img b/pc-bios/s390-ccw.img
index 0b01d49495c607b67d3f1b2359395534631deb88..5ad056400073c7e1c5e862576c76f0e674ff3c60 100644
GIT binary patch
delta 7395
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

delta 6738
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
U?~ZTDRQy#RnyR>j>mmF90k3n$m;e9(

-- 
2.10.2

Received: from eggs.gnu.org ([2001:4830:134:3::10]:38019)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <farman@linux.vnet.ibm.com>) id 1d3ODf-0003Oa-3R
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 10:47:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <farman@linux.vnet.ibm.com>) id 1d3ODa-0002OS-3F
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 10:47:03 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:34097)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <farman@linux.vnet.ibm.com>)
	id 1d3ODZ-0002NQ-Qe
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 10:46:58 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v3QEhvNp096837
	for <qemu-devel@nongnu.org>; Wed, 26 Apr 2017 10:46:55 -0400
Received: from e06smtp13.uk.ibm.com (e06smtp13.uk.ibm.com [195.75.94.109])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2a2ebvfusj-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 26 Apr 2017 10:46:55 -0400
Received: from localhost
	by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <farman@linux.vnet.ibm.com>;
	Wed, 26 Apr 2017 15:46:52 +0100
From: Eric Farman <farman@linux.vnet.ibm.com>
Date: Wed, 26 Apr 2017 16:46:45 +0200
In-Reply-To: <20170426144645.12476-1-farman@linux.vnet.ibm.com>
References: <20170426144645.12476-1-farman@linux.vnet.ibm.com>
Message-Id: <20170426144645.12476-6-farman@linux.vnet.ibm.com>
Subject: [Qemu-devel] [RFC PATCH v1 5/5] pc-bios/s390-ccw.img: rebuild image
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Alexander Graf <agraf@suse.de>, Eric Farman <farman@linux.vnet.ibm.com>

Contains the following commits:
- pc-bios/s390-ccw: Remove duplicate blk_factor adjustment
- pc-bios/s390-ccw: Move SCSI block factor to outer read
- pc-bios/s390-ccw: Break up virtio-scsi read into multiples

Signed-off-by: Eric Farman <farman@linux.vnet.ibm.com>
---
 pc-bios/s390-ccw.img | Bin 26456 -> 26456 bytes
 1 file changed, 0 insertions(+), 0 deletions(-)

diff --git a/pc-bios/s390-ccw.img b/pc-bios/s390-ccw.img
index 2a4adfa654844040dbc84e90a9c2e0af56fdb9fa..0451d319e691544ded585846cfcb8f1799b3fbf5 100644
GIT binary patch
delta 4701
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
VA4E?t7_Gy&;>oV6u31pY{|8Gx?qmP}

delta 4612
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
EKL#z#%m4rY

-- 
2.10.2

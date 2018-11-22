Received: from eggs.gnu.org ([2001:4830:134:3::10]:59496)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pmorel@linux.ibm.com>) id 1gPrxg-0007j0-Ut
	for qemu-devel@nongnu.org; Thu, 22 Nov 2018 11:36:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pmorel@linux.ibm.com>) id 1gPrxc-0000K2-KQ
	for qemu-devel@nongnu.org; Thu, 22 Nov 2018 11:36:17 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:40804)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pmorel@linux.ibm.com>)
	id 1gPrxc-0000Gx-A0
	for qemu-devel@nongnu.org; Thu, 22 Nov 2018 11:36:12 -0500
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	wAMGYG4R062475
	for <qemu-devel@nongnu.org>; Thu, 22 Nov 2018 11:36:11 -0500
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2nwxd64kq9-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 22 Nov 2018 11:36:10 -0500
Received: from localhost
	by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pmorel@linux.ibm.com>;
	Thu, 22 Nov 2018 16:36:08 -0000
From: Pierre Morel <pmorel@linux.ibm.com>
Date: Thu, 22 Nov 2018 17:35:54 +0100
In-Reply-To: <1542904555-1136-1-git-send-email-pmorel@linux.ibm.com>
References: <1542904555-1136-1-git-send-email-pmorel@linux.ibm.com>
Message-Id: <1542904555-1136-6-git-send-email-pmorel@linux.ibm.com>
Subject: [Qemu-devel] [PATCH v2 5/6] s390x/vfio: ap: Definition for AP
 Adapter type
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: borntraeger@de.ibm.com
Cc: cohuck@redhat.com, agraf@suse.de, rth@twiddle.net, david@redhat.com, qemu-s390x@nongnu.org, qemu-devel@nongnu.org, peter.maydell@linaro.org, pbonzini@redhat.com, mst@redhat.com, eric.auger@redhat.com, akrowiak@linux.ibm.com, pasic@linux.ibm.com

Let's define the AP adapter type to use it with standard
adapter interface

Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
---
 include/hw/s390x/css.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/hw/s390x/css.h b/include/hw/s390x/css.h
index aae19c4..9946492 100644
--- a/include/hw/s390x/css.h
+++ b/include/hw/s390x/css.h
@@ -217,6 +217,7 @@ IOInstEnding do_subchannel_work_passthrough(SubchDev *sub);
 typedef enum {
     CSS_IO_ADAPTER_VIRTIO = 0,
     CSS_IO_ADAPTER_PCI = 1,
+    CSS_IO_ADAPTER_AP = 2,
     CSS_IO_ADAPTER_TYPE_NUMS,
 } CssIoAdapterType;
 
-- 
2.7.4

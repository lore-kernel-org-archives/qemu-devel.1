Received: from eggs.gnu.org ([2001:4830:134:3::10]:39644)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pmorel@linux.ibm.com>) id 1gIWj4-0001rf-Vq
	for qemu-devel@nongnu.org; Fri, 02 Nov 2018 06:30:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pmorel@linux.ibm.com>) id 1gIWj2-0004Gy-7Z
	for qemu-devel@nongnu.org; Fri, 02 Nov 2018 06:30:50 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:33984
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pmorel@linux.ibm.com>)
	id 1gIWj1-00049v-UN
	for qemu-devel@nongnu.org; Fri, 02 Nov 2018 06:30:48 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	wA2ATZNe066886
	for <qemu-devel@nongnu.org>; Fri, 2 Nov 2018 06:30:32 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2ngm31a04r-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 02 Nov 2018 06:30:32 -0400
Received: from localhost
	by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pmorel@linux.ibm.com>;
	Fri, 2 Nov 2018 10:30:30 -0000
From: Pierre Morel <pmorel@linux.ibm.com>
Date: Fri,  2 Nov 2018 11:30:19 +0100
In-Reply-To: <1541154621-22423-1-git-send-email-pmorel@linux.ibm.com>
References: <1541154621-22423-1-git-send-email-pmorel@linux.ibm.com>
Message-Id: <1541154621-22423-4-git-send-email-pmorel@linux.ibm.com>
Subject: [Qemu-devel] [PATCH v1 3/5] s390x/vfio: ap: Definition for AP
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

From: Pierre Morel <pmorel@linux.vnet.ibm.com>

Let's define the AP adapter type to use it with standard
adapter interface.

Signed-off-by: Pierre Morel <pmorel@linux.vnet.ibm.com>
---
 include/hw/s390x/css.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/hw/s390x/css.h b/include/hw/s390x/css.h
index aae19c4272..9946492214 100644
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
2.17.0

Received: from eggs.gnu.org ([2001:4830:134:3::10]:55816)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1dVyO2-0007AX-Pw
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 07:03:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1dVyNz-0003Td-RU
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 07:03:54 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:35383
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1dVyNz-0003TM-Lt
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 07:03:51 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v6EAx2Sk024841
	for <qemu-devel@nongnu.org>; Fri, 14 Jul 2017 07:03:51 -0400
Received: from e06smtp10.uk.ibm.com (e06smtp10.uk.ibm.com [195.75.94.106])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2bpmfrhgr6-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 14 Jul 2017 07:03:50 -0400
Received: from localhost
	by e06smtp10.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Fri, 14 Jul 2017 12:03:48 +0100
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Fri, 14 Jul 2017 12:40:50 +0200
In-Reply-To: <1500028867-134709-1-git-send-email-borntraeger@de.ibm.com>
References: <1500028867-134709-1-git-send-email-borntraeger@de.ibm.com>
Message-Id: <1500028867-134709-24-git-send-email-borntraeger@de.ibm.com>
Subject: [Qemu-devel] [PULL 23/40] pc-bios/s390-ccw: Remove unused structs
 from virtio.h
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel <qemu-devel@nongnu.org>, Alexander Graf <agraf@suse.de>, Richard Henderson <rth@twiddle.net>, Cornelia Huck <cohuck@redhat.com>, Thomas Huth <thuth@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>

From: Thomas Huth <thuth@redhat.com>

Looks like they have never been used, so let's simply remove them.

Acked-by: Cornelia Huck <cohuck@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
Message-Id: <1499863793-18627-7-git-send-email-thuth@redhat.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 pc-bios/s390-ccw/virtio.h | 27 ---------------------------
 1 file changed, 27 deletions(-)

diff --git a/pc-bios/s390-ccw/virtio.h b/pc-bios/s390-ccw/virtio.h
index 024e9a6..d733780 100644
--- a/pc-bios/s390-ccw/virtio.h
+++ b/pc-bios/s390-ccw/virtio.h
@@ -32,24 +32,6 @@ enum VirtioDevType {
 };
 typedef enum VirtioDevType VirtioDevType;
 
-struct VirtioDevHeader {
-    VirtioDevType type:8;
-    uint8_t num_vq;
-    uint8_t feature_len;
-    uint8_t config_len;
-    uint8_t status;
-    uint8_t vqconfig[];
-} __attribute__((packed));
-typedef struct VirtioDevHeader VirtioDevHeader;
-
-struct VirtioVqConfig {
-    uint64_t token;
-    uint64_t address;
-    uint16_t num;
-    uint8_t pad[6];
-} __attribute__((packed));
-typedef struct VirtioVqConfig VirtioVqConfig;
-
 struct VqInfo {
     uint64_t queue;
     uint32_t align;
@@ -64,15 +46,6 @@ struct VqConfig {
 } __attribute__((packed));
 typedef struct VqConfig VqConfig;
 
-struct VirtioDev {
-    VirtioDevHeader *header;
-    VirtioVqConfig *vqconfig;
-    char *host_features;
-    char *guest_features;
-    char *config;
-};
-typedef struct VirtioDev VirtioDev;
-
 #define VIRTIO_RING_SIZE            (PAGE_SIZE * 8)
 #define VIRTIO_MAX_VQS              3
 #define KVM_S390_VIRTIO_RING_ALIGN  4096
-- 
2.7.4

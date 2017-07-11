Received: from eggs.gnu.org ([2001:4830:134:3::10]:54662)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dUvet-0004vg-90
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 09:57:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dUves-0004D2-Ig
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 09:56:59 -0400
Received: from mx1.redhat.com ([209.132.183.28]:4290)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1dUves-0004Cm-CA
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 09:56:58 -0400
From: Thomas Huth <thuth@redhat.com>
Date: Tue, 11 Jul 2017 15:56:32 +0200
Message-Id: <1499781397-19749-7-git-send-email-thuth@redhat.com>
In-Reply-To: <1499781397-19749-1-git-send-email-thuth@redhat.com>
References: <1499781397-19749-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [PATCH v4 06/11] pc-bios/s390-ccw: Remove unused
 structs from virtio.h
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cohuck@redhat.com>
Cc: Alexander Graf <agraf@suse.de>, Farhan Ali <alifm@linux.vnet.ibm.com>, David Hildenbrand <david@redhat.com>, Viktor Mihajlovski <mihajlov@linux.vnet.ibm.com>, Alexey Kardashevskiy <aik@ozlabs.ru>

Looks like they have never beend used, so let's simply remove them.

Signed-off-by: Thomas Huth <thuth@redhat.com>
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
1.8.3.1

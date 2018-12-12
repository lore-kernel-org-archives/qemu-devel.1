Received: from eggs.gnu.org ([2001:4830:134:3::10]:52283)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gX6MZ-0000qR-JE
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 10:23:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gX6MY-0000Fd-0m
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 10:23:51 -0500
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d]:33923)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1gX6MX-0000CR-J3
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 10:23:49 -0500
Received: by mail-wr1-x42d.google.com with SMTP id j2so18126715wrw.1
	for <qemu-devel@nongnu.org>; Wed, 12 Dec 2018 07:23:47 -0800 (PST)
Received: from 640k.lan ([93.56.166.5]) by smtp.gmail.com with ESMTPSA id
	u10sm15878859wrr.33.2018.12.12.07.23.45 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Wed, 12 Dec 2018 07:23:45 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 12 Dec 2018 16:22:47 +0100
Message-Id: <1544628195-37728-27-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1544628195-37728-1-git-send-email-pbonzini@redhat.com>
References: <1544628195-37728-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 26/54] vfio: make vfio_address_spaces static
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

It is not used outside hw/vfio/common.c, so it does not need to
be extern.

Acked-by: Alex Williamson <alex.williamson@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/vfio/common.c              | 2 +-
 include/hw/vfio/vfio-common.h | 1 -
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/hw/vfio/common.c b/hw/vfio/common.c
index 7c185e5a..7aa804e 100644
--- a/hw/vfio/common.c
+++ b/hw/vfio/common.c
@@ -39,7 +39,7 @@
 
 struct vfio_group_head vfio_group_list =
     QLIST_HEAD_INITIALIZER(vfio_group_list);
-struct vfio_as_head vfio_address_spaces =
+static QLIST_HEAD(, VFIOAddressSpace) vfio_address_spaces =
     QLIST_HEAD_INITIALIZER(vfio_address_spaces);
 
 #ifdef CONFIG_KVM
diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
index 1b434d0..127ca47 100644
--- a/include/hw/vfio/vfio-common.h
+++ b/include/hw/vfio/vfio-common.h
@@ -181,7 +181,6 @@ int vfio_get_device(VFIOGroup *group, const char *name,
 
 extern const MemoryRegionOps vfio_region_ops;
 extern QLIST_HEAD(vfio_group_head, VFIOGroup) vfio_group_list;
-extern QLIST_HEAD(vfio_as_head, VFIOAddressSpace) vfio_address_spaces;
 
 #ifdef CONFIG_LINUX
 int vfio_get_region_info(VFIODevice *vbasedev, int index,
-- 
1.8.3.1

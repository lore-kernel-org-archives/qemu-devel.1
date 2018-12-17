Received: from eggs.gnu.org ([2001:4830:134:3::10]:43576)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gZ29G-00015i-9Z
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 18:18:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gZ29C-00042Y-Sf
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 18:18:06 -0500
Received: from mx1.redhat.com ([209.132.183.28]:48188)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1gZ29C-0003xe-M6
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 18:18:02 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id F07545D607
	for <qemu-devel@nongnu.org>; Mon, 17 Dec 2018 23:18:01 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 18 Dec 2018 00:16:50 +0100
Message-Id: <20181217231700.24482-26-pbonzini@redhat.com>
In-Reply-To: <20181217231700.24482-1-pbonzini@redhat.com>
References: <20181217231700.24482-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 25/35] vfio: make vfio_address_spaces static
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>

It is not used outside hw/vfio/common.c, so it does not need to
be extern.

Acked-by: Alex Williamson <alex.williamson@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/vfio/common.c              | 2 +-
 include/hw/vfio/vfio-common.h | 1 -
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/hw/vfio/common.c b/hw/vfio/common.c
index 7c185e5a2e..7aa804ea0b 100644
--- a/hw/vfio/common.c
+++ b/hw/vfio/common.c
@@ -39,7 +39,7 @@
=20
 struct vfio_group_head vfio_group_list =3D
     QLIST_HEAD_INITIALIZER(vfio_group_list);
-struct vfio_as_head vfio_address_spaces =3D
+static QLIST_HEAD(, VFIOAddressSpace) vfio_address_spaces =3D
     QLIST_HEAD_INITIALIZER(vfio_address_spaces);
=20
 #ifdef CONFIG_KVM
diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.=
h
index 1b434d02f6..127ca47815 100644
--- a/include/hw/vfio/vfio-common.h
+++ b/include/hw/vfio/vfio-common.h
@@ -181,7 +181,6 @@ int vfio_get_device(VFIOGroup *group, const char *nam=
e,
=20
 extern const MemoryRegionOps vfio_region_ops;
 extern QLIST_HEAD(vfio_group_head, VFIOGroup) vfio_group_list;
-extern QLIST_HEAD(vfio_as_head, VFIOAddressSpace) vfio_address_spaces;
=20
 #ifdef CONFIG_LINUX
 int vfio_get_region_info(VFIODevice *vbasedev, int index,
--=20
2.20.1

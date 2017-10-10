Received: from eggs.gnu.org ([2001:4830:134:3::10]:44906)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1e1y47-0007RU-Af
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 13:11:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1e1y46-0007DB-El
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 13:11:35 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51334)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1e1y46-0007Cy-8Y
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 13:11:34 -0400
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 10 Oct 2017 19:10:58 +0200
Message-Id: <20171010171122.9756-4-marcandre.lureau@redhat.com>
In-Reply-To: <20171010171122.9756-1-marcandre.lureau@redhat.com>
References: <20171010171122.9756-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 03/27] build-sys: make vhost-user-scsi depend on
 libvhost-user.a
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, f4bug@amsat.org, changpeng.liu@intel.com, felipe@nutanix.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
---
 Makefile      | 2 +-
 Makefile.objs | 1 -
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/Makefile b/Makefile
index a0fe721c5b..c2ee765659 100644
--- a/Makefile
+++ b/Makefile
@@ -480,7 +480,7 @@ ivshmem-client$(EXESUF): $(ivshmem-client-obj-y) $(CO=
MMON_LDADDS)
 ivshmem-server$(EXESUF): $(ivshmem-server-obj-y) $(COMMON_LDADDS)
 	$(call LINK, $^)
 endif
-vhost-user-scsi$(EXESUF): $(vhost-user-scsi-obj-y)
+vhost-user-scsi$(EXESUF): $(vhost-user-scsi-obj-y) libvhost-user.a
 	$(call LINK, $^)
=20
 module_block.h: $(SRC_PATH)/scripts/modules/module_block.py config-host.=
mak
diff --git a/Makefile.objs b/Makefile.objs
index bdfa3b6177..d4f973a8fc 100644
--- a/Makefile.objs
+++ b/Makefile.objs
@@ -115,7 +115,6 @@ libvhost-user-obj-y =3D contrib/libvhost-user/
 vhost-user-scsi.o-cflags :=3D $(LIBISCSI_CFLAGS)
 vhost-user-scsi.o-libs :=3D $(LIBISCSI_LIBS)
 vhost-user-scsi-obj-y =3D contrib/vhost-user-scsi/
-vhost-user-scsi-obj-y +=3D contrib/libvhost-user/libvhost-user.o
=20
 ######################################################################
 trace-events-subdirs =3D
--=20
2.15.0.rc0.40.gaefcc5f6f

Received: from eggs.gnu.org ([2001:4830:134:3::10]:48125)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gMvGt-00029R-B8
	for qemu-devel@nongnu.org; Wed, 14 Nov 2018 08:31:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gMvGq-0000s1-NK
	for qemu-devel@nongnu.org; Wed, 14 Nov 2018 08:31:55 -0500
Received: from mx1.redhat.com ([209.132.183.28]:36190)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1gMvGq-0000px-HU
	for qemu-devel@nongnu.org; Wed, 14 Nov 2018 08:31:52 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id E36BF30B96F0
	for <qemu-devel@nongnu.org>; Wed, 14 Nov 2018 13:31:51 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Wed, 14 Nov 2018 17:31:39 +0400
Message-Id: <20181114133139.27346-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH] vmstate: constify SaveVMHandlers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: dgilbert@redhat.com, quintela@redhat.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 include/migration/register.h | 2 +-
 migration/savevm.c           | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/migration/register.h b/include/migration/register.h
index d287f4c317..3d0b9833c6 100644
--- a/include/migration/register.h
+++ b/include/migration/register.h
@@ -72,7 +72,7 @@ int register_savevm_live(DeviceState *dev,
                          const char *idstr,
                          int instance_id,
                          int version_id,
-                         SaveVMHandlers *ops,
+                         const SaveVMHandlers *ops,
                          void *opaque);
=20
 void unregister_savevm(DeviceState *dev, const char *idstr, void *opaque=
);
diff --git a/migration/savevm.c b/migration/savevm.c
index 236b242642..00a054721a 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -303,7 +303,7 @@ typedef struct SaveStateEntry {
     int section_id;
     /* section id read from the stream */
     int load_section_id;
-    SaveVMHandlers *ops;
+    const SaveVMHandlers *ops;
     const VMStateDescription *vmsd;
     void *opaque;
     CompatEntry *compat;
@@ -614,7 +614,7 @@ int register_savevm_live(DeviceState *dev,
                          const char *idstr,
                          int instance_id,
                          int version_id,
-                         SaveVMHandlers *ops,
+                         const SaveVMHandlers *ops,
                          void *opaque)
 {
     SaveStateEntry *se;
--=20
2.19.1.708.g4ede3d42df

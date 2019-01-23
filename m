Received: from eggs.gnu.org ([209.51.188.92]:41040)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1gmKve-0007JQ-Gj
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 10:59:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1gmKvd-0005cC-Qh
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 10:59:02 -0500
Received: from mx1.redhat.com ([209.132.183.28]:50462)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1gmKvd-0005bf-IT
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 10:59:01 -0500
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Wed, 23 Jan 2019 15:58:29 +0000
Message-Id: <20190123155830.8459-9-dgilbert@redhat.com>
In-Reply-To: <20190123155830.8459-1-dgilbert@redhat.com>
References: <20190123155830.8459-1-dgilbert@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 8/9] vmstate: constify SaveVMHandlers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: quintela@redhat.com, peterx@redhat.com, xiaoguangrong@tencent.com, marcandre.lureau@redhat.com, shirley17fei@gmail.com, lifei1214@126.com

From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Message-Id: <20181114133139.27346-1-marcandre.lureau@redhat.com>
Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
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
index d784e8aa40..322660438d 100644
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
2.20.1

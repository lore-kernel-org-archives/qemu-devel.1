Received: from eggs.gnu.org ([2001:4830:134:3::10]:37238)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fs2hk-0008Fk-0a
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 05:12:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fs2hf-0000gK-NM
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 05:11:58 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:43972 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1fs2hf-0000eW-9N
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 05:11:55 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 8F3FE738EF
	for <qemu-devel@nongnu.org>; Tue, 21 Aug 2018 09:11:53 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Tue, 21 Aug 2018 11:11:48 +0200
Message-Id: <20180821091148.32220-8-kraxel@redhat.com>
In-Reply-To: <20180821091148.32220-1-kraxel@redhat.com>
References: <20180821091148.32220-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PULL 7/7] dev-mtp: rename x-root to rootdir
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, Bandan Das <bsd@redhat.com>

From: Bandan Das <bsd@redhat.com>

x-root was renamed as such owing to the experimental nature of the
property; the underlying filesystem semantics were undecided

Signed-off-by: Bandan Das <bsd@redhat.com>
Message-id: 20180720214020.22897-6-bsd@redhat.com
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 hw/usb/dev-mtp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/usb/dev-mtp.c b/hw/usb/dev-mtp.c
index 2e3ea58da6..3fdc4b0da1 100644
--- a/hw/usb/dev-mtp.c
+++ b/hw/usb/dev-mtp.c
@@ -2018,7 +2018,7 @@ static void usb_mtp_realize(USBDevice *dev, Error **errp)
     QTAILQ_INIT(&s->objects);
     if (s->desc == NULL) {
         if (s->root == NULL) {
-            error_setg(errp, "usb-mtp: x-root property must be configured");
+            error_setg(errp, "usb-mtp: rootdir property must be configured");
             return;
         }
         s->desc = strrchr(s->root, '/');
@@ -2047,7 +2047,7 @@ static const VMStateDescription vmstate_usb_mtp = {
 };
 
 static Property mtp_properties[] = {
-    DEFINE_PROP_STRING("x-root", MTPState, root),
+    DEFINE_PROP_STRING("rootdir", MTPState, root),
     DEFINE_PROP_STRING("desc", MTPState, desc),
     DEFINE_PROP_BOOL("readonly", MTPState, readonly, true),
     DEFINE_PROP_END_OF_LIST(),
-- 
2.9.3

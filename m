Received: from eggs.gnu.org ([2001:4830:134:3::10]:39696)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1d8Rg5-0008Do-5S
	for qemu-devel@nongnu.org; Wed, 10 May 2017 09:29:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1d8Rg1-0007Qo-SE
	for qemu-devel@nongnu.org; Wed, 10 May 2017 09:29:17 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38806)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1d8Rg1-0007Pt-NE
	for qemu-devel@nongnu.org; Wed, 10 May 2017 09:29:13 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 80B71C054912
	for <qemu-devel@nongnu.org>; Wed, 10 May 2017 13:29:12 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Wed, 10 May 2017 14:29:06 +0100
Message-Id: <20170510132906.23481-1-dgilbert@redhat.com>
Subject: [Qemu-devel] [PATCH] libvhost-user: Fix VHOST_USER_NET_SET_MTU entry
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, mst@redhat.com, marcandre.lureau@redhat.com

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

VHOST_USER_'s 20th entry is defined as VHOST_USER_INPUT_GET_CONFIG but
should be VHOST_USER_NET_SET_MTU.

Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 contrib/libvhost-user/libvhost-user.c | 2 +-
 contrib/libvhost-user/libvhost-user.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/contrib/libvhost-user/libvhost-user.c b/contrib/libvhost-user/libvhost-user.c
index af4faad60b..645cb36c4c 100644
--- a/contrib/libvhost-user/libvhost-user.c
+++ b/contrib/libvhost-user/libvhost-user.c
@@ -62,7 +62,7 @@ vu_request_to_string(int req)
         REQ(VHOST_USER_GET_QUEUE_NUM),
         REQ(VHOST_USER_SET_VRING_ENABLE),
         REQ(VHOST_USER_SEND_RARP),
-        REQ(VHOST_USER_INPUT_GET_CONFIG),
+        REQ(VHOST_USER_NET_SET_MTU),
         REQ(VHOST_USER_MAX),
     };
 #undef REQ
diff --git a/contrib/libvhost-user/libvhost-user.h b/contrib/libvhost-user/libvhost-user.h
index 156b50e989..ecf9539ffa 100644
--- a/contrib/libvhost-user/libvhost-user.h
+++ b/contrib/libvhost-user/libvhost-user.h
@@ -60,7 +60,7 @@ typedef enum VhostUserRequest {
     VHOST_USER_GET_QUEUE_NUM = 17,
     VHOST_USER_SET_VRING_ENABLE = 18,
     VHOST_USER_SEND_RARP = 19,
-    VHOST_USER_INPUT_GET_CONFIG = 20,
+    VHOST_USER_NET_SET_MTU = 20,
     VHOST_USER_MAX
 } VhostUserRequest;
 
-- 
2.12.2

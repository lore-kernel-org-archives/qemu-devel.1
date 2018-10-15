Received: from eggs.gnu.org ([2001:4830:134:3::10]:45870)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1gByXV-0004mA-9F
	for qemu-devel@nongnu.org; Mon, 15 Oct 2018 04:47:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1gByXS-0004iw-5L
	for qemu-devel@nongnu.org; Mon, 15 Oct 2018 04:47:49 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54480)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1gByXR-0004iC-UI
	for qemu-devel@nongnu.org; Mon, 15 Oct 2018 04:47:46 -0400
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 15 Oct 2018 16:46:26 +0800
Message-Id: <1539593186-32183-27-git-send-email-jasowang@redhat.com>
In-Reply-To: <1539593186-32183-1-git-send-email-jasowang@redhat.com>
References: <1539593186-32183-1-git-send-email-jasowang@redhat.com>
Subject: [Qemu-devel] [PULL 26/26] qemu-options: Fix bad "macaddr" property
 in the documentation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org, qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Jason Wang <jasowang@redhat.com>

From: Thomas Huth <thuth@redhat.com>

When using the "-device" option, the property is called "mac".
"macaddr" is only used for the legacy "-net nic" option.

Reported-by: Harald Hoyer <harald@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 qemu-options.hx | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/qemu-options.hx b/qemu-options.hx
index f139459..0f2f65e 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -2256,7 +2256,7 @@ qemu-system-i386 linux.img \
                  -netdev socket,id=n2,mcast=230.0.0.1:1234
 # launch yet another QEMU instance on same "bus"
 qemu-system-i386 linux.img \
-                 -device e1000,netdev=n3,macaddr=52:54:00:12:34:58 \
+                 -device e1000,netdev=n3,mac=52:54:00:12:34:58 \
                  -netdev socket,id=n3,mcast=230.0.0.1:1234
 @end example
 
-- 
2.5.0

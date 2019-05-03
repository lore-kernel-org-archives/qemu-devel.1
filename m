Received: from eggs.gnu.org ([209.51.188.92]:56093)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1hMXo7-0005CI-E1
	for qemu-devel@nongnu.org; Fri, 03 May 2019 09:00:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1hMXo4-0000DL-M6
	for qemu-devel@nongnu.org; Fri, 03 May 2019 09:00:54 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56480)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1hMXo4-0000CQ-GF
	for qemu-devel@nongnu.org; Fri, 03 May 2019 09:00:52 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id CCC3C300413C
	for <qemu-devel@nongnu.org>; Fri,  3 May 2019 13:00:50 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Fri,  3 May 2019 15:00:30 +0200
Message-Id: <20190503130034.24916-3-marcandre.lureau@redhat.com>
In-Reply-To: <20190503130034.24916-1-marcandre.lureau@redhat.com>
References: <20190503130034.24916-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 2/6] libvhost-user: add PROTOCOL_F_CONFIG if
 {set, get}_config
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: kraxel@redhat.com, mst@redhat.com

Add the config protocol feature bit if the set_config & get_config
callbacks are implemented.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 contrib/libvhost-user/libvhost-user.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/contrib/libvhost-user/libvhost-user.c b/contrib/libvhost-use=
r/libvhost-user.c
index dcf4a969f2..74d42177c5 100644
--- a/contrib/libvhost-user/libvhost-user.c
+++ b/contrib/libvhost-user/libvhost-user.c
@@ -1157,6 +1157,10 @@ vu_get_protocol_features_exec(VuDev *dev, VhostUse=
rMsg *vmsg)
         features |=3D 1ULL << VHOST_USER_PROTOCOL_F_PAGEFAULT;
     }
=20
+    if (dev->iface->get_config && dev->iface->set_config) {
+        features |=3D 1ULL << VHOST_USER_PROTOCOL_F_CONFIG;
+    }
+
     if (dev->iface->get_protocol_features) {
         features |=3D dev->iface->get_protocol_features(dev);
     }
--=20
2.21.0.777.g83232e3864

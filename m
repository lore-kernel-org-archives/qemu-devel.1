Received: from eggs.gnu.org ([2001:4830:134:3::10]:36498)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gZzLc-0007jL-1w
	for qemu-devel@nongnu.org; Thu, 20 Dec 2018 09:30:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gZz8f-0001CU-Sh
	for qemu-devel@nongnu.org; Thu, 20 Dec 2018 09:17:26 -0500
Received: from mx1.redhat.com ([209.132.183.28]:34140)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1gZz8c-0001AP-Ht
	for qemu-devel@nongnu.org; Thu, 20 Dec 2018 09:17:24 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id A483737E60
	for <qemu-devel@nongnu.org>; Thu, 20 Dec 2018 14:17:21 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Thu, 20 Dec 2018 18:15:52 +0400
Message-Id: <20181220141553.24098-12-marcandre.lureau@redhat.com>
In-Reply-To: <20181220141553.24098-1-marcandre.lureau@redhat.com>
References: <20181220141553.24098-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 11/12] spice: use a default name for the
 server
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com, kraxel@redhat.com

If no -name is given, let's use a friendly "QEMU version" server
name. This is sometime exposed on spice client side, for example on
remote-viewer title.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 ui/spice-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/ui/spice-core.c b/ui/spice-core.c
index 9627f07cd8..71ff34c927 100644
--- a/ui/spice-core.c
+++ b/ui/spice-core.c
@@ -785,7 +785,7 @@ void qemu_spice_init(void)
=20
     qemu_opt_foreach(opts, add_channel, &tls_port, &error_fatal);
=20
-    spice_server_set_name(spice_server, qemu_name);
+    spice_server_set_name(spice_server, qemu_name ?: "QEMU " QEMU_VERSIO=
N);
     spice_server_set_uuid(spice_server, (unsigned char *)&qemu_uuid);
=20
     seamless_migration =3D qemu_opt_get_bool(opts, "seamless-migration",=
 0);
--=20
2.20.1.2.gb21ebb671b

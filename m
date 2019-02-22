Received: from eggs.gnu.org ([209.51.188.92]:60429)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gx5eN-0006xq-I4
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 02:53:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gx5eM-0001Y7-33
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 02:53:39 -0500
Received: from mx1.redhat.com ([209.132.183.28]:47980)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1gx5eL-0001O0-L8
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 02:53:37 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
	[10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 9E8AA70D61
	for <qemu-devel@nongnu.org>; Fri, 22 Feb 2019 07:53:30 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Fri, 22 Feb 2019 08:53:25 +0100
Message-Id: <20190222075326.9850-15-kraxel@redhat.com>
In-Reply-To: <20190222075326.9850-1-kraxel@redhat.com>
References: <20190222075326.9850-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 14/15] spice: use a default name for the server
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Markus Armbruster <armbru@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>

From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

If no -name is given, let's use a friendly "QEMU version" server
name. This is sometime exposed on spice client side, for example on
remote-viewer title.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Tested-by: Victor Toso <victortoso@redhat.com>
Message-id: 20190221110703.5775-11-marcandre.lureau@redhat.com
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 ui/spice-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/ui/spice-core.c b/ui/spice-core.c
index 4d384974ca34..0632c74e9fcb 100644
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
2.9.3

Received: from eggs.gnu.org ([2001:4830:134:3::10]:54825)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1f0Tki-00058d-6C
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 11:09:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1f0Tke-0002iR-Ab
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 11:09:40 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:36628 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1f0Tke-0002iI-6a
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 11:09:36 -0400
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Mon, 26 Mar 2018 17:08:44 +0200
Message-Id: <20180326150916.9602-7-marcandre.lureau@redhat.com>
In-Reply-To: <20180326150916.9602-1-marcandre.lureau@redhat.com>
References: <20180326150916.9602-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3 06/38] monitor: no need to remove desc
 before replacing it
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Eduardo Habkost <ehabkost@redhat.com>, Juan Quintela <quintela@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Eric Blake <eblake@redhat.com>, Cleber Rosa <crosa@redhat.com>, Markus Armbruster <armbru@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

The following qdict_put() line does replace the value, as the
documentation says.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 monitor.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/monitor.c b/monitor.c
index a8dcfa283e..5889a32231 100644
--- a/monitor.c
+++ b/monitor.c
@@ -3930,7 +3930,6 @@ static void monitor_qmp_respond(Monitor *mon, QObje=
ct *rsp,
                 && !g_strcmp0(qdict_get_try_str(qdict, "class"),
                           QapiErrorClass_str(ERROR_CLASS_COMMAND_NOT_FOU=
ND))) {
                 /* Provide a more useful error message */
-                qdict_del(qdict, "desc");
                 qdict_put_str(qdict, "desc", "Expecting capabilities"
                               " negotiation with 'qmp_capabilities'");
             }
--=20
2.17.0.rc1.1.g4c4f2b46a3

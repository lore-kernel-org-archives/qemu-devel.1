Received: from eggs.gnu.org ([2001:4830:134:3::10]:43071)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1drMYj-0005b0-Lz
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 07:07:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1drMYi-0006Vs-JV
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 07:07:21 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60738)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1drMYi-0006UJ-BS
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 07:07:20 -0400
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Mon, 11 Sep 2017 13:05:53 +0200
Message-Id: <20170911110623.24981-21-marcandre.lureau@redhat.com>
In-Reply-To: <20170911110623.24981-1-marcandre.lureau@redhat.com>
References: <20170911110623.24981-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3 20/50] qapi-event: add 'if' condition to
 generated enum
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: armbru@redhat.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>

Add condition to QAPIEvent enum members based on the event 'if'.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 scripts/qapi-event.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/qapi-event.py b/scripts/qapi-event.py
index 38f4264817..60c6f7030d 100644
--- a/scripts/qapi-event.py
+++ b/scripts/qapi-event.py
@@ -168,7 +168,7 @@ class QAPISchemaGenEventVisitor(QAPISchemaVisitor):
     def visit_event(self, name, info, ifcond, arg_type, boxed):
         self.decl +=3D gen_event_send_decl(name, arg_type, boxed)
         self.defn +=3D gen_event_send(name, arg_type, boxed)
-        self._event_names.append(QAPISchemaMember(name))
+        self._event_names.append(QAPISchemaMember(name, ifcond))
=20
=20
 (input_file, output_dir, do_c, do_h, prefix, dummy) =3D parse_command_li=
ne()
--=20
2.14.1.146.gd35faa819

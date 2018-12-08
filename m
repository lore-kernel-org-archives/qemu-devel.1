Received: from eggs.gnu.org ([2001:4830:134:3::10]:59808)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gVaby-0004Vn-Hy
	for qemu-devel@nongnu.org; Sat, 08 Dec 2018 06:17:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gVabx-00041V-UZ
	for qemu-devel@nongnu.org; Sat, 08 Dec 2018 06:17:30 -0500
Received: from mx1.redhat.com ([209.132.183.28]:57852)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1gVabx-00041C-O4
	for qemu-devel@nongnu.org; Sat, 08 Dec 2018 06:17:29 -0500
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Sat,  8 Dec 2018 15:15:49 +0400
Message-Id: <20181208111606.8505-11-marcandre.lureau@redhat.com>
In-Reply-To: <20181208111606.8505-1-marcandre.lureau@redhat.com>
References: <20181208111606.8505-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH for-4.0 v7 10/27] qapi-events: add 'if'
 condition to implicit event enum
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

The generated code remains unconditional for now. Later patches
generate the conditionals (also there is no additional coverage of
this change in qapi-schema-test.out since the event_names enum is an
implicit type created by qapi/events.py).

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
---
 scripts/qapi/events.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/qapi/events.py b/scripts/qapi/events.py
index f1b88d8786..37ee5de682 100644
--- a/scripts/qapi/events.py
+++ b/scripts/qapi/events.py
@@ -179,7 +179,7 @@ class QAPISchemaGenEventVisitor(QAPISchemaModularCVis=
itor):
             self._genh.add(gen_event_send_decl(name, arg_type, boxed))
             self._genc.add(gen_event_send(name, arg_type, boxed,
                                           self._event_enum_name))
-        self._event_enum_members.append(QAPISchemaMember(name))
+        self._event_enum_members.append(QAPISchemaMember(name, ifcond))
=20
=20
 def gen_events(schema, output_dir, prefix):
--=20
2.20.0.rc1

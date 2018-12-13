Received: from eggs.gnu.org ([2001:4830:134:3::10]:53465)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gXVyG-0006Ba-I6
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 13:44:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gXVyF-0004Oc-O5
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 13:44:28 -0500
Received: from mx1.redhat.com ([209.132.183.28]:47442)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1gXVyF-0001cd-EE
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 13:44:27 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id A5FCD9B427
	for <qemu-devel@nongnu.org>; Thu, 13 Dec 2018 18:43:48 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Thu, 13 Dec 2018 19:43:30 +0100
Message-Id: <20181213184340.24037-23-armbru@redhat.com>
In-Reply-To: <20181213184340.24037-1-armbru@redhat.com>
References: <20181213184340.24037-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 22/32] qapi-events: add 'if' condition to
 implicit event enum
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

Add condition to QAPIEvent enum members based on the event 'if'.

The generated code remains unconditional for now. Later patches
generate the conditionals (also there is no additional coverage of
this change in qapi-schema-test.out since the event_names enum is an
implicit type created by qapi/events.py).

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Message-Id: <20181213123724.4866-11-marcandre.lureau@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
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
2.17.2

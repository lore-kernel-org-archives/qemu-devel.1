Received: from eggs.gnu.org ([2001:4830:134:3::10]:48604)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1eycIs-0005VD-3q
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 07:53:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1eycIr-00085c-69
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 07:53:14 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:42076 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1eycIr-00085D-26
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 07:53:13 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 930C1406DE12
	for <qemu-devel@nongnu.org>; Wed, 21 Mar 2018 11:53:12 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Wed, 21 Mar 2018 12:51:44 +0100
Message-Id: <20180321115211.17937-23-marcandre.lureau@redhat.com>
In-Reply-To: <20180321115211.17937-1-marcandre.lureau@redhat.com>
References: <20180321115211.17937-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3 22/49] qapi-event: add 'if' condition to
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
Cc: eblake@redhat.com, armbru@redhat.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

Add condition to QAPIEvent enum members based on the event 'if'.

Generated code is not changed by this patch, but with "qapi: add #if
conditions to generated code" patch.

There is no coverage of this change in qapi-schema-test.out since the
event_names enum is an implicit type created by qapi-event.py.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 scripts/qapi/events.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/qapi/events.py b/scripts/qapi/events.py
index 233c27a6c8..f02b65cf5a 100644
--- a/scripts/qapi/events.py
+++ b/scripts/qapi/events.py
@@ -188,7 +188,7 @@ class QAPISchemaGenEventVisitor(QAPISchemaModularCVis=
itor):
         with ifcontext(ifcond, self._genh, self._genc):
             self._genh.add(gen_event_send_decl(name, arg_type, boxed))
             self._genc.add(gen_event_send(name, arg_type, boxed, self._e=
num_name))
-        self._event_names.append(QAPISchemaMember(name))
+        self._event_names.append(QAPISchemaMember(name, ifcond))
=20
=20
 def gen_events(schema, output_dir, prefix):
--=20
2.16.2.521.g9aa15f885a

Received: from eggs.gnu.org ([2001:4830:134:3::10]:58449)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1fbORQ-0008Nr-U5
	for qemu-devel@nongnu.org; Fri, 06 Jul 2018 06:58:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1fbORQ-0008GM-3f
	for qemu-devel@nongnu.org; Fri, 06 Jul 2018 06:58:21 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:40934 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1fbORP-0008DE-VB
	for qemu-devel@nongnu.org; Fri, 06 Jul 2018 06:58:20 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 747DD40122D9
	for <qemu-devel@nongnu.org>; Fri,  6 Jul 2018 10:58:19 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Fri,  6 Jul 2018 12:57:40 +0200
Message-Id: <20180706105753.26700-15-marcandre.lureau@redhat.com>
In-Reply-To: <20180706105753.26700-1-marcandre.lureau@redhat.com>
References: <20180706105753.26700-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v6 14/27] qapi-event: add 'if' condition to
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
Cc: armbru@redhat.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

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
index ea4dac6a05..c9beef8b4b 100644
--- a/scripts/qapi/events.py
+++ b/scripts/qapi/events.py
@@ -189,7 +189,7 @@ class QAPISchemaGenEventVisitor(QAPISchemaModularCVis=
itor):
             self._genh.add(gen_event_send_decl(name, arg_type, boxed))
             self._genc.add(gen_event_send(name, arg_type, boxed,
                                           self._enum_name))
-        self._event_names.append(QAPISchemaMember(name))
+        self._event_names.append(QAPISchemaMember(name, ifcond))
=20
=20
 def gen_events(schema, output_dir, prefix):
--=20
2.18.0.rc1

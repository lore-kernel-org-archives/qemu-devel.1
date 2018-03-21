Received: from eggs.gnu.org ([2001:4830:134:3::10]:48438)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1eycIT-00058e-PQ
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 07:52:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1eycIQ-0007qa-J6
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 07:52:49 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:42050 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1eycIQ-0007qL-Ep
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 07:52:46 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id EB127406DE12
	for <qemu-devel@nongnu.org>; Wed, 21 Mar 2018 11:52:45 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Wed, 21 Mar 2018 12:51:34 +0100
Message-Id: <20180321115211.17937-13-marcandre.lureau@redhat.com>
In-Reply-To: <20180321115211.17937-1-marcandre.lureau@redhat.com>
References: <20180321115211.17937-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3 12/49] qapi/events: add #if conditions to
 events
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

Wrap generated code with #if/#endif using an 'ifcontext' on
QAPIGenCSnippet objects.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 scripts/qapi/events.py | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/scripts/qapi/events.py b/scripts/qapi/events.py
index 26ae00f6f7..dae03e3d88 100644
--- a/scripts/qapi/events.py
+++ b/scripts/qapi/events.py
@@ -185,8 +185,9 @@ class QAPISchemaGenEventVisitor(QAPISchemaModularCVis=
itor):
         genc.add(gen_enum_lookup(self._enum_name, self._event_names))
=20
     def visit_event(self, name, info, ifcond, arg_type, boxed):
-        self._genh.add(gen_event_send_decl(name, arg_type, boxed))
-        self._genc.add(gen_event_send(name, arg_type, boxed, self._enum_=
name))
+        with ifcontext(ifcond, self._genh, self._genc):
+            self._genh.add(gen_event_send_decl(name, arg_type, boxed))
+            self._genc.add(gen_event_send(name, arg_type, boxed, self._e=
num_name))
         self._event_names.append(name)
=20
=20
--=20
2.16.2.521.g9aa15f885a

Received: from eggs.gnu.org ([2001:4830:134:3::10]:45591)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ckRe9-0000Oa-VQ
	for qemu-devel@nongnu.org; Sun, 05 Mar 2017 03:36:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ckRe7-0002xR-7h
	for qemu-devel@nongnu.org; Sun, 05 Mar 2017 03:36:05 -0500
Received: from mx1.redhat.com ([209.132.183.28]:40628)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1ckRe6-0002wT-UR
	for qemu-devel@nongnu.org; Sun, 05 Mar 2017 03:36:03 -0500
Received: from int-mx10.intmail.prod.int.phx2.redhat.com
	(int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 1C4FA3B712
	for <qemu-devel@nongnu.org>; Sun,  5 Mar 2017 08:36:03 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-55.ams2.redhat.com
	[10.36.116.55])
	by int-mx10.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP
	id v258a1fr028563
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256
	verify=NO)
	for <qemu-devel@nongnu.org>; Sun, 5 Mar 2017 03:36:02 -0500
From: Markus Armbruster <armbru@redhat.com>
Date: Sun,  5 Mar 2017 09:35:37 +0100
Message-Id: <1488702958-24336-7-git-send-email-armbru@redhat.com>
In-Reply-To: <1488702958-24336-1-git-send-email-armbru@redhat.com>
References: <1488702958-24336-1-git-send-email-armbru@redhat.com>
Subject: [Qemu-devel] [PULL v2 06/27] qapi-introspect: Mangle --prefix
 argument properly for C
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

qapi-introspect.py --prefix hasn't been used so far, but fix it anyway.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Message-Id: <1488544368-30622-7-git-send-email-armbru@redhat.com>
[Commit message improved]
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 scripts/qapi-introspect.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/qapi-introspect.py b/scripts/qapi-introspect.py
index 541644e..fb72c61 100644
--- a/scripts/qapi-introspect.py
+++ b/scripts/qapi-introspect.py
@@ -64,7 +64,7 @@ class QAPISchemaGenIntrospectVisitor(QAPISchemaVisitor):
         # generate C
         # TODO can generate awfully long lines
         jsons.extend(self._jsons)
-        name = prefix + 'qmp_schema_json'
+        name = c_name(prefix, protect=False) + 'qmp_schema_json'
         self.decl = mcgen('''
 extern const char %(c_name)s[];
 ''',
-- 
2.7.4

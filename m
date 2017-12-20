Received: from eggs.gnu.org ([2001:4830:134:3::10]:55662)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1eRjaX-00029V-1I
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 13:59:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1eRjaR-00060P-Co
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 13:59:33 -0500
Received: from mx1.redhat.com ([209.132.183.28]:52050)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1eRjaR-0005zF-1o
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 13:59:27 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 0B4304E341
	for <qemu-devel@nongnu.org>; Wed, 20 Dec 2017 18:59:26 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-74.ams2.redhat.com
	[10.36.116.74])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id CE3B617571
	for <qemu-devel@nongnu.org>; Wed, 20 Dec 2017 18:59:25 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Wed, 20 Dec 2017 19:59:13 +0100
Message-Id: <20171220185924.32756-3-armbru@redhat.com>
In-Reply-To: <20171220185924.32756-1-armbru@redhat.com>
References: <20171220185924.32756-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 02/13] qapi: Stop rejecting #optional
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Commit 1d8bda1 got rid of #optional tags, and added a check to keep
them from getting added back, to make sure patches then in flight
don't add them back.  It's been six months, time to drop that check.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Message-Id: <20171002141341.24616-3-armbru@redhat.com>
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 scripts/qapi.py | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/scripts/qapi.py b/scripts/qapi.py
index 62dc52ed6e..dc92bca620 100644
--- a/scripts/qapi.py
+++ b/scripts/qapi.py
@@ -234,10 +234,6 @@ class QAPIDoc(object):
             raise QAPIParseError(self.parser,
                                  "'%s' not allowed in free-form document=
ation"
                                  % match.group(1))
-        # TODO Drop this once the dust has settled
-        if (isinstance(self.section, QAPIDoc.ArgSection)
-                and '#optional' in line):
-            raise QAPISemError(self.info, "Please drop the #optional tag=
")
         self.section.append(line)
=20
     def connect_member(self, member):
--=20
2.13.6

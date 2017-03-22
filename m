Received: from eggs.gnu.org ([2001:4830:134:3::10]:52593)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cqkN8-0007td-IC
	for qemu-devel@nongnu.org; Wed, 22 Mar 2017 13:48:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cqkN6-0001LI-MS
	for qemu-devel@nongnu.org; Wed, 22 Mar 2017 13:48:34 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52224)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1cqkN6-0001K3-F3
	for qemu-devel@nongnu.org; Wed, 22 Mar 2017 13:48:32 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 6ABA46199F
	for <qemu-devel@nongnu.org>; Wed, 22 Mar 2017 17:48:32 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-26.ams2.redhat.com
	[10.36.116.26])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 361706046C
	for <qemu-devel@nongnu.org>; Wed, 22 Mar 2017 17:48:32 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Wed, 22 Mar 2017 18:48:18 +0100
Message-Id: <1490204908-26567-8-git-send-email-armbru@redhat.com>
In-Reply-To: <1490204908-26567-1-git-send-email-armbru@redhat.com>
References: <1490204908-26567-1-git-send-email-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL v2 for-2.9 07/17] qapi2texi: Fix to actually
 fail when 'doc-required' is false
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Messed up in commit bc52d03.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Message-Id: <1490015515-25851-3-git-send-email-armbru@redhat.com>
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 scripts/qapi2texi.py | 1 +
 1 file changed, 1 insertion(+)

diff --git a/scripts/qapi2texi.py b/scripts/qapi2texi.py
index 8eed11a..5c4db78 100755
--- a/scripts/qapi2texi.py
+++ b/scripts/qapi2texi.py
@@ -292,6 +292,7 @@ def main(argv):
     if not qapi.doc_required:
         print >>sys.stderr, ("%s: need pragma 'doc-required' "
                              "to generate documentation" % argv[0])
+        sys.exit(1)
     print texi_schema(schema)
=20
=20
--=20
2.7.4

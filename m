Received: from eggs.gnu.org ([2001:4830:134:3::10]:33082)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gYX76-0001TK-Oc
	for qemu-devel@nongnu.org; Sun, 16 Dec 2018 09:09:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gYX76-0005Ce-17
	for qemu-devel@nongnu.org; Sun, 16 Dec 2018 09:09:48 -0500
Received: from mx1.redhat.com ([209.132.183.28]:57970)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1gYX75-0005C6-Rg
	for qemu-devel@nongnu.org; Sun, 16 Dec 2018 09:09:47 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 37777C058CBC
	for <qemu-devel@nongnu.org>; Sun, 16 Dec 2018 14:09:47 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Sun, 16 Dec 2018 18:08:57 +0400
Message-Id: <20181216140902.23986-9-marcandre.lureau@redhat.com>
In-Reply-To: <20181216140902.23986-1-marcandre.lureau@redhat.com>
References: <20181216140902.23986-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 08/13] target.json: add a note about query-cpu*
 not being s390x-specific
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: armbru@redhat.com

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Acked-by: Cornelia Huck <cohuck@redhat.com>
---
 qapi/target.json | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/qapi/target.json b/qapi/target.json
index d751e1623a..dcfb6bc525 100644
--- a/qapi/target.json
+++ b/qapi/target.json
@@ -277,6 +277,9 @@
 #          an unknown cpu definition name, unknown properties or propert=
ies
 #          with wrong types.
 #
+# Note: this command isn't specific to s390x, but is only implemented
+# on this architecture currently.
+#
 # Since: 2.8.0
 ##
 { 'command': 'query-cpu-model-comparison',
@@ -317,6 +320,9 @@
 #          an unknown cpu definition name, unknown properties or propert=
ies
 #          with wrong types.
 #
+# Note: this command isn't specific to s390x, but is only implemented
+# on this architecture currently.
+#
 # Since: 2.8.0
 ##
 { 'command': 'query-cpu-model-baseline',
--=20
2.20.0

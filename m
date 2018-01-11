Received: from eggs.gnu.org ([2001:4830:134:3::10]:52033)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1eZkXV-0008SY-2i
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 16:37:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1eZkXU-00073J-92
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 16:37:33 -0500
Received: from mx1.redhat.com ([209.132.183.28]:54136)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1eZkXU-00072A-3g
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 16:37:32 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 33E4044BE0
	for <qemu-devel@nongnu.org>; Thu, 11 Jan 2018 21:37:31 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Thu, 11 Jan 2018 22:32:46 +0100
Message-Id: <20180111213250.16511-48-marcandre.lureau@redhat.com>
In-Reply-To: <20180111213250.16511-1-marcandre.lureau@redhat.com>
References: <20180111213250.16511-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v4 47/51] target.json: add a note about
 query-cpu* not being s390x-specific
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

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Acked-by: Cornelia Huck <cohuck@redhat.com>
---
 qapi/target.json | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/qapi/target.json b/qapi/target.json
index 776f2da5e1..ca463a0854 100644
--- a/qapi/target.json
+++ b/qapi/target.json
@@ -79,6 +79,9 @@
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
@@ -119,6 +122,9 @@
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
2.16.0.rc1.1.gef27df75a1

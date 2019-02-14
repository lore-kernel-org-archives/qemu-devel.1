Received: from eggs.gnu.org ([209.51.188.92]:54795)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1guIqu-0007YZ-2l
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 10:23:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1guIqs-0001aN-87
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 10:23:03 -0500
Received: from mx1.redhat.com ([209.132.183.28]:41054)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1guIqr-0001Ui-Tn
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 10:23:02 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id EB764C0578C4
	for <qemu-devel@nongnu.org>; Thu, 14 Feb 2019 15:22:58 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Thu, 14 Feb 2019 16:22:44 +0100
Message-Id: <20190214152251.2073-12-armbru@redhat.com>
In-Reply-To: <20190214152251.2073-1-armbru@redhat.com>
References: <20190214152251.2073-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v5 11/18] target.json: add a note about
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
Cc: marcandre.lureau@redhat.com, eblake@redhat.com

From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Acked-by: Cornelia Huck <cohuck@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 qapi/target.json | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/qapi/target.json b/qapi/target.json
index 17671d77c1..010df35ebb 100644
--- a/qapi/target.json
+++ b/qapi/target.json
@@ -275,6 +275,9 @@
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
@@ -315,6 +318,9 @@
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
2.17.2

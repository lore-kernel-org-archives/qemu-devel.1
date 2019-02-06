Received: from eggs.gnu.org ([209.51.188.92]:46338)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1grRlr-0004x0-9X
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 13:18:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1grRln-00028U-FI
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 13:18:01 -0500
Received: from mx1.redhat.com ([209.132.183.28]:52362)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1grRlm-0001qm-Ii
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 13:17:59 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id D802F66987
	for <qemu-devel@nongnu.org>; Wed,  6 Feb 2019 18:17:32 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Wed,  6 Feb 2019 19:17:18 +0100
Message-Id: <20190206181725.14337-11-armbru@redhat.com>
In-Reply-To: <20190206181725.14337-1-armbru@redhat.com>
References: <20190206181725.14337-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3 10/17] target.json: add a note about
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
Cc: marcandre.lureau@redhat.com

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

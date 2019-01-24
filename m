Received: from eggs.gnu.org ([209.51.188.92]:47953)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gmg9X-0004Iq-6V
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 09:38:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gmg9V-0004nz-4I
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 09:38:47 -0500
Received: from mx1.redhat.com ([209.132.183.28]:52482)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1gmg9U-0004Ty-OC
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 09:38:44 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 3770EC05D274
	for <qemu-devel@nongnu.org>; Thu, 24 Jan 2019 14:38:27 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-138.ams2.redhat.com
	[10.36.116.138])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 0324868D24
	for <qemu-devel@nongnu.org>; Thu, 24 Jan 2019 14:38:27 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Thu, 24 Jan 2019 15:38:22 +0100
Message-Id: <20190124143825.25921-2-armbru@redhat.com>
In-Reply-To: <20190124143825.25921-1-armbru@redhat.com>
References: <20190124143825.25921-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 1/4] qapi: Belatedly update docs for commit
 9c2f56e9f9d
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Message-Id: <20181218182234.28876-2-armbru@redhat.com>
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 docs/devel/qapi-code-gen.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/docs/devel/qapi-code-gen.txt b/docs/devel/qapi-code-gen.txt
index 43bd853e69..418a607842 100644
--- a/docs/devel/qapi-code-gen.txt
+++ b/docs/devel/qapi-code-gen.txt
@@ -1369,8 +1369,8 @@ Example:
     void qapi_event_send_my_event(void);
=20
     typedef enum example_QAPIEvent {
-        EXAMPLE_QAPI_EVENT_MY_EVENT =3D 0,
-        EXAMPLE_QAPI_EVENT__MAX =3D 1,
+        EXAMPLE_QAPI_EVENT_MY_EVENT,
+        EXAMPLE_QAPI_EVENT__MAX,
     } example_QAPIEvent;
=20
     #define example_QAPIEvent_str(val) \
--=20
2.17.2

Received: from eggs.gnu.org ([209.51.188.92]:59905)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gvjYn-0001qo-KB
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 09:06:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gvjYm-0005R5-98
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 09:06:17 -0500
Received: from mx1.redhat.com ([209.132.183.28]:2916)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1gvjYk-0005OK-7V
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 09:06:16 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B2694D77F2
	for <qemu-devel@nongnu.org>; Mon, 18 Feb 2019 14:06:09 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-92.ams2.redhat.com
	[10.36.116.92])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 811215C1B2
	for <qemu-devel@nongnu.org>; Mon, 18 Feb 2019 14:06:09 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Mon, 18 Feb 2019 15:05:51 +0100
Message-Id: <20190218140607.31998-3-armbru@redhat.com>
In-Reply-To: <20190218140607.31998-1-armbru@redhat.com>
References: <20190218140607.31998-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 02/18] qapi: Fix up documentation for recent
 commit a95291007b2
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
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Message-Id: <20190214152251.2073-3-armbru@redhat.com>
---
 docs/devel/qapi-code-gen.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/docs/devel/qapi-code-gen.txt b/docs/devel/qapi-code-gen.txt
index b91bde647c..c9ba8ddb2e 100644
--- a/docs/devel/qapi-code-gen.txt
+++ b/docs/devel/qapi-code-gen.txt
@@ -1410,6 +1410,8 @@ Example:
=20
     extern const QEnumLookup example_QAPIEvent_lookup;
=20
+    void example_qapi_event_emit(example_QAPIEvent event, QDict *qdict);
+
     #endif /* EXAMPLE_QAPI_EVENTS_H */
     $ cat qapi-generated/example-qapi-events.c
 [Uninteresting stuff omitted...]
--=20
2.17.2

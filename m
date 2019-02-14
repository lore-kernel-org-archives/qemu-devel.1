Received: from eggs.gnu.org ([209.51.188.92]:56402)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1guDMO-0003Mp-In
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 04:31:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1guDMM-0003LE-GF
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 04:31:12 -0500
Received: from mx1.redhat.com ([209.132.183.28]:35174)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1guDMM-0002ck-26
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 04:31:10 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
	[10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C18F5356F5
	for <qemu-devel@nongnu.org>; Thu, 14 Feb 2019 09:30:55 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Thu, 14 Feb 2019 10:30:37 +0100
Message-Id: <20190214093053.1400-3-armbru@redhat.com>
In-Reply-To: <20190214093053.1400-1-armbru@redhat.com>
References: <20190214093053.1400-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v4 02/18] qapi: Fix up documentation for recent
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
Cc: marcandre.lureau@redhat.com, eblake@redhat.com

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
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

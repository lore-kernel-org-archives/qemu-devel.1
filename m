Received: from eggs.gnu.org ([2001:4830:134:3::10]:49726)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1estwA-00077Y-GW
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 12:30:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1estw4-0004up-8S
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 12:30:10 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:51422 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1estw4-0004qu-4L
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 12:30:04 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id E41784063654
	for <qemu-devel@nongnu.org>; Mon,  5 Mar 2018 17:30:01 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Mon,  5 Mar 2018 18:29:49 +0100
Message-Id: <20180305172951.2150-3-marcandre.lureau@redhat.com>
In-Reply-To: <20180305172951.2150-1-marcandre.lureau@redhat.com>
References: <20180305172951.2150-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 2/4] qlit: use QType instead of int
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

Suggested-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
---
 include/qapi/qmp/qlit.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/qapi/qmp/qlit.h b/include/qapi/qmp/qlit.h
index 56f9d97bd9..f1ed082df8 100644
--- a/include/qapi/qmp/qlit.h
+++ b/include/qapi/qmp/qlit.h
@@ -20,7 +20,7 @@ typedef struct QLitDictEntry QLitDictEntry;
 typedef struct QLitObject QLitObject;
=20
 struct QLitObject {
-    int type;
+    QType type;
     union {
         bool qbool;
         int64_t qnum;
--=20
2.16.2.346.g9779355e34

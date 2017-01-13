Received: from eggs.gnu.org ([2001:4830:134:3::10]:59555)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1cS333-0003EO-2w
	for qemu-devel@nongnu.org; Fri, 13 Jan 2017 09:41:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1cS32y-0006LR-II
	for qemu-devel@nongnu.org; Fri, 13 Jan 2017 09:41:45 -0500
Received: from mx1.redhat.com ([209.132.183.28]:35614)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1cS32y-0006Ku-CA
	for qemu-devel@nongnu.org; Fri, 13 Jan 2017 09:41:40 -0500
Received: from int-mx14.intmail.prod.int.phx2.redhat.com
	(int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 7CF40C057FA6
	for <qemu-devel@nongnu.org>; Fri, 13 Jan 2017 14:41:40 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Fri, 13 Jan 2017 15:41:15 +0100
Message-Id: <20170113144135.5150-2-marcandre.lureau@redhat.com>
In-Reply-To: <20170113144135.5150-1-marcandre.lureau@redhat.com>
References: <20170113144135.5150-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v8 01/21] qapi: replace 'o' for list items
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

Replace with '*', the common form for list items.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 qapi-schema.json | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/qapi-schema.json b/qapi-schema.json
index eab8d4a9ee..1d4f27f1a3 100644
--- a/qapi-schema.json
+++ b/qapi-schema.json
@@ -1883,11 +1883,11 @@
 #
 #        Known limitations:
 #
-#        o This command is stateless, this means that commands that depe=
nd
+#        * This command is stateless, this means that commands that depe=
nd
 #          on state information (such as getfd) might not work
 #
-#       o Commands that prompt the user for data (eg. 'cont' when the bl=
ock
-#         device is encrypted) don't currently work
+#        * Commands that prompt the user for data (eg. 'cont' when the b=
lock
+#          device is encrypted) don't currently work
 ##
 { 'command': 'human-monitor-command',
   'data': {'command-line': 'str', '*cpu-index': 'int'},
--=20
2.11.0

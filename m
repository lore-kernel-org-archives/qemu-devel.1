Received: from eggs.gnu.org ([2001:4830:134:3::10]:43665)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gZK13-0003bn-3k
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 13:22:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gZK0x-0002PR-9g
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 13:22:48 -0500
Received: from mx1.redhat.com ([209.132.183.28]:50552)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1gZK0v-0002FD-E7
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 13:22:43 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 8872A13A9A
	for <qemu-devel@nongnu.org>; Tue, 18 Dec 2018 18:22:40 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Tue, 18 Dec 2018 19:22:20 +0100
Message-Id: <20181218182234.28876-2-armbru@redhat.com>
In-Reply-To: <20181218182234.28876-1-armbru@redhat.com>
References: <20181218182234.28876-1-armbru@redhat.com>
Subject: [Qemu-devel] [RFC PATCH v2 01/15] qapi: Belatedly update docs for
 commit 9c2f56e9f9d
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

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 docs/devel/qapi-code-gen.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/docs/devel/qapi-code-gen.txt b/docs/devel/qapi-code-gen.txt
index 43bd853e69..418a607842 100644
--- a/docs/devel/qapi-code-gen.txt
+++ b/docs/devel/qapi-code-gen.txt
@@ -1369,8 +1369,8 @@ Example:
     void qapi_event_send_my_event(void);
 
     typedef enum example_QAPIEvent {
-        EXAMPLE_QAPI_EVENT_MY_EVENT = 0,
-        EXAMPLE_QAPI_EVENT__MAX = 1,
+        EXAMPLE_QAPI_EVENT_MY_EVENT,
+        EXAMPLE_QAPI_EVENT__MAX,
     } example_QAPIEvent;
 
     #define example_QAPIEvent_str(val) \
-- 
2.17.2

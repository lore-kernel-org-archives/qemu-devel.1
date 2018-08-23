Received: from eggs.gnu.org ([2001:4830:134:3::10]:35476)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fsskO-0000TB-3e
	for qemu-devel@nongnu.org; Thu, 23 Aug 2018 12:46:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fsskL-0006L9-Du
	for qemu-devel@nongnu.org; Thu, 23 Aug 2018 12:46:11 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:44994 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fsskL-0006KL-23
	for qemu-devel@nongnu.org; Thu, 23 Aug 2018 12:46:09 -0400
From: Markus Armbruster <armbru@redhat.com>
Date: Thu, 23 Aug 2018 18:40:13 +0200
Message-Id: <20180823164025.12553-47-armbru@redhat.com>
In-Reply-To: <20180823164025.12553-1-armbru@redhat.com>
References: <20180823164025.12553-1-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH v3 46/58] json: Assert json_parser_parse()
 consumes all tokens on success
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, mdroth@linux.vnet.ibm.com, eblake@redhat.com

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 qobject/json-parser.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/qobject/json-parser.c b/qobject/json-parser.c
index e3ee2a273a..685e9dac24 100644
--- a/qobject/json-parser.c
+++ b/qobject/json-parser.c
@@ -544,6 +544,7 @@ QObject *json_parser_parse(GQueue *tokens, va_list *ap, Error **errp)
     QObject *result;
 
     result = parse_value(&ctxt, ap);
+    assert(ctxt.err || g_queue_is_empty(ctxt.buf));
 
     error_propagate(errp, ctxt.err);
 
-- 
2.17.1

Received: from eggs.gnu.org ([2001:4830:134:3::10]:33086)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ftHof-0002GG-UI
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 15:32:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ftHoe-0001eB-21
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 15:32:17 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:55832 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1ftHoc-0001Xz-0o
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 15:32:14 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id D5FBF7DAC2
	for <qemu-devel@nongnu.org>; Fri, 24 Aug 2018 19:32:07 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-97.ams2.redhat.com
	[10.36.116.97])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id AD92710F1BFC
	for <qemu-devel@nongnu.org>; Fri, 24 Aug 2018 19:32:07 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Fri, 24 Aug 2018 21:31:12 +0200
Message-Id: <20180824193206.25475-5-armbru@redhat.com>
In-Reply-To: <20180824193206.25475-1-armbru@redhat.com>
References: <20180824193206.25475-1-armbru@redhat.com>
Subject: [Qemu-devel] [PULL 04/58] check-qjson: Cover whitespace more
 thoroughly
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
Reviewed-by: Eric Blake <eblake@redhat.com>
Message-Id: <20180823164025.12553-5-armbru@redhat.com>
---
 tests/check-qjson.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/check-qjson.c b/tests/check-qjson.c
index 4daadc272b..188f683317 100644
--- a/tests/check-qjson.c
+++ b/tests/check-qjson.c
@@ -1236,7 +1236,7 @@ static void simple_whitespace(void)
                     })),
         },
         {
-            .encoded = " [ 43 , { 'h' : 'b' }, [ ], 42 ]",
+            .encoded = "\t[ 43 , { 'h' : 'b' },\r\n\t[ ], 42 ]\n",
             .decoded = QLIT_QLIST(((QLitObject[]){
                         QLIT_QNUM(43),
                         QLIT_QDICT(((QLitDictEntry[]){
-- 
2.17.1

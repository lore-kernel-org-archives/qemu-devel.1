Received: from eggs.gnu.org ([2001:4830:134:3::10]:38806)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1fsRp2-0006e2-97
	for qemu-devel@nongnu.org; Wed, 22 Aug 2018 08:01:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1fsRos-0008Az-0m
	for qemu-devel@nongnu.org; Wed, 22 Aug 2018 08:01:06 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:57294 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1fsRor-0008A3-C1
	for qemu-devel@nongnu.org; Wed, 22 Aug 2018 08:01:01 -0400
From: Juan Quintela <quintela@redhat.com>
Date: Wed, 22 Aug 2018 14:00:31 +0200
Message-Id: <20180822120050.12694-2-quintela@redhat.com>
In-Reply-To: <20180822120050.12694-1-quintela@redhat.com>
References: <20180822120050.12694-1-quintela@redhat.com>
Subject: [Qemu-devel] [PULL 01/20] qapi/migration.json: fix the description
 for "query-migrate" output
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: dgilbert@redhat.com, lvivier@redhat.com, peterx@redhat.com, jialina01 <jialina01@baidu.com>, chaiwen <chaiwen@baidu.com>

From: jialina01 <jialina01@baidu.com>

In the return for command "query-migrate", time information like
"total-time", "setup-time", "downtime", is not included in ram
json-object.

So fix the description in migration.json by unpacking those information
from ram json-object.

Signed-off-by: jialina01 <jialina01@baidu.com>
Signed-off-by: chaiwen <chaiwen@baidu.com>
Reviewed-by: Juan Quintela <quintela@redhat.com>
Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 qapi/migration.json | 25 ++++++++++++-------------
 1 file changed, 12 insertions(+), 13 deletions(-)

diff --git a/qapi/migration.json b/qapi/migration.json
index 186e8a7303..4040728439 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -212,13 +212,13 @@
 # -> { "execute": "query-migrate" }
 # <- { "return": {
 #         "status": "completed",
+#         "total-time":12345,
+#         "setup-time":12345,
+#         "downtime":12345,
 #         "ram":{
 #           "transferred":123,
 #           "remaining":123,
 #           "total":246,
-#           "total-time":12345,
-#           "setup-time":12345,
-#           "downtime":12345,
 #           "duplicate":123,
 #           "normal":123,
 #           "normal-bytes":123456,
@@ -238,13 +238,13 @@
 # <- {
 #       "return":{
 #          "status":"active",
+#          "total-time":12345,
+#          "setup-time":12345,
+#          "expected-downtime":12345,
 #          "ram":{
 #             "transferred":123,
 #             "remaining":123,
 #             "total":246,
-#             "total-time":12345,
-#             "setup-time":12345,
-#             "expected-downtime":12345,
 #             "duplicate":123,
 #             "normal":123,
 #             "normal-bytes":123456,
@@ -259,13 +259,13 @@
 # <- {
 #       "return":{
 #          "status":"active",
+#          "total-time":12345,
+#          "setup-time":12345,
+#          "expected-downtime":12345,
 #          "ram":{
 #             "total":1057024,
 #             "remaining":1053304,
 #             "transferred":3720,
-#             "total-time":12345,
-#             "setup-time":12345,
-#             "expected-downtime":12345,
 #             "duplicate":123,
 #             "normal":123,
 #             "normal-bytes":123456,
@@ -285,14 +285,13 @@
 # <- {
 #       "return":{
 #          "status":"active",
-#          "capabilities" : [ { "capability": "xbzrle", "state" : true } ],
+#          "total-time":12345,
+#          "setup-time":12345,
+#          "expected-downtime":12345,
 #          "ram":{
 #             "total":1057024,
 #             "remaining":1053304,
 #             "transferred":3720,
-#             "total-time":12345,
-#             "setup-time":12345,
-#             "expected-downtime":12345,
 #             "duplicate":10,
 #             "normal":3333,
 #             "normal-bytes":3412992,
-- 
2.17.1

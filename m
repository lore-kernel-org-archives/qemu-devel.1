Received: from eggs.gnu.org ([2001:4830:134:3::10]:46249)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jialina01@baidu.com>) id 1fs66A-0005t7-6w
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 08:49:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jialina01@baidu.com>) id 1fs666-0006cw-Ri
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 08:49:26 -0400
Received: from mx21.baidu.com ([220.181.3.85]:42292 helo=baidu.com)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jialina01@baidu.com>) id 1fs666-0006aS-H5
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 08:49:22 -0400
From: <jialina01@baidu.com>
Date: Tue, 21 Aug 2018 20:39:26 +0800
Message-ID: <20180821123926.17412-1-jialina01@baidu.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH] qapi/migration.json: fix the description for
 "query-migrate" output
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: eblake@redhat.com, armbru@redhat.com, quintela@redhat.com, dgilbert@redhat.com
Cc: qemu-devel@nongnu.org, jialina01 <jialina01@baidu.com>, chaiwen <chaiwen@baidu.com>

From: jialina01 <jialina01@baidu.com>

In the return for command "query-migrate", time information like
"total-time", "setup-time", "downtime", is not included in ram
json-object.

So fix the description in migration.json by unpacking those information
from ram json-object.

Signed-off-by: jialina01 <jialina01@baidu.com>
Signed-off-by: chaiwen <chaiwen@baidu.com>
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
2.13.2.windows.1

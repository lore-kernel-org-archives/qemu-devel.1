Received: from eggs.gnu.org ([2001:4830:134:3::10]:44105)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dd4d0-00029L-MJ
	for qemu-devel@nongnu.org; Wed, 02 Aug 2017 21:08:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dd4cw-0005yg-KC
	for qemu-devel@nongnu.org; Wed, 02 Aug 2017 21:08:42 -0400
From: Eric Blake <eblake@redhat.com>
Date: Wed,  2 Aug 2017 20:08:33 -0500
Message-Id: <20170803010833.19647-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH] libqtest: Fix typo in comments
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org

s/continuosly/continuously/

Signed-off-by: Eric Blake <eblake@redhat.com>
---
 tests/libqtest.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tests/libqtest.h b/tests/libqtest.h
index 38bc1e9953..3ae570927a 100644
--- a/tests/libqtest.h
+++ b/tests/libqtest.h
@@ -117,7 +117,7 @@ QDict *qtest_qmp_receive(QTestState *s);
  * @s: #QTestState instance to operate on.
  * @s: #event event to wait for.
  *
- * Continuosly polls for QMP responses until it receives the desired event.
+ * Continuously polls for QMP responses until it receives the desired event.
  */
 void qtest_qmp_eventwait(QTestState *s, const char *event);

@@ -126,7 +126,7 @@ void qtest_qmp_eventwait(QTestState *s, const char *event);
  * @s: #QTestState instance to operate on.
  * @s: #event event to wait for.
  *
- * Continuosly polls for QMP responses until it receives the desired event.
+ * Continuously polls for QMP responses until it receives the desired event.
  * Returns a copy of the event for further investigation.
  */
 QDict *qtest_qmp_eventwait_ref(QTestState *s, const char *event);
@@ -571,7 +571,7 @@ static inline QDict *qmp_receive(void)
  * qmp_eventwait:
  * @s: #event event to wait for.
  *
- * Continuosly polls for QMP responses until it receives the desired event.
+ * Continuously polls for QMP responses until it receives the desired event.
  */
 static inline void qmp_eventwait(const char *event)
 {
@@ -582,7 +582,7 @@ static inline void qmp_eventwait(const char *event)
  * qmp_eventwait_ref:
  * @s: #event event to wait for.
  *
- * Continuosly polls for QMP responses until it receives the desired event.
+ * Continuously polls for QMP responses until it receives the desired event.
  * Returns a copy of the event for further investigation.
  */
 static inline QDict *qmp_eventwait_ref(const char *event)
-- 
2.13.3

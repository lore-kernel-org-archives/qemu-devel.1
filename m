Received: from eggs.gnu.org ([2001:4830:134:3::10]:53673)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1dhDJA-0007QV-9t
	for qemu-devel@nongnu.org; Mon, 14 Aug 2017 07:13:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1dhDJ7-0007VD-4n
	for qemu-devel@nongnu.org; Mon, 14 Aug 2017 07:13:20 -0400
From: Michael Tokarev <mjt@tls.msk.ru>
Date: Mon, 14 Aug 2017 14:07:39 +0300
Message-Id: <e8ec0117b21150d2ea888bbcf6d8fe9683332a9e.1502708830.git.mjt@msgid.tls.msk.ru>
In-Reply-To: <cover.1502708830.git.mjt@msgid.tls.msk.ru>
References: <cover.1502708830.git.mjt@msgid.tls.msk.ru>
In-Reply-To: <cover.1502708830.git.mjt@msgid.tls.msk.ru>
References: <cover.1502708830.git.mjt@msgid.tls.msk.ru>
Subject: [Qemu-devel] [PULL 2/7] libqtest: Fix typo in comments
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Eric Blake <eblake@redhat.com>, qemu-trivial@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>

From: Eric Blake <eblake@redhat.com>

s/continuosly/continuously/

Signed-off-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Jeff Cody <jcody@redhat.com>
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
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
2.11.0

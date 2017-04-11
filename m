Received: from eggs.gnu.org ([2001:4830:134:3::10]:58867)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cxsXw-0004fn-KQ
	for qemu-devel@nongnu.org; Tue, 11 Apr 2017 05:57:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cxsXt-0005xR-BC
	for qemu-devel@nongnu.org; Tue, 11 Apr 2017 05:57:12 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35812)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1cxsXt-0005wh-52
	for qemu-devel@nongnu.org; Tue, 11 Apr 2017 05:57:09 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Tue, 11 Apr 2017 10:56:54 +0100
Message-Id: <20170411095654.18383-1-stefanha@redhat.com>
Subject: [Qemu-devel] [PATCH] simpletrace: document Analyzer method
 signatures
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Stefan Hajnoczi <stefanha@redhat.com>

Users can inherit from the simpletrace.Analyzer class and receive
callbacks when events of interest occur in a trace file.  The method
signature is a little magic because the timestamp and pid arguments are
optional.  Document this.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 scripts/simpletrace.py | 23 ++++++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/scripts/simpletrace.py b/scripts/simpletrace.py
index 4c99004..d60b3a0 100755
--- a/scripts/simpletrace.py
+++ b/scripts/simpletrace.py
@@ -116,7 +116,28 @@ class Analyzer(object):
     is invoked.
 
     If a method matching a trace event name exists, it is invoked to process
-    that trace record.  Otherwise the catchall() method is invoked."""
+    that trace record.  Otherwise the catchall() method is invoked.
+
+    Example:
+    The following method handles the runstate_set(int new_state) trace event::
+
+      def runstate_set(self, new_state):
+          ...
+
+    The method can also take a timestamp argument before the trace event
+    arguments::
+
+      def runstate_set(self, timestamp, new_state):
+          ...
+
+    Timestamps have the uint64_t type and are in nanoseconds.
+
+    The pid can be included in addition to the timestamp and is useful when
+    dealing with traces from multiple processes::
+
+      def runstate_set(self, timestamp, pid, new_state):
+          ...
+    """
 
     def begin(self):
         """Called at the start of the trace."""
-- 
2.9.3

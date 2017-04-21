Received: from eggs.gnu.org ([2001:4830:134:3::10]:45478)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1d1VG7-0005t0-ME
	for qemu-devel@nongnu.org; Fri, 21 Apr 2017 05:53:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1d1VG6-0002Wf-D7
	for qemu-devel@nongnu.org; Fri, 21 Apr 2017 05:53:47 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42688)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1d1VG6-0002WQ-6O
	for qemu-devel@nongnu.org; Fri, 21 Apr 2017 05:53:46 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Fri, 21 Apr 2017 10:53:34 +0100
Message-Id: <20170421095334.26692-4-stefanha@redhat.com>
In-Reply-To: <20170421095334.26692-1-stefanha@redhat.com>
References: <20170421095334.26692-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL for-2.9 3/3] simpletrace: document Analyzer
 method signatures
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Stefan Hajnoczi <stefanha@redhat.com>

Users can inherit from the simpletrace.Analyzer class and receive
callbacks when events of interest occur in a trace file.  The method
signature is a little magic because the timestamp and pid arguments are
optional.  Document this.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
Message-id: 20170411095654.18383-1-stefanha@redhat.com
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
=20
     If a method matching a trace event name exists, it is invoked to pro=
cess
-    that trace record.  Otherwise the catchall() method is invoked."""
+    that trace record.  Otherwise the catchall() method is invoked.
+
+    Example:
+    The following method handles the runstate_set(int new_state) trace e=
vent::
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
+    The pid can be included in addition to the timestamp and is useful w=
hen
+    dealing with traces from multiple processes::
+
+      def runstate_set(self, timestamp, pid, new_state):
+          ...
+    """
=20
     def begin(self):
         """Called at the start of the trace."""
--=20
2.9.3

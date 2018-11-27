Received: from eggs.gnu.org ([2001:4830:134:3::10]:59369)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ldewey@suse.com>) id 1gRijX-0007Tk-09
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 14:09:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ldewey@suse.com>) id 1gRijS-0008En-1n
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 14:09:18 -0500
Received: from inet-orm.provo.novell.com ([137.65.248.124]:37803
	helo=mail.novell.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ldewey@suse.com>) id 1gRijR-0008D4-So
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 14:09:14 -0500
From: Larry Dewey <ldewey@suse.com>
Date: Tue, 27 Nov 2018 12:08:49 -0700
Message-Id: <20181127190849.10558-1-ldewey@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH] trace: simple style changes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com, Larry Dewey <ldewey@suse.com>

This changes two lines in simple.c that end with a comma, and replaces them
with a semi-colon.

Signed-off-by: Larry Dewey <ldewey@suse.com>
---
 trace/simple.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/trace/simple.c b/trace/simple.c
index 701dec639c..ac904eca91 100644
--- a/trace/simple.c
+++ b/trace/simple.c
@@ -169,9 +169,9 @@ static gpointer writeout_thread(gpointer opaque)
         wait_for_trace_records_available();
 
         if (g_atomic_int_get(&dropped_events)) {
-            dropped.rec.event = DROPPED_EVENT_ID,
+            dropped.rec.event = DROPPED_EVENT_ID;
             dropped.rec.timestamp_ns = get_clock();
-            dropped.rec.length = sizeof(TraceRecord) + sizeof(uint64_t),
+            dropped.rec.length = sizeof(TraceRecord) + sizeof(uint64_t);
             dropped.rec.pid = trace_pid;
             do {
                 dropped_count = g_atomic_int_get(&dropped_events);
-- 
2.19.1

Received: from eggs.gnu.org ([2001:4830:134:3::10]:45145)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistai@xilinx.com>) id 1dQ0Pn-0004Jd-4i
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 20:01:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistai@xilinx.com>) id 1dQ0Ph-0003gV-4r
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 20:01:02 -0400
From: Alistair Francis <alistair.francis@xilinx.com>
Date: Tue, 27 Jun 2017 16:57:46 -0700
Message-ID: <2c339ec0264c85f9c8a4884ffb8ebe059b3b9e4b.1498607452.git.alistair.francis@xilinx.com>
In-Reply-To: <cover.1498607452.git.alistair.francis@xilinx.com>
References: <cover.1498607452.git.alistair.francis@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [RFC v1 3/4] util/oslib-win32: Fix up if conditional
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, stefanha@redhat.com, famz@redhat.com
Cc: alistair.francis@xilinx.com, alistair23@gmail.com, edgar.iglesias@xilinx.com, qemu-block@nongnu.org

Signed-off-by: Alistair Francis <alistair.francis@xilinx.com>
Acked-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
---

 util/oslib-win32.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/util/oslib-win32.c b/util/oslib-win32.c
index 7ec0f8e083..a015e1ac96 100644
--- a/util/oslib-win32.c
+++ b/util/oslib-win32.c
@@ -438,7 +438,7 @@ static int poll_rest(gboolean poll_msgs, HANDLE *handles, gint nhandles,
         if (timeout == 0 && nhandles > 1) {
             /* Remove the handle that fired */
             int i;
-            if (ready < nhandles - 1) {
+            if ((ready - WAIT_OBJECT_0) < nhandles - 1) {
                 for (i = ready - WAIT_OBJECT_0 + 1; i < nhandles; i++) {
                     handles[i-1] = handles[i];
                 }
-- 
2.11.0

Received: from eggs.gnu.org ([2001:4830:134:3::10]:58015)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistai@xilinx.com>) id 1dTccF-0008OI-6g
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 19:24:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistai@xilinx.com>) id 1dTccA-0005ib-Uh
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 19:24:51 -0400
Received: from mail-co1nam03on0051.outbound.protection.outlook.com
	([104.47.40.51]:35200
	helo=NAM03-CO1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alistai@xilinx.com>) id 1dTccA-0005hq-H7
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 19:24:46 -0400
From: Alistair Francis <alistair.francis@xilinx.com>
Date: Fri, 7 Jul 2017 16:21:29 -0700
Message-ID: <ba517a52c280fdd1768d2a16deeb5a5745dc99c3.1499453788.git.alistair.francis@xilinx.com>
In-Reply-To: <cover.1499453787.git.alistair.francis@xilinx.com>
References: <cover.1499453787.git.alistair.francis@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v2 8/8] error: Add a 'error: ' prefix to
 error_report()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: alistair.francis@xilinx.com, alistair23@gmail.com, philippe@mathieu-daude.net, berrange@redhat.com, armbru@redhat.com

As we don't regard error messages as a stable API the let's add a
'error: ' prefix to the original error_report() messages.

Signed-off-by: Alistair Francis <alistair.francis@xilinx.com>
---

 util/qemu-error.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/util/qemu-error.c b/util/qemu-error.c
index b555247e24..cf1eb8e8b9 100644
--- a/util/qemu-error.c
+++ b/util/qemu-error.c
@@ -202,6 +202,7 @@ static void vreport(report_type type, const char *fmt, va_list ap)
 
     switch (type) {
     case REPORT_TYPE_ERROR:
+        error_printf("error: ");
         break;
     case REPORT_TYPE_WARNING:
         error_printf("warning: ");
-- 
2.11.0

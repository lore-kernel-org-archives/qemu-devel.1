Received: from eggs.gnu.org ([2001:4830:134:3::10]:53999)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistai@xilinx.com>) id 1dUu0M-0004l4-A2
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 08:11:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistai@xilinx.com>) id 1dUu0J-0006OP-5K
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 08:11:02 -0400
Received: from mail-by2nam03on0041.outbound.protection.outlook.com
	([104.47.42.41]:59253
	helo=NAM03-BY2-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alistai@xilinx.com>) id 1dUu0I-0006Lr-Nt
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 08:10:59 -0400
From: Alistair Francis <alistair.francis@xilinx.com>
Date: Tue, 11 Jul 2017 05:07:42 -0700
Message-ID: <12e6dde67e57a0ecf09fbe6103512543113ca07a.1499774331.git.alistair.francis@xilinx.com>
In-Reply-To: <cover.1499774331.git.alistair.francis@xilinx.com>
References: <cover.1499774331.git.alistair.francis@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v3 8/8] error: Add a 'error: ' prefix to
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
index c557c6ae47..3a3372b68b 100644
--- a/util/qemu-error.c
+++ b/util/qemu-error.c
@@ -203,6 +203,7 @@ static void vreport(report_type type, const char *fmt, va_list ap)
 
     switch (type) {
     case REPORT_TYPE_ERROR:
+        error_printf("error: ");
         break;
     case REPORT_TYPE_WARNING:
         error_printf("warning: ");
-- 
2.11.0

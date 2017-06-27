Received: from eggs.gnu.org ([2001:4830:134:3::10]:34571)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistai@xilinx.com>) id 1dPxPy-0002Eq-L4
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 16:49:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistai@xilinx.com>) id 1dPxPv-00038t-JN
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 16:49:02 -0400
Received: from mail-cys01nam02on0058.outbound.protection.outlook.com
	([104.47.37.58]:61023
	helo=NAM02-CY1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alistai@xilinx.com>) id 1dPxPv-00038I-8h
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 16:48:59 -0400
From: Alistair Francis <alistair.francis@xilinx.com>
Date: Tue, 27 Jun 2017 13:45:43 -0700
Message-ID: <c0a2b62c80ddf46f99885b43215899a51a81ebc3.1498596157.git.alistair.francis@xilinx.com>
In-Reply-To: <cover.1498596157.git.alistair.francis@xilinx.com>
References: <cover.1498596157.git.alistair.francis@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [RFC v1 1/3] util/qemu-error: Rename error_print_loc()
 to be more generic
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, armbru@redhat.com
Cc: alistair.francis@xilinx.com, alistair23@gmail.com

Rename the error_print_loc() function in preperation for using it to
print warnings as well.

Signed-off-by: Alistair Francis <alistair.francis@xilinx.com>
---

 util/qemu-error.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/util/qemu-error.c b/util/qemu-error.c
index b331f8f4a4..1c5e35ecdb 100644
--- a/util/qemu-error.c
+++ b/util/qemu-error.c
@@ -146,7 +146,7 @@ const char *error_get_progname(void)
 /*
  * Print current location to current monitor if we have one, else to stderr.
  */
-static void error_print_loc(void)
+static void print_loc(void)
 {
     const char *sep = "";
     int i;
@@ -197,7 +197,7 @@ void error_vreport(const char *fmt, va_list ap)
         g_free(timestr);
     }
 
-    error_print_loc();
+    print_loc();
     error_vprintf(fmt, ap);
     error_printf("\n");
 }
-- 
2.11.0

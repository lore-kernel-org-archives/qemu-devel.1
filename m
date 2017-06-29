Received: from eggs.gnu.org ([2001:4830:134:3::10]:58849)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistai@xilinx.com>) id 1dQfNr-0005H7-IN
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 15:45:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistai@xilinx.com>) id 1dQfNo-0007S1-Bn
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 15:45:47 -0400
Received: from mail-sn1nam02on0072.outbound.protection.outlook.com
	([104.47.36.72]:7200
	helo=NAM02-SN1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alistai@xilinx.com>) id 1dQfNn-0007Rm-Ra
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 15:45:44 -0400
From: Alistair Francis <alistair.francis@xilinx.com>
Date: Thu, 29 Jun 2017 12:42:36 -0700
Message-ID: <f8e3b1948488bb5af26d64138d8f2a7217858a62.1498761179.git.alistair.francis@xilinx.com>
In-Reply-To: <cover.1498761179.git.alistair.francis@xilinx.com>
References: <cover.1498761179.git.alistair.francis@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [RFC v2 1/3] util/qemu-error: Rename error_print_loc()
 to be more generic
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: alistair.francis@xilinx.com, alistair23@gmail.com, philippe@mathieu-daude.net, berrange@redhat.com

Rename the error_print_loc() function in preparation for using it to
print warnings as well.

Signed-off-by: Alistair Francis <alistair.francis@xilinx.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
---

 util/qemu-error.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/util/qemu-error.c b/util/qemu-error.c
index b331f8f4a4..1c5e35ecdb 100644
--- a/util/qemu-error.c
+++ b/util/qemu-error.c
@@ -146,7 +146,7 @@ const char *error_get_progname(void)
 /*
  * Print current location to current monitor if we have one, else to stder=
r.
  */
-static void error_print_loc(void)
+static void print_loc(void)
 {
     const char *sep =3D "";
     int i;
@@ -197,7 +197,7 @@ void error_vreport(const char *fmt, va_list ap)
         g_free(timestr);
     }
=20
-    error_print_loc();
+    print_loc();
     error_vprintf(fmt, ap);
     error_printf("\n");
 }
--=20
2.11.0

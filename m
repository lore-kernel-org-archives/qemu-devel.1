Received: from eggs.gnu.org ([2001:4830:134:3::10]:59086)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dVeA0-0008V2-3E
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 09:28:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dVe9v-0001Jl-JT
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 09:28:04 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55970)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dVe9v-0001JN-Cy
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 09:27:59 -0400
From: Markus Armbruster <armbru@redhat.com>
Date: Thu, 13 Jul 2017 15:27:51 +0200
Message-Id: <1499952476-3454-5-git-send-email-armbru@redhat.com>
In-Reply-To: <1499952476-3454-1-git-send-email-armbru@redhat.com>
References: <1499952476-3454-1-git-send-email-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 4/9] util/qemu-error: Rename error_print_loc()
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
Cc: Alistair Francis <alistair.francis@xilinx.com>

From: Alistair Francis <alistair.francis@xilinx.com>

Rename the error_print_loc() function in preparation for using it to
print warnings as well.

Signed-off-by: Alistair Francis <alistair.francis@xilinx.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-Id: <661b215695db878a0aef8401b506fb3da50e981a.1499866456.git.alis=
tair.francis@xilinx.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 util/qemu-error.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/util/qemu-error.c b/util/qemu-error.c
index b331f8f..1c5e35e 100644
--- a/util/qemu-error.c
+++ b/util/qemu-error.c
@@ -146,7 +146,7 @@ const char *error_get_progname(void)
 /*
  * Print current location to current monitor if we have one, else to std=
err.
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
2.7.5

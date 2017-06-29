Received: from eggs.gnu.org ([2001:4830:134:3::10]:52088)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistai@xilinx.com>) id 1dQd6g-0003of-Rq
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 13:19:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistai@xilinx.com>) id 1dQd6f-0000BV-UW
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 13:19:54 -0400
From: Alistair Francis <alistair.francis@xilinx.com>
Date: Thu, 29 Jun 2017 10:16:32 -0700
Message-ID: <199bd37fe51c4b240da9834673c065ea042b9897.1498756113.git.alistair.francis@xilinx.com>
In-Reply-To: <cover.1498756113.git.alistair.francis@xilinx.com>
References: <cover.1498756113.git.alistair.francis@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v1 2/3] util/oslib-win32: Remove invalid check
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, stefanha@redhat.com, famz@redhat.com
Cc: alistair.francis@xilinx.com, alistair23@gmail.com, edgar.iglesias@xilinx.com, qemu-block@nongnu.org, philippe@mathieu-daude.net, pbonzini@redhat.com

There is no way nhandles can be zero in this section so that part of the
if statement will always be false. Let's just remove it to make the code
easier to read.

Signed-off-by: Alistair Francis <alistair.francis@xilinx.com>
Acked-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Reviewed-by: Fam Zheng <famz@redhat.com>
---

 util/oslib-win32.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/util/oslib-win32.c b/util/oslib-win32.c
index 80e4668935..7ec0f8e083 100644
--- a/util/oslib-win32.c
+++ b/util/oslib-win32.c
@@ -414,7 +414,7 @@ static int poll_rest(gboolean poll_msgs, HANDLE *handle=
s, gint nhandles,
         /* If we have a timeout, or no handles to poll, be satisfied
          * with just noticing we have messages waiting.
          */
-        if (timeout !=3D 0 || nhandles =3D=3D 0) {
+        if (timeout !=3D 0) {
             return 1;
         }
=20
--=20
2.11.0

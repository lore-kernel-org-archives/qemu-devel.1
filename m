Received: from eggs.gnu.org ([2001:4830:134:3::10]:57716)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <luc.michel@greensocs.com>) id 1gVC1o-0008NO-Oq
	for qemu-devel@nongnu.org; Fri, 07 Dec 2018 04:02:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <luc.michel@greensocs.com>) id 1gVC1j-0005ob-7t
	for qemu-devel@nongnu.org; Fri, 07 Dec 2018 04:02:32 -0500
From: Luc Michel <luc.michel@greensocs.com>
Date: Fri,  7 Dec 2018 10:01:29 +0100
Message-Id: <20181207090135.7651-12-luc.michel@greensocs.com>
In-Reply-To: <20181207090135.7651-1-luc.michel@greensocs.com>
References: <20181207090135.7651-1-luc.michel@greensocs.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v8 11/16] gdbstub: add support for extended
 mode packet
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Luc Michel <luc.michel@greensocs.com>, qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, saipava@xilinx.com, edgari@xilinx.com, alistair@alistair23.me, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, mark.burton@greensocs.com, Eduardo Habkost <ehabkost@redhat.com>

Add support for the '!' extended mode packet. This is required for the
multiprocess extension.

Signed-off-by: Luc Michel <luc.michel@greensocs.com>
Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
Acked-by: Alistair Francis <alistair.francis@wdc.com>
---
 gdbstub.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/gdbstub.c b/gdbstub.c
index 48c2571ebe..1cf1bea428 100644
--- a/gdbstub.c
+++ b/gdbstub.c
@@ -1301,10 +1301,13 @@ static int gdb_handle_packet(GDBState *s, const c=
har *line_buf)
     trace_gdbstub_io_command(line_buf);
=20
     p =3D line_buf;
     ch =3D *p++;
     switch(ch) {
+    case '!':
+        put_packet(s, "OK");
+        break;
     case '?':
         /* TODO: Make this return the correct value for user-mode.  */
         snprintf(buf, sizeof(buf), "T%02xthread:%s;", GDB_SIGNAL_TRAP,
                  gdb_fmt_thread_id(s, s->c_cpu, thread_id, sizeof(thread=
_id)));
         put_packet(s, buf);
--=20
2.19.2

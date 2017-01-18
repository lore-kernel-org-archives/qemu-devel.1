Received: from eggs.gnu.org ([2001:4830:134:3::10]:36986)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <skiver.cloud.yzy@gmail.com>) id 1cTlDy-0004RQ-9h
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 03:04:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <skiver.cloud.yzy@gmail.com>) id 1cTlDv-0004iX-2f
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 03:04:06 -0500
From: Ziyue Yang <skiver.cloud.yzy@gmail.com>
Date: Wed, 18 Jan 2017 16:03:29 +0800
Message-Id: <1484726609-16537-1-git-send-email-skiver.cloud.yzy@gmail.com>
Subject: [Qemu-devel] [PATCH v5 2/2] gdbstub.c: update old error report
 statements
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-trivial@nongnu.org
Cc: Fam Zheng <famz@redhat.com>, Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Anthony Liguori <aliguori@us.ibm.com>, Ziyue Yang <yzylivezh@hotmail.com>, Ziyue Yang <skiver.cloud.yzy@gmail.com>

From: Ziyue Yang <yzylivezh@hotmail.com>

Some updates from fprintf(stderr, ...) to error_report.

Signed-off-by: Ziyue Yang <skiver.cloud.yzy@gmail.com>
---
 gdbstub.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/gdbstub.c b/gdbstub.c
index 426d55e..959f6dc 100644
--- a/gdbstub.c
+++ b/gdbstub.c
@@ -637,8 +637,8 @@ void gdb_register_coprocessor(CPUState *cpu,
     *p = s;
     if (g_pos) {
         if (g_pos != s->base_reg) {
-            fprintf(stderr, "Error: Bad gdb register numbering for '%s'\n"
-                    "Expected %d got %d\n", xml, g_pos, s->base_reg);
+            error_report("Error: Bad gdb register numbering for '%s', "
+                         "expected %d got %d", xml, g_pos, s->base_reg);
         } else {
             cpu->gdb_num_g_regs = cpu->gdb_num_regs;
         }
@@ -890,7 +890,7 @@ static int gdb_handle_packet(GDBState *s, const char *line_buf)
         }
     case 'k':
         /* Kill the target */
-        fprintf(stderr, "\nQEMU: Terminated via GDBstub\n");
+        error_report("QEMU: Terminated via GDBstub");
         exit(0);
     case 'D':
         /* Detach packet */
@@ -1358,8 +1358,8 @@ void gdb_do_syscallv(gdb_syscall_complete_cb cb, const char *fmt, va_list va)
                 break;
             default:
             bad_format:
-                fprintf(stderr, "gdbstub: Bad syscall format string '%s'\n",
-                        fmt - 1);
+                error_report("gdbstub: Bad syscall format string '%s'",
+                             fmt - 1);
                 break;
             }
         } else {
--
2.7.4

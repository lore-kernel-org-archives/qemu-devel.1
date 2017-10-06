Received: from eggs.gnu.org ([2001:4830:134:3::10]:43781)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1e0cSV-0002Tn-1i
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 19:55:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1e0cSU-00088w-Do
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 19:55:11 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Fri,  6 Oct 2017 20:50:13 -0300
Message-Id: <20171006235023.11952-79-f4bug@amsat.org>
In-Reply-To: <20171006235023.11952-1-f4bug@amsat.org>
References: <20171006235023.11952-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 78/88] gdb: use g_new() family of functions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@gmail.com>, Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, qemu trival <qemu-trivial@nongnu.org>

From: Marc-André Lureau <marcandre.lureau@redhat.com>

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 gdbstub.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/gdbstub.c b/gdbstub.c
index 2a94030d3b..5f0d8af1c0 100644
--- a/gdbstub.c
+++ b/gdbstub.c
@@ -1786,7 +1786,7 @@ static void gdb_accept(void)
     /* set short latency */
     socket_set_nodelay(fd);
 
-    s = g_malloc0(sizeof(GDBState));
+    s = g_new0(GDBState, 1);
     s->c_cpu = first_cpu;
     s->g_cpu = first_cpu;
     s->fd = fd;
@@ -1980,7 +1980,7 @@ int gdbserver_start(const char *device)
 
     s = gdbserver_state;
     if (!s) {
-        s = g_malloc0(sizeof(GDBState));
+        s = g_new0(GDBState, 1);
         gdbserver_state = s;
 
         qemu_add_vm_change_state_handler(gdb_vm_state_change, NULL);
-- 
2.14.2

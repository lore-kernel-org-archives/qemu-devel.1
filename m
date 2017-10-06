Received: from eggs.gnu.org ([2001:4830:134:3::10]:43028)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1e0cRe-0001Wv-TG
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 19:54:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1e0cRe-0007Jt-6K
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 19:54:18 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Fri,  6 Oct 2017 20:49:59 -0300
Message-Id: <20171006235023.11952-65-f4bug@amsat.org>
In-Reply-To: <20171006235023.11952-1-f4bug@amsat.org>
References: <20171006235023.11952-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 64/88] user: use g_strfreev()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@gmail.com>, Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>, Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, qemu trival <qemu-trivial@nongnu.org>

From: Marc-André Lureau <marcandre.lureau@redhat.com>

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 bsd-user/main.c   | 6 +-----
 linux-user/main.c | 6 +-----
 2 files changed, 2 insertions(+), 10 deletions(-)

diff --git a/bsd-user/main.c b/bsd-user/main.c
index 836daac15c..fb0a4e48cb 100644
--- a/bsd-user/main.c
+++ b/bsd-user/main.c
@@ -947,11 +947,7 @@ int main(int argc, char **argv)
         _exit(1);
     }
 
-    for (wrk = target_environ; *wrk; wrk++) {
-        g_free(*wrk);
-    }
-
-    g_free(target_environ);
+    g_strfreev(target_environ);
 
     if (qemu_loglevel_mask(CPU_LOG_PAGE)) {
         qemu_log("guest_base  0x%lx\n", guest_base);
diff --git a/linux-user/main.c b/linux-user/main.c
index 829f974662..f1e799f570 100644
--- a/linux-user/main.c
+++ b/linux-user/main.c
@@ -4426,11 +4426,7 @@ int main(int argc, char **argv, char **envp)
         _exit(EXIT_FAILURE);
     }
 
-    for (wrk = target_environ; *wrk; wrk++) {
-        g_free(*wrk);
-    }
-
-    g_free(target_environ);
+    g_strfreev(target_environ);
 
     if (qemu_loglevel_mask(CPU_LOG_PAGE)) {
         qemu_log("guest_base  0x%lx\n", guest_base);
-- 
2.14.2

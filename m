Received: from eggs.gnu.org ([2001:4830:134:3::10]:40752)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1e0cOe-00078l-50
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 19:51:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1e0cOd-0004xZ-FF
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 19:51:12 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Fri,  6 Oct 2017 20:49:06 -0300
Message-Id: <20171006235023.11952-12-f4bug@amsat.org>
In-Reply-To: <20171006235023.11952-1-f4bug@amsat.org>
References: <20171006235023.11952-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 11/88] Cryptodev Backends: use g_new() family
 of functions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@gmail.com>, Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>, Gonglei <arei.gonglei@huawei.com>
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, qemu trival <qemu-trivial@nongnu.org>

From: Marc-André Lureau <marcandre.lureau@redhat.com>

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 backends/cryptodev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/backends/cryptodev.c b/backends/cryptodev.c
index 67edfa5328..44f693f58b 100644
--- a/backends/cryptodev.c
+++ b/backends/cryptodev.c
@@ -42,7 +42,7 @@ cryptodev_backend_new_client(const char *model,
 {
     CryptoDevBackendClient *cc;
 
-    cc = g_malloc0(sizeof(CryptoDevBackendClient));
+    cc = g_new0(CryptoDevBackendClient, 1);
     cc->model = g_strdup(model);
     if (name) {
         cc->name = g_strdup(name);
-- 
2.14.2

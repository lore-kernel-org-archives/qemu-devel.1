Received: from eggs.gnu.org ([2001:4830:134:3::10]:60779)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dXLtA-0002Ka-8a
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 02:21:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dXLt9-0001js-Jm
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 02:21:44 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Tue, 18 Jul 2017 03:10:01 -0300
Message-Id: <20170718061005.29518-26-f4bug@amsat.org>
In-Reply-To: <20170718061005.29518-1-f4bug@amsat.org>
References: <20170718061005.29518-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 25/29] libqos: use ARRAY_SIZE macro
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-trivial@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Stefan Hajnoczi <stefanha@redhat.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Laurent Vivier <lvivier@redhat.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, Eric Blake <eblake@redhat.com>

Applied using the Coccinelle semantic patch scripts/coccinelle/use_osdep.cocci

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---

No entry in MAINTAINERS for tests/libqos/* does it deserve it's own entry?

 tests/libqos/libqos.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/libqos/libqos.c b/tests/libqos/libqos.c
index 6226546c28..0edb7e99ba 100644
--- a/tests/libqos/libqos.c
+++ b/tests/libqos/libqos.c
@@ -258,7 +258,7 @@ void generate_pattern(void *buffer, size_t len, size_t cycle_len)
     p = rand() % 256;
     for (i = 0; i < len; i++) {
         tx[i] = p++ % 256;
-        if (i % cycle_len == 0) {
+        if (QEMU_IS_ALIGNED(i, cycle_len)) {
             p = rand() % 256;
         }
     }
-- 
2.13.2

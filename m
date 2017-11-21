Received: from eggs.gnu.org ([2001:4830:134:3::10]:42634)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eGz9U-0008DA-11
	for qemu-devel@nongnu.org; Mon, 20 Nov 2017 22:23:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eGz9Q-0008Vv-Rz
	for qemu-devel@nongnu.org; Mon, 20 Nov 2017 22:23:12 -0500
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Tue, 21 Nov 2017 00:22:47 -0300
Message-Id: <20171121032247.14579-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH for-2.11] Makefile: add more targets to the
 UNCHECKED_GOALS rule
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, "Daniel P . Berrange" <berrange@redhat.com>, Fam Zheng <famz@redhat.com>, Eric Blake <eblake@redhat.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, qemu-trivial@nongnu.org, Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

These targets don't need a full build of git submodules.
(See b8e535ae8af and eaa2ddbb767).

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 Makefile | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index adda3fb63e..5e8d79618c 100644
--- a/Makefile
+++ b/Makefile
@@ -6,7 +6,10 @@ BUILD_DIR=$(CURDIR)
 # Before including a proper config-host.mak, assume we are in the source tree
 SRC_PATH=.
 
-UNCHECKED_GOALS := %clean TAGS cscope ctags docker docker-% help
+UNCHECKED_GOALS := %clean TAGS cscope ctags dist \
+    html info pdf txt \
+    help check-help \
+    docker docker-% vm-test vm-build-%
 
 # All following code might depend on configuration variables
 ifneq ($(wildcard config-host.mak),)
-- 
2.15.0

Received: from eggs.gnu.org ([2001:4830:134:3::10]:49498)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1cqnC5-0003xl-Bi
	for qemu-devel@nongnu.org; Wed, 22 Mar 2017 16:49:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1cqnC4-0000Wh-EX
	for qemu-devel@nongnu.org; Wed, 22 Mar 2017 16:49:21 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Wed, 22 Mar 2017 17:48:43 -0300
Message-Id: <20170322204844.446-3-f4bug@amsat.org>
In-Reply-To: <20170322204844.446-1-f4bug@amsat.org>
References: <20170322204844.446-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH RESEND 2/3] device_tree: fix compiler warnings
 (clang 5)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Roth <mdroth@linux.vnet.ibm.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Alexander Graf <agraf@suse.de>, Gerd Hoffmann <kraxel@redhat.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, qemu-trivial@nongnu.org

static code analyzer complain:

device_tree.c:155:18: warning: Null pointer passed as an argument to a 'nonnull' parameter
    while ((de = readdir(d)) != NULL) {
                 ^~~~~~~~~~

Reported-by: Clang Static Analyzer
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 device_tree.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/device_tree.c b/device_tree.c
index 6e06320830..a24ddff02b 100644
--- a/device_tree.c
+++ b/device_tree.c
@@ -148,6 +148,7 @@ static void read_fstree(void *fdt, const char *dirname)
     d = opendir(dirname);
     if (!d) {
         error_setg(&error_fatal, "%s cannot open %s", __func__, dirname);
+        return;
     }
 
     while ((de = readdir(d)) != NULL) {
-- 
2.11.0

Received: from eggs.gnu.org ([2001:4830:134:3::10]:38945)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fOmti-0002Xv-B8
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 12:27:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fOmth-0007Vj-5P
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 12:27:26 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:60132 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1fOmth-0007VP-0J
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 12:27:25 -0400
Date: Fri, 1 Jun 2018 19:27:23 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20180601162620.32362-26-mst@redhat.com>
References: <20180601162620.32362-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180601162620.32362-1-mst@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 25/31] qga: use local path for local headers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, Michael Roth <mdroth@linux.vnet.ibm.com>

When pulling in headers that are in the same directory as the C file (as
opposed to one in include/), we should use its relative path, without a
directory.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
---
 qga/channel-posix.c             | 2 +-
 qga/channel-win32.c             | 4 ++--
 qga/commands-posix.c            | 2 +-
 qga/commands-win32.c            | 4 ++--
 qga/commands.c                  | 2 +-
 qga/guest-agent-command-state.c | 2 +-
 qga/main.c                      | 4 ++--
 qga/vss-win32.c                 | 6 +++---
 8 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/qga/channel-posix.c b/qga/channel-posix.c
index b812bf4d51..5a925a9818 100644
--- a/qga/channel-posix.c
+++ b/qga/channel-posix.c
@@ -2,7 +2,7 @@
 #include <termios.h>
 #include "qapi/error.h"
 #include "qemu/sockets.h"
-#include "qga/channel.h"
+#include "channel.h"
=20
 #ifdef CONFIG_SOLARIS
 #include <stropts.h>
diff --git a/qga/channel-win32.c b/qga/channel-win32.c
index 7e6dc4d26f..b3597a8a0f 100644
--- a/qga/channel-win32.c
+++ b/qga/channel-win32.c
@@ -1,8 +1,8 @@
 #include "qemu/osdep.h"
 #include <windows.h>
 #include <io.h>
-#include "qga/guest-agent-core.h"
-#include "qga/channel.h"
+#include "guest-agent-core.h"
+#include "channel.h"
=20
 typedef struct GAChannelReadState {
     guint thread_id;
diff --git a/qga/commands-posix.c b/qga/commands-posix.c
index 0dc219dbcf..eae817191b 100644
--- a/qga/commands-posix.c
+++ b/qga/commands-posix.c
@@ -16,7 +16,7 @@
 #include <sys/utsname.h>
 #include <sys/wait.h>
 #include <dirent.h>
-#include "qga/guest-agent-core.h"
+#include "guest-agent-core.h"
 #include "qga-qapi-commands.h"
 #include "qapi/error.h"
 #include "qapi/qmp/qerror.h"
diff --git a/qga/commands-win32.c b/qga/commands-win32.c
index 2d48394748..70ee5379f6 100644
--- a/qga/commands-win32.c
+++ b/qga/commands-win32.c
@@ -32,8 +32,8 @@
 #include <wtsapi32.h>
 #include <wininet.h>
=20
-#include "qga/guest-agent-core.h"
-#include "qga/vss-win32.h"
+#include "guest-agent-core.h"
+#include "vss-win32.h"
 #include "qga-qapi-commands.h"
 #include "qapi/error.h"
 #include "qapi/qmp/qerror.h"
diff --git a/qga/commands.c b/qga/commands.c
index a64b34ccab..cce3010f0f 100644
--- a/qga/commands.c
+++ b/qga/commands.c
@@ -11,7 +11,7 @@
  */
=20
 #include "qemu/osdep.h"
-#include "qga/guest-agent-core.h"
+#include "guest-agent-core.h"
 #include "qga-qapi-commands.h"
 #include "qapi/error.h"
 #include "qapi/qmp/qerror.h"
diff --git a/qga/guest-agent-command-state.c b/qga/guest-agent-command-st=
ate.c
index e609d320f0..18bcb5941d 100644
--- a/qga/guest-agent-command-state.c
+++ b/qga/guest-agent-command-state.c
@@ -10,7 +10,7 @@
  * See the COPYING file in the top-level directory.
  */
 #include "qemu/osdep.h"
-#include "qga/guest-agent-core.h"
+#include "guest-agent-core.h"
=20
 struct GACommandState {
     GSList *groups;
diff --git a/qga/main.c b/qga/main.c
index 1e1cec708f..ea7540edcc 100644
--- a/qga/main.c
+++ b/qga/main.c
@@ -23,12 +23,12 @@
 #include "qapi/qmp/qdict.h"
 #include "qapi/qmp/qjson.h"
 #include "qapi/qmp/qstring.h"
-#include "qga/guest-agent-core.h"
+#include "guest-agent-core.h"
 #include "qemu/module.h"
 #include "qga-qapi-commands.h"
 #include "qapi/qmp/qerror.h"
 #include "qapi/error.h"
-#include "qga/channel.h"
+#include "channel.h"
 #include "qemu/bswap.h"
 #include "qemu/help_option.h"
 #include "qemu/sockets.h"
diff --git a/qga/vss-win32.c b/qga/vss-win32.c
index 0199c2a792..a541f3ae01 100644
--- a/qga/vss-win32.c
+++ b/qga/vss-win32.c
@@ -14,9 +14,9 @@
 #include <windows.h>
 #include "qapi/error.h"
 #include "qemu/error-report.h"
-#include "qga/guest-agent-core.h"
-#include "qga/vss-win32.h"
-#include "qga/vss-win32/requester.h"
+#include "guest-agent-core.h"
+#include "vss-win32.h"
+#include "vss-win32/requester.h"
=20
 #define QGA_VSS_DLL "qga-vss.dll"
=20
--=20
MST

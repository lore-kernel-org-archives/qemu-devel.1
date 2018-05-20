Received: from eggs.gnu.org ([2001:4830:134:3::10]:40472)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1fKGuX-0004AU-2Q
	for qemu-devel@nongnu.org; Sun, 20 May 2018 01:29:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1fKGuS-0005Ah-Uf
	for qemu-devel@nongnu.org; Sun, 20 May 2018 01:29:36 -0400
From: Michael Tokarev <mjt@tls.msk.ru>
Date: Sun, 20 May 2018 08:29:27 +0300
Message-Id: <20180520052927.3479-1-mjt@msgid.tls.msk.ru>
Subject: [Qemu-devel] [PATCH] qemu-option-trace: -trace enable= is a pattern,
 not a file
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>

Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
---
 qemu-option-trace.texi | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/qemu-option-trace.texi b/qemu-option-trace.texi
index 4166d5cdc2..7d1b7f05c5 100644
--- a/qemu-option-trace.texi
+++ b/qemu-option-trace.texi
@@ -2,9 +2,8 @@ Specify tracing options.
 
 @table @option
 @item [enable=]@var{pattern}
-Immediately enable events matching @var{pattern}.
-The file must contain one event name (as listed in the @file{trace-events-all}
-file) per line; globbing patterns are accepted too.  This option is only
+Immediately enable events matching @var{pattern}
+(either event name or a globbing pattern).  This option is only
 available if QEMU has been compiled with the @var{simple}, @var{log}
 or @var{ftrace} tracing backend.  To specify multiple events or patterns,
 specify the @option{-trace} option multiple times.
-- 
2.11.0

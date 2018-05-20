Received: from eggs.gnu.org ([2001:4830:134:3::10]:43459)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1fKHck-0001XR-4M
	for qemu-devel@nongnu.org; Sun, 20 May 2018 02:15:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1fKHcg-0005Js-PG
	for qemu-devel@nongnu.org; Sun, 20 May 2018 02:15:18 -0400
From: Michael Tokarev <mjt@tls.msk.ru>
Date: Sun, 20 May 2018 09:14:50 +0300
Message-Id: <0b816e986dd5b39ff5dfacd6c74e012b3b4c09e1.1526796813.git.mjt@msgid.tls.msk.ru>
In-Reply-To: <cover.1526796813.git.mjt@msgid.tls.msk.ru>
References: <cover.1526796813.git.mjt@msgid.tls.msk.ru>
In-Reply-To: <cover.1526796813.git.mjt@msgid.tls.msk.ru>
References: <cover.1526796813.git.mjt@msgid.tls.msk.ru>
Subject: [Qemu-devel] [PULL 04/22] qemu-option-trace: -trace enable= is a
 pattern, not a file
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Michael Tokarev <mjt@tls.msk.ru>, qemu-trivial@nongnu.org

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

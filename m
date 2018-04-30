Received: from eggs.gnu.org ([2001:4830:134:3::10]:52687)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1fD8D4-0004F8-LT
	for qemu-devel@nongnu.org; Mon, 30 Apr 2018 08:47:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1fD8D0-0001a4-JD
	for qemu-devel@nongnu.org; Mon, 30 Apr 2018 08:47:14 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:40308 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1fD8D0-0001Zc-Ds
	for qemu-devel@nongnu.org; Mon, 30 Apr 2018 08:47:10 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Mon, 30 Apr 2018 13:46:51 +0100
Message-Id: <20180430124651.10340-6-stefanha@redhat.com>
In-Reply-To: <20180430124651.10340-1-stefanha@redhat.com>
References: <20180430124651.10340-1-stefanha@redhat.com>
Subject: [Qemu-devel] [PATCH v2 5/5] checkpatch: reduce MAINTAINERS update
 message frequency
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Markus Armbruster <armbru@redhat.com>, Fam Zheng <famz@redhat.com>, Thomas Huth <thuth@redhat.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@gmail.com>

From: Joe Perches <joe@perches.com>

When files are being added/moved/deleted and a patch contains an update to
the MAINTAINERS file, assume it's to update the MAINTAINERS file correctly
and do not emit the "does MAINTAINERS need updating?" message.

Reported by many people.

Signed-off-by: Joe Perches <joe@perches.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
(cherry picked from e0d975b1b439c4fef58fbc306c542c94f48bb849)
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
---
 scripts/checkpatch.pl | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 84bdf53af7..5506502cf4 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -1390,6 +1390,12 @@ sub process {
 			}
 		}
 
+# Check if MAINTAINERS is being updated.  If so, there's probably no need to
+# emit the "does MAINTAINERS need updating?" message on file add/move/delete
+		if ($line =~ /^\s*MAINTAINERS\s*\|/) {
+			$reported_maintainer_file = 1;
+		}
+
 # Check for added, moved or deleted files
 		if (!$reported_maintainer_file && !$in_commit_log &&
 		    ($line =~ /^(?:new|deleted) file mode\s*\d+\s*$/ ||
-- 
2.14.3

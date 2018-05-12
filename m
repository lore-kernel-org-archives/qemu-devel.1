Received: from eggs.gnu.org ([2001:4830:134:3::10]:34905)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1fHQqp-0006NL-89
	for qemu-devel@nongnu.org; Sat, 12 May 2018 05:30:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1fHQqo-0000qQ-Cc
	for qemu-devel@nongnu.org; Sat, 12 May 2018 05:30:03 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Sat, 12 May 2018 10:28:22 +0100
Message-Id: <20180512092824.13848-7-stefanha@redhat.com>
In-Reply-To: <20180512092824.13848-1-stefanha@redhat.com>
References: <20180512092824.13848-1-stefanha@redhat.com>
Subject: [Qemu-devel] [PULL 6/8] checkpatch: reduce MAINTAINERS update
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
Cc: qemu-block@nongnu.org, Peter Maydell <peter.maydell@linaro.org>

From: Joe Perches <joe@perches.com>

When files are being added/moved/deleted and a patch contains an update to
the MAINTAINERS file, assume it's to update the MAINTAINERS file correctly
and do not emit the "does MAINTAINERS need updating?" message.

Reported by many people.

Signed-off-by: Joe Perches <joe@perches.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
Message-id: 20180430124651.10340-6-stefanha@redhat.com
(cherry picked from e0d975b1b439c4fef58fbc306c542c94f48bb849)
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
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
2.17.0

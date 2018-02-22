Received: from eggs.gnu.org ([2001:4830:134:3::10]:38857)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eoyt3-0001LN-MA
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 16:58:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eoysz-0004Pm-Cf
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 16:58:45 -0500
From: Eric Blake <eblake@redhat.com>
Date: Thu, 22 Feb 2018 15:58:38 -0600
Message-Id: <20180222215838.18223-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH] checkpatch: Exempt long URLs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, qemu-trivial@nongnu.org

Sometimes, we want to refer to really long URLs, but checkpatch
balks, and we have to manually bypass the check.  URL shorterners
may be nice at reducing long links, but it's hard to guarantee the
shortened link will live as long as the real target, and it is
also nice to see the original target without having to load the
shortened URL through a browser.  So exempt a line containing
only a URL from the long-line syntax check.

Suggested-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Eric Blake <eblake@redhat.com>
---
 scripts/checkpatch.pl | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 1b4b812e28f..0d3f753c665 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -1447,9 +1447,10 @@ sub process {
 # check we are in a valid source file if not then ignore this hunk
 		next if ($realfile !~ /$SrcFile/);

-#90 column limit
+#90 column limit; exempt URLs, if no other words on line
 		if ($line =~ /^\+/ &&
 		    !($line =~ /^\+\s*"[^"]*"\s*(?:\s*|,|\)\s*;)\s*$/) &&
+		    !($rawline =~ /^[^[:alnum:]]*https?:\S*$/) &&
 		    $length > 80)
 		{
 			if ($length > 90) {
-- 
2.14.3

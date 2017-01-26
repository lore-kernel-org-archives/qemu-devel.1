Received: from eggs.gnu.org ([2001:4830:134:3::10]:58547)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1cWjpe-0006ZH-Jp
	for qemu-devel@nongnu.org; Thu, 26 Jan 2017 08:11:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1cWjpc-0001ZV-FW
	for qemu-devel@nongnu.org; Thu, 26 Jan 2017 08:11:18 -0500
Received: from mx1.redhat.com ([209.132.183.28]:33040)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1cWjpc-0001Z7-9t
	for qemu-devel@nongnu.org; Thu, 26 Jan 2017 08:11:16 -0500
Received: from int-mx13.intmail.prod.int.phx2.redhat.com
	(int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 8DB9F804FE
	for <qemu-devel@nongnu.org>; Thu, 26 Jan 2017 13:11:16 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
Date: Thu, 26 Jan 2017 14:11:05 +0100
Message-Id: <1485436265-12573-6-git-send-email-thuth@redhat.com>
In-Reply-To: <1485436265-12573-1-git-send-email-thuth@redhat.com>
References: <1485436265-12573-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [RFC PATCH 5/5] checkpatch: reduce MAINTAINERS update
 message frequency
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>

This is a port of the following commit from the Linux kernel:

commit e0d975b1b439c4fef58fbc306c542c94f48bb849
Author: Joe Perches <joe@perches.com>
Date:   Wed Dec 10 15:51:49 2014 -0800

    checkpatch: reduce MAINTAINERS update message frequency

    When files are being added/moved/deleted and a patch contains an update to
    the MAINTAINERS file, assume it's to update the MAINTAINERS file correctly
    and do not emit the "does MAINTAINERS need updating?" message.

    Reported by many people.

    Signed-off-by: Joe Perches <joe@perches.com>
    Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
    Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 scripts/checkpatch.pl | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index e1be7b3..555a5b6 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -1300,6 +1300,12 @@ sub process {
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
1.8.3.1

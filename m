Received: from eggs.gnu.org ([2001:4830:134:3::10]:58455)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1cWjpX-0006TN-0U
	for qemu-devel@nongnu.org; Thu, 26 Jan 2017 08:11:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1cWjpU-0001VH-CG
	for qemu-devel@nongnu.org; Thu, 26 Jan 2017 08:11:10 -0500
Received: from mx1.redhat.com ([209.132.183.28]:34228)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1cWjpU-0001V1-6R
	for qemu-devel@nongnu.org; Thu, 26 Jan 2017 08:11:08 -0500
Received: from int-mx13.intmail.prod.int.phx2.redhat.com
	(int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 5CD072E6053
	for <qemu-devel@nongnu.org>; Thu, 26 Jan 2017 13:11:08 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
Date: Thu, 26 Jan 2017 14:11:00 +0100
Message-Id: <1485436265-12573-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [RFC PATCH 0/5] checkpatch: Test bad UTF-8 encodings
 and updates to MAINTAINERS
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>

I recently noticed that the checkpatch.pl script from the Linux kernel
nowadays issues a warning if you try to add, delete or move a file
without updating the MAINTAINERS file in the same turn, too. Since
we are also struggling with keeping the MAINTAINERS file of QEMU up to
date, it might be useful to have this feature in QEMU's checkpatch.pl,
too. So here is a port the upstream patches to our version of checkpatch,
including some patches to check for invalid utf-8 in the commit message
(which were a prerequisite to the MAINTAINERS patches due to the
$in_commit_log variable that is introduced there).

Thomas Huth (5):
  checkpatch: add a check for utf-8 in commit logs
  checkpatch: check utf-8 content from a commit log when it's missing
    from charset
  checkpatch: ignore email headers better
  checkpatch: emit a reminder about MAINTAINERS on file add/move/delete
  checkpatch: reduce MAINTAINERS update message frequency

 scripts/checkpatch.pl | 57 +++++++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 53 insertions(+), 4 deletions(-)

-- 
1.8.3.1

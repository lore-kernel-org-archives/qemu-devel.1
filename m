Received: from eggs.gnu.org ([2001:4830:134:3::10]:32982)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1eQz00-0005rr-5V
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 12:14:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1eQyzz-0003ja-CF
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 12:14:44 -0500
From: Thomas Huth <thuth@redhat.com>
Date: Mon, 18 Dec 2017 18:14:30 +0100
Message-Id: <1513617273-7988-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [PATCH 0/3] block: Deprecated options
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>

Remove the deprecated "-drive boot" and "-hdachs" options and properly
mark some other deprecated options in the deprecation chapter.

Thomas Huth (3):
  block: Remove the obsolete -drive boot=on|off parameter
  block: Remove the deprecated -hdachs option
  block: Mention -drive cyls/heads/secs/trans/serial/addr in deprecation
    chapter

 blockdev.c      | 11 --------
 qemu-doc.texi   | 29 +++++++++----------
 qemu-options.hx | 19 ++-----------
 vl.c            | 86 ++-------------------------------------------------------
 4 files changed, 19 insertions(+), 126 deletions(-)

-- 
1.8.3.1

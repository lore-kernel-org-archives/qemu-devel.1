Received: from eggs.gnu.org ([2001:4830:134:3::10]:37087)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1copOM-0000ku-3g
	for qemu-devel@nongnu.org; Fri, 17 Mar 2017 06:45:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1copOL-0000Is-4D
	for qemu-devel@nongnu.org; Fri, 17 Mar 2017 06:45:54 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Fri, 17 Mar 2017 18:45:38 +0800
Message-Id: <20170317104541.28979-1-stefanha@redhat.com>
Subject: [Qemu-devel] [PATCH v2 0/3] qemu-img: improve qemu-img getopt error
 messages
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, mreitz@redhat.com, Stefan Hajnoczi <stefanha@redhat.com>

v2:
 * Print short help to avoid obscuring error messages [Max]

This series improves getopt error messages.  Unrecognized global options were
skipped rather than causing qemu-img to exit as expected.  Also avoid printing
the full help text because it obscures the actual error message.

Stefan Hajnoczi (3):
  qemu-img: show help for invalid global options
  qemu-img: fix switch indentation in img_amend()
  qemu-img: print short help on getopt failure

 qemu-img.c | 196 ++++++++++++++++++++++++++++++++++++++++++-------------------
 1 file changed, 137 insertions(+), 59 deletions(-)

-- 
2.9.3

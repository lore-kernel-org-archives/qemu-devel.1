Received: from eggs.gnu.org ([2001:4830:134:3::10]:33189)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1df4jH-0005nX-Ry
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 09:39:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1df4jD-0008Ag-0J
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 09:39:27 -0400
From: Jeff Cody <jcody@redhat.com>
Date: Tue,  8 Aug 2017 09:39:01 -0400
Message-Id: <cover.1502198932.git.jcody@redhat.com>
Subject: [Qemu-devel] [PATCH for-2.11 0/7] Code cleanup and minor fixes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, mitake.hitoshi@lab.ntt.co.jp, namei.unix@gmail.com, rjones@redhat.com, kwolf@redhat.com

Some minor cleanup for a few network protocols, with a few bug fixes thrown in.
I don't think there is anything in here that needs to be for 2.10, however.

Jeff Cody (7):
  block/ssh: don't call libssh2_init() in block_init()
  block/ssh: make compliant with coding guidelines
  block/sheepdog: remove spurious NULL check
  block/sheepdog: code beautification
  block/curl: check error return of curl_global_init()
  block/curl: fix minor memory leaks
  block/curl: code cleanup to comply with coding style

 block/curl.c     | 124 +++++++++++++++++++++++------------------
 block/sheepdog.c | 164 +++++++++++++++++++++++++++----------------------------
 block/ssh.c      |  72 +++++++++++++++---------
 3 files changed, 199 insertions(+), 161 deletions(-)

-- 
2.9.4

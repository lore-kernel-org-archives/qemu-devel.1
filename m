Received: from eggs.gnu.org ([2001:4830:134:3::10]:58324)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1dn6Ij-0005SY-0B
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 12:57:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1dn6Ii-0006on-Cz
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 12:57:13 -0400
From: Jeff Cody <jcody@redhat.com>
Date: Wed, 30 Aug 2017 12:56:57 -0400
Message-Id: <cover.1504112061.git.jcody@redhat.com>
Subject: [Qemu-devel] [PATCH v2 0/7] Code cleanup and minor fixes
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

Minor bug fixes and code cleanup.

Changes from v1 -> v2:

Rebased to v2.10.0

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
2.9.5

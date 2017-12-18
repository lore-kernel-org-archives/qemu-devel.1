Received: from eggs.gnu.org ([2001:4830:134:3::10]:41177)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1eQsTm-0006oT-Jc
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 05:17:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1eQsTl-0007bv-Pe
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 05:17:02 -0500
From: "Daniel P. Berrange" <berrange@redhat.com>
Date: Mon, 18 Dec 2017 10:16:41 +0000
Message-Id: <20171218101643.20360-1-berrange@redhat.com>
Subject: [Qemu-devel] [PATCH v2 0/2] Enable full IPv4/IPv6 dual stack for
 NBD server
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Eric Blake <eblake@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, qemu-block@nongnu.org, "Daniel P. Berrange" <berrange@redhat.com>

These patches were previously posted as part of a larger series:

  https://lists.gnu.org/archive/html/qemu-devel/2017-08/msg02064.html

These patches port the NBD server to use QIONetListener, which allows for
easy setup of multiple listening sockets. This enables full support for
IPv4/IPv6 dual stack, by fully honouring all addresses returned from a
DNS lookup.

There has been no change since v1, except for trivial rebase.

Daniel P. Berrange (2):
  blockdev: convert internal NBD server to QIONetListener
  blockdev: convert qemu-nbd server to QIONetListener

 blockdev-nbd.c | 50 +++++++++++++++--------------------------------
 qemu-nbd.c     | 61 +++++++++++++++++++++++-----------------------------------
 2 files changed, 40 insertions(+), 71 deletions(-)

-- 
2.14.3

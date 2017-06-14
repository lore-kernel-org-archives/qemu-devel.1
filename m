Received: from eggs.gnu.org ([2001:4830:134:3::10]:42401)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1dL7ne-0003x6-1L
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 08:53:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1dL7nd-0006GR-BU
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 08:53:30 -0400
From: Jeff Cody <jcody@redhat.com>
Date: Wed, 14 Jun 2017 08:53:18 -0400
Message-Id: <cover.1497444637.git.jcody@redhat.com>
Subject: [Qemu-devel] [PATCH v2 0/2] Parse 'filename' option for RBD/iSCSI
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, kwolf@redhat.com, mreitz@redhat.com, rjones@redhat.com

Change from v2:
Add warning message that this is an unsupported option that may
be deprecated in the future.

We need to be able to parse the 'filename' option for rbd and iscsi, because
there may exist images in the wild that have json backing files, that specify
the filename argument.

Jeff Cody (2):
  block/rbd: enable filename option and parsing
  block/iscsi: enable filename option and parsing

 block/iscsi.c | 22 +++++++++++++++++++++-
 block/rbd.c   | 22 +++++++++++++++++++++-
 2 files changed, 42 insertions(+), 2 deletions(-)

-- 
2.9.3

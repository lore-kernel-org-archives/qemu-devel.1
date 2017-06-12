Received: from eggs.gnu.org ([2001:4830:134:3::10]:59598)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1dKQpP-00054b-0J
	for qemu-devel@nongnu.org; Mon, 12 Jun 2017 11:00:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1dKQpO-00038H-8X
	for qemu-devel@nongnu.org; Mon, 12 Jun 2017 11:00:27 -0400
From: Jeff Cody <jcody@redhat.com>
Date: Mon, 12 Jun 2017 11:00:15 -0400
Message-Id: <cover.1497279406.git.jcody@redhat.com>
Subject: [Qemu-devel] [PATCH 0/2]  Parse 'filename' option for RBD/iSCSI
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, kwolf@redhat.com, armbru@redhat.com, rjones@redhat.com

We need to be able to parse the 'filename' option for rbd and iscsi, because
there may exist images in the wild that have json backing files, that specify
the filename argument.

Jeff Cody (2):
  block/rbd: enable filename option and parsing
  block/iscsi: enable filename option and parsing

 block/iscsi.c | 19 ++++++++++++++++++-
 block/rbd.c   | 19 ++++++++++++++++++-
 2 files changed, 36 insertions(+), 2 deletions(-)

-- 
2.9.3

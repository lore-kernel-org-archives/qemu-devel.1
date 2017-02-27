Received: from eggs.gnu.org ([2001:4830:134:3::10]:53423)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1ciFlj-0006hK-A6
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 02:30:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1ciFli-0006vX-GM
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 02:30:51 -0500
From: Jeff Cody <jcody@redhat.com>
Date: Mon, 27 Feb 2017 02:30:37 -0500
Message-Id: <cover.1488180142.git.jcody@redhat.com>
Subject: [Qemu-devel] [PATCH 0/4] RBD: blockdev-add
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, armbru@redhat.com, berrange@redhat.com, eblake@redhat.com


This series adds blockdev-add for rbd.

However, there is an area that will likely need to change.  In the RBD
driver, all options for Ceph are supported, but the qemu driver is not
explicitly aware of all the options.

There are a few options that the QEMU driver cares about and handles, while
the other options are merely split out until their string key/value pairs
and passed along to Ceph.  In patches 3 and 4, this patch series does
the same practice, and parses all the extra options as a long string.

For QAPI, this is not acceptable - so I presume the best way to handle it
is with an array schema of structs.  I'll reply to the specific patches in
the problem areas, and see what the preference is from an API perspective
 to handle this.




Jeff Cody (4):
  block/rbd: don't copy strings in qemu_rbd_next_tok()
  block/rbd: code movement
  block/rbd: parse all options via bdrv_parse_filename
  block/rbd: Add blockdev-add support

 block/rbd.c          | 435 +++++++++++++++++++++++++++++----------------------
 qapi/block-core.json |  47 +++++-
 2 files changed, 289 insertions(+), 193 deletions(-)

-- 
2.9.3

Received: from eggs.gnu.org ([2001:4830:134:3::10]:51027)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1fzb3t-0004Tx-2l
	for qemu-devel@nongnu.org; Tue, 11 Sep 2018 01:18:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1fzb1q-0004bI-43
	for qemu-devel@nongnu.org; Tue, 11 Sep 2018 01:15:58 -0400
From: Jeff Cody <jcody@redhat.com>
Date: Tue, 11 Sep 2018 01:15:47 -0400
Message-Id: <cover.1536642773.git.jcody@redhat.com>
Subject: [Qemu-devel] [PATCH 0/2] block/rbd: enable filename parsing on open
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, qemu-stable@nongnu.org, jsnow@redhat.com, kwolf@redhat.com, armbru@redhat.com

This series enables filename parsing on open, on the old key/value pair.
Recent changes to new option formats for rbd broke some images.  See
Patch 2 for more details.

Jeff Cody (2):
  block/rbd: pull out qemu_rbd_convert_options
  block/rbd: Attempt to parse legacy filenames

 block/rbd.c | 66 +++++++++++++++++++++++++++++++++++++++++------------
 1 file changed, 51 insertions(+), 15 deletions(-)

-- 
2.17.1

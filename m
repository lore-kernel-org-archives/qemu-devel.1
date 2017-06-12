Received: from eggs.gnu.org ([2001:4830:134:3::10]:46233)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1dKGbQ-0002Nv-Av
	for qemu-devel@nongnu.org; Mon, 12 Jun 2017 00:05:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1dKGbP-0001Ty-IG
	for qemu-devel@nongnu.org; Mon, 12 Jun 2017 00:05:20 -0400
From: Jeff Cody <jcody@redhat.com>
Date: Mon, 12 Jun 2017 00:05:12 -0400
Message-Id: <cover.1497240079.git.jcody@redhat.com>
Subject: [Qemu-devel] [RFC 0/2] Parse 'filename' option for RBD/iSCSI
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, kwolf@redhat.com, armbru@redhat.com

We need to be able to parse the 'filename' option for both rbd and iscsi,
because there may exist images in the wild that have json backing files,
that specify the filename argument.

Marking the series as RFC at least partially for the precedence given to
arguments; as written, these patches will give preference to the 'filename'
parameter over passed options.

Jeff Cody (2):
  block/rbd: enable filename option and parsing
  block/iscsi: enable filename option and parsing

 block/iscsi.c | 19 ++++++++++++++++++-
 block/rbd.c   | 19 ++++++++++++++++++-
 2 files changed, 36 insertions(+), 2 deletions(-)

-- 
2.9.3

Received: from eggs.gnu.org ([2001:4830:134:3::10]:46873)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dddCP-0005X1-36
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 10:03:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dddC3-000787-Qg
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 10:03:33 -0400
From: Markus Armbruster <armbru@redhat.com>
Date: Fri, 04 Aug 2017 16:01:18 +0200
Message-ID: <878tize8k1.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] Unchecked blk_getlength() in device models and board
 code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Jan Kiszka <jan.kiszka@web.de>, Stefan Hajnoczi <stefanha@redhat.com>, qemu-block@nongnu.org, Alexander Graf <agraf@suse.de>

blk_getlength() can fail.  I figure the following need fixing:

hw/arm/musicpal.c: musicpal_init()
hw/block/nand.c: nand_realize()
hw/block/virtio-blk.c: virtio_blk_update_config()
hw/ppc/ppc405_boards.c: taihu_405ep_init()

Received: from eggs.gnu.org ([2001:4830:134:3::10]:51743)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1dX2XZ-0002ER-8n
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 05:42:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1dX2XV-0003K4-Bg
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 05:42:09 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51190)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1dX2XV-0003Hz-4K
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 05:42:05 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 1975A7CB87
	for <qemu-devel@nongnu.org>; Mon, 17 Jul 2017 09:42:04 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Mon, 17 Jul 2017 11:41:58 +0200
Message-Id: <20170717094159.16447-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PULL 0/1] Vga 20170717 patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>

The following changes since commit 6e2c46334385c7e295ac883c801c81b4925fb54f:

  Merge remote-tracking branch 'remotes/pmaydell/tags/pull-target-arm-20170711' into staging (2017-07-13 10:47:10 +0100)

are available in the git repository at:

  git://git.kraxel.org/qemu tags/vga-20170717-pull-request

for you to fetch changes up to 10750ee0d67eeebbf05822b2249969ba05b5ff4b:

  virtio-gpu: skip update cursor in post_load if we don't have one (2017-07-17 11:41:23 +0200)

----------------------------------------------------------------
virtio-gpu migration fix for 2.10

----------------------------------------------------------------

Gerd Hoffmann (1):
  virtio-gpu: skip update cursor in post_load if we don't have one

 hw/display/virtio-gpu.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

-- 
2.9.3

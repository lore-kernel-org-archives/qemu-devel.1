Received: from eggs.gnu.org ([2001:4830:134:3::10]:39978)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1eqZjE-0000Te-Jq
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 02:31:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1eqZjB-0007KU-D9
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 02:31:12 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:48332 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1eqZjB-0007KD-85
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 02:31:09 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 2EB288182D2E
	for <qemu-devel@nongnu.org>; Tue, 27 Feb 2018 07:31:05 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Tue, 27 Feb 2018 08:30:59 +0100
Message-Id: <20180227073100.1911-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PULL 0/1] Vga 20180227 patches
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

The following changes since commit 0a773d55ac76c5aa89ed9187a3bc5af8c5c2a6d0:

  maintainers: Add myself as a OpenBSD maintainer (2018-02-23 12:05:07 +0000)

are available in the git repository at:

  git://git.kraxel.org/qemu tags/vga-20180227-pull-request

for you to fetch changes up to 5643cc94ac1cbc23e1ba6b16b6a88e1ce7b3f6a9:

  virtio-gpu-3d: add support for second capability set (v4) (2018-02-26 13:41:34 +0100)

----------------------------------------------------------------
virtio-gpu: add support for second capability set

----------------------------------------------------------------

Dave Airlie (1):
  virtio-gpu-3d: add support for second capability set (v4)

 include/hw/virtio/virtio-gpu.h              |  2 +-
 include/standard-headers/linux/virtio_gpu.h |  1 +
 hw/display/virtio-gpu-3d.c                  | 15 +++++++++++++++
 hw/display/virtio-gpu.c                     |  7 ++++++-
 4 files changed, 23 insertions(+), 2 deletions(-)

-- 
2.9.3

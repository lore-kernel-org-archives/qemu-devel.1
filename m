Received: from eggs.gnu.org ([2001:4830:134:3::10]:33624)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cRG9A-0001b2-Vi
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 05:28:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cRG97-0003Qk-1Y
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 05:28:49 -0500
Received: from mx1.redhat.com ([209.132.183.28]:36252)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1cRG96-0003QT-RT
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 05:28:44 -0500
Received: from int-mx11.intmail.prod.int.phx2.redhat.com
	(int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 0E85C369C3
	for <qemu-devel@nongnu.org>; Wed, 11 Jan 2017 10:28:45 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Wed, 11 Jan 2017 11:28:32 +0100
Message-Id: <1484130518-18873-1-git-send-email-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 0/5] vga patch queue
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

  Hi,

Here comes the vga patch queue, with more bugfixes, one missed the
previously pull by mistake, the other ones are revent posts on the list.

please pull,
  Gerd

The following changes since commit b44486dfb9447c88e4b216e730adcc78019085=
2c:

  Merge remote-tracking branch 'remotes/kraxel/tags/pull-ui-20170110-1' i=
nto staging (2017-01-10 14:52:34 +0000)

are available in the git repository at:


  git://git.kraxel.org/qemu tags/pull-vga-20170111-1

for you to fetch changes up to a2056e09b02745e5d000351a8a7938fa8a292ba7:

  virtio-gpu: tag as not hotpluggable (2017-01-11 09:19:05 +0100)

----------------------------------------------------------------
vga: fixes for virtio-gpu and cirrus.

----------------------------------------------------------------
Bruce Rogers (1):
      display: cirrus: ignore source pitch value as needed in blit_is_uns=
afe

Gerd Hoffmann (1):
      virtio-gpu: tag as not hotpluggable

Li Qiang (1):
      virtio-gpu: fix information leak in capset get dispatch

Peter Maydell (2):
      virtio-gpu: Recalculate VirtIOGPU::hostmem on VM load
      virtio-gpu: Fix memory leak in virtio_gpu_load()

 hw/display/cirrus_vga.c    | 11 +++++++----
 hw/display/virtio-gpu-3d.c |  2 +-
 hw/display/virtio-gpu.c    | 18 ++++++++++++++++++
 3 files changed, 26 insertions(+), 5 deletions(-)

Received: from eggs.gnu.org ([2001:4830:134:3::10]:54242)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1f5Xzr-00062S-Vl
	for qemu-devel@nongnu.org; Mon, 09 Apr 2018 10:42:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1f5Xzo-00082f-0h
	for qemu-devel@nongnu.org; Mon, 09 Apr 2018 10:42:15 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:41382 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1f5Xzn-000829-SM
	for qemu-devel@nongnu.org; Mon, 09 Apr 2018 10:42:11 -0400
Date: Mon, 9 Apr 2018 17:42:00 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <1523284856-251254-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [Qemu-devel] [PULL 0/5] virtio,vhost: fixes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>

The following changes since commit 0e87fdc966d05f4e5ad868034fcd8ee2a08ca62d:

  Update version for v2.12.0-rc2 release (2018-04-04 20:37:20 +0100)

are available in the git repository at:

  git://git.kernel.org/pub/scm/virt/kvm/mst/qemu.git tags/for_upstream

for you to fetch changes up to d434e5ac5d70e9da7d20e50246af9251a125bdad:

  virtio-serial: fix heap-over-flow (2018-04-09 17:35:46 +0300)

----------------------------------------------------------------
virtio,vhost: fixes

Add a feature flag for new protocol messages.
Misc fixes.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

----------------------------------------------------------------
Changpeng Liu (1):
      contrib/libvhost-user: add the protocol feature used for SET/GET message

Dr. David Alan Gilbert (1):
      vhost: Allow adjoining regions

Maxime Coquelin (2):
      vhost-user-blk: set config ops before vhost-user init
      vhost-user: back SET/GET_CONFIG requests with a protocol feature

linzhecheng (1):
      virtio-serial: fix heap-over-flow

 docs/interop/vhost-user.txt           | 21 ++++++++++++---------
 contrib/libvhost-user/libvhost-user.h |  1 +
 hw/block/vhost-user-blk.c             |  4 ++--
 hw/char/virtio-serial-bus.c           |  7 +++++--
 hw/virtio/vhost-user.c                | 22 ++++++++++++++++++++++
 hw/virtio/vhost.c                     | 14 +++++++++-----
 6 files changed, 51 insertions(+), 18 deletions(-)

Received: from eggs.gnu.org ([2001:4830:134:3::10]:48141)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1eeOl4-0007yv-7e
	for qemu-devel@nongnu.org; Wed, 24 Jan 2018 12:22:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1eeOl0-0006Ub-4O
	for qemu-devel@nongnu.org; Wed, 24 Jan 2018 12:22:46 -0500
Received: from mx1.redhat.com ([209.132.183.28]:41010)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1eeOkz-0006Tk-Ui
	for qemu-devel@nongnu.org; Wed, 24 Jan 2018 12:22:42 -0500
Date: Wed, 24 Jan 2018 19:22:39 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <1516814467-25906-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [Qemu-devel] [PULL v2 0/3] virtio: quick fix
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

So this just reverts Gal's patches. I hope he'll be able to resubmit
shortly but it's causing too many issues to too many people to try to do
incremental fixups, and this way there's no timing pressure on anyone.

The following changes since commit 52483b067cce4a88ffbf8fbeea26de7549d2ad23:

  Merge remote-tracking branch 'remotes/huth/tags/pull-request-2018-01-22' into staging (2018-01-23 10:15:09 +0000)

are available in the git repository at:

  git://git.kernel.org/pub/scm/virt/kvm/mst/qemu.git tags/for_upstream

for you to fetch changes up to e044c0f8dd028ea296396ad8066ba436e9acf350:

  Revert "qemu: add a cleanup callback function to EventNotifier" (2018-01-24 19:20:19 +0200)

----------------------------------------------------------------
virtio: quick fix

Fixes a regression in virtio that's causing issues
for many people.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

----------------------------------------------------------------
Michael S. Tsirkin (3):
      Revert "virtio: improve virtio devices initialization time"
      Revert "virtio: postpone the execution of event_notifier_cleanup function"
      Revert "qemu: add a cleanup callback function to EventNotifier"

 include/qemu/event_notifier.h |  1 -
 accel/kvm/kvm-all.c           |  4 ----
 hw/virtio/virtio-bus.c        | 19 ++++++++-----------
 hw/virtio/virtio.c            |  5 -----
 util/event_notifier-posix.c   |  5 +----
 util/event_notifier-win32.c   |  2 --
 6 files changed, 9 insertions(+), 27 deletions(-)

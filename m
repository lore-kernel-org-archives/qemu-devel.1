Received: from eggs.gnu.org ([2001:4830:134:3::10]:41547)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1ct2Fl-0002pX-Up
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 21:18:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1ct2Fi-0006Hi-SA
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 21:18:25 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36332)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1ct2Fi-0006Hb-MK
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 21:18:22 -0400
Date: Wed, 29 Mar 2017 04:18:20 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <1490750257-19907-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [Qemu-devel] [PULL 0/3] virtio, pci: fixes
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

The following changes since commit df9046363220e57d45818312759b954c033c58ab:

  Update version for v2.9.0-rc2 release (2017-03-28 19:11:16 +0100)

are available in the git repository at:

  git://git.kernel.org/pub/scm/virt/kvm/mst/qemu.git tags/for_upstream

for you to fetch changes up to b8adbc657802482e4da1767bf983ebfdf9bfe9fc:

  virtio: fix vring_align() on 64-bit windows (2017-03-29 02:35:24 +0300)

----------------------------------------------------------------
virtio, pci: fixes

More fixes for 2.9.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

----------------------------------------------------------------
Alexey Kardashevskiy (1):
      pci: Add missing drop of bus master AS reference

Andrew Baumann (1):
      virtio: fix vring_align() on 64-bit windows

Halil Pasic (1):
      event_notifier: prevent accidental use after close

 include/hw/virtio/virtio.h  | 2 +-
 hw/pci/pci.c                | 2 ++
 util/event_notifier-posix.c | 2 ++
 util/event_notifier-win32.c | 1 +
 4 files changed, 6 insertions(+), 1 deletion(-)

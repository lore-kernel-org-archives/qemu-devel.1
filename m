Received: from eggs.gnu.org ([2001:4830:134:3::10]:40729)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1fIFbJ-0000Gf-9s
	for qemu-devel@nongnu.org; Mon, 14 May 2018 11:41:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1fIFbE-0007Tf-S4
	for qemu-devel@nongnu.org; Mon, 14 May 2018 11:41:25 -0400
From: Cornelia Huck <cohuck@redhat.com>
Date: Mon, 14 May 2018 17:41:08 +0200
Message-Id: <20180514154114.2558-1-cohuck@redhat.com>
Subject: [Qemu-devel] [PULL 0/6] s390x fixes/cleanups
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, Alexander Graf <agraf@suse.de>, Richard Henderson <rth@twiddle.net>, David Hildenbrand <david@redhat.com>, Thomas Huth <thuth@redhat.com>, qemu-s390x@nongnu.org, qemu-devel@nongnu.org, Cornelia Huck <cohuck@redhat.com>

The following changes since commit bbd87423ea0c436c55bbc3f9c23d4f811d1f3f29:

  Merge remote-tracking branch 'remotes/stefanha/tags/tracing-pull-request' into staging (2018-05-14 11:08:16 +0100)

are available in the Git repository at:

  git://github.com/cohuck/qemu tags/s390x-20180514

for you to fetch changes up to b0dad618baad1efb014c88f4507492a79f2eaf1c:

  target/s390x: Fix brace Werror with clang 6.0.0 (2018-05-14 17:10:02 +0200)

----------------------------------------------------------------
Some s390x fixes/cleanups, mainly in the reset area and build fixes
for recent compilers (GCC 8 and clang 6.0.0).

----------------------------------------------------------------

Cornelia Huck (3):
  s390x/css: disabled subchannels cannot be status pending
  virtio-ccw: common reset handler
  s390x/ccw: make sure all ccw devices are properly reset

David Hildenbrand (1):
  s390x: refactor reset/reipl handling

Richard Henderson (1):
  target/s390x: Fix brace Werror with clang 6.0.0

Thomas Huth (1):
  pc-bios/s390-ccw: struct tpi_info must be declared as aligned(4)

 hw/s390x/ccw-device.c              |  8 +++++
 hw/s390x/css.c                     |  8 +++++
 hw/s390x/ipl.c                     | 43 +++++++++++++++++++++++----
 hw/s390x/ipl.h                     | 16 ++++++++--
 hw/s390x/s390-virtio-ccw.c         | 51 ++++++++++++++++++++++++++-----
 hw/s390x/virtio-ccw.c              | 20 ++++---------
 hw/s390x/virtio-ccw.h              |  1 +
 include/hw/s390x/s390-virtio-ccw.h |  2 --
 pc-bios/s390-ccw/cio.h             |  2 +-
 target/s390x/cpu.h                 | 26 ++++++++++++++++
 target/s390x/diag.c                | 61 +++-----------------------------------
 target/s390x/internal.h            |  6 ----
 target/s390x/kvm.c                 |  2 +-
 target/s390x/misc_helper.c         |  2 +-
 14 files changed, 152 insertions(+), 96 deletions(-)

-- 
2.14.3

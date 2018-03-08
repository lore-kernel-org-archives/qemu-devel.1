Received: from eggs.gnu.org ([2001:4830:134:3::10]:40342)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1etzuI-0005Nd-4m
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 13:04:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1etzuH-00061X-43
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 13:04:46 -0500
From: Cornelia Huck <cohuck@redhat.com>
Date: Thu,  8 Mar 2018 19:04:12 +0100
Message-Id: <20180308180423.941-1-cohuck@redhat.com>
Subject: [Qemu-devel] [PULL 00/11] s390x patches for the 2.12 softfreeze
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org, borntraeger@de.ibm.com, rth@twiddle.net, agraf@suse.de, david@redhat.com, thuth@redhat.com, Cornelia Huck <cohuck@redhat.com>

Note that this currently does not work on s390x/tcg (needs "memory: fix
flatview_access_valid RCU read lock/unlock imbalance", which hopefully
should be submitted soon) -- s390x/kvm is fine.

The following changes since commit 83d2e94cba776c02c761a5d14b5c2504796a8c0a:

  Merge remote-tracking branch 'remotes/mcayland/tags/qemu-sparc-signed' into staging (2018-03-08 13:42:26 +0000)

are available in the git repository at:

  git://github.com/cohuck/qemu tags/s390x-20180308

for you to fetch changes up to 24118af846868bb22e573be206c63e684ba9846a:

  s390x/virtio: Convert virtio-ccw from *_exit to *_unrealize (2018-03-08 17:22:20 +0100)

----------------------------------------------------------------
Fixes and cleanups for the 2.12 softfreeze.

----------------------------------------------------------------

Claudio Imbrenda (2):
  s390x/sclp: proper support of larger send and receive masks
  s390x/sclp: clean up sclp masks

Collin L. Walling (1):
  s390/ipl: only print boot menu error if -boot menu=on was specified

Cornelia Huck (1):
  vfio-ccw: license text should indicate GPL v2 or later

David Hildenbrand (1):
  numa: we don't implement NUMA for s390x

Nia Alarie (2):
  s390x/sclpconsole: Remove dead code - remove exit handlers
  s390x/virtio: Convert virtio-ccw from *_exit to *_unrealize

Thomas Huth (4):
  hw/s390x/ipl: Bail out if the network bootloader can not be found
  target/s390x: Remove leading underscores from #defines
  hw/s390x: Add the possibility to specify the netboot image on the
    command line
  pc-bios/s390-ccw: Move string arrays from bootmap header to .c file

 hw/char/sclpconsole-lm.c          |  10 +---
 hw/char/sclpconsole.c             |  10 +---
 hw/s390x/event-facility.c         | 115 ++++++++++++++++++++++++++------------
 hw/s390x/ipl.c                    |  15 +++--
 hw/s390x/s390-virtio-ccw.c        |  20 +++++--
 hw/s390x/sclpcpu.c                |   4 +-
 hw/s390x/sclpquiesce.c            |   4 +-
 hw/s390x/virtio-ccw.c             |  34 +++++------
 hw/s390x/virtio-ccw.h             |   2 +-
 hw/vfio/ccw.c                     |   4 +-
 include/hw/s390x/event-facility.h |  23 ++++----
 numa.c                            |   2 +-
 pc-bios/s390-ccw/bootmap.c        |  20 +++++++
 pc-bios/s390-ccw/bootmap.h        |  19 -------
 target/s390x/cpu.h                |  66 +++++++++++-----------
 target/s390x/mem_helper.c         |  20 +++----
 target/s390x/mmu_helper.c         |  54 +++++++++---------
 17 files changed, 234 insertions(+), 188 deletions(-)

-- 
2.13.6

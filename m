Received: from eggs.gnu.org ([2001:4830:134:3::10]:39168)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1fuxBn-0005f2-25
	for qemu-devel@nongnu.org; Wed, 29 Aug 2018 05:55:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1fuwyz-0002VM-Bu
	for qemu-devel@nongnu.org; Wed, 29 Aug 2018 05:41:52 -0400
From: Cornelia Huck <cohuck@redhat.com>
Date: Wed, 29 Aug 2018 11:41:24 +0200
Message-Id: <20180829094143.2102-1-cohuck@redhat.com>
Subject: [Qemu-devel] [PULL 00/19] next batch of s390x changes
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

The following changes since commit 19b599f7664b2ebfd0f405fb79c14dd241557452:

  Merge remote-tracking branch 'remotes/armbru/tags/pull-error-2018-08-27-v2' into staging (2018-08-27 16:44:20 +0100)

are available in the Git repository at:

  git://github.com/cohuck/qemu tags/s390x-20180829

for you to fetch changes up to ef17064acc752d47377b1b263ef328e1281ab48e:

  target/s390x: use regular spaces in translate.c (2018-08-28 17:37:01 +0200)

----------------------------------------------------------------
- various fixes and improvements in the tcg code
- split off the individual virtio-ccw devices into separate files

----------------------------------------------------------------

Pavel Zbitskiy (7):
  tests/tcg: add a simple s390x test
  target/s390x: add BAL and BALR instructions
  target/s390x: fix CSST decoding and runtime alignment check
  target/s390x: fix IPM polluting irrelevant bits
  target/s390x: add EX support for TRT and TRTR
  target/s390x: fix PACK reading 1 byte less and writing 1 byte more
  target/s390x: use regular spaces in translate.c

Thomas Huth (12):
  hw/s390x/virtio-ccw: Consolidate calls to virtio_ccw_unrealize()
  hw/s390x: Move virtio-ccw-serial code to a separate file
  hw/s390x: Move virtio-ccw-balloon code to a separate file
  hw/s390x: Move virtio-ccw-scsi code to a separate file
  hw/s390x: Move virtio-ccw-rng code to a separate file
  hw/s390x: Move virtio-ccw-9p code to a separate file
  hw/s390x: Move virtio-ccw-crypto code to a separate file
  hw/s390x: Move vhost-vsock-ccw code to a separate file
  hw/s390x: Move virtio-ccw-gpu code to a separate file
  hw/s390x: Move virtio-ccw-input code to a separate file
  hw/s390x: Move virtio-ccw-net code to a separate file
  hw/s390x: Move virtio-ccw-blk code to a separate file

 MAINTAINERS                     |   4 +-
 hw/s390x/Makefile.objs          |  11 +
 hw/s390x/vhost-vsock-ccw.c      |  60 ++++
 hw/s390x/virtio-ccw-9p.c        |  65 ++++
 hw/s390x/virtio-ccw-balloon.c   |  70 +++++
 hw/s390x/virtio-ccw-blk.c       |  67 ++++
 hw/s390x/virtio-ccw-crypto.c    |  75 +++++
 hw/s390x/virtio-ccw-gpu.c       |  67 ++++
 hw/s390x/virtio-ccw-input.c     | 118 +++++++
 hw/s390x/virtio-ccw-net.c       |  70 +++++
 hw/s390x/virtio-ccw-rng.c       |  74 +++++
 hw/s390x/virtio-ccw-scsi.c      | 125 ++++++++
 hw/s390x/virtio-ccw-serial.c    |  78 +++++
 hw/s390x/virtio-ccw.c           | 676 +---------------------------------------
 target/s390x/insn-data.def      |   3 +
 target/s390x/mem_helper.c       |  24 +-
 target/s390x/translate.c        |  79 +++--
 tests/tcg/s390x/Makefile.target |   8 +
 tests/tcg/s390x/csst.c          |  43 +++
 tests/tcg/s390x/exrl-trt.c      |  48 +++
 tests/tcg/s390x/exrl-trtr.c     |  48 +++
 tests/tcg/s390x/hello-s390x.c   |   7 +
 tests/tcg/s390x/ipm.c           |  22 ++
 tests/tcg/s390x/pack.c          |  21 ++
 24 files changed, 1168 insertions(+), 695 deletions(-)
 create mode 100644 hw/s390x/vhost-vsock-ccw.c
 create mode 100644 hw/s390x/virtio-ccw-9p.c
 create mode 100644 hw/s390x/virtio-ccw-balloon.c
 create mode 100644 hw/s390x/virtio-ccw-blk.c
 create mode 100644 hw/s390x/virtio-ccw-crypto.c
 create mode 100644 hw/s390x/virtio-ccw-gpu.c
 create mode 100644 hw/s390x/virtio-ccw-input.c
 create mode 100644 hw/s390x/virtio-ccw-net.c
 create mode 100644 hw/s390x/virtio-ccw-rng.c
 create mode 100644 hw/s390x/virtio-ccw-scsi.c
 create mode 100644 hw/s390x/virtio-ccw-serial.c
 create mode 100644 tests/tcg/s390x/Makefile.target
 create mode 100644 tests/tcg/s390x/csst.c
 create mode 100644 tests/tcg/s390x/exrl-trt.c
 create mode 100644 tests/tcg/s390x/exrl-trtr.c
 create mode 100644 tests/tcg/s390x/hello-s390x.c
 create mode 100644 tests/tcg/s390x/ipm.c
 create mode 100644 tests/tcg/s390x/pack.c

-- 
2.14.4

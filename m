Received: from eggs.gnu.org ([2001:4830:134:3::10]:41703)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1fVFNM-000727-7b
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 08:04:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1fVFNH-0001j2-J3
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 08:04:44 -0400
From: Cornelia Huck <cohuck@redhat.com>
Date: Tue, 19 Jun 2018 14:04:22 +0200
Message-Id: <20180619120434.25062-1-cohuck@redhat.com>
Subject: [Qemu-devel] [PULL 00/12] next round of s390x patches
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

The following changes since commit 2ef2f16781af9dee6ba6517755e9073ba5799fa2:

  Merge remote-tracking branch 'remotes/dgilbert/tags/pull-migration-20180615a' into staging (2018-06-15 18:13:35 +0100)

are available in the Git repository at:

  git://github.com/cohuck/qemu tags/s390x-20180619

for you to fetch changes up to 49b67e9440892179c016a7afd33725a50d995ba6:

  Merge tag 'tags/s390x-2018-06-18' into staging (2018-06-18 17:05:39 +0200)

----------------------------------------------------------------
- cleanup in virtio-ccw
- accommodate guests using vfio-ccw without specifying unlimited
  prefetch, but actually working fine
- add cpu model for the z14 Model ZR1
- add support for pxelinux.cfg-style network booting to the s390x
  firmware

----------------------------------------------------------------

Christian Borntraeger (2):
  s390x/ipl: Try to detect Linux vs non Linux for initial IPL PSW
  s390x/cpumodels: add z14 Model ZR1

Collin Walling (1):
  pc-bios/s390-ccw: define loadparm length

Halil Pasic (3):
  virtio-ccw: clean up notify
  vfio-ccw: add force unlimited prefetch property
  vfio-ccw: remove orb.c64 (64 bit data addresses) check

Thomas Huth (6):
  roms: Update SLOF submodule to current status
  pc-bios/s390-ccw/net: Update code for the latest changes in SLOF
  pc-bios/s390-ccw/net: Add support for pxelinux-style config files
  pc-bios/s390-ccw/net: Try to load pxelinux.cfg file accoring to the
    UUID
  pc-bios/s390-ccw: Optimize the s390-netboot.img for size
  pc-bios/s390-ccw: Update the s390-netboot.img binary

-- 
2.14.4

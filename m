Received: from eggs.gnu.org ([2001:4830:134:3::10]:53176)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gJhyi-0006DW-JX
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 11:43:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gJhyh-0000kJ-IM
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 11:43:52 -0500
From: Cornelia Huck <cohuck@redhat.com>
Date: Mon,  5 Nov 2018 17:43:34 +0100
Message-Id: <20181105164340.20707-1-cohuck@redhat.com>
Subject: [Qemu-devel] [PULL 0/6] final s390x patches for -rc0
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, Alexander Graf <agraf@suse.de>, Richard Henderson <rth@twiddle.net>, David Hildenbrand <david@redhat.com>, Thomas Huth <thuth@redhat.com>, Collin Walling <walling@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>, Farhan Ali <alifm@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>, qemu-s390x@nongnu.org, qemu-devel@nongnu.org, Cornelia Huck <cohuck@redhat.com>

The following changes since commit 7d56239f159afc2e7bd42623947e56ba48f37836:

  Merge remote-tracking branch 'remotes/pmaydell/tags/pull-target-arm-20181102' into staging (2018-11-02 17:17:12 +0000)

are available in the Git repository at:

  https://github.com/cohuck/qemu tags/s390x-20181105

for you to fetch changes up to 8e4eb4279fce9a736131b94b6f5f09f0503e4ab3:

  MAINTAINERS: s390/boot: the ipl code and the bios belong together (2018-11-05 09:55:29 +0100)

----------------------------------------------------------------
- some changes in s390x maintainership
- bugfix in vfio-ap

----------------------------------------------------------------

Alexander Graf (1):
  MAINTAINERS: s390: Remove myself

Christian Borntraeger (4):
  MAINTAINERS: s390: more maintainers for vfio-ccw
  MAINTAINERS: s390/virtio-ccw: drop Christian, add Halil
  MAINTAINERS: s390/pci: add Collin Walling as maintainer for zpci
  MAINTAINERS: s390/boot: the ipl code and the bios belong together

Cornelia Huck (1):
  s390x/vfio-ap: report correct error

 MAINTAINERS  | 17 +++++++++++------
 hw/vfio/ap.c |  2 +-
 2 files changed, 12 insertions(+), 7 deletions(-)

-- 
2.14.5

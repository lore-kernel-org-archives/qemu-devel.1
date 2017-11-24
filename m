Received: from eggs.gnu.org ([2001:4830:134:3::10]:39728)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1eIAmK-0000LS-9P
	for qemu-devel@nongnu.org; Fri, 24 Nov 2017 05:00:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1eIAm3-0008OQ-Cd
	for qemu-devel@nongnu.org; Fri, 24 Nov 2017 05:00:12 -0500
From: Cornelia Huck <cohuck@redhat.com>
Date: Fri, 24 Nov 2017 10:59:48 +0100
Message-Id: <20171124095949.16323-1-cohuck@redhat.com>
Subject: [Qemu-devel] [PULL for-2.11 0/1] s390x: headers deletion fallout
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, rth@twiddle.net, agraf@suse.de, thuth@redhat.com, borntraeger@de.ibm.com, david@redhat.com, Cornelia Huck <cohuck@redhat.com>

The following changes since commit c65d5e4e1d6841524c49a07bcdd56094f49982a4:

  configure: Deal with OpenBSD/i386 emulation linker (2017-11-23 16:52:24 +0000)

are available in the git repository at:

  git://github.com/cohuck/qemu tags/s390x-20171124

for you to fetch changes up to c1c4c2192c1c063a6c53c600bb97f20555b2a528:

  s390/kvm_virtio/linux-headers: remove traces of old virtio transport (2017-11-24 10:52:05 +0100)

----------------------------------------------------------------
Deal with the fallout from the deletion of the old s390 virtio header
in Linux master.

----------------------------------------------------------------

Christian Borntraeger (1):
  s390/kvm_virtio/linux-headers: remove traces of old virtio transport

 hw/s390x/s390-virtio-hcall.h                   |  6 ++-
 include/standard-headers/asm-s390/kvm_virtio.h | 64 --------------------------
 scripts/update-linux-headers.sh                |  1 -
 3 files changed, 4 insertions(+), 67 deletions(-)
 delete mode 100644 include/standard-headers/asm-s390/kvm_virtio.h

-- 
2.13.6

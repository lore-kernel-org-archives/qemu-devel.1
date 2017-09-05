Received: from eggs.gnu.org ([2001:4830:134:3::10]:42874)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dpFad-00086u-FU
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 11:16:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dpFaY-0002p1-TC
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 11:16:35 -0400
From: Cornelia Huck <cohuck@redhat.com>
Date: Tue,  5 Sep 2017 17:16:11 +0200
Message-Id: <20170905151614.31303-1-cohuck@redhat.com>
Subject: [Qemu-devel] [PATCH 0/3] iotests: cure s390x failures by switching
 to ccw
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: kwolf@redhat.com, mreitz@redhat.com
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, borntraeger@de.ibm.com, agraf@suse.de, thuth@redhat.com, david@redhat.com, haoqf@linux.vnet.ibm.com, Cornelia Huck <cohuck@redhat.com>

Recent changes in s390x made pci support dependant on the zpci cpu
feature, which is not provided on all models (and not on by default).
This means we cannot instatiate pci devices on a standard qemu
invocation for s390x. Moreover, the zpci instructions are not even
wired up for tcg yet, so actually doing anything with those pci devices
is bound to fail on tcg.

Let's follow the existing example in 068 and switch to the (default)
virtio-ccw transport on s390x. The changes for 051 and 067 are split
out as they require adding an output file for s390x (the actual command
lines are part of the output).

Cornelia Huck (3):
  iotests: use -ccw on s390x for 040, 139, and 182
  iotests: use -ccw on s390x for 051
  iotests: use -ccw on s390x for 067

 tests/qemu-iotests/040                     |   6 +-
 tests/qemu-iotests/051                     |   9 +-
 tests/qemu-iotests/051.s390-ccw-virtio.out | 434 +++++++++++++++++++++++++++
 tests/qemu-iotests/067                     |  11 +-
 tests/qemu-iotests/067.s390-ccw-virtio.out | 458 +++++++++++++++++++++++++++++
 tests/qemu-iotests/139                     |  12 +-
 tests/qemu-iotests/182                     |  13 +-
 7 files changed, 936 insertions(+), 7 deletions(-)
 create mode 100644 tests/qemu-iotests/051.s390-ccw-virtio.out
 create mode 100644 tests/qemu-iotests/067.s390-ccw-virtio.out

-- 
2.13.5

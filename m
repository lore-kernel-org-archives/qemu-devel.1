Received: from eggs.gnu.org ([2001:4830:134:3::10]:43585)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dfJ60-0000za-1L
	for qemu-devel@nongnu.org; Wed, 09 Aug 2017 00:59:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dfJ5v-0005sZ-7y
	for qemu-devel@nongnu.org; Wed, 09 Aug 2017 00:59:52 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41206)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1dfJ5v-0005sD-21
	for qemu-devel@nongnu.org; Wed, 09 Aug 2017 00:59:47 -0400
From: Thomas Huth <thuth@redhat.com>
Date: Wed,  9 Aug 2017 06:59:36 +0200
Message-Id: <1502254778-14637-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [PATCH for-2.11 0/2] Improvements for the pxe tester
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, Cornelia Huck <cohuck@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, "Michael S. Tsirkin" <mst@redhat.com>, Victor Kaplansky <victork@redhat.com>

The first patch improves the buffer handling in the pxe tester a
little bit by allocating a separate buffer on the heap for each
architecture. This also gets rid of the huge pre-initialized
array in the tester, shrinking the size of the executable by
half of a megabyte!
The second patch adds s390x support to the pxe tester. Starting
with QEMU 2.10, the guest firmware on s390x can now net-boot via
TFTP, too, so we can automatically test this code in the pxe tester.

Thomas Huth (2):
  tests/boot-sector: Do not overwrite the x86 buffer on other
    architectures
  tests/pxe: Check virtio-net-ccw on s390x

 tests/Makefile.include |  1 +
 tests/boot-sector.c    | 57 ++++++++++++++++++++++++++++++++++++++------------
 tests/pxe-test.c       |  7 +++++++
 3 files changed, 52 insertions(+), 13 deletions(-)

-- 
1.8.3.1

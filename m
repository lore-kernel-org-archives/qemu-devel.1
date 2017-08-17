Received: from eggs.gnu.org ([2001:4830:134:3::10]:39927)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1diEFG-0001hf-Fv
	for qemu-devel@nongnu.org; Thu, 17 Aug 2017 02:25:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1diEFD-0006AN-BD
	for qemu-devel@nongnu.org; Thu, 17 Aug 2017 02:25:30 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40732)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1diEFD-00066m-3t
	for qemu-devel@nongnu.org; Thu, 17 Aug 2017 02:25:27 -0400
From: Thomas Huth <thuth@redhat.com>
Date: Thu, 17 Aug 2017 08:25:07 +0200
Message-Id: <1502951113-4246-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [PATCH for-2.11 0/6] Enable more qtests for s390x
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, Cornelia Huck <cohuck@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>
Cc: David Hildenbrand <david@redhat.com>, Claudio Imbrenda <imbrenda@linux.vnet.ibm.com>, Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>, Eric Farman <farman@linux.vnet.ibm.com>, Fan Zhang <zhangfan@linux.vnet.ibm.com>, Farhan Ali <alifm@linux.vnet.ibm.com>, Fei Li <sherrylf@linux.vnet.ibm.com>, Halil Pasic <pasic@linux.vnet.ibm.com>, Janosch Frank <frankja@linux.vnet.ibm.com>, Jason J Herne <jjherne@linux.vnet.ibm.com>, Jing Liu <liujbjl@linux.vnet.ibm.com>, Pierre Morel <pmorel@linux.vnet.ibm.com>, QingFeng Hao <haoqf@linux.vnet.ibm.com>, Xiao Feng Ren <renxiaof@linux.vnet.ibm.com>, Yang Chen <bjcyang@linux.vnet.ibm.com>, Yi Min Zhao <zyimin@linux.vnet.ibm.com>, Marc Mari <markmb@redhat.com>, Cleber Rosa <crosa@redhat.com>, Michael S Tsirkin <mst@redhat.com>

We currently do not have many tests enabled for QEMU on s390x yet,
so this series reworks some of the tests to be also usable on s390x
to get some extended test coverage there.

Along the way, this also cleans up some of the generic test code,
e.g. by introducing generic functions to do hot-plugging with
the device_add QMP command.

Please review!

 Thanks,
  Thomas


Thomas Huth (6):
  tests: Run filter-redirector and -mirror test only on POSIX systems
  tests: Add network filter tests to the check-qtest-s390x list
  tests: Enable the drive_del test also on s390x
  tests: Introduce generic device hot-plug/hot-unplug functions
  tests: Add qvirtio_(un)plug_device_test wrapper functions
  tests: Enable the simple virtio tests on s390x, too

 tests/Makefile.include         | 20 +++++++++-----
 tests/drive_del-test.c         | 13 ++++-----
 tests/libqos/pci.c             | 19 ++-----------
 tests/libqos/usb.c             | 30 +++++----------------
 tests/libqos/virtio.c          | 29 ++++++++++++++++++++
 tests/libqos/virtio.h          |  5 ++++
 tests/libqtest.c               | 60 ++++++++++++++++++++++++++++++++++++++++++
 tests/libqtest.h               | 19 +++++++++++++
 tests/test-filter-mirror.c     | 14 +++++-----
 tests/test-filter-redirector.c | 32 +++++++++++-----------
 tests/test-netfilter.c         | 11 +++++++-
 tests/usb-hcd-uhci-test.c      | 26 ++----------------
 tests/usb-hcd-xhci-test.c      | 51 +++--------------------------------
 tests/virtio-balloon-test.c    |  6 ++---
 tests/virtio-console-test.c    | 12 ++++-----
 tests/virtio-net-test.c        |  8 ++----
 tests/virtio-rng-test.c        | 17 +++++-------
 tests/virtio-scsi-test.c       | 24 ++---------------
 tests/virtio-serial-test.c     | 33 +++++------------------
 19 files changed, 208 insertions(+), 221 deletions(-)

-- 
1.8.3.1

Received: from eggs.gnu.org ([2001:4830:134:3::10]:48617)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gMHZd-0005Dg-9K
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 14:08:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gMHZR-0003zn-NZ
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 14:08:31 -0500
Received: from mx1.redhat.com ([209.132.183.28]:48676)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1gMHZL-0003vk-U1
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 14:08:22 -0500
From: Thomas Huth <thuth@redhat.com>
Date: Mon, 12 Nov 2018 20:08:03 +0100
Message-Id: <1542049690-12826-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [PATCH v1 for-3.2 0/7] Get rid of global_qtest in some
 of the qtests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: Igor Mammedov <imammedo@redhat.com>, John Snow <jsnow@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Ben Warren <ben@skyportsystems.com>

We should avoid global variables like global_qtest in the qtests - they
cause trouble in the tests where we operate with multiple QEMU instances,
e.g. with migration. Eric Blake already did quite a lot of work towards
this goal in the past, but some of his patches never reached the master
branch. Here I've now rebased some of his work to the current master branch,
and added some small further clean up patches on top.

Eric Blake (3):
  ahci-test: Drop dependence on global_qtest
  ivshmem-test: Drop dependence on global_qtest
  tests/acpi-utils: Drop dependence on global_qtest

Thomas Huth (4):
  tests/pvpanic: Make the pvpanic test independent of global_qtest
  tests/libqos/pci: Make PCI access functions independent of
    global_qtest
  tests/vmgenid: Make test independent of global_qtest
  tests/boot-serial: Get rid of global_qtest variable

 tests/acpi-utils.c       | 19 +++++------
 tests/acpi-utils.h       | 63 +++++++++++++++++++------------------
 tests/ahci-test.c        | 81 +++++++++++++++++++++++------------------------
 tests/bios-tables-test.c | 82 +++++++++++++++++++++++++-----------------------
 tests/boot-serial-test.c | 13 ++++----
 tests/ivshmem-test.c     | 18 +----------
 tests/libqos/libqos.c    |  9 ------
 tests/libqos/libqos.h    |  1 -
 tests/libqos/pci-pc.c    | 47 +++++++++++++--------------
 tests/libqos/pci-spapr.c | 20 ++++++------
 tests/pvpanic-test.c     | 14 +++++----
 tests/vmgenid-test.c     | 53 ++++++++++++++++---------------
 12 files changed, 201 insertions(+), 219 deletions(-)

-- 
1.8.3.1

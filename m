Received: from eggs.gnu.org ([2001:4830:134:3::10]:50884)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gYveI-0000Q0-IM
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 11:21:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gYveD-00006U-Mf
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 11:21:42 -0500
Received: from mx1.redhat.com ([209.132.183.28]:58288)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1gYveD-00004v-4I
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 11:21:37 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
	[10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 6E676552C7
	for <qemu-devel@nongnu.org>; Mon, 17 Dec 2018 16:21:36 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
Date: Mon, 17 Dec 2018 17:21:17 +0100
Message-Id: <1545063690-10116-1-git-send-email-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 00/13] qtest patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Laurent Vivier <lvivier@redhat.com>

 Hi Peter,

the following changes since commit 139108f68486550869bd201f903f1884b78a4a=
e1:

  .shippable.yml: disable the win cross tests (2018-12-17 13:02:12 +0000)

are available in the git repository at:

  https://gitlab.com/huth/qemu.git tags/pull-request-2018-12-17

for you to fetch changes up to fe17cca6bd2cdfb9cc7f29da8e71aa1238bcdba7:

  tests/bios-tables-test: Sanitize test verbose output (2018-12-17 16:21:=
51 +0100)

----------------------------------------------------------------
- Replace global_qtest in some tests
- Exit boot-serial-test loop if child dies
- Sanitize verbose output in biot-tables-test
----------------------------------------------------------------

Eric Blake (2):
      ivshmem-test: Drop dependence on global_qtest
      tests/acpi-utils: Drop dependence on global_qtest

Igor Mammedov (1):
      tests: acpi: remove not used ACPI_READ_GENERIC_ADDRESS macro

Philippe Mathieu-Daud=C3=A9 (1):
      tests/bios-tables-test: Sanitize test verbose output

Richard Henderson (1):
      tests: Exit boot-serial-test loop if child dies

Thomas Huth (8):
      tests/libqos/pci: Make PCI access functions independent of global_q=
test
      tests/vmgenid: Make test independent of global_qtest
      tests/pvpanic: Make the pvpanic test independent of global_qtest
      tests/boot-serial: Get rid of global_qtest variable
      tests/test-filter: Make tests independent of global_qtest
      tests/machine-none: Make test independent of global_qtest
      tests/prom-env: Make test independent of global_qtest
      tests/pxe: Make test independent of global_qtest

 tests/acpi-utils.c             | 19 ++++-----
 tests/acpi-utils.h             | 57 ++++++++++++---------------
 tests/bios-tables-test.c       | 89 ++++++++++++++++++++++--------------=
------
 tests/boot-serial-test.c       | 33 ++++++++++------
 tests/ivshmem-test.c           | 18 +--------
 tests/libqos/pci-pc.c          | 47 +++++++++++-----------
 tests/libqos/pci-spapr.c       | 20 +++++-----
 tests/libqtest.c               | 72 +++++++++++++++++++++-------------
 tests/libqtest.h               |  8 ++++
 tests/machine-none-test.c      |  7 ++--
 tests/prom-env-test.c          | 17 ++++----
 tests/pvpanic-test.c           | 14 ++++---
 tests/pxe-test.c               |  7 ++--
 tests/test-filter-mirror.c     |  9 +++--
 tests/test-filter-redirector.c | 16 ++++----
 tests/vmgenid-test.c           | 53 +++++++++++++------------
 16 files changed, 258 insertions(+), 228 deletions(-)

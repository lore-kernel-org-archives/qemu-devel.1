Received: from eggs.gnu.org ([2001:4830:134:3::10]:51482)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1fnQBz-0005qa-QW
	for qemu-devel@nongnu.org; Wed, 08 Aug 2018 11:16:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1fnQBt-0002gI-OU
	for qemu-devel@nongnu.org; Wed, 08 Aug 2018 11:16:07 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:42902 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1fnQBt-0002fl-Je
	for qemu-devel@nongnu.org; Wed, 08 Aug 2018 11:16:01 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 2179840216E7
	for <qemu-devel@nongnu.org>; Wed,  8 Aug 2018 15:16:00 +0000 (UTC)
From: Igor Mammedov <imammedo@redhat.com>
Date: Wed,  8 Aug 2018 17:15:45 +0200
Message-Id: <1533741349-199141-1-git-send-email-imammedo@redhat.com>
Subject: [Qemu-devel] [RFC PATCH 0/4] "pc: acpi: _CST support"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>

It's an alternative approach to
 1) [PATCH hack dontapply v2 0/7] Dynamic _CST generation
which instead of dynamic AML loading uses static AML with
dynamic values.  It allows us to keep firmware blob static and
to avoid split firmware issue (1) in case of cross version migration.

ABI in this case is confined to cpu hotplug IO registers
(i.e. do it old school way, like we used to do so far).
This way we don't have to add yet another ABI to keep dynamic
AML code under control (1).

Tested  with: XPsp3 - ws2106 guests.

CC: "Michael S. Tsirkin" <mst@redhat.com>


Igor Mammedov (3):
  acpi: add aml_create_byte_field()
  pc: acpi: add _CST support
  acpi: add support for CST update notification

Michael S. Tsirkin (1):
  acpi: aml: add aml_register()

 include/hw/acpi/aml-build.h     |   6 ++
 include/hw/acpi/cpu.h           |  10 +++
 docs/specs/acpi_cpu_hotplug.txt |  21 +++++-
 hw/acpi/aml-build.c             |  28 +++++++
 hw/acpi/cpu.c                   | 158 +++++++++++++++++++++++++++++++++++++++-
 hw/acpi/piix4.c                 |   2 +
 hw/i386/acpi-build.c            |   5 +-
 tests/bios-tables-test.c        |   1 +
 8 files changed, 225 insertions(+), 6 deletions(-)

-- 
2.7.4

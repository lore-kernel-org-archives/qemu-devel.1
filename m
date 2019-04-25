Received: from eggs.gnu.org ([209.51.188.92]:54523)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1hJbyr-0003GZ-Nc
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 06:51:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1hJbqo-0000It-17
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 06:43:35 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41756)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1hJbqn-0000I6-Qa
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 06:43:33 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 94F778E5A1
	for <qemu-devel@nongnu.org>; Thu, 25 Apr 2019 10:43:32 +0000 (UTC)
From: Laszlo Ersek <lersek@redhat.com>
Date: Thu, 25 Apr 2019 12:43:24 +0200
Message-Id: <20190425104326.12835-1-lersek@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 0/2] tests/uefi-test-tools: report the SMBIOS
 entry point structures
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu devel list <qemu-devel@nongnu.org>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>, Igor Mammedov <imammedo@redhat.com>

Repo:      https://github.com/lersek/qemu.git
Branch:    smbios_lp_1821884
Launchpad: https://bugs.launchpad.net/qemu/+bug/1821884

In

  [Qemu-devel] [PATCH for 4.1 v2 09/13]
  tests: acpi: ignore SMBIOS tests when UEFI firmware is used

at

  http://mid.mail-archive.com/1553605799-168605-10-git-send-email-imammed=
o@redhat.com
  https://lists.gnu.org/archive/html/qemu-devel/2019-03/msg07037.html

Igor had to temporarily exclude SMBIOS unit testing with UEFI guests.

Let the BiosTablesTest guest UEFI app report the SMBIOS entry point(s),
so that SMBIOS unit tests can cover UEFI guests.

Cc: "Philippe Mathieu-Daud=C3=A9" <philmd@redhat.com>
Cc: Igor Mammedov <imammedo@redhat.com>

Thanks
Laszlo

Laszlo Ersek (2):
  tests/uefi-test-tools: report the SMBIOS entry point structures
  tests/uefi-boot-images: report the SMBIOS entry point structures

 tests/uefi-test-tools/UefiTestToolsPkg/Include/Guid/BiosTablesTest.h    =
 |  25 +++++++++++++++-----
 tests/uefi-test-tools/UefiTestToolsPkg/BiosTablesTest/BiosTablesTest.inf=
 |   2 ++
 tests/uefi-test-tools/UefiTestToolsPkg/BiosTablesTest/BiosTablesTest.c  =
 |  23 ++++++++++++++----
 tests/data/uefi-boot-images/bios-tables-test.aarch64.iso.qcow2          =
 | Bin 11776 -> 12288 bytes
 tests/data/uefi-boot-images/bios-tables-test.arm.iso.qcow2              =
 | Bin 11776 -> 11776 bytes
 tests/data/uefi-boot-images/bios-tables-test.i386.iso.qcow2             =
 | Bin 12800 -> 13312 bytes
 tests/data/uefi-boot-images/bios-tables-test.x86_64.iso.qcow2           =
 | Bin 13312 -> 13312 bytes
 7 files changed, 40 insertions(+), 10 deletions(-)

--=20
2.19.1.3.g30247aa5d201

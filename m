Received: from eggs.gnu.org ([209.51.188.92]:38937)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1hMUXQ-0006ZN-1R
	for qemu-devel@nongnu.org; Fri, 03 May 2019 05:31:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1hMUXO-0006ph-TX
	for qemu-devel@nongnu.org; Fri, 03 May 2019 05:31:28 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40014)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1hMUXO-0006iw-OD
	for qemu-devel@nongnu.org; Fri, 03 May 2019 05:31:26 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 67243307D989
	for <qemu-devel@nongnu.org>; Fri,  3 May 2019 09:31:24 +0000 (UTC)
From: Laszlo Ersek <lersek@redhat.com>
Date: Fri,  3 May 2019 11:31:16 +0200
Message-Id: <20190503093118.15700-1-lersek@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 0/2] tests/uefi-test-tools: report the SMBIOS
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

No changes relative to the original posting at
<http://mid.mail-archive.com/20190425104326.12835-1-lersek@redhat.com>,
except for picking up the review/testing tags (also noted separately on
each patch).

Cc: "Philippe Mathieu-Daud=C3=A9" <philmd@redhat.com>
Cc: Igor Mammedov <imammedo@redhat.com>

Thanks
Laszlo

The following changes since commit 8482ff2eb3bb95020eb2f370a9b3ea26511e41=
df:

  Merge remote-tracking branch 'remotes/jnsnow/tags/bitmaps-pull-request'=
 into staging (2019-05-02 12:04:51 +0100)

are available in the Git repository at:

  https://github.com/lersek/qemu.git tags/smbios_lp_1821884_20190503

for you to fetch changes up to 24496b8d27d95c4b317039e2c48f262cfd40fb4d:

  tests/uefi-boot-images: report the SMBIOS entry point structures (2019-=
05-03 10:52:27 +0200)

----------------------------------------------------------------
Fix <https://bugs.launchpad.net/qemu/+bug/1821884>:
"Extend uefi-test-tools to report SMBIOS location".

----------------------------------------------------------------
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

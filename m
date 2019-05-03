Received: from eggs.gnu.org ([209.51.188.92]:38958)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1hMUXR-0006aB-AZ
	for qemu-devel@nongnu.org; Fri, 03 May 2019 05:31:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1hMUXQ-0006wl-8T
	for qemu-devel@nongnu.org; Fri, 03 May 2019 05:31:29 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43628)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1hMUXQ-0006tq-34
	for qemu-devel@nongnu.org; Fri, 03 May 2019 05:31:28 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 709D9C058CB4
	for <qemu-devel@nongnu.org>; Fri,  3 May 2019 09:31:27 +0000 (UTC)
From: Laszlo Ersek <lersek@redhat.com>
Date: Fri,  3 May 2019 11:31:18 +0200
Message-Id: <20190503093118.15700-3-lersek@redhat.com>
In-Reply-To: <20190503093118.15700-1-lersek@redhat.com>
References: <20190503093118.15700-1-lersek@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 2/2] tests/uefi-boot-images: report the SMBIOS
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

Rebuild the "bios-tables-test" UEFI boot images with the SMBIOS entry
point reporting that has been added in the previous patch.

Cc: "Philippe Mathieu-Daud=C3=A9" <philmd@redhat.com>
Cc: Igor Mammedov <imammedo@redhat.com>
Launchpad: https://bugs.launchpad.net/qemu/+bug/1821884
Signed-off-by: Laszlo Ersek <lersek@redhat.com>
Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Tested-by: Igor Mammedov <imammedo@redhat.com>
---

Notes:
    pull:
   =20
    - pick up T-b from Phil & Igor

 tests/data/uefi-boot-images/bios-tables-test.aarch64.iso.qcow2 | Bin 117=
76 -> 12288 bytes
 tests/data/uefi-boot-images/bios-tables-test.arm.iso.qcow2     | Bin 117=
76 -> 11776 bytes
 tests/data/uefi-boot-images/bios-tables-test.i386.iso.qcow2    | Bin 128=
00 -> 13312 bytes
 tests/data/uefi-boot-images/bios-tables-test.x86_64.iso.qcow2  | Bin 133=
12 -> 13312 bytes
 4 files changed, 0 insertions(+), 0 deletions(-)

diff --git a/tests/data/uefi-boot-images/bios-tables-test.aarch64.iso.qco=
w2 b/tests/data/uefi-boot-images/bios-tables-test.aarch64.iso.qcow2
index ac0b7b1b8f89..d588cf3ebd7d 100644
Binary files a/tests/data/uefi-boot-images/bios-tables-test.aarch64.iso.q=
cow2 and b/tests/data/uefi-boot-images/bios-tables-test.aarch64.iso.qcow2=
 differ
diff --git a/tests/data/uefi-boot-images/bios-tables-test.arm.iso.qcow2 b=
/tests/data/uefi-boot-images/bios-tables-test.arm.iso.qcow2
index d20fa7c81925..552c7a7ddce6 100644
Binary files a/tests/data/uefi-boot-images/bios-tables-test.arm.iso.qcow2=
 and b/tests/data/uefi-boot-images/bios-tables-test.arm.iso.qcow2 differ
diff --git a/tests/data/uefi-boot-images/bios-tables-test.i386.iso.qcow2 =
b/tests/data/uefi-boot-images/bios-tables-test.i386.iso.qcow2
index 26c882baeaba..c66ad155196d 100644
Binary files a/tests/data/uefi-boot-images/bios-tables-test.i386.iso.qcow=
2 and b/tests/data/uefi-boot-images/bios-tables-test.i386.iso.qcow2 diffe=
r
diff --git a/tests/data/uefi-boot-images/bios-tables-test.x86_64.iso.qcow=
2 b/tests/data/uefi-boot-images/bios-tables-test.x86_64.iso.qcow2
index 9ec3c1f20bb2..f59e07c85415 100644
Binary files a/tests/data/uefi-boot-images/bios-tables-test.x86_64.iso.qc=
ow2 and b/tests/data/uefi-boot-images/bios-tables-test.x86_64.iso.qcow2 d=
iffer
--=20
2.19.1.3.g30247aa5d201

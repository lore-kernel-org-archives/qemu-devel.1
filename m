Received: from eggs.gnu.org ([2001:4830:134:3::10]:34721)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1g7m16-0006oB-I8
	for qemu-devel@nongnu.org; Wed, 03 Oct 2018 14:37:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1g7lvG-0000kg-NT
	for qemu-devel@nongnu.org; Wed, 03 Oct 2018 14:31:04 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54592)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1g7lvG-0000jz-FA
	for qemu-devel@nongnu.org; Wed, 03 Oct 2018 14:30:58 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id BA9E983F3D
	for <qemu-devel@nongnu.org>; Wed,  3 Oct 2018 18:30:57 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Date: Wed,  3 Oct 2018 20:30:33 +0200
Message-Id: <20181003183036.6716-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [RFC PATCH v2 0/3] acceptance tests: Test firmware
 checking debug console output
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cleber Rosa <crosa@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Caio Carrara <ccarrara@redhat.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>, qemu-devel@nongnu.org, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Laszlo Ersek <lersek@redhat.com>

Hi,

This RFC series add simple acceptance tests which boot SeaBIOS and EDK2 o=
n
the pc and virt/aarch64 default machines

Still PoC but can be useful for the Avocado team to test the multi-arch t=
argets.

Since v1: https://lists.gnu.org/archive/html/qemu-devel/2018-09/msg03780.=
html
- more Pythonic context managers (Cleber)
- use wait_for (Cleber)
- use workdir (Cleber)
- use Avocado 65.0 "-p" option for aarch64 (Cleber)
- fixed Q35 incorrect description in cover (Laszlo)
- use ArmVirtQemu name (Laszlo)

Next:
- address Laszlo comments about correct QEMU options and flash images
- use FDDrainer
- refactor common code in setUp()
- use new avocado.utils.archive gzip features (Cleber)
- test x86_64/aarch64 'arch' tags (Cleber)
- build EDK2 flash images (Laszlo)
- include variable store flash image (Laszlo)
- use virtual disk with UEFI shell script (Laszlo)
- improve OVMF binary selection (releases / snapshots) (Laszlo)
- check ISO images (Laszlo -> Cleber)
- add aexpect tests (Cleber?)

Regards,

Phil.

Philippe Mathieu-Daud=C3=A9 (3):
  acceptance tests: Add SeaBIOS boot and debug console checking test
  acceptance tests: Add EDK2 OVMF boot and debug console checking test
  acceptance tests: Add EDK2 ArmVirtQemu boot and console checking test

 tests/acceptance/boot_firmware.py | 159 ++++++++++++++++++++++++++++++
 1 file changed, 159 insertions(+)
 create mode 100644 tests/acceptance/boot_firmware.py

--=20
2.17.1

Received: from eggs.gnu.org ([209.51.188.92]:51817)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hEaBZ-0001El-R0
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 09:56:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hEaBX-0005k2-P5
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 09:56:13 -0400
From: Markus Armbruster <armbru@redhat.com>
Date: Thu, 11 Apr 2019 15:56:00 +0200
Message-Id: <20190411135602.21725-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 0/2] hw/arm/virt: Support firmware
 configuration with -blockdev
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: lersek@redhat.com, peter.maydell@linaro.org, qemu-arm@nongnu.org, kwolf@redhat.com, mreitz@redhat.com, qemu-block@nongnu.org

L=C3=A1szl=C3=B3 asked for feature parity with the PC machine types.

Markus Armbruster (2):
  pflash_cfi01: New pflash_cfi01_legacy_drive()
  hw/arm/virt: Support firmware configuration with -blockdev

 hw/arm/virt.c            | 192 +++++++++++++++++++++++++--------------
 hw/block/pflash_cfi01.c  |  30 ++++++
 hw/i386/pc_sysfw.c       |  19 +---
 include/hw/arm/virt.h    |   2 +
 include/hw/block/flash.h |   1 +
 5 files changed, 157 insertions(+), 87 deletions(-)

--=20
2.17.2

Received: from eggs.gnu.org ([209.51.188.92]:48974)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1h1Cvq-0006PS-W7
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 11:28:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1h1Cvq-0002G8-4o
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 11:28:42 -0500
Received: from mx1.redhat.com ([209.132.183.28]:36734)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1h1Cvp-0002Ep-UA
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 11:28:42 -0500
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Date: Tue,  5 Mar 2019 17:28:24 +0100
Message-Id: <20190305162829.20079-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 0/5] mips_malta: Clean up definition of flash
 memory size
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>
Cc: Aurelien Jarno <aurelien@aurel32.net>, Aleksandar Markovic <amarkovic@wavecomp.com>, Aleksandar Rikalo <arikalo@wavecomp.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>

Hi Markus,

this is a rework of your 'mips_malta: Clean up definition of flash memory=
 size somewhat' patch:
https://lists.gnu.org/archive/html/qemu-devel/2019-02/msg07177.html

Regards,

Phil.

Based-on: <20190226193408.23862-9-armbru@redhat.com>

Markus Armbruster (1):
  mips_malta: Clean up definition of flash memory size somewhat

Philippe Mathieu-Daud=C3=A9 (4):
  hw/mips/malta: Fix the DEBUG_BOARD_INIT code
  hw/mips/malta: Remove fl_sectors variable (used one single time)
  hw/mips/malta: Restrict 'bios_size' variable scope
  hw/mips/malta: Only accept 'monitor' pflash of 4MiB

 hw/mips/mips_malta.c | 27 +++++++++++++++++----------
 1 file changed, 17 insertions(+), 10 deletions(-)

--=20
2.20.1

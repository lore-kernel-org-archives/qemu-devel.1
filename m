Received: from eggs.gnu.org ([2001:4830:134:3::10]:45602)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1daWAR-00077C-T9
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 19:56:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1daWAM-0003cP-VZ
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 19:56:39 -0400
Received: from hall.aurel32.net ([2001:bc8:30d7:100::1]:39968)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aurelien@aurel32.net>)
	id 1daWAM-0003Y6-Pf
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 19:56:34 -0400
From: Aurelien Jarno <aurelien@aurel32.net>
Date: Thu, 27 Jul 2017 01:56:12 +0200
Message-Id: <20170726235614.14687-1-aurelien@aurel32.net>
Subject: [Qemu-devel] [PATCH for 2.10 0/2] Move endianness error reporting
 to the MIPS boards
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Yongbok Kim <yongbok.kim@imgtec.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, Alexey Kardashevskiy <aik@ozlabs.ru>, Aurelien Jarno <aurelien@aurel32.net>

This patchset improves the MIPS board error reporting when loading a 
kernel with the wrong endianness, using load_elf_strerror.

That way the check added to loader.c can be removed, as it harms the
pseries platform. Indeed it can change its endianness dynamically at
runtime and thus can load both little and big endian kernels.

Alexey Kardashevskiy (1):
  Revert "elf-loader: warn about invalid endianness"

Aurelien Jarno (1):
  hw/mips: load_elf_strerror to report kernel loading failure

 hw/core/loader.c        |  1 -
 hw/mips/mips_fulong2e.c | 15 +++++++++------
 hw/mips/mips_malta.c    | 14 ++++++++------
 hw/mips/mips_mipssim.c  |  5 +++--
 hw/mips/mips_r4k.c      |  6 ++++--
 5 files changed, 24 insertions(+), 17 deletions(-)

-- 
2.11.0

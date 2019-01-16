Received: from eggs.gnu.org ([209.51.188.92]:55746)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gjkuU-0004f0-D1
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 08:07:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gjkuT-0002IU-IB
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 08:07:10 -0500
Received: from mx2.rt-rk.com ([89.216.37.149]:54146 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
	id 1gjkuT-0008EB-8z
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 08:07:09 -0500
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Date: Wed, 16 Jan 2019 14:05:46 +0100
Message-Id: <1547643949-10776-1-git-send-email-aleksandar.markovic@rt-rk.com>
Subject: [Qemu-devel] [PATCH 0/3] target/mips: Amend CP0 (add MemoryMapID,
 add macros, renaming)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: amarkovic@wavecomp.com, arikalo@wavecomp.com, aurelien@aurel32.net

From: Aleksandar Markovic <amarkovic@wavecomp.com>

Add MemoryMapId register and add preprocessor constants for
fmajority of CP0 subregisters, and rename few variables.

Aleksandar Markovic (3):
  target/mips: Add preprocessor constants for CP0 subregisters
  target/mips: Add CP0 register MemoryMapID
  target/mips: Rename 'rn' to 'register_name'

 target/mips/cpu.h       | 115 +++++++
 target/mips/machine.c   |   5 +-
 target/mips/translate.c | 858 ++++++++++++++++++++++++------------------------
 3 files changed, 550 insertions(+), 428 deletions(-)

-- 
2.7.4

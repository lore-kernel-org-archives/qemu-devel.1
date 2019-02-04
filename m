Received: from eggs.gnu.org ([209.51.188.92]:44729)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gqlVe-0002c0-01
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 16:10:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gqlQ8-0003oF-3T
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 16:04:49 -0500
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Date: Mon,  4 Feb 2019 22:04:30 +0100
Message-Id: <20190204210433.26088-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 0/3] hw: Drop useless inclusion of hw/i386/pc.h
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-trivial@nongnu.org
Cc: qemu-ppc@nongnu.org, Artyom Tarasenko <atar4qemu@gmail.com>, =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>, Guan Xuetao <gxt@mprc.pku.edu.cn>, David Gibson <david@gibson.dropbear.id.au>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>

Since 47973a2dbf, it is useless to include "hw/i386/pc.h"
on the ppc/unicore32/sparc64 boards.

The last non-x86 targets still requiring it are alpha/hppa/mips,
because the I8259 intc is still deeply mixed with the PC board.

Philippe Mathieu-Daud=C3=A9 (3):
  hw/sparc64/sun4u: Drop useless inclusion of "hw/i386/pc.h"
  hw/unicore32/puv3: Drop useless inclusion of "hw/i386/pc.h"
  hw/ppc/prep: Drop useless inclusion of "hw/i386/pc.h"

 hw/ppc/prep.c       | 1 -
 hw/sparc64/sun4u.c  | 1 -
 hw/unicore32/puv3.c | 1 -
 3 files changed, 3 deletions(-)

--=20
2.20.1

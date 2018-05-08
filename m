Received: from eggs.gnu.org ([2001:4830:134:3::10]:57891)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fG4GL-0002dG-T2
	for qemu-devel@nongnu.org; Tue, 08 May 2018 11:10:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fG4GH-0004xa-Si
	for qemu-devel@nongnu.org; Tue, 08 May 2018 11:10:45 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Tue,  8 May 2018 12:10:31 -0300
Message-Id: <20180508151035.16774-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [RFC PATCH 0/4] qemu/typedefs.h cleanup
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, John Snow <jsnow@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Alistair Francis <alistair@alistair23.me>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, qemu-block@nongnu.org, qemu-arm@nongnu.org

Hi Thomas, Michael,

This is a RFC cleanup following the "s390x: drop an unused include" thread:
http://lists.nongnu.org/archive/html/qemu-devel/2018-05/msg01649.html

I believe we can cut a good third of typedefs.h.

Sending a RFC PoC for comments before continuing in this direction.

Regards,

Phil.

Philippe Mathieu-Daudé (4):
  typedefs: Remove PcGuestInfo from qemu/typedefs.h
  hw/pcmcia: Remove PCMCIACardState from qemu/typedefs.h
  hw/ssi: Remove SSIBus from qemu/typedefs.h
  hw/ide/ahci: Remove AllwinnerAHCIState from qemu/typedefs.h

 hw/arm/strongarm.h      | 1 +
 include/hw/arm/pxa.h    | 2 ++
 include/hw/ide/ahci.h   | 4 ++--
 include/hw/pcmcia.h     | 4 ++--
 include/hw/ssi/ssi.h    | 1 +
 include/qemu/typedefs.h | 4 ----
 6 files changed, 8 insertions(+), 8 deletions(-)

-- 
2.17.0

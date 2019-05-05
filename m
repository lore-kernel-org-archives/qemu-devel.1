Received: from eggs.gnu.org ([209.51.188.92]:45789)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hNJ4Q-0008Kw-Av
	for qemu-devel@nongnu.org; Sun, 05 May 2019 11:28:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hNJ4P-0003Nl-9l
	for qemu-devel@nongnu.org; Sun, 05 May 2019 11:28:54 -0400
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Date: Sun,  5 May 2019 17:28:36 +0200
Message-Id: <20190505152839.18650-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 0/3] hw/ppc/40p: Move the MC146818 RTC to the
 board where it belongs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Artyom Tarasenko <atar4qemu@gmail.com>, qemu-devel@nongnu.org, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: qemu-ppc@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>

Hi,

This series is to properly do the fix sent by Artyom here:
https://lists.gnu.org/archive/html/qemu-devel/2019-04/msg02264.html

There is no RTC on the i82378, move it to the board code,
set the base year there.

Regards,

Phil.

Artyom Tarasenko (1):
  hw/ppc/40p: use 1900 as a base year

Philippe Mathieu-Daud=C3=A9 (2):
  hw/ppc/prep: use TYPE_MC146818_RTC instead of a hardcoded string
  hw/ppc/40p: Move the MC146818 RTC to the board where it belongs

 hw/isa/i82378.c | 4 ----
 hw/ppc/prep.c   | 7 ++++++-
 2 files changed, 6 insertions(+), 5 deletions(-)

--=20
2.20.1

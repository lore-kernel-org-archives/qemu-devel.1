Received: from eggs.gnu.org ([209.51.188.92]:37135)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hDr4Q-0005bH-Bl
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 09:45:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hDr4P-00012v-Bd
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 09:45:50 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37980)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hDr4P-00012L-3F
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 09:45:49 -0400
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Date: Tue,  9 Apr 2019 15:45:34 +0200
Message-Id: <20190409134536.15548-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH for-4.0 v3 0/2] roms: Avoid iPXE/EDK2 EFIROM
 variable clash, pass CFLAGS to EDK2 build tools
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laszlo Ersek <lersek@redhat.com>, qemu-devel@nongnu.org, Olaf Hering <olaf@aepfle.de>
Cc: Gerd Hoffmann <kraxel@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>

Hi,

Two trivial fixes to avoid the latest EDK2 testing series to
cause trouble to downstream distributions (in particular if
they have PIE enforced).

Since v2:
- addressed Laszlo's suggestion
- reworded patch description

v2: https://lists.gnu.org/archive/html/qemu-devel/2019-04/msg01033.html
v1: https://lists.gnu.org/archive/html/qemu-devel/2019-04/msg01006.html
error report: https://lists.gnu.org/archive/html/qemu-devel/2019-04/msg00=
992.html

Regards,

Phil.

Philippe Mathieu-Daud=C3=A9 (2):
  roms: Rename the EFIROM variable to avoid clashing with iPXE
  roms: Allow passing configure options to the EDK2 build tools

 roms/Makefile | 23 ++++++++++++++++++-----
 1 file changed, 18 insertions(+), 5 deletions(-)

--=20
2.20.1

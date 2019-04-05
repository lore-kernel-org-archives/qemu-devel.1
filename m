Received: from eggs.gnu.org ([209.51.188.92]:48608)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hCQrJ-0005i5-Nm
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 11:34:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hCQrI-0003a0-Oa
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 11:34:25 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42632)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hCQrD-0002kp-3L
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 11:34:21 -0400
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Date: Fri,  5 Apr 2019 17:33:12 +0200
Message-Id: <20190405153314.2068-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH for-4.0 v2 0/2] roms: Rename the EFIROM
 variable and let it be overridable
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, Laszlo Ersek <lersek@redhat.com>, Olaf Hering <olaf@aepfle.de>
Cc: Igor Mammedov <imammedo@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>

Hi,

Two trivial fixes to avoid the latest EDK2 testing series to
cause trouble to downstream distributions (in particular if
they have PIE enforced).

Regards,

Phil.

Philippe Mathieu-Daud=C3=A9 (2):
  roms: Rename the EFIROM variable to avoid clashing with iPXE
  roms: Allow the EDK2_EFIROM variable to be overridden

 roms/Makefile | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

--=20
2.20.1

Received: from eggs.gnu.org ([2001:4830:134:3::10]:52677)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cgvVJ-0000iN-12
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 10:40:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cgvVI-0006pM-0L
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 10:40:25 -0500
Received: from mx1.redhat.com ([209.132.183.28]:57252)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1cgvVH-0006oz-QT
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 10:40:23 -0500
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Thu, 23 Feb 2017 16:40:13 +0100
Message-Id: <1487864414-25485-3-git-send-email-kraxel@redhat.com>
In-Reply-To: <1487864414-25485-1-git-send-email-kraxel@redhat.com>
References: <1487864414-25485-1-git-send-email-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 2/3] usb: ohci: fix error return code in
 servicing td
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Li Qiang <liq3ea@gmail.com>, Li Qiang <liqiang6-s@360.cn>, Gerd Hoffmann <kraxel@redhat.com>

From: Li Qiang <liq3ea@gmail.com>

It should return 1 if an error occurs when reading td.
This will avoid an infinite loop issue in ohci_service_ed_list.

Signed-off-by: Li Qiang <liqiang6-s@360.cn>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Message-id: 1487760990-115925-1-git-send-email-liqiang6-s@360.cn
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 hw/usb/hcd-ohci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/usb/hcd-ohci.c b/hw/usb/hcd-ohci.c
index 21c93e0..fe8406a 100644
--- a/hw/usb/hcd-ohci.c
+++ b/hw/usb/hcd-ohci.c
@@ -1001,7 +1001,7 @@ static int ohci_service_td(OHCIState *ohci, struct =
ohci_ed *ed)
     if (ohci_read_td(ohci, addr, &td)) {
         trace_usb_ohci_td_read_error(addr);
         ohci_die(ohci);
-        return 0;
+        return 1;
     }
=20
     dir =3D OHCI_BM(ed->flags, ED_D);
--=20
1.8.3.1

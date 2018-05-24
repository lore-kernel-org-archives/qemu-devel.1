Received: from eggs.gnu.org ([2001:4830:134:3::10]:52842)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fLsRG-0000LQ-OA
	for qemu-devel@nongnu.org; Thu, 24 May 2018 11:46:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fLsRD-00030E-5R
	for qemu-devel@nongnu.org; Thu, 24 May 2018 11:46:02 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:59400 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1fLsRD-0002za-1Y
	for qemu-devel@nongnu.org; Thu, 24 May 2018 11:45:59 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 97A83BB437
	for <qemu-devel@nongnu.org>; Thu, 24 May 2018 15:45:58 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Thu, 24 May 2018 17:45:56 +0200
Message-Id: <20180524154556.17876-8-kraxel@redhat.com>
In-Reply-To: <20180524154556.17876-1-kraxel@redhat.com>
References: <20180524154556.17876-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 7/7] MAINTAINERS: add vga entries
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>

Add entries for standard vga, virtio-gpu and cirrus.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Message-id: 20180522165058.15404-7-kraxel@redhat.com
---
 MAINTAINERS | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index e187b1f18f..2af3ad5172 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1314,6 +1314,27 @@ S: Maintained
 F: include/hw/misc/unimp.h
 F: hw/misc/unimp.c
=20
+Standard VGA
+M: Gerd Hoffmann <kraxel@redhat.com>
+S: Maintained
+F: hw/display/vga*
+F: hw/display/bochs-display.c
+F: include/hw/display/vga.h
+F: include/hw/display/bochs-vbe.h
+
+virtio-gpu
+M: Gerd Hoffmann <kraxel@redhat.com>
+S: Maintained
+F: hw/display/virtio-gpu*
+F: hw/display/virtio-vga.c
+F: include/hw/virtio/virtio-gpu.h
+
+Cirrus VGA
+M: Gerd Hoffmann <kraxel@redhat.com>
+S: Odd Fixes
+W: https://www.kraxel.org/blog/2014/10/qemu-using-cirrus-considered-harm=
ful/
+F: hw/display/cirrus*
+
 Subsystems
 ----------
 Audio
--=20
2.9.3

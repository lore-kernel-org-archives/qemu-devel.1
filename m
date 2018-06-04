Received: from eggs.gnu.org ([2001:4830:134:3::10]:59391)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fPlAs-0006lf-Lk
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 04:49:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fPlAo-0007XE-MQ
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 04:49:10 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:48968 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1fPlAo-0007VB-HK
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 04:49:06 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 05FE9859B2
	for <qemu-devel@nongnu.org>; Mon,  4 Jun 2018 08:49:05 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Mon,  4 Jun 2018 10:49:02 +0200
Message-Id: <20180604084903.8163-2-kraxel@redhat.com>
In-Reply-To: <20180604084903.8163-1-kraxel@redhat.com>
References: <20180604084903.8163-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 1/2] bochs-display: add missing break
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

Fixes: CID 1391291
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Reviewed-by: J=C3=A1n Tomko <jtomko@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Message-id: 20180525045344.28347-1-kraxel@redhat.com
---
 hw/display/bochs-display.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/display/bochs-display.c b/hw/display/bochs-display.c
index c33524b558..1187d77576 100644
--- a/hw/display/bochs-display.c
+++ b/hw/display/bochs-display.c
@@ -158,6 +158,7 @@ static int bochs_display_get_mode(BochsDisplayState *=
s,
         /* best effort: support native endianess only */
         mode->format =3D PIXMAN_r5g6b5;
         mode->bytepp =3D 2;
+        break;
     case 32:
         mode->format =3D s->big_endian_fb
             ? PIXMAN_BE_x8r8g8b8
--=20
2.9.3

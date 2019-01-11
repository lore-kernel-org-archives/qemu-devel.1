Received: from eggs.gnu.org ([209.51.188.92]:44443)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1ghxKY-0007AS-Tg
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 08:58:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1ghxKX-0000J0-PW
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 08:58:38 -0500
Received: from mx1.redhat.com ([209.132.183.28]:33410)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1ghxKX-0000Hz-JT
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 08:58:37 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
	[10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 884967E442
	for <qemu-devel@nongnu.org>; Fri, 11 Jan 2019 13:58:36 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Fri, 11 Jan 2019 14:58:35 +0100
Message-Id: <20190111135835.3453-3-kraxel@redhat.com>
In-Reply-To: <20190111135835.3453-1-kraxel@redhat.com>
References: <20190111135835.3453-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 2/2] i2c-ddc: fix oob read
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>

Suggested-by: Michael Hanselmann <public@hansmi.ch>
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Reviewed-by: Michael Hanselmann <public@hansmi.ch>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Message-id: 20190108102301.1957-1-kraxel@redhat.com
---
 hw/i2c/i2c-ddc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/i2c/i2c-ddc.c b/hw/i2c/i2c-ddc.c
index be34fe072c..0a0367ff38 100644
--- a/hw/i2c/i2c-ddc.c
+++ b/hw/i2c/i2c-ddc.c
@@ -56,7 +56,7 @@ static int i2c_ddc_rx(I2CSlave *i2c)
     I2CDDCState *s =3D I2CDDC(i2c);
=20
     int value;
-    value =3D s->edid_blob[s->reg];
+    value =3D s->edid_blob[s->reg % sizeof(s->edid_blob)];
     s->reg++;
     return value;
 }
--=20
2.9.3

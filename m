Received: from eggs.gnu.org ([2001:4830:134:3::10]:58572)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fNuQe-0002EU-CO
	for qemu-devel@nongnu.org; Wed, 30 May 2018 02:17:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fNuQb-0001Iq-8L
	for qemu-devel@nongnu.org; Wed, 30 May 2018 02:17:48 -0400
Received: from 11.mo5.mail-out.ovh.net ([46.105.47.167]:41525)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1fNuQa-0001I9-Uu
	for qemu-devel@nongnu.org; Wed, 30 May 2018 02:17:45 -0400
Received: from player718.ha.ovh.net (unknown [10.109.105.49])
	by mo5.mail-out.ovh.net (Postfix) with ESMTP id 690F91B7DB4
	for <qemu-devel@nongnu.org>; Wed, 30 May 2018 08:17:42 +0200 (CEST)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Wed, 30 May 2018 08:17:11 +0200
Message-Id: <20180530061711.23673-5-clg@kaod.org>
In-Reply-To: <20180530061711.23673-1-clg@kaod.org>
References: <20180530061711.23673-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 4/4] ftgmac100: remove check on runt messages
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jason Wang <jasowang@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>

This is a ethernet wire limitation not needed in emulation. It breaks
U-Boot n/w stack also.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 hw/net/ftgmac100.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/hw/net/ftgmac100.c b/hw/net/ftgmac100.c
index 8a7f274dc118..909c1182eebe 100644
--- a/hw/net/ftgmac100.c
+++ b/hw/net/ftgmac100.c
@@ -822,12 +822,6 @@ static ssize_t ftgmac100_receive(NetClientState *nc,=
 const uint8_t *buf,
         return size;
     }
=20
-    if (size < 64 && !(s->maccr & FTGMAC100_MACCR_RX_RUNT)) {
-        qemu_log_mask(LOG_GUEST_ERROR, "%s: dropped runt frame of %zd by=
tes\n",
-                      __func__, size);
-        return size;
-    }
-
     if (!ftgmac100_filter(s, buf, size)) {
         return size;
     }
--=20
2.13.6

Received: from eggs.gnu.org ([2001:4830:134:3::10]:45763)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1dO1Ss-0007UD-I6
	for qemu-devel@nongnu.org; Thu, 22 Jun 2017 08:44:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1dO1So-0006qM-Fz
	for qemu-devel@nongnu.org; Thu, 22 Jun 2017 08:44:02 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45258)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1dO1So-0006qA-AF
	for qemu-devel@nongnu.org; Thu, 22 Jun 2017 08:43:58 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 42397BBF4D
	for <qemu-devel@nongnu.org>; Thu, 22 Jun 2017 12:43:57 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Thu, 22 Jun 2017 14:41:53 +0200
Message-Id: <20170622124204.19407-21-marcandre.lureau@redhat.com>
In-Reply-To: <20170622124204.19407-1-marcandre.lureau@redhat.com>
References: <20170622124204.19407-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 20/31] q35: use DIV_ROUND_UP
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>

I used the clang-tidy qemu-round check to generate the fix:
https://github.com/elmarco/clang-tools-extra

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 hw/pci-host/q35.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/pci-host/q35.c b/hw/pci-host/q35.c
index 28cb97b60f..0c50c4930f 100644
--- a/hw/pci-host/q35.c
+++ b/hw/pci-host/q35.c
@@ -316,7 +316,7 @@ static void mch_update_pam(MCHPCIState *mch)
     memory_region_transaction_begin();
     for (i =3D 0; i < 13; i++) {
         pam_update(&mch->pam_regions[i], i,
-                   pd->config[MCH_HOST_BRIDGE_PAM0 + ((i + 1) / 2)]);
+                   pd->config[MCH_HOST_BRIDGE_PAM0 + (DIV_ROUND_UP(i, 2)=
)]);
     }
     memory_region_transaction_commit();
 }
--=20
2.13.1.395.gf7b71de06

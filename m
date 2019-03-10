Received: from eggs.gnu.org ([209.51.188.92]:43003)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1h2toU-0001LN-4R
	for qemu-devel@nongnu.org; Sun, 10 Mar 2019 04:28:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1h2toT-0001ZK-CD
	for qemu-devel@nongnu.org; Sun, 10 Mar 2019 04:28:06 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Sun, 10 Mar 2019 19:26:44 +1100
Message-Id: <20190310082703.1245-42-david@gibson.dropbear.id.au>
In-Reply-To: <20190310082703.1245-1-david@gibson.dropbear.id.au>
References: <20190310082703.1245-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 41/60] mac_oldworld: use node name instead of
 alias name for hd device in FWPathProvider
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: groug@kaod.org, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, lvivier@redhat.com, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, David Gibson <david@gibson.dropbear.id.au>

From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

When using -drive to configure the hd drive for the Old World machine, th=
e node
name "disk" should be used instead of the "hd" alias.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-Id: <20190307212058.4890-2-mark.cave-ayland@ilande.co.uk>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/mac_oldworld.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/ppc/mac_oldworld.c b/hw/ppc/mac_oldworld.c
index cc1e463466..460cbc7923 100644
--- a/hw/ppc/mac_oldworld.c
+++ b/hw/ppc/mac_oldworld.c
@@ -402,11 +402,11 @@ static char *heathrow_fw_dev_path(FWPathProvider *p=
, BusState *bus,
             return g_strdup("cdrom");
         }
=20
-        return g_strdup("hd");
+        return g_strdup("disk");
     }
=20
     if (!strcmp(object_get_typename(OBJECT(dev)), "ide-hd")) {
-        return g_strdup("hd");
+        return g_strdup("disk");
     }
=20
     if (!strcmp(object_get_typename(OBJECT(dev)), "ide-cd")) {
--=20
2.20.1

Received: from eggs.gnu.org ([2001:4830:134:3::10]:56375)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ej9Ga-00032q-0D
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 14:50:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ej9GW-0003sK-Nv
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 14:50:55 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:50522 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1ej9GW-0003rX-I4
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 14:50:52 -0500
From: Markus Armbruster <armbru@redhat.com>
Date: Tue,  6 Feb 2018 20:50:41 +0100
Message-Id: <20180206195044.8347-12-armbru@redhat.com>
In-Reply-To: <20180206195044.8347-1-armbru@redhat.com>
References: <20180206195044.8347-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 11/14] hw/sd: Replace fprintf(stderr,
 "*\n" with DPRINTF()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Alistair Francis <alistair.francis@xilinx.com>

From: Alistair Francis <alistair.francis@xilinx.com>

Signed-off-by: Alistair Francis <alistair.francis@xilinx.com>
[Most of original patch dropped, commit message replaced to match
what's left]
Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Message-Id: <20180203084315.20497-11-armbru@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
---
 hw/sd/sd.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index 35347a5bbc..73e405a04f 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -1564,9 +1564,10 @@ send_response:
     if (rsplen) {
         int i;
         DPRINTF("Response:");
-        for (i =3D 0; i < rsplen; i++)
-            fprintf(stderr, " %02x", response[i]);
-        fprintf(stderr, " state %d\n", sd->state);
+        for (i =3D 0; i < rsplen; i++) {
+            DPRINTF(" %02x", response[i]);
+        }
+        DPRINTF(" state %d\n", sd->state);
     } else {
         DPRINTF("No response %d\n", sd->state);
     }
--=20
2.13.6

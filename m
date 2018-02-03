Received: from eggs.gnu.org ([2001:4830:134:3::10]:58565)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ehtPt-0001sp-5C
	for qemu-devel@nongnu.org; Sat, 03 Feb 2018 03:43:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ehtPr-0000Q6-F6
	for qemu-devel@nongnu.org; Sat, 03 Feb 2018 03:43:21 -0500
Received: from mx1.redhat.com ([209.132.183.28]:51752)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1ehtPr-0000Pg-93
	for qemu-devel@nongnu.org; Sat, 03 Feb 2018 03:43:19 -0500
From: Markus Armbruster <armbru@redhat.com>
Date: Sat,  3 Feb 2018 09:43:11 +0100
Message-Id: <20180203084315.20497-11-armbru@redhat.com>
In-Reply-To: <20180203084315.20497-1-armbru@redhat.com>
References: <20180203084315.20497-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v8 10/14] hw/sd: Replace fprintf(stderr,
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
Cc: alistair.francis@xilinx.com, eblake@redhat.com, f4bug@amsat.org

From: Alistair Francis <alistair.francis@xilinx.com>

Signed-off-by: Alistair Francis <alistair.francis@xilinx.com>
[Most of original patch dropped, commit message replaced to match
what's left]
Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
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

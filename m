Received: from eggs.gnu.org ([2001:4830:134:3::10]:41556)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dTWl7-0004uS-0J
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 13:09:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dTWl6-0007pk-1D
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 13:09:36 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Fri,  7 Jul 2017 19:07:32 +0200
Message-Id: <1499447335-6125-18-git-send-email-kwolf@redhat.com>
In-Reply-To: <1499447335-6125-1-git-send-email-kwolf@redhat.com>
References: <1499447335-6125-1-git-send-email-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 017/100] vvfat: change OEM name to 'MSWIN4.1'
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, qemu-devel@nongnu.org

From: Herv=C3=A9 Poussineau <hpoussin@reactos.org>

According to specification:
"'MSWIN4.1' is the recommanded setting, because it is the setting least l=
ikely
to cause compatibility problems. If you want to put something else in her=
e,
that is your option, but the result may be that some FAT drivers might no=
t
recognize the volume."

Specification: "FAT: General overview of on-disk format" v1.03, page 9
Signed-off-by: Herv=C3=A9 Poussineau <hpoussin@reactos.org>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/vvfat.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/vvfat.c b/block/vvfat.c
index 9cb48ef..f55104c 100644
--- a/block/vvfat.c
+++ b/block/vvfat.c
@@ -1023,7 +1023,7 @@ static int init_directories(BDRVVVFATState* s,
     bootsector->jump[0]=3D0xeb;
     bootsector->jump[1]=3D0x3e;
     bootsector->jump[2]=3D0x90;
-    memcpy(bootsector->name,"QEMU    ",8);
+    memcpy(bootsector->name, "MSWIN4.1", 8);
     bootsector->sector_size=3Dcpu_to_le16(0x200);
     bootsector->sectors_per_cluster=3Ds->sectors_per_cluster;
     bootsector->reserved_sectors=3Dcpu_to_le16(1);
--=20
1.8.3.1

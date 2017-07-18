Received: from eggs.gnu.org ([2001:4830:134:3::10]:53416)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dXTKh-0000os-U7
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 10:18:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dXTKg-0007ni-OC
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 10:18:39 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Tue, 18 Jul 2017 16:18:01 +0200
Message-Id: <1500387486-5469-17-git-send-email-kwolf@redhat.com>
In-Reply-To: <1500387486-5469-1-git-send-email-kwolf@redhat.com>
References: <1500387486-5469-1-git-send-email-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 16/21] vvfat: add a constant for bootsector name
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, peter.maydell@linaro.org, qemu-devel@nongnu.org

From: Herv=C3=A9 Poussineau <hpoussin@reactos.org>

Also add links to related compatibility problems.

Signed-off-by: Herv=C3=A9 Poussineau <hpoussin@reactos.org>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/vvfat.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/block/vvfat.c b/block/vvfat.c
index eb266b5..36b4be9 100644
--- a/block/vvfat.c
+++ b/block/vvfat.c
@@ -71,6 +71,12 @@ void nonono(const char* file, int line, const char* ms=
g) {
=20
 #endif
=20
+/* bootsector OEM name. see related compatibility problems at:
+ * https://jdebp.eu/FGA/volume-boot-block-oem-name-field.html
+ * http://seasip.info/Misc/oemid.html
+ */
+#define BOOTSECTOR_OEM_NAME "MSWIN4.1"
+
 #define DIR_DELETED 0xe5
 #define DIR_KANJI DIR_DELETED
 #define DIR_KANJI_FAKE 0x05
@@ -1028,7 +1034,7 @@ static int init_directories(BDRVVVFATState* s,
     bootsector->jump[0]=3D0xeb;
     bootsector->jump[1]=3D0x3e;
     bootsector->jump[2]=3D0x90;
-    memcpy(bootsector->name, "MSWIN4.1", 8);
+    memcpy(bootsector->name, BOOTSECTOR_OEM_NAME, 8);
     bootsector->sector_size=3Dcpu_to_le16(0x200);
     bootsector->sectors_per_cluster=3Ds->sectors_per_cluster;
     bootsector->reserved_sectors=3Dcpu_to_le16(1);
--=20
1.8.3.1

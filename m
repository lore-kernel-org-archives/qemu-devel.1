Received: from eggs.gnu.org ([2001:4830:134:3::10]:43457)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cvV0r-0001zv-Dp
	for qemu-devel@nongnu.org; Tue, 04 Apr 2017 16:25:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cvV0q-00031w-JF
	for qemu-devel@nongnu.org; Tue, 04 Apr 2017 16:25:13 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Tue,  4 Apr 2017 17:24:14 -0300
Message-Id: <20170404202429.14643-7-ehabkost@redhat.com>
In-Reply-To: <20170404202429.14643-1-ehabkost@redhat.com>
References: <20170404202429.14643-1-ehabkost@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 06/21] pflash_cfi01: Remove user_creatable
 flag
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Laszlo Ersek <lersek@redhat.com>, Thomas Huth <thuth@redhat.com>, Alexander Graf <agraf@suse.de>, Peter Maydell <peter.maydell@linaro.org>, Marcel Apfelbaum <marcel@redhat.com>, Markus Armbruster <armbru@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org

TYPE_CFI_PFLASH01 devices need to be mapped by
pflash_cfi01_register() (or equivalent) and can't be used with
-device. Remove user_creatable from the device class.

Cc: Kevin Wolf <kwolf@redhat.com>
Cc: Max Reitz <mreitz@redhat.com>
Cc: qemu-block@nongnu.org
Cc: Laszlo Ersek <lersek@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Reviewed-by: Laszlo Ersek <lersek@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
Changes v1 -> v2:
* Commit message rewrite only
---
 hw/block/pflash_cfi01.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/hw/block/pflash_cfi01.c b/hw/block/pflash_cfi01.c
index ef71956433..594d4cf6fe 100644
--- a/hw/block/pflash_cfi01.c
+++ b/hw/block/pflash_cfi01.c
@@ -927,11 +927,6 @@ static void pflash_cfi01_class_init(ObjectClass *kla=
ss, void *data)
     dc->props =3D pflash_cfi01_properties;
     dc->vmsd =3D &vmstate_pflash;
     set_bit(DEVICE_CATEGORY_STORAGE, dc->categories);
-    /*
-     * FIXME: Set only because we are not sure yet if this device
-     * will be outside the q35 sysbus whitelist.
-     */
-    dc->user_creatable =3D true;
 }
=20
=20
--=20
2.11.0.259.g40922b1

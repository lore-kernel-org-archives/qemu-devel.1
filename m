Received: from eggs.gnu.org ([2001:4830:134:3::10]:54667)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1d611Q-0002xd-AZ
	for qemu-devel@nongnu.org; Wed, 03 May 2017 16:37:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1d611P-0002mw-FE
	for qemu-devel@nongnu.org; Wed, 03 May 2017 16:37:16 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37378)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1d611P-0002mG-9N
	for qemu-devel@nongnu.org; Wed, 03 May 2017 16:37:15 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Wed,  3 May 2017 17:35:56 -0300
Message-Id: <20170503203604.31462-14-ehabkost@redhat.com>
In-Reply-To: <20170503203604.31462-1-ehabkost@redhat.com>
References: <20170503203604.31462-1-ehabkost@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH RESEND v2 13/21] unimplemented-device: Remove
 user_creatable flag
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Laszlo Ersek <lersek@redhat.com>, Thomas Huth <thuth@redhat.com>, Alexander Graf <agraf@suse.de>, Markus Armbruster <armbru@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>

unimplemented-device needs to be created and mapped using
create_unimplemented_device() (or equivalent code), and won't
work with -device. Remove the user_creatable flag from the device
class.

Cc: Marcel Apfelbaum <marcel@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>
Cc: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Acked-by: Marcel Apfelbaum <marcel@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
Changes v1 -> v2:
* Commit message rewrite only
---
 hw/misc/unimp.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/hw/misc/unimp.c b/hw/misc/unimp.c
index e446c1d652..bcbb585888 100644
--- a/hw/misc/unimp.c
+++ b/hw/misc/unimp.c
@@ -90,11 +90,6 @@ static void unimp_class_init(ObjectClass *klass, void =
*data)
=20
     dc->realize =3D unimp_realize;
     dc->props =3D unimp_properties;
-    /*
-     * FIXME: Set only because we are not sure yet if this device
-     * will be outside the q35 sysbus whitelist.
-     */
-    dc->user_creatable =3D true;
 }
=20
 static const TypeInfo unimp_info =3D {
--=20
2.11.0.259.g40922b1

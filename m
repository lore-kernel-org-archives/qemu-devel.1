Received: from eggs.gnu.org ([2001:4830:134:3::10]:59006)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1eF2HG-0003qh-Mh
	for qemu-devel@nongnu.org; Wed, 15 Nov 2017 13:19:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1eF2HG-0003dR-0b
	for qemu-devel@nongnu.org; Wed, 15 Nov 2017 13:19:10 -0500
Received: from mx1.redhat.com ([209.132.183.28]:50579)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1eF2HF-0003c7-Q4
	for qemu-devel@nongnu.org; Wed, 15 Nov 2017 13:19:09 -0500
Date: Wed, 15 Nov 2017 20:19:02 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <1510769835-31902-10-git-send-email-mst@redhat.com>
References: <1510769835-31902-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1510769835-31902-1-git-send-email-mst@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 09/10] vmcoreinfo: put it in the 'misc' device
 category
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>

From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/misc/vmcoreinfo.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/misc/vmcoreinfo.c b/hw/misc/vmcoreinfo.c
index a618e12..31db57a 100644
--- a/hw/misc/vmcoreinfo.c
+++ b/hw/misc/vmcoreinfo.c
@@ -79,6 +79,7 @@ static void vmcoreinfo_device_class_init(ObjectClass *k=
lass, void *data)
     dc->vmsd =3D &vmstate_vmcoreinfo;
     dc->realize =3D vmcoreinfo_realize;
     dc->hotpluggable =3D false;
+    set_bit(DEVICE_CATEGORY_MISC, dc->categories);
 }
=20
 static const TypeInfo vmcoreinfo_device_info =3D {
--=20
MST

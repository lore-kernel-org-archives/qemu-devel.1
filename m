Received: from eggs.gnu.org ([209.51.188.92]:37796)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1ggthd-0003rm-47
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 10:54:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1ggthc-0006a2-9z
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 10:54:05 -0500
Received: from mx1.redhat.com ([209.132.183.28]:60154)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1ggtha-0006SM-B7
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 10:54:04 -0500
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Tue,  8 Jan 2019 16:53:52 +0100
Message-Id: <20190108155354.8591-4-kraxel@redhat.com>
In-Reply-To: <20190108155354.8591-1-kraxel@redhat.com>
References: <20190108155354.8591-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 3/5] usb: dev-mtp: fix memory leak in error path
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Richard Henderson <rth@twiddle.net>, "Michael S. Tsirkin" <mst@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Li Qiang <liq3ea@163.com>

From: Li Qiang <liq3ea@163.com>

Spotted by Coverity: CID 1397074

Fixes: c52d46e041b
Signed-off-by: Li Qiang <liq3ea@163.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Message-id: 20190103132605.49476-1-liq3ea@163.com
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 hw/usb/dev-mtp.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/usb/dev-mtp.c b/hw/usb/dev-mtp.c
index 6098005cd4..b19b576278 100644
--- a/hw/usb/dev-mtp.c
+++ b/hw/usb/dev-mtp.c
@@ -1729,6 +1729,7 @@ static void usb_mtp_write_metadata(MTPState *s, uin=
t64_t dlen)
     if (strchr(filename, '/')) {
         usb_mtp_queue_result(s, RES_PARAMETER_NOT_SUPPORTED, d->trans,
                              0, 0, 0, 0);
+        g_free(filename);
         return;
     }
=20
--=20
2.9.3

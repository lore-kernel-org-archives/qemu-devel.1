Received: from eggs.gnu.org ([2001:4830:134:3::10]:41044)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gWmLp-0005BY-Er
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 13:01:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gWmLl-0004Wg-Ap
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 13:01:44 -0500
Received: from mx1.redhat.com ([209.132.183.28]:36558)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1gWmLj-0004Ss-AR
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 13:01:40 -0500
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Tue, 11 Dec 2018 16:01:07 -0200
Message-Id: <20181211180129.7661-3-ehabkost@redhat.com>
In-Reply-To: <20181211180129.7661-1-ehabkost@redhat.com>
References: <20181211180129.7661-1-ehabkost@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 02/24] hw/timer/sun4v-rtc: Fix tracing at
 sun4v_rtc_write()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>

The code was converted to use sun4v_rtc_read() by mistake, fix
it.

Reported-by: David Gibson <david@gibson.dropbear.id.au>
Cc: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
Message-Id: <20181031001843.12892-1-ehabkost@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 hw/timer/sun4v-rtc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/timer/sun4v-rtc.c b/hw/timer/sun4v-rtc.c
index 4e7f6a1eff..b93cbd6a81 100644
--- a/hw/timer/sun4v-rtc.c
+++ b/hw/timer/sun4v-rtc.c
@@ -41,7 +41,7 @@ static uint64_t sun4v_rtc_read(void *opaque, hwaddr add=
r,
 static void sun4v_rtc_write(void *opaque, hwaddr addr,
                              uint64_t val, unsigned size)
 {
-    trace_sun4v_rtc_read(addr, val);
+    trace_sun4v_rtc_write(addr, val);
 }
=20
 static const MemoryRegionOps sun4v_rtc_ops =3D {
--=20
2.18.0.rc1.1.g3f1ff2140

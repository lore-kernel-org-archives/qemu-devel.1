Received: from eggs.gnu.org ([2001:4830:134:3::10]:42215)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cT7an-0004r9-6W
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 08:45:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cT7al-0005GJ-Q6
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 08:45:01 -0500
Received: from mx1.redhat.com ([209.132.183.28]:42070)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1cT7al-0005G0-K2
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 08:44:59 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Mon, 16 Jan 2017 13:44:52 +0000
Message-Id: <20170116134455.28636-2-stefanha@redhat.com>
In-Reply-To: <20170116134455.28636-1-stefanha@redhat.com>
References: <20170116134455.28636-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 1/4] trace-events: spelling fix
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Message-id: 20161212221759.28949-1-marcandre.lureau@redhat.com
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 trace-events | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/trace-events b/trace-events
index 1181486..2c66780 100644
--- a/trace-events
+++ b/trace-events
@@ -53,7 +53,7 @@ qemu_system_shutdown_request(void) ""
 qemu_system_powerdown_request(void) ""
=20
 # spice-qemu-char.c
-spice_vmc_write(ssize_t out, int len) "spice wrottn %zd of requested %d"
+spice_vmc_write(ssize_t out, int len) "spice wrote %zd of requested %d"
 spice_vmc_read(int bytes, int len) "spice read %d of requested %d"
 spice_vmc_register_interface(void *scd) "spice vmc registered interface =
%p"
 spice_vmc_unregister_interface(void *scd) "spice vmc unregistered interf=
ace %p"
--=20
2.9.3

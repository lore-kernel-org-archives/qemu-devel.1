Received: from eggs.gnu.org ([2001:4830:134:3::10]:35924)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <anton.nefedov@virtuozzo.com>) id 1dT5bo-0005dz-0q
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 08:10:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <anton.nefedov@virtuozzo.com>) id 1dT5bj-0004mV-R8
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 08:10:11 -0400
Received: from mail-ve1eur01on0138.outbound.protection.outlook.com
	([104.47.1.138]:27920
	helo=EUR01-VE1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <anton.nefedov@virtuozzo.com>)
	id 1dT5bj-0004kE-Ft
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 08:10:07 -0400
From: Anton Nefedov <anton.nefedov@virtuozzo.com>
Date: Thu,  6 Jul 2017 15:08:53 +0300
Message-ID: <1499342940-56739-7-git-send-email-anton.nefedov@virtuozzo.com>
In-Reply-To: <1499342940-56739-1-git-send-email-anton.nefedov@virtuozzo.com>
References: <1499342940-56739-1-git-send-email-anton.nefedov@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v6 06/13] test-char: destroy chardev-udp after
 test
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: den@virtuozzo.com, pbonzini@redhat.com, marcandre.lureau@redhat.com, amit@kernel.org, mst@redhat.com, Anton Nefedov <anton.nefedov@virtuozzo.com>

this is only not a problem if the test is last in a suite,
otherwise it makes the following main_loop() calls to fail

Signed-off-by: Anton Nefedov <anton.nefedov@virtuozzo.com>
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 tests/test-char.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tests/test-char.c b/tests/test-char.c
index 527b785..6add1aa 100644
--- a/tests/test-char.c
+++ b/tests/test-char.c
@@ -454,6 +454,7 @@ static void char_udp_test(void)
=20
     close(sock);
     g_free(tmp);
+    qemu_chr_fe_deinit(&be, true);
 }
=20
 #ifdef HAVE_CHARDEV_SERIAL
--=20
2.7.4

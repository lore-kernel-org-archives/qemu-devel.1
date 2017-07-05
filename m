Received: from eggs.gnu.org ([2001:4830:134:3::10]:44803)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <anton.nefedov@virtuozzo.com>) id 1dSkt2-0004lB-C8
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 10:02:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <anton.nefedov@virtuozzo.com>) id 1dSksw-0007lz-Kr
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 10:02:36 -0400
Received: from mail-eopbgr40118.outbound.protection.outlook.com
	([40.107.4.118]:22336
	helo=EUR03-DB5-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <anton.nefedov@virtuozzo.com>)
	id 1dSksw-0007l7-7r
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 10:02:30 -0400
From: Anton Nefedov <anton.nefedov@virtuozzo.com>
Date: Wed,  5 Jul 2017 17:01:57 +0300
Message-ID: <1499263324-15184-7-git-send-email-anton.nefedov@virtuozzo.com>
In-Reply-To: <1499263324-15184-1-git-send-email-anton.nefedov@virtuozzo.com>
References: <1499263324-15184-1-git-send-email-anton.nefedov@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v5 06/13] test-char: destroy chardev-udp after
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

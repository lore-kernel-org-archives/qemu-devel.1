Received: from eggs.gnu.org ([2001:4830:134:3::10]:33014)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gAlDw-0005Rr-LF
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 20:22:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gAlDu-0004vK-GI
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 20:22:36 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48124)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gAlDu-0004uv-9w
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 20:22:34 -0400
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Date: Fri, 12 Oct 2018 02:22:08 +0200
Message-Id: <20181012002217.2864-3-philmd@redhat.com>
In-Reply-To: <20181012002217.2864-1-philmd@redhat.com>
References: <20181012002217.2864-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 02/11] target/xtensa: Remove unnecessary
 declarations
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, Prasad J Pandit <ppandit@redhat.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>, qemu-devel@nongnu.org, Max Filippov <jcmvbkbc@gmail.com>

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 target/xtensa/xtensa-semi.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/target/xtensa/xtensa-semi.c b/target/xtensa/xtensa-semi.c
index 2f76216276..e389069f0b 100644
--- a/target/xtensa/xtensa-semi.c
+++ b/target/xtensa/xtensa-semi.c
@@ -161,7 +161,6 @@ typedef struct XtensaSimConsole {
=20
 static XtensaSimConsole *sim_console;
=20
-static IOCanReadHandler sim_console_can_read;
 static int sim_console_can_read(void *opaque)
 {
     XtensaSimConsole *p =3D opaque;
@@ -169,7 +168,6 @@ static int sim_console_can_read(void *opaque)
     return sizeof(p->input.buffer) - p->input.offset;
 }
=20
-static IOReadHandler sim_console_read;
 static void sim_console_read(void *opaque, const uint8_t *buf, int size)
 {
     XtensaSimConsole *p =3D opaque;
--=20
2.17.1

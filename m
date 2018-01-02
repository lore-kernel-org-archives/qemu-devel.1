Received: from eggs.gnu.org ([2001:4830:134:3::10]:49144)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1eWND9-0007Gs-Uk
	for qemu-devel@nongnu.org; Tue, 02 Jan 2018 09:06:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1eWND6-0008Di-P2
	for qemu-devel@nongnu.org; Tue, 02 Jan 2018 09:06:35 -0500
Received: from mx1.redhat.com ([209.132.183.28]:51224)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1eWND6-0008Co-Jg
	for qemu-devel@nongnu.org; Tue, 02 Jan 2018 09:06:32 -0500
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Tue,  2 Jan 2018 15:06:24 +0100
Message-Id: <20180102140625.14477-2-marcandre.lureau@redhat.com>
In-Reply-To: <20180102140625.14477-1-marcandre.lureau@redhat.com>
References: <20180102140625.14477-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 1/2] dump: fix note_name_equal()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

Use the function argument "name" instead of hardcoded
"VMCOREINFO". All callers use "VMCOREINFO" as argument, so this isn't
an exposed bug, thankfully.

Simplify a little bit the code while touching this.

Suggested-by: Andrew Jones <drjones@redhat.com>
Reported-by: Laszlo Ersek <lersek@redhat.com>
Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 dump.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/dump.c b/dump.c
index d4a8c942eb..e9dfed060a 100644
--- a/dump.c
+++ b/dump.c
@@ -788,12 +788,7 @@ static bool note_name_equal(DumpState *s,
     get_note_sizes(s, note, &head_size, &name_size, NULL);
     head_size =3D ROUND_UP(head_size, 4);
=20
-    if (name_size !=3D len ||
-        memcmp(note + head_size, "VMCOREINFO", len)) {
-        return false;
-    }
-
-    return true;
+    return name_size =3D=3D len && memcmp(note + head_size, name, len) =3D=
=3D 0;
 }
=20
 /* write common header, sub header and elf note to vmcore */
--=20
2.15.1.355.g36791d7216

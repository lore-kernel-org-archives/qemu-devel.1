Received: from eggs.gnu.org ([209.51.188.92]:35152)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1gjB7F-0004l4-Tm
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 17:53:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1gjB7E-0001e3-1V
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 17:53:57 -0500
Received: from hera.aquilenet.fr ([2a0c:e300::1]:37518)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <samuel.thibault@ens-lyon.org>)
	id 1gjB7A-0001VE-6d
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 17:53:53 -0500
From: Samuel Thibault <samuel.thibault@ens-lyon.org>
Date: Mon, 14 Jan 2019 23:52:46 +0100
Message-Id: <20190114225306.21569-46-samuel.thibault@ens-lyon.org>
In-Reply-To: <20190114225306.21569-1-samuel.thibault@ens-lyon.org>
References: <20190114225306.21569-1-samuel.thibault@ens-lyon.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 45/65] slirp: replace error_report() with
 g_critical()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, stefanha@redhat.com, jan.kiszka@siemens.com, Samuel Thibault <samuel.thibault@ens-lyon.org>

From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

Reduce dependency on QEMU. QEMU could use a custom log handler if it
wants to redirect/filter it.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Samuel Thibault <samuel.thibault@ens-lyon.org>
---
 slirp/misc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/slirp/misc.c b/slirp/misc.c
index 753b3da25b..b141446319 100644
--- a/slirp/misc.c
+++ b/slirp/misc.c
@@ -162,7 +162,7 @@ fork_exec(struct socket *so, const char *ex)
     g_strfreev(argv);
=20
     if (err) {
-        error_report("%s", err->message);
+        g_critical("fork_exec: %s", err->message);
         g_error_free(err);
         closesocket(sp[0]);
         closesocket(sp[1]);
--=20
2.20.1

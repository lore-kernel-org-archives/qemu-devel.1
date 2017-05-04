Received: from eggs.gnu.org ([2001:4830:134:3::10]:45970)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1d6FAJ-0003Fa-3t
	for qemu-devel@nongnu.org; Thu, 04 May 2017 07:43:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1d6FAI-0004Ql-CX
	for qemu-devel@nongnu.org; Thu, 04 May 2017 07:43:23 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40302)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1d6FAI-0004QP-66
	for qemu-devel@nongnu.org; Thu, 04 May 2017 07:43:22 -0400
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Thu,  4 May 2017 15:42:17 +0400
Message-Id: <20170504114232.20318-7-marcandre.lureau@redhat.com>
In-Reply-To: <20170504114232.20318-1-marcandre.lureau@redhat.com>
References: <20170504114232.20318-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 06/21] vl: add todo note about root container
 cleanup
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: stefanha@gmail.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 vl.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/vl.c b/vl.c
index f46e070e0d..150e8ebf17 100644
--- a/vl.c
+++ b/vl.c
@@ -4727,6 +4727,7 @@ int main(int argc, char **argv, char **envp)
     audio_cleanup();
     monitor_cleanup();
     qemu_chr_cleanup();
+    /* TODO: unref root container, check all devices are ok */
=20
     return 0;
 }
--=20
2.12.0.191.gc5d8de91d

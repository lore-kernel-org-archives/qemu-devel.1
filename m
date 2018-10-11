Received: from eggs.gnu.org ([2001:4830:134:3::10]:36603)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gAeWY-0002Yi-HK
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 13:13:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gAeWT-0005wO-F2
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 13:13:22 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52574)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gAeWT-0005vy-9Q
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 13:13:17 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 80522308338F
	for <qemu-devel@nongnu.org>; Thu, 11 Oct 2018 17:13:16 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Date: Thu, 11 Oct 2018 19:12:54 +0200
Message-Id: <20181011171254.32428-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH] vl: Print error when using incorrect backend
 for debugcon
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>, qemu-devel@nongnu.org

When using an incorrect backend for the debugcon, QEMU exits silently
without any error indication, which is confusing.
Add a message that the character backend is invalid.

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 vl.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/vl.c b/vl.c
index 4e25c78bff..61305b5891 100644
--- a/vl.c
+++ b/vl.c
@@ -2466,6 +2466,7 @@ static int debugcon_parse(const char *devname)
     QemuOpts *opts;
=20
     if (!qemu_chr_new_mux_mon("debugcon", devname)) {
+        error_report("invalid character backend '%s'", devname);
         exit(1);
     }
     opts =3D qemu_opts_create(qemu_find_opts("device"), "debugcon", 1, N=
ULL);
--=20
2.17.1

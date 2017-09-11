Received: from eggs.gnu.org ([2001:4830:134:3::10]:57931)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1drS4Q-0006YF-GF
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 13:00:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1drS4P-0007Lu-Su
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 13:00:26 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59366)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1drS4P-0007LT-MY
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 13:00:25 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id AFB3B1FE303
	for <qemu-devel@nongnu.org>; Mon, 11 Sep 2017 17:00:24 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Mon, 11 Sep 2017 18:59:29 +0200
Message-Id: <20170911165929.2791-8-marcandre.lureau@redhat.com>
In-Reply-To: <20170911165929.2791-1-marcandre.lureau@redhat.com>
References: <20170911165929.2791-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v6 7/7] MAINTAINERS: add Dump maintainers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: imammedo@redhat.com, berrange@redhat.com, ehabkost@redhat.com, mst@redhat.com, anderson@redhat.com, lersek@redhat.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

Proposing myself, since I have some familiarity with the code now.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Acked-by: Laszlo Ersek <lersek@redhat.com>
---
 MAINTAINERS | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 36eeb42d19..6e47428b33 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1288,6 +1288,17 @@ S: Maintained
 F: device_tree.c
 F: include/sysemu/device_tree.h
=20
+Dump
+S: Supported
+M: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
+F: dump.c
+F: hw/misc/vmcoreinfo.c
+F: include/hw/misc/vmcoreinfo.h
+F: include/sysemu/dump-arch.h
+F: include/sysemu/dump.h
+F: scripts/dump-guest-memory.py
+F: stubs/dump.c
+
 Error reporting
 M: Markus Armbruster <armbru@redhat.com>
 S: Supported
--=20
2.14.1.146.gd35faa819

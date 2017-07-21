Received: from eggs.gnu.org ([2001:4830:134:3::10]:47173)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dYYKX-0005vU-RV
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 09:50:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dYYKX-0002Vu-3q
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 09:50:57 -0400
From: Eric Blake <eblake@redhat.com>
Date: Fri, 21 Jul 2017 08:50:46 -0500
Message-Id: <20170721135047.25005-2-eblake@redhat.com>
In-Reply-To: <20170721135047.25005-1-eblake@redhat.com>
References: <20170721135047.25005-1-eblake@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 1/2] qemu-nbd: Update version string
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, "open list:Network Block Dev..." <qemu-block@nongnu.org>

qemu-io and qemu-img already mirror the qemu version string,
time to make qemu-nbd do the same.

Reported-by: =E9=99=B3=E5=9F=B9=E6=B3=93 <pahome.chen@mirlab.org>
Signed-off-by: Eric Blake <eblake@redhat.com>
---
 qemu-nbd.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/qemu-nbd.c b/qemu-nbd.c
index 78d05bea2d..1086934a95 100644
--- a/qemu-nbd.c
+++ b/qemu-nbd.c
@@ -36,6 +36,7 @@
 #include "io/channel-socket.h"
 #include "crypto/init.h"
 #include "trace/control.h"
+#include "qemu-version.h"

 #include <getopt.h>
 #include <libgen.h>
@@ -129,10 +130,10 @@ static void usage(const char *name)
 static void version(const char *name)
 {
     printf(
-"%s version 0.0.1\n"
+"%s " QEMU_VERSION QEMU_PKGVERSION "\n"
 "Written by Anthony Liguori.\n"
 "\n"
-"Copyright (C) 2006 Anthony Liguori <anthony@codemonkey.ws>.\n"
+QEMU_COPYRIGHT "\n"
 "This is free software; see the source for copying conditions.  There is=
 NO\n"
 "warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURP=
OSE.\n"
     , name);
--=20
2.13.3

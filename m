Received: from eggs.gnu.org ([2001:4830:134:3::10]:40172)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1e6dYm-0000wW-Hr
	for qemu-devel@nongnu.org; Mon, 23 Oct 2017 10:18:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1e6dYj-0000Sr-77
	for qemu-devel@nongnu.org; Mon, 23 Oct 2017 10:18:32 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50950)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1e6dYj-0000SW-0n
	for qemu-devel@nongnu.org; Mon, 23 Oct 2017 10:18:29 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 22D03356CB
	for <qemu-devel@nongnu.org>; Mon, 23 Oct 2017 14:18:28 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Mon, 23 Oct 2017 15:18:08 +0100
Message-Id: <20171023141815.17709-3-marcandre.lureau@redhat.com>
In-Reply-To: <20171023141815.17709-1-marcandre.lureau@redhat.com>
References: <20171023141815.17709-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v6 2/9] memfd: remove needless include
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, berrange@redhat.com, ehabkost@redhat.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
---
 util/memfd.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/util/memfd.c b/util/memfd.c
index e9c1a0e700..b5b7a41347 100644
--- a/util/memfd.c
+++ b/util/memfd.c
@@ -27,8 +27,6 @@
=20
 #include "qemu/osdep.h"
=20
-#include <glib/gprintf.h>
-
 #include "qemu/memfd.h"
=20
 #ifdef CONFIG_MEMFD
--=20
2.15.0.rc0.40.gaefcc5f6f

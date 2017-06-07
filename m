Received: from eggs.gnu.org ([2001:4830:134:3::10]:58668)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dIfMx-0006j5-Es
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 14:07:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dIfMw-00049Z-Fn
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 14:07:47 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34810)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1dIfMw-00047p-9J
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 14:07:46 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Wed,  7 Jun 2017 19:07:32 +0100
Message-Id: <20170607180736.11011-2-stefanha@redhat.com>
In-Reply-To: <20170607180736.11011-1-stefanha@redhat.com>
References: <20170607180736.11011-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL for-2.9 1/5] oslib: strip trailing '\n' from
 error_setg() string argument
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, Stefan Hajnoczi <stefanha@redhat.com>

From: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

spotted by Coccinelle script scripts/coccinelle/err-bad-newline.cocci

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Laurent Vivier <lvivier@redhat.com>
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 util/oslib-posix.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/util/oslib-posix.c b/util/oslib-posix.c
index 7e28c16..9ab2eb2 100644
--- a/util/oslib-posix.c
+++ b/util/oslib-posix.c
@@ -400,7 +400,7 @@ void os_mem_prealloc(int fd, char *area, size_t memor=
y, int smp_cpus,
     /* touch pages simultaneously */
     if (touch_all_pages(area, hpagesize, numpages, smp_cpus)) {
         error_setg(errp, "os_mem_prealloc: Insufficient free host memory=
 "
-            "pages available to allocate guest RAM\n");
+            "pages available to allocate guest RAM");
     }
=20
     ret =3D sigaction(SIGBUS, &oldact, NULL);
--=20
2.9.4

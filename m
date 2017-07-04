Received: from eggs.gnu.org ([2001:4830:134:3::10]:48293)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1dSVvd-0007EC-2Z
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 18:04:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1dSVvc-0008E3-3I
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 18:04:17 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54226)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1dSVvb-0008DS-TG
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 18:04:16 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id D81C581224
	for <qemu-devel@nongnu.org>; Tue,  4 Jul 2017 22:04:14 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Wed,  5 Jul 2017 00:03:14 +0200
Message-Id: <20170704220346.29244-4-marcandre.lureau@redhat.com>
In-Reply-To: <20170704220346.29244-1-marcandre.lureau@redhat.com>
References: <20170704220346.29244-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 03/35] test-coroutine: fix coroutine attribute
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>

  CC      tests/test-coroutine.o
qemu/tests/test-coroutine.c:390:5: warning: calling function 'qemu_corout=
ine_yield' requires holding role '_coroutine_fn' exclusively [-Wthread-sa=
fety-analysis]
    qemu_coroutine_yield();
    ^
qemu/tests/test-coroutine.c:403:14: warning: Unmached attributes [-Wthrea=
d-safety-analysis]
        co =3D qemu_coroutine_create(perf_cost_func, &i);
             ^
2 warnings generated.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 tests/test-coroutine.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/test-coroutine.c b/tests/test-coroutine.c
index abd97c23c1..f14277af83 100644
--- a/tests/test-coroutine.c
+++ b/tests/test-coroutine.c
@@ -385,7 +385,7 @@ static void perf_baseline(void)
         maxcycles, duration);
 }
=20
-static __attribute__((noinline)) void perf_cost_func(void *opaque)
+static __attribute__((noinline)) void coroutine_fn perf_cost_func(void *=
opaque)
 {
     qemu_coroutine_yield();
 }
--=20
2.13.1.395.gf7b71de06

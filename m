Received: from eggs.gnu.org ([2001:4830:134:3::10]:48355)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1dSVvq-0007Oo-Sl
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 18:04:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1dSVvq-0008Kc-0P
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 18:04:30 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37602)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1dSVvp-0008KF-Q5
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 18:04:29 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id D08F980F94
	for <qemu-devel@nongnu.org>; Tue,  4 Jul 2017 22:04:28 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Wed,  5 Jul 2017 00:03:16 +0200
Message-Id: <20170704220346.29244-6-marcandre.lureau@redhat.com>
In-Reply-To: <20170704220346.29244-1-marcandre.lureau@redhat.com>
References: <20170704220346.29244-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 05/35] coroutine: remove coroutine_fn from
 qemu_co_queue_run_restart()
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

The function can be invoked from non-coroutine context.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 include/qemu/coroutine_int.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/qemu/coroutine_int.h b/include/qemu/coroutine_int.h
index cb98892bba..e9fc72c5b0 100644
--- a/include/qemu/coroutine_int.h
+++ b/include/qemu/coroutine_int.h
@@ -61,6 +61,6 @@ Coroutine *qemu_coroutine_new(void);
 void qemu_coroutine_delete(Coroutine *co);
 CoroutineAction qemu_coroutine_switch(Coroutine *from, Coroutine *to,
                                       CoroutineAction action);
-void coroutine_fn qemu_co_queue_run_restart(Coroutine *co);
+void qemu_co_queue_run_restart(Coroutine *co);
=20
 #endif
--=20
2.13.1.395.gf7b71de06

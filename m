Received: from eggs.gnu.org ([2001:4830:134:3::10]:36365)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eleTj-0002Jd-2z
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 12:34:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eleTi-0003G2-9d
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 12:34:51 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:52364 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1eleTi-0003Fo-5R
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 12:34:50 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Tue, 13 Feb 2018 17:34:29 +0000
Message-Id: <20180213173429.19501-6-stefanha@redhat.com>
In-Reply-To: <20180213173429.19501-1-stefanha@redhat.com>
References: <20180213173429.19501-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 5/5] misc: fix spelling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Kevin Wolf <kwolf@redhat.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

s/pupulate/populate

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 20180208162447.10851-1-marcandre.lureau@redhat.com
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 util/qemu-coroutine-lock.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/util/qemu-coroutine-lock.c b/util/qemu-coroutine-lock.c
index 78fb79acf8..5a80c10690 100644
--- a/util/qemu-coroutine-lock.c
+++ b/util/qemu-coroutine-lock.c
@@ -89,7 +89,7 @@ void qemu_co_queue_run_restart(Coroutine *co)
      * invalid memory.  Therefore, use a temporary queue and do not touc=
h
      * the "co" coroutine as soon as you enter another one.
      *
-     * In its turn resumed "co" can pupulate "co_queue_wakeup" queue wit=
h
+     * In its turn resumed "co" can populate "co_queue_wakeup" queue wit=
h
      * new coroutines to be woken up.  The caller, who has resumed "co",
      * will be responsible for traversing the same queue, which may caus=
e
      * a different wakeup order but not any missing wakeups.
--=20
2.14.3

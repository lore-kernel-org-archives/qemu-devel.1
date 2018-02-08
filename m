Received: from eggs.gnu.org ([2001:4830:134:3::10]:35878)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1ejp0K-0007h5-O4
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 11:24:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1ejp0J-0005qb-UV
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 11:24:56 -0500
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Thu,  8 Feb 2018 17:24:47 +0100
Message-Id: <20180208162447.10851-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH] misc: fix spelling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>

s/pupulate/populate

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 util/qemu-coroutine-lock.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/util/qemu-coroutine-lock.c b/util/qemu-coroutine-lock.c
index 846ff9167f..3d0152ebec 100644
--- a/util/qemu-coroutine-lock.c
+++ b/util/qemu-coroutine-lock.c
@@ -87,7 +87,7 @@ void qemu_co_queue_run_restart(Coroutine *co)
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
2.16.1.73.g5832b7e9f2

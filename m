Received: from eggs.gnu.org ([2001:4830:134:3::10]:48383)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1dSVvx-0007Tf-TH
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 18:04:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1dSVvw-0008O5-NT
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 18:04:37 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54440)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1dSVvw-0008Ne-Dt
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 18:04:36 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 6800E8125F
	for <qemu-devel@nongnu.org>; Tue,  4 Jul 2017 22:04:35 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Wed,  5 Jul 2017 00:03:17 +0200
Message-Id: <20170704220346.29244-7-marcandre.lureau@redhat.com>
In-Reply-To: <20170704220346.29244-1-marcandre.lureau@redhat.com>
References: <20170704220346.29244-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 06/35] coroutine: mark CoRwLock coroutine_fn
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

  CC      util/qemu-coroutine-lock.o
/home/elmarco/src/qemu/util/qemu-coroutine-lock.c:371:5: warning: calling=
 function 'qemu_co_mutex_lock' requires holding role '_coroutine_fn' excl=
usively [-Wthread-safety-analysis]
    qemu_co_mutex_lock(&lock->mutex);
    ^
/home/elmarco/src/qemu/util/qemu-coroutine-lock.c:371:5: warning: calling=
 function 'qemu_co_mutex_lock' requires holding role '_coroutine_fn' excl=
usively [-Wthread-safety-analysis]
/home/elmarco/src/qemu/util/qemu-coroutine-lock.c:374:9: warning: calling=
 function 'qemu_co_queue_wait' requires holding role '_coroutine_fn' excl=
usively [-Wthread-safety-analysis]
        qemu_co_queue_wait(&lock->queue, &lock->mutex);
        ^
/home/elmarco/src/qemu/util/qemu-coroutine-lock.c:374:9: warning: calling=
 function 'qemu_co_queue_wait' requires holding role '_coroutine_fn' excl=
usively [-Wthread-safety-analysis]
/home/elmarco/src/qemu/util/qemu-coroutine-lock.c:377:5: warning: calling=
 function 'qemu_co_mutex_unlock' requires holding role '_coroutine_fn' ex=
clusively [-Wthread-safety-analysis]
    qemu_co_mutex_unlock(&lock->mutex);
    ^
/home/elmarco/src/qemu/util/qemu-coroutine-lock.c:377:5: warning: calling=
 function 'qemu_co_mutex_unlock' requires holding role '_coroutine_fn' ex=
clusively [-Wthread-safety-analysis]
/home/elmarco/src/qemu/util/qemu-coroutine-lock.c:390:9: warning: calling=
 function 'qemu_co_queue_restart_all' requires holding role '_coroutine_f=
n' exclusively [-Wthread-safety-analysis]
        qemu_co_queue_restart_all(&lock->queue);
        ^
/home/elmarco/src/qemu/util/qemu-coroutine-lock.c:390:9: warning: calling=
 function 'qemu_co_queue_restart_all' requires holding role '_coroutine_f=
n' exclusively [-Wthread-safety-analysis]
/home/elmarco/src/qemu/util/qemu-coroutine-lock.c:394:9: warning: calling=
 function 'qemu_co_mutex_lock' requires holding role '_coroutine_fn' excl=
usively [-Wthread-safety-analysis]
        qemu_co_mutex_lock(&lock->mutex);
        ^
/home/elmarco/src/qemu/util/qemu-coroutine-lock.c:394:9: warning: calling=
 function 'qemu_co_mutex_lock' requires holding role '_coroutine_fn' excl=
usively [-Wthread-safety-analysis]
/home/elmarco/src/qemu/util/qemu-coroutine-lock.c:399:13: warning: callin=
g function 'qemu_co_queue_next' requires holding role '_coroutine_fn' exc=
lusively [-Wthread-safety-analysis]
            qemu_co_queue_next(&lock->queue);
            ^
/home/elmarco/src/qemu/util/qemu-coroutine-lock.c:399:13: warning: callin=
g function 'qemu_co_queue_next' requires holding role '_coroutine_fn' exc=
lusively [-Wthread-safety-analysis]
/home/elmarco/src/qemu/util/qemu-coroutine-lock.c:402:5: warning: calling=
 function 'qemu_co_mutex_unlock' requires holding role '_coroutine_fn' ex=
clusively [-Wthread-safety-analysis]
    qemu_co_mutex_unlock(&lock->mutex);
    ^
/home/elmarco/src/qemu/util/qemu-coroutine-lock.c:402:5: warning: calling=
 function 'qemu_co_mutex_unlock' requires holding role '_coroutine_fn' ex=
clusively [-Wthread-safety-analysis]
/home/elmarco/src/qemu/util/qemu-coroutine-lock.c:407:5: warning: calling=
 function 'qemu_co_mutex_lock' requires holding role '_coroutine_fn' excl=
usively [-Wthread-safety-analysis]
    qemu_co_mutex_lock(&lock->mutex);
    ^
/home/elmarco/src/qemu/util/qemu-coroutine-lock.c:407:5: warning: calling=
 function 'qemu_co_mutex_lock' requires holding role '_coroutine_fn' excl=
usively [-Wthread-safety-analysis]
/home/elmarco/src/qemu/util/qemu-coroutine-lock.c:410:9: warning: calling=
 function 'qemu_co_queue_wait' requires holding role '_coroutine_fn' excl=
usively [-Wthread-safety-analysis]
        qemu_co_queue_wait(&lock->queue, &lock->mutex);
        ^
/home/elmarco/src/qemu/util/qemu-coroutine-lock.c:410:9: warning: calling=
 function 'qemu_co_queue_wait' requires holding role '_coroutine_fn' excl=
usively [-Wthread-safety-analysis]

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 include/qemu/coroutine.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/qemu/coroutine.h b/include/qemu/coroutine.h
index ec55fe295c..5698414c14 100644
--- a/include/qemu/coroutine.h
+++ b/include/qemu/coroutine.h
@@ -255,20 +255,20 @@ void qemu_co_rwlock_init(CoRwlock *lock);
  * of a parallel writer, control is transferred to the caller of the cur=
rent
  * coroutine.
  */
-void qemu_co_rwlock_rdlock(CoRwlock *lock);
+void coroutine_fn qemu_co_rwlock_rdlock(CoRwlock *lock);
=20
 /**
  * Write Locks the mutex. If the lock cannot be taken immediately becaus=
e
  * of a parallel reader, control is transferred to the caller of the cur=
rent
  * coroutine.
  */
-void qemu_co_rwlock_wrlock(CoRwlock *lock);
+void coroutine_fn qemu_co_rwlock_wrlock(CoRwlock *lock);
=20
 /**
  * Unlocks the read/write lock and schedules the next coroutine that was
  * waiting for this lock to be run.
  */
-void qemu_co_rwlock_unlock(CoRwlock *lock);
+void coroutine_fn qemu_co_rwlock_unlock(CoRwlock *lock);
=20
 /**
  * Yield the coroutine for a given duration
--=20
2.13.1.395.gf7b71de06

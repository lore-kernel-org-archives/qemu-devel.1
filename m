Received: from eggs.gnu.org ([209.51.188.92]:39129)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yury-kotov@yandex-team.ru>) id 1hJxyy-0005zg-63
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 06:21:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yury-kotov@yandex-team.ru>) id 1hJxyw-00006q-L7
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 06:21:28 -0400
Received: from forwardcorp1p.mail.yandex.net ([77.88.29.217]:35820)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yury-kotov@yandex-team.ru>) id 1hJxyw-0008Uw-5J
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 06:21:26 -0400
From: Yury Kotov <yury-kotov@yandex-team.ru>
Date: Fri, 26 Apr 2019 13:21:15 +0300
Message-Id: <20190426102115.30002-1-yury-kotov@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH] trace: fix runstate tracing
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org

Signed-off-by: Yury Kotov <yury-kotov@yandex-team.ru>
---
 vl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/vl.c b/vl.c
index ff5dfb6fbc..ad9b181e57 100644
--- a/vl.c
+++ b/vl.c
@@ -725,7 +725,7 @@ void runstate_set(RunState new_state)
     assert(new_state < RUN_STATE__MAX);
=20
     trace_runstate_set(current_run_state, RunState_str(current_run_state=
),
-                       new_state, RunState_str(current_run_state));
+                       new_state, RunState_str(new_state));
=20
     if (current_run_state =3D=3D new_state) {
         return;
--=20
2.21.0

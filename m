Received: from eggs.gnu.org ([209.51.188.92]:48836)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1hL8rp-0001Eq-9p
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 12:10:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1hL8ro-0003w8-CI
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 12:10:57 -0400
Received: from mail-io1-xd2e.google.com ([2607:f8b0:4864:20::d2e]:44660)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1hL8ro-0003vp-7s
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 12:10:56 -0400
Received: by mail-io1-xd2e.google.com with SMTP id r71so9416749iod.11
	for <qemu-devel@nongnu.org>; Mon, 29 Apr 2019 09:10:56 -0700 (PDT)
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Mon, 29 Apr 2019 12:10:46 -0400
Message-Id: <20190429161046.10527-2-stefanha@gmail.com>
In-Reply-To: <20190429161046.10527-1-stefanha@gmail.com>
References: <20190429161046.10527-1-stefanha@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 1/1] trace: fix runstate tracing
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Yury Kotov <yury-kotov@yandex-team.ru>, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, Stefan Hajnoczi <stefanha@gmail.com>

From: Yury Kotov <yury-kotov@yandex-team.ru>

Signed-off-by: Yury Kotov <yury-kotov@yandex-team.ru>
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-id: 20190426102115.30002-1-yury-kotov@yandex-team.ru
Message-Id: <20190426102115.30002-1-yury-kotov@yandex-team.ru>
Signed-off-by: Stefan Hajnoczi <stefanha@gmail.com>
---
 vl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/vl.c b/vl.c
index 4019a4387d..d9fea0a119 100644
--- a/vl.c
+++ b/vl.c
@@ -725,7 +725,7 @@ void runstate_set(RunState new_state)
     assert(new_state < RUN_STATE__MAX);
 
     trace_runstate_set(current_run_state, RunState_str(current_run_state),
-                       new_state, RunState_str(current_run_state));
+                       new_state, RunState_str(new_state));
 
     if (current_run_state == new_state) {
         return;
-- 
2.20.1

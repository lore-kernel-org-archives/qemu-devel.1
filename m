Received: from eggs.gnu.org ([2001:4830:134:3::10]:34172)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1d0qoP-0004Xf-GI
	for qemu-devel@nongnu.org; Wed, 19 Apr 2017 10:42:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1d0qoK-0001Rg-VX
	for qemu-devel@nongnu.org; Wed, 19 Apr 2017 10:42:29 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55618)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1d0qoK-0001Qt-PX
	for qemu-devel@nongnu.org; Wed, 19 Apr 2017 10:42:24 -0400
Received: from int-mx10.intmail.prod.int.phx2.redhat.com
	(int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 27B9F3D97C
	for <qemu-devel@nongnu.org>; Wed, 19 Apr 2017 14:42:23 +0000 (UTC)
Received: from donizetti.redhat.com (ovpn-118-57.ams2.redhat.com
	[10.36.118.57] (may be forged))
	by int-mx10.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP
	id v3JEgK5A001048
	for <qemu-devel@nongnu.org>; Wed, 19 Apr 2017 10:42:22 -0400
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 19 Apr 2017 16:42:09 +0200
Message-Id: <20170419144219.20371-2-pbonzini@redhat.com>
In-Reply-To: <20170419144219.20371-1-pbonzini@redhat.com>
References: <20170419144219.20371-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH 01/11] blockjob: remove unnecessary check
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

!job is always checked prior to the call, drop it from here.

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 blockjob.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/blockjob.c b/blockjob.c
index 6e48932..23022b3 100644
--- a/blockjob.c
+++ b/blockjob.c
@@ -480,7 +480,7 @@ static bool block_job_should_pause(BlockJob *job)
 
 bool block_job_user_paused(BlockJob *job)
 {
-    return job ? job->user_paused : 0;
+    return job->user_paused;
 }
 
 void coroutine_fn block_job_pause_point(BlockJob *job)
-- 
2.9.3

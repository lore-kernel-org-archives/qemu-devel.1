Received: from eggs.gnu.org ([2001:4830:134:3::10]:53807)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cr6hy-0005Og-Np
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 13:39:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cr6hw-0002QQ-2g
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 13:39:34 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60446)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1cr6hv-0002QJ-Sg
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 13:39:32 -0400
Received: from int-mx13.intmail.prod.int.phx2.redhat.com
	(int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id E205442BAF
	for <qemu-devel@nongnu.org>; Thu, 23 Mar 2017 17:39:31 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 23 Mar 2017 18:39:19 +0100
Message-Id: <20170323173928.14439-2-pbonzini@redhat.com>
In-Reply-To: <20170323173928.14439-1-pbonzini@redhat.com>
References: <20170323173928.14439-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH 01/10] blockjob: remove unnecessary check
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: jcody@redhat.com, jsnow@redhat.com

!job is always checked prior to the call, drop it from here.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 blockjob.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/blockjob.c b/blockjob.c
index 9b619f385..a9fb624 100644
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

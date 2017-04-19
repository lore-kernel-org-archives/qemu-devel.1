Received: from eggs.gnu.org ([2001:4830:134:3::10]:34174)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1d0qoP-0004Xj-Gc
	for qemu-devel@nongnu.org; Wed, 19 Apr 2017 10:42:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1d0qoL-0001Rx-DY
	for qemu-devel@nongnu.org; Wed, 19 Apr 2017 10:42:29 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36680)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1d0qoL-0001RY-6z
	for qemu-devel@nongnu.org; Wed, 19 Apr 2017 10:42:25 -0400
Received: from int-mx10.intmail.prod.int.phx2.redhat.com
	(int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 28EB280495
	for <qemu-devel@nongnu.org>; Wed, 19 Apr 2017 14:42:24 +0000 (UTC)
Received: from donizetti.redhat.com (ovpn-118-57.ams2.redhat.com
	[10.36.118.57] (may be forged))
	by int-mx10.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP
	id v3JEgK5B001048
	for <qemu-devel@nongnu.org>; Wed, 19 Apr 2017 10:42:23 -0400
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 19 Apr 2017 16:42:10 +0200
Message-Id: <20170419144219.20371-3-pbonzini@redhat.com>
In-Reply-To: <20170419144219.20371-1-pbonzini@redhat.com>
References: <20170419144219.20371-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 02/11] blockjob: remove iostatus_reset callback
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

This is unused since commit 66a0fae ("blockjob: Don't touch BDS iostatus"=
,
2016-05-19).

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: John Snow <jsnow@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 blockjob.c                   | 3 ---
 include/block/blockjob_int.h | 3 ---
 2 files changed, 6 deletions(-)

diff --git a/blockjob.c b/blockjob.c
index 23022b3..71187d0 100644
--- a/blockjob.c
+++ b/blockjob.c
@@ -555,9 +555,6 @@ bool block_job_is_cancelled(BlockJob *job)
 void block_job_iostatus_reset(BlockJob *job)
 {
     job->iostatus =3D BLOCK_DEVICE_IO_STATUS_OK;
-    if (job->driver->iostatus_reset) {
-        job->driver->iostatus_reset(job);
-    }
 }
=20
 static int block_job_finish_sync(BlockJob *job,
diff --git a/include/block/blockjob_int.h b/include/block/blockjob_int.h
index 3f86cc5..bfcc5d1 100644
--- a/include/block/blockjob_int.h
+++ b/include/block/blockjob_int.h
@@ -44,9 +44,6 @@ struct BlockJobDriver {
     /** Optional callback for job types that support setting a speed lim=
it */
     void (*set_speed)(BlockJob *job, int64_t speed, Error **errp);
=20
-    /** Optional callback for job types that need to forward I/O status =
reset */
-    void (*iostatus_reset)(BlockJob *job);
-
     /** Mandatory: Entrypoint for the Coroutine. */
     CoroutineEntry *start;
=20
--=20
2.9.3
